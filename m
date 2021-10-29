Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C83B243F4DC
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Oct 2021 04:13:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231530AbhJ2CPl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 22:15:41 -0400
Received: from mail-ot1-f47.google.com ([209.85.210.47]:43734 "EHLO
        mail-ot1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231356AbhJ2CPk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 22:15:40 -0400
Received: by mail-ot1-f47.google.com with SMTP id n13-20020a9d710d000000b005558709b70fso4996222otj.10;
        Thu, 28 Oct 2021 19:13:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vM3EiRXQ2OSu4mmD6bWP+EUG0mzB9TpPF/rDTHfYIj8=;
        b=WQ7hOtBuE892Whp/mRMnGRsNgdQk9QgBCX5kmfiL3fqvCJuqi3UYcFwFBod04Fmu5y
         /WzcGnJSE8SCq/y3Lc43wJAF2A7QPkBktzuuMAjOGZYqMi4ylotDTCfBs4x2d1rvmz04
         c3wrTaVZkBSRxBvaxTKHnjTplYdwZxwUekSHn9MxA3g/L6HR10CU/9QFwbovBA5bUYwe
         uXR9XBV69y/Fv7AgAFlFAFbxoTnzo/K+e/XMyARjcBqT6S66B70TA6vCb4O0setYaqbO
         Qf1l+dqwX6vjGymMdW12ZDdHo5OWKJDGBqpnZ++ZjP5BVe13TyKI2kfjyLKpXP2srDFA
         L69A==
X-Gm-Message-State: AOAM533tEjXX6spH6GlYhLlQR9e/gwJYZ/F2xRiCJ2+A3/nvC9jeTZfO
        N80sVl1x7MJpWAzD7HgKjA==
X-Google-Smtp-Source: ABdhPJyMHDvpVhYUlm/I6enpqef/qbWhYuWCe25Mv9RYKjQCgibt2oEWqsEAdKdJakD46cNOTl/6Lg==
X-Received: by 2002:a05:6830:3155:: with SMTP id c21mr6450826ots.104.1635473592353;
        Thu, 28 Oct 2021 19:13:12 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id bo35sm727867oib.40.2021.10.28.19.13.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Oct 2021 19:13:11 -0700 (PDT)
Received: (nullmailer pid 1021491 invoked by uid 1000);
        Fri, 29 Oct 2021 02:13:10 -0000
Date:   Thu, 28 Oct 2021 21:13:10 -0500
From:   Rob Herring <robh@kernel.org>
To:     Vincent Knecht <vincent.knecht@mailoo.org>
Cc:     stephan@gerhold.net, lgirdwood@gmail.com, broonie@kernel.org,
        perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH v1 3/4] ASoC: dt-bindings: nxp, tfa989x: Add rcv-gpios
 property for tfa9897
Message-ID: <YXtYtsPCeh937oF6@robh.at.kernel.org>
References: <20211024085840.1536438-1-vincent.knecht@mailoo.org>
 <20211024085840.1536438-4-vincent.knecht@mailoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211024085840.1536438-4-vincent.knecht@mailoo.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 24, 2021 at 10:58:39AM +0200, Vincent Knecht wrote:
> Add optional rcv-gpios property specific to tfa9897 receiver mode.
> 
> Signed-off-by: Vincent Knecht <vincent.knecht@mailoo.org>
> ---
>  .../devicetree/bindings/sound/nxp,tfa989x.yaml         | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/sound/nxp,tfa989x.yaml b/Documentation/devicetree/bindings/sound/nxp,tfa989x.yaml
> index 7667471be1e4..a9e15baedafd 100644
> --- a/Documentation/devicetree/bindings/sound/nxp,tfa989x.yaml
> +++ b/Documentation/devicetree/bindings/sound/nxp,tfa989x.yaml
> @@ -12,6 +12,16 @@ maintainers:
>  allOf:
>    - $ref: name-prefix.yaml#
>  
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: nxp,tfa9897
> +    then:
> +      properties:
> +        rcv-gpios:
> +          description: optional GPIO to be asserted when receiver mode is enabled.

Did you test this works? 

You have to define the property outside the if/then schema at the top 
level. Then use an if/then schema to restrict it (rcv-gpios: false).

> +
>  properties:
>    compatible:
>      enum:
> -- 
> 2.31.1
> 
> 
> 
> 
