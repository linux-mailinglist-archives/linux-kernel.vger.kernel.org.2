Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DD8632BB8E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 22:24:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378130AbhCCMhr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 07:37:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:46588 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1582414AbhCCICu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 03:02:50 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3A44D64ECE;
        Wed,  3 Mar 2021 07:39:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1614757151;
        bh=pZDwedw1hzBopScKR4gcXQohr1UFUVtkW1cq2bvn1pc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AF7UbK65qLhNRMZUhjLV0IZ6Z54Xuyc9G3xTKhOZqyzlP538PVzUcVw8CNfrPvMfH
         ExRtADFH1Z0KuGSTxWmB9ur8CHFfyVuIAZIzWhWIxXx+ArOduUwrCzsEYxmg2pQzuk
         WeO0EtjtA6k7HKo0Z41q9kTrbYveBw1wQsNshuuM=
Date:   Wed, 3 Mar 2021 08:39:09 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Wang, Li" <li.wang@windriver.com>
Cc:     jirislaby@kernel.org, andriy.shevchenko@linux.intel.com,
        dmitry.torokhov@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vt: keyboard, fix uninitialized variables warning
Message-ID: <YD89HVVBREVdqdpJ@kroah.com>
References: <1614747572-3295-1-git-send-email-li.wang@windriver.com>
 <YD83RFqtKVB2pA9H@kroah.com>
 <5f05c3c2-6c72-140f-fd56-cd9ec1c7c4a1@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5f05c3c2-6c72-140f-fd56-cd9ec1c7c4a1@windriver.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 03, 2021 at 03:33:23PM +0800, Wang, Li wrote:
> 
> On 3/3/2021 3:14 PM, Greg KH wrote:
> > On Wed, Mar 03, 2021 at 12:59:32PM +0800, Li Wang wrote:
> > > drivers/tty/vt/keyboard.c: In function 'vt_do_kdgkb_ioctl':
> > > drivers/tty/vt/keyboard.c: warning: 'ret' may be used uninitialized in this function [-Wmaybe-uninitialized]
> > >    return ret;
> > >           ^~~
> > > kernel-source/drivers/tty/vt/keyboard.c: warning: 'kbs' may be used uninitialized in this function [-Wmaybe-uninitialized]
> > >    kfree(kbs);
> > >    ^~~~~~~~~~
> > > 
> > > Signed-off-by: Li Wang <li.wang@windriver.com>
> > > ---
> > >   drivers/tty/vt/keyboard.c | 4 ++--
> > >   1 file changed, 2 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/drivers/tty/vt/keyboard.c b/drivers/tty/vt/keyboard.c
> > > index 7763862..3e73d55 100644
> > > --- a/drivers/tty/vt/keyboard.c
> > > +++ b/drivers/tty/vt/keyboard.c
> > > @@ -2049,8 +2049,8 @@ int vt_do_kdgkb_ioctl(int cmd, struct kbsentry __user *user_kdgkb, int perm)
> > >   {
> > >   	unsigned char kb_func;
> > >   	unsigned long flags;
> > > -	char *kbs;
> > > -	int ret;
> > > +	char *kbs = NULL;
> > > +	int ret = -EINVAL;
> > >   	if (get_user(kb_func, &user_kdgkb->kb_func))
> > >   		return -EFAULT;
> > What compiler is providing these "warnings"?
> > 
> > Turns out it is impossible to hit, so this isn't actually fixing
> > anything...
> 
> I tested it with gcc 8.2 for arm
> 
> for runtime codes view, indeed it is impossible to hit.
> 
> but for compiler view, gcc should give 'used uninitialized' warning, too.

Odd that no other compiler version does this right now, perhaps upgrade
to a newer version of gcc?  8.2 is really old :(

thanks,

greg k-h
