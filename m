Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D04844557B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Nov 2021 15:41:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231243AbhKDOnd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 10:43:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231269AbhKDOn0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 10:43:26 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CB44C06127A
        for <linux-kernel@vger.kernel.org>; Thu,  4 Nov 2021 07:40:48 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0f2b00bdd517953c60a78f.dip0.t-ipconnect.de [IPv6:2003:ec:2f0f:2b00:bdd5:1795:3c60:a78f])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 91A201EC0577;
        Thu,  4 Nov 2021 15:40:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1636036846;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9PsZQJD9bAg7+cXznrc2j1rzcCJvpmsnMxOJL5/iCQk=;
        b=EfZyUfD8uYgfmbHRDG7hzcPInRUPNnNHF16g139sxEULZvs7EzfxYEMB4k23R3GkcvMEZR
        eaazU6olMb+0woEPOBgHjCYSmKIiAS+3nQNwt7ooNq7Cg0WuYi0qJDGnWehOeOSKMFimgp
        x0j5cix7fXm7ARquIVo9MztEac2715Y=
From:   Borislav Petkov <bp@alien8.de>
To:     Tony Luck <tony.luck@intel.com>
Cc:     X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH v0 02/12] x86/mce: Remove function-local cpus variables
Date:   Thu,  4 Nov 2021 15:40:25 +0100
Message-Id: <20211104144035.20107-3-bp@alien8.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20211104144035.20107-1-bp@alien8.de>
References: <20211104144035.20107-1-bp@alien8.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

Use num_online_cpus() directly.

No functional changes.

Signed-off-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/kernel/cpu/mce/core.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 52d277c955f9..0dcd7ac7444c 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -989,7 +989,6 @@ static atomic_t global_nwo;
 static int mce_start(int *no_way_out)
 {
 	int order;
-	int cpus = num_online_cpus();
 	u64 timeout = (u64)mca_cfg.monarch_timeout * NSEC_PER_USEC;
 
 	if (!timeout)
@@ -1006,7 +1005,7 @@ static int mce_start(int *no_way_out)
 	/*
 	 * Wait for everyone.
 	 */
-	while (atomic_read(&mce_callin) != cpus) {
+	while (atomic_read(&mce_callin) != num_online_cpus()) {
 		if (mce_timed_out(&timeout,
 				  "Timeout: Not all CPUs entered broadcast exception handler")) {
 			atomic_set(&global_nwo, 0);
@@ -1070,14 +1069,11 @@ static int mce_end(int order)
 	atomic_inc(&mce_executing);
 
 	if (order == 1) {
-		/* CHECKME: Can this race with a parallel hotplug? */
-		int cpus = num_online_cpus();
-
 		/*
 		 * Monarch: Wait for everyone to go through their scanning
 		 * loops.
 		 */
-		while (atomic_read(&mce_executing) <= cpus) {
+		while (atomic_read(&mce_executing) <= num_online_cpus()) {
 			if (mce_timed_out(&timeout,
 					  "Timeout: Monarch CPU unable to finish machine check processing"))
 				goto reset;
-- 
2.29.2

