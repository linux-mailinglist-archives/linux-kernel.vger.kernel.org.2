Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF71E33CEA8
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 08:32:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232697AbhCPHc1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 03:32:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232640AbhCPHcS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 03:32:18 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AECE7C061756
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 00:32:18 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id y13so8241946pfr.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 00:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=y1bBx21hw1CzzID+X6WsgVeOPSC72x4uJYWEaqJ/Z0k=;
        b=V2RFEwulx/vmmxCVThpGaX31BjZxPq/HaiAUVz6aPCoy8iz2nArBTYGgfx1+zjz+g9
         X3hVvheZe+FIm4IJOf7PgnPSEOpqVlmYw0e7IMrvBjk/tHHXtpICNDRQXT0IajSSq3Ld
         cc9JdHYODvykIGo/xK/W/v7JrN1gMTUlkbn8GcuTuel/kDUq9iL47nSdRN9Aoa1IvdTy
         rLg5UWxYF3qK9qsj0+901MucOgf5GVS6WoEJ5LV/eH4J+hC6sTKyporZ5A4dp9e1i/Cj
         TAmv5TbJrrjMBxOuo8MPuvoWGkkLuIEkjHiz6DYAHeU4zTdv91iafj+FceSDtpQ3EZ/U
         Y7Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=y1bBx21hw1CzzID+X6WsgVeOPSC72x4uJYWEaqJ/Z0k=;
        b=Ee2OXmo9uBx8FREWYj0l+caldqnB17c8OxKnoj9nFUoroLeVy8PI0TFPE0POOUd20h
         HYfDp0zQ9By+2LYKuSp5zfLswMVd8PW5AbBz2oR1tYOIt++hfDYUZkwNw17nU8wHw9xS
         dfZQcgJSX3oIFj+J1URD3q8tt1v7APBCb+ySEUefw0oNZZNtKsRHtaGP6YzGl8LcLCby
         Nrh2LKeBgQY+y9wDLAc8sT/FWwhWOOqCdEwH915joKqbZ6QVtXPbdl4bUTZbF9XGYHA0
         82ZQydT5rI4cuHUMPhoefWsC9heU4iOPSHD50DevOBgcys/CDQ6paJXvEseGo+aclqUS
         t/bw==
X-Gm-Message-State: AOAM5328ptqa9aSBVBhB5sG0unJNrR91QH0EE5zxNARSEuoZe4jcLPLh
        1jeeVAJnFyrdzB/LqFhcGWeJ1w==
X-Google-Smtp-Source: ABdhPJwFpDuk0kMrQ6RLb/8KVDQfOEee9MhCLT9V+cH6JxfA97NSVTxqnB4RgeFG21Dphm69XzzUfw==
X-Received: by 2002:a63:c702:: with SMTP id n2mr2696868pgg.382.1615879938106;
        Tue, 16 Mar 2021 00:32:18 -0700 (PDT)
Received: from localhost ([122.171.124.15])
        by smtp.gmail.com with ESMTPSA id b64sm15644839pfa.191.2021.03.16.00.32.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Mar 2021 00:32:17 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        David Gibson <david@gibson.dropbear.id.au>,
        Michal Simek <michal.simek@xilinx.com>,
        Bill Mills <bill.mills@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kbuild@vger.kernel.org
Subject: [PATCH V3] kbuild: Allow .dtso format for overlay source files
Date:   Tue, 16 Mar 2021 13:02:14 +0530
Message-Id: <01b4b67d8cebc00c94e786f6e06f69fc10d39364.1615877125.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.25.0.rc1.19.g042ed3e048af
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the overlays dtb files are now named as .dtbo, there is a lot of
interest in similarly naming the overlay source dts files as .dtso.

This patch makes the necessary changes to allow .dtso format for overlay
source files.

Note that the device-tree unit-tests name their overlay files as .dts
and it would take substantial amount of changes to update them to .dtso
and that would probably involve some local rules in unit-test's Makefile
as well. This patch goes for a simpler solution instead, i.e. allow .dts
to .dtbo conversion for device-tree unit-tests.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
This was made part of the bigger patchset earlier (most of it already
got merged) whose last version was V11, but this patch was only sent
twice earlier and so starting with Version 3.

Changes since V2:

- Add the dts -> dtbo rule in unittest-data/Makefile.
- Remove the -I parameter to dtc.

 drivers/of/unittest-data/Makefile | 6 ++++++
 scripts/Makefile.lib              | 5 ++++-
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/of/unittest-data/Makefile b/drivers/of/unittest-data/Makefile
index a5d2d9254b2c..e8dd839bdcbb 100644
--- a/drivers/of/unittest-data/Makefile
+++ b/drivers/of/unittest-data/Makefile
@@ -86,3 +86,9 @@ static_test_1-dtbs := static_base_1.dtb $(apply_static_overlay_1)
 static_test_2-dtbs := static_base_2.dtb $(apply_static_overlay_2)
 
 dtb-$(CONFIG_OF_OVERLAY) += static_test_1.dtb static_test_2.dtb
+
+# We can't name the overlay files .dtso, it would require much more substantial
+# changes in Makefile. Instead allow building the overlay .dtbo files from .dts
+# source files for unittests.
+$(obj)/%.dtbo: $(src)/%.dts $(DTC) FORCE
+	$(call if_changed_dep,dtc)
diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index 90b095c60f79..a682869d8f4b 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -347,7 +347,7 @@ cmd_dtc = $(HOSTCC) -E $(dtc_cpp_flags) -x assembler-with-cpp -o $(dtc-tmp) $< ;
 $(obj)/%.dtb: $(src)/%.dts $(DTC) FORCE
 	$(call if_changed_dep,dtc)
 
-$(obj)/%.dtbo: $(src)/%.dts $(DTC) FORCE
+$(obj)/%.dtbo: $(src)/%.dtso $(DTC) FORCE
 	$(call if_changed_dep,dtc)
 
 overlay-y := $(addprefix $(obj)/, $(overlay-y))
@@ -376,6 +376,9 @@ endef
 $(obj)/%.dt.yaml: $(src)/%.dts $(DTC) $(DT_TMP_SCHEMA) FORCE
 	$(call if_changed_rule,dtc,yaml)
 
+$(obj)/%.dt.yaml: $(src)/%.dtso $(DTC) $(DT_TMP_SCHEMA) FORCE
+	$(call if_changed_rule,dtc,yaml)
+
 dtc-tmp = $(subst $(comma),_,$(dot-target).dts.tmp)
 
 # Bzip2
-- 
2.25.0.rc1.19.g042ed3e048af

