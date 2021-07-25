Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 805C23D4CE8
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jul 2021 11:23:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230507AbhGYIms (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jul 2021 04:42:48 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33136 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230261AbhGYImr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jul 2021 04:42:47 -0400
Date:   Sun, 25 Jul 2021 09:22:03 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1627204997;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=Cd4e2r3jo2golk2TebXcR45n/VWNC1F1Awju3umH8oE=;
        b=AGRy3tDI8Xb+lJ7oDEdr9jdOxRrbjV9t0Xjrid1ymIWr6pd4qCwTC1YQ0cIvSVc7VpcErp
        cKRAoRja4gxpWg6+RLHNHbvsl5gA74Is246gRCB/gFHrsjpiuoUPzBaLbh/3mHVgoGKyJc
        CXZiLco+7wXQpDdVtnjAy/LqBoBIMOxjtT0aIN1MheqCmD7e1ZBt7xHsbRJXvYwtnmiYVK
        ZHynewhAMZkl1P55txW//cYFd7TSUUxhXabzd6N0vKjaGthvNtUIA1yQQ8jhmN1b4DbRJ9
        dX8pWtlFrtQx1DM/EiBTrHtEHYLoOo6t55OEyTHUc56q4OyvFS0ntXTYCKG53Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1627204997;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=Cd4e2r3jo2golk2TebXcR45n/VWNC1F1Awju3umH8oE=;
        b=DQ4LmLtfQALJjMQocbxP5dJDzFggFikWS4UdG6NOR8LP9wi6mtSQ+idqTZhOvRWq3n3vU+
        FMevNdJDINLmAqBQ==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] locking/urgent for v5.14-rc3
References: <162720492071.8837.4047241618315201209.tglx@nanos>
Message-ID: <162720492312.8837.12317399957006920016.tglx@nanos>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest locking/urgent branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking-urgent-2021-07-25

up to:  e48a12e546ec: jump_labels: Mark __jump_label_transform() as __always_inlined to work around aggressive compiler un-inlining

A single fix for jump labels to prevent the compiler from agressive
un-inlining which results in a section mismatch.

Thanks,

	tglx

------------------>
Ingo Molnar (1):
      jump_labels: Mark __jump_label_transform() as __always_inlined to work around aggressive compiler un-inlining


 arch/x86/kernel/jump_label.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/jump_label.c b/arch/x86/kernel/jump_label.c
index 674906fad43b..68f091ba8443 100644
--- a/arch/x86/kernel/jump_label.c
+++ b/arch/x86/kernel/jump_label.c
@@ -79,9 +79,10 @@ __jump_label_patch(struct jump_entry *entry, enum jump_label_type type)
 	return (struct jump_label_patch){.code = code, .size = size};
 }
 
-static inline void __jump_label_transform(struct jump_entry *entry,
-					  enum jump_label_type type,
-					  int init)
+static __always_inline void
+__jump_label_transform(struct jump_entry *entry,
+		       enum jump_label_type type,
+		       int init)
 {
 	const struct jump_label_patch jlp = __jump_label_patch(entry, type);
 

