Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B1DD447DAA
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Nov 2021 11:17:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238791AbhKHKTL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 05:19:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238632AbhKHKPg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 05:15:36 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72B46C06120C
        for <linux-kernel@vger.kernel.org>; Mon,  8 Nov 2021 02:12:32 -0800 (PST)
Received: from zn.tnic (p200300ec2f33110088892b77bd117736.dip0.t-ipconnect.de [IPv6:2003:ec:2f33:1100:8889:2b77:bd11:7736])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 117821EC051F;
        Mon,  8 Nov 2021 11:12:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1636366351;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZrcRCvECKj7IKUT0HhuHkcjgG9gjdsthfkW1xcjqiQQ=;
        b=Bry7kjH/QPnC8+/1Xd35kNkpMnozd5dqVjBxpEJhFQos8IwQXvKbX5GfwlRbJOwjjNWHuN
        cy1YdUgsC+vuiCb5tv2y4EgPfGNdUovYo7RznunEwaImVg/xycVcfO6RgLRcz+j5NLy4aZ
        ttYPmlYm9OJYwZrmbpqI/hS5S/0F8RQ=
From:   Borislav Petkov <bp@alien8.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org
Subject: [PATCH v0 29/42] arm64: Check notifier registration return value
Date:   Mon,  8 Nov 2021 11:11:44 +0100
Message-Id: <20211108101157.15189-30-bp@alien8.de>
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
 arch/arm64/kernel/setup.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
index be5f85b0a24d..e66af9de7cd7 100644
--- a/arch/arm64/kernel/setup.c
+++ b/arch/arm64/kernel/setup.c
@@ -440,8 +440,10 @@ static struct notifier_block arm64_panic_block = {
 
 static int __init register_arm64_panic_block(void)
 {
-	atomic_notifier_chain_register(&panic_notifier_list,
-				       &arm64_panic_block);
+	if (atomic_notifier_chain_register(&panic_notifier_list,
+					   &arm64_panic_block))
+		pr_warn("Panic notifier already registered\n");
+
 	return 0;
 }
 device_initcall(register_arm64_panic_block);
-- 
2.29.2

