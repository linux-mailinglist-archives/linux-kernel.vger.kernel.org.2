Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F58A42B288
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 04:10:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235881AbhJMCMw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 22:12:52 -0400
Received: from conuserg-07.nifty.com ([210.131.2.74]:49072 "EHLO
        conuserg-07.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233544AbhJMCMv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 22:12:51 -0400
Received: from grover.RMN.KIBA.LAB.jp (133-32-232-101.west.xps.vectant.ne.jp [133.32.232.101]) (authenticated)
        by conuserg-07.nifty.com with ESMTP id 19D2AEKs008227;
        Wed, 13 Oct 2021 11:10:14 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com 19D2AEKs008227
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1634091014;
        bh=NnqRPPmxgq5KL4hmkA1y1jPB/DX/21Dq6SgXKAzloFU=;
        h=From:To:Cc:Subject:Date:From;
        b=Q1TaQHe6ntdzO9WUGf3Z5bibbnF33W9hBW52+8VnoaF1Tht1iXZ/Q4Ta34DkIOCtM
         glgHAJcgsc81acwpHoIxJWYXSFA9xZ3N1YcCOWVrskTRQQxK0kb5Pm/DmIspYgBiyx
         H9FANawR7Wb67wnwLSBaV7y7ib6dO4HboEFZZ8goPTNhxUXEInuS/d9uyZUoOKB5yQ
         4avSxOXuMS/16XUSazZ0xNaWggxG63HQQT4utBUI8gtGPM3ztxWL3ae+Qyh1NJPLP5
         sYVLWtlsQgGcngi4pOQxpmTafjUPIe5/hqi8GxIC66QQRrI0iU+62PHudW+HkVn01K
         CshaUKAJQM6EA==
X-Nifty-SrcIP: [133.32.232.101]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kernel@vger.kernel.org, Nick Hu <nickhu@andestech.com>,
        Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH] nds32: remove unused BUILTIN_DTB from arch/nds32/Makefile
Date:   Wed, 13 Oct 2021 02:10:11 +0000
Message-Id: <20211013021011.515750-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is not used or exported.

BUILTIN_DTB is locally defined and used in arch/nds32/boot/dts/Makefile.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 arch/nds32/Makefile | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/nds32/Makefile b/arch/nds32/Makefile
index c17fc3a755c3..ee26e4df2fd0 100644
--- a/arch/nds32/Makefile
+++ b/arch/nds32/Makefile
@@ -31,12 +31,6 @@ core-y				+= arch/nds32/kernel/ arch/nds32/mm/
 core-$(CONFIG_FPU)              += arch/nds32/math-emu/
 libs-y				+= arch/nds32/lib/
 
-ifneq '$(CONFIG_NDS32_BUILTIN_DTB)' '""'
-BUILTIN_DTB := y
-else
-BUILTIN_DTB := n
-endif
-
 ifdef CONFIG_CPU_LITTLE_ENDIAN
 KBUILD_CFLAGS   += $(call cc-option, -EL)
 KBUILD_AFLAGS   += $(call cc-option, -EL)
-- 
2.30.2

