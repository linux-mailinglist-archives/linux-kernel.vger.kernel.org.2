Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0FE845F02E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 15:52:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377892AbhKZOzg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 09:55:36 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:54534 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350728AbhKZOxf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 09:53:35 -0500
X-Greylist: delayed 528 seconds by postgrey-1.27 at vger.kernel.org; Fri, 26 Nov 2021 09:53:35 EST
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 710CB622A8
        for <linux-kernel@vger.kernel.org>; Fri, 26 Nov 2021 14:50:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 446D7C93056;
        Fri, 26 Nov 2021 14:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637938221;
        bh=GiaptIVWd8QNsuTNopHV7m08Achws66EMxuWiX5Oqr4=;
        h=From:To:Cc:Subject:Date:From;
        b=KIhTRDIUdHPRj+ZyZ9Zy7ATS7SKOJCyB6Q35AY0W9iAejXLR73QmVeUkcWTbx9VJw
         N37YvVf3iwdDSHj+Y7a5uloZ7IbZgTiJba5Wv+dXLBhXSEusDcpWmt3B/fg9YjxKBQ
         +KPiqDDLHt+KlMhqy5FLjQEbMhm5LKw5v6LAjyRAPbzvrfXQGBeano3RvciZWTgg+u
         FLSj7TRUbEVLk/v3AkJQZJuxiKfP++wqvzcXQ++HxyISABQmsbHwgGGxBabid2+tJQ
         rbj19ytBsGx23yhKsywgXQhxzfBuMEX72XxenWVdqxrAJ542QGblfby1Dq7gXZxM3P
         Gm7Vp2ZBOtePw==
From:   SeongJae Park <sj@kernel.org>
To:     akpm@linux-foundation.org
Cc:     oleksandr@natalenko.name, john.stultz@linaro.org,
        tglx@linutronix.de, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, SeongJae Park <sj@kernel.org>
Subject: [PATCH v3 0/2] mm/damon: Fix fake /proc/loadavg reports
Date:   Fri, 26 Nov 2021 14:50:13 +0000
Message-Id: <20211126145015.15862-1-sj@kernel.org>
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

From v2
(https://lore.kernel.org/linux-mm/20211125160830.30153-1-sj@kernel.org/)
- Cc Oleksandr (Oleksandr Natalenko)
- Add 'Suggested-by:' for Andrew Morton on the first patch

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

