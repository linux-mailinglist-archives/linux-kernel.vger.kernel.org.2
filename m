Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B22A1414601
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 12:17:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234901AbhIVKSt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 06:18:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234734AbhIVKSZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 06:18:25 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E54AC061757
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 03:16:55 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id a10so7501839qka.12
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 03:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=q7fvXndN10Ipglqr4AHb8oRIhQA/vreSOhtihIaad+U=;
        b=48Mw+XRsurH8oTh8wtDj9/25h/FB6GX1MdkEq7POsBngKQ/neYNIrVTt33Afxv1KB0
         q3P+k/l+tqUjaEXm5jbPCUjRVVmNzQ83MNydgZi11iA9GaudMP/W7zWKHGA0XWahv0O+
         O8V9OrtN9ugcfwzJFrhAGCe6Xr52L7/Svqq20XZWGymgDQq2l42yqjPfxf4mrUdbjqes
         PuXncSvIltr5gzWIuw1yM8P0cNUkOm2QC3eDyXXBE1krmm+z8vcSiS+BBUoQfFPvaANa
         DJtD8o0jRwvqHlJlOwLUl+AZfucfNBGuMhUT0tAG9Czp2MCa7z/yrzrtUASMd2l2Fanu
         PrBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q7fvXndN10Ipglqr4AHb8oRIhQA/vreSOhtihIaad+U=;
        b=KmYB6vCWlrLXhhR2g+Yct2JS1Ftb7ql4hFDyoiz2CLFeX1ycvUqNV2/Yc1pvtYhe/a
         QGaC0SeFG9wf/9trmEXn96QE9DuyawQcjsP2hWpmNJqG9AXmRGWR8qrB9XHTh29ca72y
         +KRlsePjZSqXDCjrP5Gpp3WLuys6Lx6v1Kfv7mCaPxfXMu0saWjc67aSL11Ot4pyKNyM
         hJPtG3aXibGZajNUfuVxwVh9Uk/9hhTCAXZkMYr9/8sauo7Aq1RbBA6pdUOVkIhkMfub
         GAgZHO7yYOGX9mB9PXgUvDLQgc8PmZkqdVv6XlywbrvHsvbvDMeKYm/wOZphc4J2OPfk
         34kw==
X-Gm-Message-State: AOAM533u358RO6vUSoMei2VuoxJ91wS7Nl6/5bwDZF9Yl3l+no85YTAW
        Ov5zSrNwISl+keHrbYKOO4GI9PHePYxmWSv8pWwJwA==
X-Google-Smtp-Source: ABdhPJww9MgeiCCpnhZiXnuJ5lQQX46bvMr/qfds4aQ5sHanvBoArj2RMHPXYJGbXPzSv2RH0zmy5lFz9MGvj5ru+vk=
X-Received: by 2002:a25:cbc3:: with SMTP id b186mr42843421ybg.199.1632305814753;
 Wed, 22 Sep 2021 03:16:54 -0700 (PDT)
MIME-Version: 1.0
References: <20210716221744.5445-1-robert.marko@sartura.hr> <20210716221744.5445-2-robert.marko@sartura.hr>
In-Reply-To: <20210716221744.5445-2-robert.marko@sartura.hr>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Wed, 22 Sep 2021 12:16:44 +0200
Message-ID: <CAMpxmJWbGM8=S3Dimq33T3vnAnP5kkgNHu3m8oTAO6=LttRzxw@mail.gmail.com>
Subject: Re: [PATCH 2/2] dt-bindings: gpio: tn48m: document TN4810M support
To:     Robert Marko <robert.marko@sartura.hr>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-gpio <linux-gpio@vger.kernel.org>,
        linux-devicetree <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, luka.perkov@sartura.hr
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 17, 2021 at 12:17 AM Robert Marko <robert.marko@sartura.hr> wrote:
>
> Delta TN4810M expands the existing TN48M drivers, so lets
> document the new compatibles.
>
> Note that this patch depends on the following series:
> https://patchwork.ozlabs.org/project/linux-gpio/list/?series=247538
>
> Signed-off-by: Robert Marko <robert.marko@sartura.hr>
> ---
>  Documentation/devicetree/bindings/gpio/delta,tn48m-gpio.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/gpio/delta,tn48m-gpio.yaml b/Documentation/devicetree/bindings/gpio/delta,tn48m-gpio.yaml
> index aca646aecb12..d729c5dbed65 100644
> --- a/Documentation/devicetree/bindings/gpio/delta,tn48m-gpio.yaml
> +++ b/Documentation/devicetree/bindings/gpio/delta,tn48m-gpio.yaml
> @@ -24,6 +24,10 @@ properties:
>        - delta,tn48m-gpio-sfp-tx-disable
>        - delta,tn48m-gpio-sfp-present
>        - delta,tn48m-gpio-sfp-los
> +      - delta,tn4810m-gpio-sfp-tx-disable
> +      - delta,tn4810m-gpio-sfp-tx-fault
> +      - delta,tn4810m-gpio-sfp-present
> +      - delta,tn4810m-gpio-sfp-los
>
>    reg:
>      maxItems: 1
> --
> 2.31.1
>

This series is still not upstream - what happened to it?

Bart
