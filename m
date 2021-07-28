Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D2DE3D9260
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 17:55:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237078AbhG1PzK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 11:55:10 -0400
Received: from foss.arm.com ([217.140.110.172]:59084 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229880AbhG1PzJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 11:55:09 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CB34F1FB;
        Wed, 28 Jul 2021 08:55:07 -0700 (PDT)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EBAD33F70D;
        Wed, 28 Jul 2021 08:55:06 -0700 (PDT)
Subject: Re: WARNING: CPU: 112 PID: 2041 at kernel/sched/sched.h:1453
To:     Bruno Goncalves <bgoncalv@redhat.com>,
        CKI Project <cki-project@redhat.com>,
        linux-kernel@vger.kernel.org
Cc:     nathan@kernel.org, Memory Management <mm-qe@redhat.com>
References: <CA+QYu4oOgrb8n=Qyuky-M0dYPEo_HNMdbNuj2SF4a=aQTE_xvw@mail.gmail.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <d86333e7-bcde-2adb-e566-21ec97cda8bf@arm.com>
Date:   Wed, 28 Jul 2021 17:55:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CA+QYu4oOgrb8n=Qyuky-M0dYPEo_HNMdbNuj2SF4a=aQTE_xvw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/07/2021 15:11, Bruno Goncalves wrote:
> Hello,
> 
> Since this commit (Commit: 45312bd762d3 - Merge tag 'zonefs-5.14-rc2')
> we started to see the following call trace, it seems to be
> reproducible only on aarch64.

It should happen on platforms using a slow-switching cpufreq driver.

Only in this case you have n (depends on nbr of frequency domains)
special-purpose DL threads when using schedutil CPUFreq governor:

root@juno: ps -eTo comm,pid,pri,class | grep sugov

sugov:0           132 140 DLN
sugov:1           134 140 DLN

> 
> [  384.485614] ------------[ cut here ]------------
> [  384.490227] rq->clock_update_flags < RQCF_ACT_SKIP
> [  384.490232] WARNING: CPU: 112 PID: 2041 at
> kernel/sched/sched.h:1453 sub_running_bw.isra.0+0x190/0x1a0
> [  384.504312] Modules linked in: mlx5_ib ib_uverbs ib_core rfkill
> sunrpc acpi_ipmi ipmi_ssif mlx5_core mlxfw psample ipmi_devintf
> arm_cmn ipmi_msghandler arm_dsu_pmu cppc_cpufreq acpi_tad vfat fat
> fuse zram ip_tables x_tables xfs crct10dif_ce ghash_ce ast
> i2c_algo_bit drm_vram_helper sbsa_gwdt drm_kms_helper syscopyarea
> sysfillrect sysimgblt fb_sys_fops cec drm_ttm_helper ttm nvme
> nvme_core drm xgene_hwmon aes_neon_bs
> [  384.541165] CPU: 112 PID: 2041 Comm: sugov:112 Tainted: G        W
>        5.14.0-rc1 #1
> [  384.549244] Hardware name: WIWYNN Mt.Jade Server System
> B81.030Z1.0007/Mt.Jade Motherboard, BIOS 1.6.20210526 (SCP:
> 1.06.20210526) 2021/05/26
> [  384.561922] pstate: 404000c9 (nZcv daIF +PAN -UAO -TCO BTYPE=--)
> [  384.567918] pc : sub_running_bw.isra.0+0x190/0x1a0
> [  384.572698] lr : sub_running_bw.isra.0+0x190/0x1a0
> [  384.577477] sp : ffff800024c4bb20
> [  384.580779] x29: ffff800024c4bb20 x28: 0000000000000000 x27: ffffb9a9bbe1d200
> [  384.587904] x26: 0000000000000074 x25: 0000000000000011 x24: ffffb9a9bdff9000
> [  384.595029] x23: ffff07ffb36fcaa0 x22: ffff401ee09b65c0 x21: ffffb9a9bbe1de00
> [  384.602153] x20: ffff401ee09a3360 x19: ffff401ee09b6f58 x18: 0000000000000000
> [  384.609277] x17: ffff867522f0c000 x16: ffff800010384000 x15: 0000000000000030
> [  384.616401] x14: 0000000000000000 x13: 50494b535f544341 x12: 5f46435152203c20
> [  384.623526] x11: ffff401ee04b0ea8 x10: ffff401ee021e068 x9 : ffffb9a9bbe4214c
> [  384.630650] x8 : 0000000000010ea8 x7 : ffff401ee01e0000 x6 : 0000000000017ffd
> [  384.637774] x5 : ffff401ee09a3490 x4 : 0000000000000001 x3 : ffff867522f0c000
> [  384.644898] x2 : ffff401ee09a3498 x1 : ffff07ffb53cc000 x0 : 0000000000000026
> [  384.652022] Call trace:
> [  384.654457]  sub_running_bw.isra.0+0x190/0x1a0
> [  384.658890]  migrate_task_rq_dl+0xf8/0x1e0
> [  384.662975]  set_task_cpu+0xa8/0x1f0
> [  384.666540]  try_to_wake_up+0x150/0x3d4
> [  384.670365]  wake_up_q+0x64/0xc0
> [  384.673582]  __up_write+0xd0/0x1c0
> [  384.676974]  up_write+0x4c/0x2b0
> [  384.680191]  cppc_set_perf+0x120/0x2d0
> [  384.683931]  cppc_cpufreq_set_target+0xe0/0x1a4 [cppc_cpufreq]
> [  384.689756]  __cpufreq_driver_target+0x74/0x140
> [  384.694277]  sugov_work+0x64/0x80
> [  384.697580]  kthread_worker_fn+0xe0/0x230
> [  384.701580]  kthread+0x138/0x140
> [  384.704797]  ret_from_fork+0x10/0x18

Don't quite get this.
`sugov:112` should be a special DL entity (dl_se->flags &
SCHED_FLAG_SUGOV) so sub_running_bw() should not call __sub_running_bw()
and hence there won't be a call to cpufreq_update_util() which calls
q_clock(rq) -> assert_clock_updated()?

Can't reproduce it on my Juno (arm64) (slow-switching (scpi-cpufreq
driver)).
