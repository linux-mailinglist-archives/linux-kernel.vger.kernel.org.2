Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4753E40CAB4
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 18:41:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231559AbhIOQmR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 12:42:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230023AbhIOQmB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 12:42:01 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65C64C061574
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 09:40:42 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id n128so4273447iod.5
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 09:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WWVzXcugFhShLI8+18wBUsvLbtXZHN1dHiomXl0q9m0=;
        b=h2nqqSiK05MaZPjZn0O9cW2a/DBKnxGpuJHqk1kgCRIu/6sePRxVEYYdS+iAt5RYmn
         tIxknQRSl7RgSl8FggO1GYcpt/ST0KUEtzZGc7/aOQ0ppv1AiHcURxJ6RoCpaexadWTw
         2L3Mw2saOEm92f2FT2If9VN80Xr0cqxXBqpONa6tFSlg9YAB97HV7u2/nczUftKCrkhK
         SNt3tJ+I2EwozPmBoclfxGrg2FhLPhrIvTP1y6fsqNLqOPnYdVyCNYe7MgaLNGes4T/Z
         eE5fq7ZAJdNXxAVxvcLwa1x2/X/IZBBuJgq7vkqE1FTmhKKFP2qsEvDXuVT0W5yid3fH
         aibg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WWVzXcugFhShLI8+18wBUsvLbtXZHN1dHiomXl0q9m0=;
        b=1ZmEKFm8RLX122TxiAC2x630bPCGfXLHsK4eTn4IHaw+C2UWRrFLkCkggjbHq+xpW6
         nPrRMBnKqyAEKFW09SliQeCQlzrJox/5qhLCHsmgFpbUJ6PH4VHO3eEGFWoElpntAU70
         G4VI5RBHR+ux7jvxv2bq5FfYmI3hnfOP4YLpMAG/KFPAPM+oggatfqP+2jBmjcX6x2NO
         y85jiZ2x391+qIDB0tdrsksKOq4MSb491LGxCnSXgnWMqj9bbFyFtTbn1bDTdHRxY19w
         7CgYE6mdqsS9iIWGvzyyjYMvJ4uBlPy2ARiytNEsLPEx+kS6WtICzaY9Gv9Rc9ovgirp
         DEvw==
X-Gm-Message-State: AOAM533OnY0Yr4asfO7xK9u38oc/oK4fsRVruCXsQG33AJutLpiU4KDl
        VpOsKLlxRcIkuMuOJpGwHgE=
X-Google-Smtp-Source: ABdhPJzobW5prgv7HuVZ/VMfpGur/vc5NbLATFSDX7do1XCkKAmSPcUYonOfjz2lqzGOwOC3BJNnyg==
X-Received: by 2002:a5d:8715:: with SMTP id u21mr796339iom.1.1631724041842;
        Wed, 15 Sep 2021 09:40:41 -0700 (PDT)
Received: from frodo.. (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id a5sm299540ilf.27.2021.09.15.09.40.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Sep 2021 09:40:41 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, daniel@ffwll.ch
Cc:     Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v8 10/16] i915/gvt: remove spaces in pr_debug "gvt: core:" etc prefixes
Date:   Wed, 15 Sep 2021 10:39:51 -0600
Message-Id: <20210915163957.2949166-11-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210915163957.2949166-1-jim.cromie@gmail.com>
References: <20210915163957.2949166-1-jim.cromie@gmail.com>
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
v8:
. fix patchwork CI warning
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

