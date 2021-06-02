Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6B64398924
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 14:15:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229682AbhFBMRM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 08:17:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbhFBMRK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 08:17:10 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A36B8C061574
        for <linux-kernel@vger.kernel.org>; Wed,  2 Jun 2021 05:15:27 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id p13-20020a05600c358db029019f44afc845so1534845wmq.3
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jun 2021 05:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=NYQ0DBLeg82xJUk7GJVvs66y68mmqwOYU+5W+gTFjjU=;
        b=nT3mPDXaI76rhaGbXrGdOF2tQTVladAr1KfGrc6uARYU2qTKkYje3ge+Tfi3E4pUZJ
         5g7iayiriAI25OE++iuDiMSkDgYDj0gPG7swtdaRbKRlhKKSMRTaHOKOaJUkv7r1hXeS
         Qr+6WZN7wFevagpQDD5PRn/0+R9csUoEUYy+TnZcOD5+CqVe4YfCXvNlg2Zau2XUAwPU
         WfGbPzGGUXE7iBVoyRrL6i7hXprG9zdldXpCuU8Hhv/+UqvAG/K5FKL5bX9ZbMtIACOC
         /8zVk4WuevEtH0CEEe/HJMObpZwEBsEgIOYX5MZvj9Y56XwE3MMs1GCQ0yfUmNMZ8Xtn
         tEpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NYQ0DBLeg82xJUk7GJVvs66y68mmqwOYU+5W+gTFjjU=;
        b=F2JgDka6bY0EyK/BDnQskHsAMnc2XVqTrsEpOcwo5srUASgxcBhucVW1xER/YFj3z0
         /egoiQxqSy2nUXpZqnJlaKsaQk9r6DJPprvPEf+RyqtGGI32u91mEh3lsf0W9Pvad8Yc
         +BIEugCO/sJ63HErcvhU3c+S1vrVDCm+h5ew4v0l1tVKfyrNRVtiobN6BVvfTAMgTsgV
         ysJuvdkbPxIXtIc6xu+AELK1PzGeZS+XxVfy7VcU+GLC812AE/BgGz4vBC5q6z71YBi4
         Z/tem2OHp6aAFQdzBa3+SWzKRh8lWxC/+ixRN2TO5DG7h6XE4BJgAUymbfG1d/EW/hyA
         yzGQ==
X-Gm-Message-State: AOAM533fOTHTw3cUroELark3wTn+usT+aRzgLc2/wl3hhlMphGJNS90p
        Yk+4FNAwIXfyTyw2dzYy7TE=
X-Google-Smtp-Source: ABdhPJz9eiapwoSn11oUlnVhy+ovN96PWpChVj0Xk0ODghVf8PkV+hJjYAeeRSAVAkfUmKtepo/oVg==
X-Received: by 2002:a05:600c:2cd2:: with SMTP id l18mr31359961wmc.142.1622636126300;
        Wed, 02 Jun 2021 05:15:26 -0700 (PDT)
Received: from ziggy.stardust ([37.223.145.68])
        by smtp.gmail.com with ESMTPSA id d3sm6341225wrs.41.2021.06.02.05.15.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Jun 2021 05:15:25 -0700 (PDT)
Subject: Re: [PATCH v2 3/3] arm64: dts: mt8183: remove syscon from smi_common
 node
To:     Hsin-Yi Wang <hsinyi@chromium.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        chun-jie.chen@mediatek.corp-partner.google.com,
        Yong Wu <yong.wu@mediatek.com>
References: <20210601040014.2970805-1-hsinyi@chromium.org>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <27c155d4-6198-08f3-9972-1a8da1a026ba@gmail.com>
Date:   Wed, 2 Jun 2021 14:15:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210601040014.2970805-1-hsinyi@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 01/06/2021 06:00, Hsin-Yi Wang wrote:
> We don't need to register smi_common as syscon. Also add required
> property power-domains for this node.
> 
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> Reviewed-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

Applied to v5.13-next/dts64

Thanks!

> ---
>  arch/arm64/boot/dts/mediatek/mt8183.dtsi | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8183.dtsi b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> index c5e822b6b77a..e074c0d402ff 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> @@ -1263,13 +1263,14 @@ larb0: larb@14017000 {
>  		};
>  
>  		smi_common: smi@14019000 {
> -			compatible = "mediatek,mt8183-smi-common", "syscon";
> +			compatible = "mediatek,mt8183-smi-common";
>  			reg = <0 0x14019000 0 0x1000>;
>  			clocks = <&mmsys CLK_MM_SMI_COMMON>,
>  				 <&mmsys CLK_MM_SMI_COMMON>,
>  				 <&mmsys CLK_MM_GALS_COMM0>,
>  				 <&mmsys CLK_MM_GALS_COMM1>;
>  			clock-names = "apb", "smi", "gals0", "gals1";
> +			power-domains = <&spm MT8183_POWER_DOMAIN_DISP>;
>  		};
>  
>  		imgsys: syscon@15020000 {
> 
