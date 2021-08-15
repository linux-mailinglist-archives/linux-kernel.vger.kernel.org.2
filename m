Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F8BC3EC657
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Aug 2021 02:47:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234094AbhHOAmt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Aug 2021 20:42:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:50510 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229453AbhHOAms (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Aug 2021 20:42:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C89E86056B;
        Sun, 15 Aug 2021 00:42:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628988138;
        bh=sRitVagrSOQOLeZWVuZNEoAqco8LEpwtTTPQ1teklNg=;
        h=From:To:Cc:Subject:Date:From;
        b=mP4HGWGV3pRQlnYQcS2dIqTUEDAekGCAqmU063X+NDYUlUx72vHhBvZ6biw1oINva
         ElDttu/dLjzGdz0YU3MTQ3Gds7dXmCKrq8glWRBfN8kVjE5bIXYQY9wZgabusFYUDd
         oA4pg0hW1ttWqX/eCPOZYIrJ8lGzeFK2rJ1psLMttlCY8nEzJ7FxYavCix6asF5FU1
         dehc9mT/rrHWxu6S+UrdAPDJ8+ueBktwhgeCILjffxm6d7+YLvw2IYUHrYLW1jP8cS
         sRKFo9YhE6iDkyueKkjt9syqEDtPpHjjigpAoG7QyqyXF+eKPrzJB+pH4CT9aePG+F
         nH8iowlX+Z1IQ==
From:   Nathan Chancellor <nathan@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH] lib/zstd: Fix bitwise vs logical operators
Date:   Sat, 14 Aug 2021 17:41:54 -0700
Message-Id: <20210815004154.1781834-1-nathan@kernel.org>
X-Mailer: git-send-email 2.33.0.rc2
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

clang warns several times along the lines of:

