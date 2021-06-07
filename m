Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6425239DD27
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 14:58:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230306AbhFGNAL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 09:00:11 -0400
Received: from mail-qv1-f74.google.com ([209.85.219.74]:45695 "EHLO
        mail-qv1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230390AbhFGNAJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 09:00:09 -0400
Received: by mail-qv1-f74.google.com with SMTP id n17-20020ad444b10000b02902157677ec50so13108753qvt.12
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jun 2021 05:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=n+BHm+6M37s7n8g9zZY3JE9atHfS3eOCealK8Ja+AsE=;
        b=sRyyLxFtv2v0ZTwxiLzEIh1iIlUrL9etXUB/34Y5NRLtYmHP96rYioIzfF1k+hzk74
         KH90eSgplygj56y1g4yORIjgagSBLZ/ZutlD4dVleOrAXKd7pdCXF9lBX4D+9/vE9tti
         cW54+eCf8D6oy+5BCPYGEDj0NILZI4de6NgN7i7u/yMQLvYe1rQzaph9uvgoDDAm5LSt
         Cbaa4eXiTC2YuTdRS3bIwNamAm5MOY0Fb+TNWFdRFaN18iyKbHecZKdSV+SgVC+NXj1d
         Jbi5tXqE/nCRuHDYJXCNJa4jaD/VdTMkY+yolz5VA7V5MKEI4ZvRREznWQO//u1kufHP
         usnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=n+BHm+6M37s7n8g9zZY3JE9atHfS3eOCealK8Ja+AsE=;
        b=rtpbqSOenGAnE0QlOCFMJFU3FZpcKjubnejSefZxjLkbmyDJR3xXgvQNmKAtn1mzp5
         7CEa3g43LuOwV6s4/UZkS19lR+WveqF89plX62Bd8nz6UUG/hBxQ8I5Kfb5lTjc1P9Cs
         xQZOycXm/yq5fNK3Eq5ZmxYGPRmfmEziK4tcAURMm9A7eL/JpmhPymprCN288wc3D5Mg
         3XKUMT6Qc5stPCaWFNvlLZkqN2WOfRm0VAc9kEZ0AzFsn/3Y083qJP6DEYk0kFoKYhkn
         fAXeP6gVxgfcSZeNCHb9QITz/Bt5hTfNd2J9BijsnFpv9DYttpsVPKTED2Lud8uDHlCN
         Wk9A==
X-Gm-Message-State: AOAM533pHHEc7KglnjzM47bZuKYjciew0XNOic5X4IXm81j56WfHStVy
        E7wGn40f7hT9ffp0Wa2YkYK5k6QWlg==
X-Google-Smtp-Source: ABdhPJz6+4fXZ/GCrUCTQvd/UFxSnP3BUq2wb9MCDsZ/5cVKfAQPsKdxvsQdDHRX+lbHogng50UdpM8lBg==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:15:13:2587:50:741c:6fde])
 (user=elver job=sendgmr) by 2002:a0c:c587:: with SMTP id a7mr17495331qvj.59.1623070624677;
 Mon, 07 Jun 2021 05:57:04 -0700 (PDT)
Date:   Mon,  7 Jun 2021 14:56:46 +0200
Message-Id: <20210607125653.1388091-1-elver@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.32.0.rc1.229.g3e70b5a671-goog
Subject: [PATCH 0/7] kcsan: Introduce CONFIG_KCSAN_PERMISSIVE
From:   Marco Elver <elver@google.com>
To:     elver@google.com, paulmck@kernel.org
Cc:     boqun.feng@gmail.com, mark.rutland@arm.com, will@kernel.org,
        glider@google.com, dvyukov@google.com, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While investigating a number of data races, we've encountered data-racy
accesses on flags variables to be very common. The typical pattern is a
reader masking all but one bit, and the writer setting/clearing only 1
bit (current->flags being a frequently encountered case; mm/sl[au]b.c
disables KCSAN for this reason currently).

Since these types of "trivial" data races are common (assuming they're
intentional and hard to miscompile!), having the option to filter them
(like we currently do for other types of data races) will avoid forcing
everyone to mark them, and deliberately left to preference at this time.

The primary motivation is to move closer towards more easily filtering
interesting data races (like [1], [2], [3]) on CI systems (e.g. syzbot),
without the churn to mark all such "trivial" data races.
[1] https://lkml.kernel.org/r/20210527092547.2656514-1-elver@google.com
[2] https://lkml.kernel.org/r/20210527104711.2671610-1-elver@google.com
[3] https://lkml.kernel.org/r/20210209112701.3341724-1-elver@google.com

Notably, the need for further built-in filtering has become clearer as
we notice some other CI systems (without active moderation) trying to
employ KCSAN, but usually have to turn it down quickly because their
reports are quickly met with negative feedback:
https://lkml.kernel.org/r/YHSPfiJ/h/f3ky5n@elver.google.com

The rules are implemented and guarded by a new option
CONFIG_KCSAN_PERMISSIVE. With it, we will ignore data races with only
1-bit value changes. Please see more details in in patch 7/7.

The rest of the patches are cleanups and improving configuration.

I ran some experiments to see what data races we're left with. With
CONFIG_KCSAN_PERMISSIVE=y paired with syzbot's current KCSAN config
(minimal kernel, most permissive KCSAN options), we're "just" about ~100
reports away to a pretty silent KCSAN kernel:

  https://github.com/google/ktsan/tree/kcsan-permissive-with-dataraces
  [ !!Disclaimer!! None of the commits are usable patches nor guaranteed
    to be correct -- they merely resolve a data race so it wouldn't be
    shown again and then moved on. Expect that simply marking is not
    enough for some! ]

Most of the data races look interesting enough, and only few already had
a comment nearby explaining what's happening.

All data races on current->flags, and most other flags are absent
(unlike before). Those that were reported all had value changes with >1
bit. A limitation is that few data races are still reported where the
reader is only interested in 1 bit but the writer changed more than 1
bit. A complete approach would require compiler changes in addition to
the changes in this series -- but since that would further reduce the
data races reported, the simpler and conservative approach is to stick
to the value-change based rules for now.

Marco Elver (7):
  kcsan: Improve some Kconfig comments
  kcsan: Remove CONFIG_KCSAN_DEBUG
  kcsan: Introduce CONFIG_KCSAN_STRICT
  kcsan: Reduce get_ctx() uses in kcsan_found_watchpoint()
  kcsan: Rework atomic.h into permissive.h
  kcsan: Print if strict or non-strict during init
  kcsan: permissive: Ignore data-racy 1-bit value changes

 Documentation/dev-tools/kcsan.rst | 12 ++++
 kernel/kcsan/atomic.h             | 23 --------
 kernel/kcsan/core.c               | 77 ++++++++++++++++---------
 kernel/kcsan/kcsan_test.c         | 32 +++++++++++
 kernel/kcsan/permissive.h         | 94 +++++++++++++++++++++++++++++++
 lib/Kconfig.kcsan                 | 39 +++++++++----
 6 files changed, 215 insertions(+), 62 deletions(-)
 delete mode 100644 kernel/kcsan/atomic.h
 create mode 100644 kernel/kcsan/permissive.h

-- 
2.32.0.rc1.229.g3e70b5a671-goog

