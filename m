Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46C43369B08
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 21:53:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243438AbhDWTxi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 15:53:38 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:56012 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231337AbhDWTxh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 15:53:37 -0400
Received: from mailhost.synopsys.com (sv1-mailhost2.synopsys.com [10.205.2.132])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 2E23B400CB;
        Fri, 23 Apr 2021 19:52:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1619207580; bh=HnFETGUvMhm7zDIsx9cLfUQSofJTRcYq1eMKI/YVrBk=;
        h=From:To:Cc:Subject:Date:From;
        b=E+7NKfccz2+HHv+JYhQIbFGuoBGsTU67zn6Ul6a5EqNl9by1XMpuGCeLPbIodSNCA
         ByyO4FLb8FyV+OWFnjlgJAxIPhW81UvxXqOQGnCs+bghRViaMA4TtVNTFyoJELDeFj
         uQ094ZrduBugvNkOUawsV3s8Qs0Di4OYs2UoZQKeJN5kZS+2Cq1FjjEMJYOINgAHCL
         VnhPMOXe5r+JvHLyZgOxfRCHCp9/ZC0xsDI+CnaUeMg4fTffVClZ2eGKr1xJaqAahk
         iZ3ryWlxCO6NolKpIwp1Z43vzqr62VtLKvJUTEgkYvbq95PCxDqRpiycP3/Qp4DMnI
         L8Yw5GHIMrGbQ==
Received: from vineetg-Latitude-7400.internal.synopsys.com (unknown [10.13.183.89])
        by mailhost.synopsys.com (Postfix) with ESMTP id 12620A006F;
        Fri, 23 Apr 2021 19:52:58 +0000 (UTC)
X-SNPS-Relay: synopsys.com
From:   Vineet Gupta <Vineet.Gupta1@synopsys.com>
To:     linux-snps-arc@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org,
        Vineet Gupta <Vineet.Gupta1@synopsys.com>,
        Shahab Vahedi <Shahab.Vahedi@synopsys.com>
Subject: [PATCH] ARC: entry: fix off-by-one error in syscall number validation
Date:   Fri, 23 Apr 2021 12:52:57 -0700
Message-Id: <20210423195257.892560-1-vgupta@synopsys.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We have NR_syscall syscalls from [0 .. NR_syscall-1].
However the check for invalid syscall number is "> NR_syscall".
This off-by-one error erronesously allows "NR_syscall" itself as valid
and when passed causes out-of-bounds syscall-call table access leading
to crash.

This problem showed up when testing glibc 2.33 (v5.10 kernel capable,
includng faccessat2 syscall (439) against a v5.6 kernel with
NR_syscalls=439 (0 to 438). Due to the bug, 439 was not returned with
-ENOSYS but processed leading to a crash.

Link: https://github.com/foss-for-synopsys-dwc-arc-processors/linux/issues/48
Reported-by: Shahab Vahedi <shahab@synopsys.com>
Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
---
 arch/arc/kernel/entry.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arc/kernel/entry.S b/arch/arc/kernel/entry.S
index 1743506081da..aea9b558993d 100644
--- a/arch/arc/kernel/entry.S
+++ b/arch/arc/kernel/entry.S
@@ -255,7 +255,7 @@ ENTRY(EV_Trap)
 	;============ Normal syscall case
 
 	; syscall num shd not exceed the total system calls avail
-	cmp     r8,  NR_syscalls
+	cmp     r8,  NR_syscalls - 1
 	mov.hi  r0, -ENOSYS
 	bhi     .Lret_from_system_call
 
-- 
2.25.1

