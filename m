Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3528834C2FF
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 07:28:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230212AbhC2FZK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 01:25:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230244AbhC2FY6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 01:24:58 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62213C061574
        for <linux-kernel@vger.kernel.org>; Sun, 28 Mar 2021 22:24:58 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id m7so8682386pgj.8
        for <linux-kernel@vger.kernel.org>; Sun, 28 Mar 2021 22:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bAlA5isJ9rRIE85RSXmWhvh36Efvgn4+AnafoJbdfLk=;
        b=lpwoeJRYlzK5ORY0JsfaLhgvNY19UFdv0JdosiJwbvwN+J/BUOP9ZhUJUmsOJRuLN1
         ikaSaQYX4wirVStbPpxr12VEAblYeo7/+vn3mXl+Pk0Lh0R77ReUW4DpUtXcPrRMbPIY
         puiQrPdCOgG3N5q2ZayWJU8JRY+ZBUhQ9sUX20W31Q5hiyXkF0P5kSdfu1SOWmmdeKDM
         AdAEM16EijR3fpTWVV0fe0UlbhIO1E5962W8IVHnElJ0g4FFroS0M6ELhH/9M24nKaGM
         oUTPMN42I5KzwtmMpLaRlmqpz0WYxhIyWX1PHm5BmEW8PsVA+bMoeOoBe5ry3Gfzv5q+
         lTlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bAlA5isJ9rRIE85RSXmWhvh36Efvgn4+AnafoJbdfLk=;
        b=HvLG/oXbzaKE9vngMOEOmdegQgisq25BUWK+rH9ieNHv+3rGtWygHsmY7f96fiJN7G
         xJc7nAYgxl4KWmeIYztlpDcVKq7AA/3hOOnVuyR7mMNwCFCMspr2oS9+PKVwrwduavCa
         b4AvVxyiZkm5zvol18RIL8FMh+lDLzUKYka5fSvhC/jtc0w1lreJpbJFuSnr1S6upCne
         iRN/F78xz+BZraGlK3w4ipXtAucGLmLGtTUwsuVmDksTA4b67ToTX9+tkmSOk5V+4jpE
         e9u6DFMRQ2fN+Z2+hcuq+6LXSEkWl3ttwBuRau0g6bxKHZbACWoIM4OiUq9JW3ouXV/g
         PWPA==
X-Gm-Message-State: AOAM532pUKYHBZ+krF4hyko0z+Ij2mRITy3Yf8onxQPeeCIjSzs13ll1
        KCwRFcbIQ5K6x7HlF7SP76aXB1ZRTCYpNR3b
X-Google-Smtp-Source: ABdhPJxQKNa6jNKc6WbeXXDaz7ckpek2dWgPBBt9V9AjSkvc1+UirWZP+wkK6Ep0J8jH8dwBLHGnzQ==
X-Received: by 2002:a63:3245:: with SMTP id y66mr2654278pgy.435.1616995497799;
        Sun, 28 Mar 2021 22:24:57 -0700 (PDT)
Received: from z640-arch.lan ([2602:61:7344:f100::678])
        by smtp.gmail.com with ESMTPSA id q205sm16107886pfc.126.2021.03.28.22.24.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Mar 2021 22:24:57 -0700 (PDT)
From:   Ilya Lipnitskiy <ilya.lipnitskiy@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     Ilya Lipnitskiy <ilya.lipnitskiy@gmail.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [PATCH] mm: fix race by making init_zero_pfn() early_initcall
Date:   Sun, 28 Mar 2021 22:24:26 -0700
Message-Id: <20210329052426.1130040-1-ilya.lipnitskiy@gmail.com>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are code paths that rely on zero_pfn to be fully initialized
before core_initcall. For example, wq_sysfs_init() is a core_initcall
function that eventually results in a call to kernel_execve, which
causes a page fault with a subsequent mmput. If zero_pfn is not
initialized by then it may not get cleaned up properly and result in an
error:
  BUG: Bad rss-counter state mm:(ptrval) type:MM_ANONPAGES val:1

Here is an analysis of the race as seen on a MIPS device. On this
particular MT7621 device (Ubiquiti ER-X), zero_pfn is PFN 0 until
initialized, at which point it becomes PFN 5120:
  1. wq_sysfs_init calls into kobject_uevent_env at core_initcall:
       [<80340dc8>] kobject_uevent_env+0x7e4/0x7ec
       [<8033f8b8>] kset_register+0x68/0x88
       [<803cf824>] bus_register+0xdc/0x34c
       [<803cfac8>] subsys_virtual_register+0x34/0x78
       [<8086afb0>] wq_sysfs_init+0x1c/0x4c
       [<80001648>] do_one_initcall+0x50/0x1a8
       [<8086503c>] kernel_init_freeable+0x230/0x2c8
       [<8066bca0>] kernel_init+0x10/0x100
       [<80003038>] ret_from_kernel_thread+0x14/0x1c

  2. kobject_uevent_env() calls call_usermodehelper_exec() which executes
     kernel_execve asynchronously.

  3. Memory allocations in kernel_execve cause a page fault, bumping the
     MM reference counter:
       [<8015adb4>] add_mm_counter_fast+0xb4/0xc0
       [<80160d58>] handle_mm_fault+0x6e4/0xea0
       [<80158aa4>] __get_user_pages.part.78+0x190/0x37c
       [<8015992c>] __get_user_pages_remote+0x128/0x360
       [<801a6d9c>] get_arg_page+0x34/0xa0
       [<801a7394>] copy_string_kernel+0x194/0x2a4
       [<801a880c>] kernel_execve+0x11c/0x298
       [<800420f4>] call_usermodehelper_exec_async+0x114/0x194

  4. In case zero_pfn has not been initialized yet, zap_pte_range does
     not decrement the MM_ANONPAGES RSS counter and the BUG message is
     triggered shortly afterwards when __mmdrop checks the ref counters:
       [<800285e8>] __mmdrop+0x98/0x1d0
       [<801a6de8>] free_bprm+0x44/0x118
       [<801a86a8>] kernel_execve+0x160/0x1d8
       [<800420f4>] call_usermodehelper_exec_async+0x114/0x194
       [<80003198>] ret_from_kernel_thread+0x14/0x1c

To avoid races such as described above, initialize init_zero_pfn at
early_initcall level. Depending on the architecture, ZERO_PAGE is either
constant or gets initialized even earlier, at paging_init, so there is
no issue with initializing zero_pfn earlier.

ML discussion: https://lore.kernel.org/lkml/CALCv0x2YqOXEAy2Q=hafjhHCtTHVodChv1qpM=niAXOpqEbt7w@mail.gmail.com/

Signed-off-by: Ilya Lipnitskiy <ilya.lipnitskiy@gmail.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>
---
 mm/memory.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/memory.c b/mm/memory.c
index 46ef306375bd..a8bbc4fc121f 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -166,7 +166,7 @@ static int __init init_zero_pfn(void)
 	zero_pfn = page_to_pfn(ZERO_PAGE(0));
 	return 0;
 }
-core_initcall(init_zero_pfn);
+early_initcall(init_zero_pfn);
 
 void mm_trace_rss_stat(struct mm_struct *mm, int member, long count)
 {
-- 
2.31.0

