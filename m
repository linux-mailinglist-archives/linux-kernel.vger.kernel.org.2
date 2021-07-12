Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA5083C652F
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jul 2021 22:53:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234106AbhGLU4f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jul 2021 16:56:35 -0400
Received: from mail-io1-f45.google.com ([209.85.166.45]:46997 "EHLO
        mail-io1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231289AbhGLU4e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jul 2021 16:56:34 -0400
Received: by mail-io1-f45.google.com with SMTP id y8so24393382iop.13;
        Mon, 12 Jul 2021 13:53:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=eOVn4hA3XcLo5hvPVvRyEd7iIojIzdMm8LtEmlSR/84=;
        b=LVV5oXU2wLKekxL2QdZ+DpNSItihFUKbZnLc72mWJ2te8SzetDv9DYbk95KVCZZqvf
         A7lolJXm6pgymCmKaTcMxeIG5x+1UgPfniepC0IeJhxjApgIhRKKuWpQz0Unq1Ko3f8N
         fvgDcLyysJphp4G6Qn0dxqwcR6CLL/9h/CCX7AcBJ+4TIQrPDl7Q59PqhLFHRp+ruZK3
         /Hhp6tDRGlucHa5yXBppFIEiE/iJgKXZIBMljyEV+Y27xIKoODlCN9yg9WoYhrS6Qxje
         xd2Ux7joWgV63zyxomYOxwt95Dgy9y0G5mJ2ZY8BRpgpx4xpLpzgQSg39Z7IjB5cZBnW
         yXyg==
X-Gm-Message-State: AOAM533aBSG1VwJ7iHkSu76FluXPQxBozQlcmQjJLjrz02EPP/yPFGvW
        IveyRA5f0+CYzE5TAwKKWA==
X-Google-Smtp-Source: ABdhPJwqUa1CfxBrMOnwHB9uXjwz2JDz1H24g3dCOBUO4TodIeDiOydJJgS7BjTQhNPzdcVFfMPYgg==
X-Received: by 2002:a02:380c:: with SMTP id b12mr786194jaa.68.1626123224639;
        Mon, 12 Jul 2021 13:53:44 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id g1sm8309471ile.35.2021.07.12.13.53.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jul 2021 13:53:43 -0700 (PDT)
Received: (nullmailer pid 2473956 invoked by uid 1000);
        Mon, 12 Jul 2021 20:53:42 -0000
Date:   Mon, 12 Jul 2021 14:53:42 -0600
From:   Rob Herring <robh@kernel.org>
To:     kewei.xu@mediatek.com
Cc:     wsa@the-dreams.de, bbrezillon@kernel.org, matthias.bgg@gmail.com,
        mark.rutland@arm.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com,
        leilk.liu@mediatek.com, qii.wang@mediatek.com,
        liguo.zhang@mediatek.com, xinping.qian@mediatek.com,
        ot_daolong.zhu@mediatek.com
Subject: Re: [PATCH V3 2/3] dt-bindings: i2c: add attribute
 default-timing-adjust
Message-ID: <20210712205342.GA2469648@robh.at.kernel.org>
References: <1624271985-23591-1-git-send-email-kewei.xu@mediatek.com>
 <1624271985-23591-3-git-send-email-kewei.xu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1624271985-23591-3-git-send-email-kewei.xu@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 21, 2021 at 06:39:44PM +0800, kewei.xu@mediatek.com wrote:
> From: Kewei Xu <kewei.xu@mediatek.com>
> 
> Add attribute default-timing-adjust for DT-binding document.
> 
> Fixes: be5ce0e97cc7 ("i2c: mediatek: Add i2c ac-timing adjust support")

You want to fix a kernel change with a DT change? That's not a 
compatible change (and I guess neither was the kernel change). Sounds 
like the above commit should be reverted and rethink how to add a new 
feature...

> Signed-off-by: Kewei Xu <kewei.xu@mediatek.com>
> ---
>  Documentation/devicetree/bindings/i2c/i2c-mt65xx.txt | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/i2c/i2c-mt65xx.txt b/Documentation/devicetree/bindings/i2c/i2c-mt65xx.txt
> index 7c4915bc..7b80a11 100644
> --- a/Documentation/devicetree/bindings/i2c/i2c-mt65xx.txt
> +++ b/Documentation/devicetree/bindings/i2c/i2c-mt65xx.txt
> @@ -33,6 +33,8 @@ Optional properties:
>    - mediatek,have-pmic: platform can control i2c form special pmic side.
>      Only mt6589 and mt8135 support this feature.
>    - mediatek,use-push-pull: IO config use push-pull mode.
> +  - mediatek,default-timing-adjust: use default timing calculation, no timing
> +    adjustment.
>  
>  Example:
>  
> -- 
> 1.9.1
> 
> 
