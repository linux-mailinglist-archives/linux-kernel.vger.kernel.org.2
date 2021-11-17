Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95616454E4E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 21:08:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237214AbhKQULe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 15:11:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233081AbhKQULb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 15:11:31 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AC5FC061570;
        Wed, 17 Nov 2021 12:08:32 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id gb13-20020a17090b060d00b001a674e2c4a8so3530562pjb.4;
        Wed, 17 Nov 2021 12:08:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1eIUFkqmgQBeIM3a2SS7Z1qHzuY/2QZbKVIhYF2s6CM=;
        b=gn0RGALxervyc1BJ3lrIbjlKNIWQ9Av7ZRjpP8ISH7KioW82QmyynMGV3Mnrg7Dd1X
         3ThLa8YBeiUv5p8Co0R96Nhi6S5lkiFRWiit2IpnS3jAW9Pw7UWDrUgUjEActjW8xsFG
         wAKKM/i/7frPj9W1LK9FJydDt43NJHl6rVNg4lGt1tI6FqGPEj/dCnoEvB3zqEikHgnx
         ZUcTgECld9MAHQq+YOIVIAIx/X5Duh6SUwR2NbClcs2xGNNVxGJoVLOe1QqTrInr0L6X
         ttzg0eIXE8DHz+PkPy3fvJ+ni7F6q8XXpWd6CH0f2U5UqvuQFCauXh41lkuGT3SOMqKg
         Tg+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1eIUFkqmgQBeIM3a2SS7Z1qHzuY/2QZbKVIhYF2s6CM=;
        b=r6cjzk2iwnXGGLjxd36fDOtXgMYpnYRH/ipL4zRkqjxM4HwyOu+AniKqcmP/NvlAxr
         vrAWbzRLwzAhrKxzo6mJaqdMSd6uDyoxh41CVAqcp0je1P819KokwXAOFm66mHQ1TZFL
         MyVKT6Bt16YZndyTRRIgAjFY5PwCCUwfBs5eau0oacUc5eiu/nIyubwghHfI/CdGkbm5
         7R22Aszfr0ZGa7atWvgAZqWZQiBzPOsRwR8Bpgrvddy/vLx5LSi2lffpaJAujySvYmjn
         jWyLZLVLVedR0ryTPj55nqbXcJYFq5oddq7UB9/bP5l63NpHp2sjRdxWYqT9hxERU696
         BTRg==
X-Gm-Message-State: AOAM533n9CbSt/LUbJ0X4yISS4EzDdc2bZeqoSk8kPLGL/XuuAwQGi/I
        Wy6HuoFg1EXbewG82I24Atg=
X-Google-Smtp-Source: ABdhPJyPk7N1XndovDfvuQFFkUgvLCN+Lx1OFQ+6CbRC8uj1TSl/3AAXk1ysE6LgoTEH8noW3UqCng==
X-Received: by 2002:a17:90b:1a87:: with SMTP id ng7mr3058613pjb.86.1637179712040;
        Wed, 17 Nov 2021 12:08:32 -0800 (PST)
Received: from nickserv.localdomain (c-98-35-167-56.hsd1.ca.comcast.net. [98.35.167.56])
        by smtp.gmail.com with ESMTPSA id rm1sm6511050pjb.3.2021.11.17.12.08.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Nov 2021 12:08:31 -0800 (PST)
From:   Nick Terrell <nickrterrell@gmail.com>
To:     Nick Terrell <terrelln@fb.com>
Cc:     linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
        Helge Deller <deller@gmx.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH v2 2/3] lib: zstd: Don't inline functions in zstd_opt.c
Date:   Wed, 17 Nov 2021 12:14:58 -0800
Message-Id: <20211117201459.1194876-3-nickrterrell@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211117201459.1194876-1-nickrterrell@gmail.com>
References: <20211117201459.1194876-1-nickrterrell@gmail.com>
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

