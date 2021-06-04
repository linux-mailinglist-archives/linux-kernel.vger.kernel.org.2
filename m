Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98BFF39BB06
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 16:41:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229938AbhFDOnF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 10:43:05 -0400
Received: from mail.skyhub.de ([5.9.137.197]:51854 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229778AbhFDOnE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 10:43:04 -0400
Received: from zn.tnic (p200300ec2f138500346025dad93ce3b3.dip0.t-ipconnect.de [IPv6:2003:ec:2f13:8500:3460:25da:d93c:e3b3])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 1AB481EC0402;
        Fri,  4 Jun 2021 16:41:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1622817677;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:in-reply-to:
         references; bh=qPyJV0r0gCUPNZF3Q3I+9vLGOG6rK1aBAVsO1EM+EVI=;
        b=Zm5RIMQhltphw3/nC8otWa/mPezLeLUau57c1ydlfiR++kVSfj+g14dCwUq3a3i3kbteup
        UQJuuxb+caqrzn014QT8nnm1xjZrD/kbioZS0G0k/7OIHoQzHZbFYJyaiRKQdRXSxD4KSZ
        Jiwap8leevhgBI9uJSiVyM/9BxSYt8Y=
From:   Borislav Petkov <bp@alien8.de>
To:     X86 ML <x86@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH -v2] notifier: Return non-null when callback is already registered
Date:   Fri,  4 Jun 2021 16:41:02 +0200
Message-Id: <20210604144102.13849-1-bp@alien8.de>
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

Return -EEXIST to signal that case so that callers can act accordingly.

Signed-off-by: Borislav Petkov <bp@suse.de>
---
 kernel/notifier.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/kernel/notifier.c b/kernel/notifier.c
index 1b019cbca594..5a31bc9b24b4 100644
--- a/kernel/notifier.c
+++ b/kernel/notifier.c
@@ -25,7 +25,7 @@ static int notifier_chain_register(struct notifier_block **nl,
 	while ((*nl) != NULL) {
 		if (unlikely((*nl) == n)) {
 			WARN(1, "double register detected");
-			return 0;
+			return -EEXIST;
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

