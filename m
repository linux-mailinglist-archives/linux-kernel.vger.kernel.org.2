Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B34345DE64
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 17:11:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356558AbhKYQNj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 11:13:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:36162 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1356315AbhKYQLv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 11:11:51 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7718461100;
        Thu, 25 Nov 2021 16:08:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637856516;
        bh=N5TLbEnpaRUARJ76fwRz7ItfnXC2ozGdxm0U6oH0+KE=;
        h=From:To:Cc:Subject:Date:From;
        b=Cb0vmqBIiyBwLDI/QA9Hy+DbIBlokK6kWIuIoGUkhO0UaFUvwO5Q87Ds1bOKEJbzC
         b6eXrH5+8Z1X0W3z2H2aZotndER7wWRxvXQiCcFQuUFwwlEGMEwqL8WytnVuoQZEaI
         AbQorLSh//vLx1Zv9eOJUe6zbMcpCOcWD825NPdDBF1Q6zlhPjq0yYD+i6PWdrY1u+
         B5+bdT9FOF145ZSaB/LFppGP5RYaNj6IUZeH7c1AmHUL22P25k092IioiU04EabR7m
         ucvoQZcHsRoc3O0p7b6dcrgwwtRRyWxr3LEyJgK99rRdNl89BxwnDwG8DkXb57D0pR
         cnGSogHSG+MwA==
From:   SeongJae Park <sj@kernel.org>
To:     akpm@linux-foundation.org
Cc:     john.stultz@linaro.org, tglx@linutronix.de, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, SeongJae Park <sj@kernel.org>
Subject: [PATCH v2 0/2] mm/damon: Fix fake /proc/loadavg reports
Date:   Thu, 25 Nov 2021 16:08:28 +0000
Message-Id: <20211125160830.30153-1-sj@kernel.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset fixes DAMON's fake load report issue.  The first patch
makes yet another variant of usleep_range() for this fix, and the second
patch fixes the issue of DAMON by making it using the newly introduced
function.

I think these need to be applied on v5.15.y, but the second patch cannot
cleanly applied there as is.  I will back-port this on v5.15.y and post
later once this is merged in the mainline.  If you think this is not
appropriate for stable tree, please let me know.

Changelog
---------

From v1
(https://lore.kernel.org/linux-mm/20211124145219.32866-1-sj@kernel.org/)
- Avoid copy-and-pasting usleep_delay() in DAMON code (Andrew Morton)

SeongJae Park (2):
  timers: Implement usleep_idle_range()
  mm/damon/core: Fix fake load reports due to uninterruptible sleeps

 include/linux/delay.h | 14 +++++++++++++-
 kernel/time/timer.c   | 16 +++++++++-------
 mm/damon/core.c       |  6 +++---
 3 files changed, 25 insertions(+), 11 deletions(-)

-- 
2.17.1

