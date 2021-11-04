Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19942445584
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Nov 2021 15:41:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231249AbhKDOnw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 10:43:52 -0400
Received: from mail.skyhub.de ([5.9.137.197]:49286 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231482AbhKDOnd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 10:43:33 -0400
Received: from zn.tnic (p200300ec2f0f2b00bdd517953c60a78f.dip0.t-ipconnect.de [IPv6:2003:ec:2f0f:2b00:bdd5:1795:3c60:a78f])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B4E2B1EC0577;
        Thu,  4 Nov 2021 15:40:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1636036854;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8tNhVqReHgMWvpaWzWkbcWhHL+1+E8xagLenDl8wsqI=;
        b=kbTwJRaBgtMDX8r7+bemA0B8SeXS8x99UGTvtojeCG1ygNrOJuWnqx+XyYeX8kSV2kH+2a
        SI4ZYvHfMZhOF+AC8YNSqPT5UFcv+whCt7lsooUAFMeXsNo8I1BkXeURKhI9CR0YSTFDae
        WP0WlefVr0VC8YLKgK05oc572WPT6PU=
From:   Borislav Petkov <bp@alien8.de>
To:     Tony Luck <tony.luck@intel.com>
Cc:     X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH v0 12/12] x86/mce: Mark mce_start() noinstr
Date:   Thu,  4 Nov 2021 15:40:35 +0100
Message-Id: <20211104144035.20107-13-bp@alien8.de>
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

  vmlinux.o: warning: objtool: do_machine_check()+0x4ae: call to __const_udelay() leaves .noinstr.text section

Signed-off-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/kernel/cpu/mce/core.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index bc97db90ac0a..4bec85a07259 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -1002,13 +1002,13 @@ static atomic_t global_nwo;
  * in the entry order.
  * TBD double check parallel CPU hotunplug
  */
-static int mce_start(int *no_way_out)
+static noinstr int mce_start(int *no_way_out)
 {
-	int order;
 	u64 timeout = (u64)mca_cfg.monarch_timeout * NSEC_PER_USEC;
+	int order, ret = -1;
 
 	if (!timeout)
-		return -1;
+		return ret;
 
 	atomic_add(*no_way_out, &global_nwo);
 	/*
@@ -1018,6 +1018,8 @@ static int mce_start(int *no_way_out)
 	order = atomic_inc_return(&mce_callin);
 	cpumask_clear_cpu(smp_processor_id(), &mce_missing_cpus);
 
+	instrumentation_begin();
+
 	/*
 	 * Wait for everyone.
 	 */
@@ -1025,7 +1027,7 @@ static int mce_start(int *no_way_out)
 		if (mce_timed_out(&timeout,
 				  "Timeout: Not all CPUs entered broadcast exception handler")) {
 			atomic_set(&global_nwo, 0);
-			return -1;
+			goto out;
 		}
 		ndelay(SPINUNIT);
 	}
@@ -1051,7 +1053,7 @@ static int mce_start(int *no_way_out)
 			if (mce_timed_out(&timeout,
 					  "Timeout: Subject CPUs unable to finish machine check processing")) {
 				atomic_set(&global_nwo, 0);
-				return -1;
+				goto out;
 			}
 			ndelay(SPINUNIT);
 		}
@@ -1062,7 +1064,12 @@ static int mce_start(int *no_way_out)
 	 */
 	*no_way_out = atomic_read(&global_nwo);
 
-	return order;
+	ret = order;
+
+out:
+	instrumentation_end();
+
+	return ret;
 }
 
 /*
-- 
2.29.2

