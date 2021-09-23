Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53CB24162DD
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 18:19:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232704AbhIWQUk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 12:20:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229929AbhIWQUV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 12:20:21 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FBA8C061574
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 09:18:50 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id e6-20020a0cb446000000b0037eeb9851dfso20053403qvf.17
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 09:18:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=AkcrhURqVthVCCtAtUC9nr8/+VOdZNhb5CMeqvSTap4=;
        b=cb6GSeFqP+HlIiSHk5XN4uTTTJ0C4MgXTFISO3hkBoPjUUqz9M+s/TprS2c8EhE1ez
         dEtdxbaf8bSHxQDbK6LToEzMxSqFL6HBVn4PSt738UYwaEu97vuNlPcjERk3gg1TsKKT
         zFPoXo8I7o2jv0kh15as8dY7NMeYasxbd5uQPz0woUGUEi1s5bDoyCPzcrfHheZrJhRr
         9YrvVzYUo5bMyIZbWRonV0maNteEI+RlKZBLb/YTX3apR37PgiyW67a4h95cF50KNWtt
         xCr9lH/mG9LVISFPxdXL5mHDUb/7DQQxhhuBEVLX2fmCgr3L3/V2yEENCanLpTTPDshq
         Cr9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=AkcrhURqVthVCCtAtUC9nr8/+VOdZNhb5CMeqvSTap4=;
        b=WCRKtS4MPeaALXgalRIS2ROm25hsY3o27IXCTHgu7QiFVBQUF1oAW7M4yDAvTmdgy2
         k3qJIcKFEcm1JeEFz2vSJ97QIBQm6WzUmY34ydC63F0EAwCD5afpLI+HflFULEbUgT4a
         S4GCy+ftcx8eWVuS7xtXqb7emVZdL1TGAwW1BTIVidpLFfMiQNwgNA09lpKDjvyFoC2/
         uzcoEVn8b029d8tlxR5bhjazq6O7zFrRcKY1t27B1AZgF+mBWmRu1V+7gq5DrhO6keid
         doMCv/p32WjUtg/NZGsGgT1S7bADiv3lP8NMLsPe/7EdHQQ59V07iNPpxlJ/4cOLdaQn
         KFWg==
X-Gm-Message-State: AOAM530c9d/JcQBT/bF+7BNeVGIfgAsCX+MlNJh4memikkPJpuvj1aZe
        H5lGrkVgPYsE96AsLbA1A4yniZzL1xGa
X-Google-Smtp-Source: ABdhPJw/yb4+PlQ81wOG2f1X8Cy4espwcELE3rd7BM+t26J/LdMqudvlY0W49hK5skzYmexoKDVvHPgU7HNc
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:d3ff:e8f7:11f4:c738])
 (user=irogers job=sendgmr) by 2002:a05:6214:50b:: with SMTP id
 v11mr5036151qvw.41.1632413929235; Thu, 23 Sep 2021 09:18:49 -0700 (PDT)
Date:   Thu, 23 Sep 2021 09:18:43 -0700
Message-Id: <20210923161843.751834-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.464.g1972c5931b-goog
Subject: [PATCH v4] x86/insn, tools/x86: Fix some potential undefined behavior.
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

v4. Fixes a typo.

v3. Is a rebase picking up a fix for big endian architectures.

v2. removes the validate_next check and merges the 2 changes into one as
requested by Masami Hiramatsu <mhiramat@kernel.org>

Signed-off-by: Ian Rogers <irogers@google.com>
Signed-off-by: Numfor Mbiziwo-Tiapo <nums@google.com>
Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
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
index c41f95815480..797699462cd8 100644
--- a/tools/arch/x86/lib/insn.c
+++ b/tools/arch/x86/lib/insn.c
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
-- 
2.33.0.464.g1972c5931b-goog

