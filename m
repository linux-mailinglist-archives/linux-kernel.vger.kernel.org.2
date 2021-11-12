Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D30A844E4A6
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Nov 2021 11:33:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234964AbhKLKfx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Nov 2021 05:35:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234948AbhKLKfu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Nov 2021 05:35:50 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72FF0C061767
        for <linux-kernel@vger.kernel.org>; Fri, 12 Nov 2021 02:33:00 -0800 (PST)
Received: from zn.tnic (p200300ec2f10ce005b16e04e289251c2.dip0.t-ipconnect.de [IPv6:2003:ec:2f10:ce00:5b16:e04e:2892:51c2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id F11F51EC0559;
        Fri, 12 Nov 2021 11:32:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1636713179;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TGtKw2TyQ2qxqQ+idBrA7vBKLh7rtb+oQuUnHkiBbPg=;
        b=SaLFztO5EXFOsEOAK5/iI5NMg0kwqOPU7n/sxHhQpHpk0m8muTzCRjtygSOqMkZmYleY7H
        l+da0quInkSV9gaR+CmibK6yIuCppaip9V94r2lD6TsG73dy2Q9hsc+WZSU7SlGZU9FB1Z
        hlHVYsqTUiL4PC6sXmhwIRhQBUbdybQ=
From:   Borislav Petkov <bp@alien8.de>
To:     X86 ML <x86@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/6] x86/cpu: Remove "nosep"
Date:   Fri, 12 Nov 2021 11:32:42 +0100
Message-Id: <20211112103246.7555-3-bp@alien8.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20211112103246.7555-1-bp@alien8.de>
References: <20211112103246.7555-1-bp@alien8.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

That chicken bit was added by

  4f88651125e2 ("[PATCH] i386: allow disabling X86_FEATURE_SEP at boot")

but measuring int80 vsyscall performance on 32-bit doesn't matter
anymore.

If still needed, one can boot with

  clearcpuid=sep

to disable that feature for testing.

Signed-off-by: Borislav Petkov <bp@suse.de>
---
 Documentation/admin-guide/kernel-parameters.txt | 2 --
 arch/x86/kernel/cpu/common.c                    | 7 -------
 2 files changed, 9 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index dadb09d30212..13e6f0100970 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3563,8 +3563,6 @@
 
 	nosbagart	[IA-64]
 
-	nosep		[BUGS=X86-32] Disables x86 SYSENTER/SYSEXIT support.
-
 	nosgx		[X86-64,SGX] Disables Intel SGX kernel support.
 
 	nosmp		[SMP] Tells an SMP kernel to act as a UP kernel,
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 0d1cf5c65b0c..b4598659d4a8 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -220,13 +220,6 @@ static int __init cachesize_setup(char *str)
 }
 __setup("cachesize=", cachesize_setup);
 
-static int __init x86_sep_setup(char *s)
-{
-	setup_clear_cpu_cap(X86_FEATURE_SEP);
-	return 1;
-}
-__setup("nosep", x86_sep_setup);
-
 /* Standard macro to see if a specific flag is changeable */
 static inline int flag_is_changeable_p(u32 flag)
 {
-- 
2.29.2

