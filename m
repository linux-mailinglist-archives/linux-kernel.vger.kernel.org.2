Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 918913540FE
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Apr 2021 12:37:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237609AbhDEJ7W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Apr 2021 05:59:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232063AbhDEJ7U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Apr 2021 05:59:20 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF0D3C061756
        for <linux-kernel@vger.kernel.org>; Mon,  5 Apr 2021 02:59:13 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id x16so5171144qvk.3
        for <linux-kernel@vger.kernel.org>; Mon, 05 Apr 2021 02:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=T6yzdWQr/Ij2ROB484FaLONk34Ozk8SWfjeOsTlnQUo=;
        b=W/C70YWm0qTK2+Mh+E+C9Yy6XR0vw7hMxt6ousGRWV/8L8LKqa4wtVD+sLm0R+VKXF
         80hy0xQWkKgFjyzsQznrbkj7IPECDCJUD2hwGC6sXS/4yERly3xmBuTpinV4KSTlRers
         o9bPRHANQUIjHxsqdX3tmTnbIcNV+eSfuZBAswGZNo74Bnedj+P9NDIsavqGtDEkHDcy
         PiGGHupdBe9uFvBmc9SXNuDjmYB9Ubm8Y9PgrnCKGWBB7A3JKQlnQRcP/64RJQ8s7ufh
         wuoIGITZLsC6BYttEFRSUjzRbRd0nbbj3Xma1HX4dsj2QfR7DpMTWk4mzgEQECA8FSDX
         3scw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition;
        bh=T6yzdWQr/Ij2ROB484FaLONk34Ozk8SWfjeOsTlnQUo=;
        b=bjJy0vZH+Xyctfrf4LK/GenjscmgfknnGHbjn0XyC2v9+jH7Fi4rafiGo77VsVqwQg
         k7AKwKn7CY0oniXobGBBxALtuf4S8b2KCPxF9xjW1q8/W8qlLBmS8FSsRcCg272gD5dI
         4zGFmkZmClQARdAKX44HlSJzjbmcI3Xkhis6jglnATpSKM3GcYw6PfYDa7iXVOpgNT94
         RHavZExpUAq8uPpIln1QKuxmslR5yjoG8Kt2+xLCIhAvLLvwdFErn0FadIK9osILQqFt
         83EigngaLDGgWsGlNnaB0mKaNL+GElxs/j1NblwJSQ03O/8yISmOXQ4WiFRRe/IVTrNk
         hBeA==
X-Gm-Message-State: AOAM532v4k8Wt/O526jne+/3d/P8FO2cbCivR5EPTIz8mzVkdexT8tIh
        wA65HuPTAMBDwXGQCYVV6RavWSbGdXnv6A==
X-Google-Smtp-Source: ABdhPJw10IbT5l8Uxwar/5WNjOYl2zvdsAO+ESEx/6MYR2O2itg6oM9d2+GsxKtHp4rjUQrmJD5AvA==
X-Received: by 2002:ad4:538a:: with SMTP id i10mr22935471qvv.9.1617616753015;
        Mon, 05 Apr 2021 02:59:13 -0700 (PDT)
Received: from localhost (dhcp-6c-ae-f6-dc-d8-61.cpe.echoes.net. [199.96.183.179])
        by smtp.gmail.com with ESMTPSA id b12sm12301185qti.43.2021.04.05.02.59.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Apr 2021 02:59:12 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 5 Apr 2021 05:59:11 -0400
From:   Tejun Heo <tj@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [GIT PULL] wq fixes for v5.12-rc6
Message-ID: <YGrfb6lPelb7Gcbv@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Linus.

Two workqueue fixes. One is around debugobj and poses no risk. The other is
to prevent the stall watchdog from firing spuriously in certain conditions.
Not as trivial as debugobj change but is still fairly low risk.

Thanks.

The following changes since commit 2023a53bdf41b7646b1d384b6816af06309f73a5:

  Merge tag 'for-linus' of git://github.com/openrisc/linux (2021-04-03 15:42:45 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tj/wq.git for-5.12-fixes

for you to fetch changes up to 89e28ce60cb65971c73359c66d076aa20a395cd5:

  workqueue/watchdog: Make unbound workqueues aware of touch_softlockup_watchdog() 84;0;0c84;0;0c There are two workqueue-specific watchdog timestamps: (2021-04-04 13:26:49 -0400)

----------------------------------------------------------------
Wang Qing (1):
      workqueue/watchdog: Make unbound workqueues aware of touch_softlockup_watchdog() 84;0;0c84;0;0c There are two workqueue-specific watchdog timestamps:

Zqiang (1):
      workqueue: Move the position of debug_work_activate() in __queue_work()

 kernel/watchdog.c  |  5 +++--
 kernel/workqueue.c | 19 +++++++------------
 2 files changed, 10 insertions(+), 14 deletions(-)
