Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4D6A353A0D
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Apr 2021 00:25:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231454AbhDDV66 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Apr 2021 17:58:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:34660 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230151AbhDDV6y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Apr 2021 17:58:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 63C556124B;
        Sun,  4 Apr 2021 21:58:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617573529;
        bh=GRKgEktbMMmCxWmrJOBVbr4iKnjUkhowFua49t1IAss=;
        h=From:To:Cc:Subject:Date:From;
        b=UsccQQe8LsmO3fOVklDLcmuS5e7CitE22ScMntAagjTdbpjxgzYEy8dgVnwCqcAxw
         kdrAyRTu2ImKBjVL7fZaSLwvAzdWXioYNRodvfO2Nz1lvDTxqD69v+8VhSheuvyWtB
         KyUftOMGAOuEYe5IJfn8VTbtwGjeQL3Q8jxsJ1j1JkgUFrqCbUek7slGDdBM1DrSdd
         WYX+volGERLZAtUKnE85LhrS7FCXoauYauhR9Hk27cV51ZUr7VIkOo9n0LeRtO8BoO
         sqmyT5CNMEYJeEbgoSp9CxaxWPEKgXbRcKXTIkZ36M7ruQFnCI8n2gWAkA2+2/QqeQ
         Lh7gJISEg7Dig==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Paul E . McKenney" <paulmck@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: [PATCH] doc: Fix mistaken diagram references in RCU
Date:   Sun,  4 Apr 2021 23:58:43 +0200
Message-Id: <20210404215843.8413-1-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 3 diagrams describing rcu_gp_init() all spuriously refer to the same
figure, probably due to some copy/paste issue. Fix the references.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 .../RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.rst   | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.rst b/Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.rst
index 3f6ce41ee0c5..11cdab037bff 100644
--- a/Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.rst
+++ b/Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.rst
@@ -339,14 +339,14 @@ The diagram below shows the path of ordering if the leftmost
 leftmost ``rcu_node`` structure offlines its last CPU and if the next
 ``rcu_node`` structure has no online CPUs).
 
-.. kernel-figure:: TreeRCU-gp-init-1.svg
+.. kernel-figure:: TreeRCU-gp-init-2.svg
 
 The final ``rcu_gp_init()`` pass through the ``rcu_node`` tree traverses
 breadth-first, setting each ``rcu_node`` structure's ``->gp_seq`` field
 to the newly advanced value from the ``rcu_state`` structure, as shown
 in the following diagram.
 
-.. kernel-figure:: TreeRCU-gp-init-1.svg
+.. kernel-figure:: TreeRCU-gp-init-3.svg
 
 This change will also cause each CPU's next call to
 ``__note_gp_changes()`` to notice that a new grace period has started,
-- 
2.25.1

