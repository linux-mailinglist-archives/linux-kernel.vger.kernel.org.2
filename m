Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FDFD4116D7
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 16:26:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237173AbhITO1x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 10:27:53 -0400
Received: from outbound-smtp22.blacknight.com ([81.17.249.190]:42412 "EHLO
        outbound-smtp22.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236397AbhITO1w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 10:27:52 -0400
Received: from mail.blacknight.com (pemlinmail02.blacknight.ie [81.17.254.11])
        by outbound-smtp22.blacknight.com (Postfix) with ESMTPS id D6476BB0A3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 15:26:24 +0100 (IST)
Received: (qmail 4462 invoked from network); 20 Sep 2021 14:26:24 -0000
Received: from unknown (HELO stampy.112glenside.lan) (mgorman@techsingularity.net@[84.203.17.29])
  by 81.17.254.9 with ESMTPA; 20 Sep 2021 14:26:24 -0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: [PATCH 0/2] Scale wakeup granularity relative to nr_running
Date:   Mon, 20 Sep 2021 15:26:12 +0100
Message-Id: <20210920142614.4891-1-mgorman@techsingularity.net>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's unfortunate this is colliding with Plumbers but part of the
discussions are on select_idle_sibling and hackbench is a common
reference workload for evaluating select_idle_sibling. The
downside is that hackbench is sensitive to other factors much
more than the SIS cost. A major component is the value of
kernel.sched_wakeup_granularity_ns and this series tackles that
bit.

Patch 1 is minor, it was spotted while developing patch 2.

Patch 2 scales kernel.sched_wakeup_granularity_ns so allow
	tasks to avoid preemption longer when the machine
	is heavily overloaded.

-- 
2.31.1

