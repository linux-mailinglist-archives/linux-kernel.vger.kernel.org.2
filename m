Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C872C3BB7D0
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jul 2021 09:27:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230003AbhGEHaU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jul 2021 03:30:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229884AbhGEHaU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jul 2021 03:30:20 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCFC6C061574
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jul 2021 00:27:42 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id i3-20020a05620a1503b02903b2ffa0a87fso13479674qkk.18
        for <linux-kernel@vger.kernel.org>; Mon, 05 Jul 2021 00:27:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=mDcwhPTUrel2btqXWeFaBd7hJh1LLe+zyIffNYoVAO4=;
        b=qAMqrCJFNODTwzQ7AnOWbR2A/o+Ir6oB9pMB+LVwQumUEGcyEo6L7b2A7LYszuWNqY
         L1OZYgDiHtyhQWCzXtRi5q4yUozGsuPBljxtT2+MsIk1RECQJF75UFLldzfMn2Znrbc2
         h0CvJeOGSq8yzFC8eAVVU1j28ectyr2FxWQyvrDdSTZD9z3dgl+xpi9e4LWQhCgwibTo
         /bMTMtR9vnirqBIQy7pQyZp2BqBb+94uz4Ne7jv8Ta5/YM38SvCmHSIdM2aqzelFOApg
         XvOcL+10emMXCPHezqnyOryq69EJZZdPuIVtnRsVWipaqnwlwVY30wIXtw+w0LtEchT8
         9KDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=mDcwhPTUrel2btqXWeFaBd7hJh1LLe+zyIffNYoVAO4=;
        b=LMAILc7Gv36YMf5lfr3RMqiduenOgMFIjP7lN7SRitL9pI8237VbqmJZOuro43uZBo
         EJBsT8MeMT5Z1kf6ZepwfYj29YnU9BvMtqQ+5TuL+qfpnerfe19F6DuIAMUXwmBd7Der
         dE+XZf5HQf3sCYD8hpc/0eurPLYpMPUuV3kBq2pPDhuuEhoMp17l6NzHn9LVzOJJ/77h
         xn5I89qOgoK04zzhOwdDgQOLz91MxFThEIV3WuJxWYi0BIM5rr96jzrVlKptb5KiTuk6
         uEBYp+GWpS4p2Lxp3HytLdMFv/O1i9I+waEmazfK+P3KJD2L5le42XQHh9bWZh7zRD6b
         Nd0Q==
X-Gm-Message-State: AOAM5327GW81lpXGHyxi7jsm2Gz8rgbnHZjS8Wkv/vemp+JLXzD6APu5
        JOZYcYM/nuYlsKfXUu15ZMeLfiniXg==
X-Google-Smtp-Source: ABdhPJy+5/fiU25MluGALZh833fd3YBtRXmlxtDJ6t6m9azmVvhEwK5nGVYmpILtK2FQSxUxniC2PyXhqQ==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:15:13:dddd:647c:7745:e5f7])
 (user=elver job=sendgmr) by 2002:a05:6214:d49:: with SMTP id
 9mr11847977qvr.30.1625470061873; Mon, 05 Jul 2021 00:27:41 -0700 (PDT)
Date:   Mon,  5 Jul 2021 09:27:16 +0200
Message-Id: <20210705072716.2125074-1-elver@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.32.0.93.g670b81a890-goog
Subject: [PATCH] kasan: fix build by including kernel.h
From:   Marco Elver <elver@google.com>
To:     elver@google.com, akpm@linux-foundation.org
Cc:     glider@google.com, dvyukov@google.com, pcc@google.com,
        catalin.marinas@arm.com, vincenzo.frascino@arm.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        kasan-dev@googlegroups.com, ryabinin.a.a@gmail.com,
        andreyknvl@gmail.com,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The <linux/kasan.h> header relies on _RET_IP_ being defined, and had
been receiving that definition via inclusion of bug.h which includes
kernel.h. However, since f39650de687e that is no longer the case and get
the following build error when building CONFIG_KASAN_HW_TAGS on arm64:

  In file included from arch/arm64/mm/kasan_init.c:10:
  ./include/linux/kasan.h: In function 'kasan_slab_free':
  ./include/linux/kasan.h:230:39: error: '_RET_IP_' undeclared (first use in this function)
    230 |   return __kasan_slab_free(s, object, _RET_IP_, init);

Fix it by including kernel.h from kasan.h.

Fixes: f39650de687e ("kernel.h: split out panic and oops helpers")
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Marco Elver <elver@google.com>
---
 include/linux/kasan.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/kasan.h b/include/linux/kasan.h
index 5310e217bd74..dd874a1ee862 100644
--- a/include/linux/kasan.h
+++ b/include/linux/kasan.h
@@ -3,6 +3,7 @@
 #define _LINUX_KASAN_H
 
 #include <linux/bug.h>
+#include <linux/kernel.h>
 #include <linux/static_key.h>
 #include <linux/types.h>
 
-- 
2.32.0.93.g670b81a890-goog

