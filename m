Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4ED0834F4B8
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 01:03:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233019AbhC3XDR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 19:03:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232966AbhC3XCx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 19:02:53 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 770AEC061762
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 16:02:53 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id b127so212332ybc.13
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 16:02:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:cc;
        bh=lKfr5+52jWwI+Zvip3lB7Kvy32Qdo0Kz4Xcb667U8qU=;
        b=RbDrIYhMcHjozc9q3bGMvQN6iDdXiqTQBwd84F628py0QRxg2sWsbX13cGz0DRsrv/
         RW+fOWEdvl4ujWoowaUmE8QqH32XZIfE0zAB3wCXUE0dOvCF6rgg7+SjnoTpK/dNrbyr
         79YgyVA3GJbJkroCodQj60rEu63NpoZua1lFp1BerT2emie7UK+DrGfuWjpQ4m/IzQsI
         yGUrhF5X6TJT3OJ2NazFg0+b9DEDCvH1qLUdv2CgBg15F8ft+7o9EQtGhh36li6uOoke
         DY8bN8VWFBnkkttcUhlM+GIinit7M7N7L59oD0taDnDVvx7jyFFItc+N0hkMWWTmnilk
         J1xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:cc;
        bh=lKfr5+52jWwI+Zvip3lB7Kvy32Qdo0Kz4Xcb667U8qU=;
        b=DpL3pJjwgDVSfGUTKNWvK9uyWMM15XGyIQuaTFYFQXaO7Zdq9xruNpWIkSChKeUfgW
         NvUXsSR6J2dtD4ZqFtbEASkcazLmvsycxN0/gHipFqI/Giqv25pNFjPSds8GA6GIPNin
         1Hmyhlz+r7kr2Fv98dUWhKQaWwy7lu3Mf/q1d3oCfA/qbd5PX7MbdgJPsNkzGsg54jg1
         rAl0Mfu7s5B8X3qGB50CdfZDpC6hG1gaSU6Zf7va8aKof7hkrfCJy0yJZQ3NEANBg2pY
         CrsrHwKohJr87c2JGdAaAWBYBkCXtUxWR6ltLxB5o6p3MWi+7tcHbN0K/w+6decKm69R
         nCow==
X-Gm-Message-State: AOAM530s1PLsNwp1z5/lv6jb4hIwJvSf7H0tjGjTs8s7UPk9pPgI7PG1
        Mtw275ki8/eu0cMuK7lmUddwMWEhMzFQ
X-Google-Smtp-Source: ABdhPJwbj38GgZvC3YeXXKGQl8NBGsY+L+boGqSAhoVV2yWayAk6sj9ZMXuUb5K3yPe4d9wd87B5wzSxgxmh
X-Received: from jiancai.svl.corp.google.com ([2620:15c:2ce:0:b0cb:af41:d8ca:7230])
 (user=jiancai job=sendgmr) by 2002:a25:2386:: with SMTP id
 j128mr754316ybj.284.1617145372572; Tue, 30 Mar 2021 16:02:52 -0700 (PDT)
Date:   Tue, 30 Mar 2021 16:02:49 -0700
Message-Id: <20210330230249.709221-1-jiancai@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.31.0.291.g576ba9dcdaf-goog
Subject: [PATCH] blk-mq: fix alignment mismatch.
From:   Jian Cai <jiancai@google.com>
Cc:     cjdb@google.com, manojgupta@google.com, llozano@google.com,
        clang-built-linux@googlegroups.com, Jian Cai <jiancai@google.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jens Axboe <axboe@kernel.dk>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes the mismatch of alignments between csd and its use as an
argument to smp_call_function_single_async, which causes build failure
when -Walign-mismatch in Clang is used.

Link:
http://crrev.com/c/1193732

Suggested-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Jian Cai <jiancai@google.com>
---
 include/linux/blkdev.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index bc6bc8383b43..3b92330d95ad 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -231,7 +231,7 @@ struct request {
 	unsigned long deadline;
 
 	union {
-		struct __call_single_data csd;
+		call_single_data_t csd;
 		u64 fifo_time;
 	};
 
-- 
2.31.0.291.g576ba9dcdaf-goog

