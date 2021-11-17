Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDD4B454C85
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 18:52:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239693AbhKQRzb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 12:55:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237331AbhKQRza (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 12:55:30 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1787FC061570;
        Wed, 17 Nov 2021 09:52:31 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id n33-20020a05600c502100b0032fb900951eso5469869wmr.4;
        Wed, 17 Nov 2021 09:52:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=z9za700pXbi8AMr9eE4TSbmK4A+KefuoY1pDTMXIcrQ=;
        b=nmbPe2Y0/coc222QpoJ+jvdrxN/ZhL/lFYj98mtK5uXOSapgn3k6Ry3tCUN0JEv6gh
         KQAWqpqIpzHnmCfSrjpTxzcJdzq1tlCZAjOXPYYOsTckofiU0fEQvKLUK5pRUAwH/3+Q
         EoE2X0mseuWDZxlmIDpC10/blauzr+QXvg463/5b3FiyOIjC1ewxCKOibWuhQMnf+izZ
         Y71kw+6SxLMMxCD2G/onQkXFWUtcBea7sX56YbjoBt51AE9NeuNzsc4Ut0ZzNWKTBH5D
         XQoxs5rHWYDxDw1Cef5x6EsdF96V/DKn53RNmm9GrAeEcxkw01j3JvtDy598TDi3VYqN
         +3Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=z9za700pXbi8AMr9eE4TSbmK4A+KefuoY1pDTMXIcrQ=;
        b=tu4Syj0H5w35kvJDAX3PZcnjf1QoUgO95Z27E1BPYzQzRNtza5MwEmjzli2peUGmYU
         6mpuJxbMBaB7llLEdog6JA8cfvcbkBukJ+yQlSYvpTxyvOmP+ycV3IzF/I7/id3tcWPI
         WuI9CUcbcKmadvAZlxQh4so9TxQvAqq57ud39GdQHuAeerRmoIA2n0kgZ7reTSaDMywR
         wcKiP2Xerp/CnKa6TX+8Fu8gpxOGR2YfVz0PkwkFIwQErHsZWd3Rcvf52JxR72NgnELI
         sVvBFPtNBny5RproE7QYiUj273+1TM40A50t1cMI0Vks0HfMng6MFsbk9MTBwDBiIoJm
         rL3g==
X-Gm-Message-State: AOAM530TxG8Cg4dnn+mjgSq9SfNB1fE46zhYhuqixVDdGuLAtTwIgvN/
        GueLWwRpqbza1eZwsIPwK8a/fKJUUto=
X-Google-Smtp-Source: ABdhPJwynQ5d4Q4cF6u/F26+njYaHAAlkx2vAct0EWKN2lUdmV8TDsrgmWiB/HBK0BwpLfksgHp6FA==
X-Received: by 2002:a05:600c:24d:: with SMTP id 13mr1768515wmj.156.1637171549639;
        Wed, 17 Nov 2021 09:52:29 -0800 (PST)
Received: from [192.168.0.18] (static-160-219-86-188.ipcom.comunitel.net. [188.86.219.160])
        by smtp.gmail.com with ESMTPSA id h17sm6099017wmb.44.2021.11.17.09.52.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Nov 2021 09:52:29 -0800 (PST)
Message-ID: <52c99fae-1c66-271c-f91d-89dc058585bd@gmail.com>
Date:   Wed, 17 Nov 2021 18:52:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v2] dt-bindings: mfd: change naming of mediatek rpmsg
 property
Content-Language: en-US
To:     Tinghan Shen <tinghan.shen@mediatek.com>, robh+dt@kernel.org,
        groeck@chromium.org, lee.jones@linaro.org,
        angelogioacchino.delregno@collabora.com, bleung@chromium.org,
        Enric Balletbo Serra <eballetbo@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20211103103952.12535-1-tinghan.shen@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20211103103952.12535-1-tinghan.shen@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 03/11/2021 11:39, Tinghan Shen wrote:
> Change from "mtk,rpmsg-name" to "mediatek,rpmsg-name" to sync with the
> vendor name defined in vendor-prefixes.yaml.
> 
> Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>
> Reviewed-By: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Acked-by: Rob Herring <robh@kernel.org>

Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>

> ---
> This patch is based on [1].
> [1] arm64: dts: mt8183: change rpmsg property name
>      - https://patchwork.kernel.org/project/linux-mediatek/patch/20210924033935.2127-7-tinghan.shen@mediatek.com/
> 
> Changes since v1:
> - No change. Add dependency information.
> ---
>   Documentation/devicetree/bindings/mfd/google,cros-ec.yaml | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/mfd/google,cros-ec.yaml b/Documentation/devicetree/bindings/mfd/google,cros-ec.yaml
> index d793dd0316b7..0faa4da6c7c8 100644
> --- a/Documentation/devicetree/bindings/mfd/google,cros-ec.yaml
> +++ b/Documentation/devicetree/bindings/mfd/google,cros-ec.yaml
> @@ -59,7 +59,7 @@ properties:
>         whether this nvram is present or not.
>       type: boolean
>   
> -  mtk,rpmsg-name:
> +  mediatek,rpmsg-name:
>       description:
>         Must be defined if the cros-ec is a rpmsg device for a Mediatek
>         ARM Cortex M4 Co-processor. Contains the name pf the rpmsg
> 
