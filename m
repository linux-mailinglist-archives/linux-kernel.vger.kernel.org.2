Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 276E2329FB5
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 14:02:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243549AbhCBDqL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 22:46:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:35554 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243761AbhCAVAg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 16:00:36 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id A6F85600EF;
        Mon,  1 Mar 2021 20:59:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614632391;
        bh=Ghkh2dd6hiVMkZNxCxWJWFZq3rC/o9YjYgqFCm/vzDw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=itXczhu+y4heRg+ydiqsvq+I4jSomprxCJjrcOS7v4klsW8MIoEBGS3km3ZINRm0S
         6Kt8HAl+yB08EIBSzgxqIhi224BxavVQQYCoo6p/QvY9gxsg/RL9q8+iSM/kWvh+4D
         UgV0hhWh17eLkhf7+SaZCVbato6oO3WpJrxgJnrYAhp0oq1p0vcn8969jEKhcKIqT3
         OJj+5PKADrRdxxUnkhr8fRaQ1Zi+/rQlhqEMv62M9I1wAS5XD7swldHmzUbg46WlJI
         iZcaSo/+9d2N4djrk4JjnbG4BysjGWXzZ5l992x8g7r3/u6kbTNO+ILVTJ15a+s527
         P6ZTfIB5Om73g==
Date:   Tue, 2 Mar 2021 05:59:44 +0900
From:   Keith Busch <kbusch@kernel.org>
To:     Hannes Reinecke <hare@suse.de>
Cc:     Daniel Wagner <dwagner@suse.de>, Sagi Grimberg <sagi@grimberg.me>,
        Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme-tcp: Check if request has started before processing
 it
Message-ID: <20210301205944.GE17228@redsun51.ssa.fujisawa.hgst.com>
References: <a2064070-b511-ba6d-bd64-0b3abc208356@grimberg.me>
 <20210226123534.4oovbzk4wrnfjp64@beryllium.lan>
 <9e209b12-3771-cdca-2c9d-50451061bd2a@suse.de>
 <20210226161355.GG31593@redsun51.ssa.fujisawa.hgst.com>
 <a42d6285-ff32-3e16-b2b1-808d29f2a743@suse.de>
 <20210226171901.GA3949@redsun51.ssa.fujisawa.hgst.com>
 <20210301132639.n3eowtvkms2n5mog@beryllium.lan>
 <786dcef5-148d-ff34-590c-804b331ac519@suse.de>
 <20210301160547.GB17228@redsun51.ssa.fujisawa.hgst.com>
 <b626504c-3427-e8a5-3502-e44a9e79a006@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b626504c-3427-e8a5-3502-e44a9e79a006@suse.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 01, 2021 at 05:53:25PM +0100, Hannes Reinecke wrote:
> On 3/1/21 5:05 PM, Keith Busch wrote:
> > On Mon, Mar 01, 2021 at 02:55:30PM +0100, Hannes Reinecke wrote:
> > > On 3/1/21 2:26 PM, Daniel Wagner wrote:
> > > > On Sat, Feb 27, 2021 at 02:19:01AM +0900, Keith Busch wrote:
> > > > > Crashing is bad, silent data corruption is worse. Is there truly no
> > > > > defense against that? If not, why should anyone rely on this?
> > > > 
> > > > If we receive an response for which we don't have a started request, we
> > > > know that something is wrong. Couldn't we in just reset the connection
> > > > in this case? We don't have to pretend nothing has happened and
> > > > continuing normally. This would avoid a host crash and would not create
> > > > (more) data corruption. Or I am just too naive?
> > > > 
> > > This is actually a sensible solution.
> > > Please send a patch for that.
> > 
> > Is a bad frame a problem that can be resolved with a reset?
> > 
> > Even if so, the reset doesn't indicate to the user if previous commands
> > completed with bad data, so it still seems unreliable.
> > 
> We need to distinguish two cases here.
> The one is use receiving a frame with an invalid tag, leading to a crash.
> This can be easily resolved by issuing a reset, as clearly the command was
> garbage and we need to invoke error handling (which is reset).
> 
> The other case is us receiving a frame with a _duplicate_ tag, ie a tag
> which is _currently_ valid. This is a case which will fail _even now_, as we
> have simply no way of detecting this.
> 
> So what again do we miss by fixing the first case?
> Apart from a system which does _not_ crash?

I'm just saying each case is a symptom of the same problem. The only
difference from observing one vs the other is a race with the host's
dispatch. And since you're proposing this patch, it sounds like this
condition does happen on tcp compared to other transports where we don't
observe it. I just thought the implication that data corruption happens
is a alarming.
