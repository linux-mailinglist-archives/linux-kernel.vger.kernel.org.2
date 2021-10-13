Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 046F142C2A2
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 16:15:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236502AbhJMORJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 10:17:09 -0400
Received: from mail-ua1-f42.google.com ([209.85.222.42]:44556 "EHLO
        mail-ua1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235884AbhJMORH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 10:17:07 -0400
Received: by mail-ua1-f42.google.com with SMTP id e7so4725165ual.11;
        Wed, 13 Oct 2021 07:15:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eOGdh1AkOHJBmLFPoyr41m94hwdgjBmCbg/FB38m3v4=;
        b=7c6C243zu58q/LJhg5QqG0/cDsANC9mDxIrTU/Y3c3kvErDrCWA0VA9bYm6wdMdC72
         c2OnZU0OL/K1i9FnMEub8vJU5xrXzth1ZmQaaeI5zTO1jpn3573OIn6en6qtNY+6reWL
         VQLcBxibSR3oF+A9NV/dZdqKRTCCFHtF0b0QZ2AteolTTpGZ3DSKKIcBOHMJFTsGa72Y
         qAGa6xIc6RQHH67aneH75pkfZCfLPogEyXwAHEJ1d5ojrm+Z9r6ckdm43DwKQqJ9Wvhs
         6zyHpUHE5ba+B2RSqU59MRxC+1+fr93F36D/3HT6KLJA0Fwr4OEqbo4r9XtyTcJVEDiG
         /6dg==
X-Gm-Message-State: AOAM533N5oI4NAwhTWH6tj7u65oh16ibXr4diGJsqhe9MfxF8jK7/4od
        c2NGIqqNM3jLo6gLOMyqTZ9xuBseq2fXxXIFPfU=
X-Google-Smtp-Source: ABdhPJwWSQSEOb7HJUiITEzyUPYdJB8jq0qc3AWy6XySRqTntnQ5K6xK2nsLta84iu1eLwmnUvTAtLLc1kvAWH4QoBw=
X-Received: by 2002:ab0:538a:: with SMTP id k10mr30117696uaa.14.1634134503591;
 Wed, 13 Oct 2021 07:15:03 -0700 (PDT)
MIME-Version: 1.0
References: <20201223212947.160565-1-paul.kocialkowski@bootlin.com> <20201223212947.160565-2-paul.kocialkowski@bootlin.com>
In-Reply-To: <20201223212947.160565-2-paul.kocialkowski@bootlin.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 13 Oct 2021 16:14:52 +0200
Message-ID: <CAMuHMdVKgP5RAH5MhZzjjbfEJVZF6ERvyaQ7iyzDWs35dCtw6w@mail.gmail.com>
Subject: Re: [PATCH v8 1/4] dt-bindings: display: Document the Xylon LogiCVC
 display controller
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc:     DRI Development <dri-devel@lists.freedesktop.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Rob Herring <robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

On Wed, Dec 23, 2020 at 10:32 PM Paul Kocialkowski
<paul.kocialkowski@bootlin.com> wrote:
> The Xylon LogiCVC is a display controller implemented as programmable
> logic in Xilinx FPGAs.
>
> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> Acked-by: Rob Herring <robh@kernel.org>

> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/xylon,logicvc-display.yaml
> @@ -0,0 +1,313 @@

> +  clock-names:
> +    minItems: 1
> +    maxItems: 4

After applying this to my local tree, as it is a dependency for 2/4 in
for-mfd-next:

Documentation/devicetree/bindings/display/xylon,logicvc-display.yaml:
properties:clock-names: {'required': ['maxItems']} is not allowed for
{'minItems': 1, 'maxItems': 4, 'items': [{'const': 'vclk'}, {'enum':
['vclk2', 'lvdsclk', 'lvdsclkn']}, {'enum': ['vclk2', 'lvdsclk',
'lvdsclkn']}, {'enum': ['vclk2', 'lvdsclk', 'lvdsclkn']}]}
hint: "maxItems" is not needed with an "items" list
from schema $id: http://devicetree.org/meta-schemas/items.yaml#

> +    items:
> +      # vclk is required and must be provided as first item.
> +      - const: vclk
> +      # Other clocks are optional and can be provided in any order.
> +      - enum:
> +          - vclk2
> +          - lvdsclk
> +          - lvdsclkn
> +      - enum:
> +          - vclk2
> +          - lvdsclk
> +          - lvdsclkn
> +      - enum:
> +          - vclk2
> +          - lvdsclk
> +          - lvdsclkn
> +

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
