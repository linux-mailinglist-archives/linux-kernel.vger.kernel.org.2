Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D52D83FC254
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 08:05:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239054AbhHaF50 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 01:57:26 -0400
Received: from foss.arm.com ([217.140.110.172]:51134 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229759AbhHaF5V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 01:57:21 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4427B6D;
        Mon, 30 Aug 2021 22:56:26 -0700 (PDT)
Received: from e120937-lin (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A88A33F694;
        Mon, 30 Aug 2021 22:56:24 -0700 (PDT)
Date:   Tue, 31 Aug 2021 06:56:22 +0100
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     Jim Quinlan <james.quinlan@broadcom.com>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        etienne.carriere@linaro.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Souvik Chakravarty <souvik.chakravarty@arm.com>
Subject: Re: [PATCH v4 11/12] [RFC] firmware: arm_scmi: Add
 sync_cmds_atomic_replies transport flag
Message-ID: <20210831055622.GK13160@e120937-lin>
References: <20210824135941.38656-1-cristian.marussi@arm.com>
 <20210824135941.38656-12-cristian.marussi@arm.com>
 <7a2f972d-fdd0-d0f7-cac2-1989980ed872@gmail.com>
 <CA+-6iNw-_VXcntU_UE8kTiPb8Sq28KkZG1__N7rE4ezo=VqQVQ@mail.gmail.com>
 <20210825184915.GI13160@e120937-lin>
 <CA+-6iNwjQ1SogxdyrjwqEwLosscUyvrioqFKmesifM_nmCpJAw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+-6iNwjQ1SogxdyrjwqEwLosscUyvrioqFKmesifM_nmCpJAw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 26, 2021 at 02:29:21PM -0400, Jim Quinlan wrote:
> On Wed, Aug 25, 2021 at 2:49 PM Cristian Marussi
> <cristian.marussi@arm.com> wrote:
> >
> > On Wed, Aug 25, 2021 at 01:17:47PM -0400, Jim Quinlan wrote:
> > > On Wed, Aug 25, 2021 at 12:38 PM Florian Fainelli <f.fainelli@gmail.com> wrote:
> > > >
> > > >
> > > >
> >
> > Hi Florian and Jim,
> >
> > > > On 8/24/2021 3:59 PM, Cristian Marussi wrote:
> > > > > A flag is added to let the transport signal the core that its handling of
> > > > > synchronous command messages implies that, after .send_message has returned
> > > > > successfully, the requested command can be assumed to be fully and
> > > > > completely executed on SCMI platform side so that any possible response
> > > > > value is already immediately available to be retrieved by a .fetch_reponse:
> > > > > in other words the polling phase can be skipped in such a case and the
> > > > > response values accessed straight away.
> > > > >
> > > > > Note that all of the above applies only when polling mode of operation was
> > > > > selected by the core: if instead a completion IRQ was found to be available
> > > > > the normal response processing path based on completions will still be
> > > > > followed.
> > > >
> > > > This might actually have to be settable on a per-message basis ideally
> > > > since we may be transporting short lived SCMI messages for which the
> > > > completion can be done at SMC time, and long lived SCMI messages (e.g.:
> > > > involving a voltage change) for which we would prefer a completion
> > > > interrupt. Jim, what do you think?
> > > Even if the SCMI main driver could be configured this way in an
> > > elegant manner, I'm not sure that there is a clean way of specifying
> > > this  attribute on a per-message basis.  Certainly we could do this
> > > with our own protocols, but  many of our "long lived" messages are the
> > > Perf protocol's set_level command.  At any rate, let me give it some
> > > thought.
> > >
> >
> > The new flag .sync_cmds_atomic_replies applies only when polling mode
> > has been selected for a specific cmd transaction, which means when no
> > completion IRQ was found available OR if xfer.poll_completion was
> > excplicitly set for a specific command.
> >
> > At the moment in this series (unknown bugs apart :D), if you have a
> > channel configured with a completion IRQ and the .sync_cmds_atomic_replies
> > set for the transport, this latter flag would be generally ignored and a
> > wait_for_completion() will be normally used upon reception of the
> > completionIRQ, UNLESS you specify that one specific command has to be
> > polled using the per message xfer.poll_completion flag: so you should be
> > already able to selectively use a polling which immediately returns after
> > the smc by setting xfer.poll_completion for that specific short lived
> > message (since sync_cmds_atomic_replies is set and applies to pollmode).
> > On the other side any other LONG lived message will be naturally handled
> > via completionIRQ + wait_for_completion. (at least that was the aim..)
> >
> > !!! NOTE that you'll have also to drop
> >
> >  [PATCH v4 10/12] [RFC] firmware: arm_scmi: Make smc transport atomic
> >
> > from this series for the wait_completion to happen as you wish.
> 
> Hi Cristian,
> 
Hi Jim,

> I've tested all commits on our SMC-based system.  I also tested all commits
> minus  "10/12 [RFC] firmware: arm_scmi: Make smc transport atomic".
> This was a basic stress test, not a comprehensive one.  So
> 
> Tested-by: Jim Quinlan <james.quinlan@broadcom.com>
> 

Thanks a lot for this testing.

> Of course I have a strong preference for omitting  "10/12 [RFC]" :-).
> FWIW, if you are not planning on dropping this commit, perhaps there
> could be a transport
> node in the DT, and that could contain the  a bool  property
> "smc-atomic-capable"?

Indeed, as I was saying more than one customer/partner is asking for this
configurability so this atomic mode should be definitely configurable.
(as it could be teh case similarly with the sync_cmds_atomic_replies
depedning on SCMI server placement..)

I'll talk with Sudeep in general about the series and this configurations;
in fact I can exclude that I'll commit this series with 10/12 as it is right
now.

Thanks for the feedback !

Cristian

> 
> Regards,
> Jim Quinlan
> Broadcom STB
> 
> >
> > As said I'm not sure that this whole mixing of polling and IRQs on the
> > same channel on a regular won't cause any issues: any feedback on this
> > from your setup is much appreciated.
> > (maybe it's fine for SMC transport, but it led to a bit of hell in the
> > past with mboxes AFAIK...)
> >
> > Thanks a lot again for your feedback, I'll have to chat with Sudeep
> > about the various issues/configs possibility that we discussed and I'll
> > keep you in the loop.
> >
> > Thanks,
> > Cristian
> >
> > P.S.: I'll be off for a few weeks, so even though I'll keep an eye on
> > the mail, I cannot guarantee any responsiveness :D


