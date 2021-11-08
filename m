Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AE57447D80
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Nov 2021 11:14:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238732AbhKHKQ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 05:16:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237762AbhKHKO7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 05:14:59 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55AB0C061714
        for <linux-kernel@vger.kernel.org>; Mon,  8 Nov 2021 02:12:14 -0800 (PST)
Received: from zn.tnic (p200300ec2f33110088892b77bd117736.dip0.t-ipconnect.de [IPv6:2003:ec:2f33:1100:8889:2b77:bd11:7736])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id EBC641EC04E0;
        Mon,  8 Nov 2021 11:12:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1636366333;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=X/Hn91jrBnlYF021LHj4jTZZybHLn5KSnhf9Ef7LdEA=;
        b=NeAoIcmaCi5Z+Dgahdru8ptYYODaoo3vHiVvX3JjxGdyJLE2lL5nZiug0IvwERk4pJyiyz
        DymQsesyzS5+7+pvdQJHNFtxPaQer5MNWCfkXyqTsrToIJE0DU0z+7IT4DbxKby/q3oOjt
        XmxxjoiyIcrB5gPDpC2rm/04gA32vLw=
From:   Borislav Petkov <bp@alien8.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org
Subject: [PATCH v0 06/42] firmware: Check notifier registration return value
Date:   Mon,  8 Nov 2021 11:11:21 +0100
Message-Id: <20211108101157.15189-7-bp@alien8.de>
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
Cc: linux-arm-kernel@lists.infradead.org
---
 drivers/firmware/arm_scmi/notify.c | 3 ++-
 drivers/firmware/google/gsmi.c     | 6 ++++--
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/firmware/arm_scmi/notify.c b/drivers/firmware/arm_scmi/notify.c
index 0efd20cd9d69..f4c42ac00c63 100644
--- a/drivers/firmware/arm_scmi/notify.c
+++ b/drivers/firmware/arm_scmi/notify.c
@@ -1358,7 +1358,8 @@ static int scmi_notifier_register(const struct scmi_handle *handle,
 	if (!hndl)
 		return -EINVAL;
 
-	blocking_notifier_chain_register(&hndl->chain, nb);
+	if (blocking_notifier_chain_register(&hndl->chain, nb))
+		pr_warn("SCMI notifier already registered\n");
 
 	/* Enable events for not pending handlers */
 	if (!IS_HNDL_PENDING(hndl)) {
diff --git a/drivers/firmware/google/gsmi.c b/drivers/firmware/google/gsmi.c
index adaa492c3d2d..a658e7c106c3 100644
--- a/drivers/firmware/google/gsmi.c
+++ b/drivers/firmware/google/gsmi.c
@@ -1030,8 +1030,10 @@ static __init int gsmi_init(void)
 
 	register_reboot_notifier(&gsmi_reboot_notifier);
 	register_die_notifier(&gsmi_die_notifier);
-	atomic_notifier_chain_register(&panic_notifier_list,
-				       &gsmi_panic_notifier);
+
+	if (atomic_notifier_chain_register(&panic_notifier_list,
+					   &gsmi_panic_notifier))
+		pr_warn("gsmi panic notifier already registered\n");
 
 	printk(KERN_INFO "gsmi version " DRIVER_VERSION " loaded\n");
 
-- 
2.29.2

