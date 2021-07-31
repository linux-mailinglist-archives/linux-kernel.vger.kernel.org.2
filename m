Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96AE83DC864
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Jul 2021 23:42:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231924AbhGaVmx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Jul 2021 17:42:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231462AbhGaVmw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Jul 2021 17:42:52 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD0E0C06175F
        for <linux-kernel@vger.kernel.org>; Sat, 31 Jul 2021 14:42:45 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id d10so13016480ils.7
        for <linux-kernel@vger.kernel.org>; Sat, 31 Jul 2021 14:42:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=xPck7MMABBW1WtH6n+xcidO56Avpeo49SggTpQTKxus=;
        b=AexSXd2PXlmD2Clg3eVEPdYp3vl1NLUrBzV3KgrgcMfxWzO8W6+/+i8hXtB8HqNeqm
         zuCPHcu8pvMJiXxE28nu7X9mNIjYr57YpVy1sOWu+vv3JrksNi9rDQCl5io2q2T/D31A
         ui/8qTw3jHS3AVmBdWb2syc1XgPVeNWZ908NJHyYJJO/uyAp3PObAKpSaTCLBGnbMNEe
         SVJYa0kvCwwUvJ5dJtxSLgCcuM60bLkTaiV57aDet/X8y6JZ9CKzWUfS+qMaKq/B8GO7
         j91IfyIDkHrfdsSEOT+BSSJ/Y2d21wWsMlRWnoUMMoY1w/6fGTcKr4uc8cArAkDKWV3E
         y/ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xPck7MMABBW1WtH6n+xcidO56Avpeo49SggTpQTKxus=;
        b=QhlUGBP37YYjs0ldv3nUG+tliRTOpvVrsL0QWmfwtmQWGvtszDASgHtjuYqmehHpi0
         RZTml9MR3O0590Fv2pEqXEBTbfYnfPZZKWC2XX28delxT0T0rkoJMajA5RR4t954dyOZ
         wUTm1tyaPHi70zxZdCZq639HToqyZVg+mBSC49NUCTSqNQz4V5SOaHist5e9fGeaemxn
         hS7RAluLx8obn3AqcZ1xckrgOoA0BgM7MzRmGIGrogiSCLpMqVBYq/Rx81jtvoOCUtim
         6Y8/9J0m3OtDgvMGBfoh/0TOlmhm0LMsyBJZR2rmf3v3Ix++lMpsAiF3Qi2gNza6XJpt
         NnxQ==
X-Gm-Message-State: AOAM532t1FGs5/35Sf61MvJztfFir5hz3NeH9F6rUo6WEpT1TioOn0RO
        nIk15H6aKSeqB+yeqTsO6AA=
X-Google-Smtp-Source: ABdhPJwQjrRtHttvc3vCaTEHaO1jjg2Zrk/t8zWB73N8dPAu1dBcfj2fmbzg3rQBcmT5QP+vbvn2zg==
X-Received: by 2002:a92:7b13:: with SMTP id w19mr2318517ilc.291.1627767765231;
        Sat, 31 Jul 2021 14:42:45 -0700 (PDT)
Received: from frodo.. (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id q10sm3721040ion.3.2021.07.31.14.42.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Jul 2021 14:42:44 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>,
        Zhi Wang <zhi.a.wang@intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Jason Baron <jbaron@akamai.com>,
        Ashley Thomas <Ashley.Thomas2@amd.com>,
        Aurabindo Pillai <aurabindo.pillai@amd.com>,
        Wyatt Wood <Wyatt.Wood@amd.com>,
        Qingqing Zhuo <qingqing.zhuo@amd.com>,
        Jim Cromie <jim.cromie@gmail.com>,
        Jessica Yu <jeyu@kernel.org>, Johan Hovold <johan@kernel.org>,
        Miguel Ojeda <ojeda@kernel.org>, Joe Perches <joe@perches.com>,
        Nick Desaulniers <ndesaulniers@gooogle.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        amd-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org
Subject: [PATCH v4 4/7] i915/gvt: remove spaces in pr_debug "gvt: core:" etc prefixes
Date:   Sat, 31 Jul 2021 15:42:01 -0600
Message-Id: <20210731214211.657280-5-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210731214211.657280-1-jim.cromie@gmail.com>
References: <20210731214211.657280-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Collapsing "gvt: core: " to "gvt:core: " is a better class-prefix;
dropping the internal spaces means a trailing space in a query will
more clearly terminate the prefix.

Consider a generic drm-debug example:

  # turn off most ATOMIC reports
  echo format "^drm:atomic: " -p > control

  # turn off all ATOMIC:* reports
  echo format "^drm:atomic:" -p > control

  # turn on ATOMIC:FAIL reports
  echo format "^drm:atomic:fail: " +p > control

Removing embedded spaces in the class-prefixes simplifies the
corresponding match-prefix.  This means that "quoted" match-prefixes
are only needed when the trailing space is desired, in order to
exclude explicitly sub-categorized pr-debugs; in this example,
"drm:atomic:fail:".

RFC: maybe the prefix catenation should paste in the " " class-prefix
terminator explicitly.  A pr_debug_() flavor could exclude the " ",
allowing ad-hoc sub-categorization by appending for example, "fail:"
to "drm:atomic:".

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 drivers/gpu/drm/i915/gvt/debug.h | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/i915/gvt/debug.h b/drivers/gpu/drm/i915/gvt/debug.h
index c6027125c1ec..b4021f41c546 100644
--- a/drivers/gpu/drm/i915/gvt/debug.h
+++ b/drivers/gpu/drm/i915/gvt/debug.h
@@ -36,30 +36,30 @@ do {									\
 } while (0)
 
 #define gvt_dbg_core(fmt, args...) \
-	pr_debug("gvt: core: "fmt, ##args)
+	pr_debug("gvt:core: "fmt, ##args)
 
 #define gvt_dbg_irq(fmt, args...) \
-	pr_debug("gvt: irq: "fmt, ##args)
+	pr_debug("gvt:irq: "fmt, ##args)
 
 #define gvt_dbg_mm(fmt, args...) \
-	pr_debug("gvt: mm: "fmt, ##args)
+	pr_debug("gvt:mm: "fmt, ##args)
 
 #define gvt_dbg_mmio(fmt, args...) \
-	pr_debug("gvt: mmio: "fmt, ##args)
+	pr_debug("gvt:mmio: "fmt, ##args)
 
 #define gvt_dbg_dpy(fmt, args...) \
-	pr_debug("gvt: dpy: "fmt, ##args)
+	pr_debug("gvt:dpy: "fmt, ##args)
 
 #define gvt_dbg_el(fmt, args...) \
-	pr_debug("gvt: el: "fmt, ##args)
+	pr_debug("gvt:el: "fmt, ##args)
 
 #define gvt_dbg_sched(fmt, args...) \
-	pr_debug("gvt: sched: "fmt, ##args)
+	pr_debug("gvt:sched: "fmt, ##args)
 
 #define gvt_dbg_render(fmt, args...) \
-	pr_debug("gvt: render: "fmt, ##args)
+	pr_debug("gvt:render: "fmt, ##args)
 
 #define gvt_dbg_cmd(fmt, args...) \
-	pr_debug("gvt: cmd: "fmt, ##args)
+	pr_debug("gvt:cmd: "fmt, ##args)
 
 #endif
-- 
2.31.1

