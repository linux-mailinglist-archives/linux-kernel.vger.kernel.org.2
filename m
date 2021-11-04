Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5843445583
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Nov 2021 15:41:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231725AbhKDOnt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 10:43:49 -0400
Received: from mail.skyhub.de ([5.9.137.197]:49234 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231426AbhKDOnc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 10:43:32 -0400
Received: from zn.tnic (p200300ec2f0f2b00bdd517953c60a78f.dip0.t-ipconnect.de [IPv6:2003:ec:2f0f:2b00:bdd5:1795:3c60:a78f])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id DCBA91EC0570;
        Thu,  4 Nov 2021 15:40:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1636036854;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=z57IaE9PlPaUWDLspFw5XgopziT7sMA9cS9ud0DTm3c=;
        b=YW1usKCz5FT1nLDKhjOb5ht+i5ZudQo7N+heA+GUxMtblycDlp89S701HiZQxNT45KxD97
        9l314P+WKj/hg11k9+H0IsRfjt91IkBOh9pDsh6lelbEegapV0/vC0tSTpM9W27vje6OC/
        pdqRGodueERilwF5fo+r68NjxDtd2hA=
From:   Borislav Petkov <bp@alien8.de>
To:     Tony Luck <tony.luck@intel.com>
Cc:     X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH v0 11/12] x86/mce: Mark mce_timed_out() noinstr
Date:   Thu,  4 Nov 2021 15:40:34 +0100
Message-Id: <20211104144035.20107-12-bp@alien8.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20211104144035.20107-1-bp@alien8.de>
References: <20211104144035.20107-1-bp@alien8.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

Fixes

  vmlinux.o: warning: objtool: do_machine_check()+0x482: call to mce_timed_out() leaves .noinstr.text section

Signed-off-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/kernel/cpu/mce/core.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 961f80a4bd6f..bc97db90ac0a 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -878,8 +878,12 @@ static cpumask_t mce_missing_cpus = CPU_MASK_ALL;
 /*
  * Check if a timeout waiting for other CPUs happened.
  */
-static int mce_timed_out(u64 *t, const char *msg)
+static noinstr int mce_timed_out(u64 *t, const char *msg)
 {
+	int ret = 0;
+
+	instrumentation_begin();
+
 	/*
 	 * The others already did panic for some reason.
 	 * Bail out like in a timeout.
@@ -899,12 +903,17 @@ static int mce_timed_out(u64 *t, const char *msg)
 			mce_panic(msg, NULL, NULL);
 		}
 		cpu_missing = 1;
-		return 1;
+		ret = 1;
+		goto out;
 	}
 	*t -= SPINUNIT;
+
 out:
 	touch_nmi_watchdog();
-	return 0;
+
+	instrumentation_end();
+
+	return ret;
 }
 
 /*
-- 
2.29.2

