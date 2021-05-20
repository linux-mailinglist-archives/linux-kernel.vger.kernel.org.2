Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E94A38B842
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 22:20:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235618AbhETUWI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 16:22:08 -0400
Received: from mail.skyhub.de ([5.9.137.197]:39994 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235187AbhETUWH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 16:22:07 -0400
Received: from zn.tnic (p200300ec2f0eb6004ea338741347d147.dip0.t-ipconnect.de [IPv6:2003:ec:2f0e:b600:4ea3:3874:1347:d147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id CDB0A1EC0666;
        Thu, 20 May 2021 22:20:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1621542044;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:in-reply-to:
         references; bh=k8fpufNJdi+DAKJ+3MVSuUIIZxEyJMOmWV9YsuJP6E0=;
        b=YSvdfYMC1e3PLgxmsgOdrc3SFAmbMorcDJnwNmPRxBpyEmimR/4Px5pCwS01aQD1gneCBK
        wmIW8xk7NF2HYWa3V4y1ZI2rqFH2m48lHmoKHaZNhXgPLMyVhmHo1gHg1G+gFAe5Ub5NRu
        IXPnX+s5Pxx/rvXui6VlJhWvwJbBH7c=
From:   Borislav Petkov <bp@alien8.de>
To:     X86 ML <x86@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH] notifier: Return non-null when callback already registered
Date:   Thu, 20 May 2021 22:20:33 +0200
Message-Id: <20210520202033.23851-1-bp@alien8.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

The notifier registration routine doesn't return a proper error value
when a callback has already been registered, leading people to track
whether that regisration has happened at the call site:

  https://lore.kernel.org/amd-gfx/20210512013058.6827-1-mukul.joshi@amd.com/

Which is unnecessary.

Return a non-null to signal that case so that callers can act
accordingly.

Signed-off-by: Borislav Petkov <bp@suse.de>
---
 kernel/notifier.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/kernel/notifier.c b/kernel/notifier.c
index 1b019cbca594..ff7a3198c5fc 100644
--- a/kernel/notifier.c
+++ b/kernel/notifier.c
@@ -25,7 +25,7 @@ static int notifier_chain_register(struct notifier_block **nl,
 	while ((*nl) != NULL) {
 		if (unlikely((*nl) == n)) {
 			WARN(1, "double register detected");
-			return 0;
+			return 1;
 		}
 		if (n->priority > (*nl)->priority)
 			break;
@@ -134,7 +134,7 @@ static int notifier_call_chain_robust(struct notifier_block **nl,
  *
  *	Adds a notifier to an atomic notifier chain.
  *
- *	Currently always returns zero.
+ *	Returns 0 on success, !0 on error.
  */
 int atomic_notifier_chain_register(struct atomic_notifier_head *nh,
 		struct notifier_block *n)
@@ -235,7 +235,7 @@ NOKPROBE_SYMBOL(atomic_notifier_call_chain);
  *	Adds a notifier to a blocking notifier chain.
  *	Must be called in process context.
  *
- *	Currently always returns zero.
+ *	Returns 0 on success, !0 on error.
  */
 int blocking_notifier_chain_register(struct blocking_notifier_head *nh,
 		struct notifier_block *n)
@@ -354,7 +354,7 @@ EXPORT_SYMBOL_GPL(blocking_notifier_call_chain);
  *	Adds a notifier to a raw notifier chain.
  *	All locking must be provided by the caller.
  *
- *	Currently always returns zero.
+ *	Returns 0 on success, !0 on error.
  */
 int raw_notifier_chain_register(struct raw_notifier_head *nh,
 		struct notifier_block *n)
@@ -425,7 +425,7 @@ EXPORT_SYMBOL_GPL(raw_notifier_call_chain);
  *	Adds a notifier to an SRCU notifier chain.
  *	Must be called in process context.
  *
- *	Currently always returns zero.
+ *	Returns 0 on success, !0 on error.
  */
 int srcu_notifier_chain_register(struct srcu_notifier_head *nh,
 		struct notifier_block *n)
-- 
2.29.2

