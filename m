Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1267032D8D6
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 18:48:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239578AbhCDRqe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 12:46:34 -0500
Received: from mail.skyhub.de ([5.9.137.197]:39880 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237583AbhCDRnf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 12:43:35 -0500
Received: from zn.tnic (p200300ec2f0f5900f7833063514d8659.dip0.t-ipconnect.de [IPv6:2003:ec:2f0f:5900:f783:3063:514d:8659])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 0D6941EC04DD;
        Thu,  4 Mar 2021 18:42:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1614879774;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sGu6QxPvSuXPNOoMVE6nRuZQnCAAAddjrI5BbxGfsww=;
        b=hCCd6SQNnYkwSv8KYp61RoMeqtGOzV6C8VSDakwRhae38iVdbSBm4Xosd6ju21kqFT8WeC
        fSm7tXeWFjRBtJLA2ITvbl89MmNwA8XuGNoq2FWa+dDCas1vAGGLy7DGKoIa8d6iqtin4o
        EdOl2UhmccaxMdseooewORmAnnLEa8Y=
From:   Borislav Petkov <bp@alien8.de>
To:     X86 ML <x86@kernel.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 07/21] perf/x86/intel/ds: Check insn_get_length() retval
Date:   Thu,  4 Mar 2021 18:42:23 +0100
Message-Id: <20210304174237.31945-8-bp@alien8.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210304174237.31945-1-bp@alien8.de>
References: <20210304174237.31945-1-bp@alien8.de>
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
index 7ebae1826403..cdd195a3804e 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -1353,14 +1353,13 @@ static int intel_pmu_pebs_fixup_ip(struct pt_regs *regs)
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

