Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 890EB3DA340
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 14:37:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237213AbhG2MhO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 08:37:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:29364 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236597AbhG2MhN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 08:37:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627562229;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GN4EQPcHETgYZin8lGd1R9jmdS/66D9T6iX7MkMMUXg=;
        b=cOvcc1y09iHK2AauwY7Sdu8qFYF4yQ6TIu5MGqko6NNlhcSmJhzU/ZRFWUT6uGkmJdy00s
        a9j4pUsI2Ami5aO9jsHRZ7Yt9QeDwQS/XUAlyNAucOhdo08+1LXoUflCn627nSLmce9elh
        dFvGdN2jkgK3IGR0vvH05JGuzsK5jp4=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-484---Uzn0eGMLKn3NNMSthjtA-1; Thu, 29 Jul 2021 08:37:08 -0400
X-MC-Unique: --Uzn0eGMLKn3NNMSthjtA-1
Received: by mail-ot1-f69.google.com with SMTP id z11-20020a056830290bb02904d1d78ee61cso2273046otu.3
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 05:37:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GN4EQPcHETgYZin8lGd1R9jmdS/66D9T6iX7MkMMUXg=;
        b=Sxr/9Ut8fnXxfCOxDBlN1d3/rmllCBAVpCyzqLxYTprnBbMshSx4ZXzD8YZ1sY91Mv
         AgQg5LY6qpLL7a+1j/nVpb26xr/IBRlzBIgwoZFsXM7fwfQnxkgvk0XxcWaCXfO0MfAr
         aqmyH6ykwF50dYfomB6TNphyL1hjlOPNCrsconVO7GTRNL/7+INoI+Utm/d3/UfeBB8D
         nvc2axZFR9HVW4sXW2Bmrq9kQq7vadGnrLKFsdR6HPM8psz4OS8GrUfupa20Lu3//TiY
         nTttF4WAe6EGr6AmrQbClyIegfEdfeA0LA3B53Nkfye8+aPAcZxFeidXuiLM+AYzD9tj
         PUHQ==
X-Gm-Message-State: AOAM533H9g8FSRelCr6Zf1JnqoJHOVcCMjEboL5Nu7kqCoR31LvziTok
        N8CAJ7v5PbyTGJqZriIRWw7l4j/m37bTKXEHKkXgesy2DxP4DJQsNANgDC46FM3gbuR94TuSpMl
        QjBFEUSYvzx2KxrTwS94XTmiznlKUrVGXtBcf/OT1
X-Received: by 2002:a05:6808:1887:: with SMTP id bi7mr1352991oib.115.1627562227683;
        Thu, 29 Jul 2021 05:37:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxJQ/70hSNkJK/LiNtKau4StlNc6n62SckOCOiGSA+di6CjlP5NdJJhXa8uWCy1hkrZXnqi5AJD4ySy5RDNnek=
X-Received: by 2002:a05:6808:1887:: with SMTP id bi7mr1352981oib.115.1627562227503;
 Thu, 29 Jul 2021 05:37:07 -0700 (PDT)
MIME-Version: 1.0
References: <CA+QYu4oOgrb8n=Qyuky-M0dYPEo_HNMdbNuj2SF4a=aQTE_xvw@mail.gmail.com>
 <d86333e7-bcde-2adb-e566-21ec97cda8bf@arm.com>
In-Reply-To: <d86333e7-bcde-2adb-e566-21ec97cda8bf@arm.com>
From:   Bruno Goncalves <bgoncalv@redhat.com>
Date:   Thu, 29 Jul 2021 14:36:56 +0200
Message-ID: <CA+QYu4rCRR_pNQVxSwGpzcLWJKLUA3F7LAtBiU9hPzz3D0k0Cg@mail.gmail.com>
Subject: Re: WARNING: CPU: 112 PID: 2041 at kernel/sched/sched.h:1453
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     CKI Project <cki-project@redhat.com>, linux-kernel@vger.kernel.org,
        nathan@kernel.org, Memory Management <mm-qe@redhat.com>,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 28, 2021 at 5:55 PM Dietmar Eggemann
