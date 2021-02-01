Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 105DC30A2D7
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 08:47:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232100AbhBAHqa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 02:46:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:40502 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230174AbhBAHq3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 02:46:29 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1057364E25;
        Mon,  1 Feb 2021 07:45:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1612165548;
        bh=HfIKe4Ra643edjOVDok3KddUaSAgFo3c7mdIwt/sFF4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZndDGOnb8W6QTO8zoelUE9fEpJh7fciZYJVn/OwkbQpZsAjl/y5d+kIzi0Ez6YASu
         g/eDd7ex2B4dqbv/G0xD8tMFLdH6cwO2paifEXYIHeEo/Hz7xKOzGdQngtLZS3fWOl
         4umaq1QLM9w65Qi/+5zcciL8wh0vEY5KjEOsKvvw=
Date:   Mon, 1 Feb 2021 08:45:44 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Scott Branden <scott.branden@broadcom.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Olof Johansson <olof@lixom.net>,
        Desmond Yan <desmond.yan@broadcom.com>
Subject: Re: [PATCH v3] misc: bcm-vk: only support ttyVK if CONFIG_TTY is set
Message-ID: <YBexqH9KZEMs2fq0@kroah.com>
References: <20210131233049.5500-1-scott.branden@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210131233049.5500-1-scott.branden@broadcom.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 31, 2021 at 03:30:49PM -0800, Scott Branden wrote:
> Correct compile issue if CONFIG_TTY is not set by
> only adding ttyVK devices if CONFIG_BCM_VK_TTY is set.
> 
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Signed-off-by: Scott Branden <scott.branden@broadcom.com>
> 
> ---
> Changes since v2:
> - add CONFIG_BCM_VK_TTY
> - add function and stub for bcm_vk_tty_set_irq_enabled
> Changes since v1:
> - add function stubs rather than compiling out code
> ---
>  drivers/misc/bcm-vk/Kconfig      | 16 ++++++++++++
>  drivers/misc/bcm-vk/Makefile     |  4 +--
>  drivers/misc/bcm-vk/bcm_vk.h     | 42 +++++++++++++++++++++++++++++---
>  drivers/misc/bcm-vk/bcm_vk_dev.c |  5 ++--
>  drivers/misc/bcm-vk/bcm_vk_tty.c |  6 +++++
>  5 files changed, 65 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/misc/bcm-vk/Kconfig b/drivers/misc/bcm-vk/Kconfig
> index 052f6f28b540..16ce98c964b8 100644
> --- a/drivers/misc/bcm-vk/Kconfig
> +++ b/drivers/misc/bcm-vk/Kconfig
> @@ -15,3 +15,19 @@ config BCM_VK
>  	  accelerators via /dev/bcm-vk.N devices.
>  
>  	  If unsure, say N.
> +
> +if BCM_VK

No need for this, just put it on the depends line, right?

> +
> +config BCM_VK_TTY
> +	bool "Enable ttyVK"

Better config help text to explain what this is?


> +	depends on TTY
> +	default y

Default y is only there if your system can not boot without it, please
remove it.

> +	help
> +	  Select this option to enable ttyVK support to allow console
> +	  access to VK cards from host.

Again, more help text, what is a "VK"?

thanks,

greg k-h
