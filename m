Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6442C3FCC89
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 19:50:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240492AbhHaRv2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 13:51:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240476AbhHaRv1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 13:51:27 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74A88C061575
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 10:50:32 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id q21so11112870plq.3
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 10:50:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ImsuJq21r778cYC29NRozNa+V9mlYmB3V8FvT/fMOvg=;
        b=TW+AKE1AX7lJIe+FdSW+0+8me9dUiOeoiCXLEN9i1i8q/Md9/T1ijSzR9RIaTE7vyK
         niCR659+tBM/cWxMRTcM1+UtTyDbp0Z3PPafvU+qss2rc2PATKKGfDJV49XoN4LFCjTD
         sx5ChzQqiUkZtL9kyhS+D13uRl2TpUYw42KZaeoMeMSXnIbbfqd7rI5z0M7T2IZfMcnY
         Q2sqEjwQVkTPXYWLMsxNc+oqvXmptHQUrHdIS6H7GrKSW6fdZESXgXme22T0a7VPbn8y
         alJBaHg2q7zQ45RwiBDmxC9dfdxiy727uL3Xf+hC19dwEjcwZyNR1mHpxcPl9nlBO7zM
         +Hvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ImsuJq21r778cYC29NRozNa+V9mlYmB3V8FvT/fMOvg=;
        b=ptlpQzK1Vf/3MfsjSnan4QtctbuSHrhVpDynSb/5lY9y89mGnFiDNCdjo1CAvtqDD+
         /dZ6gJPvs1AC7XRbiCC6VKpRO/D/Ndocco8rmL5yH9TRU352i6UWcGGhF+XOFIGz0s+W
         WAA0U5+sSMBhZo1ZkO+36QJK3jTSSzlEwzBIilZmOFS78tzVHsrwNBXA7lrtkuAG0F9s
         ndxtncTJrcdmNXkbJhSO2uhq1OIJAFf6Aeibn9rSsyGRhMxmHFvCtWbznc/nIYNvImlU
         30bmlL3psH4Ho9EulIqNh7ohVKMLE1NI+tbwp9Qlp9McvJD8q1/xO7xGSC25dlnEUsrS
         PakQ==
X-Gm-Message-State: AOAM533h1UBVLuZQYS5jTSk29N3WNVbsADTsrYU4givj8Zd0DdA5Czq5
        D3QPs0he50iErhe9foHC/6YMEVADYMU=
X-Google-Smtp-Source: ABdhPJzAvGdG27g6gJs672S+issxWAC+KRHXVX20NJT31yZIl3EJjLzba+pirL7MZEWBio7+ydNctg==
X-Received: by 2002:a17:902:b218:b029:11a:bf7b:1a80 with SMTP id t24-20020a170902b218b029011abf7b1a80mr5728913plr.82.1630432231749;
        Tue, 31 Aug 2021 10:50:31 -0700 (PDT)
Received: from localhost ([47.251.3.230])
        by smtp.gmail.com with ESMTPSA id 23sm21319170pgk.89.2021.08.31.10.50.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 31 Aug 2021 10:50:31 -0700 (PDT)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Lai Jiangshan <laijs@linux.alibaba.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Joerg Roedel <jroedel@suse.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Chester Lin <clin@suse.com>, Juergen Gross <jgross@suse.com>
Subject: [PATCH 01/24] x86/traps: Remove stack-protector from traps.c
Date:   Wed,  1 Sep 2021 01:50:02 +0800
Message-Id: <20210831175025.27570-2-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20210831175025.27570-1-jiangshanlai@gmail.com>
References: <20210831175025.27570-1-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lai Jiangshan <laijs@linux.alibaba.com>

When stack-protector is enabled, the compiler adds some instrument code
at the beginning and the end of some functions. Many functions in traps.c
are non-instrumentable.  Moreover, stack-protector code in the beginning
of the affected function accesses the canary that might be watched by
hardware breakpoints which might also violate the non-instrumentable
nature of some functions.

So it is better to remove stack-protector from traps.c.

It is also prepared for later patches that move some entry code into
traps.c, some of which can NOT use percpu register until gsbase is
properly switched.  And stack-protector depends on the percpu register
to work.

Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
---
 arch/x86/kernel/Makefile | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
index 3e625c61f008..21aa164cece2 100644
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -48,6 +48,9 @@ KCOV_INSTRUMENT		:= n
 
 CFLAGS_head$(BITS).o	+= -fno-stack-protector
 
+CFLAGS_REMOVE_traps.o		= -fstack-protector -fstack-protector-strong
+CFLAGS_traps.o			+= -fno-stack-protector
+
 CFLAGS_irq.o := -I $(srctree)/$(src)/../include/asm/trace
 
 obj-y			:= process_$(BITS).o signal.o
-- 
2.19.1.6.gb485710b

