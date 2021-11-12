Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5573944E4A7
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Nov 2021 11:33:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234968AbhKLKfy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Nov 2021 05:35:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234965AbhKLKfw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Nov 2021 05:35:52 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00BAAC061766
        for <linux-kernel@vger.kernel.org>; Fri, 12 Nov 2021 02:33:02 -0800 (PST)
Received: from zn.tnic (p200300ec2f10ce005b16e04e289251c2.dip0.t-ipconnect.de [IPv6:2003:ec:2f10:ce00:5b16:e04e:2892:51c2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 8C7781EC05BB;
        Fri, 12 Nov 2021 11:33:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1636713180;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LjlJWaB0Naq5R76RKJb1kr/oYn5sHRTYbjYyOKxMIbY=;
        b=QzFyDRo5pPZ2y8eRV+2T/IDaPe2Uh4VEPMtCtaiBt97nzaBkrdA5a6VdgmOkBkrjYXINfc
        Tl5edz1oEJC6SKpn+Vry1T/ithfH5VWie7xSBsOokq6sC0h4XZgzeDTuVfPF6PWnEZHCLP
        9K54zLfmBnHFeHtl96/UliY5X2Q9A0c=
From:   Borislav Petkov <bp@alien8.de>
To:     X86 ML <x86@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 4/6] x86/cpu: Remove "nosmep"
Date:   Fri, 12 Nov 2021 11:32:44 +0100
Message-Id: <20211112103246.7555-5-bp@alien8.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20211112103246.7555-1-bp@alien8.de>
References: <20211112103246.7555-1-bp@alien8.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

There should be no need to disable SMEP anymore.

Signed-off-by: Borislav Petkov <bp@suse.de>
---
 Documentation/admin-guide/kernel-parameters.txt | 4 ----
 Documentation/x86/cpuinfo.rst                   | 4 ++--
 arch/x86/kernel/cpu/common.c                    | 7 -------
 3 files changed, 2 insertions(+), 13 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 54ae0378add4..b3fbb0930997 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3365,10 +3365,6 @@
 			noexec=on: enable non-executable mappings (default)
 			noexec=off: disable non-executable mappings
 
-	nosmep		[X86,PPC]
-			Disable SMEP (Supervisor Mode Execution Prevention)
-			even if it is supported by processor.
-
 	noexec32	[X86-64]
 			This affects only 32-bit executables.
 			noexec32=on: enable non-executable mappings (default)
diff --git a/Documentation/x86/cpuinfo.rst b/Documentation/x86/cpuinfo.rst
index 12fbe2b1e98a..08246e8ac835 100644
--- a/Documentation/x86/cpuinfo.rst
+++ b/Documentation/x86/cpuinfo.rst
@@ -140,8 +140,8 @@ from #define X86_FEATURE_UMIP (16*32 + 2).
 
 In addition, there exists a variety of custom command-line parameters that
 disable specific features. The list of parameters includes, but is not limited
-to, nofsgsbase, and nosmep. 5-level paging can also be disabled using
-"no5lvl". SMEP is disabled with the aforementioned parameter.
+to, nofsgsbase, nosgx, noxsave, etc. 5-level paging can also be disabled using
+"no5lvl".
 
 e: The feature was known to be non-functional.
 ----------------------------------------------
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 796aa31fd3c8..7e70c54cdff5 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -291,13 +291,6 @@ static inline void squash_the_stupid_serial_number(struct cpuinfo_x86 *c)
 }
 #endif
 
-static __init int setup_disable_smep(char *arg)
-{
-	setup_clear_cpu_cap(X86_FEATURE_SMEP);
-	return 1;
-}
-__setup("nosmep", setup_disable_smep);
-
 static __always_inline void setup_smep(struct cpuinfo_x86 *c)
 {
 	if (cpu_has(c, X86_FEATURE_SMEP))
-- 
2.29.2

