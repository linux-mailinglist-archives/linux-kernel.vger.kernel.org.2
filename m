Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E65E637F008
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 01:44:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241154AbhELXnA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 19:43:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:52024 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243802AbhELXbT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 19:31:19 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B1BEA61417;
        Wed, 12 May 2021 23:29:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620862189;
        bh=gjHmJnnsU3Q1Vwese6/vn6GxuViDxAHN3y8e4+wDrjw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=e5uXwefl0OpwWE3zIgSMDLLkjzCMrBECfgEA1UK+vVThcs59kJMNYjY6iihTaKJAI
         tGDzevty5rqFDWPH8/TEGPOwFEnMPX+wnpXmXq5yjbmZdnS817NGLs94okp5oeEc8f
         QEotN1Td8yFhiKZr/dpBdplOwvdkrcnOfr9wkRfpW2Q85ykRqsgxSNoZ6UazIdWrWQ
         77JYNNCYcCYhz4CPg97WCtKs1FbJnOhhwkdPQPS78Vw0kB9tu77aV6QSe9Y5yvws8g
         xlVStTHaNboTOcM0k04igOKj7Um/RmWN0Z+2dbIEzk5JBVaKTSa2+fplzDmpw/ofD7
         4Zk8vSCyhvKIw==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Yunfeng Ye <yeyunfeng@huawei.com>,
        Marcelo Tosatti <mtosatti@redhat.com>
Subject: [PATCH 05/10] tick/nohz: Update nohz_full Kconfig help
Date:   Thu, 13 May 2021 01:29:19 +0200
Message-Id: <20210512232924.150322-6-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210512232924.150322-1-frederic@kernel.org>
References: <20210512232924.150322-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CONFIG_NO_HZ_FULL behaves just like CONFIG_NO_HZ_IDLE by default.
Reassure distros about it.

Acked-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Yunfeng Ye <yeyunfeng@huawei.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Marcelo Tosatti <mtosatti@redhat.com>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 kernel/time/Kconfig | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/kernel/time/Kconfig b/kernel/time/Kconfig
index 83e158d016ba..6649e1d2dba5 100644
--- a/kernel/time/Kconfig
+++ b/kernel/time/Kconfig
@@ -117,13 +117,14 @@ config NO_HZ_FULL
 	 the task mostly runs in userspace and has few kernel activity.
 
 	 You need to fill up the nohz_full boot parameter with the
-	 desired range of dynticks CPUs.
+	 desired range of dynticks CPUs to use it. This is implemented at
+	 the expense of some overhead in user <-> kernel transitions:
+	 syscalls, exceptions and interrupts.
 
-	 This is implemented at the expense of some overhead in user <-> kernel
-	 transitions: syscalls, exceptions and interrupts. Even when it's
-	 dynamically off.
+	 By default, without passing nohz_full parameter, this behaves just
+	 like NO_HZ_IDLE.
 
-	 Say N.
+	 If you're a distro say Y.
 
 endchoice
 
-- 
2.25.1

