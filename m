Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D31B8352429
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 01:48:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236058AbhDAXrQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 19:47:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:50782 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233677AbhDAXrM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 19:47:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B4BC0601FB;
        Thu,  1 Apr 2021 23:47:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617320832;
        bh=hQpws+350Uvap6ebEPGY4mqBornP8+cVYTRGADWkfyM=;
        h=From:To:Cc:Subject:Date:From;
        b=IpgwrqB0DfeelYwCgnoCS0JdZOJdgNzrWHekQLJpPmlkiUByWmzyEhZOaTgnjALKy
         S563f8F+flH3VJ5YokytzTL70FuzWcEqkWJYXYvxHUJFwwiYwPJzRSxxcao+aAEoiS
         NcpC0TMOVJ2wQC4jSamCs62qqa1pCC7r6Yw+pJoYstt+zkPQ/RtxEo0sbg2JzeBmXb
         WjUZCtDTjswUrSLAdZsKY/sKtrXBrdyyGkujUjavt77PveQCy3Yt7FbtRZoepN/uG9
         9Y2Td2L4ADUbbSan+pf5fzhM++h1QKhhmD3/vtogYyTjf4zUAZNnrTVzEvIQAinNIZ
         54DdifjQUUeoQ==
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
Subject: [PATCH 0/3] srcu: Fix boot stall
Date:   Fri,  2 Apr 2021 01:47:01 +0200
Message-Id: <20210401234704.125498-1-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a fix for a boot stall that can be reproduced with
"rcupdate.rcu_self_test=1" and CONFIG_PROVE_RCU=y.

It should be easy to trigger if you set CONFIG_MAXSMP=y and you don't
actually have thousands of CPUs.

git://git.kernel.org/pub/scm/linux/kernel/git/frederic/linux-dynticks.git
	rcu/dev

HEAD: 6390b2aa1295f79150fac8f5ff60177eea5d8f8b

Thanks,
	Frederic
---

Frederic Weisbecker (3):
      srcu: Remove superfluous ssp initialization on deferred work queue
      srcu: Remove superfluous sdp->srcu_lock_count zero filling
      srcu: Fix broken node geometry after early ssp init


 include/linux/srcutree.h |  1 +
 kernel/rcu/srcutree.c    | 81 +++++++++++++++++++++++++++++++++++++-----------
 2 files changed, 64 insertions(+), 18 deletions(-)
