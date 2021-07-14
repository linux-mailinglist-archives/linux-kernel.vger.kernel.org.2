Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5E3D3C8A33
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 19:52:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239983AbhGNRyw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 13:54:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239976AbhGNRyt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 13:54:49 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D709C06175F
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 10:51:57 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id l5so3191407iok.7
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 10:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UAZMoNAstweZZnA132MMNPq1dFVLu1OA1+DnVQ2gXAM=;
        b=MSDxBLV8UXb5V2oSAeCmJG2CpTEtuTNDW74UMTo+lVPAzUnJT4DVUD+Xi1JZ3qbFjR
         PjGGXxbSMkU9NYD3ltXZ4JWCYHPtPmtyr0J44nrDaYfTJ4bvOTako6KrYIbeFoP2Ldlw
         Xyahrq50rXDXGQXNSDBHTZc27vPRsIAXww9O8MsPJ8f+waDCqJG/SOfgp/L5PeTpb5zH
         yDwyMEVwJ8XnerempvGOW8EN1R3uKYt01mmL0j8yqAoKedJ5j/Yjdfuq8jjKHP72A0Uh
         mU0QgHWHPLemw6qnjGNtt0jwXl3714e5b/vn1//nB7F39BSCQr7tpVQbHI7SCG3/+0bT
         93ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UAZMoNAstweZZnA132MMNPq1dFVLu1OA1+DnVQ2gXAM=;
        b=HDSo+1+LLGATbV1+yXLLP0QW7qTGIG2WIutquhyL8GFULqPjR94kxnNA2XO38mk3F8
         3x6AEOS49QKfJKu84VmwIAyvZ1LEjRBrcYqe93nMy0mnZYFkN2D2pcs3TbbCEPfzWR3M
         MWWhTpQGUriibYhwPVLK4cmssG2WCbF1YerbErJQUV/EBgAsMWNBvabZSnY2/4NgoX/9
         ewq48TBp5j6MelC74WdSI0BKuF5wD8X8a4LQBo81bk8qSbkduldScpktdfJv90q+Km42
         jMZyLVhlck9DlWjp6atTLRUymG2VKhFp2Udos5fqUhlydoQ/TJAf4yYGohqd/YispORw
         BqDg==
X-Gm-Message-State: AOAM533BtWBXXL5ROetE7DOoJZyiIkXvSZY6apUH5Z/6nt0R7tstAmSg
        RxfFYZJ7K6IqFQo6xjoSnUhX+VSSVuZPKB44
X-Google-Smtp-Source: ABdhPJzaK5PA6YU9fYYPYTpCyvYrvX5Qk0P5iYQ+Mr2cuHq4ZfRdVXukYs7pwr81h4Mk7j7p7QrppA==
X-Received: by 2002:a5e:9e4a:: with SMTP id j10mr7836529ioq.29.1626285117014;
        Wed, 14 Jul 2021 10:51:57 -0700 (PDT)
Received: from frodo.. (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id b16sm706518ioh.5.2021.07.14.10.51.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 10:51:56 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Zhenyu Wang <zhenyuw@linux.intel.com>,
        Zhi Wang <zhi.a.wang@intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org
Cc:     jbaron@akamai.com, Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v3 5/5] i915: map gvt pr_debug categories to bits in parameters/debug_gvt
Date:   Wed, 14 Jul 2021 11:51:38 -0600
Message-Id: <20210714175138.319514-6-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210714175138.319514-1-jim.cromie@gmail.com>
References: <20210714175138.319514-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The gvt component of this driver has ~120 pr_debugs, in 9 "classes".
Following the interface model of drm.debug, add a parameter to map
bits to these classes.

If CONFIG_DRM_USE_DYNAMIC_DEBUG=y (and CONFIG_DYNAMIC_DEBUG_CORE), add
-DDYNAMIC_DEBUG_MODULE into Makefile.  TBD: maybe add a separate
CONFIG_I915_USE_DYNAMIC_DEBUG to more fully optionalize this.

In i915_params.c, add callback to map bits to queries.

TBD: the callback code should probably be moved to lib/dynamic_debug,
and given a declarative interface, with implied bit-numbering,
something like:

MOD_PARM_BITMAP_DESC(__gvt_debug,
	"gvt: cmd: ",  "command processing"
	"gvt: core: ", "core help",
	"gvt: dpy: ",  "display help",
	"gvt: el: ",   "help",
	"gvt: irq: ",  "help",
	"gvt: mm: ",   "help",
	"gvt: mmio: ", "help",
	"gvt: render: ", "help",
	"gvt: sched: " "help");

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 drivers/gpu/drm/i915/gvt/Makefile  |  4 ++
 drivers/gpu/drm/i915/i915_params.c | 76 ++++++++++++++++++++++++++++++
 2 files changed, 80 insertions(+)

