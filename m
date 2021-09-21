Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 690D341370C
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 18:14:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234373AbhIUQP0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 12:15:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:39830 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234360AbhIUQPN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 12:15:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632240824;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zqnAk8CEPT4G20qz1UpPoVf1omLqowS17E+dGhKhwuM=;
        b=SnfSuRXgNGTyqVjnsgUSNlHAJCc/Lkoi5nV79FrqR7bDrwBBLRK+GCmeNCeY5OaXCn2MaH
        Nt7P8hZBcSXgOXYkMVjXotbjEbPuR1iSZFgcjnbm1FcKu2a01QDy2VW8Gi8YntqwhVwVDg
        1Qxl7xZrRpEtAGiraWCuoGXVZ3d5CVc=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-202-decNi3qqPriVQzFyCQtC8w-1; Tue, 21 Sep 2021 12:13:43 -0400
X-MC-Unique: decNi3qqPriVQzFyCQtC8w-1
Received: by mail-wr1-f72.google.com with SMTP id s13-20020a5d69cd000000b00159d49442cbso9252108wrw.13
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 09:13:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zqnAk8CEPT4G20qz1UpPoVf1omLqowS17E+dGhKhwuM=;
        b=PWSb6ZjNfMykI1+dzjQdifiCSTr1FR08MiDYmJxD6hv79UDo/Kr59iqLJbynfPgB+A
         +shZMvq8O3+9rg8UArIXckyeJC0LF46k8ukurvr3lp6CIx8yTqyiRvUMaUOUc+cGk1nj
         RGOQvJxK9WkBmohTeHeBulOEtxEUnP7OvDk/okMaHbJV/xRepWaggpuAEwmXQ7mw7IXf
         IUIXlFy5wjMr8Gzf8LcXgK4vHD9IAfLI4mZnGoHRuwMiD4YBPF08iEEK86QfGmSOT3g5
         97Squkh3ha6C1C+GmPwI68Xj1WV6lELBWyEt87Ga46r9H6TK6hJtM9aJbdg5ELIQm2jf
         JnTQ==
X-Gm-Message-State: AOAM532X6MKw8XEYHA868q2oPaD8YeG0s/GdO0Y3rxIfdmWA6W+PZIyO
        EeFC+NpWN7s7q8G5Ju23nP9iVTqF+wAXzCGDEylt6HHrgfPe9BlYyvYu61eFdNrMQfyCkW3unpd
        UMh3vM2iGFVFkWZpF/crE0Wz0
X-Received: by 2002:a5d:510b:: with SMTP id s11mr35121620wrt.79.1632240821968;
        Tue, 21 Sep 2021 09:13:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz2JyQmA+xjBWA1pYPhaUZl3UgvqGOZtEA5D9vdOoOLPYTSVO682BJB72/4LybppWdkc2NU+A==
X-Received: by 2002:a5d:510b:: with SMTP id s11mr35121588wrt.79.1632240821777;
        Tue, 21 Sep 2021 09:13:41 -0700 (PDT)
Received: from vian.redhat.com ([2a0c:5a80:1d03:b900:c3d1:5974:ce92:3123])
        by smtp.gmail.com with ESMTPSA id t1sm19786477wrz.39.2021.09.21.09.13.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Sep 2021 09:13:41 -0700 (PDT)
From:   Nicolas Saenz Julienne <nsaenzju@redhat.com>
To:     akpm@linux-foundation.org, frederic@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        tglx@linutronix.de, cl@linux.com, peterz@infradead.org,
        juri.lelli@redhat.com, mingo@redhat.com, mtosatti@redhat.com,
        nilal@redhat.com, mgorman@suse.de, ppandit@redhat.com,
        williams@redhat.com, bigeasy@linutronix.de,
        anna-maria@linutronix.de, linux-rt-users@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>
Subject: [PATCH 6/6] sched/isolation: Enable 'remote_pcpu_cache_access' on NOHZ_FULL systems
Date:   Tue, 21 Sep 2021 18:13:24 +0200
Message-Id: <20210921161323.607817-7-nsaenzju@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210921161323.607817-1-nsaenzju@redhat.com>
References: <20210921161323.607817-1-nsaenzju@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When enabled, 'remote_pcpu_cache_access' allows for remote draining of
mm/swap.c's per-cpu LRU caches and mm/page_alloc.c's per-cpu page lists
instead of using per-cpu drain work. This comes at the cost of more
constraining locking, but NOHZ_FULL setups need this nonetheless:
processes running on isolated CPUs are sensitive to any sort of
interruption and preempting them in order to satisfy a housekeeping task
is bound to break their functional guarantees (i.e. latency, bandwidth,
etc...).

So enable 'remote_pcpu_cache_access' after having successfully
initialized NOHZ_FULL.

This is based on previous work by Thomas Gleixner, Anna-Maria Gleixner,
and Sebastian Andrzej Siewior[1].

[1] https://patchwork.kernel.org/project/linux-mm/patch/20190424111208.24459-3-bigeasy@linutronix.de/
Signed-off-by: Nicolas Saenz Julienne <nsaenzju@redhat.com>
---
 kernel/sched/isolation.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/isolation.c b/kernel/sched/isolation.c
index 7f06eaf12818..4fc4c76f27ab 100644
--- a/kernel/sched/isolation.c
+++ b/kernel/sched/isolation.c
@@ -8,6 +8,7 @@
  *
  */
 #include "sched.h"
+#include "../../mm/internal.h"
 
 DEFINE_STATIC_KEY_FALSE(housekeeping_overridden);
 EXPORT_SYMBOL_GPL(housekeeping_overridden);
@@ -137,11 +138,17 @@ static int __init housekeeping_setup(char *str, enum hk_flags flags)
 static int __init housekeeping_nohz_full_setup(char *str)
 {
 	unsigned int flags;
+	int ret;
 
 	flags = HK_FLAG_TICK | HK_FLAG_WQ | HK_FLAG_TIMER | HK_FLAG_RCU |
 		HK_FLAG_MISC | HK_FLAG_KTHREAD;
 
-	return housekeeping_setup(str, flags);
+	ret = housekeeping_setup(str, flags);
+	if (ret)
+		/* Avoid LRU cache and mm/page_alloc.c's pcplists drain work */
+		static_branch_enable(&remote_pcpu_cache_access);
+
+	return ret;
 }
 __setup("nohz_full=", housekeeping_nohz_full_setup);
 
-- 
2.31.1

