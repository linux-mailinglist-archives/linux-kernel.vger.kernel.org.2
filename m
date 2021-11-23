Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C361459B75
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 06:17:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232660AbhKWFUW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 00:20:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbhKWFUR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 00:20:17 -0500
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2E67C061714
        for <linux-kernel@vger.kernel.org>; Mon, 22 Nov 2021 21:17:08 -0800 (PST)
Received: by mail-pf1-x44a.google.com with SMTP id y124-20020a623282000000b0047a09271e49so11086036pfy.16
        for <linux-kernel@vger.kernel.org>; Mon, 22 Nov 2021 21:17:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=NFXAGR/xc49oqhNC41J0AQLDYJfxO7+Jxraub53Emyc=;
        b=ey7cdPuXo53FwDLmzr6OCkG/WgkXsyr7tpMu5mUd6CjU6Aiu5BGVyYKwf7ZRGqKNkW
         XCJvfuxbdEtqOUBqhjgOJkeGLjrf0FWukN82g40hpufMkzHuIrh/LLe/cILZp2xvU/mQ
         +oZZ0IzOAPAnSQVm6xLuBThCj3bV7b9Zt9T1Ldv9PpZUW15NXdxa4hMIKKEjMXqbNGxQ
         lpE+m1hXxc8ppyMpxBughfEowTTd2+zEdQnJAO+07UCh1VU52n2qC2xY4DQioiMtX6GX
         WJSeeIvpchw+UeeV8z87iFesRr5KFS+mO+4c6V6WVidi0rxrBjBucNuBqEv+8l7+yBb9
         iJ5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=NFXAGR/xc49oqhNC41J0AQLDYJfxO7+Jxraub53Emyc=;
        b=KqFYwcEaeG2fcyCaKF/54FnNpaOzBXsYtgBA1SwPdWc0ECkiFfQ4OTaecA4MgWn5+y
         YO9slQRvfkofQ0RfqAYbGaaOzk2kNRNEs81nP+11gJ1kisoq3nnipgy+lZsCJdcgbj5m
         dUAlEPaVoHWVluo6zp57gaZVG/c1ZTyAG2KEx2V7FEegpjt/rMxDe1826gBhiNJZd0nQ
         J8KZ+PQy1aYHDT+5+Qb+7JF58W0Y64JDTWusLY/ie8WYv3UyBxicZG8x9Dvpj70vw5E/
         2FAOb8YgA00mWZS0xoRrcLUbJ73KrFxkUfjTdtYKT+6h6IpVSvk/aGZ4X9U+SUbzX4Hq
         Z+wg==
X-Gm-Message-State: AOAM531pDsphvnViphga33d+eZnKmLEIoDRceT7wIVf1NgDoOGy1z5eo
        vkZ6AKqRTCwb8MeuByeFrReuQME=
X-Google-Smtp-Source: ABdhPJzxQakGABdjIJCQjLa7F4VRbS3dyTefpbTS5bC19PmFmcSwZH41uUXPqwC9QBE4HVmcOu0sevE=
X-Received: from pcc-desktop.svl.corp.google.com ([2620:15c:2ce:200:a876:2e6a:b5f:3d90])
 (user=pcc job=sendgmr) by 2002:a63:1d13:: with SMTP id d19mr1879264pgd.383.1637644628236;
 Mon, 22 Nov 2021 21:17:08 -0800 (PST)
Date:   Mon, 22 Nov 2021 21:16:54 -0800
In-Reply-To: <20211123051658.3195589-1-pcc@google.com>
Message-Id: <20211123051658.3195589-2-pcc@google.com>
Mime-Version: 1.0
References: <20211123051658.3195589-1-pcc@google.com>
X-Mailer: git-send-email 2.34.0.rc2.393.gf8c9666880-goog
Subject: [PATCH v2 1/5] fs: use raw_copy_from_user() to copy mount() data
From:   Peter Collingbourne <pcc@google.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        YiFei Zhu <yifeifz2@illinois.edu>,
        Colin Ian King <colin.king@canonical.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Peter Collingbourne <pcc@google.com>,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        Chris Hyser <chris.hyser@oracle.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Dmitry Vyukov <dvyukov@google.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Alexey Gladkov <legion@kernel.org>,
        Ran Xiaokai <ran.xiaokai@zte.com.cn>,
        David Hildenbrand <david@redhat.com>,
        Xiaofeng Cao <caoxiaofeng@yulong.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Thomas Cedeno <thomascedeno@google.com>,
        Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Evgenii Stepanov <eugenis@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With uaccess logging the contract is that the kernel must not report
accessing more data than necessary, as this can lead to false positive
reports in downstream consumers. This generally works out of the box
when instrumenting copy_{from,to}_user(), but with the data argument
to mount() we use copy_from_user() to copy PAGE_SIZE bytes (or as
much as we can, if the PAGE_SIZE sized access failed) and figure out
later how much we actually need.

To prevent this from leading to a false positive report, use
raw_copy_from_user(), which will prevent the access from being logged.
Recall that it is valid for the kernel to report accessing less
data than it actually accessed, as uaccess logging is a best-effort
mechanism for reporting uaccesses.

Link: https://linux-review.googlesource.com/id/I5629b92a725c817acd9a861288338dd605cafee6
Signed-off-by: Peter Collingbourne <pcc@google.com>
---
 fs/namespace.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 659a8f39c61a..695b30e391f0 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -3197,7 +3197,12 @@ static void *copy_mount_options(const void __user * data)
 	if (!copy)
 		return ERR_PTR(-ENOMEM);
 
-	left = copy_from_user(copy, data, PAGE_SIZE);
+	/*
+	 * Use raw_copy_from_user to avoid reporting overly large accesses in
+	 * the uaccess buffer, as this can lead to false positive reports in
+	 * downstream consumers.
+	 */
+	left = raw_copy_from_user(copy, data, PAGE_SIZE);
 
 	/*
 	 * Not all architectures have an exact copy_from_user(). Resort to
-- 
2.34.0.rc2.393.gf8c9666880-goog

