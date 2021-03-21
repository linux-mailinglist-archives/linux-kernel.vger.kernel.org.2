Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4130034347D
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Mar 2021 21:03:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230437AbhCUUCn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Mar 2021 16:02:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230468AbhCUUC3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Mar 2021 16:02:29 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C7A5C061574
        for <linux-kernel@vger.kernel.org>; Sun, 21 Mar 2021 13:02:27 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id 7so8575972qka.7
        for <linux-kernel@vger.kernel.org>; Sun, 21 Mar 2021 13:02:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RD76sz/QYSKfJTtRsvrpENFDdHGiBZ2nXNgFm4rV7h8=;
        b=KP40mhHkk6Kesavlu7HyBS4iFW4BDg7QHl6n4v6/w/ZsMuGAfn2wauqAJmt+Jv+w6H
         q1APNUC8Y1y48dZ/m5f0UV3w3ZOxg/T8qQ+DfWZ1xsFdpPs78szkjkNMUBEcMLhVmOuL
         43pIrxMFYutKfxLRajF0c0agi2NiIOspfhcoP8HQiU8pfzUG+eicBqQ7OJNcpc6EVqq7
         Wj/F3nbQrq+rBjTlHlt5ivO2m1SHIgQuPHM0ZQM7bU9gZhzC9ZmQ2a9qnBKb56JyGwzI
         sb1FFbBO+RkXegvzsHH/NvXnAZ+Je4DKsrs73DTUhmhCusNOF6ZIfozWgiwz+f+b+Dxk
         V8Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RD76sz/QYSKfJTtRsvrpENFDdHGiBZ2nXNgFm4rV7h8=;
        b=ow8dxtanH1fbY7ij5/Q3rWMiVh3jNd499jGX/HJRqFa3R8RldBWdoU/WeIzxfvVOC8
         9p0Xdqi3zmzOStBq65yU9BlDHLxpEedil7GcQbG0I/Z+KSSnX26wpI4ee15uOuE/L0S0
         ShTV2tsSUDwiRjUckNsw3G3by84FDBwd5oeXqaE4he6ij6+CwjlwhpVHtftAynnMGMpR
         7YvbZxFBFJS5HtShPuEvuZp3RXQ8wWnZTwtJSivfNWm7q04lfYkUy9Azte4CWiqHd1C6
         7zvGZTL4SpFPrE3LXLzzjjFLZumLTs4vGLERWx9HwFVNoOHsPJWCyZgB5fhTi25OLcTq
         0ugg==
X-Gm-Message-State: AOAM532yg+KW0ln2COuPGQRsnWo9Mp046cIY4eHXmcOp3ItZ6yE3RvnE
        DvFYnL1kqaN5fcGsbDx+4mY=
X-Google-Smtp-Source: ABdhPJxdKYLv2Ij2xSGdzB36CeesL/L1BSzXl93DMde8hqUaicx8tCy6P2CwmsacCrIvl0ozfK15iA==
X-Received: by 2002:a37:6887:: with SMTP id d129mr8046790qkc.252.1616356946327;
        Sun, 21 Mar 2021 13:02:26 -0700 (PDT)
Received: from localhost.localdomain ([156.146.37.163])
        by smtp.gmail.com with ESMTPSA id f9sm9049902qkk.115.2021.03.21.13.02.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Mar 2021 13:02:25 -0700 (PDT)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, jroedel@suse.de, mhiramat@kernel.org,
        gustavoars@kernel.org, unixbhaskar@gmail.com,
        linux-kernel@vger.kernel.org
Cc:     rdunlap@infradead.org
Subject: [PATCH] x86/insn-eval: Few typo fixes
Date:   Mon, 22 Mar 2021 01:32:11 +0530
Message-Id: <20210321200211.487449-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


s/deterimine/determine/
s/invalild/invalid/

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 arch/x86/lib/insn-eval.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/lib/insn-eval.c b/arch/x86/lib/insn-eval.c
index bb0b3fe1e0a0..fdd9226863d3 100644
--- a/arch/x86/lib/insn-eval.c
+++ b/arch/x86/lib/insn-eval.c
@@ -232,7 +232,7 @@ static int resolve_default_seg(struct insn *insn, struct pt_regs *regs, int off)
  * resolve_seg_reg() - obtain segment register index
  * @insn:	Instruction with operands
  * @regs:	Register values as seen when entering kernel mode
- * @regoff:	Operand offset, in pt_regs, used to deterimine segment register
+ * @regoff:	Operand offset, in pt_regs, used to determine segment register
  *
  * Determine the segment register associated with the operands and, if
  * applicable, prefixes and the instruction pointed by @insn.
@@ -576,7 +576,7 @@ static int get_reg_offset_16(struct insn *insn, struct pt_regs *regs,
 	 * If ModRM.mod is 0 and ModRM.rm is 110b, then we use displacement-
 	 * only addressing. This means that no registers are involved in
 	 * computing the effective address. Thus, ensure that the first
-	 * register offset is invalild. The second register offset is already
+	 * register offset is invalid. The second register offset is already
 	 * invalid under the aforementioned conditions.
 	 */
 	if ((X86_MODRM_MOD(insn->modrm.value) == 0) &&
--
2.31.0

