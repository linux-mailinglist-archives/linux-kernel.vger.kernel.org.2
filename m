Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E089832C47B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 01:54:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358805AbhCDAOW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 19:14:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:33338 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1353210AbhCDADq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 19:03:46 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3D9B364F41;
        Wed,  3 Mar 2021 23:55:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614815727;
        bh=NCIVjhT0woBYxIeC5INLVFPUlPl2KGykKUv0wnLajJc=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=ibkPEplFYbDFZssuSaJeQeKDdPxe6EnXsGSjdW+LI0kYVCRA4OS4kvzSR0wUrYh+a
         APzxryE+sl3s2BcthSka3QIx+//N+FB4oJdZfaBGVqk8uNx+cgDWG3+d6bbUrX+S+L
         lcNPRYHhtsClm0vqfkJmnACJ20V76RX/lFupS15kg/Z4FgpJepA/v/eGOnyTwmI+n7
         BTiT5/nNhq6Sdt2EzXLmXkviDmi+uHEdYg0jOjBFfeeApLnbhCcTxLKcfFfPsIHa1p
         HqGt/Ex5aqHHGVhTAojOpgntnxdIK6S4L1M70u3bxWhP3EPVZ3qcZugoJl614bf+Oc
         GbYUfm6rn+cxQ==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id E4FA63522591; Wed,  3 Mar 2021 15:55:26 -0800 (PST)
Date:   Wed, 3 Mar 2021 15:55:26 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        paul.gortmaker@windriver.com
Subject: [PATCH tip/core/rcu 0/9] Add bitmap (thus CPU) ranges
Message-ID: <20210303235526.GA21868@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

This series adds ranges to bitmaps, and thus to CPU numbers, so that a
kernel boot parameter such as "rcu_nocbs=2-N" is now permitted.

1.	test_bitmap: clearly separate ERANGE from EINVAL tests, courtesy
	of Paul Gortmaker.

2.	test_bitmap: add tests to trigger ERANGE case, courtesy of
	Paul Gortmaker.

3.	test_bitmap: add more start-end:offset/len tests, courtesy of
	Paul Gortmaker.

4.	bitmap: fold nbits into region struct, courtesy of Paul Gortmaker.

5.	bitmap: move ERANGE check from set_region to check_region,
	courtesy of Paul Gortmaker.

6.	bitmap: support "N" as an alias for size of bitmap, courtesy of
	Paul Gortmaker.

7.	test_bitmap: add tests for "N" alias, courtesy of Paul Gortmaker.

8.	deprecate "all" option to rcu_nocbs=, courtesy of Paul Gortmaker.

9.	Use "all" and "N" in "nohz_full" and "rcu_nocbs".

						Thanx, Paul

------------------------------------------------------------------------

 Documentation/admin-guide/kernel-parameters.rst            |    7 +
 Documentation/admin-guide/kernel-parameters.txt            |    4 
 kernel/rcu/tree_plugin.h                                   |    6 -
 lib/bitmap.c                                               |   55 +++++++------
 lib/test_bitmap.c                                          |   46 +++++++++-
 tools/testing/selftests/rcutorture/configs/rcu/TREE04.boot |    2 
 tools/testing/selftests/rcutorture/configs/rcu/TREE08.boot |    2 
 7 files changed, 84 insertions(+), 38 deletions(-)
