Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DC3137B26F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 01:23:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229984AbhEKXYc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 19:24:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:52192 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229714AbhEKXYb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 19:24:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CD57561626;
        Tue, 11 May 2021 23:23:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620775404;
        bh=RjLBvtlhn8y90g+29DLll+RUReBAbwWYe0r7rgI5q6w=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=cz5C+K8kPB9qjdnHJKLTGJRPSqxAVpeWo6GBMql2uQMxRVqQPwbO0mM2i4oTu1lv3
         N/QmTZyWihOsN1hczA7f+cSeAKO4SBP9kZQcqQAra9TXFKc/CwqttYQm4bsALC/U1O
         fEItV2TDvk+8O812TuQQ/3TsGk4VQp4pQOq61j7i5ARdp4aCaye9fZYptAXoCLcGpj
         L012EJS/TLjR/I4alwthuq5LeU9PNEc2g09RE/TUHnFKu7vOyjBcpd4/OpBJoM4tNr
         eFR6u1+n8obYJWfkN2HV0nyM5JhQhR2mi3dCocaA0VjTHh0WzgEGWf+O6I7F8xUcW0
         z6AgaXZgeJUAQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 8CF3B5C0138; Tue, 11 May 2021 16:23:24 -0700 (PDT)
Date:   Tue, 11 May 2021 16:23:24 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        kernel-team@fb.com, mingo@kernel.org
Cc:     elver@google.com, andreyknvl@google.com, glider@google.com,
        dvyukov@google.com, cai@lca.pw, boqun.feng@gmail.com
Subject: [PATCH kcsan 0/10] KCSAN updates for v5.14
Message-ID: <20210511232324.GA2896130@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

This series provides KCSAN updates.

1.	Add pointer to access-marking.txt to data_race() bullet.

2.	Simplify value change detection, courtesy of Mark Rutland.

3.	Distinguish kcsan_report() calls, courtesy of Mark Rutland.

4.	Refactor passing watchpoint/other_info, courtesy of Mark Rutland.

5.	Fold panic() call into print_report(), courtesy of Mark Rutland.

6.	Refactor access_info initialization, courtesy of Mark Rutland.

7.	Remove reporting indirection, courtesy of Mark Rutland.

8.	Remove kcsan_report_type, courtesy of Mark Rutland.

9.	Report observed value changes, courtesy of Mark Rutland.

10.	Document "value changed" line, courtesy of Marco Elver.

						Thanx, Paul

------------------------------------------------------------------------

 Documentation/dev-tools/kcsan.rst   |   88 +++++-------
 b/Documentation/dev-tools/kcsan.rst |    4 
 b/kernel/kcsan/core.c               |   40 ++---
 b/kernel/kcsan/kcsan.h              |   10 -
 b/kernel/kcsan/report.c             |   26 +++
 kernel/kcsan/core.c                 |   17 +-
 kernel/kcsan/kcsan.h                |   39 ++---
 kernel/kcsan/report.c               |  251 +++++++++++++++++-------------------
 8 files changed, 226 insertions(+), 249 deletions(-)
