Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B9213B59EB
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 09:42:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232413AbhF1Hox (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 03:44:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232369AbhF1How (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 03:44:52 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A95A9C061574
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jun 2021 00:42:25 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id df12so24405855edb.2
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jun 2021 00:42:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=VMl2wLj7xObslRrjKeSz6EV2ZrGDpAHrMavopbz8jso=;
        b=YquTn4PCUlVQoiI1R0ogNq4N48oQtF2xzYc8lmNzyBARCJhNOrmCe13WkxNpfkjEky
         jT80lNzvcW01LnVl2wn8Pfnt1sZ1QOb+SOVi+uNbITW4kU0Ume1Hd6Z5ZN32U65fIqWA
         gcztElSVJjPbbO+2cufm1Kru0Mkma8n8OxmpBjd2du1v8A+vsypKnhq0cTPW8Dp+ec3A
         xvxsGyqm+jqeFgSfuQwxTWJXaYU/FZe8mqZlvOYAkIrQB8S+vohp3BW8btCJkw01TLQx
         G5EaJwjG1NqgbbgufArXd+zw5p35Q+czIuhHukdMqTABu4moXAbqa55Wwi8wFA1Rm5Mf
         YxbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition;
        bh=VMl2wLj7xObslRrjKeSz6EV2ZrGDpAHrMavopbz8jso=;
        b=YC5oX8Vkj5bhzQnCmR2qLlEt21bGXYf1Va64X/5D+qbjmgvk5CFJSMSpLJ+R/OV1ye
         WSdic1H6CV2lvbF5LvxnkjhaytRoJRIPRurAii3+GYGEUT8kJa/hQoTI/wuyJlWDRvUA
         qAk/bv4iBR/KN5yeu0We39PM4X/DHjclcnTlknzi5dE81S079/0U3ZwAH+n1I0KjCFP2
         /a9cvOf771L4f7l05wv9AjHT42njoPqOPABJjZZHyKk3eI6X31pkxgkF4PC42Ccum5JK
         j3OZ5oMnhF/cPk9lwX6JBUdIumZN5m4ak8+cBroh0a5kEQ0gOP9djHn5r0qJP21cTXmX
         T66Q==
X-Gm-Message-State: AOAM531GIHUczp68LjY9CDYV5VnsM5xArpluHCrGjyPWLDMozA+kX7TZ
        oas5yv6LVD0brQfEXH1gDpA=
X-Google-Smtp-Source: ABdhPJzU5A9QmFMJGM8MwmXjROMzJKJR5VvBUyqoYpIUqVbnhnoVqnyYbSqUP5+3l6djw2XPFy03GQ==
X-Received: by 2002:aa7:da88:: with SMTP id q8mr31214034eds.345.1624866144281;
        Mon, 28 Jun 2021 00:42:24 -0700 (PDT)
Received: from gmail.com (94-21-131-96.pool.digikabel.hu. [94.21.131.96])
        by smtp.gmail.com with ESMTPSA id x17sm9228944edr.88.2021.06.28.00.42.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jun 2021 00:42:23 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Mon, 28 Jun 2021 09:42:22 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] x86/splitlock changes for v5.14
Message-ID: <YNl9XqC0V+tdJsjI@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest x86/splitlock git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-splitlock-2021-06-28

   # HEAD: d28397eaf4c27947a1ffc720d42e8b3a33ae1e2a Documentation/x86: Add ratelimit in buslock.rst

Changes in this cycle were:

 - Add the "ratelimit:N" parameter to the split_lock_detect= boot option,
   to rate-limit the generation of bus-lock exceptions. This is both
   easier on system resources and kinder to offending applications than
   the current policy of outright killing them.

 - Document the split-lock detection feature and its parameters.

 Thanks,

	Ingo

------------------>
Fenghua Yu (4):
      Documentation/x86: Add buslock.rst
      x86/bus_lock: Set rate limit for bus lock
      Documentation/admin-guide: Add bus lock ratelimit
      Documentation/x86: Add ratelimit in buslock.rst


 Documentation/admin-guide/kernel-parameters.txt |   8 ++
 Documentation/x86/buslock.rst                   | 126 ++++++++++++++++++++++++
 Documentation/x86/index.rst                     |   1 +
 arch/x86/kernel/cpu/intel.c                     |  42 +++++++-
 4 files changed, 175 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/x86/buslock.rst

