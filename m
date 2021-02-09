Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EFCA314790
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 05:35:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230138AbhBIEdj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 23:33:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230131AbhBIEFG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 23:05:06 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5512AC06178B
        for <linux-kernel@vger.kernel.org>; Mon,  8 Feb 2021 20:04:05 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id o7so11664186pgl.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Feb 2021 20:04:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=au9zGJI92rCYptzRiz2GTxndwXWMkdMY60ITYaRvJ48=;
        b=pNiqgSv7Zq+dihvISC6o3Vyf1V+HDRTxtg5M1v5ONv3+vn3Bw1+deTY0IopTUwk00X
         Vyx/bHrdx2wIhPuJS41p26TniVdoF4FreVxUagnUUXnNBXuZbdBEIBY+QFRiotim23p7
         1Nbe13cBkwQJdXZUJdl5y/U/IGD5jhnjtU31afGIjDcJGKOVJU/GnHfVxeQyAdXc2kcR
         vl+8G3iF0ZErBCZLpIZx6qK1GN18pqnQlbRzSLslOGeJ4aSHuhuAA10FBcMfSyYGmEAo
         c7+/eho7+otUdK/vxIUQSwkwfMK5bRTv+Je/xXDbklsXm1R4TdfEMVhzDi+8bm8/qhcH
         ALBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=au9zGJI92rCYptzRiz2GTxndwXWMkdMY60ITYaRvJ48=;
        b=Zkv1Ab6aeJ7JHylCsgkWZQSJzIvrBA5cq87VfmsrdWeQr0x+TE+CKbYhGGq2lihMca
         DGmI0ka7B3Rkfd9PjvL3w94GcQJUDPqqOaQYlkutoeUgMm6P6IKDHpZxQH916Eo/o0Yh
         jdVnhIaKUNykTlx4GnqqOnJwCaBof+UWxHYniOZI2jYC2R0drjoyKaLP2x8Yx79FjMHF
         gXMTKboQeYb8xTjYcbpziB1dFw31AoGzEu14LfUbIPMXCWAxmxylAArp0QN9hkTsvguI
         wrK4+m9LWfChFjiuJNLH+2erkBgoHdbzYy4ar5GhjFBR/WqdnG/y9PHQDP3EijM3wNPA
         UxHA==
X-Gm-Message-State: AOAM531ZqQ+N82qjIMvveZmpBx7YgrZrNmm74C5RWcon+bgzIMsxuDS3
        mfZnbgVH5oJPnW916G34toUeTA==
X-Google-Smtp-Source: ABdhPJzMxrmqTRmQb7VYVSMoSHfQalmUB4OnhVBzLyJePOaHHdx7FC9WvPb05H5V0noe6+vqV4ByiQ==
X-Received: by 2002:aa7:8016:0:b029:1d5:ea54:d7be with SMTP id j22-20020aa780160000b02901d5ea54d7bemr20976254pfi.29.1612843444429;
        Mon, 08 Feb 2021 20:04:04 -0800 (PST)
Received: from localhost ([122.172.59.240])
        by smtp.gmail.com with ESMTPSA id j7sm20246400pfh.147.2021.02.08.20.04.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Feb 2021 20:04:03 -0800 (PST)
Date:   Tue, 9 Feb 2021 09:34:01 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Anmar Oueja <anmar.oueja@linaro.org>,
        Bill Mills <bill.mills@linaro.org>,
        David Gibson <david@gibson.dropbear.id.au>,
        devicetree@vger.kernel.org, Michal Marek <michal.lkml@markovi.net>
Subject: Re: [PATCH V7 6/6] of: unittest: Statically apply overlays using
 fdtoverlay
Message-ID: <20210209040401.j5yya6qa442dvrur@vireshk-i7>
References: <cover.1611904394.git.viresh.kumar@linaro.org>
 <3683a542d4141cfcf9c2524a40a9ee75b657c1c2.1611904394.git.viresh.kumar@linaro.org>
 <20210204015409.GA3150757@robh.at.kernel.org>
 <20210208111813.oql6jmeaxuq3btz7@vireshk-i7>
 <CAL_JsqK+eM_RrzXnbm2GJGJuVwAjEz1TeTux18Hc727vovbqDA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_JsqK+eM_RrzXnbm2GJGJuVwAjEz1TeTux18Hc727vovbqDA@mail.gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08-02-21, 08:21, Rob Herring wrote:
