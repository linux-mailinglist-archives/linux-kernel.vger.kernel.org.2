Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CB113C5B7A
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jul 2021 13:44:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233384AbhGLL1W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jul 2021 07:27:22 -0400
Received: from mail-vk1-f180.google.com ([209.85.221.180]:46009 "EHLO
        mail-vk1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbhGLL1U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jul 2021 07:27:20 -0400
Received: by mail-vk1-f180.google.com with SMTP id j190so3897419vkg.12;
        Mon, 12 Jul 2021 04:24:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wSI56+0wl/8uoFZkYYEX3Cn5WjSYU9NFzgAm+bp0lBU=;
        b=TZAcxELme0KH+lXKl+7Iw9ntlmy0E2d0LvO0n4Q5956NBZbClvqIt3eL73mH46ec2f
         p9ieGyiVbYdMJnNJUwcl/eMh0it5+nCHZHbu8yZDT7b7qGVrtFq5rmzJlwfEfefe4HVk
         meFtdsSJXrb9YC/Q0ehQrevA1v2ldY38A0oE4cTyEsVugFuiwcpVAsAXSrYm77MP4jdZ
         ePonhYopbSFc3yv+14Wxl7UidVi5W3K+u5FwKB3dQp21UFb9e7QMwyceDybgLbDtVXfp
         BJM6GRWarNg+krn5r6z+RjMf0wb5I1Xiq0RxT0IVYGzRXtTKdN/eqnPmlf4UuXBLTezu
         gmmA==
X-Gm-Message-State: AOAM5310kBt1QV2bfIZ2hr/5QbtjB51O15ZfAJRMi01PSSpu8DEYXfu4
        3Sv+k8zWxhUj3awhy5PSrwws2mTKlc0mA+3Pf3XykiNgCkQ=
X-Google-Smtp-Source: ABdhPJzl+b8ID+5NtPNSzacYozt9cW/uQxXEYZQYcG4NKJ5aeR9N2kMo9YCHMcaHTF4gY4uSOKuGr5NU+gxzNe5ovNo=
X-Received: by 2002:a1f:1a41:: with SMTP id a62mr42439346vka.5.1626089070907;
 Mon, 12 Jul 2021 04:24:30 -0700 (PDT)
MIME-Version: 1.0
References: <20210709201603.2625664-1-drew@beagleboard.org>
In-Reply-To: <20210709201603.2625664-1-drew@beagleboard.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 12 Jul 2021 13:24:19 +0200
Message-ID: <CAMuHMdVBVAzy3cZtR1pOTNq3wTgGx+0_dvUXU118XfT+rCOSrw@mail.gmail.com>
Subject: Re: [PATCH v3] dt-bindings: riscv: add starfive jh7100 bindings
To:     Drew Fustini <drew@beagleboard.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Michael Zhu <michael.zhu@starfivetech.com>,
        Wei Fu <tekkamanninja@gmail.com>,
        Jack Zhu <jack.zhu@starfivetech.com>,
        Leyfoon Tan <leyfoon.tan@starfivetech.com>,
        Emil Renner Berthing <kernel@esmil.dk>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Drew,

On Fri, Jul 9, 2021 at 10:17 PM Drew Fustini <drew@beagleboard.org> wrote:
> Add DT binding documentation for the StarFive JH7100 Soc [1] and the
> BeagleV Starlight JH7100 board [2].
>
> [1] https://github.com/starfive-tech/beaglev_doc
> [2] https://github.com/beagleboard/beaglev-starlight
>
> Signed-off-by: Drew Fustini <drew@beagleboard.org>
> ---
> v3 changes:
> - added revision number for the board and soc after question from Palmer

Thanks for the update!

> --- /dev/null
> +++ b/Documentation/devicetree/bindings/riscv/starfive.yaml
> @@ -0,0 +1,27 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/riscv/starfive.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: StarFive SoC-based boards
> +
> +maintainers:
> +  - Michael Zhu <michael.zhu@starfivetech.com>
> +  - Drew Fustini <drew@beagleboard.org>
> +
> +description:
> +  StarFive SoC-based boards
> +
> +properties:
> +  $nodename:
> +    const: '/'
> +  compatible:
> +    oneOf:
> +      - items:
> +          - const: beagle,beaglev-starlight-jh7100-r0
> +          - const: starfive,jh7100-r0

While I can be convinced about the board revision number (probably you
know better if there will be different board revisions that matter),
I'm wondering if the revision number makes sense for the SoC part.
Will there be a new revision of jh7100, or will the next revision
be jh7110, which will use a different compatible value anyway?
Is there an on-chip register that allows the kernel to find out the
revision info? Might be better to use that with soc_device_register()
and soc_device_match().

> +
> +additionalProperties: true
> +
> +...

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
