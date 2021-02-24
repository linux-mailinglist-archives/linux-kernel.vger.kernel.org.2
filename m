Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7129323B09
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 12:08:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235048AbhBXLHz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 06:07:55 -0500
Received: from mail.skyhub.de ([5.9.137.197]:39714 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234868AbhBXLDX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 06:03:23 -0500
Received: from zn.tnic (p200300ec2f0d180081510bd8ee909965.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:1800:8151:bd8:ee90:9965])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 7C4971EC05B6;
        Wed, 24 Feb 2021 12:02:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1614164561;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Jft7rBvIM38K+AEunU0mPtiyGumNXlAfLHuzAtBxR1k=;
        b=jPvE19jqgpmpo6s8CPOBh5mqnvIVPuaUqRDURcwRB1BSvEdhYTTfV917ksKEmviZ9yXNTf
        q02JDkVxI15uqZIYD+m0/LBxxsmcqT1wuR4HXPnRPVgnb/EkBCT3Zl1FZWjRpLh+nf7qdf
        e01zFGSrjR5kvyG6e5wd2HCtANLEyjs=
From:   Borislav Petkov <bp@alien8.de>
To:     X86 ML <x86@kernel.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 07/21] perf/x86/intel/ds: Check insn_get_length() retval
Date:   Wed, 24 Feb 2021 12:02:19 +0100
Message-Id: <20210224110233.19715-8-bp@alien8.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210224110233.19715-1-bp@alien8.de>
References: <20210224110233.19715-1-bp@alien8.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

intel_pmu_pebs_fixup_ip() needs only the insn length so use the
appropriate helper instead of a full decode. A full decode differs only
in running insn_complete() on the decoded insn but that is not needed
here.

Signed-off-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/events/intel/ds.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index 67dbc91bccfe..c1c710f6057b 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -1265,14 +1265,13 @@ static int intel_pmu_pebs_fixup_ip(struct pt_regs *regs)
 		is_64bit = kernel_ip(to) || any_64bit_mode(regs);
 #endif
 		insn_init(&insn, kaddr, size, is_64bit);
-		insn_get_length(&insn);
+
 		/*
-		 * Make sure there was not a problem decoding the
-		 * instruction and getting the length.  This is
-		 * doubly important because we have an infinite
-		 * loop if insn.length=0.
+		 * Make sure there was not a problem decoding the instruction.
+		 * This is doubly important because we have an infinite loop if
+		 * insn.length=0.
 		 */
-		if (!insn.length)
+		if (insn_get_length(&insn))
 			break;
 
 		to += insn.length;
-- 
2.29.2

