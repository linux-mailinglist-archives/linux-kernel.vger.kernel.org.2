Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA7754419B0
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Nov 2021 11:17:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231958AbhKAKUL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 06:20:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231693AbhKAKUK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 06:20:10 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26DBDC061714
        for <linux-kernel@vger.kernel.org>; Mon,  1 Nov 2021 03:17:37 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id t21so11229175plr.6
        for <linux-kernel@vger.kernel.org>; Mon, 01 Nov 2021 03:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oYkYwA/2dIbGzKgJMwo2/gyHeXXzrEzdf/BzDdeRQYA=;
        b=B/ANsDuh9hFhnDCEr03H/+WltnM+MqPmj6syRy87S7MAMDiRYGF/x3Cu0Q9mh7XLV6
         9uCCBkB+ICcjo9XV5lBU6QwH+O9orWD4mc3purMHhtulYY4kHTmOm6JA+zs7+3taMrH/
         Ft0AvCkn6/XlS1wLg+SobkQJ6BJno0ZHJNRGZtFJk7IwEAcPaSyFZCJmqDYgRQZK5NtO
         QVMve5ualc28/2Dqvj25xqum1C2ZIbU3ot2VJUVlgZFuLpi+tUsp2HBt+17okhBTsgk7
         LPYuganUngqgRR4UBX6PqLtA+KRA4atrap4PIzjGJf4fTR/c9DSSEo6n15sPXuEs0MrU
         f3TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oYkYwA/2dIbGzKgJMwo2/gyHeXXzrEzdf/BzDdeRQYA=;
        b=7FN+KvUdw7zYzss27pnpaQ6Dkt/oeQ7Equg5pbI1Hu3xhu401DxX7gD/X3NPeiv5Vz
         GyZQPDpPUyYF7Hl80Ijju4heAa8JMjEDcBvT4IcldL5GBqlN0bPzOnB7ZWhHgGBQdvZ2
         zPDRARILVgDDKtQ+CYJKH09KA1gU9TDeEusnU4e+yaMBe6UNM3Uu/cDPqks+VBq42/+D
         ZWnR+c9qIa5z4iqYsGpU36mtIlpfZcKJvanmO6QO9XsLrhSFjtQaQQH0gz7XXf/g0PCu
         XAjUQMtNxgx4HSJ4zj8EDcdTbhhxKIqX+6BfcwSFY5WM7Pe8AX+sD8uDsAYt6zahqKlI
         cuOQ==
X-Gm-Message-State: AOAM530HLrvasn8xEK0ZyfQGUEfleHCn4NUaFiKBBLUWsu6R7nxOV8ET
        RVsNo1r/V9Wgf2WAHbGNi44=
X-Google-Smtp-Source: ABdhPJwMDfPd/xfRVQnK0lt7H0nn2UbQze6DOjcxq15tm1YELLEgCQy5+LCMaooWaVfyYg6QMJVq4A==
X-Received: by 2002:a17:902:d50d:b0:141:ea03:5193 with SMTP id b13-20020a170902d50d00b00141ea035193mr4871880plg.89.1635761856537;
        Mon, 01 Nov 2021 03:17:36 -0700 (PDT)
Received: from kushal ([115.96.218.96])
        by smtp.gmail.com with ESMTPSA id y6sm15891676pfi.154.2021.11.01.03.17.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Nov 2021 03:17:36 -0700 (PDT)
From:   Kushal Kothari <kushalkothari285@gmail.com>
To:     rppt@kernel.org, akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, mike.rapoport@gmail.com,
        kushalkothari2850@gmail.com
Cc:     Kushal Kothari <kushalkothari285@gmail.com>
Subject: [PATCH] staging: mm: Fix ERROR:do not initialise statics to 0 or NULL in memblock.c
Date:   Mon,  1 Nov 2021 15:47:19 +0530
Message-Id: <20211101101719.22538-1-kushalkothari285@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The default value of static variable is zero and bool is false so
not need to set it here.
This patch fixes this ERROR in memblock.c

Signed-off-by: Kushal Kothari <kushalkothari285@gmail.com>
---
 mm/memblock.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/mm/memblock.c b/mm/memblock.c
index 5c3503c98b2f..57b9153b2278 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -16,7 +16,7 @@
 #include <linux/kmemleak.h>
 #include <linux/seq_file.h>
 #include <linux/memblock.h>
-
+#include<stdbool.h>
 #include <asm/sections.h>
 #include <linux/io.h>
 
@@ -152,10 +152,10 @@ static __refdata struct memblock_type *memblock_memory = &memblock.memory;
 	} while (0)
 
 static int memblock_debug __initdata_memblock;
-static bool system_has_some_mirror __initdata_memblock = false;
+static bool system_has_some_mirror __initdata_memblock;
 static int memblock_can_resize __initdata_memblock;
-static int memblock_memory_in_slab __initdata_memblock = 0;
-static int memblock_reserved_in_slab __initdata_memblock = 0;
+static int memblock_memory_in_slab __initdata_memblock;
+static int memblock_reserved_in_slab __initdata_memblock;
 
 static enum memblock_flags __init_memblock choose_memblock_flags(void)
 {
-- 
2.25.1

