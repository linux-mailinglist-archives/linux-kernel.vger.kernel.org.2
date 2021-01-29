Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95161308674
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jan 2021 08:34:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232279AbhA2H3V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jan 2021 02:29:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232242AbhA2H25 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jan 2021 02:28:57 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFD62C061793
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 23:27:45 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id s24so5323056pjp.5
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 23:27:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZC1Ffn2n+T2+/SKKdskHJGHoUkjvYaC8Y9q/8gZ/2nI=;
        b=hA0E36099D3Jnqvwzt/jsYfGd5mNS1Ozh+s16u/63PXTiiG+rHKntAJXf9MMOJN+JH
         vfbg6eITjBWf4Tw+N/KACEa/FPBpZs0Oiz6O5kW6Sx4T5S8PI0Ih89JuVCEWIomefJ7/
         3C7ilMbNQr+4+TtL5h5NRiizFtUbOLfUk62rUpsTXXvtrhv900UAnxPVfY5fZdxGF+rD
         Cg0xLV1gAjgoP6MQYUhkFaMvn5MxEanqJMLPk6zlxpizUOhdG8DMZoDTWwwRzWviplG2
         00sDrptMsSG1ZtsQ+PDR33ZGBrMS2uUMSyFR7c3LMvJLlxu4lY1IFHoHumo1xEr8sAuo
         cN6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZC1Ffn2n+T2+/SKKdskHJGHoUkjvYaC8Y9q/8gZ/2nI=;
        b=uFNZT5G7JyVngPunAwmIiiJLk32h/Xs3oAEUBH65GMAWMTKI98cup5i4Y0UHOPFbzb
         pdvesfQPLF50AFVlqBqUQNgbO/ST46cWZw9mEQ4WO9CwzZZgELxOopBs5nyHsgZ5I6fB
         L0agjaLrivVd1l3AAUnmQNezEWMvBvQ9iEjrc2EDeexjDnNYZz1ZNyZpiyj6dXhLv6f3
         0FYrjgW3FahAYx0z8ycxPxq8x/ShGxXtMPOjOCZW83DD5qztT1XyMWC6mv8+e79kci1R
         F/DhDjdQ/oimINID/Sxm8qJcIUhPGz2CjVB38Q3Db/hdsVJFGG4s5soK78y0+5ibaF+N
         2/mg==
X-Gm-Message-State: AOAM531ed56k9U8JbUwpltvQI1jv6yhUPKB/yOymwZRLkJJW4JftIjF5
        ls0mkCzPcOjqzzHiPDQArfUjyw==
X-Google-Smtp-Source: ABdhPJxvo/LaMa460D0byxNPMe+n4/U+GQ9fXpx3aVjMCnu+U2ja+QFzQn4FY4nVPS1PmTre+9HjNA==
X-Received: by 2002:a17:90a:df46:: with SMTP id gy6mr3332054pjb.163.1611905265418;
        Thu, 28 Jan 2021 23:27:45 -0800 (PST)
Received: from localhost ([122.172.59.240])
        by smtp.gmail.com with ESMTPSA id w14sm6870723pjl.38.2021.01.28.23.27.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Jan 2021 23:27:44 -0800 (PST)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Frank Rowand <frowand.list@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org, anmar.oueja@linaro.org,
        Bill Mills <bill.mills@linaro.org>,
        David Gibson <david@gibson.dropbear.id.au>,
        devicetree@vger.kernel.org, linux-kbuild@vger.kernel.org
Subject: [PATCH V7 4/6] kbuild: Add support to build overlays (%.dtbo)
Date:   Fri, 29 Jan 2021 12:54:08 +0530
Message-Id: <434ba2467dd0cd011565625aeb3450650afe0aae.1611904394.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.25.0.rc1.19.g042ed3e048af
In-Reply-To: <cover.1611904394.git.viresh.kumar@linaro.org>
References: <cover.1611904394.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for building DT overlays (%.dtbo). The overlay's source file
will have the usual extension, i.e. .dts, though the blob will have
.dtbo extension to distinguish it from normal blobs.

Acked-by: Masahiro Yamada <masahiroy@kernel.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 .gitignore               | 1 +
 Makefile                 | 5 ++++-
 scripts/Makefile.dtbinst | 3 +++
 scripts/Makefile.lib     | 5 +++++
 4 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/.gitignore b/.gitignore
