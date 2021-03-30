Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3622634E363
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 10:42:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231553AbhC3ImU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 04:42:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231154AbhC3ImE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 04:42:04 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BD99C061762;
        Tue, 30 Mar 2021 01:42:04 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id m20-20020a7bcb940000b029010cab7e5a9fso9812891wmi.3;
        Tue, 30 Mar 2021 01:42:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=krsQLivBerECO2Nqnyy+OB10H1EDkhWoiyrKaCeb8Lg=;
        b=oiNBDmPzq3Y8fePN7nMQ7AdgARgd2zgHYC8Ssu+rZLzCWiorRcFC+SCUNsS/6bFO2R
         Fqhv/f0Yqr4jtU3zrQvvM208t/90Aq/yM2yzuYeSGYVugkImN1XgtIazsb9oXvEIallP
         LHA1XhdAlyru9GKMTcn38n+SL9uz9mh96qNuf4XW1RVd/GWiVQFoGqg32SSQqdPuXJs4
         VSIBP0SYFWDsdilp2V9Y7L+Q+t2THMCJTSFDVtVODcTbLuuKUofgu/LVRd8PEoE40750
         yG8iC4QAz9/thXCSPNf0V9svWo3QAdziFFCW3YxM3JNB/y8b3De0CxxZpj0SlMKxU3Wm
         ljjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=krsQLivBerECO2Nqnyy+OB10H1EDkhWoiyrKaCeb8Lg=;
        b=EDuFHzJWR7dst/gWZ5HWZDiN4cxmBRgOozgzHY6uz18gS7U6vCKHpAIWBWqpkqyhh8
         0PhGhZTAHmZ5GBCbeUqHfex3JKFdStrxIZMzAl+zDXyfiHhfLfmXkMUiJU1X+w0bk8FA
         qbQS6zZRSmnc00ruk4meJObim/RMwxWSqW8/2eRiOPXVNIKdmprJR1pDmf6RCFBAEKls
         J0Yv1ZW6bbXP+dFZypC+tj42AGtUl5bilRVdk7/Ug8lCdBU9rDBTMJq09XGjPE+A7e/Q
         ToqZFFwcp196QkuOa8q+KwERMm3CV6YsD+75jigfYBGpwpCeHtuKrxdk5quX5xuy+AFf
         PSng==
X-Gm-Message-State: AOAM530qrBLmDE2sqHlPKghtX1eJo6nTyrQIEMm9He2K0/UbjIzE+XXP
        j9DbDoJRHOCGsOr89hGakFw=
X-Google-Smtp-Source: ABdhPJxXscwjMq30pZb/7xvIHlD4sO8yvNnKjS1cmRihsXZaHln4EdWnmUPxzuVBmI+hb/+tVRybtQ==
X-Received: by 2002:a1c:b783:: with SMTP id h125mr2877539wmf.106.1617093723153;
        Tue, 30 Mar 2021 01:42:03 -0700 (PDT)
Received: from ziggy.stardust ([213.195.126.134])
        by smtp.gmail.com with ESMTPSA id c6sm32497708wri.32.2021.03.30.01.42.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Mar 2021 01:42:02 -0700 (PDT)
Subject: Re: [PATCH v4 1/2] dt-bindings: nvmem: mediatek: add support for
 MediaTek mt8192 SoC
To:     Yz.Wu@mediatek.com,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Seiya Wang <seiya.wang@mediatek.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>
References: <1612151986-19820-1-git-send-email-Yz.Wu@mediatek.com>
 <1612151986-19820-2-git-send-email-Yz.Wu@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <779f47d2-f735-aa78-c40c-8905cd9f65b9@gmail.com>
Date:   Tue, 30 Mar 2021 10:42:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <1612151986-19820-2-git-send-email-Yz.Wu@mediatek.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 01/02/2021 04:59, Yz.Wu@mediatek.com wrote:
> From: Ryan Wu <Yz.Wu@mediatek.com>
> 
> This updates dt-binding documentation for MediaTek mt8192
> 
> Signed-off-by: Ryan Wu <Yz.Wu@mediatek.com>

Applied to v5.12-next/dts64

Please resend the DTS patch with the comments I made.

> ---
> This patch is based on v5.10-rc7.
> ---
>  Documentation/devicetree/bindings/nvmem/mtk-efuse.txt | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/nvmem/mtk-efuse.txt b/Documentation/devicetree/bindings/nvmem/mtk-efuse.txt
> index 0668c45..82dafa3 100644
> --- a/Documentation/devicetree/bindings/nvmem/mtk-efuse.txt
> +++ b/Documentation/devicetree/bindings/nvmem/mtk-efuse.txt
> @@ -7,6 +7,7 @@ Required properties:
>  	      "mediatek,mt7622-efuse", "mediatek,efuse": for MT7622
>  	      "mediatek,mt7623-efuse", "mediatek,efuse": for MT7623
>  	      "mediatek,mt8173-efuse" or "mediatek,efuse": for MT8173
> +	      "mediatek,mt8192-efuse", "mediatek,efuse": for MT8192
>  - reg: Should contain registers location and length
>  
>  = Data cells =
> 