diff --git a/drivers/gpu/drm/i915/gvt/Makefile b/drivers/gpu/drm/i915/gvt/Makefile
index ea8324abc784..846ba73b8de6 100644
--- a/drivers/gpu/drm/i915/gvt/Makefile
+++ b/drivers/gpu/drm/i915/gvt/Makefile
@@ -7,3 +7,7 @@ GVT_SOURCE := gvt.o aperture_gm.o handlers.o vgpu.o trace_points.o firmware.o \
 
 ccflags-y				+= -I $(srctree)/$(src) -I $(srctree)/$(src)/$(GVT_DIR)/
 i915-y					+= $(addprefix $(GVT_DIR)/, $(GVT_SOURCE))
+
+#ifdef CONFIG_DRM_USE_DYNAMIC_DEBUG
+ccflags-y	+= -DDYNAMIC_DEBUG_MODULE
+#endif
diff --git a/drivers/gpu/drm/i915/i915_params.c b/drivers/gpu/drm/i915/i915_params.c
index e07f4cfea63a..e0d13aff5274 100644
--- a/drivers/gpu/drm/i915/i915_params.c
+++ b/drivers/gpu/drm/i915/i915_params.c
@@ -265,3 +265,79 @@ void i915_params_free(struct i915_params *params)
 	I915_PARAMS_FOR_EACH(FREE);
 #undef FREE
 }
+
+/* POC for callback -> dynamic_debug_exec_queries */
+unsigned long __gvt_debug;
+EXPORT_SYMBOL(__gvt_debug);
+
+static char *format_prefix_classes[] = {
+	"gvt: cmd: ",
+	"gvt: core: ",
+	"gvt: dpy: ",
+	"gvt: el: ",
+	"gvt: irq: ",
+	"gvt: mm: ",
+	"gvt: mmio: ",
+	"gvt: render: ",
+	"gvt: sched: "
+};
+#define NUM_CLASSES	ARRAY_SIZE(format_prefix_classes)
+#define OUR_QUERY_SIZE	128 /* we need about 20 */
+
+#include <linux/module.h>
+
+static int param_set_dyndbg(const char *instr, const struct kernel_param *kp)
+{
+	unsigned int val;
+	unsigned long changes, result;
+	int rc, chgct = 0, totct = 0, bitpos;
+	char query[OUR_QUERY_SIZE];
+
+	rc = kstrtouint(instr, 0, &val);
+	if (rc) {
+		pr_err("set_dyndbg: failed\n");
+		return -EINVAL;
+	}
+	result = val;
+	pr_info("set_dyndbg: result:0x%lx from %s\n", result, instr);
+
+	changes = result ^ __gvt_debug;
+
+	for_each_set_bit(bitpos, &changes, NUM_CLASSES) {
+
+		sprintf(query, "format '^%s' %cp", format_prefix_classes[bitpos],
+			test_bit(bitpos, &result) ? '+' : '-');
+
+		chgct = dynamic_debug_exec_queries(query, "i915");
+
+		pr_info("%d changes on: %s\n", chgct, query);
+		totct += chgct;
+	}
+	pr_info("total changes: %d\n", totct);
+	__gvt_debug = result;
+	return 0;
+}
+static int param_get_dyndbg(char *buffer, const struct kernel_param *kp)
+{
+	return scnprintf(buffer, PAGE_SIZE, "%u\n",
+			 *((unsigned int *)kp->arg));
+}
+static const struct kernel_param_ops param_ops_dyndbg = {
+	.set = param_set_dyndbg,
+	.get = param_get_dyndbg,
+};
+
+#define info_ln(hexi, prefix) "\n\t0x" __stringify(hexi) "\t" prefix
+
+MODULE_PARM_DESC(debug_gvt, " gvt debug categories:"
+		 info_ln(1, "gvt: cmd:")
+		 info_ln(2, "gvt: core:")
+		 info_ln(4, "gvt: dpy:")
+		 info_ln(8, "gvt: el:")
+		 info_ln(10, "gvt: irq:")
+		 info_ln(20, "gvt: mm:")
+		 info_ln(40, "gvt: mmio:")
+		 info_ln(80, "gvt: render:")
+		 info_ln(100, "gvt: sched:"));
+
+module_param_cb(debug_gvt, &param_ops_dyndbg, &__gvt_debug, 0644);
-- 
2.31.1

