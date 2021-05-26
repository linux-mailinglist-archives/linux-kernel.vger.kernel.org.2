Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DCD7391A90
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 16:44:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235025AbhEZOqG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 10:46:06 -0400
Received: from foss.arm.com ([217.140.110.172]:45928 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235014AbhEZOqD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 10:46:03 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 433501516;
        Wed, 26 May 2021 07:44:32 -0700 (PDT)
Received: from e120937-lin (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A26B03F73D;
        Wed, 26 May 2021 07:44:30 -0700 (PDT)
Date:   Wed, 26 May 2021 15:44:28 +0100
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        sudeep.holla@arm.com, james.quinlan@broadcom.com,
        Jonathan.Cameron@Huawei.com, etienne.carriere@linaro.org,
        vincent.guittot@linaro.org, souvik.chakravarty@arm.com
Subject: Re: [PATCH 3/4] firmware: arm_scmi: Introduce monotonically
 increasing tokens
Message-ID: <20210526144428.GO28060@e120937-lin>
References: <20210524231503.34924-1-cristian.marussi@arm.com>
 <20210524231503.34924-4-cristian.marussi@arm.com>
 <38fb1a44-3ed4-3a8f-0716-e91159b72a9b@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <38fb1a44-3ed4-3a8f-0716-e91159b72a9b@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Florian,

On Mon, May 24, 2021 at 07:13:35PM -0700, Florian Fainelli wrote:
> 
> 
> On 5/24/2021 4:15 PM, Cristian Marussi wrote:
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
> > Currenly the SCMI stack of the OSPM agent selects as token for the
> 
> s/as token/a token/?
> 
> > egressing commands the lowest possible number which is not already in use
> > by an existing in-flight transaction, which means, in other words, that
> > we immediately reuse any token after its transaction has completed or it
> > has timed out: this indeed simplifies token and associated xfer management
> > and lookup.
> > 
> > Under the above assumptions and constraints, since there is really no state
> > shared between the agent and the platform to let the platform know when a
> > token and its associated message has timed out, the current policy of early
> > reuse of tokens can easily lead to the situation in which a spurios or late
> 
> s/spurios/spurious/
> 
> > received response (or delayed_response), related to an old stale and timed
> > out transaction, can be wrongly associated to a newer valid in-flight xfer
> > that just happens to have reused the same token.
> > 
> > This misbehavior on such ghost responses is more easily exposed on those
> > transports that naturally have an higher level of parallelism in processing
> > multiple concurrent in-flight messages.
> > 
> > This commit introduces a new policy of selection of tokens for the OSPM
> > agent: each new transfer now gets the next available and monotonically
> > increasing token, until tokens are exhausted and the counter rolls over.
> > 
> > Such new policy mitigates the above issues with ghost responses since the
> > tokens are now reused as later as possible (when they roll back ideally)
> > and so it is much easier to identify ghost responses to stale timed out
> > transactions: this also helps in simplifying the specific transports
> > implementation since stale transport messages can be easily identified
> > and discarded early on in the rx path without the need to cross check
> > their actual sate with the core transport layer.
> > This mitigation is even more effective when, as is usual the case, the
> 
> s/usual/usually/
> 
> > maximum number of pending messages is capped by the platform to a much
> > lower value than whole possible range of tokens.(2^10)
> > 
> > This internal policy change in the core SCMI transport layer is fully
> > transparent to the specific transports so it has not and should not have
> > any impact on the transports implementation.
> > 
> > The empirically observed cost of such new procedure of token selection
> > amounts in the best case to ~10us out of an observed full transaction cost
> > of 3ms for the completion of a synchronous sensor reading command on a
> > platform supporting commmands completion interrupts.
> 
> s/commmands/commands/
> 
> > 
> > Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> 
> Overall this looks good to me and is more straightforward than I thought.
> [snip]
> 
> > +/**
> > + * scmi_xfer_token_set  - Reserve and set new token for the xfer at hand
> > + *
> > + * @minfo: Pointer to Tx/Rx Message management info based on channel type
> > + * @xfer: The xfer to act upon
> > + *
> > + * Pick the next unused monotonically increasing token and set it into
> > + * xfer->hdr.seq: picking a monotonically increasing value avoids reusing
> > + * immediately tokens of just completed or timed-out xfers, mitigating the risk
> > + * of wrongly associating a late received answer for an expired xfer to a live
> > + * in-flight transaction which happened to have reused the same token.
> 
> This was a bit harder to read than I thought, how about:
> 
> picking a monotonically increasing value avoids immediate reuse of
> freshly completed or timed-out xfers, thus mitigating the risk of
> incorrect association of a late and expired xfer with a live in-flight
> transaction, both happening to re-use the same token identifier.
> -- 
> Florian

Thanks for having a look and for the feedback !
I'll fix you remarks in V2.

Thanks,
Cristian

