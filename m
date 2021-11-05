Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15866446905
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 20:27:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233390AbhKET35 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 15:29:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233378AbhKET3w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 15:29:52 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9DA8C061208
        for <linux-kernel@vger.kernel.org>; Fri,  5 Nov 2021 12:27:12 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id f10so10526544ilu.5
        for <linux-kernel@vger.kernel.org>; Fri, 05 Nov 2021 12:27:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MVDfl7PAAJaLkVdQfsH1Ap16lLUYnqL6SHocbYPYy0A=;
        b=P4PDgIXDy4286cKlFS7SyepKpnasqA+6XUlqAZCAF0SjzORn1WkDLSj5vjE2mYXiMD
         QBIR3SJ3jdaqExl5Szgz/QLnVOWFDJBbkaJcWhpvrBLxzVtUGVBEUAZNK/cXCbEgV+QG
         Ndh8kPSGsqABfa06S74o1TVZlKeKJSXzaBxN9d6yaQCY3urSCMLahQx8SPysuZ1yhzWJ
         0vqD4nSwmcg/stsADf6rYjaSNp6EXmzREztg+Oey9rfv+phFKei+Kq12ISafniL1F5AJ
         WV8nD2raghQRNg4KAB3fQUpbf3iLOJ8IDoLR3UV+xp57H0B1ygxBRA3S4tvGrz89y5ln
         hnMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MVDfl7PAAJaLkVdQfsH1Ap16lLUYnqL6SHocbYPYy0A=;
        b=XBJhKb88AsW69NUh9PSL2j0oFPXsHO0/vhqA/+yLNuAjVmZVzGPNHSH+p8MBwOvYUX
         FO8BzMhPhui5KrHf9WOfTQvkqoYsXtDVBeQoakYrbxB4EqYRyNlpx6TuUVFRToKVSmoc
         5oq3VB5tPq6f3pCdEV+OYAfKj1kTPahMocCoRJDgj30x7ooYhrnFYRocYVKBhZDiGwg1
         IZQ3ZSrepTQIuigPEYBhy1RobZ8MML0WvYi+uy3nFrIbrUMN2OtKtTyuo1LUmt9FuFPJ
         /sPnQJLNFqfeQm0antQmDlKABloP2Vlzr0dpM0INAijsoCQXGAXadmhzvkHW4cHdLiSO
         MeUg==
X-Gm-Message-State: AOAM533c2N2ijB2fn3muIzpZCmZWWq1gMMTpGVFbOmFZDADxmO1Sh60v
        kbhCI5yUfGd2/ETPb0TYu/o=
X-Google-Smtp-Source: ABdhPJzWzpfFzFHWF95QeBDCRQ8M85chSNcMt3J4DRG1b6IWkDCApYyvwyTz23CkAfnwQWda+6b29g==
X-Received: by 2002:a92:db02:: with SMTP id b2mr9798908iln.95.1636140432365;
        Fri, 05 Nov 2021 12:27:12 -0700 (PDT)
Received: from samwise.. (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id l18sm4338617iob.17.2021.11.05.12.27.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Nov 2021 12:27:12 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, robdclark@gmail.com, sean@poorly.run,
        daniel.vetter@ffwll.ch, seanpaul@chromium.org, lyude@redhat.com,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org
Cc:     Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v10 05/10] i915/gvt: use dyndbg.BITGRPS for existing pr_debugs
Date:   Fri,  5 Nov 2021 13:26:32 -0600
Message-Id: <20211105192637.2370737-6-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211105192637.2370737-1-jim.cromie@gmail.com>
References: <20211105192637.2370737-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The gvt component of this driver has ~120 pr_debugs with formats using
one of 9 fixed string prefixes, which are quite similar to those
enumerated in DRM debug categories.  Following the interface model of
drm.debug, add a parameter to map bits to these format prefixes.

