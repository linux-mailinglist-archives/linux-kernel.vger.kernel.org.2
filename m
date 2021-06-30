Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BFAE3B7D5A
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jun 2021 08:26:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232307AbhF3G3J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Jun 2021 02:29:09 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:55718 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232018AbhF3G3F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jun 2021 02:29:05 -0400
Received: from mail-ej1-f71.google.com ([209.85.218.71])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lyTgA-00079o-VM
        for linux-kernel@vger.kernel.org; Wed, 30 Jun 2021 06:26:35 +0000
Received: by mail-ej1-f71.google.com with SMTP id 16-20020a1709063010b029037417ca2d43so368129ejz.5
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jun 2021 23:26:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=eyemzYiirXr0CnEJTypFgf/3fRZK1QJimxbVNA34t0g=;
        b=f5gwiHcZVdn6SPMJpuyhxQyTHiG0p2rjsTV8iJTvfY+WeaW8alx28zs3git+XJolwq
         tbvlC2vmhyJ2O4R+6ydXmGjEHSgIUSCf5s3GYv3UZzoPeUwzoZveZkanMyyB/ajSmHDL
         f/1XCtAzgGO4WbcPsnNauyaGWWSgo326bKqOcdF7eaGDJJpc5yZcQE/UBNzeKCV/6Uzl
         MMOTX3XGvMWW/rFnukGAIi0z28VnQ/xbUf1XZBnJHTZuJi4LqdjvBNGNguVxCpvu1OBp
         C4FVUgwQc3eXRTCUn9JKjfrQqfYcowLEpJASev6Rt4TuM9vEygL9do/trRTiOchb5gY3
         ls7Q==
X-Gm-Message-State: AOAM533ei/zBGU+7QBhSvHGRYhDQoDhrPPllfzfGvqxOw5Zc5bj9ZVR5
        0ti8XKIemIfaHx5qRPVKQV5RnyiAQ2uXrF6DyRWLzKO5GzquM2msGTcdHVwoGBT3JsqfcWyoFKd
        8iqykjBolBb/q2a2NADd5GIQeftyZLg7WadK8Cyj7HA==
X-Received: by 2002:aa7:cd13:: with SMTP id b19mr3967838edw.45.1625034394739;
        Tue, 29 Jun 2021 23:26:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwFojo25I4HBBB+CxEut1LzXiJF0o/oIA/Lz3C0qxx65dhOyBiZgSqkJ1gbWex0mUY7C8o8FQ==
X-Received: by 2002:aa7:cd13:: with SMTP id b19mr3967821edw.45.1625034394573;
        Tue, 29 Jun 2021 23:26:34 -0700 (PDT)
Received: from [192.168.1.115] (xdsl-188-155-177-222.adslplus.ch. [188.155.177.222])
        by smtp.gmail.com with ESMTPSA id c14sm2792126edr.27.2021.06.29.23.26.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Jun 2021 23:26:34 -0700 (PDT)
Subject: Re: [PATCH 01/24] dt-bindings: mediatek: mt8195: Add binding for MM
 IOMMU
To:     Yong Wu <yong.wu@mediatek.com>, Joerg Roedel <joro@8bytes.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     Evan Green <evgreen@chromium.org>, Tomasz Figa <tfiga@google.com>,
        Tomasz Figa <tfiga@chromium.org>,
        linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, youlin.pei@mediatek.com,
        Nicolas Boichat <drinkcat@chromium.org>, anan.sun@mediatek.com,
        chao.hao@mediatek.com
References: <20210630023504.18177-1-yong.wu@mediatek.com>
 <20210630023504.18177-2-yong.wu@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <41809d87-0f1b-13fd-b565-26a17626aad9@canonical.com>
Date:   Wed, 30 Jun 2021 08:26:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210630023504.18177-2-yong.wu@mediatek.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/06/2021 04:34, Yong Wu wrote:
> This patch adds descriptions for mt8195 IOMMU which also use ARM
> Short-Descriptor translation table format.
> 
> In mt8195, there are two smi-common HW and IOMMU, one is for vdo(video
> output), the other is for vpp(video processing pipe). They connects
> with different smi-larbs, then some setting(larbid_remap) is different.
> Differentiate them with the compatible string.
> 
> Something like this:
> 
>     IOMMU(VDO)          IOMMU(VPP)
>        |                   |
>   SMI_COMMON_VDO      SMI_COMMON_VPP
>   ---------------     ----------------
>   |      |   ...      |      |     ...
> larb0 larb2  ...    larb1 larb3    ...
> 
> Another change is that we have a new IOMMU that is for infra master like
> PCIe and USB. The infra master don't have the larb and ports, thus we
> rename the port header file to mt8195-memory-port.h rather than
> mt8195-larb-port.h.
> 
> Also, the IOMMU is not only for MM, thus, we don't call it "m4u" which
> means "MultiMedia Memory Management UNIT". thus, use the "iommu" as the
> compatiable string.
> 
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> ---
>  .../bindings/iommu/mediatek,iommu.yaml        |   7 +
>  .../dt-bindings/memory/mt8195-memory-port.h   | 390 ++++++++++++++++++
>  2 files changed, 397 insertions(+)
>  create mode 100644 include/dt-bindings/memory/mt8195-memory-port.h
> 

I understand this will go through IOMMU tree. Do you know about any
further patches for memory controllers which will need the header?

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>


Best regards,
Krzysztof
