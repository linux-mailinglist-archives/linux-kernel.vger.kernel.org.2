Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 513283130FD
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 12:37:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231879AbhBHLfw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 06:35:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232975AbhBHLS6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 06:18:58 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76F96C061794
        for <linux-kernel@vger.kernel.org>; Mon,  8 Feb 2021 03:18:17 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id j11so7629461plt.11
        for <linux-kernel@vger.kernel.org>; Mon, 08 Feb 2021 03:18:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=BG07CrVYtYSxUbAkuoODfhQgNLsRTlvgUQutHXrpUMw=;
        b=qTbaov5ZQK4osPFOrE7ts/BGRY2Fal62boysV/xey6l0QEbWJXEBnb0BjRf/ekBoZe
         TDw6eFx0+06oVrWwO307Dnskx7ZMgXWUihyHymm9b0T5YBNBITZVUribds/iozPxvTXq
         sm3v5wVOyUoFQVltMFXgKFt0r9Ia81wGgOnmuqU3D07uwMQKLSUcRtJCp23mHyWGaoKe
         aXpxnfQa+bX4guPo2iCp6ywS9bCRS5rru/a6yh9EnA0T609x4ZDOSjbzJBllIBU9lexX
         2WUH8uKDbN64+wXV1S0c9i2TgzDUX9eFm+6WybGKMCjIPBigveRxkDXt/CDfEJufTYkt
         FKzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BG07CrVYtYSxUbAkuoODfhQgNLsRTlvgUQutHXrpUMw=;
        b=eWNwgWgpDgXGz0ipvfN5JcAS6KjnYLY5BBC5j4Gx1sKQkMZ8u+4V/0YDrWMIcgiFAN
         tjHwceCR7tWymBayUNSwxKFAAkqLIC6CjX/KV1PeDn28mfWIrr7GVWO19XC281mCWA/2
         CuXFOFPXiAiZx1P8OAL1ACdKkFCqU629hsjQQzYuax43YfKFLxNIK+8HH0CMqLgOcu8H
         ExBaYBUwa1fENxwY3z+Y30osyhU7Clsq7HLDRPaOKCCmMqr5j7/Lh2aeOwulVvTvghbA
         ryBcucWllcTZVrajKWSCCkrE27UR4nU16WGqn3OlHcCsbGtmqJb/TKMDj9o91iuw+7Fg
         Ftcw==
X-Gm-Message-State: AOAM533dApDjyDfjgCkScyTaJBoSBeKqsGrVURK+AmacfHSrFPY4SZzm
        cUqkbHr8qZOkpmkJwveWOQeIRg==
X-Google-Smtp-Source: ABdhPJx6X49Klh82q7nvdQHupsKW121ytoNbxyowRY9Ik+YmEpKnwU2mWpKqoLIVlaCuS06hV4f+HA==
X-Received: by 2002:a17:902:10a:b029:e2:e8f7:2988 with SMTP id 10-20020a170902010ab02900e2e8f72988mr1419914plb.4.1612783096984;
        Mon, 08 Feb 2021 03:18:16 -0800 (PST)
Received: from localhost ([122.172.59.240])
        by smtp.gmail.com with ESMTPSA id gc13sm15429778pjb.11.2021.02.08.03.18.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Feb 2021 03:18:15 -0800 (PST)
Date:   Mon, 8 Feb 2021 16:48:13 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org, anmar.oueja@linaro.org,
        Bill Mills <bill.mills@linaro.org>,
        David Gibson <david@gibson.dropbear.id.au>,
        devicetree@vger.kernel.org, Michal Marek <michal.lkml@markovi.net>
Subject: Re: [PATCH V7 6/6] of: unittest: Statically apply overlays using
 fdtoverlay
Message-ID: <20210208111813.oql6jmeaxuq3btz7@vireshk-i7>
References: <cover.1611904394.git.viresh.kumar@linaro.org>
 <3683a542d4141cfcf9c2524a40a9ee75b657c1c2.1611904394.git.viresh.kumar@linaro.org>
 <20210204015409.GA3150757@robh.at.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210204015409.GA3150757@robh.at.kernel.org>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03-02-21, 19:54, Rob Herring wrote:
> diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
> index b00855b247e0..886d2e6c58f0 100644
> --- a/scripts/Makefile.lib
> +++ b/scripts/Makefile.lib
> @@ -66,6 +66,9 @@ multi-used   := $(multi-used-y) $(multi-used-m)
>  real-obj-y := $(foreach m, $(obj-y), $(if $(strip $($(m:.o=-objs)) $($(m:.o=-y)) $($(m:.o=-))),$($(m:.o=-objs)) $($(m:.o=-y)),$(m)))
>  real-obj-m := $(foreach m, $(obj-m), $(if $(strip $($(m:.o=-objs)) $($(m:.o=-y)) $($(m:.o=-m)) $($(m:.o=-))),$($(m:.o=-objs)) $($(m:.o=-y)) $($(m:.o=-m)),$(m)))
>  
> +real-dtb-y := $(foreach m,$(dtb-y), $(if $(strip $($(m:.dtb=-dtbs))),$($(m:.dtb=-dtbs)),))

