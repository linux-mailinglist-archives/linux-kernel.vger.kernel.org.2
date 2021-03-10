Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4CBD333573
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 06:36:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232421AbhCJFgK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 00:36:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231686AbhCJFf6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 00:35:58 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2508C06174A
        for <linux-kernel@vger.kernel.org>; Tue,  9 Mar 2021 21:35:46 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id t26so10627994pgv.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Mar 2021 21:35:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eTA/ruWCUgwnz7vARSSAyGAv3Tz9MwTQ6Galh4vgX/g=;
        b=iH3+q1Xod3OxVIhlv6X+MQ7xk+j6fw+YV+nNTITClugPqV2++j+2lvPOaiuI3EQLj9
         3PMgUbSHE2tjaAz3WgNT3vm7w0c80pMsQB8fxqfA0VamkOT5051UfCS4oCNKKir72/Zq
         tUhhJIREHQdGArk8CeqF9EIy/swECCxxSSfBqQrZDmJpkUaSSsowrdwDHFisGDLTJxh+
         6h2I/s5V0HesNsh4I05x4SZnbW+tz3TzCCRRHYRAF8xysx5q/0bLlbtuVMdBmrPkyakK
         LcP3wagtnvL31Ad303r/58LtSbP+saeDfSdVDoG6gbLu3QMyZtgEoS7jT98/xEDZrYth
         uWPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eTA/ruWCUgwnz7vARSSAyGAv3Tz9MwTQ6Galh4vgX/g=;
        b=V+qxERWL5fag7e5hXHyS1u3ZASH2fEy6QfzobKH+Hd7Y/x3ZmK+FNZ9bA3fmgvlgO9
         owMnbOTjuyKpp4mFz9x3hcdtC9OxH0aRMFRJ9JyA9ZEe6Yy5320m01zSaZ27JOHXAJvk
         fSmRsOLMAVjRn09FBXezFcKUDgMd/D7ZXDIxc5wOY9I3aPPdPlbfnd8CCjsi1jsIYs8D
         aPePv2jqL6WXn111bMddauFkCawoVivPy/d9k382p+bWdxZUQPsKYKoEnkAs6ntfIg/B
         4tDK0WHIWTd/knppsxWfQrpB0jb7nq0ERiN1r03/hJm95BxLps2vWQefscCou1hD3mv8
         5Z9w==
X-Gm-Message-State: AOAM5301KsO2ND7nLSnVx2TXVqIQ0mVIBS8hW/p7lNJ5J6zMmjlfNMtc
        NHF//38A5Uqqb8x7JZ8Y2mFB3w==
X-Google-Smtp-Source: ABdhPJyZ9bQmK3Vd4EHakSul/0C8c+C7oWYBoZvwVmb6p3cCQXKy/EA84cDs8q+tyMRlqkaiNceSpA==
X-Received: by 2002:a63:484b:: with SMTP id x11mr1387346pgk.2.1615354546486;
        Tue, 09 Mar 2021 21:35:46 -0800 (PST)
Received: from localhost ([122.171.124.15])
        by smtp.gmail.com with ESMTPSA id l15sm4656732pjq.9.2021.03.09.21.35.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Mar 2021 21:35:46 -0800 (PST)
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
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V11 3/5] kbuild: Allow .dtso format for overlay source files
Date:   Wed, 10 Mar 2021 11:05:31 +0530
Message-Id: <170e086a5fa076869e7b37de8eea850fa7c39118.1615354376.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.25.0.rc1.19.g042ed3e048af
In-Reply-To: <cover.1615354376.git.viresh.kumar@linaro.org>
References: <cover.1615354376.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the overlays dtb files are now named as .dtbo, there is a lot of
interest in similarly naming the overlay source dts files as .dtso.

This patch makes the necessary changes to allow .dtso format for overlay
source files.

Note that we still support generating .dtbo files from .dts files. This
is required for the source files present in drivers/of/unittest-data/,
because they can't be renamed to .dtso as they are used for some runtime
testing as well.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 scripts/Makefile.lib | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index bc045a54a34e..59e86f67f9e0 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -339,7 +339,7 @@ $(obj)/%.dtb.S: $(obj)/%.dtb FORCE
 
 quiet_cmd_dtc = DTC     $@
 cmd_dtc = $(HOSTCC) -E $(dtc_cpp_flags) -x assembler-with-cpp -o $(dtc-tmp) $< ; \
-	$(DTC) -O $(patsubst .%,%,$(suffix $@)) -o $@ -b 0 \
+	$(DTC) -I dts -O $(patsubst .%,%,$(suffix $@)) -o $@ -b 0 \
 		$(addprefix -i,$(dir $<) $(DTC_INCLUDE)) $(DTC_FLAGS) \
 		-d $(depfile).dtc.tmp $(dtc-tmp) ; \
 	cat $(depfile).pre.tmp $(depfile).dtc.tmp > $(depfile)
@@ -347,9 +347,13 @@ cmd_dtc = $(HOSTCC) -E $(dtc_cpp_flags) -x assembler-with-cpp -o $(dtc-tmp) $< ;
 $(obj)/%.dtb: $(src)/%.dts $(DTC) FORCE
 	$(call if_changed_dep,dtc)
 
+# Required for of unit-test files as they can't be renamed to .dtso
 $(obj)/%.dtbo: $(src)/%.dts $(DTC) FORCE
 	$(call if_changed_dep,dtc)
 
+$(obj)/%.dtbo: $(src)/%.dtso $(DTC) FORCE
+	$(call if_changed_dep,dtc)
+
 overlay-y := $(addprefix $(obj)/, $(overlay-y))
 
 quiet_cmd_fdtoverlay = DTOVL   $@
@@ -375,6 +379,9 @@ endef
 $(obj)/%.dt.yaml: $(src)/%.dts $(DTC) $(DT_TMP_SCHEMA) FORCE
 	$(call if_changed_rule,dtc,yaml)
 
+$(obj)/%.dt.yaml: $(src)/%.dtso $(DTC) $(DT_TMP_SCHEMA) FORCE
+	$(call if_changed_rule,dtc,yaml)
+
 dtc-tmp = $(subst $(comma),_,$(dot-target).dts.tmp)
 
 # Bzip2
-- 
2.25.0.rc1.19.g042ed3e048af

