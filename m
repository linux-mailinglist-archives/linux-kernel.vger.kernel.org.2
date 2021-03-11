Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36E9C33699A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 02:23:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230002AbhCKBWx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 20:22:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230076AbhCKBWm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 20:22:42 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0741BC061574
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 17:22:42 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id x4so30237771lfu.7
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 17:22:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=7yueRKf7NTloS21McCcBQmqTDQypapEcd+sak21ArKU=;
        b=uohEnWHsg2DVXLLmEZDnJShk3Lpaj+XRXUVv5r9VczfY9UX95z9wHyIZKse31Pmjr0
         E8+Mv0kjlMfXkrCfhRtEBavplgbS4QGZiA59/obV0IUquoczYumA1LNrxWca+dL87PmD
         MbCIyD71DO66VtXpZkIrU3GmsHuuIh/Md4WUu7nU004yjpggzISIJndYoIJ5KKPR7L7G
         QwL8UazybQszCFqD9S6m3/G2DCfeYTfiLPsyDbMieUgXXtbnSgbaUBHSplwZm7qYsJUW
         Dd5LUus+wc3fg6B/lTE24PEcV6bZUzxxZF2WeWx5yXQR/n0/7e+InUaeftJUQKL2rufn
         8SEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=7yueRKf7NTloS21McCcBQmqTDQypapEcd+sak21ArKU=;
        b=jSxoPLh2rMt6a6qx4XgC7nT2yH1i4CrCHoGKEqi6fmf/wKV9ukB2ENXm4X93tEVdpJ
         oKLz9UmwI6bobsgraRiZzjm72gfdV8Nyo/WkVuMqhhhmoZtX2mvqn3aeplvQtC3NpYt8
         jgl/EoP+jZw5eS1ynNH7QdGI8gbIEJh4LPsKuu1ASyv2dXmS509KYpqF4mVjvKv0HO+p
         dylnluj8Hh62S8dsBfTEN+BN+VGth6Pf1X5iqxVSpkjlYJlYcsB8naBAvYBl20fOC3M0
         CC/dvcYMRdPZcfEKcdkj+jqTm3fhH/QROBIjZTvYOqg9Pli50tAOkS9Nz7kkyW0Tv3uW
         BGdA==
X-Gm-Message-State: AOAM533Hy7VsebC2Ps6Qk/B4/uPAT+tMls5oeayEZCDBEer/VhiC5ubG
        N8FlexcRNf4ofER0cmxTBMH9kh2JCWOS2gpI5LXVTg==
X-Google-Smtp-Source: ABdhPJx/BkUrEWBn3EpUI4WDL90u3zHiaFEheDbujel4KL04+8DIyQYEkc9huFNfzgtcr/ZBnmWTojh55Tjw+M1XjB4=
X-Received: by 2002:a19:4c08:: with SMTP id z8mr732830lfa.157.1615425760563;
 Wed, 10 Mar 2021 17:22:40 -0800 (PST)
MIME-Version: 1.0
References: <20210310125504.31886-1-noltari@gmail.com> <20210310125504.31886-5-noltari@gmail.com>
 <CAL_JsqK4b+U7cVb04+moB4biGVFC4mr3VGx70KdQKitiCGdtnQ@mail.gmail.com> <A2B4813E-4177-4969-9119-A40B39A36948@gmail.com>
In-Reply-To: <A2B4813E-4177-4969-9119-A40B39A36948@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 11 Mar 2021 02:22:29 +0100
Message-ID: <CACRpkdanTJqB1dC+Ax99Xt+sFjES1B-hBW01vhrXA0Prnc4_HA@mail.gmail.com>
Subject: Re: [PATCH v6 04/15] dt-bindings: add BCM6328 pincontroller binding documentation
To:     =?UTF-8?B?w4FsdmFybyBGZXJuw6FuZGV6IFJvamFz?= <noltari@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Michael Walle <michael@walle.cc>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>,
        Jonas Gorski <jonas.gorski@gmail.com>,
        Necip Fazil Yildiran <fazilyildiran@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 10, 2021 at 7:03 PM =C3=81lvaro Fern=C3=A1ndez Rojas
<noltari@gmail.com> wrote:
> > El 10 mar 2021, a las 18:45, Rob Herring <robh+dt@kernel.org> escribi=
=C3=B3:

> >> +      reg =3D <0x10000080 0x80>;
> >> +
> >> +      pinctrl: pinctrl {
> >> +        compatible =3D "brcm,bcm6328-pinctrl";
> >> +
> >> +        gpio {
> >> +          compatible =3D "brcm,bcm6328-gpio";
> >
> > I'm still trying to understand why you need 3 levels of nodes here?
> > The gpio controller contains a pin controller plus other undefined
> > functions (because of 'syscon') and the pin controller contains a gpio
> > controller?
>
> In previous versions the gpio controller was registered along with the pi=
n controller, but @Linus requested me to register the gpio pin controller r=
anges through device tree by using gpio-ranges and I decided to use this ap=
proach, which was already used by other pin controllers.
> However, there aren=E2=80=99t any pinctrl drivers using gpio-regmap, so t=
his is kind of new=E2=80=A6

I think the crucial point is that these hardwares (all patches in the serie=
s)
is very similar and some contain several GPIO blocks rather than just
one.

The structure needs to be seen as a common pattern. We are doing this
because it gives a common structure to all BCM SoCs in this
family, which is nice.

Yours,
Linus Walleij
