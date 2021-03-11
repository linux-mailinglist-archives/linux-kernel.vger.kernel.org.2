Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25CD83372D8
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 13:38:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233384AbhCKMiG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 07:38:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:59920 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233278AbhCKMhe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 07:37:34 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id BD98C64FE6;
        Thu, 11 Mar 2021 12:37:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615466254;
        bh=ybvxpwgzpYW4yZF9YvvxKaXAx/OBphRGXXx4PIbqQw4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=W/gS14MQylGB3YVJan0oDTAKUk1Ap1qO05V6mRVruQp/oWMoqOpPF0b+7hlb6brv/
         R1RR7bS1Lta2aSspKkK4N3C8TkPgtECNeb6RmcQX1yhW1eIKgpI0ZDptmsSiInJH5M
         dp0fPVRCcJc108sY5fdwrpwy3rgfCEwnNPYIZalp4+VUWMVq812j/k0MXOhq670MLV
         yXUNoJWAg/8tTU9/hkrpgkV9bPsGVqWGafvbuHh0PsqHLzCRJ1vdJ89DejiNJLOghr
         XCMP8IhWvenpC/fYuKH1f5i5Bp1G/4B8uMzmKBYVeW9NSiDlYR2Gkc3Xr7qDHOvIAe
         zKdH+J+0GLPDg==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Ti Zhou <x2019cwm@stfx.ca>, Yunfeng Ye <yeyunfeng@huawei.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 07/10] tick/nohz: Update nohz_full Kconfig help
Date:   Thu, 11 Mar 2021 13:37:05 +0100
Message-Id: <20210311123708.23501-8-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210311123708.23501-1-frederic@kernel.org>
References: <20210311123708.23501-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CONFIG_NO_HZ_FULL behaves just like CONFIG_NO_HZ_IDLE by default.
Reassure distros about it.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Yunfeng Ye <yeyunfeng@huawei.com>
Cc: Peter Zijlstra <peterz@infradead.org>
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

