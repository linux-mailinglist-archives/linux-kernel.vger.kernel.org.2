Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E150937FD57
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 20:42:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231593AbhEMSnI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 14:43:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:38770 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231326AbhEMSnH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 14:43:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1C96E6100C;
        Thu, 13 May 2021 18:41:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1620931316;
        bh=5LLelLIQygK+U6IAj1y8uyQ90yjIXf4BkwkxKjJGayI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rGBA/HAp+QKbShTL0cZPYwlAVfh3PAhdtEBd92G2pxGJnvMO3kQR3DuZUaM9Igo/d
         It5dGilVhp7yMHn4tQ5kJMkJhEp+E+ITWYNDI9/KrlTmi2Pcg9EkxvMnFiB/oPAyqh
         XHwJGF0/dmtUtZZH1x+JmMxMNzEMuYXzUNS/k2P0=
Date:   Thu, 13 May 2021 20:41:54 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] driver core: make device_set_deferred_probe_reason a
 no-op when !CONFIG_DEBUG_FS
Message-ID: <YJ1y8rJNUlwtrOoN@kroah.com>
References: <20210419104256.1709253-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210419104256.1709253-1-linux@rasmusvillemoes.dk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 19, 2021 at 12:42:56PM +0200, Rasmus Villemoes wrote:
> When debugfs is not enabled, the deferred_probe_reason string is never
> read. So there's no reason to spend time and memory on recording it.
> 
> There's still a bunch of redundant kfree(NULL) calls and NULL
> assignments, but this gives most of the benefit (avoiding two
> vsnprintf() and a kmalloc()) for the minimal amount of ifdeffery.
> 
> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> ---
>  drivers/base/dd.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/base/dd.c b/drivers/base/dd.c
> index 37a5e5f8b221..6a197336c6a4 100644
> --- a/drivers/base/dd.c
> +++ b/drivers/base/dd.c
> @@ -216,9 +216,13 @@ void device_unblock_probing(void)
>   * device_set_deferred_probe_reason() - Set defer probe reason message for device
>   * @dev: the pointer to the struct device
>   * @vaf: the pointer to va_format structure with message
> + *
> + * The ->deferred_probe_reason string is only ever read when debugfs
> + * is enabled, so this is a no-op for !CONFIG_DEBUG_FS.
>   */
>  void device_set_deferred_probe_reason(const struct device *dev, struct va_format *vaf)
>  {
> +#ifdef CONFIG_DEBUG_FS
>  	const char *drv = dev_driver_string(dev);
>  
>  	mutex_lock(&deferred_probe_mutex);
> @@ -227,6 +231,7 @@ void device_set_deferred_probe_reason(const struct device *dev, struct va_format
>  	dev->p->deferred_probe_reason = kasprintf(GFP_KERNEL, "%s: %pV", drv, vaf);
>  
>  	mutex_unlock(&deferred_probe_mutex);
> +#endif

Can you move the #ifdef to a .h file and do this properly instead of
cutting up the function like this?

thanks,

greg k-h
