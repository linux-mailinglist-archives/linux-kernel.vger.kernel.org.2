Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F34CF32AD67
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 03:19:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378375AbhCBVtg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 16:49:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:44682 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1581459AbhCBS5M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 13:57:12 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0708964F1F;
        Tue,  2 Mar 2021 18:45:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614710735;
        bh=rOJuCq9EBX9j5Ht1Yizu1nHFQnKPSkAX4k72DB1+878=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fFxFTp30aKkqdvNa1plL/o97/t4rjtjonq4cDzi/u+sLYrtzrL5DTdf0c9JS/wNLk
         JejL1P/QwPlv3uUPi4wFGz/7yXNBOtsc3Hfe+C06/uQdzHwCBdDxK+zQu/dj6lZzf9
         pbdvx8Uqmda7eyaCq+2MUZevoOofKZcVwNUK8K0ThwV9qKkVW9BVszL7A0YXf6oMSx
         LTa/ImrHs90ZE6xz+Nk6AzX+ikR+TR9ihewAmhT7DN7mqjFFQRCNiuUvLblMvOhIzQ
         ixUmh1F+QhjB3LBTMycqDkP3sN8mxe3WXkmdi11LFYnmaxO9Q0vEsV4FgP1vBk3Rj0
         40gjJnRFDeDfQ==
Date:   Wed, 3 Mar 2021 03:45:29 +0900
From:   Keith Busch <kbusch@kernel.org>
To:     Hannes Reinecke <hare@suse.de>
Cc:     Daniel Wagner <dwagner@suse.de>, Sagi Grimberg <sagi@grimberg.me>,
        Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme-tcp: Check if request has started before processing
 it
Message-ID: <20210302184529.GB22346@redsun51.ssa.fujisawa.hgst.com>
References: <9e209b12-3771-cdca-2c9d-50451061bd2a@suse.de>
 <20210226161355.GG31593@redsun51.ssa.fujisawa.hgst.com>
 <a42d6285-ff32-3e16-b2b1-808d29f2a743@suse.de>
 <20210226171901.GA3949@redsun51.ssa.fujisawa.hgst.com>
 <20210301132639.n3eowtvkms2n5mog@beryllium.lan>
 <786dcef5-148d-ff34-590c-804b331ac519@suse.de>
 <20210301160547.GB17228@redsun51.ssa.fujisawa.hgst.com>
 <b626504c-3427-e8a5-3502-e44a9e79a006@suse.de>
 <20210301205944.GE17228@redsun51.ssa.fujisawa.hgst.com>
 <8eb26510-03e1-7923-0f47-2a8d3d539963@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8eb26510-03e1-7923-0f47-2a8d3d539963@suse.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 02, 2021 at 08:18:40AM +0100, Hannes Reinecke wrote:
> On 3/1/21 9:59 PM, Keith Busch wrote:
> > On Mon, Mar 01, 2021 at 05:53:25PM +0100, Hannes Reinecke wrote:
> >> On 3/1/21 5:05 PM, Keith Busch wrote:
> >>> On Mon, Mar 01, 2021 at 02:55:30PM +0100, Hannes Reinecke wrote:
> >>>> On 3/1/21 2:26 PM, Daniel Wagner wrote:
> >>>>> On Sat, Feb 27, 2021 at 02:19:01AM +0900, Keith Busch wrote:
> >>>>>> Crashing is bad, silent data corruption is worse. Is there truly no
> >>>>>> defense against that? If not, why should anyone rely on this?
> >>>>>
> >>>>> If we receive an response for which we don't have a started request, we
> >>>>> know that something is wrong. Couldn't we in just reset the connection
> >>>>> in this case? We don't have to pretend nothing has happened and
> >>>>> continuing normally. This would avoid a host crash and would not create
> >>>>> (more) data corruption. Or I am just too naive?
> >>>>>
> >>>> This is actually a sensible solution.
> >>>> Please send a patch for that.
> >>>
> >>> Is a bad frame a problem that can be resolved with a reset?
> >>>
> >>> Even if so, the reset doesn't indicate to the user if previous commands
> >>> completed with bad data, so it still seems unreliable.
> >>>
> >> We need to distinguish two cases here.
> >> The one is use receiving a frame with an invalid tag, leading to a crash.
> >> This can be easily resolved by issuing a reset, as clearly the command was
> >> garbage and we need to invoke error handling (which is reset).
> >>
> >> The other case is us receiving a frame with a _duplicate_ tag, ie a tag
> >> which is _currently_ valid. This is a case which will fail _even now_, as we
> >> have simply no way of detecting this.
> >>
> >> So what again do we miss by fixing the first case?
> >> Apart from a system which does _not_ crash?
> > 
> > I'm just saying each case is a symptom of the same problem. The only
> > difference from observing one vs the other is a race with the host's
> > dispatch. And since you're proposing this patch, it sounds like this
> > condition does happen on tcp compared to other transports where we don't
> > observe it. I just thought the implication that data corruption happens
> > is a alarming.
> > 
> Oh yes, it is.
> But sadly TCP inherently suffers from this, as literally anyone can
> spoof frames on the network.
> Other transports like RDMA or FC do not suffer to that extend as
> spoofing frames there is far more elaborate, and not really possible
> without dedicated hardware equipment.
> 
> That's why there is header and data digest; that will protect you
> against accidental frame corruption (as this case clearly is; the
> remainder of the frame is filled with zeroes).
> It would not protect you against deliberate frame corruption; that's why
> there is TPAR 8010 (TLS encryption for NVMe-TCP).
> 
> Be it as it may, none of these methods are in use here, and none of
> these methods can be made mandatory. So we need to deal with the case at
> hand.
> 
> And in my opinion crashing is the _worst_ options of all.
> Tear the connection down, reset the thing, whatever.
> 
> But do not crash.
> Customers tend to have a very dim view on crashing machines, and have a
> very limited capacity for being susceptible to our reasoning in these cases.

I was pushing the data corruption angle because fixing that should
address both cases. If there's really nothing you can do about
corruption, your approach here makes sense, and I defer to Sagi and
Christoph for inclusion.

I still wouldn't trust my data to storage behaving this way, though. :)
