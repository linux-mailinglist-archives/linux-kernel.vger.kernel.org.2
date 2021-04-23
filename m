Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D779368E76
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 10:07:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236730AbhDWIIJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 04:08:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:37570 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229456AbhDWIII (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 04:08:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8587861181;
        Fri, 23 Apr 2021 08:07:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619165251;
        bh=QsQ6QByKptioVTBH6dl5wYjK2s7eCxSiGywW5tPyYDs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=I9jltyfOV2tU0otWkTme/shksL4s9/m+dZh+cWNR9DF80zFVXlvvDogj3YKnv959H
         gPv96LEwqGqMOp1YhNl/504M5XfUttGb9rfkpPbMvypQ6jVRA59S+ISWiQU9c+dy3j
         P8/g+WDUfRtPhYQxpoJqkAK/S40X+MG29fp6ifuVXcHPakqQRZSy9D1SJSi48zTFtF
         WLbE97VAO310J9wPCTbcrJrIC541Q9MloP1igIy7Kg5rZrAJ2giK6+TpK3ZgPvvYVV
         9nFSM56fetqbaWquKUyKTIKSzaZBBW1BaZNs9Xqsqq91iSA3kUTwKFGLsa/Vz468ib
         fhbiv9VnPxk8g==
Date:   Fri, 23 Apr 2021 10:07:27 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-kernel@vger.kernel.org, Qiushi Wu <wu000273@umn.edu>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Julia Lawall <julia.lawall@inria.fr>
Subject: Re: [PATCH 009/190] Revert "media: s5p-mfc: Fix a reference count
 leak"
Message-ID: <20210423100727.5a999c2e@coco.lan>
In-Reply-To: <YIJy6AnG6QBlkV/5@kroah.com>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
        <20210421130105.1226686-10-gregkh@linuxfoundation.org>
        <b43fc2b0-b3cf-15ab-7d3c-25c1f2a3e658@canonical.com>
        <YIJy6AnG6QBlkV/5@kroah.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, 23 Apr 2021 09:10:32 +0200
Greg Kroah-Hartman <gregkh@linuxfoundation.org> escreveu:

> On Fri, Apr 23, 2021 at 09:04:27AM +0200, Krzysztof Kozlowski wrote:
> > On 21/04/2021 14:58, Greg Kroah-Hartman wrote:  
> > > This reverts commit 78741ce98c2e36188e2343434406b0e0bc50b0e7.
> > > 
> > > Commits from @umn.edu addresses have been found to be submitted in "bad
> > > faith" to try to test the kernel community's ability to review "known
> > > malicious" changes.  The result of these submissions can be found in a
> > > paper published at the 42nd IEEE Symposium on Security and Privacy
> > > entitled, "Open Source Insecurity: Stealthily Introducing
> > > Vulnerabilities via Hypocrite Commits" written by Qiushi Wu (University
> > > of Minnesota) and Kangjie Lu (University of Minnesota).
> > > 
> > > Because of this, all submissions from this group must be reverted from
> > > the kernel tree and will need to be re-reviewed again to determine if
> > > they actually are a valid fix.  Until that work is complete, remove this
> > > change to ensure that no problems are being introduced into the
> > > codebase.
> > > 
> > > Cc: Qiushi Wu <wu000273@umn.edu>
> > > Cc: Hans Verkuil <hverkuil-cisco@xs4all.nl>
> > > Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > ---
> > >  drivers/media/platform/s5p-mfc/s5p_mfc_pm.c | 4 +---
> > >  1 file changed, 1 insertion(+), 3 deletions(-)
> > >   
> > 
> > This looks like a good commit but should be done now in a different way
> > - using pm_runtime_resume_and_get().  Therefore I am fine with revert
> > and I can submit later better fix.  
> 
> Great, thanks for letting me know, I can have someone work on the
> "better fix" at the same time.

IMO, it is better to keep the fix. I mean, there's no reason to
revert a fix that it is known to be good.

The "better fix" patch can be produced anytime. A simple coccinelle
ruleset can replace patterns like:

	ret = pm_runtime_get_sync(pm->device);
	if (ret < 0) {
		pm_runtime_put_noidle(pm->device);
		return ret;
	}

and the broken pattern:

	ret = pm_runtime_get_sync(pm->device);
	if (ret < 0)
		return ret;

to:

	ret = pm_runtime_resume_and_get(pm->device);
	if (ret < 0)
		return ret;

Regards,
Mauro