<dietmar.eggemann@arm.com> wrote:
>
> On 28/07/2021 15:11, Bruno Goncalves wrote:
> > Hello,
> >
> > Since this commit (Commit: 45312bd762d3 - Merge tag 'zonefs-5.14-rc2')
> > we started to see the following call trace, it seems to be
> > reproducible only on aarch64.
>
> It should happen on platforms using a slow-switching cpufreq driver.
>
> Only in this case you have n (depends on nbr of frequency domains)
> special-purpose DL threads when using schedutil CPUFreq governor:
>
> root@juno: ps -eTo comm,pid,pri,class | grep sugov
>
> sugov:0           132 140 DLN
> sugov:1           134 140 DLN
>
> >
> > [  384.485614] ------------[ cut here ]------------
> > [  384.490227] rq->clock_update_flags < RQCF_ACT_SKIP
> > [  384.490232] WARNING: CPU: 112 PID: 2041 at
> > kernel/sched/sched.h:1453 sub_running_bw.isra.0+0x190/0x1a0
> > [  384.504312] Modules linked in: mlx5_ib ib_uverbs ib_core rfkill
> > sunrpc acpi_ipmi ipmi_ssif mlx5_core mlxfw psample ipmi_devintf
> > arm_cmn ipmi_msghandler arm_dsu_pmu cppc_cpufreq acpi_tad vfat fat
> > fuse zram ip_tables x_tables xfs crct10dif_ce ghash_ce ast
> > i2c_algo_bit drm_vram_helper sbsa_gwdt drm_kms_helper syscopyarea
> > sysfillrect sysimgblt fb_sys_fops cec drm_ttm_helper ttm nvme
> > nvme_core drm xgene_hwmon aes_neon_bs
> > [  384.541165] CPU: 112 PID: 2041 Comm: sugov:112 Tainted: G        W
> >        5.14.0-rc1 #1
> > [  384.549244] Hardware name: WIWYNN Mt.Jade Server System
> > B81.030Z1.0007/Mt.Jade Motherboard, BIOS 1.6.20210526 (SCP:
> > 1.06.20210526) 2021/05/26
> > [  384.561922] pstate: 404000c9 (nZcv daIF +PAN -UAO -TCO BTYPE=--)
> > [  384.567918] pc : sub_running_bw.isra.0+0x190/0x1a0
> > [  384.572698] lr : sub_running_bw.isra.0+0x190/0x1a0
> > [  384.577477] sp : ffff800024c4bb20
> > [  384.580779] x29: ffff800024c4bb20 x28: 0000000000000000 x27: ffffb9a9bbe1d200
> > [  384.587904] x26: 0000000000000074 x25: 0000000000000011 x24: ffffb9a9bdff9000
> > [  384.595029] x23: ffff07ffb36fcaa0 x22: ffff401ee09b65c0 x21: ffffb9a9bbe1de00
> > [  384.602153] x20: ffff401ee09a3360 x19: ffff401ee09b6f58 x18: 0000000000000000
> > [  384.609277] x17: ffff867522f0c000 x16: ffff800010384000 x15: 0000000000000030
> > [  384.616401] x14: 0000000000000000 x13: 50494b535f544341 x12: 5f46435152203c20
> > [  384.623526] x11: ffff401ee04b0ea8 x10: ffff401ee021e068 x9 : ffffb9a9bbe4214c
> > [  384.630650] x8 : 0000000000010ea8 x7 : ffff401ee01e0000 x6 : 0000000000017ffd
> > [  384.637774] x5 : ffff401ee09a3490 x4 : 0000000000000001 x3 : ffff867522f0c000
> > [  384.644898] x2 : ffff401ee09a3498 x1 : ffff07ffb53cc000 x0 : 0000000000000026
> > [  384.652022] Call trace:
> > [  384.654457]  sub_running_bw.isra.0+0x190/0x1a0
> > [  384.658890]  migrate_task_rq_dl+0xf8/0x1e0
> > [  384.662975]  set_task_cpu+0xa8/0x1f0
> > [  384.666540]  try_to_wake_up+0x150/0x3d4
> > [  384.670365]  wake_up_q+0x64/0xc0
> > [  384.673582]  __up_write+0xd0/0x1c0
> > [  384.676974]  up_write+0x4c/0x2b0
> > [  384.680191]  cppc_set_perf+0x120/0x2d0
> > [  384.683931]  cppc_cpufreq_set_target+0xe0/0x1a4 [cppc_cpufreq]
> > [  384.689756]  __cpufreq_driver_target+0x74/0x140
> > [  384.694277]  sugov_work+0x64/0x80
> > [  384.697580]  kthread_worker_fn+0xe0/0x230
> > [  384.701580]  kthread+0x138/0x140
> > [  384.704797]  ret_from_fork+0x10/0x18
>
> Don't quite get this.
> `sugov:112` should be a special DL entity (dl_se->flags &
> SCHED_FLAG_SUGOV) so sub_running_bw() should not call __sub_running_bw()
> and hence there won't be a call to cpufreq_update_util() which calls
> q_clock(rq) -> assert_clock_updated()?
>
> Can't reproduce it on my Juno (arm64) (slow-switching (scpi-cpufreq
> driver)).

We seem to be able to reproduce this only on Ampere Altra machines,
specifically on mtjade and mtsnow cpus.

# cpupower frequency-info
analyzing CPU 0:
  driver: cppc_cpufreq
  CPUs which run at the same hardware frequency: 0
  CPUs which need to have their frequency coordinated by software: 0
  maximum transition latency:  Cannot determine or is not supported.
  hardware limits: 1000 MHz - 2.80 GHz
  available cpufreq governors: conservative ondemand userspace
powersave performance schedutil
  current policy: frequency should be within 2.00 GHz and 2.80 GHz.
                  The governor "schedutil" may decide which speed to use
                  within this range.
  current CPU frequency: 1.55 GHz (asserted by call to hardware)

# ps -eTo comm,pid,pri,class | grep sugov
sugov:0            1082 140 DLN
sugov:1            1085 140 DLN
...
sugov:78           1319 140 DLN
sugov:79           1320 140 DLN


Bruno


>

