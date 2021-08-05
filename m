Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A15C3E1C2C
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 21:09:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242307AbhHETJb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 15:09:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242501AbhHETJV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 15:09:21 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F5E3C061799
        for <linux-kernel@vger.kernel.org>; Thu,  5 Aug 2021 12:09:04 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id w17so10724498ybl.11
        for <linux-kernel@vger.kernel.org>; Thu, 05 Aug 2021 12:09:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=66klr3RRk6o66gBKNdZEM7W2NMGH3F3MK/aEyxf87PI=;
        b=n/RdEz7x4Hdz972oDHKkOLKisyM+jGDoux+WTvW8scFrttaTpF7jvhZvrEe7sA0E/9
         AA5A5hzv/R7EUmAyoHMqBw1MeqDbJFfK1idnqIjR26dLjaJiwb6qdHMck+n2WqUqZZw/
         TB1Hab00zIU6gIG8ODCyQIV5VKvKstBT8cqdWR/3VMIqObWAAdCkWmp7YDPM381priUE
         IYlETrBGENW2IEIL5h6+nEJvgZHohoYMLp275zXc7+u8ZoFtBYPbzbOIFPxhKdj4kYl4
         CApL86Zh+6UveyxJtjeM6FqW6Hh97L8R+Jcpq7ZpWm7ZrKkAYhIAFArfgyssbthugUDm
         6UVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=66klr3RRk6o66gBKNdZEM7W2NMGH3F3MK/aEyxf87PI=;
        b=WMfQx1wzBqpSca04yfGtPFSZYLXa/C3lC4R3ZBQQtcjUuZw4757Gox1mF+PQ19IUYq
         MeYRKwfB6yth9Oe/yS31cEyE50iin10SOy9GpOha5X1VtLjMQJj8IU1kQ/Usy3QHNt9j
         B5vZ8LMxlMsMggNmI34dEAl7a2gt6XTwaWXMsL3HUVSsLuIw9YuujoU3J/oQYssOk/nQ
         g9sWspIB8tMIGLGGpR0+e0N9pZaKSvQ1s+7xG58lHjZIPkIEf7kk5qzSBP5iv8fAgwr3
         iH3mnYoXvShYmQRHgHjwv6EQE+qZTATJe7eOdsRXKBoISZzB1fGBq7RLxkm1sWy1Oky3
         CUjA==
X-Gm-Message-State: AOAM531EJVU5Wmmb/VaIcw+ISTvgxO6EYAYYpNNQPhI0j4fOsYuyXced
        K1hOKPhFf+evZiD2lJ1HnNF58bC3F5Au70AH8a5goQ==
X-Google-Smtp-Source: ABdhPJzW09jDFnZCROZvMGrpzmvOaLe++zLkGJEfyvO5tZXGesyIoWyTosfywba8jYtMHoOawEh2J1DGnf1TAwFpxf4=
X-Received: by 2002:a25:db89:: with SMTP id g131mr7906029ybf.302.1628190543546;
 Thu, 05 Aug 2021 12:09:03 -0700 (PDT)
MIME-Version: 1.0
References: <1628105086-8172-1-git-send-email-raagjadav@gmail.com> <1628105086-8172-3-git-send-email-raagjadav@gmail.com>
In-Reply-To: <1628105086-8172-3-git-send-email-raagjadav@gmail.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Thu, 5 Aug 2021 21:08:52 +0200
Message-ID: <CAMpxmJXsOHR0xTsMNqdqydboRiaj7iRnCSQT98uGX2woUUPVEA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] dt-bindings: at24: add ON Semi CAT24C04 and CAT24C05
To:     Raag Jadav <raagjadav@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Li Yang <leoyang.li@nxp.com>,
        linux-i2c <linux-i2c@vger.kernel.org>,
        linux-devicetree <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        arm-soc <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 4, 2021 at 9:25 PM Raag Jadav <raagjadav@gmail.com> wrote:
>
> Add bindings for ON Semi CAT24C04 and CAT24C05 eeproms,
> which are compatible with Atmel AT24C04.
>
> Signed-off-by: Raag Jadav <raagjadav@gmail.com>
> ---
>  Documentation/devicetree/bindings/eeprom/at24.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/eeprom/at24.yaml b/Documentation/devicetree/bindings/eeprom/at24.yaml
> index 914a423..4c5396a 100644
> --- a/Documentation/devicetree/bindings/eeprom/at24.yaml
> +++ b/Documentation/devicetree/bindings/eeprom/at24.yaml
> @@ -98,6 +98,12 @@ properties:
>            - const: nxp,se97b
>            - const: atmel,24c02
>        - items:
> +          - const: onnn,cat24c04
> +          - const: atmel,24c04
> +      - items:
> +          - const: onnn,cat24c05
> +          - const: atmel,24c04
> +      - items:
>            - const: renesas,r1ex24002
>            - const: atmel,24c02
>        - items:
> --
> 2.7.4
>

Applied, thanks!

Bartosz
