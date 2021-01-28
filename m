Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D69C0307564
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 13:04:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbhA1MA1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 07:00:27 -0500
Received: from mail.kingsoft.com ([114.255.44.146]:41174 "EHLO
        mail.kingsoft.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S231377AbhA1MAA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 07:00:00 -0500
X-Greylist: delayed 945 seconds by postgrey-1.27 at vger.kernel.org; Thu, 28 Jan 2021 06:59:59 EST
X-AuditID: 0a580155-713ff700000550c6-8c-60129d2b0143
Received: from mail.kingsoft.com (localhost [10.88.1.32])
        (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client did not present a certificate)
        by mail.kingsoft.com (SMG-2-NODE-85) with SMTP id B7.E6.20678.B2D92106; Thu, 28 Jan 2021 19:16:59 +0800 (HKT)
Received: from aili-OptiPlex-7020 (172.16.253.254) by KSBJMAIL2.kingsoft.cn
 (10.88.1.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Thu, 28 Jan
 2021 19:43:27 +0800
Date:   Thu, 28 Jan 2021 19:43:26 +0800
From:   Aili Yao <yaoaili@kingsoft.com>
To:     <x86@kernel.org>, <tony.luck@intel.com>, <naoya.horiguchi@nec.com>
CC:     <linux-kernel@vger.kernel.org>, <yangfeng1@kingsoft.com>
Subject: [PATCH] x86/fault: Send SIGBUS to user process always for hwpoison
 page access.
Message-ID: <20210128194326.71895e92.yaoaili@kingsoft.com>
Organization: Kingsoft
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.16.253.254]
X-ClientProxiedBy: KSBJMAIL1.kingsoft.cn (10.88.1.31) To KSBJMAIL2.kingsoft.cn
 (10.88.1.32)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrMLMWRmVeSWpSXmKPExsXCFcGooKs9VyjB4MUkJovLu+awWVxsPMBo
        8ebCPRaLHxseszqweCze85LJY9OqTjaPF1c3snh83iQXwBLFZZOSmpNZllqkb5fAlbH20mrG
        gg6Bike377A1ME7l7WLk5JAQMJG4++sGcxcjF4eQwHQmiW1fDzFCOC8YJS6+PAHkcHCwCKhK
        fLhuCNLABmTuujeLFcQWEXCTOPj9MTuIzSxgI/F4xzQWEFtYIEri1ZQOJpBWXgEriR0H0kBM
        fgExiVcNxhBr7SWe/z3LDGLzCghKnJz5hAViio7EiVXHmCFseYntb+eA2UICihKHl/xih+hV
        kjjSPYMNwo6VWDbvFesERsFZSEbNQjJqFpJRCxiZVzGyFOemG21ihIRr6A7GGU0f9Q4xMnEw
        HmKU4GBWEuF9O0coQYg3JbGyKrUoP76oNCe1+BCjNAeLkjhvuQNfgpBAemJJanZqakFqEUyW
        iYNTqoEpMHFnVffZS2vtv/9+9s/d21tMOqD9tf+/T/+4mk7UNtfYps2pffV8jptMlbD3/aNX
        5jx45BSrpWMSuGadS8dE/fd33oV83iL+7fGi6XO8GGvrb/vyBhwz21/OJL6na97iC7dlIhJy
        d7tpTD2xP/lFb8/BLw5pz3cdy9pw4s+f7dOOPOvPj0+t/8qjZ1Jo/WL51oQ5r05kFTTJ2PnP
        qb/7U+2//hyjRWH/zBgqBN+d42BLjv40JeKuhPLR+qlbhZKeTrE7wySy+6eHZMdXcVEWbc+i
        aLOc7iD3qWunzo3YL1KsVPNCK3H6VekdNy+Uboz/sncr67ufa6fY/b/N++F+XlPeGe9PnbPK
        N5hdnniRTYmlOCPRUIu5qDgRAF5VeATGAgAA
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

when one page is already hwpoisoned by AO action, process may not be
killed, the process mapping this page may make a syscall include this
page and result to trigger a VM_FAULT_HWPOISON fault, as it's in kernel
mode it may be fixed by fixup_exception, current code will just return
error code to user process.

This is not suffient, we should send a SIGBUS to the process and log the
info to console, as we can't trust the process will handle the error
correctly.

Suggested-by: Feng Yang <yangfeng1@kingsoft.com>
Signed-off-by: Aili Yao <yaoaili@kingsoft.com>
---
 arch/x86/mm/fault.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index f1f1b5a0956a..36d1e385512b 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -662,7 +662,16 @@ no_context(struct pt_regs *regs, unsigned long error_code,
 		 * In this case we need to make sure we're not recursively
 		 * faulting through the emulate_vsyscall() logic.
 		 */
+#ifdef CONFIG_MEMORY_FAILURE
+		if (si_code == BUS_MCEERR_AR && signal == SIGBUS)
+			pr_err("MCE: Killing %s:%d due to hardware memory corruption fault at %lx\n",
+				current->comm, current->pid, address);
+
+		if ((current->thread.sig_on_uaccess_err && signal) ||
+			(si_code == BUS_MCEERR_AR && signal == SIGBUS)) {
+#else
 		if (current->thread.sig_on_uaccess_err && signal) {
+#endif
 			sanitize_error_code(address, &error_code);
 
 			set_signal_archinfo(address, error_code);
@@ -927,7 +936,14 @@ do_sigbus(struct pt_regs *regs, unsigned long error_code, unsigned long address,
 {
 	/* Kernel mode? Handle exceptions or die: */
 	if (!(error_code & X86_PF_USER)) {
+#ifdef CONFIG_MEMORY_FAILURE
+		if (fault & (VM_FAULT_HWPOISON|VM_FAULT_HWPOISON_LARGE))
+			no_context(regs, error_code, address, SIGBUS, BUS_MCEERR_AR);
+		else
+			no_context(regs, error_code, address, SIGBUS, BUS_ADRERR);
+#else
 		no_context(regs, error_code, address, SIGBUS, BUS_ADRERR);
+#endif
 		return;
 	}
 
-- 
2.25.1