Sorry for my lack of knowledge, but what does (m:.dtb=-dtbs) do
exactly ?

> +dtb-y += $(real-dtb-y)
> +
>  always-y += $(always-m)
>  
>  # hostprogs-always-y += foo
> @@ -332,6 +335,15 @@ $(obj)/%.dtb: $(src)/%.dts $(DTC) FORCE
>  $(obj)/%.dtbo: $(src)/%.dts $(DTC) FORCE
>  	$(call if_changed_dep,dtc)
>  
> +
> +quiet_cmd_fdtoverlay = DTOVL   $@
> +      cmd_fdtoverlay = $(objtree)/scripts/dtc/fdtoverlay -o $@ -i $(real-prereqs)
> +
> +.SECONDEXPANSION:
> +
> +$(obj)/%.dtb: $$(addprefix $$(obj)/,$$(%-dtbs)) FORCE
> +	$(call if_changed,fdtoverlay)
> +
>  DT_CHECKER ?= dt-validate
>  DT_BINDING_DIR := Documentation/devicetree/bindings
>  # DT_TMP_SCHEMA may be overridden from Documentation/devicetree/bindings/Makefile

I tried to test a dtbo from arch/ code like this:

diff --git a/arch/arm64/boot/dts/hisilicon/Makefile b/arch/arm64/boot/dts/hisilicon/Makefile
index f4d68caeba83..0ee9d7dc8e07 100644
--- a/arch/arm64/boot/dts/hisilicon/Makefile
+++ b/arch/arm64/boot/dts/hisilicon/Makefile
@@ -6,3 +6,8 @@ dtb-$(CONFIG_ARCH_HISI) += hi6220-hikey.dtb
 dtb-$(CONFIG_ARCH_HISI) += hip05-d02.dtb
 dtb-$(CONFIG_ARCH_HISI) += hip06-d03.dtb
 dtb-$(CONFIG_ARCH_HISI) += hip07-d05.dtb
+
+DTC_FLAGS_hi3660-hikey960 += -@
+
+test1-dtbs := hi3660-hikey960.dtb hi3660-hikey960-overlay.dtbo
+dtb-y += test1.dtb
diff --git a/arch/arm64/boot/dts/hisilicon/hi3660-hikey960-overlay.dts b/arch/arm64/boot/dts/hisilicon/hi3660-hikey960-overlay.dts
new file mode 100644
index 000000000000..1235a911caae
--- /dev/null
+++ b/arch/arm64/boot/dts/hisilicon/hi3660-hikey960-overlay.dts
@@ -0,0 +1,16 @@
+// SPDX-License-Identifier: GPL-2.0
+/dts-v1/;
+/plugin/;
+
+&dwmmc2 {
+       #address-cells = <0x1>;
+       #size-cells = <0x0>;
+
+       wlcore2: wlcore@5 {
+               compatible = "ti,wl1837";
+               reg = <2>;
+               interrupt-parent = <&gpio22>;
+               interrupts = <3 1>;
+               test = <1>;
+       };
+};

Even after your patch there are some issues I am facing:

1. dtbs_check doesn't test hi3660-hikey960-overlay.dts. I also tried
   to add it to dtbo-y +=, but that didn't do anything as well.

I expected this to work as we have this in scripts/Makefile.lib:

 ifneq ($(CHECK_DTBS),)
 extra-y += $(patsubst %.dtb,%.dt.yaml, $(dtb-y))
+extra-y += $(patsubst %.dtbo,%.dt.yaml, $(dtb-y))
 extra-$(CONFIG_OF_ALL_DTBS) += $(patsubst %.dtb,%.dt.yaml, $(dtb-))
+extra-$(CONFIG_OF_ALL_DTBS) += $(patsubst %.dtbo,%.dt.yaml, $(dtb-))
 endif


2. This fails dtbs_check as it tries to run it for the source file of
   test1.dtb

$ make ARCH=arm64 O=../barm64/ -j8 CROSS_COMPILE=aarch64-linux-gnu- dtbs_check
make[1]: Entering directory '/mnt/ssd/all/work/repos/devel/barm64'
make[3]: *** No rule to make target 'arch/arm64/boot/dts/hisilicon/test1.dt.yaml', needed by '__build'.  Stop.
/mnt/ssd/all/work/repos/devel/linux/scripts/Makefile.build:496: recipe for target 'arch/arm64/boot/dts/hisilicon' failed
make[2]: *** [arch/arm64/boot/dts/hisilicon] Error 2
make[2]: *** Waiting for unfinished jobs....
/mnt/ssd/all/work/repos/devel/linux/Makefile:1345: recipe for target 'dtbs' failed
make[1]: *** [dtbs] Error 2
make[1]: Leaving directory '/mnt/ssd/all/work/repos/devel/barm64'
Makefile:185: recipe for target '__sub-make' failed
make: *** [__sub-make] Error 2

I am not sure how to fix this.

-- 
viresh
