Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9BB23BF78A
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jul 2021 11:26:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231299AbhGHJ2w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jul 2021 05:28:52 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:34608 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231254AbhGHJ2w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jul 2021 05:28:52 -0400
Received: from mail-wm1-f70.google.com ([209.85.128.70])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1m1QIL-0006Bt-77
        for linux-kernel@vger.kernel.org; Thu, 08 Jul 2021 09:26:09 +0000
Received: by mail-wm1-f70.google.com with SMTP id j141-20020a1c23930000b0290212502cb19aso2147309wmj.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jul 2021 02:26:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=koIPrhzeeGnASWujJpf7LVgsTrCU+gcQgVFV1kcN3ho=;
        b=eQh/ONHdvAW8lPa4eT8Jm7GRa+xvGC8NsAil6bCU09DVmmg4H3PV6qn9koPCr74V6y
         t8mHl5BB8OecWn9lMDTVA66ArPTQMNf2bljgwiXmSB+5SQbbnkOqvvrTfr1LEhkyj05W
         lmz5IeaNFiZud5Ba8rr6TLo1zrOyuTwY0XXJGyC79PltynckIhOV0TzJSUPqwT2MwGRU
         8xougpm3DlAXnfzjbu9dGhgt22wHQNd6GzUFc4otZZDqoKAzms8f5eOKaraBe+RZnpbL
         A7KnJdA13zUIqzxZmwNHlitGssO+bd/HOn/24uatKaiTpK/LatgiaZJNVgaIsoO9i0oa
         7osQ==
X-Gm-Message-State: AOAM5313eLi8pjlxYnueeDL/A+x+jRSd14E2MoKsDx7fG9a14p3bXywF
        6ba+9gOEZ4jzb+L43o5QxfyxCQ8ta06sbCpoUVTn9sKu5CniVmoQKiFxx8E+4r9XDYBrfDLSpRP
        zzNllGgoTLJELj4SY1rn8s7XX6tlja9zajATvx73jow==
X-Received: by 2002:a05:6000:1ac6:: with SMTP id i6mr29153775wry.327.1625736368926;
        Thu, 08 Jul 2021 02:26:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz9bTjhzy4ewOg0e87DpVaZF42E3AYLNFYRiKycIX46b0OEGS9rxawBZpCgOiwlhnyBj7S+/Q==
X-Received: by 2002:a05:6000:1ac6:: with SMTP id i6mr29153760wry.327.1625736368771;
        Thu, 08 Jul 2021 02:26:08 -0700 (PDT)
Received: from [192.168.3.211] (xdsl-188-155-177-222.adslplus.ch. [188.155.177.222])
        by smtp.gmail.com with ESMTPSA id h10sm4020332wmb.46.2021.07.08.02.26.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Jul 2021 02:26:08 -0700 (PDT)
Subject: Re: [PATCH 1/9] dt-bindings: memory: mediatek: Add mt8195 smi binding
To:     Yong Wu <yong.wu@mediatek.com>, Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Tomasz Figa <tfiga@chromium.org>,
        linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, youlin.pei@mediatek.com,
        anan.sun@mediatek.com, ming-fan.chen@mediatek.com,
        yi.kuo@mediatek.com, anthony.huang@mediatek.com
References: <20210616114346.18812-1-yong.wu@mediatek.com>
 <20210616114346.18812-2-yong.wu@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <6e512d15-3acc-2097-1fd1-e021552fdc8d@canonical.com>
Date:   Thu, 8 Jul 2021 11:26:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210616114346.18812-2-yong.wu@mediatek.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/06/2021 13:43, Yong Wu wrote:
> This patch adds mt8195 smi supporting in the bindings.
> 
> In mt8195, there are two smi-common HW, one is for vdo(video output),
> the other is for vpp(video processing pipe). They connects with different
> smi-larbs, then some setting(bus_sel) is different. Differentiate them
> with the compatible string.
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
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> ---
>  .../bindings/memory-controllers/mediatek,smi-common.yaml    | 6 +++++-
>  .../bindings/memory-controllers/mediatek,smi-larb.yaml      | 3 +++
>  2 files changed, 8 insertions(+), 1 deletion(-)
> 

I cannot find it on devicetree list, it seems you did not Cc it. Please
use scripts/get_maintainer.pl.


Best regards,
Krzysztof
