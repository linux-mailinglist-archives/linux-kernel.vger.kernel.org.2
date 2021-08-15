Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C4393EC6CC
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Aug 2021 05:11:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234990AbhHODLn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Aug 2021 23:11:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbhHODLi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Aug 2021 23:11:38 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C53C7C061764
        for <linux-kernel@vger.kernel.org>; Sat, 14 Aug 2021 20:11:09 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id om1-20020a17090b3a8100b0017941c44ce4so8715216pjb.3
        for <linux-kernel@vger.kernel.org>; Sat, 14 Aug 2021 20:11:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=5HBgFxuNGxuLLk+finBY0G8blyHBx8Vmnw1QUEv8sF4=;
        b=NY/bC5W6rkjho/J81seOaEzCDDwKmIEjF9ZUjhS+aQhHHUu9hYXHGucghj19UY6baB
         doNaIzTNiPAuv70EAroCEUNqnrSLx5MydU+Svo3r+cbMuM6DjU7NelmeDsI8ALcjdyVG
         Fiqj9gwmt9GMFeqPMCmNgS97ql7vqdAepcTL1+IOIsDv59iHidvJOS7h2UA604nSPCE7
         fZ4Stpxdz8MblL2GPeDJf2kB7aq2KaaJCDfWyBHbZmF7+0iJsK12XmPj8t9fYOEyzqmP
         pTmiKYgIodc/iJK5YThjRLt77y1BRLb0gSiHoixisOQ89RipkuQrnWb985waXzKZWF27
         bhNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=5HBgFxuNGxuLLk+finBY0G8blyHBx8Vmnw1QUEv8sF4=;
        b=XsTVOlQ21sY3K99UcAspzEqbOuZNjtgR/aDcj203Y2XwdQPhRcErDkGWd89tWP3Q5G
         x2/viC/uO8Rr/6zJkhgb8zFG/92JYkBXErYZ2ujUL2m5ADe8oZ2/tizWXlFgEzwkIaBI
         pHYClmNnJYJBwI60iRDBwP8ELwMtKZnHv8J7ldrcxqIMWfZWCShj++pzUs4SWap3cLEv
         e4eZ1c8dRQdabhq1pwuUPvQMdqfDKCm1UD0/C+5c4EC3xwxi+BhIlNIhMwSZ8yd6LhqW
         bUg7wWtLbskK5IiG9jLEUw0hV2UJEmYgCFDvDj1ySmXqDHHpBhO23i8BYrOtCp4h0jOR
         wP7g==
X-Gm-Message-State: AOAM5307wvBp+QhpRpr1QAc5JO+S2/oEw1pejZWDb7uPLmb5zHznCt0j
        luXJqehXBLzd67XaDS6W2CbUctAR9CncEidefJscf/VEKW0=
X-Google-Smtp-Source: ABdhPJypb7IM0tIFsKnJHUy5Bp32VmIymDmDZKadFs3kDIlfXRpMMKFZ6uxBmfDa5X+r3FwV39Sk4QOyAzPdBIbT/fY=
X-Received: by 2002:a17:90b:4c04:: with SMTP id na4mr9635660pjb.112.1628997069115;
 Sat, 14 Aug 2021 20:11:09 -0700 (PDT)
MIME-Version: 1.0
From:   Tim Lewis <elatllat@gmail.com>
Date:   Sat, 14 Aug 2021 23:10:58 -0400
Message-ID: <CA+3zgmsDd1NhJ0thX68zLxEyLuv+uSyp2LbvGymdV7nWFc2npg@mail.gmail.com>
Subject: Re: Re: [PATCH 5.10 00/19] 5.10.59-rc1 review
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Is there a reason for skipping the selftests/netfilter tests?

eg;
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.10.y/build/v5.10.57-155-ged2493daa915/testrun/5442487/suite/kselftest-net/test/netfilter:nft_trans_stress.sh/details/

I have not double checked (n=1) but it looks like this patch is the
first for that test to hang on for 13 hours. The state just before I
killed the test;

