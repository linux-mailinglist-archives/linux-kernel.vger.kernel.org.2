Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA23832667F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 18:53:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230203AbhBZRw0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 12:52:26 -0500
Received: from mx2.suse.de ([195.135.220.15]:54850 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230049AbhBZRvu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 12:51:50 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 84CDCAFCC;
        Fri, 26 Feb 2021 17:51:08 +0000 (UTC)
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     tglx@linutronix.de
Cc:     mingo@redhat.com, peterz@infradead.org, dvhart@infradead.org,
        dave@stgolabs.net, linux-kernel@vger.kernel.org,
        Davidlohr Bueso <dbueso@suse.de>
Subject: [PATCH 4/4] kernel/futex: Explicitly document pi_lock for pi_state owner fixup
Date:   Fri, 26 Feb 2021 09:50:29 -0800
Message-Id: <20210226175029.50335-4-dave@stgolabs.net>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210226175029.50335-1-dave@stgolabs.net>
References: <20210226175029.50335-1-dave@stgolabs.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This seems to belong in the serialization and lifetime rules section.
pi_state_update_owner() will take the pi_mutex's owner's pi_lock to
do whatever fixup, successful or not.

Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
---
 kernel/futex.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/futex.c b/kernel/futex.c
index dcd6132485e1..475055715371 100644
--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -981,6 +981,7 @@ static inline void exit_pi_state_list(struct task_struct *curr) { }
  * p->pi_lock:
  *
  *	p->pi_state_list -> pi_state->list, relation
+ *	pi_mutex->owner -> pi_state->owner, relation
  *
  * pi_state->refcount:
  *
-- 
2.26.2

