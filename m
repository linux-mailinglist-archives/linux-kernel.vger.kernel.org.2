Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBFFC4582FD
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Nov 2021 11:57:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238020AbhKULA3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Nov 2021 06:00:29 -0500
Received: from mout.gmx.net ([212.227.17.21]:57761 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238009AbhKULA2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Nov 2021 06:00:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1637492241;
        bh=yKnYV58EFLXVowmBF/2wLo5D8sh4laZBHiSgbmnwyi0=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date;
        b=GxjdV+QKtjrnhXN4J9xcgOBemglziX/2OMGjvbNSy2iOvHB1eUE/GtsWfJqI51CO6
         1AgV5UMeUKFgbxwpKNHf1PBDRO+yZ/FrJKRCtxX5J3mXi/t3QSEZAXUzSGdQkYE6J+
         iXqKtJ8CDNSGohH2rytHzmXMSJqfX5HudVoSKmVk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.fritz.box ([185.191.216.41]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MmDIu-1mOSH31FMO-00iFPy; Sun, 21
 Nov 2021 11:57:21 +0100
Message-ID: <99e779783d6c7fce96448a3402061b9dc1b3b602.camel@gmx.de>
Subject: mm: LTP/memcg testcase regression induced by 
 8cd7c588decf..66ce520bb7c2 series
From:   Mike Galbraith <efault@gmx.de>
To:     lkml <linux-kernel@vger.kernel.org>
Cc:     Mel Gorman <mgorman@techsingularity.net>
Date:   Sun, 21 Nov 2021 11:57:20 +0100
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.1 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:+W4wcw59uw5TjP/Mw0QiPghvKqQekCoqLgbhMvBKezjVJ2hnPms
 SRLRBKEbF8NVhS0pU/aaS3RZ34zxz77uXWhhJoJecLKmeT5GYmoMZ49jwGebS0OiZ1mVxaM
 wu+Xa6xSI+MwqbL6OrfIoiODw56F/+LRMN6tfIImr04ohUBQA8ndpgRXZE89IyCQUwDC2Lg
 kptaQPDN9fYa/+ztUu38w==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:MjlZm5rIKl8=:hygzFeontVk+r5MZRzHBJ3
 fEex33dyhl++qGTZKIXInpx7ed/BAK2EOdWkhhozr9M6AN5dV8FMsMK0D1nMGvqS/o03OpDC3
 ofCRFdUuSEmmKwbi8LwqUB05xVyxCsoec92j99PvqJJlvHI8AvTbNqhO2tZjXlZ49p2BsSKrt
 wFMoJQ2SSMPnA2Mwu0pR1aE69hyRH2GIeaHHdxYT51q9bNv4+U0jpLb4tiWzn8MJgiALBQO/8
 BHFh/csKKL/IF/u8pi04hHbpPa0vhCdvpysszyo2a0Mxwi8S2r75rQg5vOFP53faAdGlftgHZ
 fzRwmzqfET5PfZixHvtnQ2ThCxwMMcHi0hejVbHtM024F38qPMmBqmnBPnW2n7o7GPb8xeRzv
 jDUgKQLyk9/6+lvYR0S2EkbDaNjqkwXNBo5/zhTOleNk+Kr+Eb9pYN2kCtVX9Q8tkIDiQsTfM
 64IILAoivlCt9ynAbJxhmOfxd99BwUKv/DqHu8dVybrG1WjTdlFS5KpepSyupjR7k4ws0buaV
 pMgDN0bWIwTrM/JaSu19RRHwH8OQ9ghPCj5v7fknDFr7amKGgNLKhrbGm6mYEb9FBKPAeg1ku
 /tiz6gYaNB+ydlsguijRB3DTFBGAjWsToyLiXrnIQsT8cN7LWQa+1ANDjm4jXiuY+ygbgeVCh
 u7UXWl0mmmE4pqq++f3GQdcfT9qXKM8nD86KqHYkjYU3yGrqY/dJBjkx8YIiLhU3eEJGdk4yH
 B3710i4RunCmv43Vjz36O6G58m5iy1bpqOiKD9OJxZvs7RLTWTLkjF8voWkTuHg3jJZpJxkfZ
 ps+mDPImm4COPcsi2Ju5F0UMfefsNUjnn+Y+6grGYh264hdkzWb4w8dpgfpYorX5+HcWIG+c+
 mpvW2IKfkAinJY1eOjf0UrElwsqla54eRTgPGNeVMKmW/aLkW0GyHzNfwx2yZGy1YRiP/ZrI5
 CozCNgKEz91mV2ei9VSZjUsBWv6H2LhtNSPE6B14TxKq3FeB0yBQU8KS3Ln+1D59heufKTQPz
 325fqj4bR7EK/c3YPbsgJhhUwzduSL/bw1impXrFVt0Eu7b2xg62uQe5KOhOBsF6u7WRXOwOi
 qglkAa7neRLpCU=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

FYI, something in this series causes LTP controllers::memcg_regression
testcase to hang forever.  Verified via brute force revert of the lot.

After letting box moan for 4.5 hours, I poked ^C repeatedly, but runltp
didn't exit/recover gracefully, and ps hung, so I nuked the box.  All
memcg_test_1 instances were stuck in reclaim_throttle().

crash> ps | grep UN
  31458      1   5  ffff88e9c8ded100  UN   0.0    7620   1156  memcg_test_=
1
  31459      1   6  ffff88e9c8de8000  UN   0.0    7620   1156  memcg_test_=
1
  31460      1   4  ffff88e9cbdd0000  UN   0.0    7620   1156  memcg_test_=
1
  31461      1   2  ffff88ea41502880  UN   0.0    7620   1156  memcg_test_=
1
  31462      1   4  ffff88ea12750000  UN   0.0    7620   1156  memcg_test_=
1
  31463      1   7  ffff88ea12752880  UN   0.0    7620   1156  memcg_test_=
1
  31464      1   3  ffff88ea01eb8000  UN   0.0    7620   1156  memcg_test_=
1
  31465      1   6  ffff88e9c2bca880  UN   0.0    7620   1156  memcg_test_=
1
  31466      1   7  ffff88e9c2bc8000  UN   0.0    7620   1156  memcg_test_=
1
  31467      1   2  ffff88ea41e82880  UN   0.0    7620   1156  memcg_test_=
1
  31476   2834   2  ffff88ea1174d100  UN   0.0   38868   3744  ps
crash> bt -sx ffff88e9c8ded100
PID: 31458  TASK: ffff88e9c8ded100  CPU: 5   COMMAND: "memcg_test_1"
 #0 [ffffb36648bc79a0] __schedule+0x2c3 at ffffffffb72636e3
 #1 [ffffb36648bc7a60] schedule+0x3a at ffffffffb72644ba
 #2 [ffffb36648bc7a70] schedule_timeout+0x1f3 at ffffffffb7268d03
 #3 [ffffb36648bc7ae8] reclaim_throttle+0xd0 at ffffffffb6a69ab0
 #4 [ffffb36648bc7b50] do_try_to_free_pages+0x160 at ffffffffb6a6bab0
 #5 [ffffb36648bc7ba8] try_to_free_mem_cgroup_pages+0xf4 at ffffffffb6a6d2=
64
 #6 [ffffb36648bc7c40] try_charge_memcg+0x19f at ffffffffb6b03b6f
 #7 [ffffb36648bc7ce0] obj_cgroup_charge_pages+0x27 at ffffffffb6b043a7
 #8 [ffffb36648bc7d08] obj_cgroup_charge+0x6f at ffffffffb6b0605f
 #9 [ffffb36648bc7d28] kmem_cache_alloc+0x86 at ffffffffb6ae7686
#10 [ffffb36648bc7d80] vm_area_alloc+0x1a at ffffffffb689aa5a
#11 [ffffb36648bc7d90] mmap_region+0x32f at ffffffffb6a9ee1f
#12 [ffffb36648bc7df8] do_mmap+0x392 at ffffffffb6a9f492
#13 [ffffb36648bc7e50] vm_mmap_pgoff+0xd5 at ffffffffb6a75125
#14 [ffffb36648bc7ed8] do_syscall_64+0x58 at ffffffffb7256138
#15 [ffffb36648bc7f28] exc_page_fault+0x67 at ffffffffb7259c97
#16 [ffffb36648bc7f50] entry_SYSCALL_64_after_hwframe+0x44 at ffffffffb740=
007c
    RIP: 00007f7b95ad9743  RSP: 00007ffe12089b08  RFLAGS: 00000246
    RAX: ffffffffffffffda  RBX: 0000000000000000  RCX: 00007f7b95ad9743
    RDX: 0000000000000003  RSI: 0000000000001000  RDI: 0000000000000000
    RBP: 0000000000000000   R8: 0000000000000000   R9: 0000000000000000
    R10: 0000000000002022  R11: 0000000000000246  R12: 0000000000000003
    R13: 0000000000001000  R14: 0000000000002022  R15: 0000000000000000
    ORIG_RAX: 0000000000000009  CS: 0033  SS: 002b
crash> bt -sx ffff88ea1174d100
PID: 31476  TASK: ffff88ea1174d100  CPU: 2   COMMAND: "ps"
 #0 [ffffb3664883fba8] __schedule+0x2c3 at ffffffffb72636e3
 #1 [ffffb3664883fc68] schedule+0x3a at ffffffffb72644ba
 #2 [ffffb3664883fc78] rwsem_down_read_slowpath+0x1bf at ffffffffb7266c8f
 #3 [ffffb3664883fd08] down_read_killable+0x5c at ffffffffb7266f3c
 #4 [ffffb3664883fd18] down_read_killable+0x5c at ffffffffb7266f3c
 #5 [ffffb3664883fd28] __access_remote_vm+0x4a at ffffffffb6a9795a
 #6 [ffffb3664883fd98] proc_pid_cmdline_read+0x16c at ffffffffb6bc3acc
 #7 [ffffb3664883fe00] vfs_read+0x9a at ffffffffb6b1d49a
 #8 [ffffb3664883fe30] ksys_read+0xa1 at ffffffffb6b1d891
 #9 [ffffb3664883fe70] do_syscall_64+0x58 at ffffffffb7256138
#10 [ffffb3664883fec0] do_sys_openat2+0x1cd at ffffffffb6b1913d
#11 [ffffb3664883ff00] do_sys_open+0x57 at ffffffffb6b1a7e7
#12 [ffffb3664883ff28] do_syscall_64+0x67 at ffffffffb7256147
#13 [ffffb3664883ff50] entry_SYSCALL_64_after_hwframe+0x44 at ffffffffb740=
007c
    RIP: 00007f192fb5cb5e  RSP: 00007ffc611e0ee8  RFLAGS: 00000246
    RAX: ffffffffffffffda  RBX: 00007f19303de010  RCX: 00007f192fb5cb5e
    RDX: 0000000000020000  RSI: 00007f19303de010  RDI: 0000000000000006
    RBP: 0000000000020000   R8: 0000000000000007   R9: 00000000ffffffff
    R10: 0000000000000000  R11: 0000000000000246  R12: 00007f19303de010
    R13: 0000000000000000  R14: 0000000000000006  R15: 0000000000000000
    ORIG_RAX: 0000000000000000  CS: 0033  SS: 002b

