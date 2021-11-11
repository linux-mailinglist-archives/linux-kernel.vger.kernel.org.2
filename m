Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4D7944D3C7
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 10:08:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230129AbhKKJLc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Nov 2021 04:11:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbhKKJLb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Nov 2021 04:11:31 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 428FCC061766
        for <linux-kernel@vger.kernel.org>; Thu, 11 Nov 2021 01:08:42 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id f4so21407553edx.12
        for <linux-kernel@vger.kernel.org>; Thu, 11 Nov 2021 01:08:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=RjK0bhtZh22cyPP6M/Bhk6zgaUc73//+IyghEIw9PTg=;
        b=ktQhrHOZW2Rp/qBzu4YX6EiQ01MzL1EwkFbj6vub3OJxn1E2HLPs7ZFX48bj1K9WXA
         gxjMX50GyuqK22ticqJ7g9D4Q9gUYB53k2T+6oIlNA8AqJbUaiZjx+3w1l7uVjXbjcLq
         D/lAfWh3HnFUVcRbo+3PQlBXHKHV147pQL74sC2ZF1wqpDZBvaTuIPcY1ZYnkUt7+oLu
         JHM608JXMIMET9wmU0dCpk3bwmM9gFlTjEM+kRT5/tah0Cd/tqr+AyopOFvKKLuEXsiD
         74dPA+jbmgtNJvkBAaftr3TRO2EncF/q2Kx+YIuhluFqctdMmM10BRZbyIUD1ku9LV9W
         1guQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=RjK0bhtZh22cyPP6M/Bhk6zgaUc73//+IyghEIw9PTg=;
        b=GCtseSL8oDrCiTqSLb+pH8QeR8bKP/w1qUK9iBQGiZiMNXvx3Kve7djjOmHudXcKbK
         VCg84lBJRgNjSxCDo47EP83650XRodQv1mvsISAoPq+fzK1ZuCzuZAt7UpyGojusP1qi
         cUFQMyS5YKYSyZIDV6Wdl4j/yBxHwxozr4d1ligRCvYiLdg0TTstbJzz7RQaQ7YswlKC
         41N57pyBg7G3I4BffrnSEAjBDPCJl71KywGZiB1kX37y5qMfVbIyuY/797tQTTe0Rs4l
         8zQsW8edHJtCkhzk5HYSUiQmPRu40P+k+3LYFX/PVqFgpPbZyci86jyLDmmo3m9r51RV
         nUXQ==
X-Gm-Message-State: AOAM5307SK77MBZuHy3D18sIx5PZNFImM4/Qx+rr/BAOA1jrX1muZ8qf
        qd9FZC4ZD1y/NTQG/C/DK2yWv8qHm0kxwreRW5Y=
X-Google-Smtp-Source: ABdhPJw/ge3fHkKILQ7T/tG5B1vsP6/JkoD4AfjiHYmTM+pfauIwYiHIvInEmnGslW7T8IVkFotEbve2bxA5szfeEsQ=
X-Received: by 2002:a17:906:d92f:: with SMTP id rn15mr7390042ejb.557.1636621720838;
 Thu, 11 Nov 2021 01:08:40 -0800 (PST)
MIME-Version: 1.0
References: <20211110095856.469360-1-bobo.shaobowang@huawei.com>
 <CAGsJ_4wzPWnNFe4ptphVxXSz4-50-qub+H_q0woupxOM1LtqsA@mail.gmail.com>
 <943fef84-3920-42bc-b83f-4feaa3ab79f3@huawei.com> <CAGsJ_4xFhcUaVYzVKc2EXs9FsnmPoLmmKqxiDpExwUeTyOyDMg@mail.gmail.com>
In-Reply-To: <CAGsJ_4xFhcUaVYzVKc2EXs9FsnmPoLmmKqxiDpExwUeTyOyDMg@mail.gmail.com>
From:   Barry Song <21cnbao@gmail.com>
Date:   Thu, 11 Nov 2021 22:08:29 +1300
Message-ID: <CAGsJ_4yLV_-fwtH1=bmGxfcK9_TwUK5Typ_pE=zYQNt=YHoFVA@mail.gmail.com>
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

