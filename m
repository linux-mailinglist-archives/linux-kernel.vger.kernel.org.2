Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0827640D4C8
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 10:43:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235196AbhIPIoR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 04:44:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233866AbhIPIoP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 04:44:15 -0400
Received: from michel.telenet-ops.be (michel.telenet-ops.be [IPv6:2a02:1800:110:4::f00:18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AD73C061766
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 01:42:55 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed20:39fa:3565:945d:98f4])
        by michel.telenet-ops.be with bizsmtp
        id uYim2500S3mHZPk06YimpP; Thu, 16 Sep 2021 10:42:53 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1mQmyj-0053tp-S0; Thu, 16 Sep 2021 10:42:45 +0200
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1mQmyj-004q6a-AI; Thu, 16 Sep 2021 10:42:45 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Matt Fleming <matt@codeblueprint.co.uk>,
        Mel Gorman <mgorman@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, Gon Solo <gonsolo@gmail.com>,
        linux-mm@kvack.org, linux-sh@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 0/2] Fix NUMA without SMP
Date:   Thu, 16 Sep 2021 10:42:41 +0200
Message-Id: <cover.1631781495.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi all,

SuperH is the only architecture which still supports NUMA without SMP,
for good reasons (various memories scattered around the address space,
each with varying latencies).  This series fixes two build errors due to
variables and functions used by the NUMA code being provided by SMP-only
source files or sections.

These are compile-tested only, as the remote Migo-R is MIA.

Thanks for your comments!

Geert Uytterhoeven (2):
  mm: Move node_reclaim_distance to fix NUMA without SMP
  mm: Move fold_vm_numa_events() to fix NUMA without SMP

 kernel/sched/topology.c |  1 -
 mm/page_alloc.c         |  2 ++
 mm/vmstat.c             | 56 ++++++++++++++++++++---------------------
 3 files changed, 30 insertions(+), 29 deletions(-)

-- 
2.25.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
