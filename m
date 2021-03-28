Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCC7F34BBBA
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Mar 2021 10:46:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231258AbhC1Ips (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Mar 2021 04:45:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:37910 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229542AbhC1Ipl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Mar 2021 04:45:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C2E376196C;
        Sun, 28 Mar 2021 08:45:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1616921133;
        bh=3MfptsBDXUmNMmv4TO5l2srJOZ/R1fwboYZKKzF3mp4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XdLjCw4V448T8l6ky+w8KiNUISRGwRWXzlWaNEV1uhgiwRwpJTVFN+NsYiLxHuFUs
         6eVbaE1k1Jqn99CJMNviWBXuribiWO9C8rMO1qyBiVdFOPzCuv18AEWLA9DuO4rSQO
         xYGqaY3ZM15+HWm9w81a+cU/XcwCE8qkeV28ksEA=
Date:   Sun, 28 Mar 2021 10:45:28 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Pavel Skripkin <paskripkin@gmail.com>
Cc:     jirislaby@kernel.org, linux-kernel@vger.kernel.org,
        syzbot+bcc922b19ccc64240b42@syzkaller.appspotmail.com
Subject: Re: [PATCH] tty: fix memory leak in vc_deallocate
Message-ID: <YGBCKBtrirh5GmVP@kroah.com>
References: <20210327214443.21548-1-paskripkin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210327214443.21548-1-paskripkin@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 28, 2021 at 12:44:43AM +0300, Pavel Skripkin wrote:
> syzbot reported memory leak in tty/vt.
> The problem was in VT_DISALLOCATE ioctl cmd.
> After allocating unimap with PIO_UNIMAP it wasn't
> freed via VT_DISALLOCATE, but vc_cons[currcons].d was
> zeroed.
> 
> Signed-off-by: Pavel Skripkin <paskripkin@gmail.com>
> Reported-by: syzbot+bcc922b19ccc64240b42@syzkaller.appspotmail.com
> ---
>  drivers/tty/vt/vt.c | 1 +
>  1 file changed, 1 insertion(+)

Is this patch tested by syzbot to fix the problem?

thanks,

greg k-h
