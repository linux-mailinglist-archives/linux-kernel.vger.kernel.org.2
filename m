Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F5483EB935
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Aug 2021 17:27:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243032AbhHMPZC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Aug 2021 11:25:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243586AbhHMPYa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Aug 2021 11:24:30 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A63F8C061149
        for <linux-kernel@vger.kernel.org>; Fri, 13 Aug 2021 08:19:28 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id b7so4686036iob.4
        for <linux-kernel@vger.kernel.org>; Fri, 13 Aug 2021 08:19:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=V5vqhjeJwhM7E6Pt089X9QON5NrjkvFV308x6a56U3o=;
        b=LZ3AdMIXcu2n0pYTkkI/+pU36yI/lhsT0TyHbsxCyXCSaMdoqclAGgPt2iibcVEGrp
         D+J/gZiijusoQpBycq24BNPOLXXHU3YjbQ3HyJbVms4DuEXsFiGZrmnbaNmNHiqiy67X
         FJT7Y4WNF+GW9DP7eMxc0QxuJxbI5AFcSGCd3umuI9KAInUBkK/oV9rAuZt6MetbIWPi
         6ocQw22suiG8DUF3MNRgACSisMxUbEWS54XZCY5ZWzutC/8ZHTtd9xu/DAfttGqM9mGz
         EU3I6KV8S9s43spU5E5XG9Ft2UM9MR0OAQOxAUdXaeW8f4nMTwz/bbd4IubAbe5q+us7
         Rvew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=V5vqhjeJwhM7E6Pt089X9QON5NrjkvFV308x6a56U3o=;
        b=TzmniVp72o7jVmSkNUKG/necZKC5k9hEJFm3eDPHCuJnMaL0wPfYHuxQNCpg6TuCsq
         zkvyfcwqYbV95K+G8spHl/5BeF6vJeZmAPY5KjhFN3dIuyESUDW9ju19GS+zCMSnLtgD
         aExTwAEjWh8QOaAWJlFSbRz1j5xu5vUaktynzlV8C6wnkQVDk3ls8ILSx7tfcpPFdxgR
         jb5r00WdOEawpSL6prnRp37no8BsLd/wI+jzPjYsWAqRhHz8SzIkM+s7gGCAKBV+xj7G
         tEcOpfZw8vvLlyMp5D4Hv1X/h+vOaVlcFsC/MXZDUiW+/VObJrVL6iNSLP3aDIOnWPwj
         IjAA==
X-Gm-Message-State: AOAM533SOpx3u3ZVG7d9pTZHF5D5WJt0SOQHKa8Bt/RM38iJP236ygfk
        5q7N/IByCn+Bego+TGbEBC4=
X-Google-Smtp-Source: ABdhPJwSTdHRHZHLxUs9itY+cqohY+ssvDkK5TJigFWw1egZ0dHN8cBWgBGhuYjFhn5tx2SlLYEWtA==
X-Received: by 2002:a05:6638:618:: with SMTP id g24mr2839556jar.94.1628867967978;
        Fri, 13 Aug 2021 08:19:27 -0700 (PDT)
Received: from frodo.. (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id d4sm921145ilo.29.2021.08.13.08.19.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Aug 2021 08:19:27 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     gregkh@linuxfoundation.org, seanpaul@chromium.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>,
        Zhi Wang <zhi.a.wang@intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Jason Baron <jbaron@akamai.com>,
        Hawking Zhang <Hawking.Zhang@amd.com>,
        Tao Zhou <tao.zhou1@amd.com>, Huang Rui <ray.huang@amd.com>,
        Chengming Gui <Jack.Gui@amd.com>,
        Likun Gao <Likun.Gao@amd.com>, Dennis Li <Dennis.Li@amd.com>,
        Jim Cromie <jim.cromie@gmail.com>,
        John Clements <john.clements@amd.com>,
        Kevin Wang <kevin1.wang@amd.com>,
        Ashley Thomas <Ashley.Thomas2@amd.com>,
        Qingqing Zhuo <qingqing.zhuo@amd.com>,
        Wyatt Wood <Wyatt.Wood@amd.com>,
        Aurabindo Pillai <aurabindo.pillai@amd.com>,
        Johan Hovold <johan@kernel.org>, Jessica Yu <jeyu@kernel.org>,
        Miguel Ojeda <ojeda@kernel.org>, Joe Perches <joe@perches.com>,
        Nick Desaulniers <ndesaulniers@gooogle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vitor Massaru Iha <vitor@massaru.org>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Julian Braha <julianbraha@gmail.com>,
        Marco Elver <elver@google.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Patricia Alfonso <trishalfonso@google.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Arnd Bergmann <arnd@arndb.de>, Jiri Olsa <jolsa@kernel.org>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org
Subject: [PATCH v5 4/9] i915/gvt: remove spaces in pr_debug "gvt: core:" etc prefixes
Date:   Fri, 13 Aug 2021 09:17:12 -0600
Message-Id: <20210813151734.1236324-5-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210813151734.1236324-1-jim.cromie@gmail.com>
References: <20210813151734.1236324-1-jim.cromie@gmail.com>
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

