Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7191D41B27B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 17:00:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241443AbhI1PBv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 11:01:51 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:36212 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241430AbhI1PBu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 11:01:50 -0400
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1632841210;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=biqviRvIfcSjuMDwtJESDGzCrumL9mx6GJTol/qzdf8=;
        b=0NkM/7U9ER4sIBrGhG3Nlex4lok8AxFzDq0pJq4MwzSeqGhhalPRGGtKRoMGLgr1OcDi9K
        DtI2RywMiiyw63Po3Yfccg34xlW03B1mT8g7+emVs3/iZ6ycyLCk8BIDt6SQk3hCrj6coQ
        P0LJP2X2T71zvyt6cwx3/6RftaZ2G/H/bev8z/bKD3j/I0O7/+VDMjQOYyk6PeocyH7+FE
        UcH+oYFECimdSzAq+j8xKtfcGvhTIeS+BQpYrA3JTKBusfAaiYZ8qQ8miWt9G/bkkYvzHE
        7ltGaZgsoCThIE0oPE56csWu4DZJvJmx3IDaOYNZfxs1W3dixQ9Dipek2I0HDQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1632841210;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=biqviRvIfcSjuMDwtJESDGzCrumL9mx6GJTol/qzdf8=;
        b=SBZvVyG9VSyvnL+TeDLDw6TO0usqPkDM/lCZZNrHuaD+WKZF/PH6+ac6RCbE4YH5iCsupR
        8sHJeGkmBa9eW9CA==
To:     linux-kernel@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 1/2] rtmutex: Check explicit for TASK_RTLOCK_WAIT.
Date:   Tue, 28 Sep 2021 17:00:05 +0200
Message-Id: <20210928150006.597310-2-bigeasy@linutronix.de>
In-Reply-To: <20210928150006.597310-1-bigeasy@linutronix.de>
References: <20210928150006.597310-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

rt_mutex_wake_q_add() needs to  need to distiguish between sleeping
locks (TASK_RTLOCK_WAIT) and normal locks which use TASK_NORMAL to use
the proper wake mechanism.

Instead of checking for !=3D TASK_NORMAL make it more robust and check
explicit for TASK_RTLOCK_WAIT which is the reason why a different wake
mechanism is used.

No functional change.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/locking/rtmutex.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index 6bb116c559b4a..cafc259ec59d3 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -449,7 +449,7 @@ static __always_inline void rt_mutex_adjust_prio(struct=
 task_struct *p)
 static __always_inline void rt_mutex_wake_q_add(struct rt_wake_q_head *wqh,
 						struct rt_mutex_waiter *w)
 {
-	if (IS_ENABLED(CONFIG_PREEMPT_RT) && w->wake_state !=3D TASK_NORMAL) {
+	if (IS_ENABLED(CONFIG_PREEMPT_RT) && w->wake_state =3D=3D TASK_RTLOCK_WAI=
T) {
 		if (IS_ENABLED(CONFIG_PROVE_LOCKING))
 			WARN_ON_ONCE(wqh->rtlock_task);
 		get_task_struct(w->task);
--=20
2.33.0

