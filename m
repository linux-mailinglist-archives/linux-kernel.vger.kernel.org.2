Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDE65305B39
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 13:25:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237922AbhA0MY0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 07:24:26 -0500
Received: from esa8.hc1455-7.c3s2.iphmx.com ([139.138.61.253]:64467 "EHLO
        esa8.hc1455-7.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237702AbhA0MWd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 07:22:33 -0500
X-Greylist: delayed 462 seconds by postgrey-1.27 at vger.kernel.org; Wed, 27 Jan 2021 07:22:32 EST
IronPort-SDR: fS/mM9559bN0OSrG9m5SF0zTMlhNhKcH2cabQyJ5LrrwfPLljHi5Soe3Dy4sZS0YVe0vTO6eRX
 1Rcs9HrmT8o0Xe4VXkiyN7Vf28LPFxCZl2bF9bvkqp7k5O+SnsqZCkM/2YfbwbTM0PQKepsVgc
 vOL3PGvdbS4RPlfyNW62AIrVUhVcGbdzlUhrpMOtpHsuUfgH2D8HD/qTb4jvb10thRwmIl3EBR
 9F4wBlYesnPhaxKvrhK7iiLJoGpEalToS80WlZ2SwNXulutbCSNCTm/txG4DoLuQEDsHyK/GbG
 ZAs=
X-IronPort-AV: E=McAfee;i="6000,8403,9876"; a="4890707"
X-IronPort-AV: E=Sophos;i="5.79,379,1602514800"; 
   d="scan'208";a="4890707"
Received: from unknown (HELO oym-r2.gw.nic.fujitsu.com) ([210.162.30.90])
  by esa8.hc1455-7.c3s2.iphmx.com with ESMTP; 27 Jan 2021 21:12:31 +0900
Received: from oym-m1.gw.nic.fujitsu.com (oym-nat-oym-m1.gw.nic.fujitsu.com [192.168.87.58])
        by oym-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id EE99DE0382
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 21:12:30 +0900 (JST)
Received: from g01jpfmpwkw02.exch.g01.fujitsu.local (g01jpfmpwkw02.exch.g01.fujitsu.local [10.0.193.56])
        by oym-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id 43C19B4E3E
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 21:12:30 +0900 (JST)
Received: from G01JPEXCHKW13.g01.fujitsu.local (G01JPEXCHKW13.g01.fujitsu.local [10.0.194.52])
        by g01jpfmpwkw02.exch.g01.fujitsu.local (Postfix) with ESMTP id 374B432879F;
        Wed, 27 Jan 2021 21:12:29 +0900 (JST)
Received: from luna3.soft.fujitsu.com (10.124.196.199) by
 G01JPEXCHKW13.g01.fujitsu.local (10.0.194.52) with Microsoft SMTP Server id
 14.3.487.0; Wed, 27 Jan 2021 21:12:29 +0900
From:   Misono Tomohiro <misono.tomohiro@jp.fujitsu.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <x86@kernel.org>, <hpa@zytor.com>, <tglx@linutronix.de>,
        <mingo@redhat.com>, <bp@alien8.de>,
        <misono.tomohiro@jp.fujitsu.com>
Subject: [PATCH] x86/msr: Filter msr write by X86_IOC_WRMSR_REGS ioctl
Date:   Wed, 27 Jan 2021 21:24:56 +0900
Message-ID: <20210127122456.13939-1-misono.tomohiro@jp.fujitsu.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-SecurityPolicyCheck-GC: OK by FENCE-Mail
X-TM-AS-GCONF: 00
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit a7e1f67ed29f ("x86/msr: Filter MSR writes") introduces a
module parameter to disable writing to msr device file (and add_taint()
upon writing). As msr register can be written by X86_IOC_WRMSR_REGS
ioctl too, they should be applied to the ioctl as well.

Fixes: a7e1f67ed29f ("x86/msr: Filter MSR writes")
Signed-off-by: Misono Tomohiro <misono.tomohiro@jp.fujitsu.com>
---
Hello,

I just noticed this when I read the code.
I'm not sure if anyone uses ioctl interface now, but I tested this
by resetting IA32_MPERF by X86_IOC_WRMSR_REGS ioctl.

Thanks,

 arch/x86/kernel/msr.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/kernel/msr.c b/arch/x86/kernel/msr.c
index 8a67d1fa8dc5..d774618e75b8 100644
--- a/arch/x86/kernel/msr.c
+++ b/arch/x86/kernel/msr.c
@@ -182,6 +182,10 @@ static long msr_ioctl(struct file *file, unsigned int ioc, unsigned long arg)
 		err = security_locked_down(LOCKDOWN_MSR);
 		if (err)
 			break;
+		err = filter_write(regs[1]);
+		if (err)
+			return err;
+		add_taint(TAINT_CPU_OUT_OF_SPEC, LOCKDEP_STILL_OK);
 		err = wrmsr_safe_regs_on_cpu(cpu, regs);
 		if (err)
 			break;
-- 
2.26.2

