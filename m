Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD5D3445580
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Nov 2021 15:41:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231559AbhKDOno (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 10:43:44 -0400
Received: from mail.skyhub.de ([5.9.137.197]:49286 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231380AbhKDOna (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 10:43:30 -0400
Received: from zn.tnic (p200300ec2f0f2b00bdd517953c60a78f.dip0.t-ipconnect.de [IPv6:2003:ec:2f0f:2b00:bdd5:1795:3c60:a78f])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 6DEA01EC0575;
        Thu,  4 Nov 2021 15:40:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1636036851;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Oq33Tgtpo+xRi0ew4hQvFIQD3pkBJWRewfXrJaUXXqk=;
        b=DDQhfKOZqrjbLjvZY8LcsMNumOHzoNBpCfhVYEwfbeyTQTOra/bS80NZuWIYKzFp98w5EP
        yvy8WmbGtqSHMmdhW1+TZbQv25ncEcbrkzGUr6FRwIC6l5F8U6E8roIVD81UjlxcKEtRO/
        ZT8wH7X0cYKQa+mPguUlH+N9caimSjI=
From:   Borislav Petkov <bp@alien8.de>
To:     Tony Luck <tony.luck@intel.com>
Cc:     X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH v0 08/12] x86/mce: Mark mce_end() noinstr
Date:   Thu,  4 Nov 2021 15:40:31 +0100
Message-Id: <20211104144035.20107-9-bp@alien8.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20211104144035.20107-1-bp@alien8.de>
References: <20211104144035.20107-1-bp@alien8.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

It is called by the #MC handler which is noinstr.

Fixes

  vmlinux.o: warning: objtool: do_machine_check()+0xbd6: call to memset() leaves .noinstr.text section

Signed-off-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/kernel/cpu/mce/core.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 4783b009f5aa..8b0dd4fdab75 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -1060,10 +1060,12 @@ static int mce_start(int *no_way_out)
  * Synchronize between CPUs after main scanning loop.
  * This invokes the bulk of the Monarch processing.
  */
-static int mce_end(int order)
+static noinstr int mce_end(int order)
 {
-	int ret = -1;
 	u64 timeout = (u64)mca_cfg.monarch_timeout * NSEC_PER_USEC;
+	int ret = -1;
+
+	instrumentation_begin();
 
 	if (!timeout)
 		goto reset;
@@ -1104,7 +1106,8 @@ static int mce_end(int order)
 		/*
 		 * Don't reset anything. That's done by the Monarch.
 		 */
-		return 0;
+		ret = 0;
+		goto out;
 	}
 
 	/*
@@ -1120,6 +1123,10 @@ static int mce_end(int order)
 	 * Let others run again.
 	 */
 	atomic_set(&mce_executing, 0);
+
+out:
+	instrumentation_end();
+
 	return ret;
 }
 
-- 
2.29.2

