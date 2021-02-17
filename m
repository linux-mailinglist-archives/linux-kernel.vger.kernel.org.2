Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32CC931DC31
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Feb 2021 16:34:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233726AbhBQPcd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Feb 2021 10:32:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:50334 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233617AbhBQP0f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Feb 2021 10:26:35 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8425D64E2F;
        Wed, 17 Feb 2021 15:15:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1613574942;
        bh=lUUgSVw9D08H8NDbvmHh26K4kGOfdxzcmJG/Pnu8YKE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=b/JgNwWCzLwj1i23ERdJVTBxyfis/Ov1h9bMmhmZjxabjDMginjnI7BkiGPhrWGre
         EKZVt097yJI9nUvmyd9MIK3ycqZA2TqMEBjf5S/AuTWMSQrjXXETpHPxukgBC/0Yjj
         BeVmcr0oaxwHa4xh0vSx6dMaIHT4+N3v7NaEznKQ=
Date:   Wed, 17 Feb 2021 16:15:39 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Sabyrzhan Tasbolatov <snovitoll@gmail.com>
Cc:     jirislaby@kernel.org, linux-kernel@vger.kernel.org,
        syzbot+3d2c27c2b7dc2a94814d@syzkaller.appspotmail.com
Subject: Re: [PATCH] tty: fix when iov_iter_count() returns 0 in tty_write()
Message-ID: <YC0zGySVWMKdpulA@kroah.com>
References: <20210217144347.2962551-1-snovitoll@gmail.com>
 <YC0ytokrZPUitjVS@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YC0ytokrZPUitjVS@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 17, 2021 at 04:13:58PM +0100, Greg KH wrote:
> On Wed, Feb 17, 2021 at 08:43:47PM +0600, Sabyrzhan Tasbolatov wrote:
> > syzbot found WARNING in iov_iter_revert[1] when iov_iter_count() returns 0,
> > therefore INT_MAX is passed to iov_iter_revert() causing > MAX_RW_COUNT
> > warning.
> > 
> > static inline ssize_t do_tty_write()
> > {
> > ..
> > 	size_t count = iov_iter_count(from);
> > ..
> > 		size_t size = count;
> > 		if (ret != size)
> > 			iov_iter_revert(from, size-ret);
> > 
> > [1] WARNING: lib/iov_iter.c:1090
> > Call Trace:
> >  do_tty_write drivers/tty/tty_io.c:967 [inline]
> >  file_tty_write.constprop.0+0x55f/0x8f0 drivers/tty/tty_io.c:1048
> >  call_write_iter include/linux/fs.h:1901 [inline]
> >  new_sync_write+0x426/0x650 fs/read_write.c:518
> >  vfs_write+0x791/0xa30 fs/read_write.c:605
> >  ksys_write+0x12d/0x250 fs/read_write.c:658
> > 
> > Fixes: 494e63ee9c("tty: implement write_iter")
> 
> Nit, you need a ' ' before your '(' character here, otherwise the
> linux-next scripts will complain.

Also, you got the git commit id wrong, so this needs to be fixed up
anyway.  You are pointing to a merge point, I doubt that's what you want
to point to here, right?

thanks,

greg k-h
