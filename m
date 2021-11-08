Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC827447DA6
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Nov 2021 11:16:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239025AbhKHKSn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 05:18:43 -0500
Received: from mail.skyhub.de ([5.9.137.197]:38352 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230201AbhKHKPI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 05:15:08 -0500
Received: from zn.tnic (p200300ec2f33110088892b77bd117736.dip0.t-ipconnect.de [IPv6:2003:ec:2f33:1100:8889:2b77:bd11:7736])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 5327A1EC04E0;
        Mon,  8 Nov 2021 11:12:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1636366343;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=O4l6NvOfwI35aQ1VkPm6SxCKClITle3M6ZNdjdLIRBg=;
        b=WSpP5u0cMlmbvkpd/yxn2hLFcYASp5SC08SldoBh9vaf2jd4B42EPJdAiRV0Kk56CXj8g+
        mjLhn8Fnh/UqmPkKRyzReH8owa8MQeATtQYTxR4DExrxXy4/CClIdOBnfs5WIwExf4LMlp
        8SBu+OcAl+XApStMqJHw8bnjCXxe68M=
From:   Borislav Petkov <bp@alien8.de>
To:     LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH v0 19/42] kernel/hung_task: Check notifier registration return value
Date:   Mon,  8 Nov 2021 11:11:34 +0100
Message-Id: <20211108101157.15189-20-bp@alien8.de>
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
---
 kernel/hung_task.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/hung_task.c b/kernel/hung_task.c
index 9888e2bc8c76..8e3bb95968a4 100644
--- a/kernel/hung_task.c
+++ b/kernel/hung_task.c
@@ -304,7 +304,8 @@ static int watchdog(void *dummy)
 
 static int __init hung_task_init(void)
 {
-	atomic_notifier_chain_register(&panic_notifier_list, &panic_block);
+	if (atomic_notifier_chain_register(&panic_notifier_list, &panic_block))
+		pr_warn("Hung task notifier already registered\n");
 
 	/* Disable hung task detector on suspend */
 	pm_notifier(hungtask_pm_notify, 0);
-- 
2.29.2

