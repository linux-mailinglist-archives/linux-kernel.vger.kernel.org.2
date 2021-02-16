Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF60931C8E6
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Feb 2021 11:37:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbhBPKgj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Feb 2021 05:36:39 -0500
Received: from foss.arm.com ([217.140.110.172]:60194 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229812AbhBPKgG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Feb 2021 05:36:06 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8F3581FB;
        Tue, 16 Feb 2021 02:35:20 -0800 (PST)
Received: from e124901.arm.com (unknown [10.57.6.158])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 3AED03F73B;
        Tue, 16 Feb 2021 02:35:19 -0800 (PST)
From:   vincent.donnefort@arm.com
To:     peterz@infradead.org, tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, valentin.schneider@arm.com,
        Vincent Donnefort <vincent.donnefort@arm.com>
Subject: [PATCH v2 0/3] cpu/hotplug: rollback and "fail" interface fixes
Date:   Tue, 16 Feb 2021 10:35:03 +0000
Message-Id: <20210216103506.416286-1-vincent.donnefort@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vincent Donnefort <vincent.donnefort@arm.com>

This patch-set intends to unify steps call throughout hotplug and
hotunplug.

It also improves the "fail" interface, which can now be reset and will
reject states for which a failure can't be recovered.

v2:
  - Reject all DEAD steps in the fail interface.
  - Do not try to recover from a DEAD step failure.
  - WARN on DEAD step failure.
  - Additional comment in cpuhp_reset_state().
  - Fix WARN_ON coding style issues.

Vincent Donnefort (3):
  cpu/hotplug: Allowing to reset fail injection
  cpu/hotplug: CPUHP_BRINGUP_CPU failure exception
  cpu/hotplug: Add cpuhp_invoke_callback_range()

 kernel/cpu.c | 194 ++++++++++++++++++++++++++++++++-------------------
 1 file changed, 123 insertions(+), 71 deletions(-)

-- 
2.25.1

