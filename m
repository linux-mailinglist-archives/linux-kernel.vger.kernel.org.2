Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8CBC397ABC
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 21:37:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234692AbhFATjP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 15:39:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233397AbhFATjO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 15:39:14 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1776FC061574
        for <linux-kernel@vger.kernel.org>; Tue,  1 Jun 2021 12:37:31 -0700 (PDT)
Received: from zn.tnic (p200300ec2f111d0004f27110e64a0196.dip0.t-ipconnect.de [IPv6:2003:ec:2f11:1d00:4f2:7110:e64a:196])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 6244E1EC0288;
        Tue,  1 Jun 2021 21:37:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1622576249;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:in-reply-to:
         references; bh=QLE59ztlSD3m3tdl+QNVMlCX7UcfaxmeXe+Z2kA73qw=;
        b=KqkeHm93BmfiFbUCZpRtHRzIDlKG2YfpkJ+ApPSJUYQsDuSm40cezy6JQ9N3XSR8Qwj65p
        rkVpzT5Qs3HG5w1Z7CKo8DjyvX4qm+aipYMwFj14B4pagS17PHRwt+enqse45VVTm876Gn
        u62o2/xhGMIm2M4aCwGgtaL/prRoAp0=
From:   Borislav Petkov <bp@alien8.de>
To:     X86 ML <x86@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] x86/alternative: Align insn bytes vertically
Date:   Tue,  1 Jun 2021 21:37:13 +0200
Message-Id: <20210601193713.16190-1-bp@alien8.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

For easier inspection which bytes have changed.

For example:

  feat: 7*32+12, old: (__x86_indirect_thunk_r10+0x0/0x20 (ffffffff81c02480) len: 17), repl: (ffffffff897813aa, len: 17)
  ffffffff81c02480:   old_insn: 41 ff e2 90 90 90 90 90 90 90 90 90 90 90 90 90 90
  ffffffff897813aa:   rpl_insn: e8 07 00 00 00 f3 90 0f ae e8 eb f9 4c 89 14 24 c3
  ffffffff81c02480: final_insn: e8 07 00 00 00 f3 90 0f ae e8 eb f9 4c 89 14 24 c3

No functional changes.

Signed-off-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/kernel/alternative.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 75c752b0628c..227c4a8b145a 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -273,8 +273,8 @@ void __init_or_module noinline apply_alternatives(struct alt_instr *start,
 			instr, instr, a->instrlen,
 			replacement, a->replacementlen);
 
-		DUMP_BYTES(instr, a->instrlen, "%px: old_insn: ", instr);
-		DUMP_BYTES(replacement, a->replacementlen, "%px: rpl_insn: ", replacement);
+		DUMP_BYTES(instr, a->instrlen, "%px:   old_insn: ", instr);
+		DUMP_BYTES(replacement, a->replacementlen, "%px:   rpl_insn: ", replacement);
 
 		memcpy(insn_buff, replacement, a->replacementlen);
 		insn_buff_sz = a->replacementlen;
-- 
2.29.2

