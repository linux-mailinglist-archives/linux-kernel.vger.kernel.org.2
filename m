Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CE9D3FFDE4
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 12:06:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349051AbhICKHS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 06:07:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232273AbhICKHQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 06:07:16 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D53B6C061575;
        Fri,  3 Sep 2021 03:06:16 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id t15so7439221wrg.7;
        Fri, 03 Sep 2021 03:06:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=iNmWH11IfHfGgA+hr1tDCMgJNkp9fxHtUXct3dWs0WM=;
        b=ghnwOsqiqgmNVkfIqwYH+BiPPQa3gWVNLTPl6O3BMJ4jV054Ys+am8yP0fWf1sUuqf
         hD+XOJ5cJrJeifs8GFp1wprFn3k6erFwWINEs8X7y3BmwmIYLjG5qdMyU3SmHVyf8uwk
         GxIH1h1X6oOHU377BbwgpSWOomBiD98heFDH6Tnws8/7Tlmg2jjVqJAB9nyomBvMMvBL
         7gFQYwwfC5fJkNkSvk8ZtkJzeHfJo9LTzaRCQqIBUPJAEOL84N3i+BYtg1rceqM/KwMB
         4Y82A3UJnIE+BR5QZcCnzoDpl9HBcJUaIKq2nkScqnVudyvoz3ugr+MbG1TgjyeMynR6
         qcIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=iNmWH11IfHfGgA+hr1tDCMgJNkp9fxHtUXct3dWs0WM=;
        b=EwBWYuT4QtGfLiVddexPIObJDKroDj6XD4NAc7qVHxnHH0oWBWGFv74iJ+laeKvF1m
         LLVBiGwevwhuGV/0S3UXOSAuBm5qrAOQh+1ohE3u5BjpNXEkRpjcRUTveM9sEQH0MA26
         azZQeCsOIOv+MfRsWQ3eYhYsuBpNIqvd/S/Hi8RIrKwAWNaoENkpk+oySQFuf9/UzRMi
         1HP/HFJK5y/wVpOLI+E3CfgrSLWRXRMXY8ygkOxA2ZMr2+WWaD/rXHJY18H6xUfyNdwf
         8WmAAWpIB7MlvxksYr9IHV85l+Tf719uEp+buq0wOb6Swzzzc580bHtxJ7lNmguv/44H
         FiLw==
X-Gm-Message-State: AOAM533fNtTDX+zUqjhDJz59w3+ZGLt48WoI59xLbZM1Ix9XH+Jb1By0
        F7rWIw7yku2JSQuIuediiZelqxaFFM0=
X-Google-Smtp-Source: ABdhPJwlJP8tBN1TuNmAVwZFdWKz9KdIFxPvHfw+0UDerVYp2oCZxX73DeyPcYhLhTflLW+0x4R1wQ==
X-Received: by 2002:adf:b748:: with SMTP id n8mr3069436wre.133.1630663575285;
        Fri, 03 Sep 2021 03:06:15 -0700 (PDT)
Received: from ziggy.stardust ([37.223.140.66])
        by smtp.gmail.com with ESMTPSA id d9sm4176444wrm.21.2021.09.03.03.06.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Sep 2021 03:06:14 -0700 (PDT)
Subject: Re: [PATCH v5 2/2] arm64: dts: mt8192: add eFuse support for MT8192
 SoC
To:     Yz.Wu@mediatek.com,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Seiya Wang <seiya.wang@mediatek.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Tzung-Bi Shih <tzungbi@google.com>
References: <1618384669-30070-1-git-send-email-Yz.Wu@mediatek.com>
 <1618384669-30070-3-git-send-email-Yz.Wu@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <048c7ac6-e91b-14ce-17e7-a291df2763b4@gmail.com>
Date:   Fri, 3 Sep 2021 12:06:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <1618384669-30070-3-git-send-email-Yz.Wu@mediatek.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 14/04/2021 09:17, Yz.Wu@mediatek.com wrote:
> From: Ryan Wu <Yz.Wu@mediatek.com>
> 
> Add eFuse node to read Mediatek eFuse
> 
> Signed-off-by: Ryan Wu <Yz.Wu@mediatek.com>
> ---
> This patch dependents on "arm64: dts: Add Mediatek SoC MT8192 and evaluation board dts and Makefile"[1]
> 
> mt8192.dtsi file is needed for this patch.
> Please also accept this patch together with [1].
> 
> [1]http://lists.infradead.org/pipermail/linux-mediatek/2020-November/019378.html
> ---
>  arch/arm64/boot/dts/mediatek/mt8192.dtsi | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8192.dtsi b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> index 9757138..4d4e4de 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> @@ -436,6 +436,11 @@
>  			status = "disable";
>  		};
>  
> +		efuse: efuse@11c10000 {
> +				compatible = "mediatek,mt8192-efuse",
> +							 "mediatek,efuse";

Please fix identation.
Binding description mandates a reg property, please help to make the patch
better by adding that property.

Thanks a lot,
Matthias

> +		};
> +
>  		i2c3: i2c3@11cb0000 {
>  			compatible = "mediatek,mt8192-i2c";
>  			reg = <0 0x11cb0000 0 0x1000>,
> 
