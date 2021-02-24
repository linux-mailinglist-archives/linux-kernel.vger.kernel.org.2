Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBD6B323B0C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 12:10:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234973AbhBXLIx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 06:08:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234975AbhBXLDX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 06:03:23 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A564FC06178A
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 03:02:43 -0800 (PST)
Received: from zn.tnic (p200300ec2f0d180081510bd8ee909965.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:1800:8151:bd8:ee90:9965])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 370C31EC05AB;
        Wed, 24 Feb 2021 12:02:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1614164562;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1qetDyOjsEQm7aDzBgrlUSKoFCFT+6v1j0Cc3oFxGeY=;
        b=j8bmovho6EtkyVVSiqkUT+Tb8/++M0OvfYrvQAlwjpRwtzYxqUdFV7mEJrlK7gkmyIrzgA
        sqrPZ8BQ4qiL4txjlBHjGhmpsLeSYihSAQ0+11MWhkoYX5/GWDjrJYDZVAgGuYcT9YXV0e
        OkWlqRw/jyHP6DcErQ2kyWr6WU8LwDM=
From:   Borislav Petkov <bp@alien8.de>
To:     X86 ML <x86@kernel.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 08/21] perf/x86/intel/ds: Check return values of insn decoder functions
Date:   Wed, 24 Feb 2021 12:02:20 +0100
Message-Id: <20210224110233.19715-9-bp@alien8.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210224110233.19715-1-bp@alien8.de>
References: <20210224110233.19715-1-bp@alien8.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

branch_type() doesn't need to call the full insn_decode() because it
doesn't need it in all cases thus leave the calls separate.

Signed-off-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/events/intel/lbr.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
index 21890dacfcfe..9ecf5028fb8f 100644
--- a/arch/x86/events/intel/lbr.c
+++ b/arch/x86/events/intel/lbr.c
@@ -1224,8 +1224,7 @@ static int branch_type(unsigned long from, unsigned long to, int abort)
 	is64 = kernel_ip((unsigned long)addr) || any_64bit_mode(current_pt_regs());
 #endif
 	insn_init(&insn, addr, bytes_read, is64);
-	insn_get_opcode(&insn);
-	if (!insn.opcode.got)
+	if (insn_get_opcode(&insn))
 		return X86_BR_ABORT;
 
 	switch (insn.opcode.bytes[0]) {
@@ -1262,8 +1261,7 @@ static int branch_type(unsigned long from, unsigned long to, int abort)
 		ret = X86_BR_INT;
 		break;
 	case 0xe8: /* call near rel */
-		insn_get_immediate(&insn);
-		if (insn.immediate1.value == 0) {
+		if (insn_get_immediate(&insn) || insn.immediate1.value == 0) {
 			/* zero length call */
 			ret = X86_BR_ZERO_CALL;
 			break;
@@ -1279,7 +1277,9 @@ static int branch_type(unsigned long from, unsigned long to, int abort)
 		ret = X86_BR_JMP;
 		break;
 	case 0xff: /* call near absolute, call far absolute ind */
-		insn_get_modrm(&insn);
+		if (insn_get_modrm(&insn))
+			return X86_BR_ABORT;
+
 		ext = (insn.modrm.bytes[0] >> 3) & 0x7;
 		switch (ext) {
 		case 2: /* near ind call */
-- 
2.29.2

