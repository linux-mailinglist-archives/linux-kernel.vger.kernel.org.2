Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77F063A6C22
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 18:40:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235220AbhFNQl6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 12:41:58 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56216 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234934AbhFNQke (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 12:40:34 -0400
Message-Id: <20210614155357.455857263@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1623688710;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=k6/81Nf+e6pRycJkI5KcFdhXFlJ0ri3uWt/suup+NPo=;
        b=JtDXoOxeupOXJOMa9U97XUAwtV6zI7giNJfz0y3yl6u6TN1eJrqDC6GFAONedGeWTUf5Qk
        5WHrZXGJbQcKu5b3g1KUxaQk3kTegSBQqx+6ckua4rUmXC/XiOdC7GBlTeGh2sQCfs2M61
        Fsg/62SfjjWBE6SgLKt3u6QAjtWa0y5wkaM4DTmGPZ/U9DSoHmfA5uQuYGhzRf+rEWyfkz
        OdtTziWuKtlGd+LNhR5UTTx5PZxu1GpGX/VwiEKY6NBsHKZ0C/kn8/w+Qn7TLs5y+5j8yM
        3RU0KC1aN+J5Gs68QN92KBHJxFlwltPHxLj3uu07WCc2yrdrnZomG84EShB2Sw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1623688710;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=k6/81Nf+e6pRycJkI5KcFdhXFlJ0ri3uWt/suup+NPo=;
        b=06dGySKHYl2RzUpWRIKBSPt7rfb2tvm9Kt85VjMcN7cRwl2UE0Jbm5DSLYqIT8pLGO/pb5
        jCWT26pMmfkisIAQ==
Date:   Mon, 14 Jun 2021 17:44:45 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Borislav Petkov <bp@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [patch V2 37/52] x86/pkru: Provide pkru_write_default()
References: <20210614154408.673478623@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provide a simple and trivial helper which just writes the PKRU default
value without trying to fiddle with the tasks xsave buffer.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/include/asm/pkru.h |    8 ++++++++
 1 file changed, 8 insertions(+)

--- a/arch/x86/include/asm/pkru.h
+++ b/arch/x86/include/asm/pkru.h
@@ -60,4 +60,12 @@ static inline void write_pkru(u32 pkru)
 	fpregs_unlock();
 }
 
+static inline void pkru_write_default(void)
+{
+	if (!cpu_feature_enabled(X86_FEATURE_OSPKE))
+		return;
+
+	wrpkru(pkru_get_init_value());
+}
+
 #endif

