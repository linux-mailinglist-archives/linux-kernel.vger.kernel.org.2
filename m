Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01B67367FF6
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 14:02:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236237AbhDVMCz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 08:02:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:56460 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236186AbhDVMCv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 08:02:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A2FCF613FA;
        Thu, 22 Apr 2021 12:02:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619092936;
        bh=ybvxpwgzpYW4yZF9YvvxKaXAx/OBphRGXXx4PIbqQw4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uPHDA6dDTiDuGZw6+M2gJKhICMTo2R3iGsdsE3QFumEVu/bqPmLZe2Vu55o2XcwsV
         BKVHjYe78DyG0joF6Ar/OowNYztd85qrl3CGFSalFaoZ8vXNenSm1L0DxmhPhPDOmE
         UodNwNYNRMdRzzDUK950Ww1ozWO3dJGeZ4xDNarinGLfJB8ua4tAJHLNe3YE/o/RM0
         ctK4RQTjoEQB+nEstCpwlqnLDPhL68PY56QhPKtDXMwikKHfHbaP9L9PhPk7rQLcXC
         ykx9/hrTE3TLELDQyA/wJaYBGjD3laV7KI95q9s2ZkMdUMaob/uxPnyTtptbcJsSzJ
         ID4K0S/jmTrIg==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Yunfeng Ye <yeyunfeng@huawei.com>,
        Marcelo Tosatti <mtosatti@redhat.com>
Subject: [PATCH 5/8] tick/nohz: Update nohz_full Kconfig help
Date:   Thu, 22 Apr 2021 14:01:55 +0200
Message-Id: <20210422120158.33629-6-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210422120158.33629-1-frederic@kernel.org>
References: <20210422120158.33629-1-frederic@kernel.org>
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

