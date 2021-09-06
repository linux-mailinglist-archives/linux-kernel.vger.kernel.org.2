Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C18B4018BD
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Sep 2021 11:18:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241239AbhIFJTW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Sep 2021 05:19:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241259AbhIFJTN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Sep 2021 05:19:13 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95918C061575
        for <linux-kernel@vger.kernel.org>; Mon,  6 Sep 2021 02:18:08 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id u16so8791247wrn.5
        for <linux-kernel@vger.kernel.org>; Mon, 06 Sep 2021 02:18:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=menJrL5vhN9DrUdSiHpBgq6VcVejyMJMiOC85iSRuHw=;
        b=XSGP/Ojb2OTTbl5JUgaMJnr9zxX8tLPBm6Z34TViY4QlTKRguErqPwGNuCdZEited5
         hbdwkGXsgl1rN9UAG1RNTGHYNtG5qwHWVt6g9SCCPN/Bokij+Xk6wlCE3okx3k+GNaQ1
         a8ZCGzcGUc2d24B4ZV72+Sqw2yNjmtUudRBghk9eHWDft/IytBiiqMg0/DMj71sroqUW
         2CdIbFGntswJiYdX06SiPvsDDLiMP9uN0YNGsRu1WRcTpvoNQX9m7FQt6dvrXu1YxA8i
         lTzpFdA9A47ix50SU01Cnb3BW8e7gr4xFklKp7scJhydyPeKSnAMD7rE9mP6uM3kYGgS
         o9sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=menJrL5vhN9DrUdSiHpBgq6VcVejyMJMiOC85iSRuHw=;
        b=pw0w7i2G6omgJId9XkOEi74sMYn6tp1UIn8TGvGhPGeC3+P+uhlG6BMdvSDe/0ggt8
         Fr5lPuK18pNKX6fWapSJLyK1AKfdCUVqY15NVGTaZVY4GZltk/l8fHzhWznXMFG28tpc
         DFN5EBFnSim+/Z+gEjbuakKcbJ3PnCwe3TBGIg2iDTo8G0IKzTqvdoUBN9ncbWpX7oBl
         sZDxN7P+mY8sPtELDGfuBI662ir4H2U6LbjYJgeNQaQDXpjOQlDAjlAWXrMvfdPFdIqM
         WM5HXEV8hHXp3llx+R1yafRb/5wvK976c0eekAKfvXuwxs+d3re2MaugOmuIopB0EG7h
         1hGA==
X-Gm-Message-State: AOAM532yDD5B0VPgcVa8ZLk8108iy1eyuh0+W5ufTpkbkOPJLGKwxuyz
        X3rxOM/od3UMpK2CkWGTVohSjA==
X-Google-Smtp-Source: ABdhPJy9ZemOu0u4TSkFUa85fIvB0sKODTqd8G530TjRDTqC523D+6YAcDl9l71GFuB01XJT2NWWHA==
X-Received: by 2002:adf:f0c7:: with SMTP id x7mr11188300wro.42.1630919887117;
        Mon, 06 Sep 2021 02:18:07 -0700 (PDT)
Received: from google.com ([31.124.24.187])
        by smtp.gmail.com with ESMTPSA id m3sm8914003wrg.45.2021.09.06.02.18.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Sep 2021 02:18:06 -0700 (PDT)
Date:   Mon, 6 Sep 2021 10:18:04 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Vladimir Oltean <vladimir.oltean@nxp.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Arnd Bergmann <arnd@arndb.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
        Biwen Li <biwen.li@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] mfd: syscon: request a regmap with raw spinlocks for
 some devices
Message-ID: <YTXczJbHYCgkpVGu@google.com>
References: <20210825205041.927788-1-vladimir.oltean@nxp.com>
 <20210825205041.927788-3-vladimir.oltean@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210825205041.927788-3-vladimir.oltean@nxp.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Aug 2021, Vladimir Oltean wrote:

> This patch solves a ls-extirq irqchip driver bug in a perhaps
> non-intuitive (at least non-localized) way.
> 
> The issue is that ls-extirq uses regmap, and due to the fact that it is
> being called by the IRQ core under raw spinlock context, it needs to use
> raw spinlocks itself. So it needs to request raw spinlocks from the
> regmap config.
> 
> All is fine so far, except the ls-extirq driver does not manage its own
> regmap, instead it uses syscon_node_to_regmap() to get it from the
> parent syscon (this driver).
> 
> Because the syscon regmap is initialized before any of the consumer
> drivers (ls-extirq) probe, we need to know beforehand whether to request
> raw spinlocks or not.
> 
> The solution seems to be to check some compatible string. The ls-extirq
> driver probes on quite a few NXP Layerscape SoCs, all with different
> compatible strings. This is potentially fragile and subject to bit rot
> (since the fix is not localized to the ls-extirq driver, adding new
> compatible strings there but not here seems plausible). Anyway, it is
> probably the best we can do without major rework.
> 
> Suggested-by: Mark Brown <broonie@kernel.org>
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> ---
>  drivers/mfd/syscon.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/drivers/mfd/syscon.c b/drivers/mfd/syscon.c
> index 765c0210cb52..70da4e87b072 100644
> --- a/drivers/mfd/syscon.c
> +++ b/drivers/mfd/syscon.c
> @@ -83,6 +83,22 @@ static struct syscon *of_syscon_register(struct device_node *np, bool check_clk)
>  	if (ret)
>  		reg_io_width = 4;
>  
> +	/*
> +	 * We might be providing a regmap to e.g. an irqchip driver, and in
> +	 * that case, normal spinlocks won't do: the IRQ core holds raw
> +	 * spinlocks, so it needs to be raw spinlocks all the way down.
> +	 * Detect those drivers here (currently "ls-extirq") and request raw
> +	 * spinlocks in the regmap config for them.
> +	 */
> +	if (of_device_is_compatible(np, "fsl,lx2160a-isc") ||
> +	    of_device_is_compatible(np, "fsl,ls2080a-isc") ||
> +	    of_device_is_compatible(np, "fsl,ls2080a-isc") ||
> +	    of_device_is_compatible(np, "fsl,ls1088a-isc") ||
> +	    of_device_is_compatible(np, "fsl,ls1043a-scfg") ||
> +	    of_device_is_compatible(np, "fsl,ls1046a-scfg") ||
> +	    of_device_is_compatible(np, "fsl,ls1021a-scfg"))
> +		syscon_config.use_raw_spinlock = true;
> +

Since syscon is meant to be a generic solution, I'd like to avoid
spraying platform specific hacks throughout.  So, *IF* this is the
chosen solution, I'd prefer to solve this with a generic DT property,
rather than matching on a bunch of compatible strings.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
