Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 073B4358FDD
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 00:39:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232807AbhDHWjU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 18:39:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:48056 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232265AbhDHWjT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 18:39:19 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E52FE61159;
        Thu,  8 Apr 2021 22:39:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617921547;
        bh=icfb0cOZJw/ZYwhixn2emBhXKyyyLN9A85mxaGxW8W0=;
        h=From:To:Cc:Subject:Date:From;
        b=EMBUrJya0fJBxbVEH5D3mPfriQ9dDT7k9ips2tuXnTD2iIPW3HUhQ4LUlzquiM127
         fzqTbMAXF1Ub0C3WpzjbN78viFbKmPLaJZzO5BiDpBOdjTr8BfstAGrgt0R+Cxb96t
         7jEvUF/1SZRB0n1Wql51UYo0+JuaXYO8ZGmNx7isl6O0jbqHE0y/O6P0JJqMrqMLll
         oNic2WU2M30xbozKGl7EZBSb+4fz2tc/mzbZbFEQtNuoXzgFUk/3ErOR40t3jGQn3O
         DPi/SINIx57dZosJv16Hsrp+zf5TmZmbtSYFerMijoBgwUvnLFkNgPn2WB44eTUicp
         ZC1nZCumYDJHA==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Paul E . McKenney" <paulmck@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: [PATCH 0/5] srcu: Fix boot stall v2
Date:   Fri,  9 Apr 2021 00:38:57 +0200
Message-Id: <20210408223902.6405-1-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


So here is a different approach to solve the early SRCU issue.
Early initialized ssp's are reset on srcu_init() and their callbacks get
requeued.

I expanded testing in the last patch.

git://git.kernel.org/pub/scm/linux/kernel/git/frederic/linux-dynticks.git
	rcu/dev

HEAD: 0dc3551822c74a0f34783cbd64a9199c9758ec6d

Thanks,
	Frederic
---

Frederic Weisbecker (5):
      srcu: Unconditionally embed struct lockdep_map
      srcu: Initialize SRCU after timers
      srcu: Fix broken node geometry after early ssp init
      srcu: Queue a callback in case of early started poll
      srcu: Early test SRCU polling start


 include/linux/srcu.h     |   6 +++
 include/linux/srcutree.h |   4 +-
 init/main.c              |   2 +
 kernel/rcu/rcu.h         |   6 ---
 kernel/rcu/srcutree.c    | 119 ++++++++++++++++++++++++++++++++++++++++++-----
 kernel/rcu/tiny.c        |   1 -
 kernel/rcu/tree.c        |   1 -
 kernel/rcu/update.c      |  12 ++++-
 8 files changed, 129 insertions(+), 22 deletions(-)
