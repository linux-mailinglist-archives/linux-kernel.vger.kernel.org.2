Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAA45447343
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Nov 2021 15:17:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230449AbhKGOUG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Nov 2021 09:20:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:52924 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229683AbhKGOUF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Nov 2021 09:20:05 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id CE31360FC1;
        Sun,  7 Nov 2021 14:17:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1636294642;
        bh=W2Tg+hxn/VjidjI8GDcgtvbMKx6gstBSJ7VCd5VEn5A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1IBonNdqA6GG62i80+9KsiWfmf+cyXcJCb85i3sc6Tnyvv2X1ZSe0u7osoQ6PsckS
         11bIO0UBM9VC3BxG+YddngerTVi5Vu+mIpI2tuN3NanoG7pJzaNsPCEHd0SfmTwQ0W
         tcJH9iOKRn9BNfOrOOUFmu1hAnmIJMBYJ/rgmXp4=
Date:   Sun, 7 Nov 2021 15:17:19 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] staging: r8188eu: Use kzalloc() with GFP_ATOMIC in
 atomic context
Message-ID: <YYff78mUK+9F9pEN@kroah.com>
References: <20211101191847.6749-1-fmdefrancesco@gmail.com>
 <6109499.H5l3i5aCOD@localhost.localdomain>
 <YYfUywXdy3eyssyf@kroah.com>
 <2284999.BhpMBdGVLH@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2284999.BhpMBdGVLH@localhost.localdomain>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 07, 2021 at 03:03:18PM +0100, Fabio M. De Francesco wrote:
> On Sunday, November 7, 2021 2:29:47 PM CET Greg Kroah-Hartman wrote:
> > On Sun, Nov 07, 2021 at 02:15:59PM +0100, Fabio M. De Francesco wrote:
> > > On Sunday, November 7, 2021 1:38:35 PM CET Greg Kroah-Hartman wrote:
> > > > On Sun, Nov 07, 2021 at 12:43:51PM +0100, Fabio M. De Francesco wrote:
> > > > > On Monday, November 1, 2021 8:18:47 PM CET Fabio M. De Francesco 
> wrote:
> > > > > > Use the GFP_ATOMIC flag of kzalloc() with two memory allocation in
> > > > > > report_del_sta_event(). This function is called while holding 
> > > spinlocks,
> > > > > > therefore it is not allowed to sleep. With the GFP_ATOMIC type 
> flag, 
> > > the
> > > > > > allocation is high priority and must not sleep.
> > > > > > 
> > > > > > This issue is detected by Smatch which emits the following warning:
> > > > > > "drivers/staging/r8188eu/core/rtw_mlme_ext.c:6848 
> > > report_del_sta_event()
> > > > > > warn: sleeping in atomic context".
> > > > > > 
> > > > > > After the change, the post-commit hook output the following 
> message:
> > > > > > "CHECK: Prefer kzalloc(sizeof(*pcmd_obj)...) over
> > > > > > kzalloc(sizeof(struct cmd_obj)...)".
> > > > > > 
> > > > > > According to the above "CHECK", use the preferred style in the 
> first
> > > > > > kzalloc().
> > > > > > 
> > > > > > Fixes: 79f712ea994d ("staging: r8188eu: Remove wrappers for 
> kalloc() 
> > > and 
> > > > > kzalloc()")
> > > > > > Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> > > > > > ---
> > > 
> > > > > > [...]
> > > 
> > > > > Please let me know if there is something that prevents this patch to 
> be 
> > > > > applied. I have no problem in changing / adding whatever it is 
> needed.
> > > > 
> > > > Nothing needs to be done, I am waiting for 5.16-rc1 to be released
> > > > before I pick up this patch, and others that will be targeted for
> > > > 5.16-final.  Only then will I queue them up, as the automated email you
> > > > should have gotten when you submitted the patch said would happen.
> > > > 
> > > > Just relax, there is no rush here :)
> > > > 
> > > 
> > > Oh, sorry Greg. There must be something that I haven't understand about 
> the 
> > > development process... :(
> > > 
> > > Obviously I agree that there is no rush here :)
> > > 
> > > As I said, this morning I read git log and saw patches that seemed more 
> > > recent; thus I thought that was the case to ask. I just (wrongly) thought 
> > > that the v3 of the patch got unnoticed or dropped  because of some 
> requests  
> > > that I had missed. 
> > 
> > Be sure to notice what branch commits are being applied to.  There are
> > different branches for a reason :)
> > 
> This is what confuses me:
> 
> --- git-log output ---
> 
> commit 8a893759d0075ea9556abcf86a4826d9865ba4bf (origin/staging-testing)
> Author: Phillip Potter <phil@philpotter.co.uk>
> Date:   Sat Nov 6 23:16:36 2021 +0000
> 
>     staging: r8188eu: remove MSG_88E macro
> 
> --- end of git-log output ---
> 
> Aside from the "Date" field, I know that this patch has been sent to the list 
> during the last night and that it goes to the same branch (staging-testing) 
> to which my patch should go. I know I'm still missing something, but I cannot 
> understand what it is... :(

No, your change will go to the staging-linus branch, as it needs to go
into 5.16-final and get sent to Linus much sooner than 5.17-rc1, which
is where things are being queued up in the staging-testing branch at the
moment.

hope this helps,

greg k-h
