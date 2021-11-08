Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 599BF447D99
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Nov 2021 11:16:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238730AbhKHKR0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 05:17:26 -0500
Received: from mail.skyhub.de ([5.9.137.197]:38394 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238570AbhKHKPM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 05:15:12 -0500
Received: from zn.tnic (p200300ec2f33110088892b77bd117736.dip0.t-ipconnect.de [IPv6:2003:ec:2f33:1100:8889:2b77:bd11:7736])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 100541EC0501;
        Mon,  8 Nov 2021 11:12:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1636366347;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nRs8Hwu0oLLsUo7HT1qzBFdIIrVvFV70O+h27c4scJI=;
        b=k0XF0Y4nVjzUo+96uDWhyD+qexJi5lhwEKmlAtzm0xq5K2QA/s1v8CS0X3OQxJhFPpkyFI
        sKueirlziAwcAeXkBh60Cl1U+AdW7woPc51BvNYDLSzUecr1BzLDOmH6SyYdt9PBSnW0vD
        fsKgB9zAWNVyDubPQDLYS6w+i8HC2gw=
From:   Borislav Petkov <bp@alien8.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     linux-staging@lists.linux.dev
Subject: [PATCH v0 24/42] staging: olpc_dcon: Check notifier registration return value
Date:   Mon,  8 Nov 2021 11:11:39 +0100
Message-Id: <20211108101157.15189-25-bp@alien8.de>
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
Cc: linux-staging@lists.linux.dev
---
 drivers/staging/olpc_dcon/olpc_dcon.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/olpc_dcon/olpc_dcon.c b/drivers/staging/olpc_dcon/olpc_dcon.c
index 7284cb4ac395..f5204a88bb35 100644
--- a/drivers/staging/olpc_dcon/olpc_dcon.c
+++ b/drivers/staging/olpc_dcon/olpc_dcon.c
@@ -653,7 +653,9 @@ static int dcon_probe(struct i2c_client *client, const struct i2c_device_id *id)
 	}
 
 	register_reboot_notifier(&dcon->reboot_nb);
-	atomic_notifier_chain_register(&panic_notifier_list, &dcon_panic_nb);
+
+	if (atomic_notifier_chain_register(&panic_notifier_list, &dcon_panic_nb))
+		pr_warn("Panic notifier already registered\n");
 
 	return 0;
 
-- 
2.29.2

