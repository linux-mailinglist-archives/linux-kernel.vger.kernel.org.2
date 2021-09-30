Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0291A41D114
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 03:44:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347747AbhI3Bqf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 21:46:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347683AbhI3BqZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 21:46:25 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECB0AC06161C
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 18:44:43 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id k13so5038578ilo.7
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 18:44:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BS9AKALGwmUgSOoK9p/66v+O3ZFmjWbjDLsxZcHUoJA=;
        b=fU0NeOS1NtLCMt52jV0EfRi2a0pN/3WfUwz7w8A0SqcTCwLwwh8Jwbpwjjf+NDNY4p
         kc90+gpm54vP8jiU4K7PsrdYQ4G0EUCNI+KGkIN/4kKYldWSJNzOdJITQ2HKng9eTp9S
         cM9nHjEt0en9ngHFjAZ2ehpg59Oa9p625q2myEfYm1B+MrlP0gw8sSXlntTXcJwcJmWH
         XbHYv9C+WBT6409mZfvVM9+NfluAzV3gYi6BH1mxTPK8ZiToHAmERCdJlATjHAgHKsfb
         QAArWWJB3myyFhIGX3ZIwnsnJbdlz8Wme81eaPNgnuBt/zfiCaXhqngEnjiBD8reDxaw
         y0ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BS9AKALGwmUgSOoK9p/66v+O3ZFmjWbjDLsxZcHUoJA=;
        b=xRxxAqnoFhosFVIFZhkm1GN5NTx+PtVVMqIxDTkcvWBUVQY3Czz20Io5RuZYvSG02S
         0v6iuCCIc70ldllCD1pBWPvY0fjGUXNQRY0AznvT9XBiGbwxAngWTaMYn2tXwxKLHdw6
         6Wt0EKMQ2RfvJ0OYjqrZ/utel4LSOa4y5NGQVwQ/kv6VtP3S71Fv6Dqcz2cF4WryW8dD
         WAArwx1IAzML2N4FCiMvTMqproySeQrau8EloVSt/NW3TZK86uYrdaqUktoC4I4gvvDg
         /v5YdLLa0OhPj/ZmdrihWKkfq1S0n+EGP2pr9zxO67sxk63OgPZZ+uJpDo9LHS6FN2I2
         50WQ==
X-Gm-Message-State: AOAM531IzTW/wsxCnfLITRb/V7fazE+WcVU3NM3LHOwjUxA4MAsqo/Nm
        6rlGqg63Zqn4WiyBFayMR9opQIdNE6Y=
X-Google-Smtp-Source: ABdhPJwIMOyZMp7li4n1RDRWM997P9y9iKcB3MDGaziXeFE33j31hN+snrmkiubYIYsOPT7z5Ndr3g==
X-Received: by 2002:a05:6e02:1985:: with SMTP id g5mr2197498ilf.311.1632966283321;
        Wed, 29 Sep 2021 18:44:43 -0700 (PDT)
Received: from samwise.. (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id h23sm1155414ila.32.2021.09.29.18.44.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Sep 2021 18:44:42 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH 4/4] i915/gvt: remove spaces in pr_debug "gvt: core:" etc prefixes
Date:   Wed, 29 Sep 2021 19:44:27 -0600
Message-Id: <20210930014427.14239-5-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210930014427.14239-1-jim.cromie@gmail.com>
References: <20210930014427.14239-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Taking embedded spaces out of existing prefixes makes them better
class-prefixes; simplifying the extra quoting needed otherwise:

  $> echo format "^gvt: core:" +p >control
vs
  $> echo format ^gvt:core: +p >control

Dropping the internal spaces means that quotes are only needed when
the trailing space is required; they more distinctively signal that
requirement.

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

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
---
 drivers/gpu/drm/i915/gvt/debug.h | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/i915/gvt/debug.h b/drivers/gpu/drm/i915/gvt/debug.h
index c6027125c1ec..bbecc279e077 100644
--- a/drivers/gpu/drm/i915/gvt/debug.h
+++ b/drivers/gpu/drm/i915/gvt/debug.h
@@ -36,30 +36,30 @@ do {									\
 } while (0)
 
 #define gvt_dbg_core(fmt, args...) \
-	pr_debug("gvt: core: "fmt, ##args)
+	pr_debug("gvt:core: " fmt, ##args)
 
 #define gvt_dbg_irq(fmt, args...) \
-	pr_debug("gvt: irq: "fmt, ##args)
+	pr_debug("gvt:irq: " fmt, ##args)
 
 #define gvt_dbg_mm(fmt, args...) \
-	pr_debug("gvt: mm: "fmt, ##args)
+	pr_debug("gvt:mm: " fmt, ##args)
 
 #define gvt_dbg_mmio(fmt, args...) \
-	pr_debug("gvt: mmio: "fmt, ##args)
+	pr_debug("gvt:mmio: " fmt, ##args)
 
 #define gvt_dbg_dpy(fmt, args...) \
-	pr_debug("gvt: dpy: "fmt, ##args)
+	pr_debug("gvt:dpy: " fmt, ##args)
 
 #define gvt_dbg_el(fmt, args...) \
-	pr_debug("gvt: el: "fmt, ##args)
+	pr_debug("gvt:el: " fmt, ##args)
 
 #define gvt_dbg_sched(fmt, args...) \
-	pr_debug("gvt: sched: "fmt, ##args)
+	pr_debug("gvt:sched: " fmt, ##args)
 
 #define gvt_dbg_render(fmt, args...) \
-	pr_debug("gvt: render: "fmt, ##args)
+	pr_debug("gvt:render: " fmt, ##args)
 
 #define gvt_dbg_cmd(fmt, args...) \
-	pr_debug("gvt: cmd: "fmt, ##args)
+	pr_debug("gvt:cmd: " fmt, ##args)
 
 #endif
-- 
2.31.1

