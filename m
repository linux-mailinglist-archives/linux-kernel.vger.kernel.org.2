Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B15B944D3C5
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 10:07:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232728AbhKKJKZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Nov 2021 04:10:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232535AbhKKJKY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Nov 2021 04:10:24 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A5A9C061766
        for <linux-kernel@vger.kernel.org>; Thu, 11 Nov 2021 01:07:35 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id g14so21550957edz.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Nov 2021 01:07:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=pUd9Fy+Oepcznba5eWRcSgNUawHebpfgBqhaH1wrTTw=;
        b=XbUgf6gVFW/k0tiJAR07BFP4mfv9BqaeWQHq4sSxPWrhWyvItWYHyds/zraWTXGxAr
         AktAR3v8mUp0rUPqkaCJf1cKPKU/uu1XQe4m5PM7HGjrhliJM0HzYYLHjXbUfsQBTWQ+
         RfiCEFXuSrJZNtH6TtrKcjyq2xs8kV9cnPjnsr98NwIi+X5lTJVrxxnJ8uMr+/nXGWl7
         LtvxxHXSOiPx6+jjBu/EYhu0rojSJMXEBjshVJwt8tjzW1WCdzb/ZFlKj6/NMwhOY+MA
         X2TDvctWNkUhiIgpZ01sHKqgnqgJdHwDnJ797E8GogK3RXBzPzHeo6Hxt53yKpgVpSRw
         lqPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=pUd9Fy+Oepcznba5eWRcSgNUawHebpfgBqhaH1wrTTw=;
        b=G0ZQ+4W0EIL9P4n2M88y3FV4WZWqQtAWAcVP36inRv8Ku6DyBl6cVl2l3TPU38MGC8
         2hOPMzKrdsr2UAEEnQeTH5OplGwzKlerGjZSygSiiFSsnkn4kXfY6cAnB6uOlhPimDS4
         zbhAW8w8bxuLDsDUtmjIl4J4/CvznV+SLHnd3ZQ3CFW2rjc81NHC3Ls1w2jgeImil5I8
         u+dRQJ4PZHQomVUJ8flP9oWCCNq5mOC0NDKU0Xcs95Mk+Yvw5oT2X9kbTUzndgTL96Dy
         dlICpCH6sNvgA4w1FsLU3dQa/bDIzWJKOXYpkfMIm0FTHhxuYNI2TkKIsIYOoImAyUtf
         e1xg==
X-Gm-Message-State: AOAM533g5Tnfk7slk3ruAMGIUfBu7T4uNWf1wMxB78C8nodIBcIkzsYW
        tuzBozcw7fWBqzy5LQ36IoyvihhAElro5cSxo8Q=
X-Google-Smtp-Source: ABdhPJypBthjQ3S6vKx8UeNaAx1/GkYKGyhDXCLh5+ygYlejP6cdZOJ7UPN8nhRlNBAtlQb34zJJVIC4V7vvDYqgBX0=
X-Received: by 2002:a05:6402:510c:: with SMTP id m12mr7826886edd.314.1636621653741;
 Thu, 11 Nov 2021 01:07:33 -0800 (PST)
MIME-Version: 1.0
References: <20211110095856.469360-1-bobo.shaobowang@huawei.com>
 <CAGsJ_4wzPWnNFe4ptphVxXSz4-50-qub+H_q0woupxOM1LtqsA@mail.gmail.com> <943fef84-3920-42bc-b83f-4feaa3ab79f3@huawei.com>
In-Reply-To: <943fef84-3920-42bc-b83f-4feaa3ab79f3@huawei.com>
From:   Barry Song <21cnbao@gmail.com>
Date:   Thu, 11 Nov 2021 22:07:22 +1300
Message-ID: <CAGsJ_4xFhcUaVYzVKc2EXs9FsnmPoLmmKqxiDpExwUeTyOyDMg@mail.gmail.com>
Subject: Re: [PATCH] arch_topology: Fix missing clear cluster_cpumask in remove_cpu_topology()
To:     "Wangshaobo (bobo)" <bobo.shaobowang@huawei.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Peter Zijlstra <peterz@infradead.org>, cj.chengjian@huawei.com,
        huawei.libin@huawei.com, weiyongjun1@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 11, 2021 at 8:25 PM Wangshaobo (bobo)
