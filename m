Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D30193B7D5C
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jun 2021 08:27:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232454AbhF3G3p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Jun 2021 02:29:45 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:55753 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232018AbhF3G3o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jun 2021 02:29:44 -0400
Received: from mail-ed1-f70.google.com ([209.85.208.70])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lyTgo-0007FV-IG
        for linux-kernel@vger.kernel.org; Wed, 30 Jun 2021 06:27:14 +0000
Received: by mail-ed1-f70.google.com with SMTP id y17-20020a0564023591b02903951740fab5so577122edc.23
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jun 2021 23:27:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2nkD+uJbpxO3bUeNVNJ06+nPXq3al3hbepVix2nCh4U=;
        b=L7rs+0KHRHqSuMYex5lqYZkvgZ16JYE/kw2HS0LchMR+pylBd20jy9P9p1d5RDjceF
         k/kGWmCWDRfsJ39DjGj5coOTTC1AmEKnHe3qVhBqUV1ua/TOfY2rOFicUW4045Evdl6h
         kQM5yC9SdUd1nL/yIzXu2jeyr7VwCgO0zHOujvj6BHBeSnYcGJKZY9te9cIU5CwpHsVR
         Etv2LeYCL7vqUS/+7tbbsupD2Iv04PDmDwhZD9b4CQd4Bqm7PTe15sSNUKjtWdWtCEw9
         qfDnJ0K6NM9bzREPRktFVEHxy5uVEqyqgWd+8hGj8mchh/hDPYFakAiI8w9oSxY9iNlC
         WZIw==
X-Gm-Message-State: AOAM533ssUCFbPIhcFQsP4uPRdo0PqjrUTYgVPF6x5Oi4c6pau2BlX3A
        /YP6e8EqFBoSy4+PSPxos6SqVjmhIskgZVVtRoiX4QE39ZIhXQoWMo5jACe92hIZ8f9hoZ4F90d
        H++cbTturFTgC50mS3Lmii9hYbCJOjDBkRr/kjJnrnw==
X-Received: by 2002:a05:6402:10c3:: with SMTP id p3mr42666255edu.175.1625034434318;
        Tue, 29 Jun 2021 23:27:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxHQKqehToed8G/oeR4lBx7PzBHYBfu1zFW0rHyBt6DYz2r1CNwHTzMzCDFt1S6Up8CIq2JSA==
X-Received: by 2002:a05:6402:10c3:: with SMTP id p3mr42666243edu.175.1625034434224;
        Tue, 29 Jun 2021 23:27:14 -0700 (PDT)
Received: from [192.168.1.115] (xdsl-188-155-177-222.adslplus.ch. [188.155.177.222])
        by smtp.gmail.com with ESMTPSA id g8sm2791773edv.84.2021.06.29.23.27.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Jun 2021 23:27:13 -0700 (PDT)
Subject: Re: [PATCH 02/24] dt-bindings: mediatek: mt8195: Add binding for
 infra IOMMU
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
 <20210630023504.18177-3-yong.wu@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <24f3e157-da9c-d353-e5ae-5dac9e7d9c1d@canonical.com>
Date:   Wed, 30 Jun 2021 08:27:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210630023504.18177-3-yong.wu@mediatek.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/06/2021 04:34, Yong Wu wrote:
> In mt8195, we have a new IOMMU that is for INFRA IOMMU. its masters
> mainly are PCIe and USB. Different with MM IOMMU, all these masters
> connect with IOMMU directly, there is no mediatek,larbs property for
> infra IOMMU.
> 
> Another thing is about PCIe ports. currently the function
> "of_iommu_configure_dev_id" only support the id number is 1, But our
> PCIe have two ports, one is for reading and the other is for writing.
> see more about the PCIe patch in this patchset. Thus, I only list
> the reading id here and add the other id in our driver.
> 
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> ---
>  .../bindings/iommu/mediatek,iommu.yaml         | 14 +++++++++++++-
>  .../dt-bindings/memory/mt8195-memory-port.h    | 18 ++++++++++++++++++
>  include/dt-bindings/memory/mtk-memory-port.h   |  2 ++
>  3 files changed, 33 insertions(+), 1 deletion(-)
> 


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>


Best regards,
Krzysztof