static struct dyndbg_bitdesc i915_bitmap[] = {
	[0] = { "gvt:cmd:" },
	[1] = { "gvt:core:" },
	[2] = { "gvt:dpy:" },
	[3] = { "gvt:el:" },
	[4] = { "gvt:irq:" },
	[5] = { "gvt:mm:" },
	[6] = { "gvt:mmio:" },
	[7] = { "gvt:render:" },
	[8] = { "gvt:sched:" }
};
DEFINE_DYNAMIC_DEBUG_BITGRPS(debug_gvt, __gvt_debug,
	"dyndbg bitmap desc",

If CONFIG_DYNAMIC_DEBUG_CORE=y, then gvt/Makefile adds
-DDYNAMIC_DEBUG_MODULE to cflags, which CONFIG_DYNAMIC_DEBUG=n
(CORE-only) builds need.  This is redone more comprehensively soon.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 drivers/gpu/drm/i915/Makefile    |  2 ++
 drivers/gpu/drm/i915/intel_gvt.c | 38 ++++++++++++++++++++++++++++++++
 2 files changed, 40 insertions(+)

diff --git a/drivers/gpu/drm/i915/Makefile b/drivers/gpu/drm/i915/Makefile
index 660bb03de6fc..0fa5f53312a8 100644
--- a/drivers/gpu/drm/i915/Makefile
+++ b/drivers/gpu/drm/i915/Makefile
@@ -317,6 +317,8 @@ i915-y += intel_gvt.o
 include $(src)/gvt/Makefile
 endif
 
+ccflags-$(CONFIG_DYNAMIC_DEBUG_CORE) += -DDYNAMIC_DEBUG_MODULE
+
 obj-$(CONFIG_DRM_I915) += i915.o
 obj-$(CONFIG_DRM_I915_GVT_KVMGT) += gvt/kvmgt.o
 
diff --git a/drivers/gpu/drm/i915/intel_gvt.c b/drivers/gpu/drm/i915/intel_gvt.c
index 4e70c1a9ef2e..efaac5777873 100644
--- a/drivers/gpu/drm/i915/intel_gvt.c
+++ b/drivers/gpu/drm/i915/intel_gvt.c
@@ -162,3 +162,41 @@ void intel_gvt_resume(struct drm_i915_private *dev_priv)
 	if (intel_gvt_active(dev_priv))
 		intel_gvt_pm_resume(dev_priv->gvt);
 }
+
+#if defined(CONFIG_DRM_USE_DYNAMIC_DEBUG)
+
+unsigned long __gvt_debug;
+EXPORT_SYMBOL(__gvt_debug);
+
+static struct dyndbg_bitdesc i915_dyndbg_bitmap[] = {
+	[0] = { "gvt:cmd:" },
+	[1] = { "gvt:core:" },
+	[2] = { "gvt:dpy:" },
+	[3] = { "gvt:el:" },
+	[4] = { "gvt:irq:" },
+	[5] = { "gvt:mm:" },
+	[6] = { "gvt:mmio:" },
+	[7] = { "gvt:render:" },
+	[8] = { "gvt:sched:" }
+};
+
+#define help_(_N, _cat)	"\t  Bit-" #_N ":\t" _cat "\n"
+
+#define I915_GVT_CATEGORIES(name) \
+	" Enable debug output via /sys/module/i915/parameters/" #name	\
+	", where each bit enables a debug category.\n"			\
+	help_(0, "gvt:cmd:")						\
+	help_(1, "gvt:core:")						\
+	help_(2, "gvt:dpy:")						\
+	help_(3, "gvt:el:")						\
+	help_(4, "gvt:irq:")						\
+	help_(5, "gvt:mm:")						\
+	help_(6, "gvt:mmio:")						\
+	help_(7, "gvt:render:")						\
+	help_(8, "gvt:sched:")
+
+DEFINE_DYNAMIC_DEBUG_BITGRPS(debug_gvt, __gvt_debug,
+			     I915_GVT_CATEGORIES(debug_gvt),
+			     i915_dyndbg_bitmap);
+
+#endif
-- 
2.31.1

