Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FF50330B9C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 11:46:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231856AbhCHKpl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 05:45:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229818AbhCHKp2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 05:45:28 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05F86C06174A
        for <linux-kernel@vger.kernel.org>; Mon,  8 Mar 2021 02:45:28 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id ga23-20020a17090b0397b02900c0b81bbcd4so2741390pjb.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Mar 2021 02:45:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eTA/ruWCUgwnz7vARSSAyGAv3Tz9MwTQ6Galh4vgX/g=;
        b=oBqswjRqRn4rXSpsI9MSF4+KacaCLN3XZrU7xPy4TToCrDCIOUzHUegWYNFEE0dZK/
         Kybw0tW9U12gi47Jnd/tqRCC3afZIj70Au0SFZKvVYpPGlVKxlGPYwmLv0aWM2oaxZNw
         nqnw446HiOKBjPpepVHTkUjLbpq6lg3ifTb3d1eomQxkLMhvon3UKp/SuqAAwrZle34U
         sqlOFONJHf4/LEtOLN8B3+Sirf7eB5rqeLO9QwT5vkDAMnw2SkF8mnExyr6WEMLgOvE+
         GW/+KeMNVuisOMCBEx1oAaXpk1cVHILTi1Sb/cm5CaO9q7rIAbqG/eQVqTQqaP3Zh7Nx
         E7nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eTA/ruWCUgwnz7vARSSAyGAv3Tz9MwTQ6Galh4vgX/g=;
        b=MQ3z45DbZJ2dHiJzVjEG47uX2hxMOAaza/zJCG7qR3VrHo4Ek5AN9KivsZqRr3dFCB
         IJAfgjwoPY8Uc9V9AGcj3301BHfSDvmGkx7ZATr/ANGRePc7GJH4o9GyFvrc6o3rn90r
         2NHmYuqU3W6PJVNUDbKMvgYxr/zqDphYS+RbrdjFMylvu+tnR+1S5WCYdRVGE0wrl0D3
         AQj8jjESoWh42CV/NZh0koxSn7E0O/jm3r1Swfqr+o1097DNE8/5+HOer+oaspVmM0fh
         b39eCXeP/nJTtLcnyGhzCmEvUlv2BEnKMivbUN69pZn9tD19OLHH3P+qPrtT9b00bOLO
         3O0A==
X-Gm-Message-State: AOAM531GntpYNaGTjUYW4FMyHXbiBMVjdcrKUGoBzjcHbLDiS2a9O826
        fEccAY5TtdTa/sApvHBp+6+3kA==
X-Google-Smtp-Source: ABdhPJxMyvdJDEXud0R+2Kv4hYjscqohz+0TwHZhv+B9DYYlregglmwZYrvHybI0elbJFi3Hfxo8dQ==
X-Received: by 2002:a17:90b:1105:: with SMTP id gi5mr23855730pjb.26.1615200327589;
        Mon, 08 Mar 2021 02:45:27 -0800 (PST)
Received: from localhost ([122.171.124.15])
        by smtp.gmail.com with ESMTPSA id e65sm7853652pfe.9.2021.03.08.02.45.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Mar 2021 02:45:27 -0800 (PST)
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
Subject: [PATCH V10 3/5] kbuild: Allow .dtso format for overlay source files
Date:   Mon,  8 Mar 2021 16:15:08 +0530
Message-Id: <83217a5e3c964da13d3e69e79d2a1c898d98f63e.1615199908.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.25.0.rc1.19.g042ed3e048af
In-Reply-To: <cover.1615199908.git.viresh.kumar@linaro.org>
References: <cover.1615199908.git.viresh.kumar@linaro.org>
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

