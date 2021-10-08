Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 756E7426CCF
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 16:33:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230026AbhJHOfo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 10:35:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240224AbhJHOfk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 10:35:40 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EEEBC061570;
        Fri,  8 Oct 2021 07:33:45 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id v25so30435644wra.2;
        Fri, 08 Oct 2021 07:33:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=TShzTngLZi6o8lnvb+j8av9MVCWHAWUlT4LrbexAp60=;
        b=pmchaDdegR3myZdKHZV3r9+KFJhoet23YZP2QFSc+6jYCKT3uv7L6TBBAi6uWLmT5m
         XXKwRYEKBe8lA4O9pgTrItK1ChPJOsJzJE9Fo17lX6XSsYgo2qTYslmOcw1vKSz7ALoj
         p6ETP6Z+kTmh5ILTnqOVUPuAm0yvHqjSZxaFZHllo1L87bHlZGQNpi5lHX2Zr+I5DqgS
         /RsSS8/ghniGNVvYwacrxnIsEQG8Glh9YOd0JDZ+hSp+trU0gm26dfXUEITblhX5Fb7O
         lHkgiCCP+YuzzL9iXkF+TAjdvB1/fy59kkFBHvNAZrmRKJcK2Cp6r5kbUMj+JRYQ601Z
         m+Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=TShzTngLZi6o8lnvb+j8av9MVCWHAWUlT4LrbexAp60=;
        b=QmBYjLpEbb5tSvqznGH8eujKxxrnrcVUaqyE6A4Bu4h2LXzeeULzRQfLG3kwsUFt51
         u6Mno4TbDoJsZLB1eAjvnNFexAGeHKYWbi6Y6eD5hBzdMzID/dQs+p2XRXcfxTmGY/Ek
         El0fv/dtel+0cl7Pk5IKZ4jcemngB9NStxbpmuSxqxMOH3if2ir81rOh31nZow3+U7WK
         aVLw6TF2A5MhaGGm5WspWHTnBBXE97NQXUf/LKIrfIU3W6KVLFJJCVZw2PZfJHU7roFJ
         TXU8jJNRKjCTqw2CW8sUBxSymbZtQzMlXSAV60uM6AcLXWCQljM+Rf+Lb3WVrVvomXfQ
         oTgg==
X-Gm-Message-State: AOAM533vyaOW9xEu/iCEgCll03tJDOyFcebEIRRgeMOoQpxsyhr6gU+S
        kxYmB97zrc+dTvFiDquz0yU=
X-Google-Smtp-Source: ABdhPJwAtIQy4fNzxj7d0iRIf29L54prs1Xgk5dkVhacrkjXhk4lwBP2+waVCVUbE0adQC7vmnygoA==
X-Received: by 2002:adf:bb88:: with SMTP id q8mr4512891wrg.390.1633703623613;
        Fri, 08 Oct 2021 07:33:43 -0700 (PDT)
Received: from [192.168.2.177] ([206.204.146.29])
        by smtp.gmail.com with ESMTPSA id y191sm13532166wmc.36.2021.10.08.07.33.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Oct 2021 07:33:43 -0700 (PDT)
Message-ID: <0623e9d8-8b79-d163-0204-745809b0d0ba@gmail.com>
Date:   Fri, 8 Oct 2021 16:33:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.2
Subject: Re: [PATCH 1/2] dt-bindings: arm: Add MT6589 Fairphone 1
Content-Language: en-US
To:     Luca Weiss <luca@z3ntu.xyz>, linux-mediatek@lists.infradead.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        Arnd Bergmann <arnd@arndb.de>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Fabien Parent <fparent@baylibre.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Olof Johansson <olof@lixom.net>,
        Rob Herring <robh+dt@kernel.org>,
        Sean Wang <sean.wang@mediatek.com>,
        Seiya Wang <seiya.wang@mediatek.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, soc@kernel.org
References: <20211005202833.96526-1-luca@z3ntu.xyz>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20211005202833.96526-1-luca@z3ntu.xyz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 05/10/2021 22:28, Luca Weiss wrote:
> Add the compatible for Fairphone 1 smartphone with MT6589 SoC.
> 
> Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
> ---

This patch is now applied to v5.15-next/dts32

Thanks!

>   Documentation/devicetree/bindings/arm/mediatek.yaml | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/mediatek.yaml b/Documentation/devicetree/bindings/arm/mediatek.yaml
> index 80a05f6fee85..0fa55497b96f 100644
> --- a/Documentation/devicetree/bindings/arm/mediatek.yaml
> +++ b/Documentation/devicetree/bindings/arm/mediatek.yaml
> @@ -32,6 +32,7 @@ properties:
>             - const: mediatek,mt6580
>         - items:
>             - enum:
> +              - fairphone,fp1
>                 - mundoreader,bq-aquaris5
>             - const: mediatek,mt6589
>         - items:
> 
