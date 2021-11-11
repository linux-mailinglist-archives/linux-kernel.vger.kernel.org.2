Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 092DF44D1EF
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 07:25:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231418AbhKKG21 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Nov 2021 01:28:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbhKKG20 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Nov 2021 01:28:26 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB755C061766
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 22:25:37 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id j21so19813206edt.11
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 22:25:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=61mOuHKArCaKc3k1P+N+AOwU5ULnSGmawIoSfIL914M=;
        b=efI//94R0wZA+9cNcP8WtPDNRo82ddCprZK18O5G1w+w1RHY37fcNet33+pCK4wXxd
         KjNojveH6L4qtdrYyWgE6k2w0u56tEhz5PP2OAvmGjgNKwTgXDzlhEt51GZnp3wuEu2X
         nwjz31nZoGR64rplXLiRfjityWkZALoPoj5hgCc7/V6MppPsgugh81Lf2fwnIJWWtck3
         F9Wq4PLpv43pOlWBW5EdHnXVW/uQ5g2h83j+YVwYZCWvd4IDn1+Twedr0zDm359dIyEy
         zuKS6mDDY3c0g8y9h85IrzORE2F4/4TC1o/r0CRZDV344xN47j9jhiR/2DElFEgbD1BO
         RtbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=61mOuHKArCaKc3k1P+N+AOwU5ULnSGmawIoSfIL914M=;
        b=3X6l5K3f/7fleDZU5F7rhJyDLN+0u/H/4Gy/zg/kMmqZZNX9gLuGZQzwyTtu0KtS4f
         PzR6R20HgIUNjXX70eynHJtRESAyTUqIXR3MtQGWv4dWS7BBgABbVzcxbrbnNwZYVHeW
         MD86EtmtarPuptOYpw8i6L9sGUWIjH7FYETtG2ldFsVpmAPc6HaWeBY55i7I9Z207eVj
         n0UjqNCt+3AJx1zeBiX2dk+FcWPAWGSK5zh6syWfM/wWONSlZvaUGJfHVN4Evy07GTS5
         c/hk1KjxQ3zrwDvu+5/hPkLIrfJDPl7Jq3Y5CGAF7BscvM1w5NYYk1mEBiWPupLQFIxG
         hrUA==
X-Gm-Message-State: AOAM5317Aga+PwhG7sSLzzRubwYv5vJhxKs2eFXdyx9taQl/FhpLIbnk
        U/ib/5i4pPSiIBiSmF1vzjtiqBElD80Cl7NyfuI=
X-Google-Smtp-Source: ABdhPJyKGm8VXBBQXgwKnRsI9YCc+yLfcMLkepkHof15hkAYLXgJib6olTZUpIe7Ir/2Fkej71JQMoaT7+oGCDMME4U=
X-Received: by 2002:a05:6402:455:: with SMTP id p21mr6727549edw.384.1636611936275;
 Wed, 10 Nov 2021 22:25:36 -0800 (PST)
MIME-Version: 1.0
References: <20211110095856.469360-1-bobo.shaobowang@huawei.com>
In-Reply-To: <20211110095856.469360-1-bobo.shaobowang@huawei.com>
From:   Barry Song <21cnbao@gmail.com>
Date:   Thu, 11 Nov 2021 19:25:25 +1300
Message-ID: <CAGsJ_4wzPWnNFe4ptphVxXSz4-50-qub+H_q0woupxOM1LtqsA@mail.gmail.com>
Subject: Re: [PATCH] arch_topology: Fix missing clear cluster_cpumask in remove_cpu_topology()
To:     Wang ShaoBo <bobo.shaobowang@huawei.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Peter Zijlstra <peterz@infradead.org>, cj.chengjian@huawei.com,
        huawei.libin@huawei.com, weiyongjun1@huawei.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 10, 2021 at 10:53 PM Wang ShaoBo <bobo.shaobowang@huawei.com> wrote:
