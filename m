Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C9D6352089
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 22:21:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235579AbhDAUVA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 16:21:00 -0400
Received: from mail-oi1-f174.google.com ([209.85.167.174]:34678 "EHLO
        mail-oi1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234496AbhDAUU7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 16:20:59 -0400
Received: by mail-oi1-f174.google.com with SMTP id x207so3013663oif.1;
        Thu, 01 Apr 2021 13:20:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wcspT1L4njOmUk3kNinDGLJJyQmYO9IfUXHMGjOmchc=;
        b=t80aklyFzMwRAdSRdindYeLkiQIo51JVrxWZilSVmU45Lcm//gmMnwDZgQqZYUq2PO
         sa6RAVBFPpKPI68tizUe5fMi4LpmYfc37RShgoiWI1bbfQraXC9gJwLeiGqWw0aYtah/
         LpKZzzWMvLH4FrJXZElWCG7aTkNldmURdXO9AYk5N/tJcrlhnC0N1kikezq30q1ZREsC
         4epNkXBatrzBvScLzIPCTgKydW+NFONqZrRT5Xy75L00dba8BatVRNcjE6pKtcV2yZX0
         cO65n5qh7v5f6cWY5Dwn8FUY0R6Pm9Sk9AjmHwuLBwRHW4P0MOf+lDn0S+8Cc2GJT9bW
         RZcg==
X-Gm-Message-State: AOAM530PPecGf60zRmwxMO9uYHUObW2eyM5HjcAkosttZYDd4fPjHtY4
        EdjklED8EGdXOAOPNc+rle/3xfQtOw==
X-Google-Smtp-Source: ABdhPJxSgHbdxE/ixaJPEKHjh0MqUdSxB7PgHMrhXuDd6DeB4sLEIkUcP/euJUM8nA8IUQBBb058zA==
X-Received: by 2002:a54:4806:: with SMTP id j6mr7649267oij.15.1617308458832;
        Thu, 01 Apr 2021 13:20:58 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id w23sm1306812oow.25.2021.04.01.13.20.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Apr 2021 13:20:58 -0700 (PDT)
Received: (nullmailer pid 955677 invoked by uid 1000);
        Thu, 01 Apr 2021 20:20:56 -0000
Date:   Thu, 1 Apr 2021 15:20:56 -0500
From:   Rob Herring <robh@kernel.org>
To:     Zhen Lei <thunder.leizhen@huawei.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        alsa-devel <alsa-devel@alsa-project.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: Re: [PATCH v2 2/2] ASoC: dt-bindings: renesas, rsnd: Clear warning
 'ports' does not match any of the regexes
Message-ID: <20210401202056.GA947212@robh.at.kernel.org>
References: <20210331091616.2306-1-thunder.leizhen@huawei.com>
 <20210331091616.2306-3-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210331091616.2306-3-thunder.leizhen@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 31, 2021 at 05:16:16PM +0800, Zhen Lei wrote:
> Currently, if there are more than two ports, or if there is only one port
> but other properties(such as "#address-cells") is required, these ports
> are placed under the "ports" node. So add the schema of property "ports".

A given binding should just use 'ports' or 'port' depending on it's 
need. Supporting both forms is needless complexity.

> Otherwise, warnings similar to the following will be reported:
> arch/arm64/boot/dts/renesas/r8a774a1-beacon-rzg2m-kit.dt.yaml: \
> sound@ec500000: 'ports' does not match any of the regexes: \
> '^rcar_sound,ctu$', '^rcar_sound,dai$', '^rcar_sound,dvc$', ...
> 
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---
>  Documentation/devicetree/bindings/sound/renesas,rsnd.yaml | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/sound/renesas,rsnd.yaml b/Documentation/devicetree/bindings/sound/renesas,rsnd.yaml
> index 384191ee497f534..a42992fa687d3f3 100644
> --- a/Documentation/devicetree/bindings/sound/renesas,rsnd.yaml
> +++ b/Documentation/devicetree/bindings/sound/renesas,rsnd.yaml
> @@ -115,6 +115,11 @@ properties:
>      $ref: audio-graph-port.yaml#
>      unevaluatedProperties: false
>  
> +  ports:

       $ref: /schemas/graph.yaml#/properties/ports

> +    patternProperties:
> +      '^port@[0-9]':
> +        $ref: "#/properties/port"

Then this should be: $ref: audio-graph-port.yaml#

Also, what each port is should be defined, but that's a separate 
problem.

> +
>  # use patternProperties to avoid naming "xxx,yyy" issue
>  patternProperties:
>    "^rcar_sound,dvc$":
> -- 
> 1.8.3
> 
> 
