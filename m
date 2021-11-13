Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E7A444F301
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Nov 2021 13:07:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235888AbhKMMJu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Nov 2021 07:09:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235871AbhKMMJr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Nov 2021 07:09:47 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9622BC061766
        for <linux-kernel@vger.kernel.org>; Sat, 13 Nov 2021 04:06:55 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id j5-20020a17090a318500b001a6c749e697so7843716pjb.1
        for <linux-kernel@vger.kernel.org>; Sat, 13 Nov 2021 04:06:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rZbWc+NBiqSw8v3aKVJp/xYRUOsEXgP44aztd2XHhEo=;
        b=VUemUQlPTiPZDvEu4XK7VjRNrQPXKqh73ZM5juz4z9PZ9EAhvVvkaH0h9PZ5CQ5Kzj
         NLqOjrxuJudrZeLJIZRpsnZD3qnjG+XFRoZ21yZP4UHxSJHh++pGF5HeFYv4WZGvZx/u
         qSyP4CSop1Ch6gIqzLcSjK2ZFT4fwdeoHBwdQhZFTJqey8tQf30gWWVlVafg+5noKl7H
         rLhjzlhEPxGFCB0J6vzrmNR1fWCcphUNsfo//pWVD7ocerKXlhTPoCqc136Y6KbnL/66
         KO8YT0w1SUA+Bu195b25aivIx58sppMiLY1V246tfrYOn60WjZowN+BVbmy5XDDgIGqV
         2zZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rZbWc+NBiqSw8v3aKVJp/xYRUOsEXgP44aztd2XHhEo=;
        b=AtCB39cpCKANwTXA5cAS923phtKL8f/O4Cn86Lh+9Vf9Rro/Xypal/bALna3uCv9uV
         YyR4IeHdZWcgXK35m/kN5x1UJV5EuryO83x56pToMu5oh2BofdsdpX/h6UYlC2QWs0tB
         HWVRwo4jdzFuyqs6i2Y6APLkxRc7KkKr7651NWIlkl1xUG3hZ/jN2hjFPpuyuiwHSdCE
         oEpAlzgCYQH8yS56eIX7GAVu5OmLOjd2mtiZDi234qWYF23ZaHqL7Nv62Gsqcj5Dq8jI
         dVuhNKDk3YQSpwrBrUisezuw6Grk/RZg+/zRoVIXaoQ6sR8jyMFZdjyOokayOTNKvRtO
         V2lA==
X-Gm-Message-State: AOAM533cqr9k5HxX8zn9Kw+7IU0WsvFiXeYv0ATsd6uy8K/qMJgrwPOv
        ANxMYhcTfIBWVCrBqhTQY1s=
X-Google-Smtp-Source: ABdhPJyxL4rQzKwzixgel9HjGK79kBI+2FrIRZl4Zin/9JvbEzXFas/SblJaMFNLX8Qs7Rg5Ctn1iQ==
X-Received: by 2002:a17:902:6b47:b0:142:82e1:6cf5 with SMTP id g7-20020a1709026b4700b0014282e16cf5mr16779924plt.28.1636805215155;
        Sat, 13 Nov 2021 04:06:55 -0800 (PST)
Received: from localhost.localdomain (li567-56.members.linode.com. [192.155.81.56])
        by smtp.gmail.com with ESMTPSA id z22sm9290403pfe.93.2021.11.13.04.06.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Nov 2021 04:06:54 -0800 (PST)
From:   Jeff Xie <xiehuan09@gmail.com>
To:     rostedt@goodmis.org
Cc:     mhiramat@kernel.org, mingo@redhat.com, zanussi@kernel.org,
        linux-kernel@vger.kernel.org, Jeff Xie <xiehuan09@gmail.com>
Subject: [RFC][PATCH v5 3/4] trace/objtrace: Add testcases for objtrace trigger parsing
Date:   Sat, 13 Nov 2021 20:06:31 +0800
Message-Id: <20211113120632.94754-3-xiehuan09@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211113120632.94754-1-xiehuan09@gmail.com>
References: <20211113120632.94754-1-xiehuan09@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Jeff Xie <xiehuan09@gmail.com>
---
 .../ftrace/test.d/trigger/trigger-objtrace.tc | 41 +++++++++++++++++++
 1 file changed, 41 insertions(+)
 create mode 100644 tools/testing/selftests/ftrace/test.d/trigger/trigger-objtrace.tc

diff --git a/tools/testing/selftests/ftrace/test.d/trigger/trigger-objtrace.tc b/tools/testing/selftests/ftrace/test.d/trigger/trigger-objtrace.tc
new file mode 100644
index 000000000000..4efcd7eee694
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/trigger/trigger-objtrace.tc
@@ -0,0 +1,41 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# description: event trigger - test objtrace-trigger
+# requires: kprobe_events
+
+fail() { #msg
+    echo $1
+    exit_fail
+}
+
+echo 'p bio_add_page arg1=$arg1' > kprobe_events
+
+FEATURE=`grep objtrace events/kprobes/p_bio_add_page_0/trigger`
+if [ -z "$FEATURE" ]; then
+    echo "objtrace trigger is not supported"
+    exit_unsupported
+fi
+
+echo "Test objtrace trigger"
+echo 'objtrace:add:0x28(arg1):u32:1 if comm == "cat"' > \
+	events/kprobes/p_bio_add_page_0/trigger
+if [ -z $? ]; then
+	fail "objtrace trigger syntax error"
+fi
+
+echo "Test objtrace semantic errors"
+
+# Being lack of type size
+! echo 'objtrace:add:0x28(arg1):1' > events/kprobes/p_bio_add_page_0/trigger
+# Being lack of objtrace command
+! echo 'objtrace:0x28(arg1):u32:1' > events/kprobes/p_bio_add_page_0/trigger
+# Bad parameter name
+! echo 'objtrace:add:argx:u32:1' > events/kprobes/p_bio_add_page_0/trigger
+
+echo "reset objtrace trigger"
+
+echo '!objtrace:add:0x28(arg1):u32' > \
+	events/kprobes/p_bio_add_page_0/trigger
+echo '-:p_bio_add_page_0' >> ./kprobe_events
+
+exit 0
-- 
2.25.1

