Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC2E533AAA3
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 06:03:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbhCOFDS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 01:03:18 -0400
Received: from mx2.suse.de ([195.135.220.15]:59752 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229851AbhCOFCw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 01:02:52 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 09B6EAD74;
        Mon, 15 Mar 2021 05:02:51 +0000 (UTC)
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     tglx@linutronix.de, mingo@redhat.com
Cc:     peterz@infradead.org, dvhart@infradead.org,
        linux-kernel@vger.kernel.org, dave@stgolabs.net,
        Davidlohr Bueso <dbueso@suse.de>
Subject: [PATCH 1/2] futex: Fix irq mismatch in exit_pi_state_list()
Date:   Sun, 14 Mar 2021 22:02:23 -0700
Message-Id: <20210315050224.107056-2-dave@stgolabs.net>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210315050224.107056-1-dave@stgolabs.net>
References: <20210315050224.107056-1-dave@stgolabs.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pi_mutex->wait_lock is irq safe and needs to enable local
interrupts upon unlocking, matching it's corresponding
raw_spin_lock_irq().

Fixes: c74aef2d06a9f (futex: Fix pi_state->owner serialization)
Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
---
 kernel/futex.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/futex.c b/kernel/futex.c
index 475055715371..ded7af2ba87f 100644
--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -885,7 +885,7 @@ static void exit_pi_state_list(struct task_struct *curr)
 		 */
 		if (head->next != next) {
 			/* retain curr->pi_lock for the loop invariant */
-			raw_spin_unlock(&pi_state->pi_mutex.wait_lock);
+			raw_spin_unlock_irq(&pi_state->pi_mutex.wait_lock);
 			spin_unlock(&hb->lock);
 			put_pi_state(pi_state);
 			continue;
-- 
2.26.2