index d01cda8e1177..bb65fa253e58 100644
--- a/.gitignore
+++ b/.gitignore
@@ -18,6 +18,7 @@
 *.c.[012]*.*
 *.dt.yaml
 *.dtb
+*.dtbo
 *.dtb.S
 *.dwo
 *.elf
diff --git a/Makefile b/Makefile
index e0af7a4a5598..d5bc67e523be 100644
--- a/Makefile
+++ b/Makefile
@@ -1337,6 +1337,9 @@ ifneq ($(dtstree),)
 %.dtb: include/config/kernel.release scripts_dtc
 	$(Q)$(MAKE) $(build)=$(dtstree) $(dtstree)/$@
 
+%.dtbo: include/config/kernel.release scripts_dtc
+	$(Q)$(MAKE) $(build)=$(dtstree) $(dtstree)/$@
+
 PHONY += dtbs dtbs_install dtbs_check
 dtbs: include/config/kernel.release scripts_dtc
 	$(Q)$(MAKE) $(build)=$(dtstree)
@@ -1816,7 +1819,7 @@ clean: $(clean-dirs)
 	@find $(if $(KBUILD_EXTMOD), $(KBUILD_EXTMOD), .) $(RCS_FIND_IGNORE) \
 		\( -name '*.[aios]' -o -name '*.ko' -o -name '.*.cmd' \
 		-o -name '*.ko.*' \
-		-o -name '*.dtb' -o -name '*.dtb.S' -o -name '*.dt.yaml' \
+		-o -name '*.dtb' -o -name '*.dtbo' -o -name '*.dtb.S' -o -name '*.dt.yaml' \
 		-o -name '*.dwo' -o -name '*.lst' \
 		-o -name '*.su' -o -name '*.mod' \
 		-o -name '.*.d' -o -name '.*.tmp' -o -name '*.mod.c' \
diff --git a/scripts/Makefile.dtbinst b/scripts/Makefile.dtbinst
index 50d580d77ae9..ba01f5ba2517 100644
--- a/scripts/Makefile.dtbinst
+++ b/scripts/Makefile.dtbinst
@@ -29,6 +29,9 @@ quiet_cmd_dtb_install = INSTALL $@
 $(dst)/%.dtb: $(obj)/%.dtb
 	$(call cmd,dtb_install)
 
+$(dst)/%.dtbo: $(obj)/%.dtbo
+	$(call cmd,dtb_install)
+
 PHONY += $(subdirs)
 $(subdirs):
 	$(Q)$(MAKE) $(dtbinst)=$@ dst=$(patsubst $(obj)/%,$(dst)/%,$@)
diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index 213677a5ed33..b00855b247e0 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -86,7 +86,9 @@ extra-$(CONFIG_OF_ALL_DTBS)	+= $(dtb-)
 
 ifneq ($(CHECK_DTBS),)
 extra-y += $(patsubst %.dtb,%.dt.yaml, $(dtb-y))
+extra-y += $(patsubst %.dtbo,%.dt.yaml, $(dtb-y))
 extra-$(CONFIG_OF_ALL_DTBS) += $(patsubst %.dtb,%.dt.yaml, $(dtb-))
+extra-$(CONFIG_OF_ALL_DTBS) += $(patsubst %.dtbo,%.dt.yaml, $(dtb-))
 endif
 
 # Add subdir path
@@ -327,6 +329,9 @@ cmd_dtc = $(HOSTCC) -E $(dtc_cpp_flags) -x assembler-with-cpp -o $(dtc-tmp) $< ;
 $(obj)/%.dtb: $(src)/%.dts $(DTC) FORCE
 	$(call if_changed_dep,dtc)
 
+$(obj)/%.dtbo: $(src)/%.dts $(DTC) FORCE
+	$(call if_changed_dep,dtc)
+
 DT_CHECKER ?= dt-validate
 DT_BINDING_DIR := Documentation/devicetree/bindings
 # DT_TMP_SCHEMA may be overridden from Documentation/devicetree/bindings/Makefile
-- 
2.25.0.rc1.19.g042ed3e048af

