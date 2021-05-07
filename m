Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 588D1376C52
	for <lists+linux-kernel@lfdr.de>; Sat,  8 May 2021 00:13:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229970AbhEGWOt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 18:14:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:33264 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229869AbhEGWOf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 18:14:35 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4A21F61164;
        Fri,  7 May 2021 22:13:34 +0000 (UTC)
Date:   Fri, 7 May 2021 18:13:32 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <wagi@monom.org>,
        Tom Zanussi <zanussi@kernel.org>,
        "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>,
        ycollette.nospam@free.fr,
        "Ahmed S. Darwish" <a.darwish@linutronix.de>
Subject: [ANNOUNCE] 5.10.30-rt38
Message-ID: <20210507181332.43f2597c@gandalf.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Dear RT Folks,

I'm pleased to announce the 5.10.30-rt38 stable release.


You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v5.10-rt
  Head SHA1: a2847d56ef8c309b56d0c2c56324e56df275ae05


Or to build 5.10.30-rt38 directly, the following patches should be applied:

  http://www.kernel.org/pub/linux/kernel/v5.x/linux-5.10.tar.xz

  http://www.kernel.org/pub/linux/kernel/v5.x/patch-5.10.30.xz

  http://www.kernel.org/pub/linux/kernel/projects/rt/5.10/patch-5.10.30-rt38.patch.xz



You can also build from 5.10.30-rt37 by applying the incremental patch:

  http://www.kernel.org/pub/linux/kernel/projects/rt/5.10/incr/patch-5.10.30-rt37-rt38.patch.xz



Enjoy,

-- Steve


Changes from v5.10.30-rt37:

---

Ahmed S. Darwish (1):
      net: xfrm: Use sequence counter with associated spinlock

Steven Rostedt (VMware) (1):
      Linux 5.10.30-rt38

----
 include/net/netns/xfrm.h | 2 +-
 localversion-rt          | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)
---------------------------
diff --git a/include/net/netns/xfrm.h b/include/net/netns/xfrm.h
index b59d73d529ba..e816b6a3ef2b 100644
--- a/include/net/netns/xfrm.h
+++ b/include/net/netns/xfrm.h
@@ -73,7 +73,7 @@ struct netns_xfrm {
 	struct dst_ops		xfrm6_dst_ops;
 #endif
 	spinlock_t		xfrm_state_lock;
-	seqcount_t		xfrm_state_hash_generation;
+	seqcount_spinlock_t	xfrm_state_hash_generation;
 
 	spinlock_t xfrm_policy_lock;
 	struct mutex xfrm_cfg_mutex;
diff --git a/localversion-rt b/localversion-rt
index a3b2408c1da6..49bae8d6aa67 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt37
+-rt38
