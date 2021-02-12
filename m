Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D2F5319D43
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 12:22:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230100AbhBLLUe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 06:20:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230201AbhBLLTt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 06:19:49 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07870C0617AB
        for <linux-kernel@vger.kernel.org>; Fri, 12 Feb 2021 03:18:58 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id x136so5633150pfc.2
        for <linux-kernel@vger.kernel.org>; Fri, 12 Feb 2021 03:18:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wF13wHlH8AwN31lqAZwhyJR4x/IvJw4g38aibW4ph8w=;
        b=Amb+jKC7GS9/Nh89skSUnbGw/MjcxgSTvKj+QeSofjwQWAB72O+crjokGbjJKp4nzt
         0xo1aAAVZYXXctB3fqwFF4Z+IlaZ4SK61Cl9x07BQVVSGo/NPxaZ7/BKR45XDib8/37A
         2e/c4V+MhTJ+ag97f4Soca6W4JFcfW/3XOjB6SOty7Jpfp60Jn4MlHY3vqcvQ+cigg15
         WorvVsnqqfvh7bBwDIQW1p0K7nFd18ZnhXYr3/fhVNbztDxo5c2VALk8iwX2veHnUMDm
         aYY0dK6GJxq4oJv/hPQ6KOnCWKnlB6TvEjJlu8rmKTSzQwBFEEBhstacZA1Rn/z4LNiY
         XPKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wF13wHlH8AwN31lqAZwhyJR4x/IvJw4g38aibW4ph8w=;
        b=Qo/PJ//wEQlCXMWKoL4g1ag5o/Tbkg4rkfEMTvN+GJwLP5+ds3kI/39QtyXS0ES/It
         nu+6FPS2eVSw7rbRnpxZ0kMUO6nD/CUefPDGMhEZMAdcrzMAwBvPdILLwhqp2RD6hSWn
         cJD+HqEJ5J+VcmYA+pfHDJT4QCBLgZt3IexND+s1I6jZlzS/GHGpMhn9+NKEx7/LePDh
         333WQXW/npWhO6861FH9JPYnjQiCXEnxUi3rW6qJpZPEwNtatGHy6VhFsDS5a5FAvC6r
         PPvFsdDgNGx3QpxnQ+vNWZ1Xdp1+1ic2roF/n7zqdgOKI25L18GjSB4+UnAgG5cruOIY
         6/IA==
X-Gm-Message-State: AOAM531bhXMfGUE9zNx1u2qQSQJWxQMFdQRz9A0kCZIxQ2PPM53/yVJl
        QoTl69wZEwvSyBFg2nv080X6zw==
X-Google-Smtp-Source: ABdhPJwc3RACf1a60kDzhiAt8G6zfxfDX50y6YB81gE9Cr9NCRMlnocyE/BJ7az/AHL9e8GmoQCRtw==
X-Received: by 2002:a63:4f1f:: with SMTP id d31mr2802136pgb.104.1613128737563;
        Fri, 12 Feb 2021 03:18:57 -0800 (PST)
Received: from localhost ([122.172.59.240])
        by smtp.gmail.com with ESMTPSA id 74sm8836106pfw.53.2021.02.12.03.18.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Feb 2021 03:18:57 -0800 (PST)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Frank Rowand <frowand.list@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Masahiro Yamada <masahiroy@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        anmar.oueja@linaro.org, Bill Mills <bill.mills@linaro.org>,
        David Gibson <david@gibson.dropbear.id.au>,
        devicetree@vger.kernel.org, linux-kbuild@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Michal Simek <michal.simek@xilinx.com>
Subject: [PATCH V8 4/4] of: unittest: Statically apply overlays using fdtoverlay
Date:   Fri, 12 Feb 2021 16:48:38 +0530
Message-Id: <3fd43e11012d0c21606aef6d2af1e01a4efe274c.1613127681.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.25.0.rc1.19.g042ed3e048af
In-Reply-To: <cover.1613127681.git.viresh.kumar@linaro.org>
References: <cover.1613127681.git.viresh.kumar@linaro.org>
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
 drivers/of/unittest-data/Makefile          | 50 ++++++++++++++++++++++
 drivers/of/unittest-data/static_base_1.dts |  4 ++
 drivers/of/unittest-data/static_base_2.dts |  4 ++
 3 files changed, 58 insertions(+)
 create mode 100644 drivers/of/unittest-data/static_base_1.dts
 create mode 100644 drivers/of/unittest-data/static_base_2.dts

diff --git a/drivers/of/unittest-data/Makefile b/drivers/of/unittest-data/Makefile
index 009f4045c8e4..f88b2f48f172 100644
--- a/drivers/of/unittest-data/Makefile
+++ b/drivers/of/unittest-data/Makefile
@@ -34,7 +34,57 @@ DTC_FLAGS_overlay += -@
 DTC_FLAGS_overlay_bad_phandle += -@
 DTC_FLAGS_overlay_bad_symbol += -@
 DTC_FLAGS_overlay_base += -@
+DTC_FLAGS_static_base_1 += -@
+DTC_FLAGS_static_base_2 += -@
 DTC_FLAGS_testcases += -@
 
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

