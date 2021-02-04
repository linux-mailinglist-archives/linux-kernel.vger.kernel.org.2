Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55D1830E9BC
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 02:56:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234436AbhBDBzA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 20:55:00 -0500
Received: from mail-ot1-f51.google.com ([209.85.210.51]:45943 "EHLO
        mail-ot1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234250AbhBDByy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 20:54:54 -0500
Received: by mail-ot1-f51.google.com with SMTP id o12so1879047ote.12;
        Wed, 03 Feb 2021 17:54:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=X2PsPGTSsMQny8Jyooz1PwhhdoLEgmc9a8WXGjEwmh8=;
        b=H7f7fFzUhbNAhRXr13Q0p2RMetZhNUPXBKj84lvb8I/6Dz2Y7FC3IZJQq+ImyAezuV
         X3+bmWt16s9JoZF8/9tezwdTIMr2c6ePe1CyzfGRz5l91ByO4zcoDLji1el+ogN/4KhD
         Vx0Glmyo1phEwG8wcxng8w0Z+83uNvD7SJaMZp899dSKxKu8oatnxeO6E/cMo8SHluJ5
         oEZpkggiTiARQLjfRIUFzRL0AfkDV6Y3ivGvBWnxT4ONFeOXsVGj4whX7UipAhnu2q2f
         2ix5duJqRKh9tNKo43JL//VZZeigEurfVIMr+MqWloFPvGWbrA402WnVZCbp7yJH2IAk
         wTvQ==
X-Gm-Message-State: AOAM5327KyVxE9JLq3cCUmelEbChCPOJM69dDEe3OF7s0sV8QGwD9M2r
        8A79yzWmp/6wY36j71liIJyLejqxcA==
X-Google-Smtp-Source: ABdhPJyfQZUMfy33EOObUzPa8e2fexsc8Ey/nbsGSao2AZibEFE65NOPB5Uvc4aSYuVob8NvsyoysQ==
X-Received: by 2002:a05:6830:47:: with SMTP id d7mr3897361otp.246.1612403651348;
        Wed, 03 Feb 2021 17:54:11 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id m15sm814815otl.11.2021.02.03.17.54.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Feb 2021 17:54:10 -0800 (PST)
Received: (nullmailer pid 3169217 invoked by uid 1000);
        Thu, 04 Feb 2021 01:54:09 -0000
Date:   Wed, 3 Feb 2021 19:54:09 -0600
From:   Rob Herring <robh@kernel.org>
To:     Viresh Kumar <viresh.kumar@linaro.org>
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
Message-ID: <20210204015409.GA3150757@robh.at.kernel.org>
References: <cover.1611904394.git.viresh.kumar@linaro.org>
 <3683a542d4141cfcf9c2524a40a9ee75b657c1c2.1611904394.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3683a542d4141cfcf9c2524a40a9ee75b657c1c2.1611904394.git.viresh.kumar@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 29, 2021 at 12:54:10PM +0530, Viresh Kumar wrote:
> Now that fdtoverlay is part of the kernel build, start using it to test
> the unitest overlays we have by applying them statically. Create two new
> base files static_base_1.dts and static_base_2.dts which includes other
> .dtsi files.
> 
> Some unittest overlays deliberately contain errors that unittest checks
> for. These overlays will cause fdtoverlay to fail, and are thus not
> included for static builds.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/of/unittest-data/Makefile          | 56 ++++++++++++++++++++++
>  drivers/of/unittest-data/static_base_1.dts |  4 ++
>  drivers/of/unittest-data/static_base_2.dts |  4 ++
>  3 files changed, 64 insertions(+)
>  create mode 100644 drivers/of/unittest-data/static_base_1.dts
>  create mode 100644 drivers/of/unittest-data/static_base_2.dts

The first 4 patches look good to me, no need to resend those if you 
don't want to.

> 
> diff --git a/drivers/of/unittest-data/Makefile b/drivers/of/unittest-data/Makefile
> index 009f4045c8e4..fc286224b2d1 100644
> --- a/drivers/of/unittest-data/Makefile
> +++ b/drivers/of/unittest-data/Makefile
> @@ -34,7 +34,63 @@ DTC_FLAGS_overlay += -@
>  DTC_FLAGS_overlay_bad_phandle += -@
>  DTC_FLAGS_overlay_bad_symbol += -@
>  DTC_FLAGS_overlay_base += -@
> +DTC_FLAGS_static_base_1 += -@
> +DTC_FLAGS_static_base_2 += -@
>  DTC_FLAGS_testcases += -@
>  
>  # suppress warnings about intentional errors
>  DTC_FLAGS_testcases += -Wno-interrupts_property
> +
> +# Apply overlays statically with fdtoverlay.  This is a build time test that
> +# the overlays can be applied successfully by fdtoverlay.  This does not
> +# guarantee that the overlays can be applied successfully at run time by
> +# unittest, but it provides a bit of build time test coverage for those
> +# who do not execute unittest.
> +#
> +# The overlays are applied on top of static_base_1.dtb and static_base_2.dtb to
> +# create static_test_1.dtb and static_test_2.dtb.  If fdtoverlay detects an
> +# error than the kernel build will fail.  static_test_1.dtb and
> +# static_test_2.dtb are not consumed by unittest.
> +#
> +# Some unittest overlays deliberately contain errors that unittest checks for.
> +# These overlays will cause fdtoverlay to fail, and are thus not included
> +# in the static test:
> +#			  overlay_bad_add_dup_node.dtb \
> +#			  overlay_bad_add_dup_prop.dtb \
> +#			  overlay_bad_phandle.dtb \
> +#			  overlay_bad_symbol.dtb \
> +
> +apply_static_overlay_1 := overlay_0.dtb \
> +			  overlay_1.dtb \
> +			  overlay_2.dtb \
> +			  overlay_3.dtb \
> +			  overlay_4.dtb \
> +			  overlay_5.dtb \
> +			  overlay_6.dtb \
> +			  overlay_7.dtb \
> +			  overlay_8.dtb \
> +			  overlay_9.dtb \
> +			  overlay_10.dtb \
> +			  overlay_11.dtb \
> +			  overlay_12.dtb \
> +			  overlay_13.dtb \
> +			  overlay_15.dtb \
> +			  overlay_gpio_01.dtb \
> +			  overlay_gpio_02a.dtb \
> +			  overlay_gpio_02b.dtb \
> +			  overlay_gpio_03.dtb \
> +			  overlay_gpio_04a.dtb \
> +			  overlay_gpio_04b.dtb

As these are overlays, .dtbo

> +
> +apply_static_overlay_2 := overlay.dtb
> +
> +quiet_cmd_fdtoverlay = FDTOVERLAY $@
> +      cmd_fdtoverlay = $(objtree)/scripts/dtc/fdtoverlay -o $@ -i $^
> +
> +$(obj)/static_test_1.dtb: $(obj)/static_base_1.dtb $(addprefix $(obj)/,$(apply_static_overlay_1))
> +	$(call if_changed,fdtoverlay)
> +
> +$(obj)/static_test_2.dtb: $(obj)/static_base_2.dtb $(addprefix $(obj)/,$(apply_static_overlay_2))
> +	$(call if_changed,fdtoverlay)
> +
> +always-$(CONFIG_OF_OVERLAY) += static_test_1.dtb static_test_2.dtb

We can't be leaving all this for ordinary folks to copy-n-paste in 
every directory with overlays. It needs to be simple for users like 
multi-file modules:

test1-dtbs := static_base_1.dtb $(apply_static_overlay_1)
test2-dtbs := static_base_2.dtb $(apply_static_overlay_2)

dtb-$(CONFIG_OF_OVERLAY) += test1.dtb test2.dtb


I've gotten something working with the patch below. Hopefully, Masahiro 
has some comments on it. I couldn't get multiple '-dtbs' to work without 
the '.SECONDEXPANSION'.

Rob

8<-------------------------------------------------------------------
From 3f3f1e478d0cc512050c70eda2e9e6f577bc3107 Mon Sep 17 00:00:00 2001
From: Rob Herring <robh@kernel.org>
Date: Wed, 3 Feb 2021 19:22:47 -0600
Subject: [PATCH] rework dtb overlay building

Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/of/unittest-data/Makefile | 54 ++++++++++++++-----------------
 scripts/Makefile.lib              | 12 +++++++
 2 files changed, 36 insertions(+), 30 deletions(-)

diff --git a/drivers/of/unittest-data/Makefile b/drivers/of/unittest-data/Makefile
index fc286224b2d1..749d04ee6dc3 100644
--- a/drivers/of/unittest-data/Makefile
+++ b/drivers/of/unittest-data/Makefile
@@ -60,37 +60,31 @@ DTC_FLAGS_testcases += -Wno-interrupts_property
 #			  overlay_bad_phandle.dtb \
 #			  overlay_bad_symbol.dtb \
 
-apply_static_overlay_1 := overlay_0.dtb \
-			  overlay_1.dtb \
-			  overlay_2.dtb \
-			  overlay_3.dtb \
-			  overlay_4.dtb \
-			  overlay_5.dtb \
-			  overlay_6.dtb \
-			  overlay_7.dtb \
-			  overlay_8.dtb \
-			  overlay_9.dtb \
-			  overlay_10.dtb \
-			  overlay_11.dtb \
-			  overlay_12.dtb \
-			  overlay_13.dtb \
-			  overlay_15.dtb \
-			  overlay_gpio_01.dtb \
-			  overlay_gpio_02a.dtb \
-			  overlay_gpio_02b.dtb \
-			  overlay_gpio_03.dtb \
-			  overlay_gpio_04a.dtb \
-			  overlay_gpio_04b.dtb
+apply_static_overlay_1 := overlay_0.dtbo \
+			  overlay_1.dtbo \
+			  overlay_2.dtbo \
+			  overlay_3.dtbo \
+			  overlay_4.dtbo \
+			  overlay_5.dtbo \
+			  overlay_6.dtbo \
+			  overlay_7.dtbo \
+			  overlay_8.dtbo \
+			  overlay_9.dtbo \
+			  overlay_10.dtbo \
+			  overlay_11.dtbo \
+			  overlay_12.dtbo \
+			  overlay_13.dtbo \
+			  overlay_15.dtbo \
+			  overlay_gpio_01.dtbo \
+			  overlay_gpio_02a.dtbo \
+			  overlay_gpio_02b.dtbo \
+			  overlay_gpio_03.dtbo \
+			  overlay_gpio_04a.dtbo \
+			  overlay_gpio_04b.dtbo
 
 apply_static_overlay_2 := overlay.dtb
 
-quiet_cmd_fdtoverlay = FDTOVERLAY $@
-      cmd_fdtoverlay = $(objtree)/scripts/dtc/fdtoverlay -o $@ -i $^
+test1-dtbs := static_base_1.dtb $(apply_static_overlay_1)
+test2-dtbs := static_base_2.dtb $(apply_static_overlay_2)
 
-$(obj)/static_test_1.dtb: $(obj)/static_base_1.dtb $(addprefix $(obj)/,$(apply_static_overlay_1))
-	$(call if_changed,fdtoverlay)
-
-$(obj)/static_test_2.dtb: $(obj)/static_base_2.dtb $(addprefix $(obj)/,$(apply_static_overlay_2))
-	$(call if_changed,fdtoverlay)
-
-always-$(CONFIG_OF_OVERLAY) += static_test_1.dtb static_test_2.dtb
+dtb-$(CONFIG_OF_OVERLAY) += test1.dtb test2.dtb
diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index b00855b247e0..886d2e6c58f0 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -66,6 +66,9 @@ multi-used   := $(multi-used-y) $(multi-used-m)
 real-obj-y := $(foreach m, $(obj-y), $(if $(strip $($(m:.o=-objs)) $($(m:.o=-y)) $($(m:.o=-))),$($(m:.o=-objs)) $($(m:.o=-y)),$(m)))
 real-obj-m := $(foreach m, $(obj-m), $(if $(strip $($(m:.o=-objs)) $($(m:.o=-y)) $($(m:.o=-m)) $($(m:.o=-))),$($(m:.o=-objs)) $($(m:.o=-y)) $($(m:.o=-m)),$(m)))
 
+real-dtb-y := $(foreach m,$(dtb-y), $(if $(strip $($(m:.dtb=-dtbs))),$($(m:.dtb=-dtbs)),))
+dtb-y += $(real-dtb-y)
+
 always-y += $(always-m)
 
 # hostprogs-always-y += foo
@@ -332,6 +335,15 @@ $(obj)/%.dtb: $(src)/%.dts $(DTC) FORCE
 $(obj)/%.dtbo: $(src)/%.dts $(DTC) FORCE
 	$(call if_changed_dep,dtc)
 
+
+quiet_cmd_fdtoverlay = DTOVL   $@
+      cmd_fdtoverlay = $(objtree)/scripts/dtc/fdtoverlay -o $@ -i $(real-prereqs)
+
+.SECONDEXPANSION:
+
+$(obj)/%.dtb: $$(addprefix $$(obj)/,$$(%-dtbs)) FORCE
+	$(call if_changed,fdtoverlay)
+
 DT_CHECKER ?= dt-validate
 DT_BINDING_DIR := Documentation/devicetree/bindings
 # DT_TMP_SCHEMA may be overridden from Documentation/devicetree/bindings/Makefile
-- 
2.27.0


