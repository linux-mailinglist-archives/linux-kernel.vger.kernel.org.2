Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0439933321E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 00:57:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232107AbhCIX5U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 18:57:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230122AbhCIX5A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 18:57:00 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA4BFC06174A
        for <linux-kernel@vger.kernel.org>; Tue,  9 Mar 2021 15:56:48 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id d3so30245050lfg.10
        for <linux-kernel@vger.kernel.org>; Tue, 09 Mar 2021 15:56:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=a9Lmdm6VB4GFA6TEnlIWZDBWh5/5cVccVMbC8OYVKBM=;
        b=fHnu5MEy54ZOUEVuSGz20TyvF58zuTtzhQ2L+nR5RKxGqDqAViEyWmkkyimUZjNt/b
         7CR28Pk/9Tips2JKIYDn+/Y4Npm35aZPK2CyGUd6pI/zpb880lBnYL/VFRD4Ay5tOG6t
         ya3+CUbtAHrbu3LgquDeZpHwxt4mvwcn2HbFI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=a9Lmdm6VB4GFA6TEnlIWZDBWh5/5cVccVMbC8OYVKBM=;
        b=WLRJJtgsP4Oj4aJoGt/Xb6eE08XddQGE3uZ9LNg+8fqgn8t5E2u2oJCm+WrdelhPCj
         nXjOLs/uw5HtiJ9m42Lb3bsVXEm1IDTMGwT5N0azzl9RI5c8QP2aa+J3UgABGxQGmuDg
         PuZKcED4uj0tv2yzwlAP3kqnCrTcQTbnMBKNpKf4b9Gzx5r+hdCGor9pcLWCwDgroYxJ
         Dzw9f+drzwGfyvv7VTq05FIYPmESv/6FSKVL6MCa3vKSGGd6OZN1ub0UW4p9BWa1/VfQ
         TBa0VWUsty+J3ChJLY9khuMXjOS6h+j9A/FtosZz1uuHc446GhtprwgVR5V6lz1Xwf09
         wUrA==
X-Gm-Message-State: AOAM530xyQ32e9nuNEIRFQaRiG73rSqNKVQ5qd4g+hzCXeT7qZdgDBda
        nW4x928wmteM1B3q1dGUFcJIcHrjYqHoWw==
X-Google-Smtp-Source: ABdhPJwxJEm12j1Ob49SPFmC/uT/vVnmwkh1Zk63k/egHy1p3XucN1I6enJ74tOpcoCZ3HIPhr6oGQ==
X-Received: by 2002:a19:791:: with SMTP id 139mr323458lfh.436.1615334207015;
        Tue, 09 Mar 2021 15:56:47 -0800 (PST)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com. [209.85.208.181])
        by smtp.gmail.com with ESMTPSA id b3sm2259619lfb.191.2021.03.09.15.56.45
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Mar 2021 15:56:46 -0800 (PST)
Received: by mail-lj1-f181.google.com with SMTP id m11so23098405lji.10
        for <linux-kernel@vger.kernel.org>; Tue, 09 Mar 2021 15:56:45 -0800 (PST)
X-Received: by 2002:a2e:a306:: with SMTP id l6mr100413lje.251.1615334205328;
 Tue, 09 Mar 2021 15:56:45 -0800 (PST)
MIME-Version: 1.0
References: <20210301080404.GF12822@xsang-OptiPlex-9020>
In-Reply-To: <20210301080404.GF12822@xsang-OptiPlex-9020>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 9 Mar 2021 15:56:29 -0800
X-Gmail-Original-Message-ID: <CAHk-=wh+RFzJqa51aO2zgGFhgV7=WjTs82B2wFfCMEHPs4B49g@mail.gmail.com>
Message-ID: <CAHk-=wh+RFzJqa51aO2zgGFhgV7=WjTs82B2wFfCMEHPs4B49g@mail.gmail.com>
Subject: Re: [mm, slub] 8ff60eb052: stress-ng.rawpkt.ops_per_sec -47.9% regression
To:     kernel test robot <oliver.sang@intel.com>
Cc:     Jann Horn <jannh@google.com>, David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        kernel test robot <lkp@intel.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        Feng Tang <feng.tang@intel.com>, zhengjun.xing@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jann,
 it looks like that change of yours made a rather big negative impact
on this load.

On Sun, Feb 28, 2021 at 11:49 PM kernel test robot
<oliver.sang@intel.com> wrote:
>
> FYI, we noticed a -47.9% regression of stress-ng.rawpkt.ops_per_sec due t=
o commit:

Looking at the profile, nothing really obvious stands out, although
some of the numbers imply more polling, and less waiting, ie:

Lots less context switching::

>      12810 =C4=85 17%     -63.6%       4658 =C4=85  8%  sched_debug.cpu.n=
r_switches.avg

Less time spent sending packets:

>      68.52            -5.0       63.55        perf-profile.calltrace.cycl=
es-pp.__dev_queue_xmit.packet_snd.sock_sendmsg.__sys_sendto.__x64_sys_sendt=
o
>      69.00            -4.9       64.14        perf-profile.calltrace.cycl=
es-pp.__sys_sendto.__x64_sys_sendto.do_syscall_64.entry_SYSCALL_64_after_hw=
frame

and quite a lot more time spent in what looks like the receive path,
which allocates the packets:

