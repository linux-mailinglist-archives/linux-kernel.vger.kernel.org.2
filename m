Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA64A309D74
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jan 2021 16:24:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232285AbhAaPWc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jan 2021 10:22:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232345AbhAaOdR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jan 2021 09:33:17 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2CB7C061574;
        Sun, 31 Jan 2021 06:32:29 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id o10so9821078wmc.1;
        Sun, 31 Jan 2021 06:32:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=FWkhcoloomIf/wCpYLZRmkASt8JrJgJ4CUQou1kVpi0=;
        b=Dai/PVKLRrTBU1URL0yU/x4P2QwlU3Cmsqf2VGfLIoBnH9A/PjbEkEqv+SLpitCBkS
         PcbdA+H90MKBbQITo/nD2onuWVXsb8fh2QTMM9PR/en+4qNM3eVMaTBhTOTHIuA/a/ZE
         9kfWztDsVNAIsZPBWa+X51gNcZWg4HP2JhCNv3o9bgJ/MadOuWac6dc50peTFa0fWcMu
         2+zU4u0EmDdtGe3o9KUCxIqw4YxhH1eqktqwtJXe7FQFL51+k47+Wq2klP4dCHeE0j4J
         wFOO/nFeN+h+7WEVeQXwzQC1IKiQCD4aGWRiy+efxyIHTA4Yfl7XrUoLozPljVePdHKF
         JvJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FWkhcoloomIf/wCpYLZRmkASt8JrJgJ4CUQou1kVpi0=;
        b=C09/lSnH+tGufqJ35OJwPRPZsFUuAZVrKE0GQ7tSVUReONL1ZgH/hRWT5g8qLElE5s
         /+qXGHjdGswz/0BbdUSqTIDeKwSYSWwSEbkpjQc7D+5PSJmentT9iGjg3j4WGvWR8LuE
         cOsb7TjmivBbURtIuif0ZHGURDbsAC4DQNxwg9E64PJeNy0S+Qu7N7Ot1s1AUC5k2shv
         v3DFJZltbvRSZcxic/D8YWRUROpQOPuOyOYqUMYsprcbT4l3+JeK2N/Y13JHIMPPd/ky
         k6/VJIZRxhRSab+036tckzNEizRYq/LObmo5R18p8XqXwpMc7ocgQ4GYogbXCMrSf6Xv
         wa5Q==
X-Gm-Message-State: AOAM530MXeXG1uQyGU304wF/ArWXriSh7PWYCaDD95+JKmvV/ImPdLBd
        p1USJtqrOE4kKGXPBT7iwJY=
X-Google-Smtp-Source: ABdhPJyj7wgFtetm6z3qEvEw8kAksVNfpgYl9/gaF3CnnwgE1h/kpUTnWQ8oEbScQTavtrccspYEdw==
X-Received: by 2002:a1c:a406:: with SMTP id n6mr11363169wme.53.1612103548450;
        Sun, 31 Jan 2021 06:32:28 -0800 (PST)
Received: from ziggy.stardust ([213.195.126.134])
        by smtp.gmail.com with ESMTPSA id b83sm5000058wmc.44.2021.01.31.06.32.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 31 Jan 2021 06:32:27 -0800 (PST)
Subject: Re: [PATCH 2/2] arm64: configs: Support pwrap on Mediatek MT6779
 platform
To:     Argus Lin <argus.lin@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Arnd Bergmann <arnd@arndb.de>,
        Anson Huang <Anson.Huang@nxp.com>,
        Michael Walle <michael@walle.cc>, agx@sigxcpu.org,
        Max Krummenacher <max.oss.09@gmail.com>,
        wsd_upstream@mediatek.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <1609747703-27207-1-git-send-email-argus.lin@mediatek.com>
 <1609747703-27207-3-git-send-email-argus.lin@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <5d5a67a5-ac2d-9ef9-b20c-66cbd55ebb8f@gmail.com>
Date:   Sun, 31 Jan 2021 15:32:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <1609747703-27207-3-git-send-email-argus.lin@mediatek.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 04/01/2021 09:08, Argus Lin wrote:
> Support pwrap on Mediatek MT6779 platform by enabling CONFIG_MTK_PMIC_WRAP.
> 
> Signed-off-by: Argus Lin <argus.lin@mediatek.com>
> ---

Applied to v5.11-next/defconfig

>  arch/arm64/configs/defconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index 8383016..a2c926f 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -479,6 +479,7 @@ CONFIG_SPI_S3C64XX=y
>  CONFIG_SPI_SH_MSIOF=m
>  CONFIG_SPI_SUN6I=y
>  CONFIG_SPI_SPIDEV=m
> +CONFIG_MTK_PMIC_WRAP=m
>  CONFIG_SPMI=y
>  CONFIG_PINCTRL_SINGLE=y
>  CONFIG_PINCTRL_MAX77620=y
> --
> 1.8.1.1.dirty
> 