lib/zstd/compress.c:1043:7: warning: bitwise and of boolean expressions; did you mean logical and? [-Wbool-operation-and]
                if ((offset_1 > 0) & (ZSTD_read32(ip + 1 - offset_1) == ZSTD_read32(ip + 1))) {
                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
                                   &&

Bitwise ANDs do not short circuit, meaning that the ZSTD_read32 calls
will be evaluated even if the first condition is not true. This is not
always a problem but it is not a standard way to do conditionals so
replace the bitwise ANDs with logical ones to fix the warning and make
the code clearer.

Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 lib/zstd/compress.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/lib/zstd/compress.c b/lib/zstd/compress.c
index b080264ed3ad..0e515d1d4237 100644
--- a/lib/zstd/compress.c
+++ b/lib/zstd/compress.c
@@ -1040,7 +1040,7 @@ void ZSTD_compressBlock_fast_generic(ZSTD_CCtx *cctx, const void *src, size_t sr
 		const BYTE *match = base + matchIndex;
 		hashTable[h] = curr; /* update hash table */
 
-		if ((offset_1 > 0) & (ZSTD_read32(ip + 1 - offset_1) == ZSTD_read32(ip + 1))) {
+		if ((offset_1 > 0) && (ZSTD_read32(ip + 1 - offset_1) == ZSTD_read32(ip + 1))) {
 			mLength = ZSTD_count(ip + 1 + 4, ip + 1 + 4 - offset_1, iend) + 4;
 			ip++;
 			ZSTD_storeSeq(seqStorePtr, ip - anchor, anchor, 0, mLength - MINMATCH);
@@ -1072,7 +1072,7 @@ void ZSTD_compressBlock_fast_generic(ZSTD_CCtx *cctx, const void *src, size_t sr
 			hashTable[ZSTD_hashPtr(base + curr + 2, hBits, mls)] = curr + 2; /* here because curr+2 could be > iend-8 */
 			hashTable[ZSTD_hashPtr(ip - 2, hBits, mls)] = (U32)(ip - 2 - base);
 			/* check immediate repcode */
-			while ((ip <= ilimit) && ((offset_2 > 0) & (ZSTD_read32(ip) == ZSTD_read32(ip - offset_2)))) {
+			while ((ip <= ilimit) && ((offset_2 > 0) && (ZSTD_read32(ip) == ZSTD_read32(ip - offset_2)))) {
 				/* store sequence */
 				size_t const rLength = ZSTD_count(ip + 4, ip + 4 - offset_2, iend) + 4;
 				{
@@ -1291,7 +1291,7 @@ void ZSTD_compressBlock_doubleFast_generic(ZSTD_CCtx *cctx, const void *src, siz
 		const BYTE *match = base + matchIndexS;
 		hashLong[h2] = hashSmall[h] = curr; /* update hash tables */
 
-		if ((offset_1 > 0) & (ZSTD_read32(ip + 1 - offset_1) == ZSTD_read32(ip + 1))) { /* note : by construction, offset_1 <= curr */
+		if ((offset_1 > 0) && (ZSTD_read32(ip + 1 - offset_1) == ZSTD_read32(ip + 1))) { /* note : by construction, offset_1 <= curr */
 			mLength = ZSTD_count(ip + 1 + 4, ip + 1 + 4 - offset_1, iend) + 4;
 			ip++;
 			ZSTD_storeSeq(seqStorePtr, ip - anchor, anchor, 0, mLength - MINMATCH);
@@ -1350,7 +1350,7 @@ void ZSTD_compressBlock_doubleFast_generic(ZSTD_CCtx *cctx, const void *src, siz
 			hashLong[ZSTD_hashPtr(ip - 2, hBitsL, 8)] = hashSmall[ZSTD_hashPtr(ip - 2, hBitsS, mls)] = (U32)(ip - 2 - base);
 
 			/* check immediate repcode */
-			while ((ip <= ilimit) && ((offset_2 > 0) & (ZSTD_read32(ip) == ZSTD_read32(ip - offset_2)))) {
+			while ((ip <= ilimit) && ((offset_2 > 0) && (ZSTD_read32(ip) == ZSTD_read32(ip - offset_2)))) {
 				/* store sequence */
 				size_t const rLength = ZSTD_count(ip + 4, ip + 4 - offset_2, iend) + 4;
 				{
@@ -1929,7 +1929,7 @@ void ZSTD_compressBlock_lazy_generic(ZSTD_CCtx *ctx, const void *src, size_t src
 		const BYTE *start = ip + 1;
 
 		/* check repCode */
-		if ((offset_1 > 0) & (ZSTD_read32(ip + 1) == ZSTD_read32(ip + 1 - offset_1))) {
+		if ((offset_1 > 0) && (ZSTD_read32(ip + 1) == ZSTD_read32(ip + 1 - offset_1))) {
 			/* repcode : we take it */
 			matchLength = ZSTD_count(ip + 1 + EQUAL_READ32, ip + 1 + EQUAL_READ32 - offset_1, iend) + EQUAL_READ32;
 			if (depth == 0)
@@ -1953,7 +1953,7 @@ void ZSTD_compressBlock_lazy_generic(ZSTD_CCtx *ctx, const void *src, size_t src
 		if (depth >= 1)
 			while (ip < ilimit) {
 				ip++;
-				if ((offset) && ((offset_1 > 0) & (ZSTD_read32(ip) == ZSTD_read32(ip - offset_1)))) {
+				if ((offset) && ((offset_1 > 0) && (ZSTD_read32(ip) == ZSTD_read32(ip - offset_1)))) {
 					size_t const mlRep = ZSTD_count(ip + EQUAL_READ32, ip + EQUAL_READ32 - offset_1, iend) + EQUAL_READ32;
 					int const gain2 = (int)(mlRep * 3);
 					int const gain1 = (int)(matchLength * 3 - ZSTD_highbit32((U32)offset + 1) + 1);
@@ -1974,7 +1974,7 @@ void ZSTD_compressBlock_lazy_generic(ZSTD_CCtx *ctx, const void *src, size_t src
 				/* let's find an even better one */
 				if ((depth == 2) && (ip < ilimit)) {
 					ip++;
-					if ((offset) && ((offset_1 > 0) & (ZSTD_read32(ip) == ZSTD_read32(ip - offset_1)))) {
+					if ((offset) && ((offset_1 > 0) && (ZSTD_read32(ip) == ZSTD_read32(ip - offset_1)))) {
 						size_t const ml2 = ZSTD_count(ip + EQUAL_READ32, ip + EQUAL_READ32 - offset_1, iend) + EQUAL_READ32;
 						int const gain2 = (int)(ml2 * 4);
 						int const gain1 = (int)(matchLength * 4 - ZSTD_highbit32((U32)offset + 1) + 1);
@@ -2021,7 +2021,7 @@ void ZSTD_compressBlock_lazy_generic(ZSTD_CCtx *ctx, const void *src, size_t src
 		}
 
 		/* check immediate repcode */
-		while ((ip <= ilimit) && ((offset_2 > 0) & (ZSTD_read32(ip) == ZSTD_read32(ip - offset_2)))) {
+		while ((ip <= ilimit) && ((offset_2 > 0) && (ZSTD_read32(ip) == ZSTD_read32(ip - offset_2)))) {
 			/* store sequence */
 			matchLength = ZSTD_count(ip + EQUAL_READ32, ip + EQUAL_READ32 - offset_2, iend) + EQUAL_READ32;
 			offset = offset_2;

base-commit: ba31f97d43be41ca99ab72a6131d7c226306865f
-- 
2.33.0.rc2

