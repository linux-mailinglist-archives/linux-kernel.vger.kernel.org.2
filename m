Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B82FA3FD3D1
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 08:31:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242118AbhIAGcQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 02:32:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229910AbhIAGcL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 02:32:11 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 187D2C061575
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 23:31:14 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id i6so2247240edu.1
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 23:31:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=Fsca0t6CnCa0R0W6Tovf24OVFrdfu63sXc98AJa+AeM=;
        b=f23SxrzJliNgmaFAh3HlMavDMgKzHKEV2zNzDQE5nUELhTU9sG/Bd/Oy7CqT7u9FMg
         z4ZBYXShgVJBycy6waK4TCvG3IOEvVxVKWDaa2KDUVXCpnXm8DcepuWyXC0TwRfLEeS+
         r7B00/9P9xoabDx8ZACVE8czm+yj0qGkfEugjTyiMT8Wmh3Y23v7cU3vb/z1xyVABiwh
         284Ia44+TJhsYUNZqY8w4POEk7f3rbfCYs+f33BC6xAounoys3vwTwWS5N8Yry/F6/Mo
         r5xFKUMRV/PGzkULNbIVk1uZl1b+aacjDbn8FOPVmo733/Qvz7Se3pp+1R58jxBoZaUO
         FMLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition;
        bh=Fsca0t6CnCa0R0W6Tovf24OVFrdfu63sXc98AJa+AeM=;
        b=TqZVVCWVgshSBewwPlWTo6azJoCEkXk3pwHbXHvrKcHpmMARiBYvhR2i8ZuQMaQd3Y
         L6fX7BctPKvsiMxw/VYARXwCgWnZh/RpPam4dQ2U/2dLGGc+tMmizVd26Y0Ztoajal5P
         lZRWmSB9bIhZMiGAjaLoywnfdCf0ytVlH58wPgYGQyGPOk7lt+Zm2lU36nyyw72pVBIE
         ucQ3jQwQJyTnQ+jtd6+RGIgaKKxz0egnVnO1EAx/OOSqxOuKKYXcZF6BLYOMV+t7VHp6
         mW+0D34JL2YtPcMQs0UPKYrjvX02Z6MNaOcgfCsJm6tUuPr4h7+5ZJaZIFRLGFQ7ARO1
         2dww==
X-Gm-Message-State: AOAM530cHyOZXlK+GxKEm+QnH8WIlikPIONa+p65d9uI5Unv7Zr/3lGI
        08bslKPVqh1DOPH2xiRKGcY=
X-Google-Smtp-Source: ABdhPJyeClWBhm4Wfp9OJXHD/EuGjR4VIrDHJh23BrFh7HRM4ReUrwhB7BDy/4yCQIvUF7DEjLFZSg==
X-Received: by 2002:a05:6402:d6b:: with SMTP id ec43mr29718673edb.107.1630477872740;
        Tue, 31 Aug 2021 23:31:12 -0700 (PDT)
Received: from gmail.com (0526ECFD.dsl.pool.telekom.hu. [5.38.236.253])
        by smtp.gmail.com with ESMTPSA id mb14sm9287173ejb.81.2021.08.31.23.31.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Aug 2021 23:31:12 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Wed, 1 Sep 2021 08:31:10 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] locking/debug updates for v5.15
Message-ID: <YS8eLmLdB7a9WLGd@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest locking/debug git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking-debug-2021-09-01

   # HEAD: 4812c9111220b0af00f7a436cc02ffaed289962c Merge branch 'lkmm' of git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu into locking/debug

LKMM updates:

 - Update documentation and code example

KCSAN updates:

 - Introduce CONFIG_KCSAN_STRICT (which RCU uses)
 - Optimize use of get_ctx() by kcsan_found_watchpoint()
 - Rework atomic.h into permissive.h
 - Add the ability to ignore writes that change only one bit of a given data-racy variable.
 - Improve comments

 Thanks,

	Ingo

------------------>
Manfred Spraul (1):
      tools/memory-model: Heuristics using data_race() must handle all values

Marco Elver (8):
      kcsan: Improve some Kconfig comments
      kcsan: Remove CONFIG_KCSAN_DEBUG
      kcsan: Introduce CONFIG_KCSAN_STRICT
      kcsan: Reduce get_ctx() uses in kcsan_found_watchpoint()
      kcsan: Rework atomic.h into permissive.h
      kcsan: Print if strict or non-strict during init
      kcsan: permissive: Ignore data-racy 1-bit value changes
      kcsan: Make strict mode imply interruptible watchers

Paul E. McKenney (3):
      tools/memory-model: Make read_foo_diagnostic() more clearly diagnostic
      tools/memory-model: Add example for heuristic lockless reads
      tools/memory-model: Document data_race(READ_ONCE())


 Documentation/dev-tools/kcsan.rst                  |  12 ++
 kernel/kcsan/atomic.h                              |  23 ----
 kernel/kcsan/core.c                                |  77 +++++++----
 kernel/kcsan/kcsan_test.c                          |  32 +++++
 kernel/kcsan/permissive.h                          |  94 +++++++++++++
 lib/Kconfig.kcsan                                  |  42 ++++--
 .../memory-model/Documentation/access-marking.txt  | 151 ++++++++++++++++++---
 7 files changed, 352 insertions(+), 79 deletions(-)
 delete mode 100644 kernel/kcsan/atomic.h
 create mode 100644 kernel/kcsan/permissive.h
