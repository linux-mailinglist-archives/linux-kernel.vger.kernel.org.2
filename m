Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 332E438FBA7
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 09:27:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231627AbhEYH2q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 03:28:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231618AbhEYH2n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 03:28:43 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 515BBC061574
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 00:27:14 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id l18-20020a1c79120000b0290181c444b2d0so5648623wme.5
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 00:27:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3ULzEBN0Jp6XpJ/GBCDjzUsE47Bj6V3OGDqs3nkCmBQ=;
        b=NfZNK3AP4Og/CCDj7YYSs3dxKXI9Yon/pw5TGBatv6Z3hbr71FBpaqjvfhyK00mUnl
         UIdBQiPqdFiqwOhmVUnNfwiV1y9R0umkNt4Tq0w+gZos6CmFq5RECL9MXuLRIQ7275Qq
         Gn822MmikBlAoDmGTjlFZkWki47X/e14d2JPNIsjYO+YmYRhHCufrKtatPJXvdkpt8nM
         Mjj12l2nlaOhCn+tfBhEr01K9++dRz3EyUJ4WNfwiWiqeZvhnjC6drVmX9Trd7PKhdrJ
         LpKweY3Q0tJHgXpqzwAm9sjT0HmmWfJXVQrZU+AkvDHHcMpfsBCQaPANLPWiGNGMNpMC
         H0lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=3ULzEBN0Jp6XpJ/GBCDjzUsE47Bj6V3OGDqs3nkCmBQ=;
        b=IprnXwKnRhAPFb4tDf7oGLSOCtx0PrEiF1ZYq6/WD2nuLrcORbivsJbzGiGLCa0lb/
         VQ1NKFtLQA7iiJvGO6A7cDxh7S0Qepyy6ullAATwTnlxZkQXAfkO4BwI75se2M5YDL9n
         jd9s2I7Ac/N5PxDNhsLaA0hrbBe5CExakA/yUD5j1FntYZ/KfgDNE8PyeS6nXG4V9Icf
         yhCo3wuS0SIlM8Avya2i1rGSrbvqL0NqSQ1cFvGPw7odF/rVYI3ZxQ+Hjz6Ewdmvw0UK
         Juoxlbo6PCLIaSnBvIfrzBno89CbV/YE6ZQnAdPcABPrrtMuIlOWLIYz6q6FLtrTRPvv
         kvhg==
X-Gm-Message-State: AOAM533gU5M5UJnA2hw/HlCPRHVRFlBb6a1bJf1W2Tcp+/TbyEsWfzx/
        fqVnq4WEHDYren7w9N7h7Bmzlyg37orewyD6
X-Google-Smtp-Source: ABdhPJxyYxttWGaOHQK/+i3OGI3H2+FM/NOaYwrT/XMwPbrCsfvs/WLauniXQAHjriF6Y7oiTOIgDw==
X-Received: by 2002:a1c:b457:: with SMTP id d84mr2458736wmf.58.1621927632859;
        Tue, 25 May 2021 00:27:12 -0700 (PDT)
Received: from ?IPv6:2a01:e0a:90c:e290:1062:9531:8150:c5f3? ([2a01:e0a:90c:e290:1062:9531:8150:c5f3])
        by smtp.gmail.com with ESMTPSA id h14sm1932369wmb.1.2021.05.25.00.27.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 May 2021 00:27:12 -0700 (PDT)
Subject: Re: [PATCH] drm/meson: fix shutdown crash when component not probed
To:     dri-devel@lists.freedesktop.org
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Stefan Agner <stefan@agner.ch>
References: <20210430082744.3638743-1-narmstrong@baylibre.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Organization: Baylibre
Message-ID: <0359d826-49d5-d724-b38e-012e3389ae43@baylibre.com>
Date:   Tue, 25 May 2021 09:27:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210430082744.3638743-1-narmstrong@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/04/2021 10:27, Neil Armstrong wrote:
> When main component is not probed, by example when the dw-hdmi module is
> not loaded yet or in probe defer, the following crash appears on shutdown:
> 
> Unable to handle kernel NULL pointer dereference at virtual address 0000000000000038
> ...
> pc : meson_drv_shutdown+0x24/0x50
> lr : platform_drv_shutdown+0x20/0x30
> ...
> Call trace:
> meson_drv_shutdown+0x24/0x50
> platform_drv_shutdown+0x20/0x30
> device_shutdown+0x158/0x360
> kernel_restart_prepare+0x38/0x48
> kernel_restart+0x18/0x68
> __do_sys_reboot+0x224/0x250
> __arm64_sys_reboot+0x24/0x30
> ...
> 
> Simply check if the priv struct has been allocated before using it.
> 
> Fixes: fa0c16caf3d7 ("drm: meson_drv add shutdown function")
> Reported-by: Stefan Agner <stefan@agner.ch>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  drivers/gpu/drm/meson/meson_drv.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/meson/meson_drv.c b/drivers/gpu/drm/meson/meson_drv.c
> index 453d8b4c5763..07fcd12dca16 100644
> --- a/drivers/gpu/drm/meson/meson_drv.c
> +++ b/drivers/gpu/drm/meson/meson_drv.c
> @@ -485,11 +485,12 @@ static int meson_probe_remote(struct platform_device *pdev,
>  static void meson_drv_shutdown(struct platform_device *pdev)
>  {
>  	struct meson_drm *priv = dev_get_drvdata(&pdev->dev);
> -	struct drm_device *drm = priv->drm;
>  
> -	DRM_DEBUG_DRIVER("\n");
> -	drm_kms_helper_poll_fini(drm);
> -	drm_atomic_helper_shutdown(drm);
> +	if (!priv)
> +		return;
> +
> +	drm_kms_helper_poll_fini(priv->drm);
> +	drm_atomic_helper_shutdown(priv->drm);
>  }
>  
>  static int meson_drv_probe(struct platform_device *pdev)
> 

Applied to drm-misc-fixes

Neil
