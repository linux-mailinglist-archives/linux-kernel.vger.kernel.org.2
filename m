Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12CDC3CB783
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 14:49:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239386AbhGPMws (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jul 2021 08:52:48 -0400
Received: from mail-vs1-f53.google.com ([209.85.217.53]:46632 "EHLO
        mail-vs1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234357AbhGPMwr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jul 2021 08:52:47 -0400
Received: by mail-vs1-f53.google.com with SMTP id e9so4898135vsk.13;
        Fri, 16 Jul 2021 05:49:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QPzYoNGuofUoO3zXko6ZHL58ZO0oCjn9vuEYCFE9//o=;
        b=dfJHByVDwm+P8v3dTB0FPwaan59bPSOFEl3WkaCadXkIzKFRNXL9cmJIPkhBistcMD
         3fNkLIpSr5eXV/CwIFtFUSP79RZDRT1zWZDWeDFsUoy1jL76lDUFeKDuWDHtMtjMK6CX
         jQfsGwbkdj6jBZrMt8jERoWTLTmdmgieMbCXLWEP7Yer9W1/k/ZfGVW28uZo5bvUQFRT
         IuOZfvPUPkeJDgKci10EtnKImzCGxTLqpGR1vzMUT5cOA5ESAuD5IWKGoMt5Guack7gf
         rJyefJd4/UOIIks6EayHkzuOJSeGVx5LgKGDaBzmC1iwbbfh+F1TJisvn3HEq3px+arb
         NXRw==
X-Gm-Message-State: AOAM533JG9x6y/WtCYNGSqj+vk/mfPZeZ0pLfwgckT7QPWdQYSL8F0Xo
        vo9Yj+mEprEM/iuu6UPIQNYbEFK0npKPBZrKo9I=
X-Google-Smtp-Source: ABdhPJwIse8RhEmkKEyZTYSOZAvcDB1SPGaj0VAhHhLN3bATCm1G9lUEhBmRL33PiglvWeQ1iiyT6GwNThVzmxmb9Ow=
X-Received: by 2002:a05:6102:321c:: with SMTP id r28mr12049640vsf.40.1626439790812;
 Fri, 16 Jul 2021 05:49:50 -0700 (PDT)
MIME-Version: 1.0
References: <1607403341-57214-1-git-send-email-yash.shah@sifive.com> <1607403341-57214-8-git-send-email-yash.shah@sifive.com>
In-Reply-To: <1607403341-57214-8-git-send-email-yash.shah@sifive.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 16 Jul 2021 14:49:39 +0200
Message-ID: <CAMuHMdW74DsiqyLCYyWSosZmwVEqPiAWNV2i6m4LWzz0868fbg@mail.gmail.com>
Subject: Re: [PATCH v2 7/9] riscv: dts: add initial support for the SiFive
 FU740-C000 SoC
To:     Yash Shah <yash.shah@sifive.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Palmer Dabbelt <palmer@dabbelt.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yash,

On Tue, Dec 8, 2020 at 5:57 AM Yash Shah <yash.shah@sifive.com> wrote:
> Add initial support for the SiFive FU540-C000 SoC. FU740-C000 is built
> around the SiFIve U7 Core Complex and a TileLink interconnect.
>
> This file is expected to grow as more device drivers are added to the
> kernel.
>
> Signed-off-by: Yash Shah <yash.shah@sifive.com>

Thanks for your patch, which became commit 57985788158a5a6b ("riscv:
dts: add initial support for the SiFive FU740-C000 SoC").

> --- /dev/null
> +++ b/arch/riscv/boot/dts/sifive/fu740-c000.dtsi
> @@ -0,0 +1,293 @@

> +       cpus {
> +               #address-cells = <1>;
> +               #size-cells = <0>;
> +               cpu0: cpu@0 {
> +                       compatible = "sifive,bullet0", "riscv";

I'm wondering why you're using

    compatible = "sifive,bullet0", "riscv";

According to your own commit 75e6d7248efccc2b ("dt-bindings: riscv:
Update DT binding docs to support SiFive FU740 SoC"), it should be

    compatible = "sifive,u74-mc", "riscv";

instead.

Likewise, the older arch/riscv/boot/dts/sifive/fu540-c000.dtsi is using

    compatible = "sifive,e51", "sifive,rocket0", "riscv";

and

    compatible = "sifive,u54-mc", "sifive,rocket0", "riscv";

but according to the DT bindings the rocket part should not be present.

Is there any specific reason for that?
Should the DT bindings and/or the DTS files be fixed?

Thanks!

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
