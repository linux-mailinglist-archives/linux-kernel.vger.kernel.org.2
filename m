Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF1C931A212
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 16:50:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232031AbhBLPtq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 10:49:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:58932 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231424AbhBLPtl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 10:49:41 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1C3A264E02;
        Fri, 12 Feb 2021 15:48:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1613144940;
        bh=mPWU5J6FvfSdf87XeMnvIwDdBegHQnAd+4cz0Zhf7/k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=J6Zxe15mIrkj4UIWWsMMaLMX4mZkklYfrPxMUuKCk1g49j+b4Lxx7yRiu86k/RKTn
         8bFgVXJjWUJ2Q6P+0Qp3vgQMWjhwgVqvYo3UWlkPtsBBfbDypmISlr8Fr1VKsVpAIW
         HrW28m8dvXj0lco4hV66PanfVN8PEbhp9u+stFhg=
Date:   Fri, 12 Feb 2021 16:48:58 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Min Li <min.li.xe@renesas.com>
Cc:     "derek.kiernan@xilinx.com" <derek.kiernan@xilinx.com>,
        "dragan.cvetic@xilinx.com" <dragan.cvetic@xilinx.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v2] misc: Add Renesas Synchronization Management
 Unit (SMU) support
Message-ID: <YCajam09pnhVHqkQ@kroah.com>
References: <1613092575-17311-1-git-send-email-min.li.xe@renesas.com>
 <YCYwrNE8547uuODo@kroah.com>
 <OSBPR01MB47733A5CB20E20E48EE84602BA8B9@OSBPR01MB4773.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OSBPR01MB47733A5CB20E20E48EE84602BA8B9@OSBPR01MB4773.jpnprd01.prod.outlook.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 12, 2021 at 03:39:03PM +0000, Min Li wrote:
> > > +
> > > +	/* Only one open per device at a time */
> > > +	if (!atomic_dec_and_test(&rsmu->open_count)) {
> > > +		atomic_inc(&rsmu->open_count);
> > > +		return -EBUSY;
> > 
> > This does not do what you think it does, and does not prevent multiple
> > applications from talking to your device at the same time.
> > 
> > There is no need for this at all, as it does not work, sorry.  If multiple apps
> > talk to your device, it's their fault, not the kernel's fault, that things go
> > wrong.
> > 
> > And I thought that Arnd already told you to fix this?
> > 
> 
> Hi Greg
> 
> Sorry for not replying to the list, I am new so not very familiar with the process.
> 
> Can you elaborate why it doesn't work? I kind of borrow the idea from
> xilinx_sdfec.c and I don't see why it doesn't work.

xilinx_sdfec.c has:

	static int xsdfec_dev_open(struct inode *iptr, struct file *fptr)
	{
	        return 0;
	}

Which isn't even needed at all, but it is NOT trying to keep people from
calling open multiple times.

As for why the above logic does not work in your driver, think of what
happens if someone opens the character device node, and then calls
dup(2) on it and passes that file descriptor off to another program.  Or
just calls it multiple times from different threads in the same program.
The kernel does not know what is happening here, and so, "do not allow
to be opened multiple times" does not do anything to keep userspace from
actually writing to the device node from multiple processes or threads.

So don't even try, it's not worth it.

> I mean if an application failed at opening the device, how can it
> proceed to talk the device without a file descriptor?

See above for how to do this.

thanks,

greg k-h
