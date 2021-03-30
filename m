Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAA6834E5C3
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 12:49:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231649AbhC3KtB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 06:49:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231561AbhC3Ksp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 06:48:45 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E0D8C061574;
        Tue, 30 Mar 2021 03:48:45 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id m20-20020a7bcb940000b029010cab7e5a9fso10029232wmi.3;
        Tue, 30 Mar 2021 03:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Q//pqem2+12d7QEjvjgaohlrsZ0f7RzdSyBP0d8mQF8=;
        b=XAAkVB7wU7qFKtSJlIbXEuV0fqSLgWmM7CgKkpyrJZrHMLETXXA0GIEtbJDfHnrIxa
         DnrA9/t+AGUEYEiHhrppYvAvUcj6TjuE8CVO0pcajCmO+v324od1o1qi2gphEOkIiHzZ
         kLEhzQRZh6e2vl8RSEjU0MXkRCltLjmubLh2ad1zSg64+wFfCYXOX3oy7FotQT6jKG9f
         Tkzk6idkrKaYy/z1NzZSKhwqossCXQ3/BsHyA/tCexS6cAus2ZG8rJvg3/H+mqcO5v/E
         zXcTeyYRpaytvboHZ09XiFGDw+afgcrmMZYlYgkcuWsm5HJm4H4PJh1xa4hLBZhHqXSk
         rDLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Q//pqem2+12d7QEjvjgaohlrsZ0f7RzdSyBP0d8mQF8=;
        b=OR9Qg6ULl8+6oQjdS14MtTsXUupBueTnu7D3lggLMsRtr6Q5H4gDWURWb+NbgfMaTt
         0QKwXwLNncOrW7qMsPEbEx5gMjkr0U3t0M7khiLnc6pstloewc9jyC2Y8Ljg8UwujKIH
         wTSZJduw9qWncUoqVZUsHaQMdHQocsQfpmLiyhs5wySU2Xi/CtArYiKttC9cVA/En1XF
         W8lr5EMpRUIdme7/BUQtwBSgbB+n5DNTruuro45eR6kHHF6bXb7oCtvQ7Iv4ThjmR4h6
         Yc2wFjYDnEn3KEDrLbFhVyhr+p9M+2SbMpL6vBp78sPHnHHEjF0ovkwCH3x41k/Ca9cM
         jqrg==
X-Gm-Message-State: AOAM5309NMi5e/iH0weDbfDgGf6piNMnb6ago07U7svOMMl691Vt7Izj
        Y7rePCdU24Ye582L/c/4Sr8=
X-Google-Smtp-Source: ABdhPJwvPii3xPnYowk2vyInsF26PMhunrL16Vuj5UvYFQF18+YD+34YeHDpiFXR6Zds8mztAtBjQg==
X-Received: by 2002:a7b:cf11:: with SMTP id l17mr3360588wmg.128.1617101323947;
        Tue, 30 Mar 2021 03:48:43 -0700 (PDT)
Received: from ziggy.stardust ([213.195.126.134])
        by smtp.gmail.com with ESMTPSA id p14sm2901836wmc.30.2021.03.30.03.48.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Mar 2021 03:48:43 -0700 (PDT)
Subject: Re: [PATCH v10 1/4] dt-bindings: mediatek: Add smi dts binding for
 Mediatek MT6765 SoC
To:     Macpaul Lin <macpaul.lin@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Wendell Lin <Wendell.Lin@mediatek.com>,
        Fabien Parent <fparent@baylibre.com>,
        Weiyi Lu <weiyi.lu@mediatek.com>,
        Mars Cheng <mars.cheng@mediatek.com>,
        Sean Wang <Sean.Wang@mediatek.com>,
        Owen Chen <owen.chen@mediatek.com>,
        Evan Green <evgreen@chromium.org>, Yong.Wu@mediatek.com,
        Joerg Roedel <jroedel@suse.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Ryder Lee <Ryder.Lee@mediatek.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-clk@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Ainge Hsu <ainge.hsu@mediatek.com>,
        Eddie Hung <eddie.hung@mediatek.com>,
        Mediatek WSD Upstream <wsd_upstream@mediatek.com>,
        Macpaul Lin <macpaul@gmail.com>,
        CC Hwang <cc.hwang@mediatek.com>,
        Loda Chou <loda.chou@mediatek.com>
References: <1615291538-9799-1-git-send-email-macpaul.lin@mediatek.com>
 <1615358218-6540-1-git-send-email-macpaul.lin@mediatek.com>
 <1615358218-6540-2-git-send-email-macpaul.lin@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <5caf003d-e7c5-1f2f-d499-726788d5e490@gmail.com>
Date:   Tue, 30 Mar 2021 12:48:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <1615358218-6540-2-git-send-email-macpaul.lin@mediatek.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/03/2021 07:36, Macpaul Lin wrote:
> From: Mars Cheng <mars.cheng@mediatek.com>
> 
> This patch adds MT6765 smi binding document
> 
> Signed-off-by: Mars Cheng <mars.cheng@mediatek.com>
> Signed-off-by: Owen Chen <owen.chen@mediatek.com>
> Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>
> Acked-by: Rob Herring <robh@kernel.org>

Patch looks good, but where is the driver part for it?

Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>

> ---
>  .../bindings/memory-controllers/mediatek,smi-common.yaml         | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.yaml b/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.yaml
> index a08a32340987..4a4f4377576f 100644
> --- a/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.yaml
> +++ b/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.yaml
> @@ -31,6 +31,7 @@ properties:
>        - enum:
>            - mediatek,mt2701-smi-common
>            - mediatek,mt2712-smi-common
> +          - mediatek,mt6765-smi-common
>            - mediatek,mt6779-smi-common
>            - mediatek,mt8167-smi-common
>            - mediatek,mt8173-smi-common
> 
