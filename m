Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C77AC315967
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 23:28:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234392AbhBIWY7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 17:24:59 -0500
Received: from mail-yb1-f169.google.com ([209.85.219.169]:40075 "EHLO
        mail-yb1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233149AbhBITmZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 14:42:25 -0500
Received: by mail-yb1-f169.google.com with SMTP id i71so19336110ybg.7;
        Tue, 09 Feb 2021 11:40:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GJFPQ2Ilx++OlRwYhDURW2rh2NMBhJeZYovPyBO0lLM=;
        b=M7B+qQCkaYtWo584MWFVGHTEdWPGIIKhwuw3g22B2LCzBE3PLE6wnMPIfyT3tWXLn+
         IltwCwUQT0LtNmk4abvNXpMY5smamK6nVaKfdXbWhuCozN37mCs1whtvrlr49Vu/JABA
         EjNf+xY2kR3qkoBCVvwgTZGa28hIV2p00fgcbJeF2A6QmSMx5Qbqzms2qrcinfx3yp+7
         UDiebbnRbRnZICPhDuJYK9OZcuHwfg26GvRqKbH3kGQgH8d4i0kAy3ZIUlf2eBCEvZrx
         5r4Ei86RV0fRZ/3sIzTDBTNNrKUxU+t/Sn6mzt6YMpdU76d3qhJ6ka2WNl8yZoes6J80
         cYZQ==
X-Gm-Message-State: AOAM5339vNRbgvBdte2W4XtJ3m17vDMJ0uWdX/hyhp8ydTojQ7jiBOBW
        KdN/BSNFg2WxfOi+vYKxYPkuBKMDvA==
X-Google-Smtp-Source: ABdhPJz5cVwP1C15lX4pHusdFwtbNSqO2ZM3QELnNfk3yoegBRN1B/LqtqKPlcHeP8B5ax2zQPfq5g==
X-Received: by 2002:a9d:303:: with SMTP id 3mr16767236otv.301.1612899012649;
        Tue, 09 Feb 2021 11:30:12 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id j68sm4481922otc.6.2021.02.09.11.30.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Feb 2021 11:30:11 -0800 (PST)
Received: (nullmailer pid 12877 invoked by uid 1000);
        Tue, 09 Feb 2021 19:30:10 -0000
Date:   Tue, 9 Feb 2021 13:30:10 -0600
From:   Rob Herring <robh@kernel.org>
To:     Xin Ji <xji@analogixsemi.com>
Cc:     David Airlie <airlied@linux.ie>,
        Nicolas Boichat <drinkcat@google.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sam Ravnborg <sam@ravnborg.org>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Maxime Ripard <mripard@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Ricardo =?iso-8859-1?Q?Ca=F1uelo?= 
        <ricardo.canuelo@collabora.com>, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, Sheng Pan <span@analogixsemi.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/3] dt-bindings:drm/bridge:anx7625:add vendor define
 flags
Message-ID: <20210209193010.GA4675@robh.at.kernel.org>
References: <cover.1611802321.git.xji@analogixsemi.com>
 <246b8bd6e51ed5c8cb3618f4259adf8aba319511.1611802321.git.xji@analogixsemi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <246b8bd6e51ed5c8cb3618f4259adf8aba319511.1611802321.git.xji@analogixsemi.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 28, 2021 at 11:08:26AM +0800, Xin Ji wrote:
> Add 'bus-type' and 'data-lanes' define for port0, add HDCP support
> flag and DP tx lane0 and lane1 swing register array define.
> 
> Signed-off-by: Xin Ji <xji@analogixsemi.com>
> ---
>  .../bindings/display/bridge/analogix,anx7625.yaml  | 54 +++++++++++++++++++++-
>  1 file changed, 53 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/display/bridge/analogix,anx7625.yaml b/Documentation/devicetree/bindings/display/bridge/analogix,anx7625.yaml
> index c789784..048deec 100644
> --- a/Documentation/devicetree/bindings/display/bridge/analogix,anx7625.yaml
> +++ b/Documentation/devicetree/bindings/display/bridge/analogix,anx7625.yaml
> @@ -34,6 +34,24 @@ properties:
>      description: used for reset chip control, RESET_N pin B7.
>      maxItems: 1
>  
> +  analogix,lane0-swing:
> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> +    maxItems: 20
> +    description:
> +      an array of swing register setting for DP tx lane0 PHY, please don't
> +      add this property, or contact vendor.
> +
> +  analogix,lane1-swing:
> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> +    maxItems: 20
> +    description:
> +      an array of swing register setting for DP tx lane1 PHY, please don't
> +      add this property, or contact vendor.
> +
> +  analogix,hdcp-support:
> +    type: boolean
> +    description: indicate the DP tx HDCP support or not.

Please show the new properties in the example.

> +
>    ports:
>      $ref: /schemas/graph.yaml#/properties/ports
>  
> @@ -41,13 +59,45 @@ properties:
>        port@0:
>          $ref: /schemas/graph.yaml#/properties/port
>          description:
> -          Video port for MIPI DSI input.
> +          Video port for MIPI input.
> +
> +        properties:
> +          endpoint:
> +            type: object
> +            additionalProperties: false
> +
> +            # Properties described in
> +            # Documentation/devicetree/bindings/media/video-interfaces.txt

Now video-interfaces.yaml which should have a $ref here. It's currently 
in media tree and linux-next. Follow the examples there. You'll also 
have to wait for 5.12-rc1 to apply to drm-misc.

> +            properties:
> +              remote-endpoint: true
> +              bus-type: true
> +              data-lanes: true
> +
> +            required:
> +              - remote-endpoint
> +
> +        required:
> +          - endpoint
> +
>  
>        port@1:
>          $ref: /schemas/graph.yaml#/properties/port
>          description:
>            Video port for panel or connector.
>  
> +        properties:
> +          endpoint:
> +            type: object
> +            additionalProperties: false
> +
> +            # Properties described in
> +            # Documentation/devicetree/bindings/media/video-interfaces.txt
> +            properties:
> +              remote-endpoint: true
> +
> +            required:
> +              - remote-endpoint
> +
>      required:
>        - port@0
>        - port@1
> @@ -81,6 +131,8 @@ examples:
>                      reg = <0>;
>                      anx7625_in: endpoint {
>                          remote-endpoint = <&mipi_dsi>;
> +                        bus-type = <5>;
> +                        data-lanes = <0 1 2 3>;
>                      };
>                  };
>  
> -- 
> 2.7.4
> 
