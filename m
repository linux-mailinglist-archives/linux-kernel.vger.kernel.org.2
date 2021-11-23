Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16CE945A37C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 14:13:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235664AbhKWNQL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 08:16:11 -0500
Received: from mout.gmx.net ([212.227.15.19]:39423 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231240AbhKWNQJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 08:16:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1637673180;
        bh=n/UBJfLfj0Q6FnUyXlyaDPmDmGgQu29pnuAOTSrCZT8=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=RTKABBArOlMZ//78MNfZQmE5dQ+4ugONWG71hpvaRNKJ+Jl8u25/Jc8e8E3dC8JNp
         F11HA7/t8N+brmxk/m7NEVHZPDUUrOZo2vUjHM1iv/VYYSH85EdGvD/NEzTjKdeJ3A
         FzL7p2yQqtNN5LRwsoNfmcisN7w751AYceJ/yTPc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.fritz.box ([185.221.148.50]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MLQxN-1n7rnk41tD-00IRMr; Tue, 23
 Nov 2021 14:13:00 +0100
Message-ID: <904392102aee146723ebd442c6289db10f85f421.camel@gmx.de>
Subject: Re: mm: LTP/memcg testcase regression induced by
 8cd7c588decf..66ce520bb7c2 series
From:   Mike Galbraith <efault@gmx.de>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     lkml <linux-kernel@vger.kernel.org>
Date:   Tue, 23 Nov 2021 14:12:59 +0100
In-Reply-To: <21c3489c7ce8342d392c08547a3222a9c289e9fc.camel@gmx.de>
References: <99e779783d6c7fce96448a3402061b9dc1b3b602.camel@gmx.de>
         <20211123091304.GC3366@techsingularity.net>
         <21c3489c7ce8342d392c08547a3222a9c289e9fc.camel@gmx.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.1 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:CyOsLm3RyMcZcvidMb14cF/qMkKj3kBD/uyfXkBDh+KtgmYlSqd
 UYmHoBPGbqd9v9HN2yfYYaJZrpYVkfbzRL5lHSwIxvmazMcX7tiIEID+Lq7ICdExIada3B5
 vXMbwj2G8KsvJKxT8RZqgEhqGBQ4sRz6EsZVnR7nUPvZlzlo0ZOSAoExViI0TtHhSGQKkRU
 0f4mmjM6LzSI7yJ++dGkw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:rUjYx5bbzls=:ZDLoEnt/C1E4JOoqU2yO8w
 mHDEn1zogSxZQzpshTMi7TGl+uCg6EhEahq+bLNqsGwgdkSc+IWvHZD07GYh/XrRWKgIcgHKK
 t/hn9mQxtcIg3gKWIKwbABPW86Qw1Nc4BwgQcaCdQ6c2cuFI2eJ2RqzwbETGHrbLCKZ4kcQD+
 g6G+IDc3jGVR+kjtasNpC0xX+G3l3wTFfXuO5hqz8JYYmNbqLfByxP5nQ3yNBmdkaQfDJj0JF
 qSp7T8NZCd4lh+m6dS0dFgD+RDRd80H/kKKG8OspX8cQwS1OZ9KTWOzN/uYduXGkwvF9VIr2M
 hBTDpTm3agC2mvWfYKwqEJWtFK7YzPaLHZ4Dr0+8VNNLbu97MiwunLGdly5CTnkmHdVVhCgqe
 ljy/SnINJTP4/S4XIlxDaveL0TFMrRHZT4AifWzu8ElLHTcRx9Ze/fpZdhzMqmMUVTJe6Lq/6
 VjYnOX5wC4H0lG4WNDPgp9yKMr2ldm4wg889dCl/95vZnM3BfWegI8PoOAQCp2QqYce1izcVp
 OS1H1g4sxAXMWq4vcQS2eD1o0wkms3Jhf0LNDbHJmnO386tTiMYIsPF8rFyskiUg1CFb3VwHp
 Twx7qhZhA4ljAwpSbeAop4Rd1l+aylEKrdkXRAkB8e6yjQOdwX9TMok529lSSDWHvRuAr5yfu
 pi/R72J0fOkYhi0st+yRcXwbP80vVEEH5X+vKq51o0uwE1Ym0ZMI39s3VrP1RdQaNnP1sQJmf
 4Ms4nD1I6JIaS8zPS0lWba9YXmsBWZY1YOD+afkIWFh8yg+/dt3EjZ6CL/hf8vrZgHFItAzNc
 CQA4UWoA8PFes/Vlqaq+M56rEETFpme1fohbxUYwR1zyfBaFtyF37E+sEi5cxxSayPmFBTj+H
 KBJG5eBC8y2RScjlb/FjTXKTsSjEq3XCKLfg5j9bzUG3O17T+5PQZZ4mDO3DjibUKYT3g6GyA
 Ft9xbOOdTmC5oixIcSamVQMHY25o+bSUHt0aQjYPXphaFjxNrjNhj9jacOl5sKL53PRclkl8L
 rhoyX4vt896cb9NLpmljDeegB0tixaeTXC28LhkgQPPJF9PMa1WcWhAYBi8YCcRvYPxJm/Bmw
 DYMOA7WCHzs7w0=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2021-11-23 at 12:18 +0100, Mike Galbraith wrote:
> On Tue, 2021-11-23 at 09:13 +0000, Mel Gorman wrote:
> >
> > I'll see can I reproduce this...
>
> You likely already know this, but just in case, just plunk the below
> into $LTPROOT/runtest/foo, and $LTPROOT/runltp -f foo.
>
> #DESCRIPTION:Resource Management testing
> memcg_regression=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 memcg_regress=
ion_test.sh

Editing memcg_regression_test.sh to only run test_4() works fine, and
an earlier kernel does oom-kill swapoff as it expects.

  319.265016] swapoff invoked oom-killer: gfp_mask=3D0x1100cca(GFP_HIGHUSE=
R_MOVABLE), order=3D0, oom_score_adj=3D0

New kernel says it oom-killed, but it's in the penalty box.

[  272.325727] swapoff invoked oom-killer: gfp_mask=3D0x1100cca(GFP_HIGHUS=
ER_MOVABLE), order=3D0, oom_score_adj=3D0

crash> ps | grep memcg
   4105   4104   4  ffff953bd1a88000  IN   0.0   15176   3596  memcg_regre=
ssio
   4115   4105   0  ffff953beffe2880  IN   0.0   15172   3580  memcg_test_=
4.sh
   4117   4115   7  ffff953c0b818000  IN   0.2  110020  38404  memcg_test_=
4
crash> ps | grep swapoff
   4138   4115   1  ffff953bf2f70000  UN   0.0   19032      0  swapoff
crash> bt -sx 4138
PID: 4138   TASK: ffff953bf2f70000  CPU: 5   COMMAND: "swapoff"
 #0 [ffffad1a02957770] __schedule+0x2c3 at ffffffff932636e3
 #1 [ffffad1a02957830] schedule+0x3a at ffffffff932644ba
 #2 [ffffad1a02957840] schedule_timeout+0x1f3 at ffffffff93268d03
 #3 [ffffad1a029578b8] reclaim_throttle+0xd0 at ffffffff92a69ab0
 #4 [ffffad1a02957920] do_try_to_free_pages+0x160 at ffffffff92a6bab0
 #5 [ffffad1a02957978] try_to_free_mem_cgroup_pages+0xf4 at ffffffff92a6d2=
64
 #6 [ffffad1a02957a10] try_charge_memcg+0x19f at ffffffff92b03b6f
 #7 [ffffad1a02957ab0] charge_memcg+0x33 at ffffffff92b04313
 #8 [ffffad1a02957ad0] mem_cgroup_swapin_charge_page+0x58 at ffffffff92b06=
a08
 #9 [ffffad1a02957b00] __read_swap_cache_async+0x206 at ffffffff92ac2006
#10 [ffffad1a02957b68] swap_cluster_readahead+0x165 at ffffffff92ac2295
#11 [ffffad1a02957bf0] swapin_readahead+0x84 at ffffffff92ac24d4
#12 [ffffad1a02957c78] unuse_pte_range+0x53c at ffffffff92ac5cfc
#13 [ffffad1a02957d68] try_to_unuse+0x50e at ffffffff92ac664e
#14 [ffffad1a02957e38] __do_sys_swapoff+0x1e4 at ffffffff92ac6ba4
#15 [ffffad1a02957e90] do_syscall_64+0x58 at ffffffff93256138
#16 [ffffad1a02957ea8] exit_to_user_mode_prepare+0xf8 at ffffffff9293f138
#17 [ffffad1a02957ec0] syscall_exit_to_user_mode+0x18 at ffffffff9325a358
#18 [ffffad1a02957ed0] do_syscall_64+0x67 at ffffffff93256147
#19 [ffffad1a02957ef0] syscall_exit_to_user_mode+0x18 at ffffffff9325a358
#20 [ffffad1a02957f28] exc_page_fault+0x67 at ffffffff93259c97
#21 [ffffad1a02957f50] entry_SYSCALL_64_after_hwframe+0x44 at ffffffff9340=
007c
    RIP: 00007f6da7cd9997  RSP: 00007fffbca10388  RFLAGS: 00000202
    RAX: ffffffffffffffda  RBX: 0000000000000001  RCX: 00007f6da7cd9997
    RDX: 0000000000000001  RSI: 0000000000000001  RDI: 000055bc98cb6d10
    RBP: 000055bc98cb6d10   R8: 00007fffbca103f0   R9: 0000000000000003
    R10: 000055bc98cb15af  R11: 0000000000000202  R12: 0000000000000001
    R13: 0000000000000000  R14: 00007fffbca103f0  R15: 0000000000000000
    ORIG_RAX: 00000000000000a8  CS: 0033  SS: 002b
crash>

Enabling sched events for it...

homer:..debug/tracing # tail -25 trace
         swapoff-4138    [001] d....  1641.929650: sched_switch: prev_comm=
=3Dswapoff prev_pid=3D4138 prev_prio=3D120 prev_state=3DD =3D=3D> next_com=
m=3Dswapper/1 next_pid=3D0 next_prio=3D120
          <idle>-0       [001] d.s..  1642.441625: sched_waking: comm=3Dsw=
apoff pid=3D4138 prio=3D120 target_cpu=3D001
          <idle>-0       [001] dNs..  1642.441631: sched_wakeup: comm=3Dsw=
apoff pid=3D4138 prio=3D120 target_cpu=3D001
          <idle>-0       [001] d....  1642.441638: sched_switch: prev_comm=
=3Dswapper/1 prev_pid=3D0 prev_prio=3D120 prev_state=3DR =3D=3D> next_comm=
=3Dswapoff next_pid=3D4138 next_prio=3D120
         swapoff-4138    [001] d....  1642.441642: sched_waking: comm=3Dkw=
orker/1:0 pid=3D5005 prio=3D120 target_cpu=3D001
         swapoff-4138    [001] d....  1642.441643: sched_stat_runtime: com=
m=3Dswapoff pid=3D4138 runtime=3D11453 [ns] vruntime=3D45946584931 [ns]
         swapoff-4138    [001] d....  1642.441645: sched_wakeup: comm=3Dkw=
orker/1:0 pid=3D5005 prio=3D120 target_cpu=3D001
         swapoff-4138    [001] d....  1642.441652: sched_stat_runtime: com=
m=3Dswapoff pid=3D4138 runtime=3D8758 [ns] vruntime=3D45946593689 [ns]
         swapoff-4138    [001] d....  1642.441653: sched_switch: prev_comm=
=3Dswapoff prev_pid=3D4138 prev_prio=3D120 prev_state=3DD =3D=3D> next_com=
m=3Dkworker/1:0 next_pid=3D5005 next_prio=3D120
          <idle>-0       [001] d.s..  1642.953622: sched_waking: comm=3Dsw=
apoff pid=3D4138 prio=3D120 target_cpu=3D001
          <idle>-0       [001] dNs..  1642.953627: sched_wakeup: comm=3Dsw=
apoff pid=3D4138 prio=3D120 target_cpu=3D001
          <idle>-0       [001] d....  1642.953634: sched_switch: prev_comm=
=3Dswapper/1 prev_pid=3D0 prev_prio=3D120 prev_state=3DR =3D=3D> next_comm=
=3Dswapoff next_pid=3D4138 next_prio=3D120
         swapoff-4138    [001] d....  1642.953638: sched_waking: comm=3Dkw=
orker/1:0 pid=3D5005 prio=3D120 target_cpu=3D001
         swapoff-4138    [001] d....  1642.953639: sched_stat_runtime: com=
m=3Dswapoff pid=3D4138 runtime=3D10995 [ns] vruntime=3D45946604684 [ns]
         swapoff-4138    [001] d....  1642.953641: sched_wakeup: comm=3Dkw=
orker/1:0 pid=3D5005 prio=3D120 target_cpu=3D001
         swapoff-4138    [001] d....  1642.953648: sched_stat_runtime: com=
m=3Dswapoff pid=3D4138 runtime=3D8633 [ns] vruntime=3D45946613317 [ns]
         swapoff-4138    [001] d....  1642.953649: sched_switch: prev_comm=
=3Dswapoff prev_pid=3D4138 prev_prio=3D120 prev_state=3DD =3D=3D> next_com=
m=3Dkworker/1:0 next_pid=3D5005 next_prio=3D120
          <idle>-0       [001] d.s..  1643.465642: sched_waking: comm=3Dsw=
apoff pid=3D4138 prio=3D120 target_cpu=3D001
          <idle>-0       [001] dNs..  1643.465654: sched_wakeup: comm=3Dsw=
apoff pid=3D4138 prio=3D120 target_cpu=3D001
          <idle>-0       [001] d....  1643.465674: sched_switch: prev_comm=
=3Dswapper/1 prev_pid=3D0 prev_prio=3D120 prev_state=3DR =3D=3D> next_comm=
=3Dswapoff next_pid=3D4138 next_prio=3D120
         swapoff-4138    [001] d....  1643.465683: sched_waking: comm=3Dkw=
orker/1:0 pid=3D5005 prio=3D120 target_cpu=3D001
         swapoff-4138    [001] d....  1643.465686: sched_stat_runtime: com=
m=3Dswapoff pid=3D4138 runtime=3D28731 [ns] vruntime=3D45946642048 [ns]
         swapoff-4138    [001] d....  1643.465690: sched_wakeup: comm=3Dkw=
orker/1:0 pid=3D5005 prio=3D120 target_cpu=3D001
         swapoff-4138    [001] d....  1643.465708: sched_stat_runtime: com=
m=3Dswapoff pid=3D4138 runtime=3D21966 [ns] vruntime=3D45946664014 [ns]
         swapoff-4138    [001] d....  1643.465711: sched_switch: prev_comm=
=3Dswapoff prev_pid=3D4138 prev_prio=3D120 prev_state=3DD =3D=3D> next_com=
m=3Dkworker/1:0 next_pid=3D5005 next_prio=3D120
homer:..debug/tracing #

...I bet if I were reeeeeally patient, I might see the test pass.

LOL, and as I write this, it just did :)

	-Mike
