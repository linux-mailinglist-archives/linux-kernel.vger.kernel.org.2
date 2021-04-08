Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B371358B51
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 19:28:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232718AbhDHR2J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 13:28:09 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:52242 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232418AbhDHR2I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 13:28:08 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 138HJAKb104624;
        Thu, 8 Apr 2021 17:27:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2020-01-29;
 bh=Vflg6A0fEo3bhVfOYXzyU6u39/Gvn+V8Q3taoGkOQcI=;
 b=kX3EzOiOs5AnTC56Z/F8ykmS3SfJ5vL7W6kGr3gD9Sgf6nPDtCQhUiaN0T3w4SEFiBVO
 gidRLIRZQ8qocgJfJfpcE/udEEslPvC1MK3iEiE5HkUC90XGO/bK8ZCFay/9TQVGIwEj
 SDctsN/Ol+wh4zoq3ezmFeA0Ju5fFZbDP6gfD/E2WEKP/JSJi5yeV7nBFuIEy5dhgGKH
 ZbCc8Ev0Her2JoxXKGtQmDWCyopNHMtwB659bujIzi/86s0pbc0Wozw/sf2oFarRTzEM
 P97rrr0sql7zhcGf4ue6LM6ruyTf+wTTA2+3rXoB3CpE+c8CzSAsMgpivcrq0dYHmd9S Hg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2130.oracle.com with ESMTP id 37rvaw6rj8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 08 Apr 2021 17:27:37 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 138HQC4T171076;
        Thu, 8 Apr 2021 17:27:36 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by aserp3030.oracle.com with ESMTP id 37rvbgk31u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 08 Apr 2021 17:27:36 +0000
Received: from aserp3030.oracle.com (aserp3030.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 138HQDtO171304;
        Thu, 8 Apr 2021 17:27:36 GMT
Received: from brm-x62-20.us.oracle.com (brm-x62-20.us.oracle.com [10.80.150.35])
        by aserp3030.oracle.com with ESMTP id 37rvbgk31c-1;
        Thu, 08 Apr 2021 17:27:36 +0000
From:   Thomas Tai <thomas.tai@oracle.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org
Cc:     sean.j.christopherson@intel.com, luto@amacapital.net,
        jarkko@kernel.org, bp@suse.de, jethro@fortanix.com,
        alexandre.chartre@oracle.com, linux-kernel@vger.kernel.org,
        thomas.tai@oracle.com
Subject: [PATCH 1/2] x86/traps: call cond_local_irq_disable before returning from exc_general_protection and math_error
Date:   Thu,  8 Apr 2021 13:28:33 -0400
Message-Id: <1617902914-83245-1-git-send-email-thomas.tai@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-ORIG-GUID: c7kJkqlbWiDGncCxk8h6CbzkIaDLMEkU
X-Proofpoint-GUID: c7kJkqlbWiDGncCxk8h6CbzkIaDLMEkU
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9948 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 phishscore=0 mlxlogscore=999 spamscore=0 malwarescore=0
 mlxscore=0 bulkscore=0 impostorscore=0 adultscore=0 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104080115
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes commit 334872a09198 ("x86/traps: Attempt to fixup exceptions
in vDSO before signaling") which added return statements without calling
cond_local_irq_disable(). According to commit ca4c6a9858c2
("x86/traps: Make interrupt enable/disable symmetric in C code"),
cond_local_irq_disable() is needed because the ASM return code no
longer disables interrupts. Follow the existing code as an example to
use "goto exit" instead of "return" statement.

Signed-off-by: Thomas Tai <thomas.tai@oracle.com>
---
 arch/x86/kernel/traps.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index ac1874a..651e3e5 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -556,7 +556,7 @@ static enum kernel_gp_hint get_kernel_gp_address(struct pt_regs *regs,
 		tsk->thread.trap_nr = X86_TRAP_GP;
 
 		if (fixup_vdso_exception(regs, X86_TRAP_GP, error_code, 0))
-			return;
+			goto exit;
 
 		show_signal(tsk, SIGSEGV, "", desc, regs, error_code);
 		force_sig(SIGSEGV);
@@ -1057,7 +1057,7 @@ static void math_error(struct pt_regs *regs, int trapnr)
 		goto exit;
 
 	if (fixup_vdso_exception(regs, trapnr, 0, 0))
-		return;
+		goto exit;
 
 	force_sig_fault(SIGFPE, si_code,
 			(void __user *)uprobe_get_trap_addr(regs));
-- 
1.8.3.1

