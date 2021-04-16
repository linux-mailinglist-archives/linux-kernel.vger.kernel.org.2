Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD89A36198D
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 08:01:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238838AbhDPF43 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 01:56:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237974AbhDPF41 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 01:56:27 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2B9EC061756;
        Thu, 15 Apr 2021 22:56:03 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id l131so21721931oih.0;
        Thu, 15 Apr 2021 22:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=eGb9tO0JgwKxeoNVQTkPx2c1NNPAmkW7z97RD+8YUJA=;
        b=V+Wo7dau0bTz6J3vRoH7RwQPDgtRcYnomjD2vBP38M8N5XgW7reF3k4yfxKNHpQA09
         SkFLXZNnNTBUDwNxkA0augdi0c288AD5L6HEMmhOdIKDjgjGKO8RbCrDFHcevx8lkp8N
         Aj6l8NwHhNZe5snjYVj5TOdSMaZYEf5PwP8Gis5quK+dJ2UfSKkWFqLKx1/4gb4e8V1J
         s6cieQ87HI0e5DoQgSu+RVRiy1KL/oOmLAHHXyr57Br+zcpo7tqpEwoZipxXxnGE1ylU
         NzCaSb5xRSP42YFZcJvjcQ42bclUBKseHhqLha3hsBtypAkqMWowxz9j3QFcw7PcDBvJ
         Yflw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=eGb9tO0JgwKxeoNVQTkPx2c1NNPAmkW7z97RD+8YUJA=;
        b=KTTYA2jPJX8MqdL2J+YpTavcRa0mogEGKbZAwuhzKq5VGiJqp2HFXxJAzvaPq14Po5
         SjKi81P9EwM1nZydMhIV/Y7WFM+lTc7OaIm/LupOF4q9z9SYN0ZiZ7JzZxmKr04JRBpj
         6yl/0U6YNkTYAhl7Ok6apZ0pWDhDp2oy4QMf814nFr0fRa3IjskqPOIKioL48nc/j0qw
         b34juJSYNSYxQrSszYT3jN3wK2flXwIWWTeglA3w2e9RKyg7HAsktPN+fkUOo4D1DhK2
         tTZQvh4qiGVl8XlJmjaliuCkeiCIiFZ80ooiHMhKZoGQZDzCwZdihk1HKgM12t0UBz+I
         q9RA==
X-Gm-Message-State: AOAM5325dy4d2sDXBM2Z/byXHy/93xiVQMbFsmnx3rzdpw26KtGVRASn
        /Pf664UQI/jBlGPt4T81FozjlSm1qwxTa2nJq+c=
X-Google-Smtp-Source: ABdhPJyUG1P2zDXwovNhvUfuCo9ccTWBONlJiEDEMu7B3qbVbom2H7ZLsMjB8RDiVmZcX7glnobvoJ4TsoQGhBaBosA=
X-Received: by 2002:a05:6808:bd6:: with SMTP id o22mr5255727oik.129.1618552563257;
 Thu, 15 Apr 2021 22:56:03 -0700 (PDT)
MIME-Version: 1.0
References: <20210415093519.1920877-1-hsinyi@chromium.org>
In-Reply-To: <20210415093519.1920877-1-hsinyi@chromium.org>
From:   Enric Balletbo Serra <eballetbo@gmail.com>
Date:   Fri, 16 Apr 2021 07:55:54 +0200
Message-ID: <CAFqH_52buFMF6rvyYDgSZ7wCyP2PHXa771N1L28NR8K=XAVO+w@mail.gmail.com>
Subject: Re: [PATCH 1/8] dt-bindings: arm64: dts: mediatek: Add mt8183-kukui-jacuzzi-kappa
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
> Kappa is known as HP Chromebook 11a.
>
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>

Reviewed-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

> ---
>  Documentation/devicetree/bindings/arm/mediatek.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/arm/mediatek.yaml b/Docume=
ntation/devicetree/bindings/arm/mediatek.yaml
> index aff57a8c8c30..81b86b189a8d 100644
> --- a/Documentation/devicetree/bindings/arm/mediatek.yaml
> +++ b/Documentation/devicetree/bindings/arm/mediatek.yaml
> @@ -144,6 +144,10 @@ properties:
>            - const: google,kakadu-rev2
>            - const: google,kakadu
>            - const: mediatek,mt8183
> +      - description: Google Kappa (HP Chromebook 11a)
> +        items:
> +          - const: google,kappa
> +          - const: mediatek,mt8183
>        - description: Google Kodama (Lenovo 10e Chromebook Tablet)
>          items:
>            - enum:
> --
> 2.31.1.295.g9ea45b61b8-goog
>
>
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
