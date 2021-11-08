Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55219447DA7
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Nov 2021 11:16:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238839AbhKHKSz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 05:18:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238627AbhKHKPf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 05:15:35 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 126E6C06120A;
        Mon,  8 Nov 2021 02:12:30 -0800 (PST)
Received: from zn.tnic (p200300ec2f33110088892b77bd117736.dip0.t-ipconnect.de [IPv6:2003:ec:2f33:1100:8889:2b77:bd11:7736])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 9ECB41EC0516;
        Mon,  8 Nov 2021 11:12:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1636366348;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0YFBkgqdyQLeiLHHptUCQ5vO3EksAALAsAlozqYl3To=;
        b=Tqhuf+E9i6F9aPsu5EzSDHAVP0zIH9DC9Xgq7vOLzlAdtscjDgLgDqNd8ckEkEVPt1CuW0
        oOFQRNgz1Xg1tUzPRwEsfv6+p7YaULts8Bf0xfNOLHI2VOGQUb4nyxukiZu/z5elSbJATk
        yCaX/8WtCnKs5iqX5Xsy8846UHOpUHA=
From:   Borislav Petkov <bp@alien8.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     linux-alpha@vger.kernel.org
Subject: [PATCH v0 26/42] alpha: Check notifier registration return value
Date:   Mon,  8 Nov 2021 11:11:41 +0100
Message-Id: <20211108101157.15189-27-bp@alien8.de>
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
Cc: linux-alpha@vger.kernel.org
---
 arch/alpha/kernel/setup.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/alpha/kernel/setup.c b/arch/alpha/kernel/setup.c
index b4fbbba30aa2..520c08031137 100644
--- a/arch/alpha/kernel/setup.c
+++ b/arch/alpha/kernel/setup.c
@@ -465,8 +465,9 @@ setup_arch(char **cmdline_p)
 	}
 
 	/* Register a call for panic conditions. */
-	atomic_notifier_chain_register(&panic_notifier_list,
-			&alpha_panic_block);
+	if (atomic_notifier_chain_register(&panic_notifier_list,
+					   &alpha_panic_block))
+		pr_warn("Panic notifier already registered\n");
 
 #ifndef alpha_using_srm
 	/* Assume that we've booted from SRM if we haven't booted from MILO.
-- 
2.29.2

