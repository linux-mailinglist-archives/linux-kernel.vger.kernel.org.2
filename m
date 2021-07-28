Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 916C53D8676
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 06:12:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229718AbhG1EMD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 00:12:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbhG1EMB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 00:12:01 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AABA0C061757
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jul 2021 21:12:00 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id z7so551911iog.13
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jul 2021 21:12:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jkbI7zztV8NxbL6OAK1GEXMLTdKA0PoGPYCzxGouH9A=;
        b=dXYscuKA9USWzwsEiMBwy5bFn/At9FyANB2VnftNc1X/3U6Q7IE+ADanciy9xfye3r
         dagomBuKngzGJSGumLSkQdm8bYNno6ki1QW7KUxpxYe9jxJOcDIxvRU7EpP8S5E00c2/
         pXE/MXTifhLK7UKGySp+fdKyCMkGBXoCzF4BQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jkbI7zztV8NxbL6OAK1GEXMLTdKA0PoGPYCzxGouH9A=;
        b=Z4oqRyauPl2iXsdnvR9EcSZJeg82a/yVkzWm8ahEdoI6T4d7OjUONN3btI9WeQa6hf
         QjADIauKWzLLy609ce1y9epsshMvciIBjwORnWGOvFoX91+x4iRAUqtUo17ZxnbHd66Q
         vofk8iWq/6fDHv/F0mHlkL2n+RKY34O9pVGfPwb9fVbscaFLS4uMO+cN+2c0RvMXfoOi
         f2xbxdf7D5gsop6ICY6h7VWQcR81C64uy6LycZWT0ATN953Lt3R5tphDJQjX+d83M3xY
         LdupqtcJjUNBUZcUsqS/dggzMLa+2SjR8PiL8FG7RGZHeqNGz+2ysyg8LtxlLdtLbm7i
         rxYg==
X-Gm-Message-State: AOAM5334V55ga8COLuwYtxrCnYhenZ4Ih6mzsT/dG4IucqbH0oSUoR39
        4IljXtIN/sImRRg1gVtPmVFlQKTMEjS4nCCcH97Y+Klnw4uKUA==
X-Google-Smtp-Source: ABdhPJwZURagtlb/Es05dXEFrkQMdNvFOAO3Y0xE8fnLEijoUW7gGe8ePUB+PSUfm3tmzaT/PUEwnpmW7dLCcUiGvtg=
X-Received: by 2002:a02:6946:: with SMTP id e67mr24142969jac.4.1627445519987;
 Tue, 27 Jul 2021 21:11:59 -0700 (PDT)
MIME-Version: 1.0
References: <20210727110232.2503763-1-hsinyi@chromium.org> <20210727110232.2503763-3-hsinyi@chromium.org>
 <1627410395.874547.3210653.nullmailer@robh.at.kernel.org>
In-Reply-To: <1627410395.874547.3210653.nullmailer@robh.at.kernel.org>
From:   Hsin-Yi Wang <hsinyi@chromium.org>
Date:   Wed, 28 Jul 2021 12:11:34 +0800
Message-ID: <CAJMQK-jii-qqzG8Myn2svn+hBS+s+0YZLO1Gx=Co23gzd7FUgA@mail.gmail.com>
Subject: Re: [PATCH 3/3] dt-bindings: mediatek: convert pinctrl to yaml
To:     Rob Herring <robh@kernel.org>
Cc:     Enric Balletbo Serra <eballetbo@gmail.com>,
        Andy Teng <andy.teng@mediatek.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>, linux-gpio@vger.kernel.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sean Wang <sean.wang@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 28, 2021 at 2:26 AM Rob Herring <robh@kernel.org> wrote:
>
> On Tue, 27 Jul 2021 19:02:32 +0800, Hsin-Yi Wang wrote:
> > Convert mt65xx, mt6796, mt7622, mt8183 bindings to yaml.
> >
> > Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> > ---
> >  .../pinctrl/mediatek,mt65xx-pinctrl.yaml      | 202 +++++++
> >  .../pinctrl/mediatek,mt6797-pinctrl.yaml      | 175 ++++++
> >  .../pinctrl/mediatek,mt7622-pinctrl.yaml      | 537 ++++++++++++++++++
> >  .../pinctrl/mediatek,mt8183-pinctrl.yaml      | 230 ++++++++
> >  .../bindings/pinctrl/pinctrl-mt65xx.txt       | 156 -----
> >  .../bindings/pinctrl/pinctrl-mt6797.txt       |  83 ---
> >  .../bindings/pinctrl/pinctrl-mt7622.txt       | 490 ----------------
> >  .../bindings/pinctrl/pinctrl-mt8183.txt       | 132 -----
> >  8 files changed, 1144 insertions(+), 861 deletions(-)
> >  create mode 100644 Documentation/devicetree/bindings/pinctrl/mediatek,mt65xx-pinctrl.yaml
> >  create mode 100644 Documentation/devicetree/bindings/pinctrl/mediatek,mt6797-pinctrl.yaml
> >  create mode 100644 Documentation/devicetree/bindings/pinctrl/mediatek,mt7622-pinctrl.yaml
> >  create mode 100644 Documentation/devicetree/bindings/pinctrl/mediatek,mt8183-pinctrl.yaml
> >  delete mode 100644 Documentation/devicetree/bindings/pinctrl/pinctrl-mt65xx.txt
> >  delete mode 100644 Documentation/devicetree/bindings/pinctrl/pinctrl-mt6797.txt
> >  delete mode 100644 Documentation/devicetree/bindings/pinctrl/pinctrl-mt7622.txt
> >  delete mode 100644 Documentation/devicetree/bindings/pinctrl/pinctrl-mt8183.txt
> >
>
> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
>
> yamllint warnings/errors:
>
> dtschema/dtc warnings/errors:
> Documentation/devicetree/bindings/pinctrl/mediatek,mt8183-pinctrl.example.dts:21:18: fatal error: dt-bindings/pinctrl/mt8183-pinfunc.h: No such file or directory
>    21 |         #include <dt-bindings/pinctrl/mt8183-pinfunc.h>
>       |                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> compilation terminated.
> make[1]: *** [scripts/Makefile.lib:380: Documentation/devicetree/bindings/pinctrl/mediatek,mt8183-pinctrl.example.dt.yaml] Error 1
> make[1]: *** Waiting for unfinished jobs....
> make: *** [Makefile:1418: dt_binding_check] Error 2
> \ndoc reference errors (make refcheckdocs):
> Warning: MAINTAINERS references a file that doesn't exist: Documentation/devicetree/bindings/pinctrl/pinctrl-mt65xx.txt
> Warning: MAINTAINERS references a file that doesn't exist: Documentation/devicetree/bindings/pinctrl/pinctrl-mt7622.txt
> MAINTAINERS: Documentation/devicetree/bindings/pinctrl/pinctrl-mt65xx.txt
> MAINTAINERS: Documentation/devicetree/bindings/pinctrl/pinctrl-mt7622.txt
>
> See https://patchwork.ozlabs.org/patch/1510444
>
> This check can fail if there are any dependencies. The base for a patch
> series is generally the most recent rc1.
>
This patch is dependent on
https://patchwork.kernel.org/project/linux-mediatek/patch/20210727110232.2503763-2-hsinyi@chromium.org/
("arm: dts: mt8183: Move pinfunc to include/dt-bindings/pinctrl")

> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure 'yamllint' is installed and dt-schema is up to
> date:
>
> pip3 install dtschema --upgrade
>
> Please check and re-submit.
>
