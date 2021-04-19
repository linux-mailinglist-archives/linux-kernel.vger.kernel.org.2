Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76EEA363E02
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 10:51:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238425AbhDSIv0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 04:51:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238307AbhDSIvZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 04:51:25 -0400
Received: from mail-wr1-x44a.google.com (mail-wr1-x44a.google.com [IPv6:2a00:1450:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AED40C06174A
        for <linux-kernel@vger.kernel.org>; Mon, 19 Apr 2021 01:50:55 -0700 (PDT)
Received: by mail-wr1-x44a.google.com with SMTP id 65-20020adf94c70000b0290106f90d4e1bso4413628wrr.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Apr 2021 01:50:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=VPfpXo1xSfALIUwFMBsi0FLx47EowiBPs3NWCkZXP+I=;
        b=Jqi15edE3SoTSO3W1bED5dPhh8cADbtvGhZha1HrraZ80eH2qjlIOJBqaJj/JkvKmL
         YCIJixwtWtrf770zGOp/yQ0YrvYivmLrJC/WRSTBVeSK++b+eRiZCWXBfqDOn5/p0ixW
         UEf5OSbnYh1ElUgdYkxnaDNfCkDhjPKpMEToSRzi4QRIsDZrGE+uuNGGnX3rBKVztOmd
         65swUex2nYBf4E+chFavTDh3H2ERQzmFpmnp9HSe7S7KecrlYAyGyPIzBwE4PyErohTK
         Km+DG1v3TaNQxLITTfnUheK1jhjFk7L71YYphPnPKQdRSmn/Ta2P9v/mwtsnm+XgrR/R
         YYjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=VPfpXo1xSfALIUwFMBsi0FLx47EowiBPs3NWCkZXP+I=;
        b=BNVsZjLgUxxQ8Gc099jFctXI2UWG9V3mOw5/75TuMAq5jwRpeS4wzj4EREe8sdEkkQ
         3v5OiymJe/NOoHM0F+RG43PO5PgS8WiFD7JP8BDL2+kLJ0BnKNaA6TmHhfQR6KRMmRCy
         If5pNL7SRF9QGmOwjKMocNrKgS+SFWmWkgwCOdYcLXwIgbnGo+4rCp6U+dy6iYyW3yEz
         /Z94Z20mhKjuzs3kg23gOOjBZYavbQj+BeG1PyT19zBr0Sz892Z/BONstuxoTVOpzOHr
         BMVyo/G85ZYwteCRboAi5aO1EqCVDexQPAceACwcQNKy2jPZov2WU1jbW7PRZxH/H43M
         3tUw==
X-Gm-Message-State: AOAM533DN+jUwYxWXfOCaS4V4fGmsMkbJkoC4mtxDhGdjq+cDw5dpEuT
        ni19Z0sv/8RfSFj3RkGYwXEZUy4x3A==
X-Google-Smtp-Source: ABdhPJwMgNBllV0CEdQPMGVfV0l0dDonTuTqSZkXzVJzL0IzpvF142CXs3Jp2+0muGVESO0nLgxZ/W3j8A==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:15:13:92f8:c03b:1448:ada5])
 (user=elver job=sendgmr) by 2002:a05:600c:ac2:: with SMTP id
 c2mr21244847wmr.23.1618822253817; Mon, 19 Apr 2021 01:50:53 -0700 (PDT)
Date:   Mon, 19 Apr 2021 10:50:24 +0200
Message-Id: <20210419085027.761150-1-elver@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.31.1.368.gbe11c130af-goog
Subject: [PATCH 0/3] kfence: optimize timer scheduling
From:   Marco Elver <elver@google.com>
To:     elver@google.com, akpm@linux-foundation.org
Cc:     glider@google.com, dvyukov@google.com, jannh@google.com,
        mark.rutland@arm.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, kasan-dev@googlegroups.com
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

Marco Elver (3):
  kfence: await for allocation using wait_event
  kfence: maximize allocation wait timeout duration
  kfence: use power-efficient work queue to run delayed work

 lib/Kconfig.kfence |  1 +
 mm/kfence/core.c   | 71 +++++++++++++++++++++++++++++++++++-----------
 2 files changed, 55 insertions(+), 17 deletions(-)

-- 
2.31.1.368.gbe11c130af-goog

