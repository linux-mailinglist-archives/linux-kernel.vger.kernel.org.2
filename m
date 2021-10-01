Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3AA841EB30
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Oct 2021 12:50:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352922AbhJAKv6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Oct 2021 06:51:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352728AbhJAKv5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Oct 2021 06:51:57 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94017C06177C
        for <linux-kernel@vger.kernel.org>; Fri,  1 Oct 2021 03:50:12 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id x7so32143786edd.6
        for <linux-kernel@vger.kernel.org>; Fri, 01 Oct 2021 03:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=Q0Ww4rdF93vuhLA9EB8gy8zyZFUhPSXKcFE+ISMqwg0=;
        b=wcZvcDO43h0zIQAIwDovuHJoDyirgyV5cYvW5x/H2yCkDuPswY2OXVOEu2D6AO34fY
         ANbbxnLfGpBpoFxboRHaYI6de6ydIWbE9N/zqKULfh62kUJseMiS6lXYkZhCq1l3MPYe
         vV/m835fq8UqpAUioTWa1xBfwLmCMRRHHGD32+KqCy1io9pahXpjxvmraJcDHpafrg6S
         7fwzn/I7Dnx6kukl7wxM0JCKQGwgXRkn0f3MywMCJJSo0hpDiiGLO19qaMuSTab4GlXx
         pDdDxXeyS9MRNBmBB4u6kydOaUCPQ0rhs/5kvQkB/ChD/LGPuggPgFz7aE2PmmGJjJWi
         ZVMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=Q0Ww4rdF93vuhLA9EB8gy8zyZFUhPSXKcFE+ISMqwg0=;
        b=MFP1QYxdq4Ew4oLWunElIki+eCar2afWgbM6MBc4RVm1Vtg+WzdSAZ8CJPcdb/Mptv
         1cAvWzg2jMZbjKp+dcMXyq56qGjfdn2N4i1o1P4r4xCG2QYZJH26u8q3SkDeFjqYXZls
         3Hw9lRHgQp+XuNd7j/WTU5B1n5VhLNkWYYawRWcCNzVnkYXO6+2xJPJUCcuzRIgTSG8t
         lWmEhk1W2uWxTmsIWZZuWZ4Bs3yF/L9Wr2EP5M9UVDq3TAsIh5kbBGxZ+MLZHoCeQN5E
         eTVGIn/uVBk3HzaPorD6M/0fEQfd+Da+lVg6v2dvoJID5QzltKfT8pjcDW/5J1qEyVIQ
         jIAw==
X-Gm-Message-State: AOAM533f54WsOQWZqN7lXxgfWuaUOGeP/hESKu89zsyKDJ2n0G45Uc4d
        3Fo59MT3tQd2cRxvqqSA9dceaFKSDGuZlXZGhLIszHmRWgvfyA==
X-Google-Smtp-Source: ABdhPJwC3mpxAp+yFDP18LlzEJJAxEi6YO60QJjagz4jHMt+1+jwJGVWTjZvA/aTzdbygkEXB/7hehkVUmcIc20uTW8=
X-Received: by 2002:a05:6402:1778:: with SMTP id da24mr13776581edb.398.1633085409734;
 Fri, 01 Oct 2021 03:50:09 -0700 (PDT)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Fri, 1 Oct 2021 16:19:58 +0530
Message-ID: <CA+G9fYsKjyOL1xj+GFC=Ab7Yw+b0Tg9jf8uvnN2tOc6OdupA-Q@mail.gmail.com>
Subject: swim3.c:1200:38: error: 'FLOPPY_MAJOR' undeclared (first use in this function)
To:     open list <linux-kernel@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        lkft-triage@lists.linaro.org
Cc:     Jens Axboe <axboe@kernel.dk>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Following build errors noticed while building Linux next 20211001
with gcc-11 for powerpc architecture.

kernel/sched/debug.c: In function 'print_cfs_group_stats':
kernel/sched/debug.c:460:41: warning: unused variable 'stats'
[-Wunused-variable]
  460 |                struct sched_statistics *stats =
__schedstats_from_se(se);
      |                                         ^~~~~
In file included from include/linux/blkdev.h:6,
                 from include/linux/blk-mq.h:5,
                 from drivers/block/swim3.c:24:
drivers/block/swim3.c: In function 'swim3_attach':
drivers/block/swim3.c:1200:38: error: 'FLOPPY_MAJOR' undeclared (first
use in this function)
 1200 |                 rc = register_blkdev(FLOPPY_MAJOR, "fd");
      |                                      ^~~~~~~~~~~~
include/linux/genhd.h:276:27: note: in definition of macro 'register_blkdev'
  276 |         __register_blkdev(major, name, NULL)
      |                           ^~~~~
drivers/block/swim3.c:1200:38: note: each undeclared identifier is
reported only once for each function it appears in
 1200 |                 rc = register_blkdev(FLOPPY_MAJOR, "fd");
      |                                      ^~~~~~~~~~~~
include/linux/genhd.h:276:27: note: in definition of macro 'register_blkdev'
  276 |         __register_blkdev(major, name, NULL)
      |                           ^~~~~
make[3]: *** [scripts/Makefile.build:288: drivers/block/swim3.o] Error 1
make[3]: Target '__build' not remade because of errors.
make[2]: *** [scripts/Makefile.build:571: drivers/block] Error 2
make[2]: Target '__build' not remade because of errors.
make[1]: *** [Makefile:2034: drivers] Error 2

Build config:
https://builds.tuxbuild.com/1ytcB62L9I617oV0cveJtUhcpUu/config

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

meta data:
-----------
    git_repo: https://gitlab.com/Linaro/lkft/mirrors/next/linux-next
    git_sha: a25006a77348ba06c7bc96520d331cd9dd370715
    git_short_log: a25006a77348 (\"Add linux-next specific files for 20211001\")
    kconfig:  ppc6xx_defconfig
    kernel_version: 5.15.0-rc3
    target_arch: powerpc
    toolchain: gcc-11

steps to reproduce:
https://builds.tuxbuild.com/1ytcB62L9I617oV0cveJtUhcpUu/tuxmake_reproducer.sh

--
Linaro LKFT
https://lkft.linaro.org
