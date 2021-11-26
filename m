Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4418445F250
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 17:42:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352672AbhKZQpr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 11:45:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245494AbhKZQnq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 11:43:46 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C94AC0619D8
        for <linux-kernel@vger.kernel.org>; Fri, 26 Nov 2021 08:28:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 168B3B8272C
        for <linux-kernel@vger.kernel.org>; Fri, 26 Nov 2021 16:28:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CED9C93056;
        Fri, 26 Nov 2021 16:28:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1637944102;
        bh=gmwd/U4xyQPM2smltF/FD6JYAawcil0k29c20nXQr1M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1VExt6UJbxL/vHe23x0bsXdpiYVOrXEffk6rt4sD/ABCOTIXSxg3Nr0kZqrvYN0qt
         0p817BVRaQjt1eEJ5OdgSUC4dAnyRLWjOdZxlACpdVGpBAcDR4RsRdCf47lmuYAbGS
         0aRB5PkQkwcKS33CCdQV24u7CZml98Tn1hUoUUbQ=
Date:   Fri, 26 Nov 2021 17:28:19 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Wang ShaoBo <bobo.shaobowang@huawei.com>
Cc:     linux-kernel@vger.kernel.org, rafael@kernel.org,
        sudeep.holla@arm.com, peterz@infradead.org,
        cj.chengjian@huawei.com, huawei.libin@huawei.com,
        weiyongjun1@huawei.com
Subject: Re: [PATCH] arch_topology: Fix missing clear cluster_cpumask in
 remove_cpu_topology()
Message-ID: <YaELI8+QnBeXXIVm@kroah.com>
References: <20211110095856.469360-1-bobo.shaobowang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211110095856.469360-1-bobo.shaobowang@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 10, 2021 at 05:58:56PM +0800, Wang ShaoBo wrote:
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
> ---
>  drivers/base/arch_topology.c | 2 ++
>  1 file changed, 2 insertions(+)

What commit id does this fix?

thanks,

greg k-h