On Thu, Nov 11, 2021 at 10:07 PM Barry Song <21cnbao@gmail.com> wrote:
>
> On Thu, Nov 11, 2021 at 8:25 PM Wangshaobo (bobo)
> <bobo.shaobowang@huawei.com> wrote:
> >
> >
> > =E5=9C=A8 2021/11/11 14:25, Barry Song =E5=86=99=E9=81=93:
> >
> > On Wed, Nov 10, 2021 at 10:53 PM Wang ShaoBo <bobo.shaobowang@huawei.co=
m> wrote:
> >
> > When testing cpu online and offline, warning happened like this:
> >
> > [  146.746743] WARNING: CPU: 92 PID: 974 at kernel/sched/topology.c:221=
5 build_sched_domains+0x81c/0x11b0
> > [  146.749988] CPU: 92 PID: 974 Comm: kworker/92:2 Not tainted 5.15.0 #=
9
> > [  146.750402] Hardware name: Huawei TaiShan 2280 V2/BC82AMDDA, BIOS 1.=
79 08/21/2021
> > [  146.751213] Workqueue: events cpuset_hotplug_workfn
> > [  146.751629] pstate: 00400009 (nzcv daif +PAN -UAO -TCO -DIT -SSBS BT=
YPE=3D--)
> > [  146.752048] pc : build_sched_domains+0x81c/0x11b0
> > [  146.752461] lr : build_sched_domains+0x414/0x11b0
> > [  146.752860] sp : ffff800040a83a80
> > [  146.753247] x29: ffff800040a83a80 x28: ffff20801f13a980 x27: ffff208=
00448ae00
> > [  146.753644] x26: ffff800012a858e8 x25: ffff800012ea48c0 x24: 0000000=
000000000
> > [  146.754039] x23: ffff800010ab7d60 x22: ffff800012f03758 x21: 0000000=
00000005f
> > [  146.754427] x20: 000000000000005c x19: ffff004080012840 x18: fffffff=
fffffffff
> > [  146.754814] x17: 3661613030303230 x16: 30303078303a3239 x15: ffff800=
011f92b48
> > [  146.755197] x14: ffff20be3f95cef6 x13: 2e6e69616d6f642d x12: 6465686=
373204c4c
> > [  146.755578] x11: ffff20bf7fc83a00 x10: 0000000000000040 x9 : 0000000=
000000000
> > [  146.755957] x8 : 0000000000000002 x7 : ffffffffe0000000 x6 : 0000000=
000000002
> > [  146.756334] x5 : 0000000090000000 x4 : 00000000f0000000 x3 : 0000000=
000000001
> > [  146.756705] x2 : 0000000000000080 x1 : ffff800012f03860 x0 : 0000000=
000000001
> > [  146.757070] Call trace:
> > [  146.757421]  build_sched_domains+0x81c/0x11b0
> > [  146.757771]  partition_sched_domains_locked+0x57c/0x978
> > [  146.758118]  rebuild_sched_domains_locked+0x44c/0x7f0
> > [  146.758460]  rebuild_sched_domains+0x2c/0x48
> > [  146.758791]  cpuset_hotplug_workfn+0x3fc/0x888
> > [  146.759114]  process_one_work+0x1f4/0x480
> > [  146.759429]  worker_thread+0x48/0x460
> > [  146.759734]  kthread+0x158/0x168
> > [  146.760030]  ret_from_fork+0x10/0x20
> > [  146.760318] ---[ end trace 82c44aad6900e81a ]---
> >
> > For some architectures like risc-v and arm64 which use common code
> > clear_cpu_topology() in shutting down CPUx, When CONFIG_SCHED_CLUSTER
> > is set, cluster_sibling in cpu_topology of each sibling adjacent
> > to CPUx is missed clearing, this causes checking failed in
> > topology_span_sane() and rebuilding topology failure at end when CPU on=
line.
> >
> > Different sibling's cluster_sibling in cpu_topology[] when CPU92 offlin=
e
> > (CPU 92, 93, 94, 95 are in one cluster):
> >
> > Before revision:
> > CPU                 [92]      [93]      [94]      [95]
> > cluster_sibling     [92]     [92-95]   [92-95]   [92-95]
> >
> > After revision:
> > CPU                 [92]      [93]      [94]      [95]
> > cluster_sibling     [92]     [93-95]   [93-95]   [93-95]
> >
> > Signed-off-by: Wang ShaoBo <bobo.shaobowang@huawei.com>
> >
> > The patch looks correct. But how do you reproduce it?
> >
> > Hi Barry,
> >
> > you can try this test case in kunpeng 920:
> >
> >
> echo 0 > cpu92/online
> echo 0 > cpu93/online
> echo 1 > cpu92/online
>
> Yes. I was making the whole cluster offline. this warning can only be
> reproduced when
> we disable a part of CPUs in one cluster, then enable one of the disabled=
 CPUs.
>
> Acked-by: Barry Song <song.bao.hua@hisilicon.com>
>
> Might need some refine to explain how to reproduce in commit log.

and also a fix tag.

>
> >
> > - Wang ShaoBo
>
> Thanks
> Barry
