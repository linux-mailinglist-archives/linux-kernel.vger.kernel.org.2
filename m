Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB0BF3FD6E2
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 11:36:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243697AbhIAJhA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 05:37:00 -0400
Received: from foss.arm.com ([217.140.110.172]:35006 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243672AbhIAJg7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 05:36:59 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5E4AB1042;
        Wed,  1 Sep 2021 02:36:02 -0700 (PDT)
Received: from e120937-lin (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 67E0B3F766;
        Wed,  1 Sep 2021 02:36:01 -0700 (PDT)
Date:   Wed, 1 Sep 2021 10:35:58 +0100
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     rishabhb@codeaurora.org
Cc:     sudeep.holla@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, avajid@codeaurora.org,
        adharmap@codeaurora.org
Subject: Re: [PATCH v3] firmware: arm_scmi: Free mailbox channels if probe
 fails
Message-ID: <20210901093558.GL13160@e120937-lin>
References: <1628111999-21595-1-git-send-email-rishabhb@codeaurora.org>
 <20210805105427.GU6592@e120937-lin>
 <51782599a01a6a22409d01e5fc1f8a50@codeaurora.org>
 <20210831054835.GJ13160@e120937-lin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210831054835.GJ13160@e120937-lin>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 31, 2021 at 06:48:35AM +0100, Cristian Marussi wrote:
> On Mon, Aug 30, 2021 at 02:09:37PM -0700, rishabhb@codeaurora.org wrote:
> > Hi Christian
> 
> Hi Rishabh,
> 
> thanks for looking into this kind of bad interactions.
> 
> > There seems to be another issue here. The response from agent can be delayed
> > causing a timeout during base protocol acquire,
> > which leads to the probe failure. What I have observed is sometimes the
> > failure of probe and rx_callback (due to a delayed message)
> > happens at the same time on different cpus.
> > Because of this race, the device memory may be cleared while the
> > interrupt(rx_callback) is executing on another cpu.
> 
> You are right that concurrency was not handled properly in this kind of
> context and moreover, if you think about it, even the case of out of
> order reception of responses and delayed_responses (type2 SCMI messages)
> for asynchronous SCMI commands was not handled properly.
> 
> > How do you propose we solve this? Do you think it is better to take the
> > setting up of base and other protocols out of probe and
> > in some delayed work? That would imply the device memory is not released
> > until remove is called. Or should we add locking to
> > the interrupt handler(scmi_rx_callback) and the cleanup in probe to avoid
> > the race?
> > 
> 
> These issues were more easily exposed by SCMI Virtio transport, so in
> the series where I introduced scmi-virtio:
> 
> https://lore.kernel.org/linux-arm-kernel/162848483974.232214.9506203742448269364.b4-ty@arm.com/
> 
> (which is now queued for v5.15 ...  now on -next I think...finger crossed)
> 
> I took the chance to rectify a couple of other things in the SCMI core
> in the initial commits.
> As an example, in the above series
> 
>  [PATCH v7 05/15] firmware: arm_scmi: Handle concurrent and out-of-order messages
> 
> cares to add a refcount to xfers and some locking on xfers between TX
> and RX path to avoid that a timed out xfer can vanish while the rx path
> is concurrently working on it (as you said); moreover I handle the
> condition (rare if not unplausible anyway) in which a transport delivers
> out of order responses and delayed responses.
> 
> I tested this scenarios on some fake emulated SCMI Virtio transport
> where I could play any sort of mess and tricks to stress this limit
> conditions, but you're more than welcome to verify if the race you are
> seeing on Base protocol time out is solved (as I would hope :D) by this
> series of mine.
> 
> Let me know, any feedback is welcome.
> 
> Btw, in the series above there are also other minor changes, but there
> is also another more radical change needed to ensure correctness and
> protection against stale old messages which maybe could interest you
> in general if you are looking into SCMI:
> 
> [PATCH v7 04/15] firmware: arm_scmi: Introduce monotonically increasing tokens 
> 
> Let me know if yo have other concerns.
> 

Hi Rishabhb,

just a quick remark, thinking again about your fail @probe scenario above
I realized that while the concurrency patch I mentioned above could help on
races against vanishing xfers when late timed-out responses are delivered,
here we really are then also shutting down everything on failure, so there
could be further issues between a very late invokation of scmi_rx_callback
and the core devm_ helpers freeing the underlying xfer/cinfo/etc.. structs
used by scmi-rx-callback itself (maybe this was already what you meant and
I didn't get it,...sorry)

On the other side, I don't feel that delaying Base init to a deferred
worker is a viable solution since we need Base protocol init to be
initialized and we need to just give up if we cannot communicate with
the SCMI platform fw in such early stages. (Base protocol is really the
only mandatory proto is I remember correctly the spec)

Currenly I'm off and only glancing at mails but I'll have a thought about
these issues once back in a few weeks time.

Thanks,
Cristian
