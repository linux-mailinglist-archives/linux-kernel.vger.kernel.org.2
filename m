Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B38032F72D
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Mar 2021 01:18:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbhCFAQa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 19:16:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbhCFAQA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 19:16:00 -0500
Received: from mail-wr1-x44a.google.com (mail-wr1-x44a.google.com [IPv6:2a00:1450:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F76CC06175F
        for <linux-kernel@vger.kernel.org>; Fri,  5 Mar 2021 16:16:00 -0800 (PST)
Received: by mail-wr1-x44a.google.com with SMTP id m9so1779744wrx.6
        for <linux-kernel@vger.kernel.org>; Fri, 05 Mar 2021 16:16:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=Vm4vyPpxQ7w8FtG0FaFIYIajGbm/X1qa4ffJxCVDSQc=;
        b=WOH4/bdPZRdpEM3NJYFopgN3Pp+cuDQnWnreBB08vKkOkWXlr6htLh6Bgyo/G6Rwvi
         JcdlO8bY8dd3U1qA4r3XmcBXtP3Vnoo0nJ53zxSVUdoN5POu/lJDfFxKTQ1oT2XwkKLW
         Iy8lkW46C00xIX6/84xDT7luQ5ugnCxl7a/LWNZgOzkv8uxYt2lF6vFQh1Vpllc1m9UM
         b9WVok/veTipaxNWI23jD9AVUHhdhPzXkgxlgija2uVsX5IQzDIPtrXMKlncuAZOg6N7
         jyq/viI290LngkpJZY6wOfCmBKIdFtLKAzWx6oa3XshBCZNWBCedgGY8m2WvLFZJBZvv
         ovTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=Vm4vyPpxQ7w8FtG0FaFIYIajGbm/X1qa4ffJxCVDSQc=;
        b=jpDTQhhGniYCEeXDAHRBcEUtJNqlrP7dVfDNQejkdeJhojc0i64MeVVc9oS2YqQMAO
         OKQd8bK8dDb8Anb+LqHbKDOHjioAWPrWnLUpIiJFOHLVSB3j41oz7F3UOltyQ5d98bA2
         M2ljcj/qJuc8OapLTJ/y2ExHmDfCFPLV9xiWEQFZIQlADlo+92+8nRXt6Pe3q5FJwkqi
         3svssTurW8jagA6YkKPTX59OPHhxj203dno/sMoRKxV0OZhSHXKsOIpYs0dd9QNpF4ir
         KzxxoanjnMKET542jgqDJZEsdJtn7uHr2olZQcuQITz5WBKtrs8dlvsFM1vdcyyfxibb
         dfsA==
X-Gm-Message-State: AOAM532OgkupkBqIRqqJLym8W45Dfztaq5xqcB7JL1Aj0TMbWmTXAjtr
        nenmmZY4hCPLx8N1l+LjhMCddTMmL9z/M5hj
X-Google-Smtp-Source: ABdhPJyqv+Z1WxarFIPJMB/BoL525nnYCwDuEvMd9JMOQnru4zl57QKqAIoddJdR+IFnZzhsdIO6cazeqZtXLvL2
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:953b:d7cf:2b01:f178])
 (user=andreyknvl job=sendgmr) by 2002:a1c:f203:: with SMTP id
 s3mr11046868wmc.152.1614989758870; Fri, 05 Mar 2021 16:15:58 -0800 (PST)
Date:   Sat,  6 Mar 2021 01:15:49 +0100
Message-Id: <cover.1614989433.git.andreyknvl@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
Subject: [PATCH 0/5] kasan: integrate with init_on_alloc/free
From:   Andrey Konovalov <andreyknvl@google.com>
To:     Alexander Potapenko <glider@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Marco Elver <elver@google.com>,
        Peter Collingbourne <pcc@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        kasan-dev@googlegroups.com, linux-arm-kernel@lists.infradead.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This goes on top of:

[v3] kasan, mm: fix crash with HW_TAGS and DEBUG_PAGEALLOC
[v3] mm, kasan: don't poison boot memory with tag-based modes

This patch series integrates HW_TAGS KASAN with init_on_alloc/free
by initializing memory via the same arm64 instruction that sets memory
tags.

This is expected to improve HW_TAGS KASAN performance when
init_on_alloc/free is enabled. The exact perfomance numbers are unknown
as MTE-enabled hardware doesn't exist yet.

Andrey Konovalov (5):
  arm64: kasan: allow to init memory when setting tags
  kasan: init memory in kasan_(un)poison for HW_TAGS
  kasan, mm: integrate page_alloc init with HW_TAGS
  kasan, mm: integrate slab init_on_alloc with HW_TAGS
  kasan, mm: integrate slab init_on_free with HW_TAGS

 arch/arm64/include/asm/memory.h    |  4 +-
 arch/arm64/include/asm/mte-kasan.h | 20 ++++++---
 include/linux/kasan.h              | 34 ++++++++-------
 lib/test_kasan.c                   |  4 +-
 mm/kasan/common.c                  | 45 +++++++++----------
 mm/kasan/generic.c                 | 12 ++---
 mm/kasan/kasan.h                   | 19 ++++----
 mm/kasan/shadow.c                  | 10 ++---
 mm/kasan/sw_tags.c                 |  2 +-
 mm/mempool.c                       |  4 +-
 mm/page_alloc.c                    | 37 +++++++++++-----
 mm/slab.c                          | 43 ++++++++++--------
 mm/slab.h                          | 17 ++++++--
 mm/slub.c                          | 70 +++++++++++++++---------------
 14 files changed, 182 insertions(+), 139 deletions(-)

-- 
2.30.1.766.gb4fecdf3b7-goog

