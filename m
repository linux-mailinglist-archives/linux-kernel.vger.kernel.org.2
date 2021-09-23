Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 295C94162CE
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 18:15:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242001AbhIWQQe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 12:16:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231233AbhIWQQb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 12:16:31 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1655EC061756
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 09:15:00 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id z6-20020a056214060600b0037a3f6bd9abso21217552qvw.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 09:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=8skwKNtO9I6V2G8mmM/41MyFzuQ5MEvFVCQ4srHSO5U=;
        b=StP+whmufP9F/dLmxaO5AZdsk1rqzYkCY8Wjt8hnmM0pwS+sJEqMz96BShtHjlzQQq
         gOFL9yFNDzDiL7lL2xl/NjVB9WRQ3yXQLzJKz6FNM+AI9BusTmx04Ig8CDy//108tRMG
         ktt8NudAYgbMS0wb+9DoKL94Gb3xRqlhkxqAdQ4VLkmB7aMS4K/iIRfgddNyuzVsl/zM
         RF2KQ9ne0fRAqUf+M2rOTk8V1hIgHSO382gQDejol9gqNEQ3fTgD7NX694Eip/xve0zo
         QSkawXq2JOiepUxlnY7LC+QXK7g2Gi+XLg56KiGXq5u+AOhZP68aKOD1PmPiNEGjyCO2
         F2lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=8skwKNtO9I6V2G8mmM/41MyFzuQ5MEvFVCQ4srHSO5U=;
        b=G6YvCOt+L8ojnHREJG+T2IoR3ryEV6L21sBnjajc9RZwAPEvOdOL+hra9V1TeKNS35
         uslzP4NNGNk/4cQdTlbAp1ayGpFRObEWJiQEyC6tUK/ewJRyCEEVrbD96/G5m94uOuJb
         AwOPM2ObxxNT3lvSbYXRvtRHklroreCKIjtG7vpIwj/tfXTrKn7xzS2G2DM0sXddI5MQ
         EA/8nVhOOBUSzLzWyF/qQ1r+3yoC0EydLDP1OHmapBofBaPUDMc2x986VDti4Ci3b91Q
         KzLn+u7+sHzqDUBuPclcKvsiUkjq9PdHV2otJsCVxm1rZkD+8Qe0lNl1WGz5gU67eUFD
         oPPg==
X-Gm-Message-State: AOAM533LwYKZTxfEz0n/4izcgEs9c7e4Tdeyxu3pFue1m8ScV3xQ2dBL
        1FKmeLn15/rlG+SKjeCUhQIjgWYbKFAg
X-Google-Smtp-Source: ABdhPJz4BkGaJpb9N5HKKwzsg2+PxWO/3F209IbCIgr+IOfty/pF3oUk82+fPA+78zbZBzGo48C4zVZGCBTj
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:d3ff:e8f7:11f4:c738])
 (user=irogers job=sendgmr) by 2002:a25:bacd:: with SMTP id
 a13mr7450706ybk.216.1632413699216; Thu, 23 Sep 2021 09:14:59 -0700 (PDT)
Date:   Thu, 23 Sep 2021 09:14:40 -0700
Message-Id: <20210923161440.746537-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.464.g1972c5931b-goog
Subject: [PATCH v3] x86/insn, tools/x86: Fix some potential undefined behavior.
From:   Ian Rogers <irogers@google.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        linux-kernel@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        David Laight <David.Laight@aculab.com>
Cc:     Numfor Mbiziwo-Tiapo <nums@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Numfor Mbiziwo-Tiapo <nums@google.com>

Don't perform unaligned loads in __get_next and __peek_nbyte_next as
these are forms of undefined behavior.

These problems were identified using the undefined behavior sanitizer
(ubsan) with the tools version of the code and perf test. Part of this
patch was previously posted here:
https://lore.kernel.org/lkml/20190724184512.162887-4-nums@google.com/

v3. Is a rebase picking up a fix for big endian architectures.

v2. removes the validate_next check and merges the 2 changes into one as
requested by Masami Hiramatsu <mhiramat@kernel.org>

Signed-off-by: Ian Rogers <irogers@google.com>
Signed-off-by: Numfor Mbiziwo-Tiapo <nums@google.com>
---
 arch/x86/lib/insn.c       | 4 ++--
 tools/arch/x86/lib/insn.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/lib/insn.c b/arch/x86/lib/insn.c
index 058f19b20465..c565def611e2 100644
--- a/arch/x86/lib/insn.c
+++ b/arch/x86/lib/insn.c
@@ -37,10 +37,10 @@
 	((insn)->next_byte + sizeof(t) + n <= (insn)->end_kaddr)
 
 #define __get_next(t, insn)	\
-	({ t r = *(t*)insn->next_byte; insn->next_byte += sizeof(t); leXX_to_cpu(t, r); })
+	({ t r; memcpy(&r, insn->next_byte, sizeof(t)); insn->next_byte += sizeof(t); leXX_to_cpu(t, r); })
 
 #define __peek_nbyte_next(t, insn, n)	\
-	({ t r = *(t*)((insn)->next_byte + n); leXX_to_cpu(t, r); })
+	({ t r; memcpy(&r, (insn)->next_byte + n, sizeof(t)); leXX_to_cpu(t, r); })
 
 #define get_next(t, insn)	\
 	({ if (unlikely(!validate_next(t, insn, 0))) goto err_out; __get_next(t, insn); })
diff --git a/tools/arch/x86/lib/insn.c b/tools/arch/x86/lib/insn.c
index c41f95815480..bc11b5774a44 100644
--- a/tools/arch/x86/lib/insn.c
+++ b/tools/arch/x86/lib/insn.c
@@ -37,10 +37,10 @@
 	((insn)->next_byte + sizeof(t) + n <= (insn)->end_kaddr)
 
 #define __get_next(t, insn)	\
-	({ t r = *(t*)insn->next_byte; insn->next_byte += sizeof(t); leXX_to_cpu(t, r); })
+	({ t r; memcpy(&r, insn->next_byte, sizeof(t)); insn->next_byte += sizeof(t); leXX_to_cpu(t, r);; })
 
 #define __peek_nbyte_next(t, insn, n)	\
-	({ t r = *(t*)((insn)->next_byte + n); leXX_to_cpu(t, r); })
+	({ t r; memcpy(&r, (insn)->next_byte + n, sizeof(t)); leXX_to_cpu(t, r);; })
 
 #define get_next(t, insn)	\
 	({ if (unlikely(!validate_next(t, insn, 0))) goto err_out; __get_next(t, insn); })
-- 
2.33.0.464.g1972c5931b-goog

