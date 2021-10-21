Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F9C7436C05
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 22:24:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231948AbhJUU02 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 16:26:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:51302 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231887AbhJUU0V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 16:26:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E774160E8B;
        Thu, 21 Oct 2021 20:24:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634847844;
        bh=jg39CC34qCaGNNBh/BEjvI4xMifdkAP0+LmruQqx7iM=;
        h=From:To:Cc:Subject:Date:From;
        b=rj/1E0IGzxMpU1MhVc+iZ6ua4g06JARLJjbgWZ3SBbmlzbrr5ou0xz1+RlBWk0j6h
         uHEgFo5Hz/9cpxmbS6yiYSgOnXSDa0cyEUhSdSaI2byUuFk2y6/LItmiraYlkdzHjw
         aFhOk2e6tgI/9WBgpR18RLoe9IHYhca8l5mu0f0m50VCBuXiOYsrSq+xHCwwk84Zyo
         WFOhNtqoO0UwlDJ1jZYCsdXT1CrAUwnx+vRv2Vjp3U4h0lHP8x5wMVnOPc94Kf/RAO
         FjqT7DyXy3J2iJNMRLBOhLuluPNJTgNxUc3UfgE84Y2bX19cBEHiroF4gsUGbWN2mQ
         WqbpVFPCWazEA==
From:   Nathan Chancellor <nathan@kernel.org>
To:     Nick Terrell <terrelln@fb.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH] lib: zstd: Add cast to silence clang's -Wbitwise-instead-of-logical
Date:   Thu, 21 Oct 2021 13:23:53 -0700
Message-Id: <20211021202353.2356400-1-nathan@kernel.org>
X-Mailer: git-send-email 2.33.1.637.gf443b226ca
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A new warning in clang warns that there is an instance where boolean
expressions are being used with bitwise operators instead of logical
ones:

lib/zstd/decompress/huf_decompress.c:890:25: warning: use of bitwise '&' with boolean operands [-Wbitwise-instead-of-logical]
                        (BIT_reloadDStreamFast(&bitD1) == BIT_DStream_unfinished)
                        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

zstd does this frequently to help with performance, as logical operators
have branches whereas bitwise ones do not.

To fix this warning in other cases, the expressions were placed on
separate lines with the '&=' operator; however, this particular instance
was moved away from that so that it could be surrounded by LIKELY, which
is a macro for __builtin_expect(), to help with a performance
regression, according to upstream zstd pull #1973.

Aside from switching to logical operators, which is likely undesirable
in this instance, or disabling the warning outright, the solution is
casting one of the expressions to an integer type to make it clear to
clang that the author knows what they are doing. Add a cast to U32 to
silence the warning. The first U32 cast is to silence an instance of
-Wshorten-64-to-32 because __builtin_expect() returns long so it cannot
be moved.

Link: https://github.com/ClangBuiltLinux/linux/issues/1486
Link: https://github.com/facebook/zstd/pull/1973
Reported-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 lib/zstd/decompress/huf_decompress.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/zstd/decompress/huf_decompress.c b/lib/zstd/decompress/huf_decompress.c
index 05570ed5f8be..5105e59ac04a 100644
--- a/lib/zstd/decompress/huf_decompress.c
+++ b/lib/zstd/decompress/huf_decompress.c
@@ -886,7 +886,7 @@ HUF_decompress4X2_usingDTable_internal_body(
             HUF_DECODE_SYMBOLX2_0(op2, &bitD2);
             HUF_DECODE_SYMBOLX2_0(op3, &bitD3);
             HUF_DECODE_SYMBOLX2_0(op4, &bitD4);
-            endSignal = (U32)LIKELY(
+            endSignal = (U32)LIKELY((U32)
                         (BIT_reloadDStreamFast(&bitD1) == BIT_DStream_unfinished)
                       & (BIT_reloadDStreamFast(&bitD2) == BIT_DStream_unfinished)
                       & (BIT_reloadDStreamFast(&bitD3) == BIT_DStream_unfinished)
-- 
2.33.1.637.gf443b226ca

