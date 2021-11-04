Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11890445581
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Nov 2021 15:41:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231508AbhKDOnq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 10:43:46 -0400
Received: from mail.skyhub.de ([5.9.137.197]:49234 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231388AbhKDOna (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 10:43:30 -0400
Received: from zn.tnic (p200300ec2f0f2b00bdd517953c60a78f.dip0.t-ipconnect.de [IPv6:2003:ec:2f0f:2b00:bdd5:1795:3c60:a78f])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 425081EC0589;
        Thu,  4 Nov 2021 15:40:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1636036852;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CfwsSAthbfLpxHMwealKgPFbBP0RP/0F45cvL62XpbY=;
        b=EVI6dDCLrTMc1E0qGWLF33i0mN6C4+HL7VX2bBwTe1GYJ1/vMUWdyT8WO71GUOztnm5Gby
        RCFh+sWxMgrw891vV9yDlB4bct+WpHc+yeQ+tAMElU6PsEo0E1j7F1jV18QUA09RV7J3x4
        BQrca2zF1kUfRynkf3YYmVacXrgDwpc=
From:   Borislav Petkov <bp@alien8.de>
To:     Tony Luck <tony.luck@intel.com>
Cc:     X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH v0 09/12] x86/mce: Mark mce_read_aux() noinstr
Date:   Thu,  4 Nov 2021 15:40:32 +0100
Message-Id: <20211104144035.20107-10-bp@alien8.de>
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

  vmlinux.o: warning: objtool: do_machine_check()+0x681: call to mce_read_aux() leaves .noinstr.text section

Signed-off-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/kernel/cpu/mce/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 8b0dd4fdab75..e31df79f87c7 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -643,7 +643,7 @@ static struct notifier_block mce_default_nb = {
 /*
  * Read ADDR and MISC registers.
  */
-static void mce_read_aux(struct mce *m, int i)
+static noinstr void mce_read_aux(struct mce *m, int i)
 {
 	if (m->status & MCI_STATUS_MISCV)
 		m->misc = mce_rdmsrl(mca_msr_reg(i, MCA_MISC));
-- 
2.29.2

