Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AF4135F4C7
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 15:24:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347180AbhDNNYt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 09:24:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:48166 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1351459AbhDNNYk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 09:24:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id ACF8061001;
        Wed, 14 Apr 2021 13:24:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618406658;
        bh=UYGL7D9KGLRHOvyvMh5DQO63MVVUR/C4t72rujQmv8Q=;
        h=From:To:Cc:Subject:Date:From;
        b=FK2QJhVJBVA2WZk5J0Pzdvna13oQ7+yOy9VrpBTDnLCYLh0qKh53pDU7DfcfxXg3U
         mpWHlXl2H3F/O3zxh69oJusE+wuMF6XcaaMv0B3x01ZSSPm1HUrJVWysy/DhNJceSg
         wU0Jmes4Fak+y0/AWSTeX4mwIcsZ1Bo23bbGJ+5NBLWYNqv6som0ndAtXya5C87Pia
         9/PAmDg+Heezen04JUpdK+wWjYS1NgOY33TdYyrSpX3pRlb9RQVa8PYNetoxYC8dTd
         9GGTVGHPv6qZ+VsydbQOn2Tkdjb1Pzw4KuUjgW0vNtYAoHfOAFqWzyxvRIo0ZZSi9X
         xZ4Y56OCwrJfg==
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
Subject: [PATCH 0/2] srcu: Fix early boot hang v3
Date:   Wed, 14 Apr 2021 15:24:11 +0200
Message-Id: <20210414132413.98062-1-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Another approach, suggested offlist by Paul. Much more
simple and maintainable. Enjoy!

git://git.kernel.org/pub/scm/linux/kernel/git/frederic/linux-dynticks.git
	rcu/dev-v3

HEAD: bd6cef5d990e47a523027aea95f80537644af55e

Thanks,
	Frederic
---

Frederic Weisbecker (2):
      srcu: Fix broken node geometry after early ssp init
      srcu: Early test SRCU polling start


 kernel/rcu/rcu.h      |  3 +++
 kernel/rcu/srcutree.c |  2 ++
 kernel/rcu/tree.c     | 18 +++++++++++++++++-
 kernel/rcu/update.c   |  6 +++++-
 4 files changed, 27 insertions(+), 2 deletions(-)
