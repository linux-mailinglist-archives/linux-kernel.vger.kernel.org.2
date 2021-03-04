Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DBDF32D8E0
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 18:48:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239830AbhCDRqq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 12:46:46 -0500
Received: from mail.skyhub.de ([5.9.137.197]:39964 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237721AbhCDRnk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 12:43:40 -0500
Received: from zn.tnic (p200300ec2f0f5900f7833063514d8659.dip0.t-ipconnect.de [IPv6:2003:ec:2f0f:5900:f783:3063:514d:8659])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 284911EC04E2;
        Thu,  4 Mar 2021 18:42:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1614879779;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HlTQtjLkQOp4Sk4iaNF99pKQ6RkZ8oDYoRuc68J/LaY=;
        b=fVEqoXpC+uOQvQeMHZkDt+c+BUSjg5daGS015pkfrpy7vDUkRFHC3OmGMLUDak/Up8KPS3
        ze0jvUuA0zlwyst0/19gcB9Dj9DF9u02zEImdXoplXCpFPHhXnwMw68Y9LnnaeGbJ9iuro
        RTXSztNCbrgqEr6B4YdI7Vn/TVSUCKo=
From:   Borislav Petkov <bp@alien8.de>
To:     X86 ML <x86@kernel.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 14/21] x86/traps: Convert to insn_decode()
Date:   Thu,  4 Mar 2021 18:42:30 +0100
Message-Id: <20210304174237.31945-15-bp@alien8.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210304174237.31945-1-bp@alien8.de>
References: <20210304174237.31945-1-bp@alien8.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

Simplify code, no functional changes.

Signed-off-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/kernel/traps.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index 7f5aec758f0e..c2a08c4c1872 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -498,14 +498,15 @@ static enum kernel_gp_hint get_kernel_gp_address(struct pt_regs *regs,
 {
 	u8 insn_buf[MAX_INSN_SIZE];
 	struct insn insn;
+	int ret;
 
 	if (copy_from_kernel_nofault(insn_buf, (void *)regs->ip,
 			MAX_INSN_SIZE))
 		return GP_NO_HINT;
 
-	kernel_insn_init(&insn, insn_buf, MAX_INSN_SIZE);
-	insn_get_modrm(&insn);
-	insn_get_sib(&insn);
+	ret = insn_decode(&insn, insn_buf, MAX_INSN_SIZE, INSN_MODE_KERN);
+	if (ret < 0)
+		return GP_NO_HINT;
 
 	*addr = (unsigned long)insn_get_addr_ref(&insn, regs);
 	if (*addr == -1UL)
-- 
2.29.2

