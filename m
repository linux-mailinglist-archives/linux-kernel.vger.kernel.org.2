Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E37732D8D4
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 18:48:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239521AbhCDRqb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 12:46:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236477AbhCDRnc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 12:43:32 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A528C061756
        for <linux-kernel@vger.kernel.org>; Thu,  4 Mar 2021 09:42:52 -0800 (PST)
Received: from zn.tnic (p200300ec2f0f5900f7833063514d8659.dip0.t-ipconnect.de [IPv6:2003:ec:2f0f:5900:f783:3063:514d:8659])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id DD3471EC04DD;
        Thu,  4 Mar 2021 18:42:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1614879770;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Y1QNspwsNROu1NmR4HfVY56lxw0ZjKMAMU06LaFh4uY=;
        b=ekeDkHsxcVRKaa5YFP7JIKyi+io31ZF/+P56ICqEpef9Ik3frC21H8ZuRrNPvwxeoXJfCH
        NmU1esP3MhTnTL9IElYURhcgKF4uGO7fAN4mfwV5MRiJ7HhqOKkkvgK4vwRpvEM2ljvP1j
        a21x7uuxZ7UdPxDrt2xEqW8Jxil92hQ=
From:   Borislav Petkov <bp@alien8.de>
To:     X86 ML <x86@kernel.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 02/21] x86/insn: Add @buf_len param to insn_init() kernel-doc comment
Date:   Thu,  4 Mar 2021 18:42:18 +0100
Message-Id: <20210304174237.31945-3-bp@alien8.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210304174237.31945-1-bp@alien8.de>
References: <20210304174237.31945-1-bp@alien8.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

It wasn't documented so add it. No functional changes.

Signed-off-by: Borislav Petkov <bp@suse.de>
Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 arch/x86/lib/insn.c       | 1 +
 tools/arch/x86/lib/insn.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/x86/lib/insn.c b/arch/x86/lib/insn.c
index 435630a6ec97..4d1640dc7882 100644
--- a/arch/x86/lib/insn.c
+++ b/arch/x86/lib/insn.c
@@ -51,6 +51,7 @@
  * insn_init() - initialize struct insn
  * @insn:	&struct insn to be initialized
  * @kaddr:	address (in kernel memory) of instruction (or copy thereof)
+ * @buf_len:	length of the insn buffer at @kaddr
  * @x86_64:	!0 for 64-bit kernel or 64-bit app
  */
 void insn_init(struct insn *insn, const void *kaddr, int buf_len, int x86_64)
diff --git a/tools/arch/x86/lib/insn.c b/tools/arch/x86/lib/insn.c
index 3d9355ed1246..31afbf0a75f7 100644
--- a/tools/arch/x86/lib/insn.c
+++ b/tools/arch/x86/lib/insn.c
@@ -51,6 +51,7 @@
  * insn_init() - initialize struct insn
  * @insn:	&struct insn to be initialized
  * @kaddr:	address (in kernel memory) of instruction (or copy thereof)
+ * @buf_len:	length of the insn buffer at @kaddr
  * @x86_64:	!0 for 64-bit kernel or 64-bit app
  */
 void insn_init(struct insn *insn, const void *kaddr, int buf_len, int x86_64)
-- 
2.29.2