ps ax --forest
...
   2013 pts/2    Ss     0:00  \_ -bash
   2025 pts/2    S+     0:00      \_ bash scripts/kernel_test_diff.sh
   2064 pts/2    S+     0:00          \_ make SKIP_TARGETS=ptrace rtc
breakpoints kselftest
   2285 pts/2    S+     0:00              \_ make -C
./tools/testing/selftests run_tests
   2953 pts/2    S+     0:00                  \_ /bin/sh -c for TARGET
in android arm64 bpf capabilities cgroup clone3 core cpufreq
cpu-hotplug drivers/dma-buf efivarfs exec filesystems
filesystems/binde
  13616 pts/2    S+     0:00                      \_ make
OUTPUT=/media/btrfs/linux/tools/testing/selftests/netfilter -C
netfilter run_tests
  13617 pts/2    S+     0:00                          \_ /bin/sh -c
BASE_DIR="/media/btrfs/linux/tools/testing/selftests"; .
/media/btrfs/linux/tools/testing/selftests/kselftest/runner.sh; if [
"X" != "X
  13624 pts/2    S+     0:00                              \_ /bin/sh
-c BASE_DIR="/media/btrfs/linux/tools/testing/selftests"; .
/media/btrfs/linux/tools/testing/selftests/kselftest/runner.sh; if [
"X" !
  13625 pts/2    S+     0:00                                  \_
/bin/sh -c BASE_DIR="/media/btrfs/linux/tools/testing/selftests"; .
/media/btrfs/linux/tools/testing/selftests/kselftest/runner.sh; if [ "
  13626 pts/2    S+     0:00                                      \_
/bin/sh -c BASE_DIR="/media/btrfs/linux/tools/testing/selftests"; .
/media/btrfs/linux/tools/testing/selftests/kselftest/runner.sh; if
  13629 pts/2    S+     0:00
\_ /bin/sh -c BASE_DIR="/media/btrfs/linux/tools/testing/selftests"; .
/media/btrfs/linux/tools/testing/selftests/kselftest/runner.sh
  13631 pts/2    S+     0:00
   \_ perl /media/btrfs/linux/tools/testing/selftests/kselftest/prefix.pl
  16853 pts/2    R+   188:32 ping -4 127.0.0.1 -fq
  16854 pts/2    R+   188:32 ping -6 ::1 -fq
  16856 pts/2    R+   189:36 ping -4 127.0.0.1 -fq
  16857 pts/2    R+   189:36 ping -6 ::1 -fq
  16859 pts/2    R+   189:24 ping -4 127.0.0.1 -fq
  16860 pts/2    R+   189:24 ping -6 ::1 -fq
  16862 pts/2    R+   189:22 ping -4 127.0.0.1 -fq
  16863 pts/2    R+   189:22 ping -6 ::1 -fq




dmesg
...
[  248.609199] BUG: scheduling while atomic: cpuhp/1/15/0x00000002
...
[  248.609658] Call trace:
[  248.609670]  dump_backtrace+0x0/0x1a8
[  248.609675]  show_stack+0x18/0x68
[  248.609681]  dump_stack+0xd0/0x12c
[  248.609687]  __schedule_bug+0x60/0x78
[  248.609692]  __schedule+0x5d8/0x650
[  248.609696]  schedule+0x70/0x108
[  248.609702]  schedule_timeout+0x228/0x288
[  248.609707]  wait_for_completion_killable+0x88/0x170
[  248.609712]  __kthread_create_on_node+0xbc/0x1a8
[  248.609716]  kthread_create_on_node+0x58/0x80
[  248.609723]  spl_kthread_create+0x9c/0x110
[  248.609727]  taskq_thread_create+0x64/0x108
[  248.609732]  spl_taskq_expand+0xc4/0xf0
[  248.609738]  cpuhp_invoke_callback+0x180/0x210
[  248.609743]  cpuhp_thread_fun+0xd8/0x170
[  248.609747]  smpboot_thread_fn+0x1c4/0x280
[  248.609752]  kthread+0x140/0x160
[  248.609756]  ret_from_fork+0x10/0x34
...
[  385.330256] IPv6: ADDRCONF(NETDEV_CHANGE): ns2eth3: link becomes ready
