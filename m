Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9505431358C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 15:48:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233146AbhBHOsC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 09:48:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:46292 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232392AbhBHOg4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 09:36:56 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id C615864E84;
        Mon,  8 Feb 2021 14:22:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612794132;
        bh=xIHe2+hcXIQgWZj5/3i+bzgVb55TqVHLBWaYhZTHQdg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=AIZ1gs/VkdWv/NA9eXdH9lr/xDqumLmZqWlBHXrQMwS2fsP2LdbfCkuDOYRTaL1QU
         Kpz51pMedBcjOvkyIkPYorgRKP1St/3+loEyoK8iouJXqAkref5gIP8T20CTiDqzqt
         w+i9bwvVnnV0gnfENqLl2SEC1WC+JxfFdyWTWLUvRUAChb7K8iLTRYTkBE/5b5nqFk
         MwMoY39dFeRErnSNvdrqwzOCvfQudgAirLjxMfKBihousmM2NR0hkukhBlUPzXGTEO
         u/Uer7uT+1T9LiBvhwo5QmpqTSJuqVQUSbcAivzRw5GbjWU7dj32Up5GDzzWBA7zYo
         fxp7iYkh1zbBg==
Received: by mail-qk1-f174.google.com with SMTP id t63so14506679qkc.1;
        Mon, 08 Feb 2021 06:22:12 -0800 (PST)
X-Gm-Message-State: AOAM5301R2L60L4FGYfoyiGTAV+k1R+QLGxbhMJ9AgSrjM7lbVaMDNW9
        a8aK21lgZiD/Tz9ZouQvVah1sSni31NVH2jWgw==
X-Google-Smtp-Source: ABdhPJzm/lIL5vDH1+nWzRP0x8pc6Iq9ovJzNcqQnvnNyHnP6QKWMQPt+FemAsjqdSqBaYByOIRYIKw1paJ1leULFPs=
X-Received: by 2002:ae9:f20b:: with SMTP id m11mr17389999qkg.464.1612794131744;
 Mon, 08 Feb 2021 06:22:11 -0800 (PST)
MIME-Version: 1.0
References: <cover.1611904394.git.viresh.kumar@linaro.org> <3683a542d4141cfcf9c2524a40a9ee75b657c1c2.1611904394.git.viresh.kumar@linaro.org>
 <20210204015409.GA3150757@robh.at.kernel.org> <20210208111813.oql6jmeaxuq3btz7@vireshk-i7>
In-Reply-To: <20210208111813.oql6jmeaxuq3btz7@vireshk-i7>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 8 Feb 2021 08:21:59 -0600
X-Gmail-Original-Message-ID: <CAL_JsqK+eM_RrzXnbm2GJGJuVwAjEz1TeTux18Hc727vovbqDA@mail.gmail.com>
Message-ID: <CAL_JsqK+eM_RrzXnbm2GJGJuVwAjEz1TeTux18Hc727vovbqDA@mail.gmail.com>
Subject: Re: [PATCH V7 6/6] of: unittest: Statically apply overlays using fdtoverlay
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Anmar Oueja <anmar.oueja@linaro.org>,
        Bill Mills <bill.mills@linaro.org>,
        David Gibson <david@gibson.dropbear.id.au>,
        devicetree@vger.kernel.org, Michal Marek <michal.lkml@markovi.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 8, 2021 at 5:18 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 03-02-21, 19:54, Rob Herring wrote:
> > diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
> > index b00855b247e0..886d2e6c58f0 100644
> > --- a/scripts/Makefile.lib
> > +++ b/scripts/Makefile.lib
> > @@ -66,6 +66,9 @@ multi-used   := $(multi-used-y) $(multi-used-m)
> >  real-obj-y := $(foreach m, $(obj-y), $(if $(strip $($(m:.o=-objs)) $($(m:.o=-y)) $($(m:.o=-))),$($(m:.o=-objs)) $($(m:.o=-y)),$(m)))
> >  real-obj-m := $(foreach m, $(obj-m), $(if $(strip $($(m:.o=-objs)) $($(m:.o=-y)) $($(m:.o=-m)) $($(m:.o=-))),$($(m:.o=-objs)) $($(m:.o=-y)) $($(m:.o=-m)),$(m)))
> >
> > +real-dtb-y := $(foreach m,$(dtb-y), $(if $(strip $($(m:.dtb=-dtbs))),$($(m:.dtb=-dtbs)),))
>
> Sorry for my lack of knowledge, but what does (m:.dtb=-dtbs) do
> exactly ?

In string 'm' replace '.dtb' with '-dtbs'. Then we get the value of
that variable.