> In string 'm' replace '.dtb' with '-dtbs'. Then we get the value of
> that variable.

Ah, thanks. I was able to get everything to work as expected now :)

> >  ifneq ($(CHECK_DTBS),)
> >  extra-y += $(patsubst %.dtb,%.dt.yaml, $(dtb-y))
> > +extra-y += $(patsubst %.dtbo,%.dt.yaml, $(dtb-y))
> >  extra-$(CONFIG_OF_ALL_DTBS) += $(patsubst %.dtb,%.dt.yaml, $(dtb-))
> > +extra-$(CONFIG_OF_ALL_DTBS) += $(patsubst %.dtbo,%.dt.yaml, $(dtb-))
> >  endif
> 
> I'll have to try that out. I think that should work.

It works with your patch itself, just that it was done after the
failure and so wasn't happening.

> > 2. This fails dtbs_check as it tries to run it for the source file of
> >    test1.dtb
> >
> > $ make ARCH=arm64 O=../barm64/ -j8 CROSS_COMPILE=aarch64-linux-gnu- dtbs_check
> > make[1]: Entering directory '/mnt/ssd/all/work/repos/devel/barm64'
> > make[3]: *** No rule to make target 'arch/arm64/boot/dts/hisilicon/test1.dt.yaml', needed by '__build'.  Stop.
> > /mnt/ssd/all/work/repos/devel/linux/scripts/Makefile.build:496: recipe for target 'arch/arm64/boot/dts/hisilicon' failed
> > make[2]: *** [arch/arm64/boot/dts/hisilicon] Error 2
> > make[2]: *** Waiting for unfinished jobs....
> > /mnt/ssd/all/work/repos/devel/linux/Makefile:1345: recipe for target 'dtbs' failed
> > make[1]: *** [dtbs] Error 2
> > make[1]: Leaving directory '/mnt/ssd/all/work/repos/devel/barm64'
> > Makefile:185: recipe for target '__sub-make' failed
> > make: *** [__sub-make] Error 2
> >
> > I am not sure how to fix this.
> 
> Even if we fixed the make rules, it's not going to work with
> validation. There's some information from source files that we
> maintain in yaml output, but is lost in dtb output. For example, the
> sizes of /bits/ syntax are maintained. For now, I think we'll want to
> just validate base and overlays separately. We may need to turn off
> checks in overlays for required properties as they may be incomplete.
> We already do that on disabled nodes.

I did this instead and it made everything work, we don't try dt.yaml
for the test1.dtb file anymore, is this acceptable ?

diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index 886d2e6c58f0..b86ff1b3de14 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -66,7 +66,7 @@ multi-used   := $(multi-used-y) $(multi-used-m)
 real-obj-y := $(foreach m, $(obj-y), $(if $(strip $($(m:.o=-objs)) $($(m:.o=-y)) $($(m:.o=-))),$($(m:.o=-objs)) $($(m:.o=-y)),$(m)))
 real-obj-m := $(foreach m, $(obj-m), $(if $(strip $($(m:.o=-objs)) $($(m:.o=-y)) $($(m:.o=-m)) $($(m:.o=-))),$($(m:.o=-objs)) $($(m:.o=-y)) $($(m:.o=-m)),$(m)))
 
-real-dtb-y := $(foreach m,$(dtb-y), $(if $(strip $($(m:.dtb=-dtbs))),$($(m:.dtb=-dtbs)),))
+real-dtb-y := $(foreach m,$(overlay-y), $(if $(strip $($(m:.dtb=-dtbs))),$($(m:.dtb=-dtbs)),))
 dtb-y += $(real-dtb-y)
 
 always-y += $(always-m)

diff --git a/arch/arm64/boot/dts/hisilicon/Makefile b/arch/arm64/boot/dts/hisilicon/Makefile
index f4d68caeba83..69ca27014e89 100644
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
+overlay-y += test1.dtb
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

-- 
viresh
