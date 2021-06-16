Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B98F83A95A2
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 11:12:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232234AbhFPJOH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 05:14:07 -0400
Received: from foss.arm.com ([217.140.110.172]:59628 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231727AbhFPJOH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 05:14:07 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6C56431B;
        Wed, 16 Jun 2021 02:12:01 -0700 (PDT)
Received: from e120937-lin (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C54813F70D;
        Wed, 16 Jun 2021 02:11:57 -0700 (PDT)
Date:   Wed, 16 Jun 2021 10:11:55 +0100
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        virtualization@lists.linux-foundation.org,
        virtio-dev@lists.oasis-open.org, sudeep.holla@arm.com,
        james.quinlan@broadcom.com, f.fainelli@gmail.com,
        etienne.carriere@linaro.org, vincent.guittot@linaro.org,
        souvik.chakravarty@arm.com, igor.skalkin@opensynergy.com,
        peter.hilber@opensynergy.com, alex.bennee@linaro.org,
        jean-philippe@linaro.org, mikhail.golubev@opensynergy.com,
        anton.yakovlev@opensynergy.com, Vasyl.Vavrychuk@opensynergy.com,
        Andriy.Tryshnivskyy@opensynergy.com
Subject: Re: [PATCH v4 04/16] firmware: arm_scmi: Introduce monotonically
 increasing tokens
Message-ID: <20210616091155.GD35368@e120937-lin>
References: <20210611165937.701-1-cristian.marussi@arm.com>
 <20210611165937.701-5-cristian.marussi@arm.com>
 <20210614145301.00002cd9@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210614145301.00002cd9@Huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Jun 14, 2021 at 02:53:01PM +0100, Jonathan Cameron wrote:
> On Fri, 11 Jun 2021 17:59:25 +0100
> Cristian Marussi <cristian.marussi@arm.com> wrote:
> 
> > Tokens are sequence numbers embedded in the each SCMI message header: they
> > are used to correlate commands with responses (and delayed responses), but
> > their usage and policy of selection is entirely up to the caller (usually
> > the OSPM agent), while they are completely opaque to the callee (SCMI
> > server platform) which merely copies them back from the command into the
> > response message header.
> > This also means that the platform does not, can not and should not enforce
> > any kind of policy on received messages depending on the contained sequence
> > number: platform can perfectly handle concurrent requests carrying the same
> > identifiying token if that should happen.
> > 
> > Moreover the platform is not required to produce in-order responses to
> > agent requests, the only constraint in these regards is that in case of
> > an asynchronous message the delayed response must be sent after the
> > immediate response for the synchronous part of the command transaction.
> > 
> > Currenly the SCMI stack of the OSPM agent selects a token for the egressing
> > commands picking the lowest possible number which is not already in use by
> > an existing in-flight transaction, which means, in other words, that we
> > immediately reuse any token after its transaction has completed or it has
> > timed out: this policy indeed does simplify management and lookup of tokens
> > and associated xfers.
> > 
> > Under the above assumptions and constraints, since there is really no state
> > shared between the agent and the platform to let the platform know when a
> > token and its associated message has timed out, the current policy of early
> > reuse of tokens can easily lead to the situation in which a spurious or
> > late received response (or delayed_response), related to an old stale and
> > timed out transaction, can be wrongly associated to a newer valid in-flight
> > xfer that just happens to have reused the same token.
> > 
> > This misbehaviour on such ghost responses is more easily exposed on those
> > transports that naturally have an higher level of parallelism in processing
> > multiple concurrent in-flight messages.
> > 
> > This commit introduces a new policy of selection of tokens for the OSPM
> > agent: each new transfer now gets the next available and monotonically
> > increasing token, until tokens are exhausted and the counter rolls over.
> > 
> > Such new policy mitigates the above issues with ghost responses since the
> > tokens are now reused as late as possible (when they roll back ideally)
> > and so it is much easier to identify such ghost responses to stale timed
> > out transactions: this also helps in simplifying the specific transports
> > implementation since stale transport messages can be easily identified
> > and discarded early on in the rx path without the need to cross check
> > their actual state with the core transport layer.
> > This mitigation is even more effective when, as is usually the case, the
> > maximum number of pending messages is capped by the platform to a much
> > lower number than the whole possible range of tokens values (2^10).
> > 
> > This internal policy change in the core SCMI transport layer is fully
> > transparent to the specific transports so it has not and should not have
> > any impact on the transports implementation.
> > 
> > The empirically observed cost of such new procedure of token selection
> > amounts in the best case to ~10us out of an observed full transaction cost
> > of 3ms for the completion of a synchronous sensor reading command on a
> > platform supporting commands completion interrupts.
> 
> Hi Cristian,
> 
> Just curious... How badly did a cyclic IDR perform for this usecase?
> Feature wise it seems suitable, but perhaps to heavy weight for this
> rather constrained case where you can assume the number of IDs in
> use at a time is rather small.
> 
> Also, I've not looked closely at the code so there may be other relevant
> constraint or subtlety I'm missing.
> 

I'll give it a go to implement it with a cyclic IDR and see how much it
improves the performance; I'm not really strong towards an
implementation than another, the only real requirement here was to use
the full set of 1024 possible tokens before reusing them, even if in
reality the set of possibly pending transactions is far less than
1024 (max_msg <<< 1024) and the set of probably pending ones is even
smaller.

Thanks for the hint about the IDRs I'll see how it pans out in term of
complexity and perf before re-posting.

Cristian
