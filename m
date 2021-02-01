Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 143AD30A5A5
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 11:42:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233277AbhBAKm3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 05:42:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233227AbhBAKjt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 05:39:49 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37209C06174A
        for <linux-kernel@vger.kernel.org>; Mon,  1 Feb 2021 02:38:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=hT32F+1+qzGAoz9OMfU1+7KvTmDOul429ef8JLlGlMU=; b=HON1Y9zoy+HZJVURjuTsUGK7VS
        Od0avc1J481uaLQzAAdV6Qif+2zWN2zJLrfwQvCr5ph8iMKNAVaPaNtEf5OKuYUAKCriStQsCic9g
        ATsJv01g0r2AxLdWY+SUqm/G8x3dZWIV4p/cih4YDbydu/kSShabhEm8+7ieN9sbl7+e1s2GuF5i3
        cyClyJx4e5JU0F/YyCYh1ZbAZKGAubLoMbXg1iGQMQwVmfQisMvTXf+FNx+I/Ksht5/FXGHyprWjc
        +fKNkAe3BI3D2IXKZWTqu8iQH1B3cop+SZgf8eVSIWMEsAVnY5gzx7QIZeN8HXqlX/TJB/2r2goc8
        n5jjW54A==;
Received: from i7.infradead.org ([2001:8b0:10b:1:21e:67ff:fecb:7a92])
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1l6WbM-000286-CC; Mon, 01 Feb 2021 10:38:36 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1l6WbL-004NPZ-7h; Mon, 01 Feb 2021 10:38:35 +0000
From:   David Woodhouse <dwmw@amazon.co.uk>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Andy Lutomirski <luto@kernel.org>,
        "shenkai (D)" <shenkai8@huawei.com>, mimoja@amazon.com,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        X86 ML <x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>,
        hewenliang4@huawei.com, hushiyuan@huawei.com,
        luolongjun@huawei.com, hejingxian@huawei.com
Subject: [PATCH 5/6] cpu/hotplug: Move idle_thread_get() to <linux/smpboot.h>
Date:   Mon,  1 Feb 2021 10:38:34 +0000
Message-Id: <20210201103835.1043254-5-dwmw@amazon.co.uk>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210201103835.1043254-1-dwmw@amazon.co.uk>
References: <478c56af540eaa47b8f452e51cb0c085f26db738.camel@infradead.org>
 <20210201103835.1043254-1-dwmw@amazon.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: David Woodhouse <dwmw2@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by merlin.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of relying purely on the special-case wrapper in bringup_cpu()
to pass the idle thread to __cpu_up(), expose idle_thread_get() so that
the architecture code can obtain it directly when necessary.

This will be useful when the existing __cpu_up() is split into multiple
phases, only *one* of which will actually need the idle thread.

If the architecture code is to register its new pre-bringup states with
the cpuhp core, having a special-case wrapper to pass extra arguments is
non-trivial and it's easier just to let the arch register its function
pointer to be invoked with the standard API.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 include/linux/smpboot.h | 7 +++++++
 kernel/smpboot.h        | 2 --
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/include/linux/smpboot.h b/include/linux/smpboot.h
index 9d1bc65d226c..3862addcaa34 100644
--- a/include/linux/smpboot.h
+++ b/include/linux/smpboot.h
@@ -5,6 +5,13 @@
 #include <linux/types.h>
 
 struct task_struct;
+
+#ifdef CONFIG_GENERIC_SMP_IDLE_THREAD
+struct task_struct *idle_thread_get(unsigned int cpu);
+#else
+static inline struct task_struct *idle_thread_get(unsigned int cpu) { return NULL; }
+#endif
+
 /* Cookie handed to the thread_fn*/
 struct smpboot_thread_data;
 
diff --git a/kernel/smpboot.h b/kernel/smpboot.h
index 34dd3d7ba40b..60c609318ad6 100644
--- a/kernel/smpboot.h
+++ b/kernel/smpboot.h
@@ -5,11 +5,9 @@
 struct task_struct;
 
 #ifdef CONFIG_GENERIC_SMP_IDLE_THREAD
-struct task_struct *idle_thread_get(unsigned int cpu);
 void idle_thread_set_boot_cpu(void);
 void idle_threads_init(void);
 #else
-static inline struct task_struct *idle_thread_get(unsigned int cpu) { return NULL; }
 static inline void idle_thread_set_boot_cpu(void) { }
 static inline void idle_threads_init(void) { }
 #endif
-- 
2.29.2

