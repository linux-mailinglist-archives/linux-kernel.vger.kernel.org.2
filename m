Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0556A4342D4
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 03:23:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbhJTBZs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 21:25:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbhJTBZr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 21:25:47 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BE87C06161C
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 18:23:34 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id c29so1527051pfp.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 18:23:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Rl6NsXQGdhrhfKfBbAtEquberPjJU3JVly0Gmzg5ILQ=;
        b=lS0lqUu64wvn/ze8/N/YOBWraIY+8cXpOf+UZZ8mHpVouP+h7HQngd/aV+GR0jq1sf
         3zX8bt1jZpv+jbK5RjgEN7gRAdlE5gnLPwbvEUNIt9A4s38iozdWoWmKfU8hXbErlZRL
         OerafwBNJtqh9YyAku9rkUVU55KR2ZFw/1ZqOLZQJMVOhANnbz7KkvmA5E40XTWiYOxu
         0fCS5k7MNjQF6jSIj0fe7gOHXTF1tl3ef2r0Ow2f1F/NFdRDcYl14IPMEMID4m6h3tWR
         2F5/kLABHs7YqP5anvFamF1GPPBLC6BvnQttB0I8L4VfsxDIFYKkQ1Ngpm8JpmNOJyo5
         wIrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Rl6NsXQGdhrhfKfBbAtEquberPjJU3JVly0Gmzg5ILQ=;
        b=qQlPEHIRsU0D9YeLSrVXCikU17z1AlhxRhE+z0fEMCh7GC40q8Y1UyO5fqX6JJLTVO
         yZ68SY6z1Auuq6teZ7Z8M7FyJvzb9uiUFTi8HeKEDL+ku+69YHZNGiilR2myfeKkrdA1
         M0HpXmNrKugJ+soBudMmH6ZKDn5gBq88xFfghN++9onhM/AwPHPpgtVT11ff34iF2MPH
         gspG28QfJ37yWQctK31c2zMSaVxSIbUcZ4kLLlcp0Opr7mLLzrhaayQk3NJIQGvswKeW
         gNuXu0J71PdJpVCrpDXFXEVjcKMJPgNyydtQcwCHiKzZ8ZPnlNuWG57hVKs2cRPhefLN
         VblA==
X-Gm-Message-State: AOAM530aXe05f2DfvDA2FVtUxEoBX8xZgQfcW6DsVXYAyRvvoedaCr0p
        FyAcCiYUyPxwWHZmsNrsO9bi9OjQpXY=
X-Google-Smtp-Source: ABdhPJwEYchvNZg4K6/ZN4M1xv6n6U0ffWEp2XRdBiZ2BQFDTLaDO+DhOmS2fEHMMrVcSqeOXmyGag==
X-Received: by 2002:a63:79cf:: with SMTP id u198mr31480471pgc.259.1634693013573;
        Tue, 19 Oct 2021 18:23:33 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id bf7sm366648pjb.14.2021.10.19.18.23.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Oct 2021 18:23:33 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: ye.guojin@zte.com.cn
To:     dyoung@redhat.com
Cc:     bhe@redhat.com, vgoyal@redhat.com, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, Ye Guojin <ye.guojin@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] crash_dump: remove duplicate include in crash_dump.h
Date:   Wed, 20 Oct 2021 01:23:18 +0000
Message-Id: <20211020012318.1035952-1-ye.guojin@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ye Guojin <ye.guojin@zte.com.cn>

'linux/pgtable.h' included in 'crash_dump.h' is duplicated.
it's also included at line 8.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Ye Guojin <ye.guojin@zte.com.cn>
---
 include/linux/crash_dump.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/linux/crash_dump.h b/include/linux/crash_dump.h
index 0c547d866f1e..b7b255b23b99 100644
--- a/include/linux/crash_dump.h
+++ b/include/linux/crash_dump.h
@@ -8,8 +8,6 @@
 #include <linux/pgtable.h>
 #include <uapi/linux/vmcore.h>
 
-#include <linux/pgtable.h> /* for pgprot_t */
-
 /* For IS_ENABLED(CONFIG_CRASH_DUMP) */
 #define ELFCORE_ADDR_MAX	(-1ULL)
 #define ELFCORE_ADDR_ERR	(-2ULL)
-- 
2.25.1

