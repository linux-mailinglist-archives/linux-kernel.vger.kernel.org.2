Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F96A447D55
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Nov 2021 11:12:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235856AbhKHKO5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 05:14:57 -0500
Received: from mail.skyhub.de ([5.9.137.197]:38202 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230462AbhKHKOy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 05:14:54 -0500
Received: from zn.tnic (p200300ec2f33110088892b77bd117736.dip0.t-ipconnect.de [IPv6:2003:ec:2f33:1100:8889:2b77:bd11:7736])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id BABC81EC04E0;
        Mon,  8 Nov 2021 11:12:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1636366329;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=grdSLe+txR+qPcky5ijEGsjPCSkRE9m2uQKOXesimzE=;
        b=OveTWrDzAdrOoSEwa1Av97jBWR5pZb8d7IM/QcE2Bm0tLy+LKZctYgVNu/8HPp+khPKy8S
        fBJxFCpTfhDSa0lqOVDygpDhEY+AGd64/coDHahUOeAP4LgJ5PPdM1pvgt1eBYUTFfAiTM
        J8ofTFwzerbk/CRlwmeCnSLXSqeLzqY=
From:   Borislav Petkov <bp@alien8.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     xen-devel@lists.xenproject.org
Subject: [PATCH v0 02/42] xen/x86: Check notifier registration return value
Date:   Mon,  8 Nov 2021 11:11:17 +0100
Message-Id: <20211108101157.15189-3-bp@alien8.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20211108101157.15189-1-bp@alien8.de>
References: <20211108101157.15189-1-bp@alien8.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

Avoid homegrown notifier registration checks.

No functional changes.

Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: xen-devel@lists.xenproject.org
---
 arch/x86/xen/enlighten.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/x86/xen/enlighten.c b/arch/x86/xen/enlighten.c
index 95d970359e17..2264dd6e157f 100644
--- a/arch/x86/xen/enlighten.c
+++ b/arch/x86/xen/enlighten.c
@@ -354,7 +354,9 @@ static struct notifier_block xen_panic_block = {
 
 int xen_panic_handler_init(void)
 {
-	atomic_notifier_chain_register(&panic_notifier_list, &xen_panic_block);
+	if (atomic_notifier_chain_register(&panic_notifier_list, &xen_panic_block))
+		pr_warn("Xen panic notifier already registered\n");
+
 	return 0;
 }
 
-- 
2.29.2

