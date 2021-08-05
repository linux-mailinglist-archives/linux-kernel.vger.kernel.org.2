Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61F463E18FB
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 18:00:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242800AbhHEQAr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 12:00:47 -0400
Received: from outbound-smtp53.blacknight.com ([46.22.136.237]:60709 "EHLO
        outbound-smtp53.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242509AbhHEQAp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 12:00:45 -0400
Received: from mail.blacknight.com (pemlinmail03.blacknight.ie [81.17.254.16])
        by outbound-smtp53.blacknight.com (Postfix) with ESMTPS id 5473DFB00E
        for <linux-kernel@vger.kernel.org>; Thu,  5 Aug 2021 17:00:30 +0100 (IST)
Received: (qmail 17347 invoked from network); 5 Aug 2021 16:00:30 -0000
Received: from unknown (HELO stampy.112glenside.lan) (mgorman@techsingularity.net@[84.203.17.255])
  by 81.17.254.9 with ESMTPA; 5 Aug 2021 16:00:30 -0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Hugh Dickins <hughd@google.com>, Linux-MM <linux-mm@kvack.org>,
        Linux-RT-Users <linux-rt-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: [PATCH 0/1 v2] Protect vmstats on PREEMPT_RT
Date:   Thu,  5 Aug 2021 17:00:18 +0100
Message-Id: <20210805160019.1137-1-mgorman@techsingularity.net>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changelog since v1
o Remove preempt_[en|dis]able_rt helper

When adding local_lock support to mm/page_alloc.c and reducing the overhead
of vmstats in general, I wondered how vmstats could be safe on PREEMPT_RT
as it partially relies on interrupts being disabled for the stats that
must be accurate for correctness. As it turns out, the preempt-rt tree
already encountered the same problem.

This series protects just the accurate counters. As Thomas expressed
concern that the preempt_enable_rt() helper could be abused, this
version open-codes the preemption with a comment explaining why it
is necessary.

This is specific to PREEMPT_RT which cannot be enabled on mainline yet
and should have no impact on !PREEMPT_RT kernels.

This patch replaces the following mmotm patches

o preempt-provide-preempt__nort-variants.patch
o mm-vmstat-protect-per-cpu-variables-with-preempt-disable-on-rt.patch

-- 
2.31.1

