Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A337636402E
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 13:03:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238618AbhDSLDr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 07:03:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:34676 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238312AbhDSLDe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 07:03:34 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6065861166;
        Mon, 19 Apr 2021 11:03:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1618830185;
        bh=RV0J+qJN63RF1LfXGiWFf495q6N3XeBEcmKUPqxeYX8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IsU1wXQUTVtxIem2KUCCuXbCA/uWxFum4SiPeorW5cCpXigY/FeHXBRuD4IdXavS9
         9LpCrbX89bgbFi8aTyw17BScWjf7O+EJTA87wqbb/6BumGZ08byhectiWljoXsyNuk
         OKI2TD/dL7OlySH4eqlsje4dVBHycN5F+cSgnfq0=
Date:   Mon, 19 Apr 2021 13:03:02 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] driver core: make device_set_deferred_probe_reason a
 no-op when !CONFIG_DEBUG_FS
Message-ID: <YH1jZp9w4j3WvLNG@kroah.com>
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

How much time and memory is it?

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

I really don't like #ifdef in .c files.  Any way to put this in the .h
file instead like should be done properly?

thanks,

greg k-h
