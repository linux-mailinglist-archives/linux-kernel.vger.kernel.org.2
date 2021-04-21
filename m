Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07B5F36697C
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 12:52:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235396AbhDUKwg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 06:52:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230000AbhDUKwf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 06:52:35 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D856C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 03:52:01 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id p196-20020a37a6cd0000b02902e41c0c90bbso1732725qke.5
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 03:52:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=sw+9jYBxrqSEYlhC6g7s4hihWn7xQEI251/x8DCExM4=;
        b=niS9o6XJW15BgeAt66tRA+u87VsppXQgRDjyUi7vi7+RzcRN5tGboc3Y4Dux+70z2K
         jqRWXIKAvKhitjw8mDVCUyt+YkxMgXeEmSh1o8wgjQFDMYPk+a64EW2UmvcTWWi+P+Vo
         ix2X81SAy6qwLKkub9epNGmLn3zlprAfWf9V8hruwqDXQjUIiQl5i0egdjHCI6A4WsPI
         ZIkaOT7zXuulEz1aMpl8A1yo1kcGq6gBru5BPD1Lmpgajdu+cc+8OmUFE1uGxYgZHOLN
         z87b4xk+EI8zqoYIUoHYkmpHsV6MI9hNUbp/UJgCoO0rAvpESrv0vBQzj0hasrdUPiZQ
         WkXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=sw+9jYBxrqSEYlhC6g7s4hihWn7xQEI251/x8DCExM4=;
        b=R3ZLFQ7KSZRwR4HtEnRgrLv44A7R6jQ94WZeGWe/7gp1ptWmxs5u+XYTwJbsa1y+Af
         3DnaIZ7lZtvNv/gOz+NwVi7QqWXOwNtco6ChMdg5vALpI9DbnIhKQeV07I6t7RknMM30
         LrF0hIKok5Am45vF8EMO6RWO6Go0BhvpFGVM7Mt/+SgPirc2GfWpJkm8X6irQOYtFkGS
         GqY1Sp3S7dvCNtFhXid7Y/CKlp7tMIgU8cyeq4It9IgL1mIIPTa5u9P/fBgtOnbVX65i
         NjVnEu7UJFXa3Q8D2jXPWCNBo6BbH0kLjEGgmowhDfrcnEN34OsNnDYPREm5aDJNJXwZ
         gG0w==
X-Gm-Message-State: AOAM531w1pROUNJ6ob+0kiNClg73EWgOd996i0YVU/T213MHKOxNKbcJ
        u0nXdTvWrlo5NQm+OMU0Csx2TrGf/w==
X-Google-Smtp-Source: ABdhPJxbhjQSZUVIqBwWaNHt9KmfKEu61gegKhBYh8G8q+ZgtJQobtOJZHrdlreDY95xs18AvjUrvcoyEg==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:15:13:c552:ee7c:6a14:80cc])
 (user=elver job=sendgmr) by 2002:ad4:5be1:: with SMTP id k1mr12623987qvc.55.1619002320199;
 Wed, 21 Apr 2021 03:52:00 -0700 (PDT)
Date:   Wed, 21 Apr 2021 12:51:29 +0200
Message-Id: <20210421105132.3965998-1-elver@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.31.1.368.gbe11c130af-goog
Subject: [PATCH v2 0/3] kfence: optimize timer scheduling
From:   Marco Elver <elver@google.com>
To:     elver@google.com, akpm@linux-foundation.org
Cc:     glider@google.com, dvyukov@google.com, jannh@google.com,
        mark.rutland@arm.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, kasan-dev@googlegroups.com, hdanton@sina.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We have observed that mostly-idle systems with KFENCE enabled wake up
otherwise idle CPUs, preventing such to enter a lower power state.
Debugging revealed that KFENCE spends too much active time in
toggle_allocation_gate().

While the first version of KFENCE was using all the right bits to be
scheduling optimal, and thus power efficient, by simply using
wait_event() + wake_up(), that code was unfortunately removed.

As KFENCE was exposed to various different configs and tests, the
scheduling optimal code slowly disappeared. First because of hung task
warnings, and finally because of deadlocks when an allocation is made by
timer code with debug objects enabled. Clearly, the "fixes" were not too
friendly for devices that want to be power efficient.

Therefore, let's try a little harder to fix the hung task and deadlock
problems that we have with wait_event() + wake_up(), while remaining as
scheduling friendly and power efficient as possible.

Crucially, we need to defer the wake_up() to an irq_work, avoiding any
potential for deadlock.

The result with this series is that on the devices where we observed a
power regression, power usage returns back to baseline levels.

Changelog
---------

v2:
* Replace kfence_timer_waiting with simpler waitqueue_active() check.

v1: https://lkml.kernel.org/r/20210419085027.761150-1-elver@google.com

Marco Elver (3):
  kfence: await for allocation using wait_event
  kfence: maximize allocation wait timeout duration
  kfence: use power-efficient work queue to run delayed work

 lib/Kconfig.kfence |  1 +
 mm/kfence/core.c   | 58 ++++++++++++++++++++++++++++++++--------------
 2 files changed, 42 insertions(+), 17 deletions(-)

-- 
2.31.1.368.gbe11c130af-goog

