Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F14C30F34B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 13:40:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236097AbhBDMjd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 07:39:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235605AbhBDMj2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 07:39:28 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47C3BC0613D6
        for <linux-kernel@vger.kernel.org>; Thu,  4 Feb 2021 04:38:48 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id d26so811064pfn.5
        for <linux-kernel@vger.kernel.org>; Thu, 04 Feb 2021 04:38:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2dvgQdQ6hKfQnFN6cqPppjkW9v8eA0H2PjYK802sxpo=;
        b=BNEQCznMNh8r0jLb9D7EexdCQzuEeG7tRhc7/5Xr5bLtHg4/YMMeu1f33qhVQ9k6x5
         c9X8mzULfLUvJyNGW2KJVU+8n3yw3b0JOiWwHVMipnqOmi7mB2y8rcpL3Q3Er1LWIeXd
         HXqodl8ZmCUwNkKHina/mvRq/XjerB7irxnK5etoEZB3UKFE+7dIMa8zN3Jlc9jtjvv2
         RPpXBGkKCz3vl4ROsdeXfEfxVUJIvFQk+kaGQsY2Km8cWCZnHRsOetVp1OicJtm9DUXd
         r8UjH2Xj3lxH6N+iGsAZSnr01RwmNS8nzKfkmcXKzqe172Y76mzvpDD1aren5hp8cfHv
         /q/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2dvgQdQ6hKfQnFN6cqPppjkW9v8eA0H2PjYK802sxpo=;
        b=SLVEyU0PuIzgSnC9ho3JCgDbagj67C84wiY5e3iwgc7Ju+6LVQq/aKe748nIucC1cE
         eiwFQ5uXYwudB1iwVw6OLNB6eKSBLEGgl50zR/GQyHS3aJyFr08HVEHNKB5KTbWgd5LY
         ILWaX5/S1/jpi78XXa7iTqOjnecqBYjyTyIYIn0ZdA8EQGaxnrGnD5ieFpwLhDBpxodZ
         kTYM91rceA07GAIr+WyksGc5r1EYFF057x4Cyiuq06450A/TpaS+xSKDDG889XVlzwTd
         3jQzqOksoLydeUCG26+b653kyHKgomTvVK3GM3nmt50O83HtqIo7At5AlA4Gx3g/3L+R
         pO/Q==
X-Gm-Message-State: AOAM530HCKsT0PcmDBHCfPqx8uNdzwIfpr5ZYGesw6j5zzWYzd0dtOrR
        tgl2CvPp/W20rq2y3XuBIJ8rzfAtn9u+fMouhkgOZQ==
X-Google-Smtp-Source: ABdhPJy3NmQ6w+rzYQfD4UrbFDVSoOhOsQHrBW+h26hmwT2e06tr4AzZ5nWGZCFbAK/jlrd3r9KmgGEneSIqEODKxKM=
X-Received: by 2002:a63:5b4f:: with SMTP id l15mr8863564pgm.339.1612442327673;
 Thu, 04 Feb 2021 04:38:47 -0800 (PST)
MIME-Version: 1.0
References: <cover.1611802321.git.xji@analogixsemi.com> <246b8bd6e51ed5c8cb3618f4259adf8aba319511.1611802321.git.xji@analogixsemi.com>
In-Reply-To: <246b8bd6e51ed5c8cb3618f4259adf8aba319511.1611802321.git.xji@analogixsemi.com>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Thu, 4 Feb 2021 13:38:36 +0100
Message-ID: <CAG3jFyu0qj_ipqz8eKWtmkjKDBBAF_X20f1i-d=83vksgh6nxg@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] dt-bindings:drm/bridge:anx7625:add vendor define flags
To:     Xin Ji <xji@analogixsemi.com>
Cc:     Rob Herring <robh+dt@kernel.org>, David Airlie <airlied@linux.ie>,
        Nicolas Boichat <drinkcat@google.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sam Ravnborg <sam@ravnborg.org>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Maxime Ripard <mripard@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        =?UTF-8?Q?Ricardo_Ca=C3=B1uelo?= <ricardo.canuelo@collabora.com>,
        dri-devel@lists.freedesktop.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Sheng Pan <span@analogixsemi.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Xin,

On Thu, 28 Jan 2021 at 04:10, Xin Ji <xji@analogixsemi.com> wrote:
>
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

Maybe MIPI DSI/DPI input is more correct, since there are a lot of
other MIPI standards.

> +
> +        properties:
> +          endpoint:
> +            type: object
> +            additionalProperties: false
> +
> +            # Properties described in
> +            # Documentation/devicetree/bindings/media/video-interfaces.txt
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
