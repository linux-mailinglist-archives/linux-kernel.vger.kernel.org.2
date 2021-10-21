Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA5C6436B8E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 21:52:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231948AbhJUTzK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 15:55:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231924AbhJUTzI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 15:55:08 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D187DC061764
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 12:52:51 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id q187so1278869pgq.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 12:52:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZkXKIl0cvonpSMPGbZtkMfANAFTOohR0bKnvqthvOXw=;
        b=JutQJLFxA+3lL90mZzR5yi7o5P/8Etyk+Xr3rSPjfgVQe85aUnXiu7bYYc2kWNmws2
         VsWMouTl3YB6Pq7NcS6pip1fYYxtcsG3Ez9la13QpAVxXaucpYDuWh6Kd7AFNOUJ8617
         TkPo8H2jC7nB16PUtjcOBdfU1sOT5kEiNQWcN+dfy7bDzVNNqOib0MHgbWgRYIYe8SXP
         devpb+kyUVY+LYsB5JUab9lEr7+nSM+QGrY0gspIVN3HpCeXSaurHAn38A9kRy0rWbdW
         Mi2kYLEgwZAQlKct4VpEm4YyuoppuvNr2dzsguH/Jv6uMMDPf4En3Ar4tOL1U5Ovph9W
         adeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZkXKIl0cvonpSMPGbZtkMfANAFTOohR0bKnvqthvOXw=;
        b=GfVQUACa3xW37ZGm1XskaYYu2DpQFk+izND1lHQIxQb9LNWRCiieEoZ6EYkFKpZJmm
         iIZiB/6qKI9noKEJFTCx2ZKx0J1idIDjHcQX7h6kVDLac1FlT1m/5w5JcbToakAgsBfO
         NEYEUU5cSXZgtXpNlRA3tcpiBVsV9xNRoG1zDXygine94ubszetFkpP1YfI4CkS2ggKu
         eN65BVaMJAX0gZ5fUA2FSrQcHzm3u5pAX/ik7Q22JM5TKkunUQiMyoXTd3RPXjNBEG8a
         3qZRe9H9lgp1whDtbt6721dLHJjOYmGxTecMkXz+tgiOHHFXOp4JiUKWEs43oht49ZgR
         3wlg==
X-Gm-Message-State: AOAM532dPVibP2tUTx2Tk98KhgxaLYduWD6wyGOOiZH1Ezj1JtgEJNf7
        fv7XlkgsKHIsim9uoY3OfEA=
X-Google-Smtp-Source: ABdhPJyepvA4cFmUlSoj8gy3U9v1K7jLnLDxZ2aoIQifXbNjNp7IFgZ3P3NY1KDGqfb7CERd7Vbxug==
X-Received: by 2002:a05:6a00:1255:b0:44c:dd49:b39a with SMTP id u21-20020a056a00125500b0044cdd49b39amr8050182pfi.66.1634845971227;
        Thu, 21 Oct 2021 12:52:51 -0700 (PDT)
Received: from sc2-haas01-esx0118.eng.vmware.com ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id n202sm7098078pfd.160.2021.10.21.12.52.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 12:52:50 -0700 (PDT)
From:   Nadav Amit <nadav.amit@gmail.com>
X-Google-Original-From: Nadav Amit
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, Nadav Amit <namit@vmware.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Xu <peterx@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>, Yu Zhao <yuzhao@google.com>,
        Nick Piggin <npiggin@gmail.com>, x86@kernel.org
Subject: [PATCH v2 3/5] x86/mm: check exec permissions on fault
Date:   Thu, 21 Oct 2021 05:21:10 -0700
Message-Id: <20211021122112.592634-4-namit@vmware.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211021122112.592634-1-namit@vmware.com>
References: <20211021122112.592634-1-namit@vmware.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nadav Amit <namit@vmware.com>

access_error() currently does not check for execution permission
violation. As a result, spurious page-faults due to execution permission
violation cause SIGSEGV.

It appears not to be an issue so far, but the next patches avoid TLB
flushes on permission promotion, which can lead to this scenario. nodejs
for instance crashes when TLB flush is avoided on permission promotion.

Add a check to prevent access_error() from returning mistakenly that
page-faults due to instruction fetch are not allowed. Intel SDM does not
indicate whether "instruction fetch" and "write" in the hardware error
code are mutual exclusive, so check both before returning whether the
access is allowed.

Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Andrew Cooper <andrew.cooper3@citrix.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Peter Xu <peterx@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Will Deacon <will@kernel.org>
Cc: Yu Zhao <yuzhao@google.com>
Cc: Nick Piggin <npiggin@gmail.com>
Cc: x86@kernel.org
Signed-off-by: Nadav Amit <namit@vmware.com>
---
 arch/x86/mm/fault.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index b2eefdefc108..e776130473ce 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -1100,10 +1100,17 @@ access_error(unsigned long error_code, struct vm_area_struct *vma)
 				       (error_code & X86_PF_INSTR), foreign))
 		return 1;
 
-	if (error_code & X86_PF_WRITE) {
+	if (error_code & (X86_PF_WRITE | X86_PF_INSTR)) {
 		/* write, present and write, not present: */
-		if (unlikely(!(vma->vm_flags & VM_WRITE)))
+		if ((error_code & X86_PF_WRITE) &&
+		    unlikely(!(vma->vm_flags & VM_WRITE)))
 			return 1;
+
+		/* exec, present and exec, not present: */
+		if ((error_code & X86_PF_INSTR) &&
+		    unlikely(!(vma->vm_flags & VM_EXEC)))
+			return 1;
+
 		return 0;
 	}
 
-- 
2.25.1

