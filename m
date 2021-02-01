Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA603309FC1
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 01:47:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230087AbhBAAqH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jan 2021 19:46:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbhBAAqE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jan 2021 19:46:04 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31A73C061573
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jan 2021 16:45:24 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id 7so14797588wrz.0
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jan 2021 16:45:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=1eI6OoxYY5CxELsJMC/RuUDLfGSNJ12HWpkeH0Ey/O0=;
        b=PnbpClYiui8NBTUXe6HVV0I35g04X2V3hYyJlOxNToAIJepdz7J1wGw+8ESIYfJVXP
         seijK/yTm5H9qAELEf/IhEinJQtmpwmJ0i46tIUgVR0dcEXF1eioXp8622LMyL//4EbX
         KhxVUu+xvI29Bk/b3tKV+PZTGXeUnr2Iy+98XGmgzqi4QWHoqaFVbJVsXdj3HbBsIgHb
         8UcKMp8cK7AA5qp/b9wQdKpMK+injIvMwkgOWYyf8+Fukt+UIcLgGo/d+W1gvhsvZcF9
         x2akI5315VAaQDCEEsIw1UaE3NRQcwJh85R2eqt6woMGd7mzC8ip3s2FukRv7UDMaBK+
         TvXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=1eI6OoxYY5CxELsJMC/RuUDLfGSNJ12HWpkeH0Ey/O0=;
        b=B4ZG2NGF832QqPAxWNpYD/J2UnFsn4P65eVM4t/AePQz1QcA9o1BoTzaCRMj/V8Hb7
         BvQcoHu2r8sHTCq9pjxvGNuDu4jLGoo6UBvSG8biopYFbOT0avhFogozWTHVWQZ9g/+p
         mCRkUxtczPUwC0uJ7253yj1vl+PWYPFGXAEEM+lKFzOygfYXzqUkahdpZ83kjGFAbqOP
         dtBdPStjaXEr8vNKrGtNVfqJDBSfMNpUj9MtnkD/q3CqWcd/ixCjIOvBMRvSqJiLiGNq
         i9tcnsDW5cCSkwhTMM5EGERfx6mDd4t1OPDxZf9dZb5BRWQHRqBhMxyshgobgybk9L1e
         jXkw==
X-Gm-Message-State: AOAM5336ASL+wh0OVgK5nhYcM2G1pEZe6K3HooqF+iVYxytJ+qvVE5dG
        TTeCNewE9R62UJ5SEgaFmeHS1uPVaCQ=
X-Google-Smtp-Source: ABdhPJz2Jjyzt4ihn9g4E5pYT75jGbcwlSEMGZmL8/fgTf1oxqd88oYOodSEsu0mpPTuZQT3I49/Jw==
X-Received: by 2002:a5d:544b:: with SMTP id w11mr15794246wrv.1.1612140321043;
        Sun, 31 Jan 2021 16:45:21 -0800 (PST)
Received: from localhost.localdomain (net-93-70-85-165.cust.vodafonedsl.it. [93.70.85.165])
        by smtp.gmail.com with ESMTPSA id z63sm19306745wme.8.2021.01.31.16.45.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 31 Jan 2021 16:45:20 -0800 (PST)
From:   Giancarlo Ferrari <giancarlo.ferrari89@gmail.com>
To:     linux-arm-kernel@lists.infradead.org, linux@armlinux.org.uk
Cc:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        rppt@kernel.org, penberg@kernel.org, geert@linux-m68k.org,
        giancarlo.ferrari@nokia.com,
        Giancarlo Ferrari <giancarlo.ferrari89@gmail.com>
Subject: [PATCH] ARM: kexec: Fix panic after TLB are invalidated
Date:   Mon,  1 Feb 2021 00:44:56 +0000
Message-Id: <1612140296-12546-1-git-send-email-giancarlo.ferrari89@gmail.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

machine_kexec() need to set rw permission in text and rodata sections
to assign some variables (e.g. kexec_start_address). To do that at
the end (after flushing pdm in memory, etc.) it needs to invalidate
TLB [section] entries.

If during the TLB invalidation an interrupt occours, which might cause
a context switch, there is the risk to inject invalid TLBs, with ro
permissions.

When trying to assign .text labels, this lead to the following:

 Unable to handle kernel paging request at virtual address 80112f38
 pgd = fd7ef03e
 [80112f38] *pgd=0001141e(bad)
 Internal error: Oops: 80d [#1] PREEMPT SMP ARM
 ...

Signed-off-by: Giancarlo Ferrari <giancarlo.ferrari89@gmail.com>
---
 arch/arm/kernel/machine_kexec.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/kernel/machine_kexec.c b/arch/arm/kernel/machine_kexec.c
index 5d84ad3..23e8816 100644
--- a/arch/arm/kernel/machine_kexec.c
+++ b/arch/arm/kernel/machine_kexec.c
@@ -174,6 +174,13 @@ void machine_kexec(struct kimage *image)
 
 	reboot_code_buffer = page_address(image->control_code_page);
 
+	/*
+	 * If below part is not atomic TLB entries might be corrupted after TLB
+	 * invalidation, which leads to Data Abort in .text variable assignment
+	 */
+	raw_local_irq_disable();
+	local_fiq_disable();
+
 	/* Prepare parameters for reboot_code_buffer*/
 	set_kernel_text_rw();
 	kexec_start_address = image->start;
@@ -181,6 +188,9 @@ void machine_kexec(struct kimage *image)
 	kexec_mach_type = machine_arch_type;
 	kexec_boot_atags = image->arch.kernel_r2;
 
+	local_fiq_enable();
+	raw_local_irq_enable();
+
 	/* copy our kernel relocation code to the control code page */
 	reboot_entry = fncpy(reboot_code_buffer,
 			     &relocate_new_kernel,
-- 
2.7.4

