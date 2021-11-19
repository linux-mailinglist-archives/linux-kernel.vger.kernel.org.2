Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCADD456A9B
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Nov 2021 08:01:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233118AbhKSHEP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Nov 2021 02:04:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232201AbhKSHEO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Nov 2021 02:04:14 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60E33C061574
        for <linux-kernel@vger.kernel.org>; Thu, 18 Nov 2021 23:01:13 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id b4so7831522pgh.10
        for <linux-kernel@vger.kernel.org>; Thu, 18 Nov 2021 23:01:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8p47yJxzaBJgNNK9+SElB+OrwH4KzAUJIu2lK10OypQ=;
        b=ZFJp0TCSWOWZQLnddVGFqUo/BIk9uNJMrRJsftAkkoK6ow4kFS83Ak2vm8Q1OznVbq
         XQIbiA3I6euCEcpoR7tb4RKEIUPEMM1rMwWZts/jH3P/q1ubzOllq8nmO8FM0VUpCHal
         oN8nNd0nKS7F0H2DFNXnR7QI4HWQbr3o2B7ewEd7nhIov0pV47qqmX2VGfWCi+b631cr
         ZAINWCszY2VwH9e3BOe8P6iSESPETqfLrY0uKQRx9WdFlOMZAFE/97UmOzhXGWCA+7xd
         zqVHgyQnSPG/jujDfjIqNV48d2oUelaq8h1fmD6qtAKbdmkNUveex44E0JtSYmIXQrsJ
         2iBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8p47yJxzaBJgNNK9+SElB+OrwH4KzAUJIu2lK10OypQ=;
        b=UfpREYh9h+G2bZMjrkYBKFiBn581ppml45PXiP//RTx9PT8l2BlXzmOqwDg2dzSzas
         gdPUo7BBMj1CzHskqp+M1WdxIJhJ1g2oSCzkcOFXiBPbwn2pUnxFG6TGAWwnFeYY5+nJ
         QCJWRjYJ8/GDA9TzGhjQYsSrss1+yF4rHUcQusK7EUhenkvnsdwodpPgJnx6Ir2K3F5s
         I9FO4iD/kn9LGnU4C7qAIsqA7zwKc3rPbRdVLX1y5VUsxkX9lF7Sj5kGt4Yyf+ryb+ne
         +f5Fh+sz7jofzOMOSyckwgfHcYQgfihkwsj8c39uzwChIA8z0nRy1TCnx0g7Cf0lEa5G
         5vYA==
X-Gm-Message-State: AOAM5324YJrOaBm+5MnfLp8BmXIT7lu/5vKOIdHADIkAcQi08O4pPL2K
        aO+WCCSGoEahAnX76Ap+0l7L8Q==
X-Google-Smtp-Source: ABdhPJzkUTCrq95HBFbLoKRFLMhkI67/vAcmTT2UP14n374SY0AA9/tSZSr0LfdDYqLGUIgEoenSwg==
X-Received: by 2002:a62:b606:0:b0:47b:e32f:9ca with SMTP id j6-20020a62b606000000b0047be32f09camr61248842pff.57.1637305272927;
        Thu, 18 Nov 2021 23:01:12 -0800 (PST)
Received: from localhost.localdomain ([139.177.225.245])
        by smtp.gmail.com with ESMTPSA id r2sm1255382pgm.4.2021.11.18.23.01.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Nov 2021 23:01:12 -0800 (PST)
From:   Muchun Song <songmuchun@bytedance.com>
To:     dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        duanxiongchun@bytedance.com, zhengqi.arch@bytedance.com,
        Muchun Song <songmuchun@bytedance.com>
Subject: [RFC PATCH] x86/fault: move might_sleep() out of mmap read lock
Date:   Fri, 19 Nov 2021 14:58:31 +0800
Message-Id: <20211119065831.31406-1-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The mmap lock is supposed to be a contended lock sometimes, scheduling
to other task with holding mmap read lock does not seems to be a wise
choice. So move it to the front of mmap_read_trylock(). Although
mmap_read_lock() implies a might_sleep(), I think redundant check is
not a problem since this task is about to sleep and it is not a hot
path.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 arch/x86/mm/fault.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index 4bfed53e210e..22fd1dfafa3d 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -1323,6 +1323,8 @@ void do_user_addr_fault(struct pt_regs *regs,
 	}
 #endif
 
+	might_sleep();
+
 	/*
 	 * Kernel-mode access to the user address space should only occur
 	 * on well-defined single instructions listed in the exception
@@ -1346,13 +1348,6 @@ void do_user_addr_fault(struct pt_regs *regs,
 		}
 retry:
 		mmap_read_lock(mm);
-	} else {
-		/*
-		 * The above down_read_trylock() might have succeeded in
-		 * which case we'll have missed the might_sleep() from
-		 * down_read():
-		 */
-		might_sleep();
 	}
 
 	vma = find_vma(mm, address);
-- 
2.11.0

