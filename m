Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90DFD3A4998
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 21:48:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230361AbhFKTuD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 15:50:03 -0400
Received: from mail-ej1-f47.google.com ([209.85.218.47]:33776 "EHLO
        mail-ej1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbhFKTuA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 15:50:00 -0400
Received: by mail-ej1-f47.google.com with SMTP id g20so6261406ejt.0;
        Fri, 11 Jun 2021 12:47:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=C6C9XAc/4o5g/nJl5oV+VV5fk+Yq/QDQ08tqYJKVlN8=;
        b=Wr7Kz7qyfO/ySRu0Ur5oh4v8IOHFu8omwbVz1962faGV6z+ITUn5KuX1jAG8TS3aaK
         38Y5LWZipl+cT7CCjzqAEBNuaFWBQYdqfW1H+5+6Lt5EG720ZyzFkIMcTcl+OjuFRlSa
         1XlypvFbDDLNScs0lkW0/HZT66ck3oqM/FyMxwKAeo4o8OwF0+vbD2b/quzziHxXWW6d
         pidse3IlAvV/27stXoJhYAvK3j0oalHBWdCtu9CVifIKhqi3wF+kuOid+KRDOkOZL/Qe
         LZelQiJQ03l7fkbwK73jwDQ1mz1FLjgp+ReFtkMynml8Dd6zmR5KO1KUkt39XleFQ0HV
         6lMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=C6C9XAc/4o5g/nJl5oV+VV5fk+Yq/QDQ08tqYJKVlN8=;
        b=IXl5b5sHWtuImAruwq2YWtFzKXqAIMC89PkH1rtOkD3OohvO8lHPch2B76OX80Z8Nu
         +S+2Gz7ilRK5S15Wo3aC8ZmVNYtiASrByQMTG0szj4RuuMgDITRQJpivb3ZDNnOOX6Kp
         LPhDkebgaJCekwvOefzdLarXQBJrFNYX3/aZpjLGD40lWnd7yKhiCv+ZEGXO3u9MSkej
         vNpqgC57tn+vpGuLU0AvoHOhdAQpnmV/kdToK4T9kskzbDChKqQjJJ+uVn/1OtYzjxlb
         kpY7ymFclCkJf7KEnO5Sw8RN02oBRfq1gVgViZG2kf+SLsJXMLe6yc/yG0fdSUKZuIwN
         kpVQ==
X-Gm-Message-State: AOAM530GGeYGlSllrz9N0PnMfzNca6O/D2Eo7tETiw5zfbpMNgvxjtOP
        +K11XNDRZmumijnaTaxl1u0=
X-Google-Smtp-Source: ABdhPJxfI9du5pPrBGY5Y+smBF61rv+3CBid1CuZMbtYk5u7WBPWybqvRdM2AW0rcmkmc37DxDvXjw==
X-Received: by 2002:a17:907:948c:: with SMTP id dm12mr5060138ejc.484.1623440806641;
        Fri, 11 Jun 2021 12:46:46 -0700 (PDT)
Received: from skbuf ([188.26.52.84])
        by smtp.gmail.com with ESMTPSA id o64sm3011500eda.83.2021.06.11.12.46.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jun 2021 12:46:46 -0700 (PDT)
Date:   Fri, 11 Jun 2021 22:46:44 +0300
From:   Vladimir Oltean <olteanv@gmail.com>
To:     Matthew Hagan <mnhagan88@gmail.com>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>, Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        soc@kernel.org, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 1/5] dt-bindings: arm: bcm: NSP: add Meraki MX64/MX65
Message-ID: <20210611194644.64lvhvp76wy6guqp@skbuf>
References: <20210610232727.1383117-1-mnhagan88@gmail.com>
 <20210610232727.1383117-2-mnhagan88@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210610232727.1383117-2-mnhagan88@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 11, 2021 at 12:27:13AM +0100, Matthew Hagan wrote:
> Add bindings for the Meraki MX64/MX65 series. Note this patch should be
> applied on top of "dt-bindings: arm: bcm: add NSP devices to SoCs".
> 
> Signed-off-by: Matthew Hagan <mnhagan88@gmail.com>
> ---
>  Documentation/devicetree/bindings/arm/bcm/brcm,nsp.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/bcm/brcm,nsp.yaml b/Documentation/devicetree/bindings/arm/bcm/brcm,nsp.yaml
> index 78dfa315f3d0..7d184ba7d180 100644
> --- a/Documentation/devicetree/bindings/arm/bcm/brcm,nsp.yaml
> +++ b/Documentation/devicetree/bindings/arm/bcm/brcm,nsp.yaml
> @@ -62,6 +62,12 @@ properties:
>            - enum:
>                - brcm,bcm958625hr
>                - brcm,bcm958625k
> +              - meraki,mx64
> +              - meraki,mx64-a0
> +              - meraki,mx64w
> +              - meraki,mx64w-a0
> +              - meraki,mx65
> +              - meraki,mx65w
>            - const: brcm,bcm58625
>            - const: brcm,nsp
>  
> -- 
> 2.26.3
> 

I think these compatibles describe SoCs, whereas Meraki MX64/MX65 are
boards, so this is a miscategorization. Can you not just describe the
Northstar Plus SoC that you are using in your compatible string?
