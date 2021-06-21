Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FB3D3AF6BE
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 22:17:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231757AbhFUUTa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 16:19:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230028AbhFUUT2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 16:19:28 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 304B5C061574;
        Mon, 21 Jun 2021 13:17:14 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id v22-20020a0568301416b029044e2d8e855eso9810972otp.8;
        Mon, 21 Jun 2021 13:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=lUeLmMYshlqC43ra6D4oMuARM4v5esyzjhcrxCA07rc=;
        b=uen0OLlYCIIJ0ysttCR0tWOzZvZE5wYyjv1j32o1ETOiVlFbURt/DJjrawet5dbsIe
         qIrNSCW+z+bmiq/9pccgtefZpkJF0oli3c6Pjgd0CswfHP/A2OwLRzc96x6AmjEzOUg2
         MKIjDKrWzFL7M/2ulpK8jfxMmxSjqgBJlV3SNGxfxLv7bbNfXeMldlxq5XJtbyomWN6X
         XedyC82puop1+jilpO7Tea1DV5uwXf7KoHF1wAK6UzcRfqLNpKB1Y0mebh9r0zQRWdWY
         IringK+01puuyFlkLMrTjlQLqo/ku8E2X3rWC4q/XAnIfbS0dtQ8qRzp5DLd8h0CE8Bo
         Sq4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=lUeLmMYshlqC43ra6D4oMuARM4v5esyzjhcrxCA07rc=;
        b=YTgs2SlkIKdxuNOEAgPdwEqXKAq26ePRCl0PN2PNfbeLqQkzprkYa9NMB0TOXT2Hry
         oxYyJziQYpcPb23VdqlpoCXBXd/aB+fdXA18PnKjHUloRjte1Vr/oB3V66p37rHCP9wy
         lhCmO1jqj30xOKdFpZZ5uC85yew9u9gv7S5daj6jtSiuL05nt+MW3+E+1eWVEqgWnMoL
         IQbXQNntDfsUpvwwcKcgfYJc6IVKZBsMdMAmueyGx9YFxcvRsl0Uvs1q7UX9piCJhfJ/
         6E1Eniec6kOgQr7qUkA8vwN0io12tW9NnajBrAyojmmH2cIBVasIsT5CxmSTclkxdStL
         wJdw==
X-Gm-Message-State: AOAM5329xhkp7q9IJKvBRCVg9ZNwmkMVl/M1B0vGhmxfiuE4SvcWLPhJ
        7JCKP0/KvibHau+BSLS/Jik=
X-Google-Smtp-Source: ABdhPJyXvwYFylZXYOaEJn7CqGhHRyc5sGx5GMsyW2l3WGjfojJwouZF+P6Xohag5ohcqn7xqfaq3g==
X-Received: by 2002:a9d:5d11:: with SMTP id b17mr222037oti.216.1624306633582;
        Mon, 21 Jun 2021 13:17:13 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id h193sm3808092oib.3.2021.06.21.13.17.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jun 2021 13:17:12 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 21 Jun 2021 13:17:11 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jean Delvare <jdelvare@suse.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Marc Zyngier <maz@kernel.org>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Wei Yang <richard.weiyang@linux.alibaba.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Alexey Klimov <aklimov@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, etnaviv@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-hwmon@vger.kernel.org
Subject: Re: [PATCH 3/3] Replace for_each_*_bit_from() with for_each_*_bit()
 where appropriate
Message-ID: <20210621201711.GA631547@roeck-us.net>
References: <20210618195735.55933-1-yury.norov@gmail.com>
 <20210618195735.55933-4-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210618195735.55933-4-yury.norov@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 18, 2021 at 12:57:35PM -0700, Yury Norov wrote:
> A couple of kernel functions call for_each_*_bit_from() with start
> bit equal to 0. Replace them with for_each_*_bit().
> 
> No functional changes, but might improve on readability.
> 
> Signed-off-by: Yury Norov <yury.norov@gmail.com>
> ---
>  arch/x86/kernel/apic/vector.c         | 4 ++--
>  drivers/gpu/drm/etnaviv/etnaviv_gpu.c | 4 ++--
>  drivers/hwmon/ltc2992.c               | 3 +--

This should be three different patches, one per subsystem.

Guenter

>  3 files changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/x86/kernel/apic/vector.c b/arch/x86/kernel/apic/vector.c
> index fb67ed5e7e6a..d099ef226f55 100644
> --- a/arch/x86/kernel/apic/vector.c
> +++ b/arch/x86/kernel/apic/vector.c
> @@ -760,9 +760,9 @@ void __init lapic_update_legacy_vectors(void)
>  
>  void __init lapic_assign_system_vectors(void)
>  {
> -	unsigned int i, vector = 0;
> +	unsigned int i, vector;
>  
> -	for_each_set_bit_from(vector, system_vectors, NR_VECTORS)
> +	for_each_set_bit(vector, system_vectors, NR_VECTORS)
>  		irq_matrix_assign_system(vector_matrix, vector, false);
>  
>  	if (nr_legacy_irqs() > 1)
> diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
> index 4102bcea3341..42ce3287d3be 100644
> --- a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
> +++ b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
> @@ -1032,7 +1032,7 @@ int etnaviv_gpu_debugfs(struct etnaviv_gpu *gpu, struct seq_file *m)
>  
>  void etnaviv_gpu_recover_hang(struct etnaviv_gpu *gpu)
>  {
> -	unsigned int i = 0;
> +	unsigned int i;
>  
>  	dev_err(gpu->dev, "recover hung GPU!\n");
>  
> @@ -1045,7 +1045,7 @@ void etnaviv_gpu_recover_hang(struct etnaviv_gpu *gpu)
>  
>  	/* complete all events, the GPU won't do it after the reset */
>  	spin_lock(&gpu->event_spinlock);
> -	for_each_set_bit_from(i, gpu->event_bitmap, ETNA_NR_EVENTS)
> +	for_each_set_bit(i, gpu->event_bitmap, ETNA_NR_EVENTS)
>  		complete(&gpu->event_free);
>  	bitmap_zero(gpu->event_bitmap, ETNA_NR_EVENTS);
>  	spin_unlock(&gpu->event_spinlock);
> diff --git a/drivers/hwmon/ltc2992.c b/drivers/hwmon/ltc2992.c
> index 2a4bed0ab226..7352d2b3c756 100644
> --- a/drivers/hwmon/ltc2992.c
> +++ b/drivers/hwmon/ltc2992.c
> @@ -248,8 +248,7 @@ static int ltc2992_gpio_get_multiple(struct gpio_chip *chip, unsigned long *mask
>  
>  	gpio_status = reg;
>  
> -	gpio_nr = 0;
> -	for_each_set_bit_from(gpio_nr, mask, LTC2992_GPIO_NR) {
> +	for_each_set_bit(gpio_nr, mask, LTC2992_GPIO_NR) {
>  		if (test_bit(LTC2992_GPIO_BIT(gpio_nr), &gpio_status))
>  			set_bit(gpio_nr, bits);
>  	}
