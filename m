Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 877D03FCE54
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 22:21:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241030AbhHaUWm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 16:22:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241022AbhHaUWh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 16:22:37 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03946C061575
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 13:21:42 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id y18so616530ioc.1
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 13:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VevGQRX0f3bv63YwX/k69vMS69ewVWDs8ONm/N/C1Sc=;
        b=ek59l99OmiR9mUyjr8y9DQsVkGNnyOQoNmw1dZOM5OLGCT34Lm+dE62PrdYIWHEOOn
         sa9Ws8jwtag4yzn6+GXh+06Y/lM3m8QVeuHlfJfGgn6LxBjNZ4Voe000VhSoVEaGcyrz
         zI+7Co2Ar/CE4IPj1Ztf3LLbI+mY9K/ky4cUMpI4dmNRxCNuf0bWYaaemPAzfWzKnDk0
         qDP+bXr5Edb+ywpLo8vajtXl0MhgKGI32zJQtlzsyV0fo+E6mVVlvsF2d4oSWAigCuxl
         YbzIwdImpGd0SVDH+/j4S8O8fjTiyyR/YP4LIrRSZptXQhZT2c514EVEf2TCbZp4EgM/
         XOEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VevGQRX0f3bv63YwX/k69vMS69ewVWDs8ONm/N/C1Sc=;
        b=Ej/DuoEHdJpH/6Lb5bJFV+QSMvTqsYvJGQSc/wJl7lVnX8dMWe7FYYspJcCCCYN39S
         6wnhc4KpaCwRDQcda0CY0glTYX5xNdAyxPA5QnJVIgF/1H4asVhqxDnSFJS/Olu/KWZi
         hSaVPTHa71V2SAcEQsuqc8JOKbgEFGSLlaBp6lgCSt7nKocwRYxeSB7WYn8UtlAxmFEn
         MKNnvW40TNm9ndNoAcfmxb6Hfr3flk7bNMsygW1iuDY3eswgoa6Qa7IATFTlnIYx8xO9
         skS7sC0R+khq5pE5dUeD7VUd90U442+D8oRJhf0K696rWtyggyvR76K5O92mreIaw7fc
         /A6A==
X-Gm-Message-State: AOAM533OE43caj9kBVyPBl0KbI8tj8L3M2t/Sww+QTArHdk76GlmGSeR
        a4eXPIvzE/sEm4O4ab+yfGk=
X-Google-Smtp-Source: ABdhPJyddbm54BnxLTe/23NlvxX+Frr1DcrqpFH5ZJpXq9sTh9bF2hJKZflGy0zBLD4MG7j58hGXzA==
X-Received: by 2002:a05:6638:4122:: with SMTP id ay34mr4436636jab.131.1630441301329;
        Tue, 31 Aug 2021 13:21:41 -0700 (PDT)
Received: from frodo.. (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id u15sm10597384ilk.53.2021.08.31.13.21.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Aug 2021 13:21:41 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org
Cc:     Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v7 2/8] dyndbg: remove spaces in pr_debug "gvt: core:" etc prefixes
Date:   Tue, 31 Aug 2021 14:21:27 -0600
Message-Id: <20210831202133.2165222-3-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210831202133.2165222-1-jim.cromie@gmail.com>
References: <20210831202133.2165222-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Taking embedded spaces out of existing prefixes makes them better
class-prefixes; simplifying the extra quoting needed otherwise:

  $> echo format "^gvt: core:" +p >control

Dropping the internal spaces means any trailing space in a query will
more clearly terminate the prefix being searched for.

Consider a generic drm-debug example:

  # turn off ATOMIC reports
  echo format "^drm:atomic: " -p > control

  # turn off all ATOMIC:* reports, including any sub-categories
  echo format "^drm:atomic:" -p > control

  # turn on ATOMIC:FAIL: reports
  echo format "^drm:atomic:fail: " +p > control

Removing embedded spaces in the class-prefixes simplifies the
corresponding match-prefix.  This means that "quoted" match-prefixes
are only needed when the trailing space is desired, in order to
exclude explicitly sub-categorized pr-debugs; in this example,
"drm:atomic:fail:".

RFC: maybe the prefix catenation should paste in the " " class-prefix
terminator explicitly.  A pr_debug_() flavor could exclude the " ",
allowing ad-hoc sub-categorization by appending for example, "fail:"
to "drm:atomic:" without the default " " insertion.

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

