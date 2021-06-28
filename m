Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1F6A3B5EF1
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 15:33:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231996AbhF1NgL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 09:36:11 -0400
Received: from mout.gmx.net ([212.227.17.21]:53625 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231964AbhF1NgK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 09:36:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1624887223;
        bh=tSO2hqOl3Y1O1JjngPo7Y8mnSrXWiZto0tnC4EfHSxQ=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date;
        b=jB3YKpSjI25D5X5o1HCAun1sqJBcMFVnV+zdubpC4gu+ombplyTnMTmZKEXcBA556
         H0ZRZ95MAR6We6xwRyHZGaJWheHnJ/dk7I2g05S4l0ZYfwjfc3lq9IuxuxvvJBlLlv
         K4jH8IMCYL7O4RPAaxomPaI9DObSFSPc/FcCVxaI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.fritz.box ([185.221.151.107]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MIdeX-1m38Al3o29-00EdM8; Mon, 28
 Jun 2021 15:33:42 +0200
Message-ID: <760cf981588a31b9a51fa1f6d485d5dbdc61400a.camel@gmx.de>
Subject: v5.13 regression - suspend went belly up
From:   Mike Galbraith <efault@gmx.de>
To:     lkml <linux-kernel@vger.kernel.org>
Cc:     Mel Gorman <mgorman@techsingularity.net>
Date:   Mon, 28 Jun 2021 15:33:42 +0200
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:BCmXLg/xLRknJQfZg3hLdWuXP+FV8haRVPMZ3U0cRu4QBQT64kr
 N9CDyj1aGMYe0oXjr/meiVtEs6SUj6KefakCm2Jf8Zln3zEmm0Ndpv4i52iHFzhwKsaJxHE
 aHz4j4bmzN+0fQ43wJvAD9QLrVoSxXMsqDJ2CJMza27oOxwHR44CZGTFEJwW+Z81fB6h4/i
 n/YjkZyt9BbTOGFn77K7w==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:ce+BE792/T4=:raelJ/hBVF8DBmOPccP0UB
 ATWQg2dux/g6V16lJ//UaH0PkXxYiaYc/hAsi8fBOmMngytILlYC2AsdeRFFnuCi9MxwLcLad
 smlyhIxrkOq8mNK7yL8Px4kitWsAirsyfMUL+pMJN2dxKwt5VoVZhdnsdo5ByCitwOfU9mW5o
 Y+0485MS+SyFu9T4Po1dEZeyDZO4FQvUrLQ3o3/wFuL4zA8CzuxjIFDkB80NeA1zuG+CNZlWm
 /tHB43gOhMc8o3fQ3AQQArFpiTf97ctdeo8Q8O36bmaAKzuLe5T2XgMHely1F4g96ygkCZsvu
 7FIMp0JCzS6yBRNTvGx7DTynM50ojKwWMCeh6MptbxJVQ41oWdPwVdH/gd7DvNVH+0XeMtOHk
 aCo0Np/tIoBpgBF4f2MSNdUJz1RHgDGipZjWkEpnX9IuWd4dag3j8Wgq3yaNy9vJOoXEbNdYY
 En7VIB+HnkYYK+CyHxlRxM06QPG10uYat1lQa8fQDxopKpGT8y6RKv37Bhhq5u4MhQq8j18jB
 t6Q7TzDrhCm8GTJ15Du2/IB92pT5K+UrkSeVc9CBnq/cv6jpbrVXmPQbvQ94/MiUGcKz0sAtK
 0dCPdH+SxF2UzACVyoRtWCYOAx25d5DDD0v/zKA3kZ7rj6Km2maT6ds7sDBVKR9vuxc9PYxOw
 az1Hbv8wk04ey+uuSnkODCxYhAjQA7TQXhn3nviBL/Q5OnyeAY2S8ZrLvopuVweDNWJPed6ok
 GeE7+mdQCidsIF4xMFgCUctnc15l7PKsow71e1i8TgCTEXPXhwZE9Ycq6iS3eU38GXSWMjiUE
 My67tENi8zuVwn0RSSjg+L7a6Xz3maE+Yq6HNkWVbIU2BqRgzihFjNN4OjQESGV9ZDngpfsCw
 0yUecC9bCM9M3hxwjrtrB/gA6dnpRFtmIJCLLx73EoNu0s9DVGoBqu+qSLH07Aj1s4Ri0lhCn
 4JkDxPRPgxN2Any8QjVN2FYW6NeWkltLv/zVodG0qtrgSuvxZsP2is/ijIZiJ034N+zoJpzf9
 oZ9IC22gMKluJRHcXM0yTuY1Enlu7xjsDWn91U6EgR7ZRP5bRrO6PHq4a2sCDiTSc94aENRZA
 CqRvhCF9rvXM7t0Gxnb/LqD7dGRbSLE/qf+
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

A regression popping up post rc7 is a bit unusual, but hohum, I suppose
they can bite whenever they damn well feel like it.  This one was
bisected rc7..release, the (surprising to me) result then confirmed in
four disgruntled local trees.

b3b64ebd38225d8032b5db42938d969b602040c2 is the first bad commit
commit b3b64ebd38225d8032b5db42938d969b602040c2
Author: Mel Gorman <mgorman@techsingularity.net>
Date:   Thu Jun 24 18:40:07 2021 -0700

    mm/page_alloc: do bulk array bounds check after checking populated ele=
ments

    Dan Carpenter reported the following

      The patch 0f87d9d30f21: "mm/page_alloc: add an array-based interface
      to the bulk page allocator" from Apr 29, 2021, leads to the followin=
g
      static checker warning:

            mm/page_alloc.c:5338 __alloc_pages_bulk()
            warn: potentially one past the end of array 'page_array[nr_pop=
ulated]'

    The problem can occur if an array is passed in that is fully populated=
.
    That potentially ends up allocating a single page and storing it past
    the end of the array.  This patch returns 0 if the array is fully
    populated.

    Link: https://lkml.kernel.org/r/20210618125102.GU30378@techsingularity=
.net
    Fixes: 0f87d9d30f21 ("mm/page_alloc: add an array-based interface to t=
he bulk page allocator")
    Signed-off-by: Mel Gorman <mgorman@techsinguliarity.net>
    Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
    Cc: Jesper Dangaard Brouer <brouer@redhat.com>
    Cc: Vlastimil Babka <vbabka@suse.cz>
    Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
    Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>

 mm/page_alloc.c | 4 ++++
 1 file changed, 4 insertions(+)

[   45.503409] PM: suspend entry (deep)
[   45.529287] Filesystems sync: 0.026 seconds
[   45.532934] Freezing user space processes ... (elapsed 0.001 seconds) d=
one.
[   45.534340] OOM killer disabled.
[   45.534341] Freezing remaining freezable tasks ...
[   65.505035] Freezing of tasks failed after 20.008 seconds (5 tasks refu=
sing to freeze, wq_busy=3D0):
[   65.505079] task:lockd           state:S stack:    0 pid: 1809 ppid:   =
  2 flags:0x00004000
[   65.505093] Call Trace:
[   65.505102]  __schedule+0x28b/0x870
[   65.505121]  schedule+0x3c/0xa0
[   65.505130]  schedule_timeout+0x1d2/0x260
[   65.505145]  ? del_timer_sync+0x40/0x40
[   65.505160]  svc_recv+0xc3/0x8a0 [sunrpc]
[   65.505310]  ? grace_ender+0x10/0x10 [lockd]
[   65.505331]  lockd+0x8b/0x190 [lockd]
[   65.505348]  ? __kthread_parkme+0x4c/0x70
[   65.505361]  kthread+0x115/0x130
[   65.505371]  ? kthread_park+0x90/0x90
[   65.505381]  ret_from_fork+0x1f/0x30
[   65.505401] task:nfsd            state:S stack:    0 pid: 2044 ppid:   =
  2 flags:0x00004000
[   65.505413] Call Trace:
[   65.505417]  __schedule+0x28b/0x870
[   65.505428]  schedule+0x3c/0xa0
[   65.505437]  schedule_timeout+0x1d2/0x260
[   65.505449]  ? del_timer_sync+0x40/0x40
[   65.505459]  svc_recv+0xc3/0x8a0 [sunrpc]
[   65.505572]  ? nfsd_shutdown_threads+0x80/0x80 [nfsd]
[   65.505636]  nfsd+0xd6/0x150 [nfsd]
[   65.505691]  kthread+0x115/0x130
[   65.505701]  ? kthread_park+0x90/0x90
[   65.505710]  ret_from_fork+0x1f/0x30
[   65.505722] task:nfsd            state:S stack:    0 pid: 2045 ppid:   =
  2 flags:0x00004000
[   65.505732] Call Trace:
[   65.505737]  __schedule+0x28b/0x870
[   65.505748]  schedule+0x3c/0xa0
[   65.505757]  schedule_timeout+0x1d2/0x260
[   65.505769]  ? del_timer_sync+0x40/0x40
[   65.505779]  svc_recv+0xc3/0x8a0 [sunrpc]
[   65.505889]  ? nfsd_shutdown_threads+0x80/0x80 [nfsd]
[   65.505945]  nfsd+0xd6/0x150 [nfsd]
[   65.505998]  kthread+0x115/0x130
[   65.506008]  ? kthread_park+0x90/0x90
[   65.506017]  ret_from_fork+0x1f/0x30
[   65.506029] task:nfsd            state:S stack:    0 pid: 2046 ppid:   =
  2 flags:0x00004000
[   65.506039] Call Trace:
[   65.506043]  __schedule+0x28b/0x870
[   65.506054]  schedule+0x3c/0xa0
[   65.506063]  schedule_timeout+0x1d2/0x260
[   65.506081]  ? del_timer_sync+0x40/0x40
[   65.506094]  svc_recv+0xc3/0x8a0 [sunrpc]
[   65.506202]  ? nfsd_shutdown_threads+0x80/0x80 [nfsd]
[   65.506260]  nfsd+0xd6/0x150 [nfsd]
[   65.506314]  kthread+0x115/0x130
[   65.506327]  ? kthread_park+0x90/0x90
[   65.506339]  ret_from_fork+0x1f/0x30
[   65.506355] task:nfsd            state:S stack:    0 pid: 2051 ppid:   =
  2 flags:0x00004000
[   65.506367] Call Trace:
[   65.506374]  __schedule+0x28b/0x870
[   65.506387]  schedule+0x3c/0xa0
[   65.506399]  schedule_timeout+0x1d2/0x260
[   65.506414]  ? del_timer_sync+0x40/0x40
[   65.506426]  svc_recv+0xc3/0x8a0 [sunrpc]
[   65.506530]  ? nfsd_shutdown_threads+0x80/0x80 [nfsd]
[   65.506608]  nfsd+0xd6/0x150 [nfsd]
[   65.506662]  kthread+0x115/0x130
[   65.506675]  ? kthread_park+0x90/0x90
[   65.506687]  ret_from_fork+0x1f/0x30

[   65.506780] Restarting kernel threads ... done.
[   65.506968] OOM killer enabled.
[   65.506973] Restarting tasks ... done.
[   65.508047] PM: suspend exit
[   65.508081] PM: suspend entry (s2idle)
[   65.516062] Filesystems sync: 0.007 seconds
[   65.516186] Freezing user space processes ... (elapsed 0.007 seconds) d=
one.
[   65.523663] OOM killer disabled.
[   65.523664] Freezing remaining freezable tasks ...
[   85.525885] Freezing of tasks failed after 20.004 seconds (9 tasks refu=
sing to freeze, wq_busy=3D0):
[   85.525937] task:lockd           state:S stack:    0 pid: 1809 ppid:   =
  2 flags:0x00004000
[   85.525955] Call Trace:
[   85.525966]  __schedule+0x28b/0x870
[   85.525989]  schedule+0x3c/0xa0
[   85.526001]  schedule_timeout+0x1d2/0x260
[   85.526017]  ? del_timer_sync+0x40/0x40
[   85.526033]  svc_recv+0xc3/0x8a0 [sunrpc]
[   85.526167]  ? grace_ender+0x10/0x10 [lockd]
[   85.526190]  lockd+0x8b/0x190 [lockd]
[   85.526210]  ? __kthread_parkme+0x4c/0x70
[   85.526225]  kthread+0x115/0x130
[   85.526237]  ? kthread_park+0x90/0x90
[   85.526250]  ret_from_fork+0x1f/0x30
[   85.526271] task:nfsd            state:S stack:    0 pid: 2044 ppid:   =
  2 flags:0x00004000
[   85.526284] Call Trace:
[   85.526291]  __schedule+0x28b/0x870
[   85.526305]  schedule+0x3c/0xa0
[   85.526317]  schedule_timeout+0x1d2/0x260
[   85.526332]  ? del_timer_sync+0x40/0x40
[   85.526344]  svc_recv+0xc3/0x8a0 [sunrpc]
[   85.526451]  ? nfsd_shutdown_threads+0x80/0x80 [nfsd]
[   85.526511]  nfsd+0xd6/0x150 [nfsd]
[   85.526563]  kthread+0x115/0x130
[   85.526575]  ? kthread_park+0x90/0x90
[   85.526588]  ret_from_fork+0x1f/0x30
[   85.526602] task:nfsd            state:S stack:    0 pid: 2045 ppid:   =
  2 flags:0x00004000
[   85.526615] Call Trace:
[   85.526621]  __schedule+0x28b/0x870
[   85.526634]  schedule+0x3c/0xa0
[   85.526646]  schedule_timeout+0x1d2/0x260
[   85.526661]  ? del_timer_sync+0x40/0x40
[   85.526673]  svc_recv+0xc3/0x8a0 [sunrpc]
[   85.526776]  ? nfsd_shutdown_threads+0x80/0x80 [nfsd]
[   85.526830]  nfsd+0xd6/0x150 [nfsd]
[   85.526879]  kthread+0x115/0x130
[   85.526892]  ? kthread_park+0x90/0x90
[   85.526904]  ret_from_fork+0x1f/0x30
[   85.526918] task:nfsd            state:S stack:    0 pid: 2046 ppid:   =
  2 flags:0x00004000
[   85.526931] Call Trace:
[   85.526937]  __schedule+0x28b/0x870
[   85.526951]  schedule+0x3c/0xa0
[   85.526962]  schedule_timeout+0x1d2/0x260
[   85.526977]  ? del_timer_sync+0x40/0x40
[   85.526989]  svc_recv+0xc3/0x8a0 [sunrpc]
[   85.527089]  ? nfsd_shutdown_threads+0x80/0x80 [nfsd]
[   85.527142]  nfsd+0xd6/0x150 [nfsd]
[   85.527192]  kthread+0x115/0x130
[   85.527204]  ? kthread_park+0x90/0x90
[   85.527217]  ret_from_fork+0x1f/0x30
[   85.527231] task:nfsd            state:S stack:    0 pid: 2047 ppid:   =
  2 flags:0x00004000
[   85.527242] Call Trace:
[   85.527249]  __schedule+0x28b/0x870
[   85.527262]  schedule+0x3c/0xa0
[   85.527273]  schedule_timeout+0x1d2/0x260
[   85.527288]  ? del_timer_sync+0x40/0x40
[   85.527300]  svc_recv+0xc3/0x8a0 [sunrpc]
[   85.527397]  ? nfsd_shutdown_threads+0x80/0x80 [nfsd]
[   85.527449]  nfsd+0xd6/0x150 [nfsd]
[   85.527497]  kthread+0x115/0x130
[   85.527510]  ? kthread_park+0x90/0x90
[   85.527522]  ret_from_fork+0x1f/0x30
[   85.527536] task:nfsd            state:S stack:    0 pid: 2048 ppid:   =
  2 flags:0x00004000
[   85.527548] Call Trace:
[   85.527554]  __schedule+0x28b/0x870
[   85.527568]  schedule+0x3c/0xa0
[   85.527579]  schedule_timeout+0x1d2/0x260
[   85.527594]  ? del_timer_sync+0x40/0x40
[   85.527606]  svc_recv+0xc3/0x8a0 [sunrpc]
[   85.527698]  ? nfsd_shutdown_threads+0x80/0x80 [nfsd]
[   85.527749]  nfsd+0xd6/0x150 [nfsd]
[   85.527798]  kthread+0x115/0x130
[   85.527810]  ? kthread_park+0x90/0x90
[   85.527822]  ret_from_fork+0x1f/0x30
[   85.527837] task:nfsd            state:S stack:    0 pid: 2049 ppid:   =
  2 flags:0x00004000
[   85.527848] Call Trace:
[   85.527854]  __schedule+0x28b/0x870
[   85.527868]  schedule+0x3c/0xa0
[   85.527879]  schedule_timeout+0x1d2/0x260
[   85.527894]  ? del_timer_sync+0x40/0x40
[   85.527906]  svc_recv+0xc3/0x8a0 [sunrpc]
[   85.527999]  ? nfsd_shutdown_threads+0x80/0x80 [nfsd]
[   85.528050]  nfsd+0xd6/0x150 [nfsd]
[   85.528098]  kthread+0x115/0x130
[   85.528110]  ? kthread_park+0x90/0x90
[   85.528122]  ret_from_fork+0x1f/0x30
[   85.528137] task:nfsd            state:S stack:    0 pid: 2050 ppid:   =
  2 flags:0x00004000
[   85.528148] Call Trace:
[   85.528154]  __schedule+0x28b/0x870
[   85.528167]  schedule+0x3c/0xa0
[   85.528178]  schedule_timeout+0x1d2/0x260
[   85.528193]  ? del_timer_sync+0x40/0x40
[   85.528205]  svc_recv+0xc3/0x8a0 [sunrpc]
[   85.528298]  ? nfsd_shutdown_threads+0x80/0x80 [nfsd]
[   85.528363]  nfsd+0xd6/0x150 [nfsd]
[   85.528412]  kthread+0x115/0x130
[   85.528424]  ? kthread_park+0x90/0x90
[   85.528436]  ret_from_fork+0x1f/0x30
[   85.528450] task:nfsd            state:S stack:    0 pid: 2051 ppid:   =
  2 flags:0x00004000
[   85.528462] Call Trace:
[   85.528469]  __schedule+0x28b/0x870
[   85.528482]  schedule+0x3c/0xa0
[   85.528494]  schedule_timeout+0x1d2/0x260
[   85.528508]  ? del_timer_sync+0x40/0x40
[   85.528521]  svc_recv+0xc3/0x8a0 [sunrpc]
[   85.528616]  ? nfsd_shutdown_threads+0x80/0x80 [nfsd]
[   85.528668]  nfsd+0xd6/0x150 [nfsd]
[   85.528715]  kthread+0x115/0x130
[   85.528728]  ? kthread_park+0x90/0x90
[   85.528740]  ret_from_fork+0x1f/0x30

[   85.528831] Restarting kernel threads ... done.
[   85.529020] OOM killer enabled.
[   85.529024] Restarting tasks ... done.
[   85.529753] PM: suspend exit

