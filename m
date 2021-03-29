Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A681D34D9EF
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 00:13:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231636AbhC2WMn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 18:12:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231623AbhC2WMQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 18:12:16 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58154C061762
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 15:12:16 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id 17so1685214qtt.11
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 15:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=ekCF2vvcLsdB3w/7DhoYThMPMaRHrvLWv1Vl8Jy7w1I=;
        b=m6mRmHasW2CUfIqjeOLJjTmqe7jpWbLqCpMyS4UjSz15CBgj3Z/6MIX6P2SGCPN+2a
         uOjKHQKXIpb9v6UTTw1sZFoY2R8DFJwdxWSDqKqvPzhqPjwKx+LvddeI6FGcPMgNpviZ
         0aHtQOZCODLTgy3WBSfrulpkw2jqkYOoUwXqFLYxjI0d6z/+4U9IAtgfjTPLuAlrOG8W
         4yBMM44hCZ/n686/A99TA8pQhgsmjDBitZs6otjZTWUSTjMXioLXG3/8+iQl5JlEpsco
         qYHtk8upMZGcNypAk1Zr8v8tgn0jg/ZfaC9Te5J/m3KVvxOQ3qY0+WGGvdL8U/2Hwz1L
         gODA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=ekCF2vvcLsdB3w/7DhoYThMPMaRHrvLWv1Vl8Jy7w1I=;
        b=rM5mDNNxLkKErLKPtdmlRqgK25N0nqImaDfQHTlj18QwzCFSDpRJJIb594wlSKk+uq
         8nCfEXS4BShy1t4lVk6Om+ySO8Ub0sqRiUdNwenGUiClOpciKk16SBr3TIuRLuaIkx4V
         I6N23F4nkWtiXmFNaFf/amy3qwpQocInQ6mwdN9FrCwJlxPLfk8DyVTWJZQaWuwoJMyr
         l9HWXK8/pH4B3MUQyLCMI3t9tR7e+vHlh5BFTpvp8LX5UiYMmcHSlDbEqmJsTUY/YtkB
         SaAcW1qtseBzeXkKe3+QBgXRa9HK8aTMP+AKcpMhnsCGuZeQKlFT/K/rwU9uAVOqj/BK
         4RYw==
X-Gm-Message-State: AOAM533vsnz01o7vgEozGyVhOY+Si9+XBrp9ERzNf796vvp2Eo/A/4VM
        /u/tpAJZLJOWHsREZIgWCbgmTTyh13qsniTbr6A=
X-Google-Smtp-Source: ABdhPJxlrxFWJ1uH4w6BOY1fugaPfBLFs2slmCsH1utiMKigXAVV6bzviq0qukxiy7S7XN0ThzH7Pi3yiwSdrFEBD6E=
X-Received: from ndesaulniers1.mtv.corp.google.com ([2620:15c:211:202:c959:2751:3fb4:47b1])
 (user=ndesaulniers job=sendgmr) by 2002:a05:6214:204:: with SMTP id
 i4mr27848771qvt.47.1617055935550; Mon, 29 Mar 2021 15:12:15 -0700 (PDT)
Date:   Mon, 29 Mar 2021 15:12:06 -0700
Message-Id: <20210329221209.1718079-1-ndesaulniers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.31.0.291.g576ba9dcdaf-goog
Subject: [PATCH v2] ARM: kprobes: test-thumb: fix for LLVM_IAS=1
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     Russell King <linux@armlinux.org.uk>
Cc:     Ard Biesheuvel <ardb@kernel.org>, Arnd Bergmann <arnd@kernel.org>,
        David Spickett <david.spickett@linaro.org>,
        Stephen Hines <srhines@google.com>,
        Jian Cai <jiancai@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's a few instructions that GAS infers operands but Clang doesn't;
from what I can tell the Arm ARM doesn't say these are optional.

F5.1.257 TBB, TBH T1 Halfword variant
F5.1.238 STREXD T1 variant
F5.1.84 LDREXD T1 variant

Link: https://github.com/ClangBuiltLinux/linux/issues/1309
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
See:
https://lore.kernel.org/linux-arm-kernel/CAMj1kXE5uw4+zV3JVpfA2drOD5TZVMs5a_E5wrrnzjEYc=E_fA@mail.gmail.com/
for what I'd consider V1. The previous issues with .w suffixes have been
fixed or have fixes pending in LLVM:
* BL+DBG:   https://reviews.llvm.org/D97236
* ORN/ORNS: https://reviews.llvm.org/D99538
* RSB/RSBS: https://reviews.llvm.org/D99542
I'd have expected the Arm ARM to use curly braces to denote optional
operands (see also "F5.1.167 RSB, RSBS (register)" for an example).

 arch/arm/probes/kprobes/test-thumb.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/probes/kprobes/test-thumb.c b/arch/arm/probes/kprobes/test-thumb.c
index 456c181a7bfe..4e11f0b760f8 100644
--- a/arch/arm/probes/kprobes/test-thumb.c
+++ b/arch/arm/probes/kprobes/test-thumb.c
@@ -441,21 +441,21 @@ void kprobe_thumb32_test_cases(void)
 		"3:	mvn	r0, r0	\n\t"
 		"2:	nop		\n\t")
 
-	TEST_RX("tbh	[pc, r",7, (9f-(1f+4))>>1,"]",
+	TEST_RX("tbh	[pc, r",7, (9f-(1f+4))>>1,", lsl #1]",
 		"9:			\n\t"
 		".short	(2f-1b-4)>>1	\n\t"
 		".short	(3f-1b-4)>>1	\n\t"
 		"3:	mvn	r0, r0	\n\t"
 		"2:	nop		\n\t")
 
-	TEST_RX("tbh	[pc, r",12, ((9f-(1f+4))>>1)+1,"]",
+	TEST_RX("tbh	[pc, r",12, ((9f-(1f+4))>>1)+1,", lsl #1]",
 		"9:			\n\t"
 		".short	(2f-1b-4)>>1	\n\t"
 		".short	(3f-1b-4)>>1	\n\t"
 		"3:	mvn	r0, r0	\n\t"
 		"2:	nop		\n\t")
 
-	TEST_RRX("tbh	[r",1,9f, ", r",14,1,"]",
+	TEST_RRX("tbh	[r",1,9f, ", r",14,1,", lsl #1]",
 		"9:			\n\t"
 		".short	(2f-1b-4)>>1	\n\t"
 		".short	(3f-1b-4)>>1	\n\t"
@@ -468,10 +468,10 @@ void kprobe_thumb32_test_cases(void)
 
 	TEST_UNSUPPORTED("strexb	r0, r1, [r2]")
 	TEST_UNSUPPORTED("strexh	r0, r1, [r2]")
-	TEST_UNSUPPORTED("strexd	r0, r1, [r2]")
+	TEST_UNSUPPORTED("strexd	r0, r1, r2, [r2]")
 	TEST_UNSUPPORTED("ldrexb	r0, [r1]")
 	TEST_UNSUPPORTED("ldrexh	r0, [r1]")
-	TEST_UNSUPPORTED("ldrexd	r0, [r1]")
+	TEST_UNSUPPORTED("ldrexd	r0, r1, [r1]")
 
 	TEST_GROUP("Data-processing (shifted register) and (modified immediate)")
 
-- 
2.31.0.291.g576ba9dcdaf-goog

