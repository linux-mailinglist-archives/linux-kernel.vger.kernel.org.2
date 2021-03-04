Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 085AB32D910
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 18:55:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232130AbhCDRy5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 12:54:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239217AbhCDRo6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 12:44:58 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 016BCC0613DA
        for <linux-kernel@vger.kernel.org>; Thu,  4 Mar 2021 09:43:05 -0800 (PST)
Received: from zn.tnic (p200300ec2f0f5900f7833063514d8659.dip0.t-ipconnect.de [IPv6:2003:ec:2f0f:5900:f783:3063:514d:8659])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 987891EC051F;
        Thu,  4 Mar 2021 18:43:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1614879783;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Qinu4w6uEJbNdhFo9HNx9stpWYH8Bzubyyt4TT8WuPg=;
        b=Yr+99doup8HgKc+F2648kOq85Ju0WSPJvEpzw0v+M32xOzWHXzG23h24GCLsklC7gggFOM
        p3qjRXjgPL+s5PZV8WeUv8wqUDkSDDaqUagKuQI0d+aSeSmz0WwGFbbsDSryyfqu9wZhu2
        tnGgs1mPIy4DEpRdPsoW+xyVnmviXUE=
From:   Borislav Petkov <bp@alien8.de>
To:     X86 ML <x86@kernel.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 20/21] x86/insn: Remove kernel_insn_init()
Date:   Thu,  4 Mar 2021 18:42:36 +0100
Message-Id: <20210304174237.31945-21-bp@alien8.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210304174237.31945-1-bp@alien8.de>
References: <20210304174237.31945-1-bp@alien8.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

Now that it is not needed anymore, drop it.

Signed-off-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/include/asm/insn.h       | 11 -----------
 tools/arch/x86/include/asm/insn.h | 11 -----------
 2 files changed, 22 deletions(-)

diff --git a/arch/x86/include/asm/insn.h b/arch/x86/include/asm/insn.h
index de9fe760c1e7..5eb3753dce33 100644
--- a/arch/x86/include/asm/insn.h
+++ b/arch/x86/include/asm/insn.h
@@ -159,17 +159,6 @@ static inline void insn_get_attribute(struct insn *insn)
 /* Instruction uses RIP-relative addressing */
 extern int insn_rip_relative(struct insn *insn);
 
-/* Init insn for kernel text */
-static inline void kernel_insn_init(struct insn *insn,
-				    const void *kaddr, int buf_len)
-{
-#ifdef CONFIG_X86_64
-	insn_init(insn, kaddr, buf_len, 1);
-#else /* CONFIG_X86_32 */
-	insn_init(insn, kaddr, buf_len, 0);
-#endif
-}
-
 static inline int insn_is_avx(struct insn *insn)
 {
 	if (!insn->prefixes.got)
diff --git a/tools/arch/x86/include/asm/insn.h b/tools/arch/x86/include/asm/insn.h
index 2fe19b1a8765..5aae785003dc 100644
--- a/tools/arch/x86/include/asm/insn.h
+++ b/tools/arch/x86/include/asm/insn.h
@@ -159,17 +159,6 @@ static inline void insn_get_attribute(struct insn *insn)
 /* Instruction uses RIP-relative addressing */
 extern int insn_rip_relative(struct insn *insn);
 
-/* Init insn for kernel text */
-static inline void kernel_insn_init(struct insn *insn,
-				    const void *kaddr, int buf_len)
-{
-#ifdef CONFIG_X86_64
-	insn_init(insn, kaddr, buf_len, 1);
-#else /* CONFIG_X86_32 */
-	insn_init(insn, kaddr, buf_len, 0);
-#endif
-}
-
 static inline int insn_is_avx(struct insn *insn)
 {
 	if (!insn->prefixes.got)
-- 
2.29.2

