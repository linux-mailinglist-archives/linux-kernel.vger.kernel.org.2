Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1771364E86
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 01:18:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231984AbhDSXS1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 19:18:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230114AbhDSXS0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 19:18:26 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A008C06174A
        for <linux-kernel@vger.kernel.org>; Mon, 19 Apr 2021 16:17:55 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id y62so420554pfg.4
        for <linux-kernel@vger.kernel.org>; Mon, 19 Apr 2021 16:17:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mpzKlZqkQF+j0Y24ZCjEE7a1IQfuQ30qydgZaL1YVPM=;
        b=QYgSfpArZ/tZmJR+GynFl1qOxLGmMcBck1ioD3LWZuqnmdC3W0PtpONY04AOx4yEUV
         GzSbWrM5e90nHCzHQSw8wmeaOiNplF8LGFdvgTeSSdlOkN5o5h+kYnaTvTJxUVLOpEr6
         if7Zu2D78Tn1toEz/JrIoHGIcnjSglsLxDl2U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mpzKlZqkQF+j0Y24ZCjEE7a1IQfuQ30qydgZaL1YVPM=;
        b=jPqXWnA287DVC3BAgwoMX48uXuIAUlblwg0E/fIQrQbf/q5pPDDMd3Tf8UFAuIa1Lx
         HazPwiGih4BzmaXh2y1gUdsut8VySvSdoFuARxvFznG/J/YHwTmwSgEJjZRtD1eWMi5u
         12tn7YTzNj2C5OXYQ+FuKx4iSmwb+eq5a0RmV8mUXw7DzXe+eZPGx2N/+Ihfeedum0Xn
         sxnCOCRDNutcRvuSXO4QsWKFHHFnaJOb2y5c8VwTV/Qlnwa8njvY7ROhmMdIJTtsSyPK
         0Nn/1h58msnmsIsr3u9X5eTZa521ZFgXiZxvQg8KUXf7t2g6165mBNIdbMHsVoOdO781
         zFng==
X-Gm-Message-State: AOAM531rC49FZNOrxR1Q93YV6doCb9Zu21HQUI7eLuTWEAlqZAHMXMel
        9au5cfsUugN3EJGX1XnTCzCbzg==
X-Google-Smtp-Source: ABdhPJyNgPPOGGOtGVWmeNFqGRkc8jhi/koQe3dHj1BQ3lW9idqWIssRg9nW4gTJMypOOStHujr+uQ==
X-Received: by 2002:a65:620d:: with SMTP id d13mr14001580pgv.85.1618874274608;
        Mon, 19 Apr 2021 16:17:54 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id w4sm441295pjk.55.2021.04.19.16.17.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Apr 2021 16:17:54 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Elena Reshetova <elena.reshetova@intel.com>,
        David Laight <David.Laight@ACULAB.COM>,
        Will Deacon <will@kernel.org>,
        clang-built-linux@googlegroups.com, linux-kernel@vger.kernel.org
Subject: [PATCH] stack: replace "o" output with "r" input constraint
Date:   Mon, 19 Apr 2021 16:17:41 -0700
Message-Id: <20210419231741.4084415-1-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Patch-Hashes: v=1; h=sha256; g=107b110abea15ea50dd7287bab5454c51fba75af; i=IpIn0WJbK5AHx0CI/YU1Pp8wmQpYNAHsCPXAyJb63RE=; m=rkwYQhAIHzivH/uXgvMK4Amjng3IIclbTBo0/8PNWeg=; p=LEFGjKZZ25DUKHDKAFgOOruCO6MLiNc9fAJplphP9Xc=
X-Patch-Sig: m=pgp; i=ndesaulniers@google.com; s=0x0x8972F4DFDC6DC026; b=iQIzBAABCgAdFiEEpcP2jyKd1g9yPm4TiXL039xtwCYFAmB+D5UACgkQiXL039xtwCbrDhAArJl 5CJMV/vviFWTpqqfJE5usPZ/HWYL6LUHvWWuZNhfh2Ei7STSO08aVQ54Ux19w3YPdtZCGphTEm92B +oh3sWKbAbnpOUO+LuekHJGbwyxNzg2n9Y0whF9Q/VpSP6BHJchTRbtDb/R7uQdLCkyZK4KULtknW aR/UF0MGQPBPlctEmzaVwTY9zQkJWsmiXuLCOcN3RtaIeIMiopd3JI21TV3Q/frqSYXFOHoaHH2HT JyzB+OuLMsO3xsiyI+4n6gMqcVOQvy8vZvu2ZjLKF6WZ2a3pu6JWap3XcjNKIwmDsAiXuJv8WMCj5 crhbtwxNxkkBwkrCkuu41hTa4LaW1NzGby3FH/pgpw9TULIFVshCqJJ4jp92JKCz9Dnv358T1ZpaO RPd85vgTosffDkUEmhZSrm1rrAMelrwDsVRhh871c4zKmT3CXAJRnnBZna1O9TNVQYAJ4cQ81nzZM b1O2nkYu4NJXlALJxP1LWTPf7POKi1xmuWvd2Y7ST0tikFG0Ywa4T7bNH+WRfJRK3SnDQ57in+cwm g3aJPInymBiU6u/z3n7qyNG6JKbtumaK49GfsnLqu7aw6k5umO62O113jWPppaCJTsMN+3SlOAEHK Qulk8GKvatl0l54r5+qkE0CyMUPREAB8n0+G2nW/DLEE2EfTI9wknTowLqjlWDHE=
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nick Desaulniers <ndesaulniers@google.com>

"o" isn't a common asm() constraint to use; it triggers an assertion in
assert-enabled builds of LLVM that it's not recognized when targeting
aarch64 (though it appears to fall back to "m"). I've fixed this in LLVM
13 now, but there isn't really a good reason to be using "o" in particular
here. To avoid causing build issues for those using assert-enabled builds
of earlier LLVM versions, the constraint needs changing.

Instead, if the point is to retain the __builtin_alloca(), we can make ptr
appear to "escape" via being an input to an empty inline asm block. This
is preferable anyways, since otherwise this looks like a dead store.

While the use of "r" was considered in
https://lore.kernel.org/lkml/202104011447.2E7F543@keescook/
it was only tested as an output (which looks like a dead store, and
wasn't sufficient). Use "r" as an input constraint instead, which
behaves correctly across compilers and architectures:
https://godbolt.org/z/E9cd411ob

Link: https://reviews.llvm.org/D100412
Link: https://bugs.llvm.org/show_bug.cgi?id=49956
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
Tested-by: Kees Cook <keescook@chromium.org>
Fixes: 39218ff4c625 ("stack: Optionally randomize kernel stack offset each syscall")
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/linux/randomize_kstack.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/randomize_kstack.h b/include/linux/randomize_kstack.h
index fd80fab663a9..bebc911161b6 100644
--- a/include/linux/randomize_kstack.h
+++ b/include/linux/randomize_kstack.h
@@ -38,7 +38,7 @@ void *__builtin_alloca(size_t size);
 		u32 offset = raw_cpu_read(kstack_offset);		\
 		u8 *ptr = __builtin_alloca(KSTACK_OFFSET_MAX(offset));	\
 		/* Keep allocation even after "ptr" loses scope. */	\
-		asm volatile("" : "=o"(*ptr) :: "memory");		\
+		asm volatile("" :: "r"(ptr) : "memory");		\
 	}								\
 } while (0)
 
-- 
2.25.1

