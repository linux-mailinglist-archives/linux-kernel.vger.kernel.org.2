Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE5DE3804B7
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 09:54:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233313AbhENHzs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 03:55:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233331AbhENHzj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 03:55:39 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49D76C06175F
        for <linux-kernel@vger.kernel.org>; Fri, 14 May 2021 00:54:27 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id m9so29187044wrx.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 May 2021 00:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=FbGTVWfDS8cQxtpKVogvmAa19HBXse2riK6QNgECFH0=;
        b=Q6qpTyejKg9P5pbjlb9OBXFbZrpYh9c5b7ybGw1+n1x0RHPwkGzKUMGbxTFVNHD4pk
         e6JbmRKDlMDXGJUmPVsVjqeWXruW91aeugzhTpl4H6R2xf9KEO7UH+Nb3eMknW2WQHJe
         tpWNIEPTotB19XzCmximUJ9NyAUP/j3ksCSrviJXoOS8mMEWsHuEvSQFbhX7UxXnAu4E
         7yhHWwEQYTb3qJkQEqToVB74upMfr2Yw+m7IPBAy1N6n+RRgS1UyBVLlTqwER+hrEFTX
         2Bi12Vafq6wwNQo4lFG2ked7x1TID+I24bv1UC27Ew0ai260oud7WsqmmdFPT2QAyZfK
         WEEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FbGTVWfDS8cQxtpKVogvmAa19HBXse2riK6QNgECFH0=;
        b=W8G7ryl/r+Di532OYbGxumsb/dk47kIgugJduj3bAfnwOncRfOa7YAyn0wTgUupnQG
         bkKZqHx3DTN0GgdZ4ncN9DAfySG9RDi4g6/m9QT8zB1vWsz5ZD3MSHkES3pkLJPgi2tr
         KpExWxsPy7zCmkyPgKh/CwAti2a/nQOYrC+EmCaQk2fVFFASnPgboDhC5xwdM9YzrzBC
         inYeAo+yJuVa1kbuqfV7Aw53ZJDu88w+czjnMv/BtCc12XJdwOv1oRLA8XAcIaVks3Tp
         1LM07i9SnkYv9ixVhnLeKoaVzQA6h8pc1Q2QxKxTS4n/ZasFp2QzJ3XOYWE6T4gckrDK
         47hg==
X-Gm-Message-State: AOAM532QIg9770/xGTyRYD3xN5+GrQHqpOQM0hlB2GegxWDD5gO6Omix
        JOKa8LgSjS0YYWpYvC3LQAw=
X-Google-Smtp-Source: ABdhPJz1Y01d/RaSBoTNvcjRbbII61UcK2e1OHyQzttzkylztFb1W9bZhck1gfshbYO+IUiACQjQ+g==
X-Received: by 2002:a5d:4151:: with SMTP id c17mr6875305wrq.262.1620978865974;
        Fri, 14 May 2021 00:54:25 -0700 (PDT)
Received: from ziggy.stardust ([213.195.126.134])
        by smtp.gmail.com with ESMTPSA id e10sm5895391wrw.20.2021.05.14.00.54.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 May 2021 00:54:25 -0700 (PDT)
Subject: Re: [PATCH] arm64: defconfig: Allow Mediatek boards to boot from the
 mmc
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        linux-kernel@vger.kernel.org
Cc:     Collabora Kernel ML <kernel@collabora.com>,
        linux-mediatek@lists.infradead.org, drinkcat@chromium.org,
        hsinyi@chromium.org, Anson Huang <Anson.Huang@nxp.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        =?UTF-8?Q?Guido_G=c3=bcnther?= <agx@sigxcpu.org>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Max Krummenacher <max.oss.09@gmail.com>,
        Michael Walle <michael@walle.cc>, Nishanth Menon <nm@ti.com>,
        Shawn Guo <shawnguo@kernel.org>, Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org
References: <20210423075250.2616275-1-enric.balletbo@collabora.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <8f5ba7d9-cae0-dde6-6d20-f6e37cbe6338@gmail.com>
Date:   Fri, 14 May 2021 09:54:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210423075250.2616275-1-enric.balletbo@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 23/04/2021 09:52, Enric Balletbo i Serra wrote:
> Enable the MMC_MTK option necessary to boot Mediatek boards from the
> mmc. Booting from the mmc is the common method used for a bunch of
> boards, specially Chromebooks, to boot from. Hence this driver is
> built-in.
> 
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>


Applied to v5.13-next/defconfig



Thanks!

> ---
> 
>  arch/arm64/configs/defconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index 7b4be3807b6d..acb718160345 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -851,6 +851,7 @@ CONFIG_MMC_DW_K3=y
>  CONFIG_MMC_DW_ROCKCHIP=y
>  CONFIG_MMC_SUNXI=y
>  CONFIG_MMC_BCM2835=y
> +CONFIG_MMC_MTK=y
>  CONFIG_MMC_SDHCI_XENON=y
>  CONFIG_MMC_SDHCI_AM654=y
>  CONFIG_MMC_OWL=y
> 
