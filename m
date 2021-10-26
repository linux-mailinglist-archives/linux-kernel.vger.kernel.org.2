Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5769243BBAC
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 22:38:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239218AbhJZUkd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 16:40:33 -0400
Received: from mail-oi1-f176.google.com ([209.85.167.176]:33685 "EHLO
        mail-oi1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231169AbhJZUkc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 16:40:32 -0400
Received: by mail-oi1-f176.google.com with SMTP id q129so449102oib.0;
        Tue, 26 Oct 2021 13:38:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cQAy+ch/uXL0enK+MtdMfdJNuhvgB4pFrD8BNcOrG1A=;
        b=SeJMbKTHVkr0BDeKcDPSJDcUXoRIxPqUMdxRWsiVkrwjgiQQsg+EuJT7f6tBHY72W2
         scDwymhz16fAVf6mhzz1aAiP4GIaHERp9gd74L03tBNocKCV4G2EKcCfX45b6Opj0pL3
         AMY4LBcrLm+H0Wf61xibCnzKtsAnF40cjwAYFMY145y0pALeE+ZpwzvKyJSnUodPJ7Bz
         Y7gUdqWaU0h5gi66QHjLKrZFt7haYk39lFdngFNJ3ZEkms19/gRK7YuZhho7xqG3YO/b
         WgtB0glGGoMPi7N3VtzvUMiLNvJq38Ml1BEo0P63lFm6DU61xq3aY8GHcV4aVGtdrm41
         /2wA==
X-Gm-Message-State: AOAM533LlGa++jQ4CqLxti1NIENJ9O1TAIRXUtyF91ptU4PLdOzqiNN/
        lkqN6CohHfN/zv3Q3XVoEg==
X-Google-Smtp-Source: ABdhPJzauTHPSFI/P4AXq1Lb+Cgj5u3xsLCqIk3BpGpme6R4fCMv6FXhMoQpXBkiuqzHK27I78Rb8g==
X-Received: by 2002:a05:6808:1cc:: with SMTP id x12mr780989oic.88.1635280687533;
        Tue, 26 Oct 2021 13:38:07 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id c5sm935744oiw.13.2021.10.26.13.38.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Oct 2021 13:38:07 -0700 (PDT)
Received: (nullmailer pid 3202845 invoked by uid 1000);
        Tue, 26 Oct 2021 20:38:06 -0000
Date:   Tue, 26 Oct 2021 15:38:06 -0500
From:   Rob Herring <robh@kernel.org>
To:     Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Cc:     hminas@synopsys.com, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        devicetree@vger.kernel.org, amelie.delaunay@foss.st.com,
        alexandre.torgue@foss.st.com
Subject: Re: [PATCH] dt-bindings: usb: dwc2: document the port when
 usb-role-switch is used
Message-ID: <YXhnLh9OYxUz8dIC@robh.at.kernel.org>
References: <1634144026-3326-1-git-send-email-fabrice.gasnier@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1634144026-3326-1-git-send-email-fabrice.gasnier@foss.st.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 13, 2021 at 06:53:46PM +0200, Fabrice Gasnier wrote:
> Document the "port" property, which is used with "usb-role-switch"
> to describe the bus connector.
> Definition is inspired from mediatek,mtu3.yaml.
> 
> This fixes some errors seen when running "make dtbs_check":
> ... 'port' does not match any of the regexes: 'pinctrl-[0-9]+'
>         From schema: ... Documentation/devicetree/bindings/usb/dwc2.yaml
> 
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
> ---
>  Documentation/devicetree/bindings/usb/dwc2.yaml | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/usb/dwc2.yaml b/Documentation/devicetree/bindings/usb/dwc2.yaml
> index 10c7d9b..7d1aa53 100644
> --- a/Documentation/devicetree/bindings/usb/dwc2.yaml
> +++ b/Documentation/devicetree/bindings/usb/dwc2.yaml
> @@ -130,6 +130,16 @@ properties:
>      description: If present indicates that we need to reset the PHY when we 
>        detect a wakeup. This is due to a hardware errata.
>  
> +  port:
> +    description:
> +      Any connector to the data bus of this controller should be modelled
> +      using the OF graph bindings specified, if the "usb-role-switch"
> +      property is used. See graph.txt

Drop 'See graph.txt'

> +    $ref: /schemas/graph.yaml#/properties/port
> +
> +dependencies:
> +  port: [ 'usb-role-switch' ]

usb-role-switch without port is valid or both must be present. In case 
of the latter, you need to add:

usb-role-switch: [ port ]

Also, you don't need quotes.

> +
>  required:
>    - compatible
>    - reg
> -- 
> 2.7.4
> 
> 
