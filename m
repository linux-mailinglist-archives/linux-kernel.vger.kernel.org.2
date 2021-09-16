Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A685440D981
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 14:10:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239274AbhIPMMQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 08:12:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:59068 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239255AbhIPMMO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 08:12:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2493A60F4A;
        Thu, 16 Sep 2021 12:10:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631794253;
        bh=UgEA4kb2lcXFksBos8a4QPeHgOcznXv68lDgy/caka8=;
        h=From:To:Cc:Subject:Date:From;
        b=tqRkWUGdwHafR5Rpk8vhheAO1GkRUbKNR/w2xBboWF0oiLyelUT+Dj3TFZes5D7C1
         1+/OJpc128HrR4nZt+gQlAwwK2HqF2lL/d4KEI02sxpRSOM4UHC3eHkwBO1muZdJKB
         SeEhZb9AsWlZcm0X0LUkAMpi94wh40lubbjGCSeY8E5G+EqUxhV9GSUZxVLZL9ymWw
         OUeGM222wfdlyQ16F/l4EpQ936AywnS/HUrSt/pEQikYZqgu1bKwE6Y2ohLFHYTZTu
         gcuKixmVV7C1qwHKdwCkir9McEBMEU8TynMmkUHfe6QfxewjQf/hpdToG3EWfHGIfy
         u0CVXgOUrkT+Q==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Paul E . McKenney" <paulmck@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>, rcu@vger.kernel.org,
        urezki@gmail.com, boqun.feng@gmail.com,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        joel@joelfernandes.org
Subject: [PATCH 0/4] rcu: Unify a bit [non-]PREEMPT expedited quiescent state report
Date:   Thu, 16 Sep 2021 14:10:44 +0200
Message-Id: <20210916121048.36623-1-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This eventually removes rcu_data.exp_deferred_qs to use
rcu_data.cpu no_qs.b.exp instead.

For those like me who need a headlamp to walk there: https://ibb.co/3d06r0V

git://git.kernel.org/pub/scm/linux/kernel/git/frederic/linux-dynticks.git
	rcu/dev

HEAD: 7d9d8a0c6141f95cbac4367b12e755bfabb383ee

Thanks,
	Frederic
---

Frederic Weisbecker (4):
      rcu: Ignore rdp.cpu_no_qs.b.exp on premptible RCU's rcu_qs()
      rcu: Remove useless WRITE_ONCE() on rcu_data.exp_deferred_qs
      rcu: Move rcu_data.cpu_no_qs.b.exp reset to rcu_export_exp_rdp()
      rcu: Remove rcu_data.exp_deferred_qs and convert to rcu_data.cpu no_qs.b.exp


 kernel/rcu/tree.h        |  1 -
 kernel/rcu/tree_exp.h    |  6 +++---
 kernel/rcu/tree_plugin.h | 24 +++++++++++++-----------
 3 files changed, 16 insertions(+), 15 deletions(-)
