Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C11835516A
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 12:58:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245276AbhDFK6o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 06:58:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234101AbhDFK6m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 06:58:42 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1F34C06174A;
        Tue,  6 Apr 2021 03:58:33 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id t24so3641061pjw.4;
        Tue, 06 Apr 2021 03:58:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3IuYdRBsCZ+Y5lWM9na+Xuq5U89d/EyLy2gspRBPEb4=;
        b=FsziQaUOv1JbF7KynLcN+6pB3PVIbPFR+bGV752KNJ3skTa5AW8O1A9ap3zp78AEca
         5MdyCKup+QqoikJdNpxq0BTsB8fRLylzK6nXv2cGr4zBWn4lcJ1VJwIfGJ8/6CQnHyfi
         lRtVL4ogwkwT2qqEJc4+tjS8YjWDRPCE8QsUNy8rxl+uZRSV1Qkmnl0SIWNjUj4n/ZVK
         BPcnoI/flie4X0c1pMGU1DR9aWB7LchawUTu9pExkTUwTpLAttRxlNsFpFypW77kHTM6
         Vjfi7vJYoPjgPoh/xr9BzOBaRhY1vfsqmNQy20rZH26fqHj3xIZPfNFX3DlO6O45BJIc
         gdOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3IuYdRBsCZ+Y5lWM9na+Xuq5U89d/EyLy2gspRBPEb4=;
        b=Ep3xhLH/OAWynnfjzmr4DmhqRnp7EbbZQfRhUpuWfxIubA0lYscJqSGKTNeOjRsL55
         uXcBWK3IRruL/OTUvePaemGNbcREYIdLtDnLDJgX8sE8nmP66A535MaYRIQWkUSzumdi
         Y24ytaUnrCw2d9AI/kMHy0ZpzxlInj5H8/6a2+sefewKMltgw/6g5m0bd7NLri0kSojT
         hf2gGeI9EmvWyz9aFrTHH4WJnavuIpFdeQ4fb8IBD9XLp11PzRaymWIjv6tkAA2C5UQe
         d7eXxISm7WFSt8ByKmDbCURZxziZQWjbnplayzH7SjtVJi3KoOe9ig6seuj8YIMzk708
         94fQ==
X-Gm-Message-State: AOAM5332bAL4p7/bxpWkSbWSmaiJAt1/rB+/zQPDSz85vEtWg+uultHS
        wOt36VVUvXs1t3TlOlTktHc=
X-Google-Smtp-Source: ABdhPJxjVxXlX98oAykoBDIlIyV+I6TAUjpWJ6VdilYsvNOBpM5pg6/IPv7OlHUAQlBWx9FT+L7Nqg==
X-Received: by 2002:a17:902:d706:b029:e6:90aa:24e0 with SMTP id w6-20020a170902d706b02900e690aa24e0mr28592949ply.42.1617706713246;
        Tue, 06 Apr 2021 03:58:33 -0700 (PDT)
Received: from ziggy.stardust ([213.195.126.134])
        by smtp.gmail.com with ESMTPSA id q2sm1630689pfk.143.2021.04.06.03.58.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Apr 2021 03:58:32 -0700 (PDT)
Subject: Re: [PATCH v2 1/2] dt-bindings: mediatek: mmsys: add mt8167 binding
To:     Fabien Parent <fparent@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     mkorpershoek@baylibre.com, Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20210405200354.2194930-1-fparent@baylibre.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <10e5739f-dfdf-d734-57a6-2b46e5d15220@gmail.com>
Date:   Tue, 6 Apr 2021 12:58:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210405200354.2194930-1-fparent@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 05/04/2021 22:03, Fabien Parent wrote:
> Add binding documentation for MT8167 SoC.
> 
> Signed-off-by: Fabien Parent <fparent@baylibre.com>
> Reviewed-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>
> Acked-by: Rob Herring <robh@kernel.org>

Applied both patches to v5.12-next/soc-2

Thanks!

> ---
> V2: Rebased + fix typo in commit message.
> 
>  .../devicetree/bindings/arm/mediatek/mediatek,mmsys.txt          | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.txt b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.txt
> index d8c9108c3b4a..78c50733985c 100644
> --- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.txt
> +++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.txt
> @@ -13,6 +13,7 @@ Required Properties:
>  	- "mediatek,mt6779-mmsys", "syscon"
>  	- "mediatek,mt6797-mmsys", "syscon"
>  	- "mediatek,mt7623-mmsys", "mediatek,mt2701-mmsys", "syscon"
> +	- "mediatek,mt8167-mmsys", "syscon"
>  	- "mediatek,mt8173-mmsys", "syscon"
>  	- "mediatek,mt8183-mmsys", "syscon"
>  - #clock-cells: Must be 1
> 
