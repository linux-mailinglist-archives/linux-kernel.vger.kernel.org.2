Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42785453DD5
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 02:43:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232540AbhKQBqP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 20:46:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232355AbhKQBqM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 20:46:12 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC7BBC061746;
        Tue, 16 Nov 2021 17:43:14 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id o14so753746plg.5;
        Tue, 16 Nov 2021 17:43:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1eIUFkqmgQBeIM3a2SS7Z1qHzuY/2QZbKVIhYF2s6CM=;
        b=LhnOPRD/I2LCrwnDqXM6sQieU7tUSe2Hy1OAc253hiIZ+RF3NA8mIfkvJXFFIg71Hf
         FZZ5OjKpoqXlbCqea5Sg+8t1Dvmj3xOtaxejw43iWP5NVWutwzdZh07aKFHSBZPu8X7X
         gNaxzYECHZ6r/pv/shpAJdJhnrWeR+mW/lPWs5DNdPDi4GmaKslRzzARY7ZrB+EZsVBW
         /8Mu0D/1aK7ZVEckzquzrE50GsJhQizCJABsEVUEtt/AMwnnS1wM7j5kF7wdEaOg3ywB
         knIJnLcY8hf4IbcTQl5SmmKiiS4PGsHKUodNggEiDKQCk6fe2DvvUD54KOY9cXrrUHji
         Ie0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1eIUFkqmgQBeIM3a2SS7Z1qHzuY/2QZbKVIhYF2s6CM=;
        b=urummQdaxXPPEaEz4GTXsa4Tn0brweMi3rLVqxCpDvxQd0n55kBTIMVC0a8qI3KgEq
         1La3LPtVQQaKwRNEsAcU3/QNYu0Lx5h/+Yj/QxcRto/WSa1bBMk+o9o7mNLrPXwuumVD
         fxE1zSVAopRlXEsYthNAxN7LsLBB5ExrNSSa8Mc2whARdZP0INSHIZFuT5o1T4fRWGGr
         CD7i/w0urxhFR92yB9rjCPFEuXU6qigcLPdttbd1q+7R3YTJNKtoEQqZQufEandy/aPj
         bmh8kRRoOOFzA1fMfAtVFurmQPAPZtU4t3dVYNjb+wYqimvHfgYOPgh5tVViho1z7iIW
         cVsw==
X-Gm-Message-State: AOAM533isOOq3JXADlQLTXNbKL0zYDPVYABaev95HQY/h+pBr6p8hRoV
        HZL47esKcKmZXenaA6tvB1o=
X-Google-Smtp-Source: ABdhPJzRw1dO1GikNUfBTpxL074oiEKVoVJq/uHYWUu0ZgnvZOTzcqst17xBxZp1Wd8ysH/RpRpeFA==
X-Received: by 2002:a17:902:7289:b0:142:805f:e2c with SMTP id d9-20020a170902728900b00142805f0e2cmr49927599pll.42.1637113394313;
        Tue, 16 Nov 2021 17:43:14 -0800 (PST)
Received: from nickserv.localdomain (c-98-35-167-56.hsd1.ca.comcast.net. [98.35.167.56])
        by smtp.gmail.com with ESMTPSA id np16sm3783411pjb.6.2021.11.16.17.43.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Nov 2021 17:43:13 -0800 (PST)
From:   Nick Terrell <nickrterrell@gmail.com>
To:     Nick Terrell <terrelln@fb.com>
Cc:     linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
        Helge Deller <deller@gmx.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 2/3] lib: zstd: Don't inline functions in zstd_opt.c
Date:   Tue, 16 Nov 2021 17:49:48 -0800
Message-Id: <20211117014949.1169186-3-nickrterrell@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211117014949.1169186-1-nickrterrell@gmail.com>
References: <20211117014949.1169186-1-nickrterrell@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nick Terrell <terrelln@fb.com>

`zstd_opt.c` contains the match finder for the highest compression
levels. These levels are already very slow, and are unlikely to be used
in the kernel. If they are used, they shouldn't be used in latency
sensitive workloads, so slowing them down shouldn't be a big deal.

This saves 188 KB of the 288 KB regression reported by Geert Uytterhoeven [0].
I've also opened an issue upstream [1] so that we can properly tackle
the code size issue in `zstd_opt.c` for all users, and can hopefully
remove this hack in the next zstd version we import.

Bloat-o-meter output on x86-64:

```
> ../scripts/bloat-o-meter vmlinux.old vmlinux
add/remove: 6/5 grow/shrink: 1/9 up/down: 16673/-209939 (-193266)
Function                                     old     new   delta
ZSTD_compressBlock_opt_generic.constprop       -    7559   +7559
ZSTD_insertBtAndGetAllMatches                  -    6304   +6304
ZSTD_insertBt1                                 -    1731   +1731
ZSTD_storeSeq                                  -     693    +693
ZSTD_BtGetAllMatches                           -     255    +255
ZSTD_updateRep                                 -     128    +128
ZSTD_updateTree                               96      99      +3
ZSTD_insertAndFindFirstIndexHash3             81       -     -81
ZSTD_setBasePrices.constprop                  98       -     -98
ZSTD_litLengthPrice.constprop                138       -    -138
ZSTD_count                                   362     181    -181
ZSTD_count_2segments                        1407     938    -469
ZSTD_insertBt1.constprop                    2689       -   -2689
ZSTD_compressBlock_btultra2                19990     423  -19567
ZSTD_compressBlock_btultra                 19633      15  -19618
ZSTD_initStats_ultra                       19825       -  -19825
ZSTD_compressBlock_btopt                   20374      12  -20362
ZSTD_compressBlock_btopt_extDict           29984      12  -29972
ZSTD_compressBlock_btultra_extDict         30718      15  -30703
ZSTD_compressBlock_btopt_dictMatchState    32689      12  -32677
ZSTD_compressBlock_btultra_dictMatchState   33574      15  -33559
Total: Before=6611828, After=6418562, chg -2.92%
```

[0] https://lkml.org/lkml/2021/11/14/189
[1] https://github.com/facebook/zstd/issues/2862

Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Nick Terrell <terrelln@fb.com>
---
 lib/zstd/common/compiler.h   |  7 +++++++
 lib/zstd/compress/zstd_opt.c | 14 +++++++++++++-
 2 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/lib/zstd/common/compiler.h b/lib/zstd/common/compiler.h
index a1a051e4bce6..f5a9c70a228a 100644
--- a/lib/zstd/common/compiler.h
+++ b/lib/zstd/common/compiler.h
@@ -16,6 +16,7 @@
 *********************************************************/
 /* force inlining */
 
+#if !defined(ZSTD_NO_INLINE)
 #if (defined(__GNUC__) && !defined(__STRICT_ANSI__)) || defined(__cplusplus) || defined(__STDC_VERSION__) && __STDC_VERSION__ >= 199901L   /* C99 */
 #  define INLINE_KEYWORD inline
 #else
@@ -24,6 +25,12 @@
 
 #define FORCE_INLINE_ATTR __attribute__((always_inline))
 
+#else
+
+#define INLINE_KEYWORD
+#define FORCE_INLINE_ATTR
+
+#endif
 
 /*
   On MSVC qsort requires that functions passed into it use the __cdecl calling conversion(CC).
diff --git a/lib/zstd/compress/zstd_opt.c b/lib/zstd/compress/zstd_opt.c
index 04337050fe9a..09483f518dc3 100644
--- a/lib/zstd/compress/zstd_opt.c
+++ b/lib/zstd/compress/zstd_opt.c
@@ -8,6 +8,18 @@
  * You may select, at your option, one of the above-listed licenses.
  */
 
+/*
+ * Disable inlining for the optimal parser for the kernel build.
+ * It is unlikely to be used in the kernel, and where it is used
+ * latency shouldn't matter because it is very slow to begin with.
+ * We prefer a ~180KB binary size win over faster optimal parsing.
+ *
+ * TODO(https://github.com/facebook/zstd/issues/2862):
+ * Improve the code size of the optimal parser in general, so we
+ * don't need this hack for the kernel build.
+ */
+#define ZSTD_NO_INLINE 1
+
 #include "zstd_compress_internal.h"
 #include "hist.h"
 #include "zstd_opt.h"
@@ -894,7 +906,7 @@ static void ZSTD_optLdm_processMatchCandidate(ZSTD_optLdm_t* optLdm, ZSTD_match_
              */
             U32 posOvershoot = currPosInBlock - optLdm->endPosInBlock;
             ZSTD_optLdm_skipRawSeqStoreBytes(&optLdm->seqStore, posOvershoot);
-        } 
+        }
         ZSTD_opt_getNextMatchAndUpdateSeqStore(optLdm, currPosInBlock, remainingBytes);
     }
     ZSTD_optLdm_maybeAddMatch(matches, nbMatches, optLdm, currPosInBlock);
-- 
2.33.1

