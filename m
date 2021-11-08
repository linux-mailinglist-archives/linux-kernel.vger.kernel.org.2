Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 256C6447D90
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Nov 2021 11:14:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238602AbhKHKQ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 05:16:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237842AbhKHKPD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 05:15:03 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1449C061714
        for <linux-kernel@vger.kernel.org>; Mon,  8 Nov 2021 02:12:18 -0800 (PST)
Received: from zn.tnic (p200300ec2f33110088892b77bd117736.dip0.t-ipconnect.de [IPv6:2003:ec:2f33:1100:8889:2b77:bd11:7736])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 011761EC0501;
        Mon,  8 Nov 2021 11:12:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1636366337;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BFq9wMoiEcM4ke+MTRBzDm8LDUO4bEBhPpFd5qQWnyI=;
        b=JpAVisHHJRty1TqzHW7fiv5Qffxj8K9BiYhvlLslKD7P+0XA0GXN/cDcHSsOxd77gP02C2
        VBh4LGxgMrBnGDb1ZalRy5E2CATp4d3JnKgcycPPzxyKvSbrkHw0lLn2P7tttoHql/r7E+
        8VvAekPGjIRBwIqXuIyvwVy4iL6FHLg=
From:   Borislav Petkov <bp@alien8.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v0 11/42] misc: Check notifier registration return value
Date:   Mon,  8 Nov 2021 11:11:26 +0100
Message-Id: <20211108101157.15189-12-bp@alien8.de>
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
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/misc/ibmasm/heartbeat.c | 3 ++-
 drivers/misc/pvpanic/pvpanic.c  | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/ibmasm/heartbeat.c b/drivers/misc/ibmasm/heartbeat.c
index 59c9a0d95659..f7c22d9a768b 100644
--- a/drivers/misc/ibmasm/heartbeat.c
+++ b/drivers/misc/ibmasm/heartbeat.c
@@ -39,7 +39,8 @@ static struct notifier_block panic_notifier = { panic_happened, NULL, 1 };
 
 void ibmasm_register_panic_notifier(void)
 {
-	atomic_notifier_chain_register(&panic_notifier_list, &panic_notifier);
+	if (atomic_notifier_chain_register(&panic_notifier_list, &panic_notifier))
+		pr_warn("IBM ASM panic notifier already registered\n");
 }
 
 void ibmasm_unregister_panic_notifier(void)
diff --git a/drivers/misc/pvpanic/pvpanic.c b/drivers/misc/pvpanic/pvpanic.c
index 4b8f1c7d726d..6e89e8b1beaf 100644
--- a/drivers/misc/pvpanic/pvpanic.c
+++ b/drivers/misc/pvpanic/pvpanic.c
@@ -95,7 +95,8 @@ static int pvpanic_init(void)
 	INIT_LIST_HEAD(&pvpanic_list);
 	spin_lock_init(&pvpanic_lock);
 
-	atomic_notifier_chain_register(&panic_notifier_list, &pvpanic_panic_nb);
+	if (atomic_notifier_chain_register(&panic_notifier_list, &pvpanic_panic_nb))
+		pr_warn("PV panic notifier already registered\n");
 
 	return 0;
 }
-- 
2.29.2

