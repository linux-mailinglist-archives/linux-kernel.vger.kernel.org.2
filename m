Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA5683E00A8
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 13:59:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236943AbhHDL7Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 07:59:25 -0400
Received: from outbound-smtp20.blacknight.com ([46.22.139.247]:44079 "EHLO
        outbound-smtp20.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234555AbhHDL7W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 07:59:22 -0400
Received: from mail.blacknight.com (pemlinmail02.blacknight.ie [81.17.254.11])
        by outbound-smtp20.blacknight.com (Postfix) with ESMTPS id B43761C3CC2
        for <linux-kernel@vger.kernel.org>; Wed,  4 Aug 2021 12:59:08 +0100 (IST)
Received: (qmail 29371 invoked from network); 4 Aug 2021 11:59:08 -0000
Received: from unknown (HELO stampy.112glenside.lan) (mgorman@techsingularity.net@[84.203.17.255])
  by 81.17.254.9 with ESMTPA; 4 Aug 2021 11:59:08 -0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Song Bao Hua <song.bao.hua@hisilicon.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: [PATCH 0/2] Reduce SIS scanning
Date:   Wed,  4 Aug 2021 12:58:55 +0100
Message-Id: <20210804115857.6253-1-mgorman@techsingularity.net>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the first two patches from "Modify and/or delete SIS_PROP" and
focues on improving the hit rate for recent_used_cpu and avoids rescanning
the target CPU when it's known to be busy. These are relatively simply
patches in comparison to the full series which could be a regression
magnet and that series had at least one mistake in it.

In general, the usual suspects showed mostly small gains with a few
exceptions.  Usual suspects were NAS, hackbench, schbench (Facebook
latency-sensitive workload), perf pipe, kernel building, git test suite,
dbench and redis.

From here, the next obvious candidates are either improving has_idle_cores
or continuing to try remove/improve SIS_PROP.

 kernel/sched/fair.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

-- 
2.31.1