>
> > +dtb-y += $(real-dtb-y)
> > +
> >  always-y += $(always-m)
> >
> >  # hostprogs-always-y += foo
> > @@ -332,6 +335,15 @@ $(obj)/%.dtb: $(src)/%.dts $(DTC) FORCE
> >  $(obj)/%.dtbo: $(src)/%.dts $(DTC) FORCE
> >       $(call if_changed_dep,dtc)
> >
> > +
> > +quiet_cmd_fdtoverlay = DTOVL   $@
> > +      cmd_fdtoverlay = $(objtree)/scripts/dtc/fdtoverlay -o $@ -i $(real-prereqs)
> > +
> > +.SECONDEXPANSION:
> > +
> > +$(obj)/%.dtb: $$(addprefix $$(obj)/,$$(%-dtbs)) FORCE
> > +     $(call if_changed,fdtoverlay)
> > +
> >  DT_CHECKER ?= dt-validate
> >  DT_BINDING_DIR := Documentation/devicetree/bindings
> >  # DT_TMP_SCHEMA may be overridden from Documentation/devicetree/bindings/Makefile
>
> I tried to test a dtbo from arch/ code like this:
>
> diff --git a/arch/arm64/boot/dts/hisilicon/Makefile b/arch/arm64/boot/dts/hisilicon/Makefile
> index f4d68caeba83..0ee9d7dc8e07 100644
> --- a/arch/arm64/boot/dts/hisilicon/Makefile
> +++ b/arch/arm64/boot/dts/hisilicon/Makefile
> @@ -6,3 +6,8 @@ dtb-$(CONFIG_ARCH_HISI) += hi6220-hikey.dtb
>  dtb-$(CONFIG_ARCH_HISI) += hip05-d02.dtb
>  dtb-$(CONFIG_ARCH_HISI) += hip06-d03.dtb
>  dtb-$(CONFIG_ARCH_HISI) += hip07-d05.dtb
> +
> +DTC_FLAGS_hi3660-hikey960 += -@
> +
> +test1-dtbs := hi3660-hikey960.dtb hi3660-hikey960-overlay.dtbo
> +dtb-y += test1.dtb
> diff --git a/arch/arm64/boot/dts/hisilicon/hi3660-hikey960-overlay.dts b/arch/arm64/boot/dts/hisilicon/hi3660-hikey960-overlay.dts
> new file mode 100644
> index 000000000000..1235a911caae
> --- /dev/null
> +++ b/arch/arm64/boot/dts/hisilicon/hi3660-hikey960-overlay.dts
> @@ -0,0 +1,16 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/dts-v1/;
> +/plugin/;
> +
> +&dwmmc2 {
> +       #address-cells = <0x1>;
> +       #size-cells = <0x0>;
> +
> +       wlcore2: wlcore@5 {
> +               compatible = "ti,wl1837";
> +               reg = <2>;
> +               interrupt-parent = <&gpio22>;
> +               interrupts = <3 1>;
> +               test = <1>;
> +       };
> +};
>
> Even after your patch there are some issues I am facing:
>
> 1. dtbs_check doesn't test hi3660-hikey960-overlay.dts. I also tried
>    to add it to dtbo-y +=, but that didn't do anything as well.
>
> I expected this to work as we have this in scripts/Makefile.lib:
>
>  ifneq ($(CHECK_DTBS),)
>  extra-y += $(patsubst %.dtb,%.dt.yaml, $(dtb-y))
> +extra-y += $(patsubst %.dtbo,%.dt.yaml, $(dtb-y))
>  extra-$(CONFIG_OF_ALL_DTBS) += $(patsubst %.dtb,%.dt.yaml, $(dtb-))
> +extra-$(CONFIG_OF_ALL_DTBS) += $(patsubst %.dtbo,%.dt.yaml, $(dtb-))
>  endif

I'll have to try that out. I think that should work.

> 2. This fails dtbs_check as it tries to run it for the source file of
>    test1.dtb
>
> $ make ARCH=arm64 O=../barm64/ -j8 CROSS_COMPILE=aarch64-linux-gnu- dtbs_check
> make[1]: Entering directory '/mnt/ssd/all/work/repos/devel/barm64'
> make[3]: *** No rule to make target 'arch/arm64/boot/dts/hisilicon/test1.dt.yaml', needed by '__build'.  Stop.
> /mnt/ssd/all/work/repos/devel/linux/scripts/Makefile.build:496: recipe for target 'arch/arm64/boot/dts/hisilicon' failed
> make[2]: *** [arch/arm64/boot/dts/hisilicon] Error 2
> make[2]: *** Waiting for unfinished jobs....
> /mnt/ssd/all/work/repos/devel/linux/Makefile:1345: recipe for target 'dtbs' failed
> make[1]: *** [dtbs] Error 2
> make[1]: Leaving directory '/mnt/ssd/all/work/repos/devel/barm64'
> Makefile:185: recipe for target '__sub-make' failed
> make: *** [__sub-make] Error 2
>
> I am not sure how to fix this.

Even if we fixed the make rules, it's not going to work with
validation. There's some information from source files that we
maintain in yaml output, but is lost in dtb output. For example, the
sizes of /bits/ syntax are maintained. For now, I think we'll want to
just validate base and overlays separately. We may need to turn off
checks in overlays for required properties as they may be incomplete.
We already do that on disabled nodes.

Rob
