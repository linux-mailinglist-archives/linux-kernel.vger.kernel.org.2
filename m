Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B92AE323AFE
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 12:05:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232849AbhBXLFD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 06:05:03 -0500
Received: from mail.skyhub.de ([5.9.137.197]:39632 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234960AbhBXLDU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 06:03:20 -0500
Received: from zn.tnic (p200300ec2f0d180081510bd8ee909965.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:1800:8151:bd8:ee90:9965])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 693E21EC059F;
        Wed, 24 Feb 2021 12:02:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1614164557;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wikZYikTmGpOcT13/Sy9Nbwhz8ex6iPLRUjiRHkn0a0=;
        b=Tg9EH5rAgcdZ+7Rd/yXnfboOwd+O/xxarrpHW3J6jd0vAltg6YJEzjRQpYaKgjwhZoKlxQ
        NXjOh16YNKENm9lclyj7DtH3MxZuWULl/nf6ivWHBKue3gXGp6VicFuEIJ2W7japwdvINp
        k/bhIxbKik4EkjumdGbIc0ZH2fFrBeE=
From:   Borislav Petkov <bp@alien8.de>
To:     X86 ML <x86@kernel.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 02/21] x86/insn: Add @buf_len param to insn_init() kernel-doc comment
Date:   Wed, 24 Feb 2021 12:02:14 +0100
Message-Id: <20210224110233.19715-3-bp@alien8.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210224110233.19715-1-bp@alien8.de>
References: <20210224110233.19715-1-bp@alien8.de>
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
index 404279563891..1ba994862b56 100644
--- a/arch/x86/lib/insn.c
+++ b/arch/x86/lib/insn.c
@@ -37,6 +37,7 @@
  * insn_init() - initialize struct insn
  * @insn:	&struct insn to be initialized
  * @kaddr:	address (in kernel memory) of instruction (or copy thereof)
+ * @buf_len:	length of the insn buffer at @kaddr
  * @x86_64:	!0 for 64-bit kernel or 64-bit app
  */
 void insn_init(struct insn *insn, const void *kaddr, int buf_len, int x86_64)
diff --git a/tools/arch/x86/lib/insn.c b/tools/arch/x86/lib/insn.c
index 0151dfc6da61..f3277d6e4ef2 100644
--- a/tools/arch/x86/lib/insn.c
+++ b/tools/arch/x86/lib/insn.c
@@ -37,6 +37,7 @@
  * insn_init() - initialize struct insn
  * @insn:	&struct insn to be initialized
  * @kaddr:	address (in kernel memory) of instruction (or copy thereof)
+ * @buf_len:	length of the insn buffer at @kaddr
  * @x86_64:	!0 for 64-bit kernel or 64-bit app
  */
 void insn_init(struct insn *insn, const void *kaddr, int buf_len, int x86_64)
-- 
2.29.2

