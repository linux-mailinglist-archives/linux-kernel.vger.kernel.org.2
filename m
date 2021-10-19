Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1DED433101
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 10:24:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234671AbhJSI0n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 04:26:43 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:49978
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230082AbhJSI0l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 04:26:41 -0400
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com [209.85.208.197])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 84BF14001A
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 08:24:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1634631867;
        bh=a51E5LbbeoBiM09ZZvVA6mvFSU1Efb43bjrujhxw6Ho=;
        h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
         In-Reply-To:Content-Type;
        b=Jo7D2aC0iP2bwppMoguHfbSynPnAEMRXwGBaN3iw0l/Bmk0I6XnHzAuLJFQbE6Y0j
         sWT/qGbWKYdtwg7Yp7aaUECisvVX32Xx1l/g6G/n1fwQhNWj7oZj4LgdnBQpIIB/GO
         DXTCQuBXyYFzZbbgRkeBFD/xk17r/YzhAISYzbHBOcVFuYuSSG5y4J2maCgcdhdYDl
         x6vltaUYYPzToH2lKODOMhga7sQqtzSfrK9kL79eRLOzpGfhEdjZUsj2ReNX1qDCJ1
         tIW/HyTAQAi5WIw9+s6LiMyt36jt/JusrZvcbfS0f4jzgRLAFzFfheuKtfpwuFGKLV
         DDdUrvPCoYKcQ==
Received: by mail-lj1-f197.google.com with SMTP id t1-20020a2e8e61000000b00210c040693bso608125ljk.8
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 01:24:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=a51E5LbbeoBiM09ZZvVA6mvFSU1Efb43bjrujhxw6Ho=;
        b=PE8+T8PspLgdjEVn0U10KJ9ElqfakBg0mBl1wyuCxktZE8gJFETep4ceRJLvPhwGTM
         vpOb8rqwA64SVTDAiFWGlobHSebq1EtFU+ynWt06eAd6sos98C268YP/rDE1swVOctKY
         fZm+yU6IuQ3x+JDvxLnDzsSc/rm+UP0x1Sj7fzmA1LpCCjVndKWZsvVF6JBVPsLZGGeH
         uh+mED8+GnLJpN3DAU9VsuL3U3EvVu2DmF6nAToTt472nAZBJc+MuCGyCc+A+44JIV1B
         JtD7jrqWNmJtlg1Y+hX+mO4k6brwWobCkb4+xWYLKSMsMulOA/dqi5WpCVunfXCDUUrM
         KSfA==
X-Gm-Message-State: AOAM533Z5aLftcIPnnYcuAKZT19+SeKTFhBhwDu2ZtfE5qAm3MFp24dK
        d+87KGkIl0H3+yMP2bjUjR7kG77ZXKHChWtsHsMt+I0D2haNq1bR66GqbXRK8JKfVGQ5sNrbgtn
        fqkv8GCN1SQM5AUDL57lMhZlPCNYllEyUmuEN4fROcw==
X-Received: by 2002:a2e:86ce:: with SMTP id n14mr5463855ljj.325.1634631866400;
        Tue, 19 Oct 2021 01:24:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzkLe6UN97XVnzFaFavdfVYyHa8Kvv+CJr9EKy/myTmY7y7LNLGdsYtwU56i+0jQwR7VPlYTw==
X-Received: by 2002:a2e:86ce:: with SMTP id n14mr5463842ljj.325.1634631866193;
        Tue, 19 Oct 2021 01:24:26 -0700 (PDT)
Received: from [192.168.3.161] (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
        by smtp.gmail.com with ESMTPSA id y7sm1348443lfa.126.2021.10.19.01.24.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Oct 2021 01:24:25 -0700 (PDT)
Subject: Re: [PATCH v3 21/23] regulator: dt-bindings: update
 samsung,s2mpa01.yaml reference
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org
References: <cover.1634630485.git.mchehab+huawei@kernel.org>
 <9acc235dc4af794d18e1267371944a3955e1fb21.1634630486.git.mchehab+huawei@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <390833d2-25a5-72ae-4d05-c145d6f8507a@canonical.com>
Date:   Tue, 19 Oct 2021 10:24:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <9acc235dc4af794d18e1267371944a3955e1fb21.1634630486.git.mchehab+huawei@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/10/2021 10:04, Mauro Carvalho Chehab wrote:
> The file name: Documentation/devicetree/bindings/mfd/samsung,s2mpa01.yaml
> should be, instead: Documentation/devicetree/bindings/regulator/samsung,s2mpa01.yaml.
> 
> Update its cross-reference accordingly.
> 
> Fixes: a52afb0f54fa ("regulator: dt-bindings: samsung,s2mpa01: convert to dtschema")
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
> 
> To mailbombing on a large number of people, only mailing lists were C/C on the cover.
> See [PATCH v3 00/23] at: https://lore.kernel.org/all/cover.1634630485.git.mchehab+huawei@kernel.org/
> 
>  .../devicetree/bindings/regulator/samsung,s2mpa01.yaml          | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/regulator/samsung,s2mpa01.yaml b/Documentation/devicetree/bindings/regulator/samsung,s2mpa01.yaml
> index 0627dec513da..0a564319f4b2 100644
> --- a/Documentation/devicetree/bindings/regulator/samsung,s2mpa01.yaml
> +++ b/Documentation/devicetree/bindings/regulator/samsung,s2mpa01.yaml
> @@ -15,7 +15,7 @@ description: |
>  
>    The S2MPA01 provides buck and LDO regulators.
>  
> -  See also Documentation/devicetree/bindings/mfd/samsung,s2mpa01.yaml for
> +  See also Documentation/devicetree/bindings/regulator/samsung,s2mpa01.yaml for
>    additional information and example.
>  

Hi Mauro,

Thanks for the patch but it is incorrect. Old path is proper, just the
patch waits on merging.

For this one: NAK.

Best regards,
Krzysztof
