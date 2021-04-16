Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13FA7361990
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 08:01:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238865AbhDPF5J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 01:57:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238843AbhDPF5I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 01:57:08 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34AA1C061756;
        Thu, 15 Apr 2021 22:56:43 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id n184so743284oia.12;
        Thu, 15 Apr 2021 22:56:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=kS57iiOa0AGHkUaGIRJozUL71gHvC57WJEZwM6v3V14=;
        b=UpCWEGb8NJ6bZ5/8DkI7x52RqEg7jfX1hhsKz9FtR96RgK0RNurxNWriMVVmSzQQak
         bZKOePt3I24vEzbYf6iekOhDLwojaS+SvE2FPK8Rx2dD1zqWgZ8AZWUprHgcCX+B5Isf
         bAjAWQ5RB3NrIE82iyBNJPgha0EtA0euWxoXYEjx0l4JtrS+6iWztFxmktTPRqX/36Ou
         5XgbqkqYnp2yHSkZuiP9QY9jZNsBnBROirUq7OQeI1EFBxYrwWVzgJsSkSs84crzQJAD
         GzzGK5Y+lc4qgVpjWRl9TWMluEl+rv3zENBOzcZAHJHBxhorMbk3fpC6Rwjc+Cvq7NO5
         jMrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=kS57iiOa0AGHkUaGIRJozUL71gHvC57WJEZwM6v3V14=;
        b=Oeq1mqgHo6Pp+MZE5U8pI7fAnpZtntUbBRoxJNa68fBGzDUnjdF1iDQUhvqxTKm/ny
         Yz0n8eIM3kxhUOtMIA9eZshlPLC0KEJk41Q4ye8lDTDjYKWywM+eXyX+dZrawlIMrsUi
         MlHSGykFBWPg4WNW+lSH1UXnehmlRFiSxQ0rSiNxQhb+yGaN6HMqKxyKXc8U3U7CbawV
         9BV5x0W+nTyoMlBzO0qpXrLoj8NIgl5sTNUecns2/Nyn6t925Kgx3wr5LLJEO0MNkwzs
         xGoHeY4p4Z+3oFYXnLDT+cYOFAUtVAXBS7JefIarSXL/x+0ig+pKL4jo1dXz0k3BW/uY
         uEtw==
X-Gm-Message-State: AOAM530wETxDsg4zgqAbVdkTb5lOeezt3puT1YrnDBudpHc2VX9/1goP
        Niq9jMTvMRZIlFOnmmncn3xdMYW38ebOXY5d/ic=
X-Google-Smtp-Source: ABdhPJymhDuEtEnD+Fy/IUfcVZZ89XR8eRsUMCgAQ1y3Y1XFsaC/aS5rMV3CqroE+T+Rv+aaJReYZqP4yA5Fzn4GVnk=
X-Received: by 2002:aca:b408:: with SMTP id d8mr5312478oif.47.1618552602684;
 Thu, 15 Apr 2021 22:56:42 -0700 (PDT)
MIME-Version: 1.0
References: <20210415093519.1920877-1-hsinyi@chromium.org> <20210415093519.1920877-2-hsinyi@chromium.org>
In-Reply-To: <20210415093519.1920877-2-hsinyi@chromium.org>
From:   Enric Balletbo Serra <eballetbo@gmail.com>
Date:   Fri, 16 Apr 2021 07:56:33 +0200
Message-ID: <CAFqH_51rfSf5QR5xE5v=Fky5djT3uR_=0Ho8hD-wXS57tNXtpw@mail.gmail.com>
Subject: Re: [PATCH 2/8] dt-bindings: arm64: dts: mediatek: Add mt8183-kukui-jacuzzi-willow
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

Hi Hsin-Yi.

Thank you for your patch.

Missatge de Hsin-Yi Wang <hsinyi@chromium.org> del dia dj., 15 d=E2=80=99ab=
r.
2021 a les 11:36:
>
> Willow is known as Acer Chromebook 311 (C722/C722T).
>
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>

Reviewed-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

> ---
>  Documentation/devicetree/bindings/arm/mediatek.yaml | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/arm/mediatek.yaml b/Docume=
ntation/devicetree/bindings/arm/mediatek.yaml
> index 81b86b189a8d..96c401597bd8 100644
> --- a/Documentation/devicetree/bindings/arm/mediatek.yaml
> +++ b/Documentation/devicetree/bindings/arm/mediatek.yaml
> @@ -157,6 +157,13 @@ properties:
>                - google,kodama-sku32
>            - const: google,kodama
>            - const: mediatek,mt8183
> +      - description: Google Willow (Acer Chromebook 311 C722/C722T)
> +        items:
> +          - enum:
> +              - google,willow-sku0
> +              - google,willow-sku1
> +          - const: google,willow
> +          - const: mediatek,mt8183
>        - items:
>            - enum:
>                - mediatek,mt8183-pumpkin
> --
> 2.31.1.295.g9ea45b61b8-goog
>
>
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
