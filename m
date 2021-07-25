Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5245E3D4CE7
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jul 2021 11:23:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230398AbhGYImq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jul 2021 04:42:46 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33124 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230261AbhGYImp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jul 2021 04:42:45 -0400
Date:   Sun, 25 Jul 2021 09:22:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1627204995;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=Eb8zLkzibuB3a5eXs48XQ3FjSRtMvgHsc2zWAWQ3Scw=;
        b=AGQsy5RtV/5v2PpwXEtipJCv4PtZzdqjZUiVeW6kU78f/qyBKxVgvxm8HJZgffzrggJIns
        0cl7Im/URVxCg9kzyMdb0Nlj117dIMpyCRwC6l5tGQSQd9F9DCRKZfRB6USLju4f9nir7U
        wxNsVOsSCfShb8dsiz/aX/UGjnstnx/QydLaB+CUjch2imwWyDyHTvD4ZEWZ9JZypyZT85
        8A+p1HZjL6BApTAoiz98u6OtlceM64HhqcC8fpbm00mPBrqwwh05dlmibbLWF4tgbb7FCa
        q3v+a89J8enjsoARUcLeRgD1Z7llQbbz3cwWJMjJH5ogAP04byodlvW/WnvL2g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1627204995;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=Eb8zLkzibuB3a5eXs48XQ3FjSRtMvgHsc2zWAWQ3Scw=;
        b=Dt33gh5U1sqFCtyJXSkNqjEmvLSwoknYiX7DPZPaOCiiad1zlDm0yfIuuSPyPQWI1IQvyd
        tBdyrZfGXux3qsDg==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] core/urgent for v5.14-rc3
Message-ID: <162720492071.8837.4047241618315201209.tglx@nanos>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest core/urgent branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core-urgent-2021-07-25

up to:  e9ba16e68cce: smpboot: Mark idle_init() as __always_inlined to work around aggressive compiler un-inlining

A single update for the boot code to prevent aggressive un-inlining which
causes a section mismatch.

Thanks,

	tglx

------------------>
Ingo Molnar (1):
      smpboot: Mark idle_init() as __always_inlined to work around aggressive compiler un-inlining


 kernel/smpboot.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/smpboot.c b/kernel/smpboot.c
index e4163042c4d6..21b7953f8242 100644
--- a/kernel/smpboot.c
+++ b/kernel/smpboot.c
@@ -47,7 +47,7 @@ void __init idle_thread_set_boot_cpu(void)
  *
  * Creates the thread if it does not exist.
  */
-static inline void idle_init(unsigned int cpu)
+static inline void __always_inline idle_init(unsigned int cpu)
 {
 	struct task_struct *tsk = per_cpu(idle_threads, cpu);
 

