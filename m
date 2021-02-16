Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D38C31C8E7
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Feb 2021 11:37:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230018AbhBPKgp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Feb 2021 05:36:45 -0500
Received: from foss.arm.com ([217.140.110.172]:60202 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229912AbhBPKgH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Feb 2021 05:36:07 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6960CD6E;
        Tue, 16 Feb 2021 02:35:22 -0800 (PST)
Received: from e124901.arm.com (unknown [10.57.6.158])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id ED4023F73B;
        Tue, 16 Feb 2021 02:35:20 -0800 (PST)
From:   vincent.donnefort@arm.com
To:     peterz@infradead.org, tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, valentin.schneider@arm.com,
        Vincent Donnefort <vincent.donnefort@arm.com>
Subject: [PATCH v2 1/3] cpu/hotplug: Allowing to reset fail injection
Date:   Tue, 16 Feb 2021 10:35:04 +0000
Message-Id: <20210216103506.416286-2-vincent.donnefort@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210216103506.416286-1-vincent.donnefort@arm.com>
References: <20210216103506.416286-1-vincent.donnefort@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vincent Donnefort <vincent.donnefort@arm.com>

Currently, the only way of resetting the fail injection is to trigger a
hotplug, hotunplug or both. This is rather annoying for testing
and, as the default value for this file is -1, it seems pretty natural to
let a user write it.

Signed-off-by: Vincent Donnefort <vincent.donnefort@arm.com>

diff --git a/kernel/cpu.c b/kernel/cpu.c
index 4e11e91010e1..093f96fb0824 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -2200,6 +2200,11 @@ static ssize_t write_cpuhp_fail(struct device *dev,
 	if (ret)
 		return ret;
 
+	if (fail == CPUHP_INVALID) {
+		st->fail = fail;
+		return count;
+	}
+
 	if (fail < CPUHP_OFFLINE || fail > CPUHP_ONLINE)
 		return -EINVAL;
 
-- 
2.25.1