>
> When testing cpu online and offline, warning happened like this:
>
> [  146.746743] WARNING: CPU: 92 PID: 974 at kernel/sched/topology.c:2215 build_sched_domains+0x81c/0x11b0
> [  146.749988] CPU: 92 PID: 974 Comm: kworker/92:2 Not tainted 5.15.0 #9
> [  146.750402] Hardware name: Huawei TaiShan 2280 V2/BC82AMDDA, BIOS 1.79 08/21/2021
> [  146.751213] Workqueue: events cpuset_hotplug_workfn
> [  146.751629] pstate: 00400009 (nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> [  146.752048] pc : build_sched_domains+0x81c/0x11b0
> [  146.752461] lr : build_sched_domains+0x414/0x11b0
> [  146.752860] sp : ffff800040a83a80
> [  146.753247] x29: ffff800040a83a80 x28: ffff20801f13a980 x27: ffff20800448ae00
> [  146.753644] x26: ffff800012a858e8 x25: ffff800012ea48c0 x24: 0000000000000000
> [  146.754039] x23: ffff800010ab7d60 x22: ffff800012f03758 x21: 000000000000005f
> [  146.754427] x20: 000000000000005c x19: ffff004080012840 x18: ffffffffffffffff
> [  146.754814] x17: 3661613030303230 x16: 30303078303a3239 x15: ffff800011f92b48
> [  146.755197] x14: ffff20be3f95cef6 x13: 2e6e69616d6f642d x12: 6465686373204c4c
> [  146.755578] x11: ffff20bf7fc83a00 x10: 0000000000000040 x9 : 0000000000000000
> [  146.755957] x8 : 0000000000000002 x7 : ffffffffe0000000 x6 : 0000000000000002
> [  146.756334] x5 : 0000000090000000 x4 : 00000000f0000000 x3 : 0000000000000001
> [  146.756705] x2 : 0000000000000080 x1 : ffff800012f03860 x0 : 0000000000000001
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
> topology_span_sane() and rebuilding topology failure at end when CPU online.
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

The patch looks correct. But how do you reproduce it?

it seems the below pattern can't reproduce it:

root@ubuntu:/sys/devices/system/cpu# dmesg -c

root@ubuntu:/sys/devices/system/cpu# echo 0 > cpu92/online
root@ubuntu:/sys/devices/system/cpu# echo 0 > cpu93/online
root@ubuntu:/sys/devices/system/cpu# echo 0 > cpu94/online
root@ubuntu:/sys/devices/system/cpu# echo 0 > cpu95/online

root@ubuntu:/sys/devices/system/cpu# echo 1 > cpu92/online
root@ubuntu:/sys/devices/system/cpu# echo 1 > cpu93/online
root@ubuntu:/sys/devices/system/cpu# echo 1 > cpu94/online
root@ubuntu:/sys/devices/system/cpu# echo 1 > cpu95/online

root@ubuntu:/sys/devices/system/cpu# dmesg
[297239.288736] psci: CPU92 killed (polled 0 ms)
[297242.060617] psci: CPU93 killed (polled 0 ms)
[297244.748477] psci: CPU94 killed (polled 0 ms)
[297248.480440] psci: CPU95 killed (polled 0 ms)
[297254.966108] Detected VIPT I-cache on CPU92
[297254.966163] GICv3: CPU92: found redistributor 2f0000 region
92:0x00002000ae800000
[297254.966256] CPU92: Booted secondary processor 0x00002f0000 [0x481fd010]
[297261.997920] Detected VIPT I-cache on CPU93
[297261.997965] GICv3: CPU93: found redistributor 2f0100 region
93:0x00002000ae840000
[297261.998052] CPU93: Booted secondary processor 0x00002f0100 [0x481fd010]
[297264.893849] Detected VIPT I-cache on CPU94
[297264.893895] GICv3: CPU94: found redistributor 2f0200 region
94:0x00002000ae880000
[297264.893985] CPU94: Booted secondary processor 0x00002f0200 [0x481fd010]
[297267.869685] Detected VIPT I-cache on CPU95
[297267.869731] GICv3: CPU95: found redistributor 2f0300 region
95:0x00002000ae8c0000
[297267.869817] CPU95: Booted secondary processor 0x00002f0300 [0x481fd010]
root@ubuntu:/sys/devices/system/cpu#


> ---
>  drivers/base/arch_topology.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
> index 981e72a3dafb..ff16a36a908b 100644
> --- a/drivers/base/arch_topology.c
> +++ b/drivers/base/arch_topology.c
> @@ -677,6 +677,8 @@ void remove_cpu_topology(unsigned int cpu)
>                 cpumask_clear_cpu(cpu, topology_core_cpumask(sibling));
>         for_each_cpu(sibling, topology_sibling_cpumask(cpu))
>                 cpumask_clear_cpu(cpu, topology_sibling_cpumask(sibling));
> +       for_each_cpu(sibling, topology_cluster_cpumask(cpu))
> +               cpumask_clear_cpu(cpu, topology_cluster_cpumask(sibling));
>         for_each_cpu(sibling, topology_llc_cpumask(cpu))
>                 cpumask_clear_cpu(cpu, topology_llc_cpumask(sibling));
>
> --
> 2.25.1
>

Thanks
Barry
