Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DB5A3B9581
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jul 2021 19:27:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233114AbhGAR3s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jul 2021 13:29:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229987AbhGAR3r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jul 2021 13:29:47 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBAD9C061762;
        Thu,  1 Jul 2021 10:27:15 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id t15so5862285wry.11;
        Thu, 01 Jul 2021 10:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+88KlZNNLOIm2DdqGH+4+ZuHLP9XUHctYTH3I53lf+8=;
        b=qXlJSeXS8ubK4FAzT8fLgFN9ZD3u2NyTmEjZrsUF4VSyVIFMFZSQbb27MKgTDTVhPH
         Vbnp3R5lCU+rSV84smwV/P5GEs1dWy2IAqFaqeyHfbTWyfQhHXDkfmxZ2fsAOcT0wt9n
         5omRV2seNR92AEfs0j8a41BGhsefYTB3OHm4UDyQRehb4xnl2odDwx9W3IaCN91g3tWe
         MHhTnodpnL8peJURrxQDSrKF08KtWZZ4rRDfPuURcYMYl5/78UxPxb7cxvFA8B8T2bg6
         Ojt4n2grs+fJiK07J0KMldANkNyWg8YUSHx8OUkKg9XNt1K5pPpfG+d+ToGsvPZZZsaK
         fKsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+88KlZNNLOIm2DdqGH+4+ZuHLP9XUHctYTH3I53lf+8=;
        b=WhVkbXxlZn7RtKTA5PCd+BZYmx76+uqTmI5dxCNY9oxeNri/dLXJvDSfvNymu3ZmH5
         uRNRfW8Dvd2rEXDoG1RkCbjxL3skgoxqZBLoyYKTprr14EphVyK/cvn02nXBYSTSx+Gy
         OZH1yO0Ota987VrCP2o3ueD/rZpAmVFdNi4O/N04ZFZL79y4PJseby7jkD/0+B/SBkXC
         1WKcljM3A+rcXg2iDsrOzd+WmBsIa9YTm3HvacRu2Hc0I/ld4TsJTPxgkdpJp7PbBDL8
         zlttF/tt2KMBEzdOHJoeQX4IdID97QBIphkrGv1oaOQq++c8g1HEeJlOOhfnlPiUZjuv
         L3hg==
X-Gm-Message-State: AOAM532pdealE+LriO90QPtCHb08VWqTuhdKEGUKsxqqB/MWxODtShRf
        iFJ2ywoEGwhv/GKDAEvfap2lPECnotPcsg==
X-Google-Smtp-Source: ABdhPJxTiDHHiOn2vzTtLIolscc0obkiPhBZ9KyokX2MSHtthkSnk0yEo9O5omdr8fNfNdqZg/qBPQ==
X-Received: by 2002:a5d:48ca:: with SMTP id p10mr921119wrs.87.1625160434440;
        Thu, 01 Jul 2021 10:27:14 -0700 (PDT)
Received: from ziggy.stardust ([213.195.127.100])
        by smtp.gmail.com with ESMTPSA id z6sm542191wrh.67.2021.07.01.10.27.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Jul 2021 10:27:13 -0700 (PDT)
Subject: Re: [RESEND PATCH 0/3] Misc bug fixes in mtk power domain driver
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        linux-kernel@vger.kernel.org
Cc:     linux-mediatek@lists.infradead.org, drinkcat@chromium.org,
        hsinyi@chromium.org, Collabora Kernel ML <kernel@collabora.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20210701094024.1273759-1-enric.balletbo@collabora.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <736b909d-ed43-3691-6e93-e7f025a04833@gmail.com>
Date:   Thu, 1 Jul 2021 19:27:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210701094024.1273759-1-enric.balletbo@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 01/07/2021 11:40, Enric Balletbo i Serra wrote:
> 
> This series, originally sent by Bilal Wasim [1], initially broke my
> display in mainline (no gpu driver). The problem was not in the series
> itself, and, after [2], this series works as expected. I was able to go
> to the UI with and without the imgtec gpu driver on my Acer Chromebook
> R13 (elm). Hence I rebased on top of mainline and resend it to take into
> account for next merge window.
> 

Whole series pushed to v5.14-tmp/soc

Thanks!

> Best regards,
>   Enric
> 
> [1] https://yhbt.net/lore/all/20210216165926.46bbafc7@a-VirtualBox/T/
> [2] https://patchwork.kernel.org/project/linux-mediatek/patch/20210625062448.3462177-1-enric.balletbo@collabora.com/
> 
> 
> Bilal Wasim (3):
>   soc: mediatek: pm-domains: Use correct mask for bus_prot_clr
>   soc: mediatek: pm-domains: Add domain_supply cap for mfg_async PD
>   arm64: dts: mediatek: mt8173: Add domain supply for mfg_async
> 
>  arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi | 4 ++++
>  arch/arm64/boot/dts/mediatek/mt8173-evb.dts  | 4 ++++
>  arch/arm64/boot/dts/mediatek/mt8173.dtsi     | 2 +-
>  drivers/soc/mediatek/mt8173-pm-domains.h     | 1 +
>  drivers/soc/mediatek/mtk-pm-domains.h        | 2 +-
>  5 files changed, 11 insertions(+), 2 deletions(-)
> 
