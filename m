Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A603E44E4AA
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Nov 2021 11:33:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235020AbhKLKgB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Nov 2021 05:36:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234973AbhKLKfy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Nov 2021 05:35:54 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0E4AC061766
        for <linux-kernel@vger.kernel.org>; Fri, 12 Nov 2021 02:33:03 -0800 (PST)
Received: from zn.tnic (p200300ec2f10ce005b16e04e289251c2.dip0.t-ipconnect.de [IPv6:2003:ec:2f10:ce00:5b16:e04e:2892:51c2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 434E41EC05BC;
        Fri, 12 Nov 2021 11:33:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1636713182;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5C1CLa+SzlO/w9LrM+MATfUkpOBEM60Z9VBF0qAEjz8=;
        b=UJZXqs6WHve/llQL2Mbem6UezR2K8XiiCT6WyYIYmY1PpBE+OZcsLghOO/Ysky+AqE+wCu
        enF3Mbghp4a6MPZ34MHIpJBkghXbSnALOl5/3YJR5I8S8MpbjHe0EX4mAeo2Idf42BwB8M
        Q8DXpBG2E9w0tCtBmv3QKlbpQfrYCv0=
From:   Borislav Petkov <bp@alien8.de>
To:     X86 ML <x86@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 6/6] x86/cpu: Remove "noclflush"
Date:   Fri, 12 Nov 2021 11:32:46 +0100
Message-Id: <20211112103246.7555-7-bp@alien8.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20211112103246.7555-1-bp@alien8.de>
References: <20211112103246.7555-1-bp@alien8.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

Not really needed anymore and there's clearcpuid=.

Signed-off-by: Borislav Petkov <bp@suse.de>
---
 Documentation/admin-guide/kernel-parameters.txt | 2 --
 arch/x86/kernel/cpu/common.c                    | 8 --------
 2 files changed, 10 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 3a4c3fc88bf1..5239d4ae2b91 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3348,8 +3348,6 @@
 
 	nocache		[ARM]
 
-	noclflush	[BUGS=X86] Don't use the CLFLUSH instruction
-
 	delayacct	[KNL] Enable per-task delay accounting
 
 	nodsp		[SH] Disable hardware DSP at boot time.
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 7e70c54cdff5..9a8ecb388f2f 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1721,14 +1721,6 @@ void identify_secondary_cpu(struct cpuinfo_x86 *c)
 	update_srbds_msr();
 }
 
-static __init int setup_noclflush(char *arg)
-{
-	setup_clear_cpu_cap(X86_FEATURE_CLFLUSH);
-	setup_clear_cpu_cap(X86_FEATURE_CLFLUSHOPT);
-	return 1;
-}
-__setup("noclflush", setup_noclflush);
-
 void print_cpu_info(struct cpuinfo_x86 *c)
 {
 	const char *vendor = NULL;
-- 
2.29.2