>       5.47 =C4=85 12%      +4.5        9.94 =C4=85  2%  perf-profile.call=
trace.cycles-pp.kmem_cache_alloc.skb_clone.packet_rcv.__netif_receive_skb_c=
ore.__netif_receive_skb_one_core
>       5.46 =C4=85 12%      +4.5        9.92 =C4=85  2%  perf-profile.call=
trace.cycles-pp.skb_clone.packet_rcv.dev_queue_xmit_nit.dev_hard_start_xmit=
.__dev_queue_xmit
>       5.37 =C4=85 12%      +4.5        9.88 =C4=85  2%  perf-profile.call=
trace.cycles-pp.kmem_cache_alloc.skb_clone.packet_rcv.dev_queue_xmit_nit.de=
v_hard_start_xmit
>       5.18 =C4=85 13%      +4.5        9.71 =C4=85  2%  perf-profile.call=
trace.cycles-pp.__slab_alloc.kmem_cache_alloc.skb_clone.packet_rcv.__netif_=
receive_skb_core
>       5.08 =C4=85 13%      +4.6        9.66 =C4=85  2%  perf-profile.call=
trace.cycles-pp.__slab_alloc.kmem_cache_alloc.skb_clone.packet_rcv.dev_queu=
e_xmit_nit
>      29.57 =C4=85  2%      +5.5       35.12        perf-profile.calltrace=
.cycles-pp.__x64_sys_recvfrom.do_syscall_64.entry_SYSCALL_64_after_hwframe
>      29.48 =C4=85  2%      +5.6       35.08        perf-profile.calltrace=
.cycles-pp.__sys_recvfrom.__x64_sys_recvfrom.do_syscall_64.entry_SYSCALL_64=
_after_hwframe
>      26.62 =C4=85  2%      +7.1       33.67        perf-profile.calltrace=
.cycles-pp.packet_recvmsg.__sys_recvfrom.__x64_sys_recvfrom.do_syscall_64.e=
ntry_SYSCALL_64_after_hwframe
>       8.83 =C4=85 15%      +8.8       17.66 =C4=85  2%  perf-profile.call=
trace.cycles-pp._raw_spin_lock.get_partial_node.___slab_alloc.__slab_alloc.=
kmem_cache_alloc
>       8.58 =C4=85 15%      +8.9       17.48 =C4=85  2%  perf-profile.call=
trace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.get_partial=
_node.___slab_alloc.__slab_alloc
>       9.46 =C4=85 14%      +9.0       18.44 =C4=85  2%  perf-profile.call=
trace.cycles-pp.get_partial_node.___slab_alloc.__slab_alloc.kmem_cache_allo=
c.skb_clone
>      10.19 =C4=85 13%      +9.1       19.28 =C4=85  2%  perf-profile.call=
trace.cycles-pp.___slab_alloc.__slab_alloc.kmem_cache_alloc.skb_clone.packe=
t_rcv
>      14.31 =C4=85  6%     +14.0       28.27 =C4=85  3%  perf-profile.call=
trace.cycles-pp.skb_free_datagram.packet_recvmsg.__sys_recvfrom.__x64_sys_r=
ecvfrom.do_syscall_64
>       9.50 =C4=85 11%     +16.7       26.21 =C4=85  4%  perf-profile.call=
trace.cycles-pp.kmem_cache_free.skb_free_datagram.packet_recvmsg.__sys_recv=
from.__x64_sys_recvfrom
>       6.09 =C4=85 18%     +17.8       23.88 =C4=85  5%  perf-profile.call=
trace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.unfreeze_pa=
rtials.put_cpu_partial.kmem_cache_free
>       6.37 =C4=85 18%     +17.9       24.23 =C4=85  5%  perf-profile.call=
trace.cycles-pp._raw_spin_lock.unfreeze_partials.put_cpu_partial.kmem_cache=
_free.skb_free_datagram
>       6.92 =C4=85 17%     +18.0       24.94 =C4=85  5%  perf-profile.call=
trace.cycles-pp.unfreeze_partials.put_cpu_partial.kmem_cache_free.skb_free_=
datagram.packet_recvmsg
>       7.03 =C4=85 16%     +18.0       25.06 =C4=85  5%  perf-profile.call=
trace.cycles-pp.put_cpu_partial.kmem_cache_free.skb_free_datagram.packet_re=
cvmsg.__sys_recvfrom

.. and I think the reason is here:

>      26.26 =C4=85  6%     +23.8       50.07 =C4=85  3%  perf-profile.chil=
dren.cycles-pp._raw_spin_lock

Look at that +23.8 for _raw_spin_lock, and it really shows up here too:

>      25.86 =C4=85  6%     +23.4       49.22 =C4=85  3%  perf-profile.self=
.cycles-pp.native_queued_spin_lock_slowpath

I think what is going on is that your change caused the "contention on
the freelist" case to now loop - possibly several times, and
expensively with atomic operations - while you are holding the
'n->list_lock' spinlock in get_partial_node().

End result: contention on the freelist now becomes *huge* contention
on that list_lock instead.

Before, it would release the list lock, and generally then (maybe) try
again. Or more likely just get another page and avoid the contention.

So when you wrote:

    However, the current code accidentally stops looking at the partial lis=
t
    completely in that case.  Especially on kernels without CONFIG_NUMA set=
,
    this means that get_partial() fails and new_slab_objects() falls back t=
o
    new_slab(), allocating new pages.  This could lead to an unnecessary
    increase in memory fragmentation.

it really looks like this might well have been very intentional
indeed. Or at least very beneficial for _some_ loads.

Comments?

                    Linus
