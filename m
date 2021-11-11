Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94D6644D357
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 09:46:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232420AbhKKItX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Nov 2021 03:49:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231961AbhKKItS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Nov 2021 03:49:18 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 360DEC061766
        for <linux-kernel@vger.kernel.org>; Thu, 11 Nov 2021 00:46:30 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id r5so5295240pls.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Nov 2021 00:46:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=J9tytTC89tIbQkkTkBO8DMvoL6kQDxHyRTJb1T6FR4I=;
        b=gJKdUH+boe+03Lj9B0dpLRiHMIx7CCyfV9fm4zLuWRj4xiB/R765QusNMWZZz0b1Ne
         NBV5FHQ9VHA1Yo1Z81pEZDDbBsMVZJpWYrPmxIJP2BvsyQ6WvWPTIhYo7oMSyQWor05f
         nuNQxGKy1vRwuPMjVSTlnHFg8TmYPm3+9yi8ZT1t2lD4GSp2zRHv8ZxMR/UrKiWXD7KY
         OVLq9lXjT4fR8v9cQvr95EQV+rbZRvZmxZ+eI2cZkil9QOTAzl/JvSOoV8gwM9XuPArg
         0/sl8wOtp1HIJ50ZsTITO4wtiaqI18IJ3K+9um6XsDNIYzh0rSN8vDZOdSBuyjYq/uxp
         SLkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=J9tytTC89tIbQkkTkBO8DMvoL6kQDxHyRTJb1T6FR4I=;
        b=qIXXIHFwOFvMVq+Fxg+EIR1gaMjwxoiAaDmXBcAqLbj/lk9Ygb035PsJZHghC8Ewit
         fyzO/aQSnAbKO17GTq1tDScltie6mQS0bqdf4TuIeiBMfocETTMXIY2/Z+g6HL7XT2G6
         u9EpI8Zfl6mucbcbL25fg9oadFW2JOO891T75YwbtzriLP24UYyyMJc+2Q/c2xFrMXnK
         nHeDWSImFV4/4mDBqzyX/nsENt9QS2dJoCp5/Ly+kvt3yWhNlWoAxJMybpjN5RfKrag9
         3WxUIdUTLYQWMJKCGxA0Yi1A0Y3sSuLADs1jDi/LGfw7fXEQ/0FR7DxdfzVRxl48lsFh
         q1GQ==
X-Gm-Message-State: AOAM5337yY1J7ryZqC62O0WY4JeTq2rCUmAPHMjKdANLr7Z9KFeU9aVX
        sOcdUJvl4VjvNlpVBf04kR8=
X-Google-Smtp-Source: ABdhPJycXbgOGJgNgY9qJNh952ZDv0BKh88rCcOWEt7rqPB5PmStXpRZZYS9V+FLZr92v/im7wlPGw==
X-Received: by 2002:a17:903:1248:b0:13f:cd7d:69eb with SMTP id u8-20020a170903124800b0013fcd7d69ebmr6376481plh.23.1636620389666;
        Thu, 11 Nov 2021 00:46:29 -0800 (PST)
Received: from host-x86-64.. ([122.161.243.27])
        by smtp.gmail.com with ESMTPSA id v1sm2107306pfg.204.2021.11.11.00.46.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Nov 2021 00:46:29 -0800 (PST)
From:   Ajay Garg <ajaygargnsit@gmail.com>
To:     hughd@google.com, akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     Ajay Garg <ajaygargnsit@gmail.com>
Subject: [PATCH] mm: shmem: do not call PageHWPoison on a ERR-page
Date:   Thu, 11 Nov 2021 14:16:17 +0530
Message-Id: <20211111084617.6746-1-ajaygargnsit@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit b9d02f1bdd98
("mm: shmem: don't truncate page if memory failure happens")

introduced a PageHWPoison(page) call in "shmem_read_mapping_page_gfp"
in shmem.c.

Now, if "shmem_getpage_gfp" returns an error, page is set to ERR-page.
Therafter, calling PageHWPoison() on this ERR-page, causes KASAN to OOP
the kernel :

 #############################
BUG: unable to handle page fault for address: fffffffffffffff4
PF: supervisor read access in kernel mode
PF: error_code(0x0000) - not-present page
PGD 18e019067 P4D 18e019067 PUD 18e01b067 PMD 0 
Oops: 0000 [#1] PREEMPT SMP DEBUG_PAGEALLOC KASAN PTI
CPU: 0 PID: 4836 Comm: MATLAB Not tainted 5.15.0+ #18
Hardware name: Dell Inc. Latitude E6320/0GJF11, BIOS A19 11/14/2013
RIP: 0010:shmem_read_mapping_page_gfp+0xd3/0x140
Code: 4c 89 ff e8 6f eb ff ff 5a 59 85 c0 74 64 48 63 d8 48 89 5d 98 be 08 00 00 00 48 89 df e8 e5 67 0c 00 48 89 df e8 6d 5c 0c 00 <48> 8b 13 48 c7 c0 fb ff ff ff f7 c2 00 00 80 00 74 30 48 ba 00 00
RSP: 0018:ffff88806b33f998 EFLAGS: 00010246
RAX: 0000000000000000 RBX: fffffffffffffff4 RCX: ffffffffb7a37ba3
RDX: 0000000000000003 RSI: dffffc0000000000 RDI: fffffffffffffff4
RBP: ffff88806b33fa20 R08: 1ffffffffffffffe R09: fffffffffffffffb
R10: fffffbffffffffff R11: 0000000000000001 R12: 1ffff1100d667f33
R13: 00000000001120d2 R14: 00000000000005db R15: ffff88814e64e2d8
FS:  00007f379a384640(0000) GS:ffff888161a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: fffffffffffffff4 CR3: 00000000269dc004 CR4: 00000000000606f0
Call Trace:
<TASK>
? shmem_fault+0x480/0x480
? __cond_resched+0x1c/0x30
? __kasan_check_read+0x11/0x20
shmem_get_pages+0x3a4/0xa70 [i915]
? shmem_writeback+0x3b0/0x3b0 [i915]
? i915_gem_object_wait_reservation+0x330/0x560 [i915]   
...
...
 ################################

So, we proceed with PageHWPoison() call, only if the page is not a 
ERR-page.


P.S. : Alternative (optimised) solution :
===========================================

We could save some CPU cycles, if we directly replace

        if (error)
                page = ERR_PTR(error);
        else
                unlock_page(page);

with

        if (error)
                return ERR_PTR(error);


Fixes: b9d02f1bdd98 ("mm: shmem: don't truncate page if memory failure happens")
Signed-off-by: Ajay Garg <ajaygargnsit@gmail.com>
---
 mm/shmem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index 23c91a8beb78..427863cbf0dc 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -4222,7 +4222,7 @@ struct page *shmem_read_mapping_page_gfp(struct address_space *mapping,
 	else
 		unlock_page(page);
 
-	if (PageHWPoison(page))
+	if (!IS_ERR(page) && PageHWPoison(page))
 		page = ERR_PTR(-EIO);
 
 	return page;
-- 
2.30.2

