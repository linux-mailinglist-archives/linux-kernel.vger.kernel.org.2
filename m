Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEC5231DFF8
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Feb 2021 21:08:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234032AbhBQUHc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Feb 2021 15:07:32 -0500
Received: from mail.efficios.com ([167.114.26.124]:39684 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233141AbhBQUH2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Feb 2021 15:07:28 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 515C932423D;
        Wed, 17 Feb 2021 15:06:47 -0500 (EST)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id X4AR5kN0c6vM; Wed, 17 Feb 2021 15:06:47 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id ED84A32423C;
        Wed, 17 Feb 2021 15:06:46 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com ED84A32423C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1613592406;
        bh=5P7Ncq4Ykb3zOPzmdqF7w3UezIdSKHZ/iWHIZuHqNxk=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=c+YJNTT/2dVfd2beLgeu8FDhRLms185g3CmbUrX77rc+eYgZlLEREMmF6EhBGJhLd
         e26wPiCKaiHYHREN2uDb1fYPgD4S8jcQ9JKLDgQhHYnaoc5bJrUblYcYM+6TggifWe
         6awnDTkPRibnvuVBZx86E8Dy46oPcKyG6ZMSBgucST+yH+z64pRBmQ804E3mLpm5qi
         qzIlnfJBHP3FaJ7oGOBhearhXDA327Bincm8ImiVJgPjewY1aWnUtbcwUuq84XSz95
         vI576UshQc2z80sHaDe60U8TcK6ItpqHwHWmEmdXGHUXMvC6//ILFJWRERZfBfpQJ/
         dky0aY1398WPw==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Iu47rLtWdr8q; Wed, 17 Feb 2021 15:06:46 -0500 (EST)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id DEAB432407E;
        Wed, 17 Feb 2021 15:06:46 -0500 (EST)
Date:   Wed, 17 Feb 2021 15:06:46 -0500 (EST)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     linux-kernel@vger.kernel.org, lttng-dev@lists.lttng.org,
        rp@svcs.cs.pdx.edu
Cc:     "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Stephen Hemminger <stephen@networkplumber.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Lai Jiangshan <jiangshanlai@gmail.com>, lwn@lwn.net
Message-ID: <424165303.25817.1613592406800.JavaMail.zimbra@efficios.com>
Subject: [RELEASE] Userspace RCU 0.11.3 and 0.12.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3996 (ZimbraWebClient - FF85 (Linux)/8.8.15_GA_3996)
Thread-Index: Q9VqS6nKdol5OMjUduAPKUZnxS3Q9Q==
Thread-Topic: Userspace RCU 0.11.3 and 0.12.2
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is a bugfix release announcement for the Userspace RCU library
(liburcu) for its two currently maintained branches.

liburcu is a LGPLv2.1 userspace RCU (read-copy-update) library. This
data synchronization library provides read-side access which scales
linearly with the number of cores. It does so by allowing multiple
copies of a given data structure to live at the same time, and by
monitoring the data structure accesses to detect grace periods after
which memory reclamation is possible.

liburcu-cds provides efficient data structures based on RCU and
lock-free algorithms. Those structures include hash tables, queues,
stacks, and doubly-linked lists.

The Changelog entries highlight the relevant fixes:

2021-02-17 Userspace RCU 0.11.3
        * fix: exclude clang from GCC version blacklists
        * aarch64: blacklist gcc prior to 5.1
        * Fix: configure: support Autoconf 2.70
        * fix: bump tests thread limit to 4096
        * cleanup: Improve wording of CONFIG_RCU_DEBUG description
        * fix: explicitly include urcu/config.h in files using CONFIG_RCU_ defines
        * Fix typo in README.md
        * fix: add -lurcu-common to pkg-config libs for each flavor
        * call_rcu: Fix race between rcu_barrier() and call_rcu_data_free()

2021-02-17 Userspace RCU 0.12.2
        * fix: exclude clang from GCC version blacklists
        * aarch64: blacklist gcc prior to 5.1
        * Fix: configure: support Autoconf 2.70
        * fix: bump tests thread limit to 4096
        * cleanup: Improve wording of CONFIG_RCU_DEBUG description
        * fix: explicitly include urcu/config.h in files using CONFIG_RCU_ defines
        * Fix typo in README.md
        * fix: add -lurcu-common to pkg-config libs for each flavor
        * call_rcu: Fix race between rcu_barrier() and call_rcu_data_free()

Project website: http://liburcu.org
Git repository: git://git.liburcu.org/urcu.git

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
