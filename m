Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2EDC427116
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 20:58:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239603AbhJHTAL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 15:00:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:44444 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231459AbhJHTAG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 15:00:06 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E551D60FF2;
        Fri,  8 Oct 2021 18:58:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633719490;
        bh=vJva/HpoeUn+4gPZyR4WLzqjqQsUwQtyF3rf7Q6S3T4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=CgXaABOb9gNGAOqRfRfFgwTItuF6RLY77H3NnriIqYe0Y3fyo8GYxxC9df98OFaYW
         Jb14pYa7EVnXQSU9egbiOzjVbThsZK6povp/ugOQyUC9m6ZJJO5MN6eHFzLUzMRtrr
         whX9r+3s8HoBewDftCu4lNRX4V382LoIQcB+V9/qJ9yyPlDaea6yRr0AeYGHW869Q3
         h6UesZupaY86jn+QKVTYJvjDayKQdn23mMhV+OBQgk9pmv640aoHIE8fs2spitLgEn
         wmAtveTJ3By2OG3Ku4Xlr04l3nWNx2wVGfhXQjDxtafjlQOaZnFbu4arBzJ9m7367n
         ardhDAoiNsdsw==
Received: by mail-ed1-f50.google.com with SMTP id d9so15993192edh.5;
        Fri, 08 Oct 2021 11:58:10 -0700 (PDT)
X-Gm-Message-State: AOAM533XkHzUX3Jm6evTo1xCP6RGO/ndpZXWDVyDFicpAZwFYKfPkwoj
        B0m2xX2/VzbopI6jjacodqSjJ26ECWql/qAwCQ==
X-Google-Smtp-Source: ABdhPJzBttaP056QfvNAp0LGKfTv4Wu68h8vKSUgvj7d/nrVSCz93oZHkNGlo6sQGYTgKEc0qcv31neoUntcj2P7MSM=
X-Received: by 2002:a17:906:71d4:: with SMTP id i20mr6499269ejk.390.1633719489276;
 Fri, 08 Oct 2021 11:58:09 -0700 (PDT)
MIME-Version: 1.0
References: <20210920182114.339419-1-krzysztof.kozlowski@canonical.com>
 <20210920182114.339419-6-krzysztof.kozlowski@canonical.com>
 <YUzuyG3e7sHlMHAJ@robh.at.kernel.org> <8871dd77-f9f1-bf25-78ad-48f97efcf7d9@canonical.com>
In-Reply-To: <8871dd77-f9f1-bf25-78ad-48f97efcf7d9@canonical.com>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 8 Oct 2021 13:57:57 -0500
X-Gmail-Original-Message-ID: <CAL_JsqK4cku0XPgEL=xot67FjfApxLHUDAvbwV6-MvpG_M0aKg@mail.gmail.com>
Message-ID: <CAL_JsqK4cku0XPgEL=xot67FjfApxLHUDAvbwV6-MvpG_M0aKg@mail.gmail.com>
Subject: Re: [PATCH 6/6] dt-bindings: hwmon: jedec,jc42: add nxp,se97b
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jiri Kosina <trivial@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Linux HWMON List <linux-hwmon@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 24, 2021 at 1:57 AM Krzysztof Kozlowski
<krzysztof.kozlowski@canonical.com> wrote:
>
> On 23/09/2021 23:16, Rob Herring wrote:
> > On Mon, Sep 20, 2021 at 08:21:14PM +0200, Krzysztof Kozlowski wrote:
> >> Document bindings for NXP SE97B, a DDR memory module temperature sensor
> >> with integrated SPD and EEPROM via Atmel's AT24 interface.
> >>
> >> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> >> ---
> >>  Documentation/devicetree/bindings/hwmon/jedec,jc42.yaml | 9 +++++++++
> >>  1 file changed, 9 insertions(+)
> >>
> >> diff --git a/Documentation/devicetree/bindings/hwmon/jedec,jc42.yaml b/Documentation/devicetree/bindings/hwmon/jedec,jc42.yaml
> >> index a7bb4e3a1c46..0e49b3901161 100644
> >> --- a/Documentation/devicetree/bindings/hwmon/jedec,jc42.yaml
> >> +++ b/Documentation/devicetree/bindings/hwmon/jedec,jc42.yaml
> >> @@ -10,6 +10,14 @@ maintainers:
> >>    - Jean Delvare <jdelvare@suse.com>
> >>    - Guenter Roeck <linux@roeck-us.net>
> >>
> >> +select:
> >> +  properties:
> >> +    compatible:
> >> +      const: jedec,jc-42.4-temp
> >> +
> >> +  required:
> >> +    - compatible
> >> +
> >
> > Is this supposed to be in the last patch? And why is it needed?
>
> Yes, this is here on purpose because of nxp,se97b which is sensor with
> at24-compatible EEPROM.
>
> arch/arm/boot/dts/at91-nattis-2-natte-2.dts:
> 169         temp@18 {
> 170                 compatible = "nxp,se97b", "jedec,jc-42.4-temp";
>
> 171                 reg = <0x18>;
> 172                 smbus-timeout-disable;
> 173         };
> 174
> 175         eeprom@50 {
> 176                 compatible = "nxp,se97b", "atmel,24c02";
> 177                 reg = <0x50>;
> 178                 pagesize = <16>;
>
> Without the select, dtbs_check was complaining about the second node:
>
> eeprom@50: compatible: 'oneOf' conditional failed, one must be fixed:
>         ['nxp,se97b', 'atmel,24c02'] is too long
>         Additional items are not allowed ('atmel,24c02' was unexpected)
>         'jedec,jc-42.4-temp' was expected
>         From schema:
> /home/dev/linux/linux/Documentation/devicetree/bindings/hwmon/jedec,jc42.yaml
>
> eeprom@50: 'pagesize' does not match any of the regexes: 'pinctrl-[0-9]+'
>         From schema:
> /home/dev/linux/linux/Documentation/devicetree/bindings/hwmon/jedec,jc42.yaml

If a dt only lists one of the vendor specific compatibles, it is going
to pass as this schema won't be applied with this change. We won't get
an undocumented compatible either because it is documented. I don't
have a better suggestion other than listing everything but
'nxp,se97b'. I don't think it is really worth do that, so:

Reviewed-by: Rob Herring <robh@kernel.org>
