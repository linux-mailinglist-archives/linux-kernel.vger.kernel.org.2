Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 653D03E063B
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 18:59:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239765AbhHDQ7H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 12:59:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239555AbhHDQ7D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 12:59:03 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2B60C0613D5;
        Wed,  4 Aug 2021 09:58:49 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id u15so1606197wmj.1;
        Wed, 04 Aug 2021 09:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3Ssyrr/LekuqyfoFP6rWy6sS/bB/kXsH0XIHqq6qrRA=;
        b=d6yEoAllZGCIiIueIGkiRtizcnZJvJZz/7grSWi60dtuThwbzCP0txQSI6PW24vBof
         ujuku+sbZ68B5JTfrq6BT3/8UTDqIur4gqE10o6M4zIOLKbvrhAg1h7wozS5Wkd1Fwpq
         oKkBNOOG780dSz0LDPznyhNlqAbwM9xh7fX+dLqS6F8FaEs88//3x20aubIhfqHYVneQ
         fJq0dPwibQlpflo6yKIVqaqRAXWgVxlgMLj3mICKTVxcFq19v8K8uAdgAwmL+DWD3WMX
         W4WhBAE/PhnqjBMDHkCsPVbaFJB7FHjHfHCPIVHud4TGPFAKiOqPzyKXKEwA53BHJgYB
         HKEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3Ssyrr/LekuqyfoFP6rWy6sS/bB/kXsH0XIHqq6qrRA=;
        b=MPjuE40mArSQcTr47dzrbtMXNSI7ET6Z3C56ngVSSXefutsELXkyT6IB9hu6LpgyG7
         wfb/qbPmFqLaDtLffApUePZ5UGLMXNyERkgJtki8XMQDPcCyCTQ2BcYtFmFuPJD8At+9
         dCN2qLwnWl0wW17IBZuS9gtqaZ2QV3+7LvhK3cwMqjkiovE0japrS7dE+Nf4QvIMQwE5
         y85lil1drR/y1AjZfeagmbaoXsRMyiB91UkJvAD+9kJ48ExXkiyjLgdBmDynp8bN00zU
         uNeg59fEFlEjV7D/mzX8k5g9uGM6P0oGlyMESw24CWbJeGUp6oYjBOlTF+WYgWzdnltf
         txtQ==
X-Gm-Message-State: AOAM530pMn1xMsyDeJfgJ2MpSj/uZLJpAFS5xKarmZ8cTRs33kpoD8XA
        sRcbypuBrrZy11XX/hkSeo8=
X-Google-Smtp-Source: ABdhPJwafgMJoBvwzw0+RnBkoe8PPw1by0O0pbkbU82e5MFA8Z4ROKKfNhJh/lAx6gweEKQ7LWzKjA==
X-Received: by 2002:a05:600c:acd:: with SMTP id c13mr526867wmr.189.1628096328471;
        Wed, 04 Aug 2021 09:58:48 -0700 (PDT)
Received: from ziggy.stardust (static-55-132-6-89.ipcom.comunitel.net. [89.6.132.55])
        by smtp.gmail.com with ESMTPSA id q5sm3428112wrx.33.2021.08.04.09.58.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Aug 2021 09:58:48 -0700 (PDT)
Subject: Re: [v15] dt-bindings: ARM: Mediatek: Add mmsys document binding for
 MT8192
To:     Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Nicolas Boichat <drinkcat@chromium.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        srv_heupstream@mediatek.com,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20210802025839.16763-1-chun-jie.chen@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <aa0602cb-c4f3-53e0-7ce4-47e9eabe84ee@gmail.com>
Date:   Wed, 4 Aug 2021 18:58:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210802025839.16763-1-chun-jie.chen@mediatek.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On 02/08/2021 04:58, Chun-Jie Chen wrote:
> This patch adds the mmsys document binding for MT8192 SoC.
> 
> Signed-off-by: Chun-Jie Chen <chun-jie.chen@mediatek.com>
> Reviewed-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>
> Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
> Acked-by: Rob Herring <robh@kernel.org>
> ---
> This patch is based on 5.14-rc1 and [1].
> 
> Due to mmsys binding document has been converted to YAML format in [1],
> so resend the patch in [2].
> 
> [1] https://patchwork.kernel.org/project/linux-mediatek/list/?series=485165
> [2] https://patchwork.kernel.org/project/linux-mediatek/patch/20210726105719.15793-3-chun-jie.chen@mediatek.com/
> ---
>  .../devicetree/bindings/arm/mediatek/mediatek,mmsys.yaml         | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.yaml b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.yaml
> index 2d4ff0ce387b..f9ffa5b703a5 100644
> --- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.yaml
> +++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.yaml
> @@ -29,6 +29,7 @@ properties:
>                - mediatek,mt8167-mmsys
>                - mediatek,mt8173-mmsys
>                - mediatek,mt8183-mmsys
> +              - mediatek,mt8192-mmsys
>                - mediatek,mt8365-mmsys
>            - const: syscon
>        - items:
> 

This patch has a dependency to [1] which you merged in your tree. Would you mind
to take this one as well?

Acked-by: Matthias Brugger <matthias.bgg@gmail.com>

Thanks,
Matthias

[1]
https://patchwork.kernel.org/project/linux-mediatek/patch/20210519161847.3747352-1-fparent@baylibre.com/
