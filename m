Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBE8B447D60
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Nov 2021 11:12:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238606AbhKHKPZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 05:15:25 -0500
Received: from mail.skyhub.de ([5.9.137.197]:38212 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231208AbhKHKOz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 05:14:55 -0500
Received: from zn.tnic (p200300ec2f33110088892b77bd117736.dip0.t-ipconnect.de [IPv6:2003:ec:2f33:1100:8889:2b77:bd11:7736])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 8FBB91EC04E4;
        Mon,  8 Nov 2021 11:12:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1636366330;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ND2LAp5V1cntcC8R5Alkyf27iXFfBHan47izc4wnMQM=;
        b=EGQc7Yry2RAR5SapNiYcK4fsmLV9Cz0AL6DHe24vwqSfXZCKqw9uPBeZlXRkPYKfLdQO2v
        ThnmTWk7RtlmeoysorTcja4Mz2N1X72PXPumoiSYch+ZRPoFZSQ9/+ytocg1QFAppS1ocO
        BoPQnK6zsahj2qibw4f7T6ZH5klZvQc=
From:   Borislav Petkov <bp@alien8.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     openipmi-developer@lists.sourceforge.net
Subject: [PATCH v0 03/42] impi: Check notifier registration return value
Date:   Mon,  8 Nov 2021 11:11:18 +0100
Message-Id: <20211108101157.15189-4-bp@alien8.de>
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
Cc: openipmi-developer@lists.sourceforge.net
---
 drivers/char/ipmi/ipmi_msghandler.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/char/ipmi/ipmi_msghandler.c b/drivers/char/ipmi/ipmi_msghandler.c
index deed355422f4..9df360b53a90 100644
--- a/drivers/char/ipmi/ipmi_msghandler.c
+++ b/drivers/char/ipmi/ipmi_msghandler.c
@@ -5381,7 +5381,8 @@ static int ipmi_init_msghandler(void)
 	timer_setup(&ipmi_timer, ipmi_timeout, 0);
 	mod_timer(&ipmi_timer, jiffies + IPMI_TIMEOUT_JIFFIES);
 
-	atomic_notifier_chain_register(&panic_notifier_list, &panic_block);
+	if (atomic_notifier_chain_register(&panic_notifier_list, &panic_block))
+		pr_warn("IPMI panic notifier already registered\n");
 
 	initialized = true;
 
-- 
2.29.2

