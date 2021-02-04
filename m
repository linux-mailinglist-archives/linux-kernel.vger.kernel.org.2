Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CA7C30F4F4
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 15:30:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236702AbhBDO3a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 09:29:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236745AbhBDO1J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 09:27:09 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DAA5C061786
        for <linux-kernel@vger.kernel.org>; Thu,  4 Feb 2021 06:26:26 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id z21so2203747pgj.4
        for <linux-kernel@vger.kernel.org>; Thu, 04 Feb 2021 06:26:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=shQ3thNNr7YvQ9m2EoH4YSQbHCyV5/ReC8L7NfquPKc=;
        b=f78ME7psWJ1TxtyIjp6cRPDgxeoJlubBiumqDNlZJ9+StWZMNq+11P3J02nT2je/5u
         IgK78wZqWliFElR48ittuZeHmBMEfz04hxU5x1RTc+UERCPgYeNOej0mIUUR4i0rRejD
         hO36qzQ5Z5UPBIE05IYjpllh0zB1LAxIi1WxS9IKCqJinzAPAGWt+CKYmGgzG2c+85vj
         0TyxHzcP54ccHI9Tw+Pk8QXt7Uq+DcvN3UKjm7OHjo4jJC1K95ZxSOVzPIs0IymDlOfN
         D0RUHCr8m9xQWhHseFMmlEDVeMxCR28ZyohXu9620GAJvHimQLu/8cn/gJw9RF0okRfv
         fkMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=shQ3thNNr7YvQ9m2EoH4YSQbHCyV5/ReC8L7NfquPKc=;
        b=IuNw5XfxKRyMyGSPkhK0zPizQ6M+4XbXUNeP2x0xvRexOXwd5LmQyGX8aIptXX1OIb
         vZ+ZQaj9AlVhpQgyWppexQBZ13TZHNT+UYqCQe4dR7wkdetza2HoS40QN6URWzDdR5sP
         GlxCocziYLSOVjw9nCM2XY8ivvD9EMdzDlzJWOIquoCMpKUAxpIIRvOqa49WCUiDWhoU
         QF1B7iHwIhMg2rbzvMy5xVw4MvpOP5nyQJjsM4UyfF8slvJzNH5xDRN2iKB3j3rjpvOz
         0FASiJPX8IqlzrwUUKFgYmoe5t9CFIE1G0DmRPzaqtLunYLBlyTd977pI4zEsVk2iPw7
         UwIA==
X-Gm-Message-State: AOAM5306Ws0qT9X89faEEuTRQP6V1og7zl9UaCuOegN464c5HH/CpsAV
        +sLioBWfkL56NZxfYsqpoPyMJx+4htI=
X-Google-Smtp-Source: ABdhPJwiTEMdPyqytflQ/LnmD20aflPg9cCsfOdaSIianI9Hf0uOXPpGUbVk5S+sXPe/9ob5/Kxz4A==
X-Received: by 2002:aa7:808c:0:b029:1d5:c9d4:d39a with SMTP id v12-20020aa7808c0000b02901d5c9d4d39amr1784769pff.46.1612448785373;
        Thu, 04 Feb 2021 06:26:25 -0800 (PST)
Received: from localhost ([47.251.4.198])
        by smtp.gmail.com with ESMTPSA id h12sm6403570pgs.7.2021.02.04.06.26.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Feb 2021 06:26:24 -0800 (PST)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Lai Jiangshan <laijs@linux.alibaba.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Andy Lutomirski <luto@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        "Chang S. Bae" <chang.seok.bae@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 1/2] x86/hw_breakpoint: Prevent data breakpoints on __per_cpu_offset
Date:   Thu,  4 Feb 2021 23:27:06 +0800
Message-Id: <20210204152708.21308-1-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lai Jiangshan <laijs@linux.alibaba.com>

When FSGSBASE is enabled, paranoid_entry() fetches the per-CPU
GSBASE value via __per_cpu_offset or pcpu_unit_offsets.

When data breakpoint is set on __per_cpu_offset[cpu] (read-write
operation), the specific cpu will be stuck in the infinite #DB loop.
RCU will try to send NMI to the specific cpu, but it is not working
either since NMI also relies on paranoid_entry().

Fixes: eaad981291ee3("x86/entry/64: Introduce the FIND_PERCPU_BASE macro")
Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
---
 arch/x86/kernel/hw_breakpoint.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/x86/kernel/hw_breakpoint.c b/arch/x86/kernel/hw_breakpoint.c
index 03aa33b58165..bc7493a0736f 100644
--- a/arch/x86/kernel/hw_breakpoint.c
+++ b/arch/x86/kernel/hw_breakpoint.c
@@ -269,6 +269,20 @@ static inline bool within_cpu_entry(unsigned long addr, unsigned long end)
 			CPU_ENTRY_AREA_TOTAL_SIZE))
 		return true;
 
+	/*
+	 * When FSGSBASE is enabled, paranoid_entry() fetches the per-CPU
+	 * GSBASE value via __per_cpu_offset or pcpu_unit_offsets.
+	 */
+#ifdef CONFIG_SMP
+	if (within_area(addr, end, (unsigned long)__per_cpu_offset,
+			sizeof(unsigned long) * nr_cpu_ids))
+		return true;
+#else
+	if (within_area(addr, end, (unsigned long)&pcpu_unit_offsets,
+			sizeof(pcpu_unit_offsets)))
+		return true;
+#endif
+
 	for_each_possible_cpu(cpu) {
 		/* The original rw GDT is being used after load_direct_gdt() */
 		if (within_area(addr, end, (unsigned long)get_cpu_gdt_rw(cpu),
-- 
2.19.1.6.gb485710b