<bobo.shaobowang@huawei.com> wrote:
>
>
> =E5=9C=A8 2021/11/11 14:25, Barry Song =E5=86=99=E9=81=93:
>
> On Wed, Nov 10, 2021 at 10:53 PM Wang ShaoBo <bobo.shaobowang@huawei.com>=
 wrote:
>
> When testing cpu online and offline, warning happened like this:
>
> [  146.746743] WARNING: CPU: 92 PID: 974 at kernel/sched/topology.c:2215 =
build_sched_domains+0x81c/0x11b0
> [  146.749988] CPU: 92 PID: 974 Comm: kworker/92:2 Not tainted 5.15.0 #9
> [  146.750402] Hardware name: Huawei TaiShan 2280 V2/BC82AMDDA, BIOS 1.79=
 08/21/2021
> [  146.751213] Workqueue: events cpuset_hotplug_workfn
> [  146.751629] pstate: 00400009 (nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYP=
E=3D--)
> [  146.752048] pc : build_sched_domains+0x81c/0x11b0
> [  146.752461] lr : build_sched_domains+0x414/0x11b0
> [  146.752860] sp : ffff800040a83a80
> [  146.753247] x29: ffff800040a83a80 x28: ffff20801f13a980 x27: ffff20800=
448ae00
> [  146.753644] x26: ffff800012a858e8 x25: ffff800012ea48c0 x24: 000000000=
0000000
> [  146.754039] x23: ffff800010ab7d60 x22: ffff800012f03758 x21: 000000000=
000005f
> [  146.754427] x20: 000000000000005c x19: ffff004080012840 x18: fffffffff=
fffffff
> [  146.754814] x17: 3661613030303230 x16: 30303078303a3239 x15: ffff80001=
1f92b48
> [  146.755197] x14: ffff20be3f95cef6 x13: 2e6e69616d6f642d x12: 646568637=
3204c4c
> [  146.755578] x11: ffff20bf7fc83a00 x10: 0000000000000040 x9 : 000000000=
0000000
> [  146.755957] x8 : 0000000000000002 x7 : ffffffffe0000000 x6 : 000000000=
0000002
> [  146.756334] x5 : 0000000090000000 x4 : 00000000f0000000 x3 : 000000000=
0000001
> [  146.756705] x2 : 0000000000000080 x1 : ffff800012f03860 x0 : 000000000=
0000001
> [  146.757070] Call trace:
> [  146.757421]  build_sched_domains+0x81c/0x11b0
> [  146.757771]  partition_sched_domains_locked+0x57c/0x978
> [  146.758118]  rebuild_sched_domains_locked+0x44c/0x7f0
> [  146.758460]  rebuild_sched_domains+0x2c/0x48
> [  146.758791]  cpuset_hotplug_workfn+0x3fc/0x888
> [  146.759114]  process_one_work+0x1f4/0x480
> [  146.759429]  worker_thread+0x48/0x460
> [  146.759734]  kthread+0x158/0x168
> [  146.760030]  ret_from_fork+0x10/0x20
> [  146.760318] ---[ end trace 82c44aad6900e81a ]---
>
> For some architectures like risc-v and arm64 which use common code
> clear_cpu_topology() in shutting down CPUx, When CONFIG_SCHED_CLUSTER
> is set, cluster_sibling in cpu_topology of each sibling adjacent
> to CPUx is missed clearing, this causes checking failed in
> topology_span_sane() and rebuilding topology failure at end when CPU onli=
ne.
>
> Different sibling's cluster_sibling in cpu_topology[] when CPU92 offline
> (CPU 92, 93, 94, 95 are in one cluster):
>
> Before revision:
> CPU                 [92]      [93]      [94]      [95]
> cluster_sibling     [92]     [92-95]   [92-95]   [92-95]
>
> After revision:
> CPU                 [92]      [93]      [94]      [95]
> cluster_sibling     [92]     [93-95]   [93-95]   [93-95]
>
> Signed-off-by: Wang ShaoBo <bobo.shaobowang@huawei.com>
>
> The patch looks correct. But how do you reproduce it?
>
> Hi Barry,
>
> you can try this test case in kunpeng 920:
>
>
echo 0 > cpu92/online
echo 0 > cpu93/online
echo 1 > cpu92/online

Yes. I was making the whole cluster offline. this warning can only be
reproduced when
we disable a part of CPUs in one cluster, then enable one of the disabled C=
PUs.

Acked-by: Barry Song <song.bao.hua@hisilicon.com>

Might need some refine to explain how to reproduce in commit log.

>
> - Wang ShaoBo

Thanks
Barry
