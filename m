Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64DD335E0E8
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 16:05:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346227AbhDMOFG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 10:05:06 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:56462 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241172AbhDMOFD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 10:05:03 -0400
Received: from mail-ed1-f71.google.com ([209.85.208.71])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lWJel-0001R5-0l
        for linux-kernel@vger.kernel.org; Tue, 13 Apr 2021 14:04:43 +0000
Received: by mail-ed1-f71.google.com with SMTP id o4-20020a0564024384b0290378d45ecf57so1337171edc.12
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 07:04:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1zoVtByllhosC8xnCO3YIKw2vthWTwQhfS+DihX0pa4=;
        b=ulesEH/Pb3aPZZQfiTqdclFu/cBl4ftjyyGl5k/t/r8flzMIhgzdIXIzWlJ7Wm/RWn
         xcnlUGfMN4yc/Bz0kr2/yYepOcxCaFdH/RbjtbsVoYbGnCywy6AJQTZAq2fq6oIOsRem
         GoioO5aNqzk4u68tTLwBO5ssYG4hLt2FqFgho//P5/o0zVSobWM9rteKSWwKW845H9mp
         N6TYdS9M+fH6wf6qkm/fvG9CMhTa0N5YnPiWhsViSx1iW4GiBfjn7StaV1n+kwSa42tP
         ickbn/YBd8623qyDyiS0LGQbmW3kc6rTxF5ciODAM8yRFhCQZeGgg3CLT0US68CM49Xz
         Uw2A==
X-Gm-Message-State: AOAM533013bfIqXOwSgOqqYFDdNWWyN1YinxJo2T5o2miirrFkQ1wtlq
        fLrVkXybLILdnaacUgjjDv8IrjAmsxqRJFnd/o1ebaUQLb2gDgOzpWqGZlDoW/jN9QrsGa3WadQ
        s9a70iix46ZZYi/AZESRm6S+Xi4ouTAD4ZyF+pYLpoA==
X-Received: by 2002:a05:6402:142:: with SMTP id s2mr34982246edu.2.1618322671987;
        Tue, 13 Apr 2021 07:04:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJytwQzQE5BkozQ2VOreQSdkoAGEAaqvJ0FgXGTACKHn/MAUy6h5uirgVHlAcudl2n8kdm1F6w==
X-Received: by 2002:a05:6402:142:: with SMTP id s2mr34982231edu.2.1618322671878;
        Tue, 13 Apr 2021 07:04:31 -0700 (PDT)
Received: from [192.168.1.115] (xdsl-188-155-192-147.adslplus.ch. [188.155.192.147])
        by smtp.gmail.com with ESMTPSA id n17sm9379838edq.32.2021.04.13.07.04.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Apr 2021 07:04:31 -0700 (PDT)
Subject: Re: [PATCH v5 14/16] memory: mtk-smi: Get rid of mtk_smi_larb_get/put
To:     Yong Wu <yong.wu@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Joerg Roedel <joro@8bytes.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Evan Green <evgreen@chromium.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Tomasz Figa <tfiga@chromium.org>,
        Will Deacon <will.deacon@arm.com>,
        linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, youlin.pei@mediatek.com,
        Nicolas Boichat <drinkcat@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>, anan.sun@mediatek.com,
        chao.hao@mediatek.com, ming-fan.chen@mediatek.com,
        yi.kuo@mediatek.com, eizan@chromium.org, acourbot@chromium.org
References: <20210410091128.31823-1-yong.wu@mediatek.com>
 <20210410091128.31823-15-yong.wu@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <b015fd4a-f05b-5dc7-f23e-e517d40aeb21@canonical.com>
Date:   Tue, 13 Apr 2021 16:04:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210410091128.31823-15-yong.wu@mediatek.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/04/2021 11:11, Yong Wu wrote:
> After adding device_link between the iommu consumer and smi-larb,
> the pm_runtime_get(_sync) of smi-larb and smi-common will be called
> automatically. we can get rid of mtk_smi_larb_get/put.
> 
> CC: Matthias Brugger <matthias.bgg@gmail.com>
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> Reviewed-by: Evan Green <evgreen@chromium.org>
> ---
>  drivers/memory/mtk-smi.c   | 14 --------------
>  include/soc/mediatek/smi.h | 20 --------------------
>  2 files changed, 34 deletions(-)
> 


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>


Best regards,
Krzysztof
