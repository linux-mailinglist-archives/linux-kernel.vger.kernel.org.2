Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 101C03D8149
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 23:17:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234456AbhG0VRJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 17:17:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233767AbhG0VRA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 17:17:00 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68B58C061799
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jul 2021 14:17:00 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id i10so67753pla.3
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jul 2021 14:17:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vRgb1VJvkR4TxUQ9j5wT6NQOJVualZe/N5ucmrpwcpM=;
        b=Urt716jbz8XdyF5XY5KmZM6capTDsG++7NWnKWGXa8A82gOnBVfVmzBVpmjGHy1J4E
         Ae0oY6icZsuXtD/nJ3EHWKWtJRkbNQuHNTS22y5t0/gFqDYoj2X9jMSktKlfLPXE1X8w
         GZLII5xANVEeoTTYkjVLPXyHbZ6nhUyQoz/jc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vRgb1VJvkR4TxUQ9j5wT6NQOJVualZe/N5ucmrpwcpM=;
        b=YIQ5tYUWxcutkeRldh02BM9ENNw6ckiQOSfh+YO0EpUGimEi/oROpL8nYgefE40Frt
         uZ0WBjpNsNOZIpTEQQzvobFTwEEyZSuW3adc3G+PwRovvgSxi0RJYeRNw4ESBmID+zjc
         crWTu2mGIOS33flwzjbH6gzSPWMiXrBWbY/2GBCvQhNidabPMRM91uMfmHu3MaWCVNMc
         QzbZih+eVIU8OHlFSZOP9H1eXI1CQ8ZKUMoFLkCKG1lSMhpZyt01/tzoMKrKExdMTo9h
         Vr6MSpNlexoaOpXkn/LaVKUElr3p3LPozIqLwMUJuvWiErdxDyit7/Q6z9EI8ifd1GV4
         VH/g==
X-Gm-Message-State: AOAM531e3wt4jRNn0iPY3S7k7+PIJyq67C0ndK/EhZrWOgEUGUzN4yUP
        f18F1QIK8shJ37xH/H7Qv3v+TA==
X-Google-Smtp-Source: ABdhPJyL6XeGJmKfKYoPIwSnVfrJu9DIh6q4pNy4qcyzmKIcgSJdIeoB0sfhxYXoqkr/188RbhWTVQ==
X-Received: by 2002:a05:6a00:1913:b029:32b:cec0:77e5 with SMTP id y19-20020a056a001913b029032bcec077e5mr24883708pfi.76.1627420619841;
        Tue, 27 Jul 2021 14:16:59 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id w15sm3794043pjc.45.2021.07.27.14.16.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jul 2021 14:16:57 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     linux-hardening@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Keith Packard <keithpac@amazon.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-staging@lists.linux.dev, linux-block@vger.kernel.org,
        linux-kbuild@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: [PATCH 51/64] tracing: Use struct_group() to zero struct trace_iterator
Date:   Tue, 27 Jul 2021 13:58:42 -0700
Message-Id: <20210727205855.411487-52-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210727205855.411487-1-keescook@chromium.org>
References: <20210727205855.411487-1-keescook@chromium.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1917; h=from:subject; bh=x33Bs21uGrD+N+Lns8bFSqK7vUUUNaNSw4EtFfeCu58=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBhAHOLu8z/bdU1zMaKndqRyKLCCkXgpWttZKN9yc8w d3BxuKSJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYQBziwAKCRCJcvTf3G3AJgHsD/ 98DZD+ecFAqbOjuzLoGxIi4OSnpxnTAcnT2/ZfVnIlEZyXBS+jkr8lU+k0GXpQG2scT/z3KyhdrOJp E60WG63kSFNFWzdWBZZyb0Rf9XVDGHksNfg81VOrWxyCFWrib/BFkg1uKQ3XHny7kvC0saWxsJLOvP PMmBG3p0AzH/bcHeY8JCSe1JqVGWLz4Wdiqq+a1FX3oATkVH4X6hjEPQSu7K5W5gsu8y3sWyfaJ/21 OTekfh+08tGzJUz0x5qwW+mEDgtAt0LEEHLhnIpkUCLiYWmDJzWKF5CUljC6wN4V/uNZBOMTukJCz8 F9nA0W1W0nXeWdz0Z6mMUksqNHOYIhyE52fHArE2U0l0tdWYgbUybcSQsrFUzJ1QxTx6KXNTmHAdC8 g1F37UY/3wzrelPZKNjO7Q2mpX8Q0hoRoR0IePaxvGxraMIKoteVOWP+yTjyheOHuIRmmwFS+m4zl0 xz0ti0B1g1MqQBahH7M3aZtJg/kgJEHRJTpe8g68atzyvYwY8rGNnEiemCygZ2liwL0XGVd/tcrTlJ KkliSKYsXdS6eykIau3c0P0wmRt7ydb/oQgVBcA744nu/6TZH0x0ehC/RmIZ3f0pnMMvLuX81V1dQy aaHLtNUQtk1I2pKRDzLqOWe+HldXvpA+eH/7VFXxng+zPZzpvdu07VGean9Q==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for FORTIFY_SOURCE performing compile-time and run-time
field bounds checking for memset(), avoid intentionally writing across
neighboring fields.

Add struct_group() to mark region of struct trace_iterator that should
be initialized to zero.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/linux/trace_events.h | 26 ++++++++++++++------------
 kernel/trace/trace.c         |  4 +---
 2 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
index ad413b382a3c..cadad77fe524 100644
--- a/include/linux/trace_events.h
+++ b/include/linux/trace_events.h
@@ -101,18 +101,20 @@ struct trace_iterator {
 	bool			snapshot;
 
 	/* The below is zeroed out in pipe_read */
-	struct trace_seq	seq;
-	struct trace_entry	*ent;
-	unsigned long		lost_events;
-	int			leftover;
-	int			ent_size;
-	int			cpu;
-	u64			ts;
-
-	loff_t			pos;
-	long			idx;
-
-	/* All new field here will be zeroed out in pipe_read */
+	struct_group(init,
+		struct trace_seq	seq;
+		struct trace_entry	*ent;
+		unsigned long		lost_events;
+		int			leftover;
+		int			ent_size;
+		int			cpu;
+		u64			ts;
+
+		loff_t			pos;
+		long			idx;
+
+		/* All new field here will be zeroed out in pipe_read */
+	);
 };
 
 enum trace_iter_flags {
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index c59dd35a6da5..9f83864b0be6 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -6691,9 +6691,7 @@ tracing_read_pipe(struct file *filp, char __user *ubuf,
 		cnt = PAGE_SIZE - 1;
 
 	/* reset all but tr, trace, and overruns */
-	memset(&iter->seq, 0,
-	       sizeof(struct trace_iterator) -
-	       offsetof(struct trace_iterator, seq));
+	memset(&iter->init, 0, sizeof(iter->init));
 	cpumask_clear(iter->started);
 	trace_seq_init(&iter->seq);
 	iter->pos = -1;
-- 
2.30.2

