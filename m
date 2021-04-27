Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10B4D36C6BE
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 15:11:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236121AbhD0NLx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 09:11:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:47804 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235489AbhD0NLt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 09:11:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3D7A2613C8;
        Tue, 27 Apr 2021 13:11:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619529065;
        bh=eF35Tnf4PiV35XLj7Xf7zsuZaAaaflmqarwD/osrkgI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BtvmdxHFkqWNNUX9yA+8ZO4dcjQxlP1pIsX9tZpDGGfSE0TAX3MrsEaTkH/A0dHtT
         53X0k+ZcOkIR0r28SJYVc7j1Rl2L27wLStFHGnsRYvGbdYCQ/hYsmCJ26JGWSLoMip
         QL0gIw/FOBD7z95Us7miJzeSkVBTq8FKoe1h7oks=
Date:   Tue, 27 Apr 2021 15:11:03 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     linux-kernel@vger.kernel.org, Qiushi Wu <wu000273@umn.edu>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 007/190] Revert "media: ti-vpe: Fix a missing check and
 reference count leak"
Message-ID: <YIgNZ0YOPLLLx06B@kroah.com>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
 <20210421130105.1226686-8-gregkh@linuxfoundation.org>
 <01927b51-7d17-112a-a0fd-eae3efafd769@xs4all.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01927b51-7d17-112a-a0fd-eae3efafd769@xs4all.nl>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 22, 2021 at 10:10:50AM +0200, Hans Verkuil wrote:
> On 21/04/2021 14:58, Greg Kroah-Hartman wrote:
> > This reverts commit 7dae2aaaf432767ca7aa11fa84643a7c2600dbdd.
> > 
> > Commits from @umn.edu addresses have been found to be submitted in "bad
> > faith" to try to test the kernel community's ability to review "known
> > malicious" changes.  The result of these submissions can be found in a
> > paper published at the 42nd IEEE Symposium on Security and Privacy
> > entitled, "Open Source Insecurity: Stealthily Introducing
> > Vulnerabilities via Hypocrite Commits" written by Qiushi Wu (University
> > of Minnesota) and Kangjie Lu (University of Minnesota).
> > 
> > Because of this, all submissions from this group must be reverted from
> > the kernel tree and will need to be re-reviewed again to determine if
> > they actually are a valid fix.  Until that work is complete, remove this
> > change to ensure that no problems are being introduced into the
> > codebase.
> > 
> > Cc: Qiushi Wu <wu000273@umn.edu>
> > Cc: Hans Verkuil <hverkuil-cisco@xs4all.nl>
> > Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > ---
> >  drivers/media/platform/ti-vpe/vpe.c | 2 --
> >  1 file changed, 2 deletions(-)
> > 
> > diff --git a/drivers/media/platform/ti-vpe/vpe.c b/drivers/media/platform/ti-vpe/vpe.c
> > index 10251b787674..c7a0a7c19ca6 100644
> > --- a/drivers/media/platform/ti-vpe/vpe.c
> > +++ b/drivers/media/platform/ti-vpe/vpe.c
> > @@ -2473,8 +2473,6 @@ static int vpe_runtime_get(struct platform_device *pdev)
> >  
> >  	r = pm_runtime_get_sync(&pdev->dev);
> >  	WARN_ON(r < 0);
> > -	if (r)
> 
> This should have been: if (r < 0)
> 
> I missed that as a reviewer, and I don't think it was intentional either
> since I couldn't find any clear documentation in pm_runtime_get_sync()
> that it can return 0 or 1 as success. After going through a few wrapper
> functions you end up in rpm_resume() in drivers/base/power/runtime.c
> which doesn't document the return code.
> 
> So keep this reverted and I'll make a new patch for this later.
> 
> I've CC-ed Rafael and Pavel: it would be really nice if someone can
> document the return code from rpm_resume() in drivers/base/power/runtime.c.
> 
> I just discovered that it is documented in Documentation/power/runtime_pm.rst,
> but if you just look at the code then you'll miss this.

Mauro asked for me to drop this one, as he's fixing them all up in a
"better" way with a follow-on patch series.

thanks,

greg k-h
