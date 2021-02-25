Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00578324C22
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 09:39:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235930AbhBYIiI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 03:38:08 -0500
Received: from foss.arm.com ([217.140.110.172]:47668 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233814AbhBYIiB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 03:38:01 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2E575ED1;
        Thu, 25 Feb 2021 00:37:15 -0800 (PST)
Received: from e124901.arm.com (unknown [10.57.11.52])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 4029A3F70D;
        Thu, 25 Feb 2021 00:37:13 -0800 (PST)
From:   vincent.donnefort@arm.com
To:     peterz@infradead.org, mingo@redhat.com, vincent.guittot@linaro.org
Cc:     dietmar.eggemann@arm.com, linux-kernel@vger.kernel.org,
        qperret@google.com, patrick.bellasi@matbug.net,
        valentin.schneider@arm.com,
        Vincent Donnefort <vincent.donnefort@arm.com>
Subject: [PATCH v2 0/2] Fix task utilization accountability for EAS
Date:   Thu, 25 Feb 2021 08:36:10 +0000
Message-Id: <20210225083612.1113823-1-vincent.donnefort@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vincent Donnefort <vincent.donnefort@arm.com>

Changelog since v1:
  - Fix the issue in compute_energy(), as a change in cpu_util_next() would
    break the OPP selection estimation.
  - Separate patch for lsub_positive usage in cpu_util_next()

Vincent Donnefort (2):
  sched/fair: Fix task utilization accountability in compute_energy()
  sched/fair: use lsub_positive in cpu_util_next()

 kernel/sched/fair.c | 26 +++++++++++++++++++++-----
 1 file changed, 21 insertions(+), 5 deletions(-)

-- 
2.25.1

