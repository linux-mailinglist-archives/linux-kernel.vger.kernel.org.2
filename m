Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E58DB3A4F73
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jun 2021 17:09:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231366AbhFLPLA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Jun 2021 11:11:00 -0400
Received: from mail-ed1-f51.google.com ([209.85.208.51]:44686 "EHLO
        mail-ed1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230191AbhFLPK5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jun 2021 11:10:57 -0400
Received: by mail-ed1-f51.google.com with SMTP id u24so40603603edy.11;
        Sat, 12 Jun 2021 08:08:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=MyHAGIpkkv5FhdCV+dmubHT6fI0J4Qtzj9J4fslDtcQ=;
        b=W0TBv8YxPCk0CMIX/i/QLdgS9KiKeQNoLDvGMD8SlDDMPEk6JkrNmNWNTTwzESG1DS
         VocDE82KQpTdDCqbqJn9RnvauCxSTCdFPH0GvzqxPLAfzKxYE5RsZ4RIbhMQ5LDR+H35
         zoRR+nzmC0a1z4dA97a7ZhTm6+eH4/zUC47HyMZKzVDU59gg250UVuGDeaVKnCvFbjb0
         GJ2HEvLaGKba8mdh7LQ0i4DLMzZaRLWsayayPUaFwVAY054QBMNB2YrSpcOJtc/LEEB+
         va0d42hOiUVzQa60NOHtISexG3n0qBdKgrIAy6bwb1z6ZtPsemBkGGQjvIXwkf+puHb1
         uJ/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MyHAGIpkkv5FhdCV+dmubHT6fI0J4Qtzj9J4fslDtcQ=;
        b=pgT8hxxXWFahFkoXrjMH2bzbsGG4Fvm8do5sKRTjiQdxUxJOwsc800w3uhPyud+OlH
         X1+Y7M0/zWoCvtaTDj+gP+71KNtahrne39+yAGEShzutd8KiZr0x6arXcyV2Aus3/nQx
         sNyZ9Wy2rgRA15eHhqF9VkkPNVpVBYRafKqYgvhoFkZjMFqtrJ6SY5A9uS7y8l/bCgJe
         N+Q6ciyE0d3gG5V2SzK4qAzb8aUEjZ4TSTv7VI5T8ONHAursgf+4iZa2LGWhoOYQo8n8
         90yx0RsY48NDSYD8zoLx7YGmHLXro6cwRvlGeb6FGXQzeLWVdrNbAbBKQXfXXt4MY2kd
         XZlA==
X-Gm-Message-State: AOAM531JPg1g83B18P0qRupt+lefKA7VidLlpleT9l5bJGOY+7hucwLf
        NO/4SCTlCCRhdhekHuA0OhY=
X-Google-Smtp-Source: ABdhPJzxp36MU7OxaYVh1dgVnXetWoZR9dLwm9Xiwc/QVPJuVTP+udohcInDHSZkGVZKBTRk6s1urA==
X-Received: by 2002:a50:d943:: with SMTP id u3mr9250028edj.175.1623510476839;
        Sat, 12 Jun 2021 08:07:56 -0700 (PDT)
Received: from skbuf ([188.26.52.84])
        by smtp.gmail.com with ESMTPSA id n5sm4002476edd.40.2021.06.12.08.07.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Jun 2021 08:07:56 -0700 (PDT)
Date:   Sat, 12 Jun 2021 18:07:55 +0300
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
Message-ID: <20210612150755.efb5hw3xujkkh2va@skbuf>
References: <20210610232727.1383117-1-mnhagan88@gmail.com>
 <20210610232727.1383117-2-mnhagan88@gmail.com>
 <20210611194644.64lvhvp76wy6guqp@skbuf>
 <f0af3f0a-ab13-ecdc-d834-c95ddcb52866@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f0af3f0a-ab13-ecdc-d834-c95ddcb52866@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 12, 2021 at 10:21:31AM +0100, Matthew Hagan wrote:
> Hi Vladimir,
> 
> Many thanks for taking the time to review the submission.
> 
> On 11/06/2021 20:46, Vladimir Oltean wrote:
> 
> > On Fri, Jun 11, 2021 at 12:27:13AM +0100, Matthew Hagan wrote:
> >> Add bindings for the Meraki MX64/MX65 series. Note this patch should be
> >> applied on top of "dt-bindings: arm: bcm: add NSP devices to SoCs".
> >>
> >> Signed-off-by: Matthew Hagan <mnhagan88@gmail.com>
> >> ---
> >>  Documentation/devicetree/bindings/arm/bcm/brcm,nsp.yaml | 6 ++++++
> >>  1 file changed, 6 insertions(+)
> >>
> >> diff --git a/Documentation/devicetree/bindings/arm/bcm/brcm,nsp.yaml b/Documentation/devicetree/bindings/arm/bcm/brcm,nsp.yaml
> >> index 78dfa315f3d0..7d184ba7d180 100644
> >> --- a/Documentation/devicetree/bindings/arm/bcm/brcm,nsp.yaml
> >> +++ b/Documentation/devicetree/bindings/arm/bcm/brcm,nsp.yaml
> >> @@ -62,6 +62,12 @@ properties:
> >>            - enum:
> >>                - brcm,bcm958625hr
> >>                - brcm,bcm958625k
> >> +              - meraki,mx64
> >> +              - meraki,mx64-a0
> >> +              - meraki,mx64w
> >> +              - meraki,mx64w-a0
> >> +              - meraki,mx65
> >> +              - meraki,mx65w
> >>            - const: brcm,bcm58625
> >>            - const: brcm,nsp
> >>  
> >> -- 
> >> 2.26.3
> >>
> > I think these compatibles describe SoCs, whereas Meraki MX64/MX65 are
> > boards, so this is a miscategorization. Can you not just describe the
> > Northstar Plus SoC that you are using in your compatible string?
> 
> My understanding is that the bcm958625hr and bcm958625k are dev boards
> using the BCM58625 SoC variant of NSP. For reference, a close example
> can be found in brcm,bcm4708.yaml in the same directory:
> 
>       - description: BCM53012 based boards
>         items:
>           - enum:
>               - brcm,bcm953012er
>               - brcm,bcm953012hr
>               - brcm,bcm953012k
>               - meraki,mr32
>           - const: brcm,brcm53012
>           - const: brcm,brcm53016
>           - const: brcm,bcm4708
> 
> For the compatible string we would definitely need to specify a unique
> device name for identification by the OS, rather than just the SoC.
> 
> Of course I could be mistaken. Will await confirmation on this.

Yeah, ok, fair, after rechecking I think you're right. I'm dropping this charge.
