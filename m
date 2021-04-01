Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76DDD351105
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 10:42:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233624AbhDAIlz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 04:41:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233383AbhDAIlj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 04:41:39 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11CCAC0613E6
        for <linux-kernel@vger.kernel.org>; Thu,  1 Apr 2021 01:41:39 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id j6-20020a17090adc86b02900cbfe6f2c96so653791pjv.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Apr 2021 01:41:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IXNOp7cXhuLe5p1dDGf1ROatU9pUcUu1AUYD78x1H78=;
        b=KlEn+doHT/1eaDCvXo2Ezxer5ewn9NDK82VGmDpGKMDoJc54wJ8CSGLguexIjb6y6y
         vVy58LrgZuEYUx68uPZoM+HhVKClw8jJcOgBtO3Hzb6qPosf7Ijs3EbFdkx757ktICMy
         8SCE4jf4O/x+OPlMrOa9uS8SExBAhxRO/WgOV5LKAI+9bcgapztVcJ9mWjIciWKH0oJu
         Cu2kPa98lKbAsflGUxnVXpXBCazY34oDPUUgeU4azonRyZXN7YlRy2C0bAcKIinvIIpq
         abnZThBjFF27oO57Om0Zopwees74T0a+cOxjLbaHz0Wm2G9LrRqNMMXmb3TrgtYcJWej
         ZC5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IXNOp7cXhuLe5p1dDGf1ROatU9pUcUu1AUYD78x1H78=;
        b=I1TGwNzg1k/qPcfAXhBiKcVCSRG34V/1LQMSGJxuPwkuPV35wm3tIUWldpsZdTFGef
         Q1cwLjuS+fWq+MWeCWJvPiHX0vC33u8fR7UQ5iDyvHnLNmcyghh85rjr2jVS2ww3rQrn
         fKkpDp/lH35SwbROa/gNfpIL9AWD+Bv9YEDW2EL1wNuOjy1y7twouDv5aAdlsb+fPHiV
         eu3SoWJD7pemHC8MEQqt67jwHhpWcx1xl8yzf2qDgEHDtCrNAySRMOFe85xdSRZ4jtp3
         Hd3e2uQuBX5WRbaVoz1B0xr4xETr1D+IWBVvHaS1rpoOlfiEpwiq9Ub9S1Tx9fb2Twc3
         CudQ==
X-Gm-Message-State: AOAM533Tm9UMSbvD9i9ufJFsUS9bpEi5Urvrm3xupzl2SuQeIWAULBhk
        +hMJZs78hbMhphjKdvQcpiLeEbLmMK01vQhUrkPBsw==
X-Google-Smtp-Source: ABdhPJzYIaLiC0MYJA3XRB6eqAIr3Ww013zSL3r6maBxPLMQDTa8/OSTf3qvuQlUEYOLz89xr4IkXKa1l4xTMuHVSv4=
X-Received: by 2002:a17:902:7d8d:b029:e6:4061:b767 with SMTP id
 a13-20020a1709027d8db02900e64061b767mr7050428plm.32.1617266498537; Thu, 01
 Apr 2021 01:41:38 -0700 (PDT)
MIME-Version: 1.0
References: <20210401053202.159302-1-hsinyi@chromium.org>
In-Reply-To: <20210401053202.159302-1-hsinyi@chromium.org>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Thu, 1 Apr 2021 10:41:27 +0200
Message-ID: <CAG3jFytABggTSGVan97Gi-9Y5N1Xf3eEBTWBrPhSmrJVu56Zpw@mail.gmail.com>
Subject: Re: [RESEND PATCH v4 1/2] dt-bindings: drm/bridge: anx7625: Add power supplies
To:     Hsin-Yi Wang <hsinyi@chromium.org>
Cc:     Sam Ravnborg <sam@ravnborg.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        David Airlie <airlied@linux.ie>, Xin Ji <xji@analogixsemi.com>,
        Rob Herring <robh+dt@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Hsin-Yi,

Thanks for the reminder, just merged the series.

https://cgit.freedesktop.org/drm/drm-misc/commit/?id=2f240cdb23e9cde551d99c77f4e60062188d8d81

On Thu, 1 Apr 2021 at 07:32, Hsin-Yi Wang <hsinyi@chromium.org> wrote:
>
> anx7625 requires 3 power supply regulators.
>
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Reviewed-by: Robert Foss <robert.foss@linaro.org>
> ---
> v3->v4: rebase to drm-misc/for-linux-next
> ---
>  .../bindings/display/bridge/analogix,anx7625.yaml | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/display/bridge/analogix,anx7625.yaml b/Documentation/devicetree/bindings/display/bridge/analogix,anx7625.yaml
> index c789784efe306..ab48ab2f4240d 100644
> --- a/Documentation/devicetree/bindings/display/bridge/analogix,anx7625.yaml
> +++ b/Documentation/devicetree/bindings/display/bridge/analogix,anx7625.yaml
> @@ -34,6 +34,15 @@ properties:
>      description: used for reset chip control, RESET_N pin B7.
>      maxItems: 1
>
> +  vdd10-supply:
> +    description: Regulator that provides the supply 1.0V power.
> +
> +  vdd18-supply:
> +    description: Regulator that provides the supply 1.8V power.
> +
> +  vdd33-supply:
> +    description: Regulator that provides the supply 3.3V power.
> +
>    ports:
>      $ref: /schemas/graph.yaml#/properties/ports
>
> @@ -55,6 +64,9 @@ properties:
>  required:
>    - compatible
>    - reg
> +  - vdd10-supply
> +  - vdd18-supply
> +  - vdd33-supply
>    - ports
>
>  additionalProperties: false
> @@ -72,6 +84,9 @@ examples:
>              reg = <0x58>;
>              enable-gpios = <&pio 45 GPIO_ACTIVE_HIGH>;
>              reset-gpios = <&pio 73 GPIO_ACTIVE_HIGH>;
> +            vdd10-supply = <&pp1000_mipibrdg>;
> +            vdd18-supply = <&pp1800_mipibrdg>;
> +            vdd33-supply = <&pp3300_mipibrdg>;
>
>              ports {
>                  #address-cells = <1>;
> --
> 2.31.0.291.g576ba9dcdaf-goog
>
