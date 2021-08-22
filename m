Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44FCF3F41F8
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 00:21:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233977AbhHVWVf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Aug 2021 18:21:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229700AbhHVWVb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Aug 2021 18:21:31 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78F08C061575
        for <linux-kernel@vger.kernel.org>; Sun, 22 Aug 2021 15:20:50 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id x9-20020a056830278900b0051b8be1192fso10541153otu.7
        for <linux-kernel@vger.kernel.org>; Sun, 22 Aug 2021 15:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=V5vqhjeJwhM7E6Pt089X9QON5NrjkvFV308x6a56U3o=;
        b=TQ7xu2IpCflARc8FKk474nyH5tm12zi4tObsZCwfPlOFFS/LnC6EZsd4Q7FlNVTOLf
         zCj+kX2dOXM8dNEhSu9VMaxvyigkwfLB7U6TquFc/fMx8AKjHg5MsrugWDPWsvS+sIHg
         8+Iu3rRzOUAaybZi3h95K+QtyfNAUNZ3zvHefmjva3DaJuhnSQEWm9lKs+dV/72tmPf/
         nOaa0nUCC0nbDuFE9W5aFz2R/RAWfnHzl52cV46KL1yG6uCd6MtBiIudESWB0TPTLid+
         4tLlcJMKwSRciEg1Odw8RHrAkCfM7ZUXOuuDEUNwOTP4HB/Md/aqSIAnJ06xnFlODgKn
         J55A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=V5vqhjeJwhM7E6Pt089X9QON5NrjkvFV308x6a56U3o=;
        b=ONlVGG70adO/aLvJUmQKfFqF/9f9YsG8zx7h6HS/3EzQc6y2Q3HuDU12goUMrcCvtE
         MsAKJZJw5YvPbtDAZOOkLQBiyG36XJnH3cp+EnZTVQwwXzkoQrema3peWKssW6FDfkok
         SW8Hu+1q9s1uG+G07RHAPLR/jLLWzhG3azE0EPYYYZWAYbSA2BrufcJGolu5wLS+uufm
         JMxa9+ysZCB2GC1I5rkARekR9xiMrnh4CF4WyjAU5iwAsi7A1vnhxaGhY/HqOZemuG6h
         nT3crUdWi7FIhul3E/W0dvpEhCDiAtO/xaLG0UhkCTuFNtqff44ZU/wwMefeP11FQ2Ar
         4N4Q==
X-Gm-Message-State: AOAM532UQ3Rn58rnk6x+s3MmRbvNJFxobdbuKvGQraTRLnfzurpJ6fxu
        p1AkEDvasRodlThmGciiE9M=
X-Google-Smtp-Source: ABdhPJwOuCAjc2+TBpcJ9GNUOPER2Y36eRiOD00lA2cNZH9TVsLUwf3djGHOtmZlh5lnw24liyxq6w==
X-Received: by 2002:aca:c6ce:: with SMTP id w197mr9883707oif.6.1629670849838;
        Sun, 22 Aug 2021 15:20:49 -0700 (PDT)
Received: from frodo.. (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id x198sm2964122ooa.43.2021.08.22.15.20.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Aug 2021 15:20:49 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, gregkh@linuxfoundation.org,
        seanpaul@chromium.org, jeyu@kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org
Cc:     Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v6 03/11] i915/gvt: remove spaces in pr_debug "gvt: core:" etc prefixes
Date:   Sun, 22 Aug 2021 16:20:01 -0600
Message-Id: <20210822222009.2035788-4-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210822222009.2035788-1-jim.cromie@gmail.com>
References: <20210822222009.2035788-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Taking embedded spaces out of existing prefixes makes them better
class-prefixes; simplifying the nested quoting needed otherwise:

  $> echo "format '^gvt: core:' +p" >control

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

