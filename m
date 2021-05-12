Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F8BD37BCA1
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 14:36:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232755AbhELMhx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 08:37:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231533AbhELMhv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 08:37:51 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD67AC061574
        for <linux-kernel@vger.kernel.org>; Wed, 12 May 2021 05:36:43 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id x19so33512898lfa.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 May 2021 05:36:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=2Bfymur/FN+xNILc6FXmZHfrU/0ko9T6nAYD/EdwQHw=;
        b=mM9paLpLKhOS0VHfPLsPRqZeF8ow3YDDedzNCVM4o2jx30+t+puGyATwVAo3fQ7/Wo
         VQoL+ext9Qsa9TwRTS+ZUuetRurB7U6Pz6zHGmZWFJAmJMr3+S747HiDrR4q7KO/T9GV
         gMtkLEqSY1oGN6imN1MxEc2dAthtcxeLt2FW0vCGX1sKIl0kNKKbKHm+OsKL0elPgrAQ
         6WdFAed0b5M3XrllKo98oBI7WQ87xS6nvgP5qLqwQa8IN9CHuOGXo7LHMdMslQnBp/MG
         HLpWTQFC3LP6G7uyhyXdo2wUu6G4IEq0HSfcaGDtn60D2MCm/KiVYkne2DGbI4Ed3xl9
         EGaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=2Bfymur/FN+xNILc6FXmZHfrU/0ko9T6nAYD/EdwQHw=;
        b=hl38ccUY9QP1FWqXX6nOlAGovlK80yYbTUA811lgk4DzlGT20/qLJZfdwuvhLlO1hz
         U+4NjApa0AASche/6uwB200OZruf9wC+jSUDbQOQ3lsDoh0t/Tm0LqqBLsnMFu6Fzs3C
         Fj5TP0pMOAO5PBycz4mESVvGuVidnTbl8K7NlrCD3GqcGs7e9pe2drm+3Xge3I4J7S4s
         aoN3vlq8Ui1fOjUhszHpCCpk5B/vfJnLoqlGbfRpbw2bG9C3pb43bh+8ppbvk+hqUS2S
         c1c4rrhHVswHiG13PmA/4WpQ+2s0yCmUgStGXZfk+bjlQg/C2JD52JOOjfG1dgR7q2eJ
         9OFA==
X-Gm-Message-State: AOAM533wH+CCbWYXp94AML8gQxEGUuoUg+sNzOXTKyY6/kGuYLSsYFSp
        S9DC19jaAKuOtGF3xpqF8nBeUlL0paBJUkBlGRDguQ==
X-Google-Smtp-Source: ABdhPJyVwxOY2BBD0LWWFBR4VflOMUdVrq6m6P1nIDcTAyhLZ/bBkGKTc4XsQCnwLy/6Xe/7Qz97Wo+Nx4OGL8C93a8=
X-Received: by 2002:a05:6512:1182:: with SMTP id g2mr24913140lfr.117.1620823001956;
 Wed, 12 May 2021 05:36:41 -0700 (PDT)
MIME-Version: 1.0
References: <921e53f3-4b13-aab8-4a9e-e83ff15371e4@nec.com>
In-Reply-To: <921e53f3-4b13-aab8-4a9e-e83ff15371e4@nec.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Wed, 12 May 2021 05:36:29 -0700
Message-ID: <CALvZod6J8Nk2Vv8eMo020F-jfKHii3Lu1KxOOaut4U88AH3gfw@mail.gmail.com>
Subject: Re: [REGRESSION v5.13-rc1] NULL dereference in do_shrink_slab()
To:     =?UTF-8?B?Tk9NVVJBIEpVTklDSEko6YeO5p2RIOa3s+S4gCk=?= 
        <junichi.nomura@nec.com>, Tejun Heo <tj@kernel.org>
Cc:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "shy828301@gmail.com" <shy828301@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "vbabka@suse.cz" <vbabka@suse.cz>,
        "ktkhai@virtuozzo.com" <ktkhai@virtuozzo.com>,
        "guro@fb.com" <guro@fb.com>,
        "david@fromorbit.com" <david@fromorbit.com>,
        "hannes@cmpxchg.org" <hannes@cmpxchg.org>,
        "mhocko@suse.com" <mhocko@suse.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Tejun Heo

