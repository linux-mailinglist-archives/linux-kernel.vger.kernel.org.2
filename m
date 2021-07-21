Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C5363D18A7
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 23:07:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbhGUU0v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 16:26:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:35594 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229453AbhGUU0u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 16:26:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D81AD613E4;
        Wed, 21 Jul 2021 21:07:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626901646;
        bh=jY2gLD2yZrkJGS1/aaLZf6sXBdRM4OoSPuXXjktVwqo=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=OwUN9pWXpcFfXke4y80+852IR9NaOnEnwMgs2GiuFcgyjc2MmCS3YMIYI6hnaOnoP
         0tJsKxp93roVR5L7+8BlHLjX8ZdxA2DF9ofcjCl54Dl0pwByftGCnNETYvH+Igl6OW
         4EXWSsXypxTRnMDFZORZn6eFuK5kFyhs0LHUYh9Ly4JpjoWAlykTP0H73qNLlSR9MI
         fKapK0pWEDwuHASlbPMLD8rB9sS1nDk/bfmWVGbwLCplhVzbHcJJMZPtclgECbZ73y
         PW33/o/hHwh7k307kwyeU2m61U2RYws0dUWbt4wTj42IzNej+VuvVy+gPb+IBD5nUR
         RXPozB/U/SoPQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 970AC5C09A4; Wed, 21 Jul 2021 14:07:26 -0700 (PDT)
Date:   Wed, 21 Jul 2021 14:07:26 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        kernel-team@fb.com, mingo@kernel.org
Cc:     elver@google.com, andreyknvl@google.com, glider@google.com,
        dvyukov@google.com, cai@lca.pw, boqun.feng@gmail.com
Subject: [PATCH kcsan 0/8] KCSAN updates for v5.15
Message-ID: <20210721210726.GA828672@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

This series contains KCSAN updates:

1.	Improve some Kconfig comments, courtesy of Marco Elver.

2.	Remove CONFIG_KCSAN_DEBUG, courtesy of Marco Elver.

3.	Introduce CONFIG_KCSAN_STRICT, courtesy of Marco Elver.

4.	Reduce get_ctx() uses in kcsan_found_watchpoint(), courtesy of
	Marco Elver.

5.	Rework atomic.h into permissive.h, courtesy of Marco Elver.

6.	Print if strict or non-strict during init, courtesy of Marco
	Elver.

7.	permissive: Ignore data-racy 1-bit value changes, courtesy of
	Marco Elver.

8.	Make strict mode imply interruptible watchers, courtesy of
	Marco Elver.

						Thanx, Paul

------------------------------------------------------------------------

 Documentation/dev-tools/kcsan.rst   |    8 ++++
 b/Documentation/dev-tools/kcsan.rst |    4 ++
 b/kernel/kcsan/core.c               |    9 ----
 b/kernel/kcsan/kcsan_test.c         |   32 ++++++++++++++++
 b/kernel/kcsan/permissive.h         |   47 ++++++++++++++++++++++++
 b/lib/Kconfig.kcsan                 |   16 ++++----
 kernel/kcsan/atomic.h               |   23 ------------
 kernel/kcsan/core.c                 |   68 +++++++++++++++++++++++++-----------
 kernel/kcsan/permissive.h           |   49 +++++++++++++++++++++++++
 lib/Kconfig.kcsan                   |   26 +++++++++++--
 10 files changed, 218 insertions(+), 64 deletions(-)
