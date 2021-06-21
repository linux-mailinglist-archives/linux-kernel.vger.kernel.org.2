Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81E443AE746
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 12:39:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230204AbhFUKla (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 06:41:30 -0400
Received: from foss.arm.com ([217.140.110.172]:60430 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229621AbhFUKl3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 06:41:29 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E1F8F1FB;
        Mon, 21 Jun 2021 03:39:14 -0700 (PDT)
Received: from e120877-lin.cambridge.arm.com (e120877-lin.cambridge.arm.com [10.1.194.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A16EF3F718;
        Mon, 21 Jun 2021 03:39:13 -0700 (PDT)
From:   Vincent Donnefort <vincent.donnefort@arm.com>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com
Cc:     vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        valentin.schneider@arm.com, rostedt@goodmis.org,
        linux-kernel@vger.kernel.org,
        Vincent Donnefort <vincent.donnefort@arm.com>
Subject: [PATCH v2 0/2] Fix RT/DL utilization during policy change
Date:   Mon, 21 Jun 2021 11:37:50 +0100
Message-Id: <1624271872-211872-1-git-send-email-vincent.donnefort@arm.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

changelog since V1:
  * Simplify and merge "if" conditions for RT's switched_to
  * Collect Reviewed-by

Vincent Donnefort (2):
  sched/rt: Fix RT utilization tracking during policy change
  sched/rt: Fix Deadline utilization tracking during policy change

 kernel/sched/deadline.c |  2 ++
 kernel/sched/rt.c       | 17 ++++++++++++-----
 2 files changed, 14 insertions(+), 5 deletions(-)

-- 
2.7.4