On Wed, May 12, 2021 at 3:48 AM NOMURA JUNICHI(=E9=87=8E=E6=9D=91=E3=80=80=
=E6=B7=B3=E4=B8=80)
<junichi.nomura@nec.com> wrote:
>
> v5.13-rc1 sometimes causes NULL pointer dereference during kdump, where
> memcg is disabled with "cgroup_disable=3Dmemory" boot option.
> I haven't seen this problem with v5.12, so it looks like regression.
>
> [   73.199590] BUG: kernel NULL pointer dereference, address: 00000000000=
00000
> [   73.206593] #PF: supervisor write access in kernel mode
> [   73.211845] #PF: error_code(0x0002) - not-present page
> [   73.217010] PGD 0 P4D 0
> [   73.219556] Oops: 0002 [#1] SMP NOPTI
> [   73.223236] CPU: 0 PID: 95 Comm: kswapd0 Tainted: G          I       5=
.13.0-rc1 #1
> [   73.239418] RIP: 0010:do_shrink_slab+0x85/0x2d0
> [   73.243977] Code: 49 63 44 24 04 be 00 00 00 00 49 8b 4c 24 18 f6 c2 0=
2 48 0f 44 c6 48 85 c9 74 09 83 e2 04 0f 85 19 02 00 00 49 8b 4f 38 31 d2 <=
48> 87 14 c1 48 89 55 b8 41 8b 77 18 4c 89 f0 85 f6 0f 84 82 01 00
> [   73.262856] RSP: 0018:ffffc900001abc18 EFLAGS: 00010246
> [   73.268108] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 000000000=
0000000
> [   73.275281] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000000000=
0000064
> [   73.282454] RBP: ffffc900001abc70 R08: 28f5c28f5c28f5c3 R09: 000000000=
0000000
> [   73.289628] R10: 0000000000000000 R11: 0000000000000004 R12: ffffc9000=
01abca0
> [   73.296800] R13: 0000000000000400 R14: 0000000000000002 R15: ffff88805=
344bc10
> [   73.303972] FS:  0000000000000000(0000) GS:ffff888072c00000(0000) knlG=
S:0000000000000000
> [   73.312108] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   73.317883] CR2: 0000000000000000 CR3: 000000005cf68004 CR4: 000000000=
07706b0
> [   73.325055] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 000000000=
0000000
> [   73.332227] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 000000000=
0000400
> [   73.339400] PKRU: 55555554
> [   73.342117] Call Trace:
> [   73.344576]  shrink_slab+0xa9/0x2b0
> [   73.348083]  ? __update_load_avg_se+0x298/0x320
> [   73.352640]  shrink_node+0x248/0x6f0
> [   73.356234]  balance_pgdat+0x303/0x5f0
> [   73.360002]  kswapd+0x20b/0x390
> [   73.363157]  ? finish_wait+0x80/0x80
> [   73.366752]  ? balance_pgdat+0x5f0/0x5f0
> [   73.370693]  kthread+0x124/0x140
> [   73.373937]  ? kthread_park+0x90/0x90
> [   73.377617]  ret_from_fork+0x1f/0x30
> [   73.381215] Modules linked in: xfs libcrc32c sd_mod t10_pi sr_mod cdro=
m sg crc32c_intel ahci libahci libata smartpqi scsi_transport_sas overlay s=
quashfs loop
> [   73.395386] CR2: 0000000000000000
> [   73.398716] ---[ end trace 9752d71309d33c00 ]---
>
> The code around do_shrink_slab+0x85 is:
> 0xffffffff9d094925 <do_shrink_slab+0x65>:       mov    0x18(%r12),%rcx
> 0xffffffff9d09492a <do_shrink_slab+0x6a>:       test   $0x2,%dl
> 0xffffffff9d09492d <do_shrink_slab+0x6d>:       cmove  %rsi,%rax
> 0xffffffff9d094931 <do_shrink_slab+0x71>:       test   %rcx,%rcx
> 0xffffffff9d094934 <do_shrink_slab+0x74>:       je     0xffffffff9d09493f=
 <do_shrink_slab+0x7f>
> 0xffffffff9d094936 <do_shrink_slab+0x76>:       and    $0x4,%edx
> 0xffffffff9d094939 <do_shrink_slab+0x79>:       jne    0xffffffff9d094b58=
 <do_shrink_slab+0x298>
> 0xffffffff9d09493f <do_shrink_slab+0x7f>:       mov    0x38(%r15),%rcx
> 0xffffffff9d094943 <do_shrink_slab+0x83>:       xor    %edx,%edx
> 0xffffffff9d094945 <do_shrink_slab+0x85>:       xchg   %rdx,(%rcx,%rax,8)
>
> The NULL dereference occurred at here in in-lined xchg_nr_deferred():
>
>          return atomic_long_xchg(&shrinker->nr_deferred[nid], 0);
>
> that means "shrinker->nr_deferred" was NULL.
>
> Though I haven't fully bisected between v5.12 and v5.13-rc1, I can reprod=
uce
> the problem with this commit:
>
>    476b30a0949a mm: vmscan: don't need allocate shrinker->nr_deferred for=
 memcg aware shrinkers
>
> but not with this previous commit:
>
>    867508304685 mm: vmscan: use per memcg nr_deferred of shrinker
>
> With the commit 476b30a0949a, if a memcg-aware shrinker is registered bef=
ore
> cgroup_init(), shrinker->nr_deferred is NULL.  However xchg_nr_deferred()
> tries to use it as memcg is turned off via "cgroup_disable=3Dmemory".
>
> Any thoughts?

Is there a way to find the call chain of "memcg-aware shrinker is
registered before cgroup_init()"?

Irrespective I think we can revert a3e72739b7a7e ("cgroup: fix too
early usage of static_branch_disable()") as 6041186a3258 ("init:
initialize jump labels before command line option parsing") has moved
the initialization of jump labels before command line parsing.
