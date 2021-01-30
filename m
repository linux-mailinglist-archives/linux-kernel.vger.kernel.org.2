Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E2D23092E9
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jan 2021 10:10:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233684AbhA3JJ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jan 2021 04:09:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:39216 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233245AbhA3JI5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jan 2021 04:08:57 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id EBC0864E25;
        Sat, 30 Jan 2021 08:55:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1611996907;
        bh=1sftpBGk31jURifaeXhZUvxk92slR/moCxUUzqdzzyc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=I7DAXt6tkiUsTGcNbP5vEdBC8UrrXkxA5P4oS18NT7yfg7EePL+kXrycrIIDLxwav
         lqnh0WAP8W2C12xbM4mkVXcwXC9cHtWJFsK7voKd+8lImfHPsugc+NLAp4ppVUt3Tn
         S2IeeYEKw305cgQA4swZwSK6KObjGk0qB7uugI7Y=
Date:   Sat, 30 Jan 2021 09:55:03 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Scott Branden <scott.branden@broadcom.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Olof Johansson <olof@lixom.net>,
        Desmond Yan <desmond.yan@broadcom.com>
Subject: Re: [PATCH v2] misc: bcm-vk: only support ttyVK if CONFIG_TTY is set
Message-ID: <YBUe58hiyI81oUOp@kroah.com>
References: <20210129220627.22641-1-scott.branden@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210129220627.22641-1-scott.branden@broadcom.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 29, 2021 at 02:06:27PM -0800, Scott Branden wrote:
> Correct compile issue if CONFIG_TTY is not set by
> only adding ttyVK devices if CONFIG_TTY is set.
> 
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Signed-off-by: Scott Branden <scott.branden@broadcom.com>
> 
> ---
> Changes since v1:
> Add function stubs rather than compiling out code
> ---
>  drivers/misc/bcm-vk/Makefile     |  4 ++--
>  drivers/misc/bcm-vk/bcm_vk.h     | 35 +++++++++++++++++++++++++++++---
>  drivers/misc/bcm-vk/bcm_vk_dev.c |  3 +--
>  drivers/misc/bcm-vk/bcm_vk_tty.c |  6 ++++++
>  4 files changed, 41 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/misc/bcm-vk/Makefile b/drivers/misc/bcm-vk/Makefile
> index e4a1486f7209..8d81a734fcad 100644
> --- a/drivers/misc/bcm-vk/Makefile
> +++ b/drivers/misc/bcm-vk/Makefile
> @@ -7,6 +7,6 @@ obj-$(CONFIG_BCM_VK) += bcm_vk.o
>  bcm_vk-objs := \
>  	bcm_vk_dev.o \
>  	bcm_vk_msg.o \
> -	bcm_vk_sg.o \
> -	bcm_vk_tty.o
> +	bcm_vk_sg.o
>  
> +bcm_vk-$(CONFIG_TTY) += bcm_vk_tty.o
> diff --git a/drivers/misc/bcm-vk/bcm_vk.h b/drivers/misc/bcm-vk/bcm_vk.h
> index 3f37c640a814..4a1d515374c7 100644
> --- a/drivers/misc/bcm-vk/bcm_vk.h
> +++ b/drivers/misc/bcm-vk/bcm_vk.h
> @@ -258,7 +258,11 @@ enum pci_barno {
>  	BAR_2
>  };
>  
> +#ifdef CONFIG_TTY
>  #define BCM_VK_NUM_TTY 2
> +#else
> +#define BCM_VK_NUM_TTY 0
> +#endif
>  
>  struct bcm_vk_tty {
>  	struct tty_port port;
> @@ -366,11 +370,15 @@ struct bcm_vk {
>  	struct miscdevice miscdev;
>  	int devid; /* dev id allocated */
>  
> +#ifdef CONFIG_TTY
>  	struct tty_driver *tty_drv;
>  	struct timer_list serial_timer;
>  	struct bcm_vk_tty tty[BCM_VK_NUM_TTY];
>  	struct workqueue_struct *tty_wq_thread;
>  	struct work_struct tty_wq_work;
> +#else
> +	struct bcm_vk_tty *tty;

Why do you still need this pointer?

And should you just have a separate config option for your tty driver
instead that depends on CONFIG_TTY?  Would you ever want to run this
driver without the tty portion?

Oh, and much better than the previous version, thanks for cleaning it
up.

thanks,

greg k-h
