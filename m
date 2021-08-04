Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A49CD3E03CF
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 17:01:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238941AbhHDPBm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 11:01:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238826AbhHDPBl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 11:01:41 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2E53C0613D5;
        Wed,  4 Aug 2021 08:01:27 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id k4so2655010wrc.0;
        Wed, 04 Aug 2021 08:01:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=b/CGPGKAIJdU81c9VKQNODFZgreiXcLnh2tcMHBfuZM=;
        b=HpKqdQAoj25mhjTtSvf7761Z6DAeK91j7qgoD2Xp7GxroakkEZsXbCvN6pO7F+Lqnu
         7MZk7nRZkIM/kSoEepSC9DW/KjZUlVEpC8yTJhYIBFeW8+SPH2jzSmiFfncFLT32zWrO
         APamyL5VaHn/njXG12sVKlUzDiEYe4ESGPmz3nm7UfJlz19VLu2EBKKINlbQLbokeZAF
         K48scpqfuq6Y6D+W51wVGs2dl1LSOfC49220MXexYKgxLaoXvX5yV712fWFR+C7xyTMW
         Vme6E8g/34yZld/s3Z9xM0wkzvcONsE+0xPe/igBPe3vSnmRshE2p94FXe0ohY8iDgfs
         lDSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=b/CGPGKAIJdU81c9VKQNODFZgreiXcLnh2tcMHBfuZM=;
        b=JE0PkpWoAhZnsIJ+kL+m1ezrD4TWBX25SQDMYBUEDZCXPjUjuqJKMoLz8XfGEvx8e8
         aH/XuW//guC95NPwB5duEIlu374NKiW5YXS92D01ULRp5TrDqjtJuXdoi7LdzN5HGvJk
         sLIN0YqN7L+BvzHwpppLCMJLKRXdYPxKzzikNzH9VPpHh0oDrV8Nvi6ncXGfJlVxmNf+
         1yP/13tfo+0kE5AM1oDuFQYBBV/+3GxopQZqlgzbMKIYessAVBGPdjME5do7+PeZs+bc
         uWyVHXVVv/U3uK79wjw9UDUZiOZzF7aIx7t9xu7OJMSxz++IVyjGDEi+Zz7Hr8fOhHyG
         645w==
X-Gm-Message-State: AOAM531ZcmRd1Umcmel6HbI7OADHk6SsUMgq8jDtyKOP1toQexpEKuHE
        ZsLnR/GoIXCL5z6UyZxLB3561gVXXn0ayA==
X-Google-Smtp-Source: ABdhPJz1VngK4KyOLmBahayZ/13L7txbqaR776m8lVaezd/WsyTRfY1khzKVSoMshxjY5e6l520jKQ==
X-Received: by 2002:a5d:4e91:: with SMTP id e17mr29179159wru.7.1628089286553;
        Wed, 04 Aug 2021 08:01:26 -0700 (PDT)
Received: from ziggy.stardust (static-55-132-6-89.ipcom.comunitel.net. [89.6.132.55])
        by smtp.gmail.com with ESMTPSA id g11sm3005787wrd.97.2021.08.04.08.01.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Aug 2021 08:01:25 -0700 (PDT)
Subject: Re: [PATCH 1/2] dt-bindings: usb: mtk-musb: add MT7623 compatible
To:     Sungbo Eo <mans0n@gorani.run>, linux-mediatek@lists.infradead.org
Cc:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Min Guo <min.guo@mediatek.com>,
        Frank Wunderlich <frank-w@public-files.de>,
        devicetree@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20210803151320.71531-1-mans0n@gorani.run>
 <20210803151320.71531-2-mans0n@gorani.run>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <353c79de-2dab-0367-32e8-63b0fd89900d@gmail.com>
Date:   Wed, 4 Aug 2021 17:01:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210803151320.71531-2-mans0n@gorani.run>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 03/08/2021 17:13, Sungbo Eo wrote:
> Document MT7623 compatible for mtk-musb.
> 
> Signed-off-by: Sungbo Eo <mans0n@gorani.run>

Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>

> ---
>  Documentation/devicetree/bindings/usb/mediatek,musb.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/usb/mediatek,musb.yaml b/Documentation/devicetree/bindings/usb/mediatek,musb.yaml
> index 84ddacfdbe9b..03d62d60ce5f 100644
> --- a/Documentation/devicetree/bindings/usb/mediatek,musb.yaml
> +++ b/Documentation/devicetree/bindings/usb/mediatek,musb.yaml
> @@ -19,6 +19,7 @@ properties:
>        - enum:
>            - mediatek,mt8516-musb
>            - mediatek,mt2701-musb
> +          - mediatek,mt7623-musb
>        - const: mediatek,mtk-musb
>  
>    reg:
> 
