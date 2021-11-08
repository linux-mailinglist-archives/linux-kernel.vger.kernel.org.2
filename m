Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C859447DA1
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Nov 2021 11:16:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237313AbhKHKSA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 05:18:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238595AbhKHKPU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 05:15:20 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39F46C061208
        for <linux-kernel@vger.kernel.org>; Mon,  8 Nov 2021 02:12:29 -0800 (PST)
Received: from zn.tnic (p200300ec2f33110088892b77bd117736.dip0.t-ipconnect.de [IPv6:2003:ec:2f33:1100:8889:2b77:bd11:7736])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id CE3381EC0505;
        Mon,  8 Nov 2021 11:12:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1636366347;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PzOPuLscGxVueOEHDmBojbj7Lh0Tq2B/QQr/AISfS/c=;
        b=qtAqqdfn1THtPBwyPZBq12j9u2vAbZjxAt+6yxyE6OsirMpQ47UK4gYN2Hdp58Xs7J05iN
        bh8/xOqrOsNaoECN9NUk8rTbTEwlObG73wNNX5+feEHN8t6ey1S5Lbq0smyNfQ8aH18olT
        eyPeR84afp74lzjxI/CpNOdws01/YgY=
From:   Borislav Petkov <bp@alien8.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     linux-um@lists.infradead.org
Subject: [PATCH v0 25/42] arch/um: Check notifier registration return value
Date:   Mon,  8 Nov 2021 11:11:40 +0100
Message-Id: <20211108101157.15189-26-bp@alien8.de>
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
Cc: linux-um@lists.infradead.org
---
 arch/um/drivers/mconsole_kern.c | 6 ++++--
 arch/um/kernel/um_arch.c        | 5 +++--
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/arch/um/drivers/mconsole_kern.c b/arch/um/drivers/mconsole_kern.c
index 6ead1e240457..ceea940c0aa0 100644
--- a/arch/um/drivers/mconsole_kern.c
+++ b/arch/um/drivers/mconsole_kern.c
@@ -856,8 +856,10 @@ static struct notifier_block panic_exit_notifier = {
 
 static int add_notifier(void)
 {
-	atomic_notifier_chain_register(&panic_notifier_list,
-			&panic_exit_notifier);
+	if (atomic_notifier_chain_register(&panic_notifier_list,
+					   &panic_exit_notifier))
+		pr_warn("UM console panic notifier already registered\n");
+
 	return 0;
 }
 
diff --git a/arch/um/kernel/um_arch.c b/arch/um/kernel/um_arch.c
index 54447690de11..6c0e562ff0b7 100644
--- a/arch/um/kernel/um_arch.c
+++ b/arch/um/kernel/um_arch.c
@@ -255,8 +255,9 @@ static struct notifier_block panic_exit_notifier = {
 
 void uml_finishsetup(void)
 {
-	atomic_notifier_chain_register(&panic_notifier_list,
-				       &panic_exit_notifier);
+	if (atomic_notifier_chain_register(&panic_notifier_list,
+					   &panic_exit_notifier))
+		pr_warn("UM panic notifier already registered\n");
 
 	uml_postsetup();
 
-- 
2.29.2

