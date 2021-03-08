Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8698330BA4
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 11:46:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231643AbhCHKqG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 05:46:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231638AbhCHKpf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 05:45:35 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A70F6C06174A
        for <linux-kernel@vger.kernel.org>; Mon,  8 Mar 2021 02:45:34 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id b15so2794816pjb.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Mar 2021 02:45:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=K1QgQjNHtN761sdXJlMXANZwX7Jh8JMy1gwv4GNPG4g=;
        b=LqDwByIeuwQYzR2bhJQ2URfoiZZf6kiHEGdH6iisqNOeBLthDw3rATLZ3IWNMdwjw+
         mDMf2ot0HywnTy+ZFgDwSe0LNDlMgz60w+o1O7HrMZNN2G7FoCLfZg+pHBS960nxMZJy
         uAVZssBZ6lhXevjFVP4dW4k0FfteIvSYnGRYFOcvUtb7Y8Pwc70ms6j5RWtegvnsTEtu
         ybGIuiTjgh8oZ6BFLSVRitpg+oQNuE3Gy7pHg/9441jkcmepiin2sBYNIM7m1oEml+WP
         E/TyBgOGBFhO5piDxzz5y9rjGmBlFt7Gpr5DAa/+tivZmoAR3FDDUgKOg9I0VXRs/SsE
         HMjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=K1QgQjNHtN761sdXJlMXANZwX7Jh8JMy1gwv4GNPG4g=;
        b=GFORU/9bQU1bln2kwGUTkDtcVIU5cqAdVqioa9th/J9VTOnoDPRE59S8zLiShgyP5E
         xr1+cy818R7/uYxnmLaEYnQdh9kJj+PVDFJTp3ycUOEB181l22ORkcz4Q1DSwHUawV0X
         QX8/3nx8ZWJcHgYlM5OuJwWYu3VchR0YXMSMY5aMGNztvYWanZPmrKMEKKvYNp7anH5i
         8BgyRvXRtCC3Y3obSfZmzHHJMaDCWpNaiYrrj7792RA2++5Yk7DdrBJ9Gve3kcrSP2M9
         i06DIHhgyEUFkBS9nAZjgFmjka4ihk5+8AGQcaCTdXcsSTQs1fFtxChMKfGlngHgjO9e
         54sg==
X-Gm-Message-State: AOAM533P8sFim56yWT3WXfWn3DywMtkrfS8bKdbaGszClsxQ3VR7d01i
        WQMDDJPNwq8GJsuDsFWrRRLAnQ==
X-Google-Smtp-Source: ABdhPJz1crqSMNF+5kJLPLKuP68mXmE6MVedKm/BZ/DlWc5ugAbMIRuCYGemGA6xJFkolN6dQDgVCA==
X-Received: by 2002:a17:90a:5510:: with SMTP id b16mr24325005pji.87.1615200334259;
        Mon, 08 Mar 2021 02:45:34 -0800 (PST)
Received: from localhost ([122.171.124.15])
        by smtp.gmail.com with ESMTPSA id x190sm10045278pfx.60.2021.03.08.02.45.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Mar 2021 02:45:33 -0800 (PST)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        David Gibson <david@gibson.dropbear.id.au>,
        Michal Simek <michal.simek@xilinx.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        anmar.oueja@linaro.org, Bill Mills <bill.mills@linaro.org>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH V10 5/5] of: unittest: Statically apply overlays using fdtoverlay
Date:   Mon,  8 Mar 2021 16:15:10 +0530
Message-Id: <72cb0c45cb61e0fa739249dbc0aacb1c97d1a8e8.1615199908.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.25.0.rc1.19.g042ed3e048af
In-Reply-To: <cover.1615199908.git.viresh.kumar@linaro.org>
References: <cover.1615199908.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that fdtoverlay is part of the kernel build, start using it to test
the unitest overlays we have by applying them statically. Create two new
base files static_base_1.dts and static_base_2.dts which includes other
.dtsi files.

Some unittest overlays deliberately contain errors that unittest checks
for. These overlays will cause fdtoverlay to fail, and are thus not
included for static builds.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/of/unittest-data/Makefile          | 48 ++++++++++++++++++++++
 drivers/of/unittest-data/static_base_1.dts |  4 ++
 drivers/of/unittest-data/static_base_2.dts |  4 ++
 3 files changed, 56 insertions(+)
 create mode 100644 drivers/of/unittest-data/static_base_1.dts
 create mode 100644 drivers/of/unittest-data/static_base_2.dts

diff --git a/drivers/of/unittest-data/Makefile b/drivers/of/unittest-data/Makefile
index 009f4045c8e4..a5d2d9254b2c 100644
--- a/drivers/of/unittest-data/Makefile
+++ b/drivers/of/unittest-data/Makefile
@@ -38,3 +38,51 @@ DTC_FLAGS_testcases += -@
 
 # suppress warnings about intentional errors
 DTC_FLAGS_testcases += -Wno-interrupts_property
+
+# Apply overlays statically with fdtoverlay.  This is a build time test that
+# the overlays can be applied successfully by fdtoverlay.  This does not
+# guarantee that the overlays can be applied successfully at run time by
+# unittest, but it provides a bit of build time test coverage for those
+# who do not execute unittest.
+#
+# The overlays are applied on top of static_base_1.dtb and static_base_2.dtb to
+# create static_test_1.dtb and static_test_2.dtb.  If fdtoverlay detects an
+# error than the kernel build will fail.  static_test_1.dtb and
+# static_test_2.dtb are not consumed by unittest.
+#
+# Some unittest overlays deliberately contain errors that unittest checks for.
+# These overlays will cause fdtoverlay to fail, and are thus not included
+# in the static test:
+#			  overlay_bad_add_dup_node.dtbo \
+#			  overlay_bad_add_dup_prop.dtbo \
+#			  overlay_bad_phandle.dtbo \
+#			  overlay_bad_symbol.dtbo \
+
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
+
+apply_static_overlay_2 := overlay.dtbo
+
+static_test_1-dtbs := static_base_1.dtb $(apply_static_overlay_1)
+static_test_2-dtbs := static_base_2.dtb $(apply_static_overlay_2)
+
+dtb-$(CONFIG_OF_OVERLAY) += static_test_1.dtb static_test_2.dtb
diff --git a/drivers/of/unittest-data/static_base_1.dts b/drivers/of/unittest-data/static_base_1.dts
new file mode 100644
index 000000000000..10556cb3f01f
--- /dev/null
+++ b/drivers/of/unittest-data/static_base_1.dts
@@ -0,0 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
+/dts-v1/;
+
+#include "testcases_common.dtsi"
diff --git a/drivers/of/unittest-data/static_base_2.dts b/drivers/of/unittest-data/static_base_2.dts
new file mode 100644
index 000000000000..b0ea9504d6f3
--- /dev/null
+++ b/drivers/of/unittest-data/static_base_2.dts
@@ -0,0 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
+/dts-v1/;
+
+#include "overlay_common.dtsi"
-- 
2.25.0.rc1.19.g042ed3e048af

