Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B909536B753
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 18:57:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234798AbhDZQ6c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 12:58:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:33582 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234257AbhDZQ6a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 12:58:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 352FA61078;
        Mon, 26 Apr 2021 16:57:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619456268;
        bh=sRKHRNhGCFGLt+EhLW6+Qg77rTkmKmj5RH1dtbCQXDI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lnm5pdSDim0fWeYgZtu101XCgMW/hZsf697m4dCAKRvLZmx0/yCUFGKwqCqOmEX94
         HhCwhOWb7nEJRybnIvhZP8jIWWDat2jhyuA/Fd5Pf0hTNidwgyW+7cmfrphnCKIlt+
         iqjtOUAO5dqPBasJuyG1P2T77c/Xrpa9jFOg2zOk=
Date:   Mon, 26 Apr 2021 18:57:46 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Felipe Balbi <balbi@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Aditya Pakki <pakki001@umn.edu>
Subject: Re: [PATCH 026/190] Revert "usb: dwc3: pci: Fix reference count leak
 in dwc3_pci_resume_work"
Message-ID: <YIbxCgnTrVBIu1lA@kroah.com>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
 <20210421130105.1226686-27-gregkh@linuxfoundation.org>
 <87fszimtpy.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87fszimtpy.fsf@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 22, 2021 at 02:42:01PM +0300, Felipe Balbi wrote:
> 
> Hi,
> 
> Greg Kroah-Hartman <gregkh@linuxfoundation.org> writes:
> 
> > This reverts commit 2655971ad4b34e97dd921df16bb0b08db9449df7.
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
> > Cc: Aditya Pakki <pakki001@umn.edu>
> > Cc: Felipe Balbi <balbi@kernel.org>
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > ---
> >  drivers/usb/dwc3/dwc3-pci.c | 4 +---
> >  1 file changed, 1 insertion(+), 3 deletions(-)
> >
> > diff --git a/drivers/usb/dwc3/dwc3-pci.c b/drivers/usb/dwc3/dwc3-pci.c
> > index 4c5c6972124a..0c0619f7b1a7 100644
> > --- a/drivers/usb/dwc3/dwc3-pci.c
> > +++ b/drivers/usb/dwc3/dwc3-pci.c
> > @@ -226,10 +226,8 @@ static void dwc3_pci_resume_work(struct work_struct *work)
> >  	int ret;
> >  
> >  	ret = pm_runtime_get_sync(&dwc3->dev);
> > -	if (ret) {
> > -		pm_runtime_put_sync_autosuspend(&dwc3->dev);
> > +	if (ret)
> >  		return;
> > -	}
> 
> this was a valid fix. pm_runtime_get_sync() leaves an unbalanced get on
> the runtime usage counter.
> 
> It's okay if you prefer to revert it and have a new review cycle for
> this, though.

I'll drop this revert now, thanks for the review.

greg k-h
