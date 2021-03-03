Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E8E032BAB3
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 21:59:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351768AbhCCLuM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 06:50:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352972AbhCCEjf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 23:39:35 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9A08C061756
        for <linux-kernel@vger.kernel.org>; Tue,  2 Mar 2021 20:36:39 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id s7so6146720plg.5
        for <linux-kernel@vger.kernel.org>; Tue, 02 Mar 2021 20:36:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=F/YHDNwyYioDOL4y0mRj7OebKXsbka3rl1hm6OjzmaY=;
        b=ch3cHzFNh97JDaBblOrq+50iTkDmK2AT7z6I3O2xvgv+PysPFbX1Y1HuYM4vfj+KZU
         g/qQACEVXZ42IP8AwdhlHa1VWtb9Nl8Azbb2WgFTdXmAEdJ9u/SOsGEbbdRxKKe0mH+k
         RMIUP9AWYWcqbUEZ7mlT0LN50TeHSSAxKdEywKp+rLvt+XOJ9p2ppaOnceco5LFKUFVw
         +nXOY0CLUrRJUJ5I9Kcs19uA44wkhcIyaATN+BMzi2lsR9u33VLUGPa8xsmqNrYNT1aW
         W3R/8CarqPxusB5qpz0GiAuRrFmvpB6AiNEzIz3Y3vwWb8env+VBq/b+CEWL8SJ/XWe/
         WNtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=F/YHDNwyYioDOL4y0mRj7OebKXsbka3rl1hm6OjzmaY=;
        b=MPl72u+M7PxpfxgewRgk/GKxqLeWe0HHGvaMfDyc456rOyqNhRRTWcxk416o09vEC/
         DtTL2Gj/KLwO4RmhyCg7UPo2Imu7k9qQJOTjU6ZdJxC4ETBcRrSQBNPTnP2CogjdnFbg
         zI8AHErQuTh88BlhfQJeU0PLujOOUxFQpPBcfu3cx86rzFVySBnseDs7r5i6uNKNWA+Z
         tZkNetyOphxOvhYEI0xSh20cbEexwVvNzltUjF1NXnbDQ1Um+zzgTZTewMvrcSbRkki2
         PgCXWhrs13NRr2VBSWePpamTr4+PbFPC+TAKorazKUXSggsOojVSW8c13m6k4SMTohEW
         rq2Q==
X-Gm-Message-State: AOAM531MRHVIzCLWSNR3MS+oPOmUjoiW07jSaBXihJzWaxNmmdvvhjBH
        Nc5xHEt309nBXG1vNIthcIk2sg==
X-Google-Smtp-Source: ABdhPJwwWJTdXYWvvfOb4RSzBUkpuf6EHQtfVedvW6/pAz7WFKd/xKJ3kWXFlkDV82YhuFXkk11xyQ==
X-Received: by 2002:a17:90a:7061:: with SMTP id f88mr7877158pjk.56.1614746199493;
        Tue, 02 Mar 2021 20:36:39 -0800 (PST)
Received: from localhost ([122.171.124.15])
        by smtp.gmail.com with ESMTPSA id m19sm21736807pfa.70.2021.03.02.20.36.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Mar 2021 20:36:39 -0800 (PST)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        David Gibson <david@gibson.dropbear.id.au>,
        Frank Rowand <frowand.list@gmail.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        anmar.oueja@linaro.org, Bill Mills <bill.mills@linaro.org>,
        Rob Herring <robh@kernel.org>, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V9 2/4] kbuild: Add generic rule to apply fdtoverlay
Date:   Wed,  3 Mar 2021 10:06:18 +0530
Message-Id: <263ac0777bee9384b66fb4e74ed3abdc45a1bb82.1614745266.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.25.0.rc1.19.g042ed3e048af
In-Reply-To: <cover.1614745266.git.viresh.kumar@linaro.org>
References: <cover.1614745266.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rob Herring <robh@kernel.org>

Add a generic rule to apply fdtoverlay in Makefile.lib, so every
platform doesn't need to carry the complex rule.

The platform's Makefile only needs to have this now:

 DTC_FLAGS_foo_base += -@
 foo-dtbs := foo_base.dtb foo_overlay1.dtbo foo_overlay2.dtbo
 dtb-y := foo.dtb

We don't want to run schema checks on foo.dtb (as foo.dts doesn't exist)
and the Makefile is updated accordingly.

Signed-off-by: Rob Herring <robh@kernel.org>
Co-developed-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 scripts/Makefile.lib | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index a2658242d956..c430fbb36763 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -58,6 +58,10 @@ real-search = $(foreach m,$(1), $(if $(strip $(call suffix-search,$(m),$(2) -)),
 real-obj-y := $(call real-search, $(obj-y),-objs -y)
 real-obj-m := $(call real-search, $(obj-m),-objs -y -m)
 
+# List all dtbs to be generated by fdtoverlay
+overlay-y := $(foreach m,$(dtb-y), $(if $(strip $($(m:.dtb=-dtbs))),$(m),))
+overlay-$(CONFIG_OF_ALL_DTBS) += $(foreach m,$(dtb-), $(if $(strip $($(m:.dtb=-dtbs))),$(m),))
+
 always-y += $(always-m)
 
 # hostprogs-always-y += foo
@@ -72,14 +76,21 @@ userprogs += $(userprogs-always-y) $(userprogs-always-m)
 always-y += $(userprogs-always-y) $(userprogs-always-m)
 
 # DTB
+# Add base dtb and overlay dtbo
+dtb-y += $(foreach m,$(overlay-y), $($(m:.dtb=-dtbs)))
+
 # If CONFIG_OF_ALL_DTBS is enabled, all DT blobs are built
 dtb-$(CONFIG_OF_ALL_DTBS)       += $(dtb-)
 
 always-y			+= $(dtb-y)
 
 ifneq ($(CHECK_DTBS),)
-always-y += $(patsubst %.dtb,%.dt.yaml, $(dtb-y))
-always-y += $(patsubst %.dtbo,%.dt.yaml, $(dtb-y))
+# Don't run schema checks for dtbs created by fdtoverlay as they don't
+# have corresponding dts files.
+dt-yaml-y := $(filter-out $(overlay-y),$(dtb-y))
+
+always-y += $(patsubst %.dtb,%.dt.yaml, $(dt-yaml-y))
+always-y += $(patsubst %.dtbo,%.dt.yaml, $(dt-yaml-y))
 endif
 
 # Add subdir path
@@ -337,6 +348,15 @@ $(obj)/%.dtb: $(src)/%.dts $(DTC) FORCE
 $(obj)/%.dtbo: $(src)/%.dts $(DTC) FORCE
 	$(call if_changed_dep,dtc)
 
+overlay-y := $(addprefix $(obj)/, $(overlay-y))
+
+quiet_cmd_fdtoverlay = DTOVL   $@
+      cmd_fdtoverlay = $(objtree)/scripts/dtc/fdtoverlay -o $@ -i $(real-prereqs)
+
+$(overlay-y): FORCE
+	$(call if_changed,fdtoverlay)
+$(call multi_depend, $(overlay-y), .dtb, -dtbs)
+
 DT_CHECKER ?= dt-validate
 DT_BINDING_DIR := Documentation/devicetree/bindings
 # DT_TMP_SCHEMA may be overridden from Documentation/devicetree/bindings/Makefile
-- 
2.25.0.rc1.19.g042ed3e048af

