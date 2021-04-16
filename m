Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF7A936199D
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 08:01:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238932AbhDPF6o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 01:58:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236787AbhDPF6f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 01:58:35 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3703FC061574;
        Thu, 15 Apr 2021 22:58:11 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id i81so26769758oif.6;
        Thu, 15 Apr 2021 22:58:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Ze0E4HckaFH5mJg66hViAQBt3akuirU2NsikBcdw7Ls=;
        b=qJRTgttDvK9iZe0dwcrtYQMSQMFZK4D2s51cYpBDMULGJ1jtblkpfMyafwedvaarfh
         PvGjqPITGHIeajL5QUtoBWBoVK4oKJFTzQuJl0i/5GdqNd9bQ3XKGdcQx/4aq1hAqpCX
         PY7VkAV+qRiK0O9IQO1qg51+76s0AWNfmyMBDQEuQxXYYhyxnoTxE5wXdhckqS7pwkf+
         lOQ487LH59h2nv7+fk6LqTcY2it57EyAdor1Fm0vhpg1a8VUUP7obkk1NG9Hk4Zp9elu
         u2RzIsjFT/LQ1Ul0gwqczienwM7FYG3iZvjG3H29YXphJLIcL+PTMhH9qu8jqTk11HNN
         WY8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Ze0E4HckaFH5mJg66hViAQBt3akuirU2NsikBcdw7Ls=;
        b=P1WwpZATktXSt5AaHY4qdy+ygTHDF1tRYe20JWmHlCZBatguUIDkzanz/vAgBNVzpI
         VXJNeyhrtv2dxjXUbXj9EkLrxOc9N5jKkvCR83i16E62g071nl2nm8Szq8DzwGk5PKcl
         /MaQa7xsyk9h0J9r66Hm9rXSPZmofIvlOAsCxCg24mxAUfeq19Un3C9FGKIByG2gOR+Z
         UYdp+M1+I+KC1tRd39o7VjJcBToECYKJDXTolRp+9ucUKLcR+lWJ+570gP0iacGYZ/2u
         aM5LODvOOINB4Xli01SWL+AZx9szNj4LtDlMyte+4tfcg2kNqcVOCYtwuJ9XnzzJk2cF
         A/kA==
X-Gm-Message-State: AOAM530zOBPiIrrcv+FbK4fhAwEmhDBG3ftphEyctnqkwm4N26WtaiBZ
        jq/wAqaE53dS40aTV52LQUEBfM0XR3qVkNGGF9A=
X-Google-Smtp-Source: ABdhPJx8nO9o2WPSuUZ1vQVPGCgRInpsGr+23PnyET35hB7M1rBLSeV+ffHh6TEno7oYmmY/u4DtIRfYEvO7VCn6Cig=
X-Received: by 2002:a05:6808:bd6:: with SMTP id o22mr5259675oik.129.1618552690038;
 Thu, 15 Apr 2021 22:58:10 -0700 (PDT)
MIME-Version: 1.0
References: <20210415093519.1920877-1-hsinyi@chromium.org> <20210415093519.1920877-4-hsinyi@chromium.org>
In-Reply-To: <20210415093519.1920877-4-hsinyi@chromium.org>
From:   Enric Balletbo Serra <eballetbo@gmail.com>
Date:   Fri, 16 Apr 2021 07:58:01 +0200
Message-ID: <CAFqH_506gmouWeLRXhRbUpaQ7Xb+bOOJt_65GnPsYE4oRs05XA@mail.gmail.com>
Subject: Re: [PATCH 4/8] dt-bindings: arm64: dts: mediatek: Add mt8183-kukui-jacuzzi-kenzo
To:     Hsin-Yi Wang <hsinyi@chromium.org>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Sean Wang <sean.wang@mediatek.com>,
        Ben Ho <Ben.Ho@mediatek.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hsin-Yi,

Thank you for your patch.

Missatge de Hsin-Yi Wang <hsinyi@chromium.org> del dia dj., 15 d=E2=80=99ab=
r.
2021 a les 11:36:
>
> Kenzo is known as Acer Chromebook 311.
>
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>

Reviewed-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

> ---
>  Documentation/devicetree/bindings/arm/mediatek.yaml | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/arm/mediatek.yaml b/Docume=
ntation/devicetree/bindings/arm/mediatek.yaml
> index 0870490aa350..39e4a99ebb37 100644
> --- a/Documentation/devicetree/bindings/arm/mediatek.yaml
> +++ b/Documentation/devicetree/bindings/arm/mediatek.yaml
> @@ -137,9 +137,11 @@ properties:
>          items:
>            - const: google,damu
>            - const: mediatek,mt8183
> -      - description: Google Juniper (Acer Chromebook Spin 311)
> +      - description: Google Juniper (Acer Chromebook Spin 311) / Kenzo (=
Acer Crhomebook 311)
>          items:
> -          - const: google,juniper-sku16
> +          - enum:
> +              - google,juniper-sku16
> +              - google,juniper-sku17
>            - const: google,juniper
>            - const: mediatek,mt8183
>        - description: Google Kakadu (ASUS Chromebook Detachable CM3)
> --
> 2.31.1.295.g9ea45b61b8-goog
>
>
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
