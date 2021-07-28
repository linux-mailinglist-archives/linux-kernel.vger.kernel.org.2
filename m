Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1583C3D8EAB
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 15:11:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236185AbhG1NL4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 09:11:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:44385 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235204AbhG1NLy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 09:11:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627477912;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=aQ+852563VaNS2uiQQ1GclOgDI9K53wVa6AHNRjzjGc=;
        b=dBeYazUXrIeZ1qFTB5FR6T94DwPE78/YdVIgFBxpXeMlEfTGGH1M6VsYMX6xM0X4Wx3XLd
        oOj55Y8LVMkxXYEgbdtEgzn9zYoeNuXl7lfgPJ9LUilV+naV4uT60FGudvhk9jMvYmExjG
        CrZM64RKBaCPBLkmP7MsMNaAwHPAcfk=
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-377-moGlsMOKP8So6bu32cf__g-1; Wed, 28 Jul 2021 09:11:48 -0400
X-MC-Unique: moGlsMOKP8So6bu32cf__g-1
Received: by mail-oo1-f72.google.com with SMTP id b7-20020a0568200247b02902691c6a5defso1170008ooe.15
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jul 2021 06:11:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=aQ+852563VaNS2uiQQ1GclOgDI9K53wVa6AHNRjzjGc=;
        b=gN6MlcpvOQB4BorEPD8Ryroy21nPkbXB1gEcJoguhekzD9DBGmyMu0gv5xeHSmZlC8
         odlruILuLD0sHOM9tMcGW+cL7OimHNVzo5BJ6qSDAERrnR42bYxYOyPctWYf8WScpUPD
         ZlG+pQDOlySltmLvP/SDovEMqDycRhQH9nZqbOZwGqNmxeUUJWsGANlcQ1ASKiM399/Q
         sTY1gbPCY966j3uIDBMGshlyoltW+/GqhDaIJxy0A740cRMdWJPEShc+NN2xf1Zw3su+
         FUf1LBuY8L+nupcNxCJHm3pbT8AXxhkzOwWaevpjCKlmmDlGxymFrN+ddMznfaWCvSPb
         iXoA==
X-Gm-Message-State: AOAM5325yrfNq9okkEsbFkAkw5w3Wpluqm8Zz0TeGn9MJ1+Tcj3hsaxp
        cXJmRGB5QxsaSHc0rvn6JW6Cw3rqxNgOERHyrsIiipwcYjZat4RNugUskhoErqi7gbArToAIVJz
        N7v9z1BK5QOi+efDYhF0+5pylFN3ipFt7reyXgFi/
X-Received: by 2002:a05:6808:f14:: with SMTP id m20mr6522431oiw.179.1627477907589;
        Wed, 28 Jul 2021 06:11:47 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzvN2DhEABGf6XGJGQDGziKffAt6QRZ1Z8QZ+dChmJRVX0ogfD1GUlprGwOCZBBXqP8rty9bjGtp4PQvXPze8g=
X-Received: by 2002:a05:6808:f14:: with SMTP id m20mr6522418oiw.179.1627477907443;
 Wed, 28 Jul 2021 06:11:47 -0700 (PDT)
MIME-Version: 1.0
From:   Bruno Goncalves <bgoncalv@redhat.com>
Date:   Wed, 28 Jul 2021 15:11:36 +0200
Message-ID: <CA+QYu4oOgrb8n=Qyuky-M0dYPEo_HNMdbNuj2SF4a=aQTE_xvw@mail.gmail.com>
Subject: WARNING: CPU: 112 PID: 2041 at kernel/sched/sched.h:1453
To:     CKI Project <cki-project@redhat.com>, linux-kernel@vger.kernel.org
Cc:     nathan@kernel.org, Memory Management <mm-qe@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Since this commit (Commit: 45312bd762d3 - Merge tag 'zonefs-5.14-rc2')
we started to see the following call trace, it seems to be
reproducible only on aarch64.

[  384.485614] ------------[ cut here ]------------
[  384.490227] rq->clock_update_flags < RQCF_ACT_SKIP
[  384.490232] WARNING: CPU: 112 PID: 2041 at
kernel/sched/sched.h:1453 sub_running_bw.isra.0+0x190/0x1a0
[  384.504312] Modules linked in: mlx5_ib ib_uverbs ib_core rfkill
sunrpc acpi_ipmi ipmi_ssif mlx5_core mlxfw psample ipmi_devintf
arm_cmn ipmi_msghandler arm_dsu_pmu cppc_cpufreq acpi_tad vfat fat
fuse zram ip_tables x_tables xfs crct10dif_ce ghash_ce ast
i2c_algo_bit drm_vram_helper sbsa_gwdt drm_kms_helper syscopyarea
sysfillrect sysimgblt fb_sys_fops cec drm_ttm_helper ttm nvme
nvme_core drm xgene_hwmon aes_neon_bs
[  384.541165] CPU: 112 PID: 2041 Comm: sugov:112 Tainted: G        W
       5.14.0-rc1 #1
[  384.549244] Hardware name: WIWYNN Mt.Jade Server System
B81.030Z1.0007/Mt.Jade Motherboard, BIOS 1.6.20210526 (SCP:
1.06.20210526) 2021/05/26
[  384.561922] pstate: 404000c9 (nZcv daIF +PAN -UAO -TCO BTYPE=--)
[  384.567918] pc : sub_running_bw.isra.0+0x190/0x1a0
[  384.572698] lr : sub_running_bw.isra.0+0x190/0x1a0
[  384.577477] sp : ffff800024c4bb20
[  384.580779] x29: ffff800024c4bb20 x28: 0000000000000000 x27: ffffb9a9bbe1d200
[  384.587904] x26: 0000000000000074 x25: 0000000000000011 x24: ffffb9a9bdff9000
[  384.595029] x23: ffff07ffb36fcaa0 x22: ffff401ee09b65c0 x21: ffffb9a9bbe1de00
[  384.602153] x20: ffff401ee09a3360 x19: ffff401ee09b6f58 x18: 0000000000000000
[  384.609277] x17: ffff867522f0c000 x16: ffff800010384000 x15: 0000000000000030
[  384.616401] x14: 0000000000000000 x13: 50494b535f544341 x12: 5f46435152203c20
[  384.623526] x11: ffff401ee04b0ea8 x10: ffff401ee021e068 x9 : ffffb9a9bbe4214c
[  384.630650] x8 : 0000000000010ea8 x7 : ffff401ee01e0000 x6 : 0000000000017ffd
[  384.637774] x5 : ffff401ee09a3490 x4 : 0000000000000001 x3 : ffff867522f0c000
[  384.644898] x2 : ffff401ee09a3498 x1 : ffff07ffb53cc000 x0 : 0000000000000026
[  384.652022] Call trace:
[  384.654457]  sub_running_bw.isra.0+0x190/0x1a0
[  384.658890]  migrate_task_rq_dl+0xf8/0x1e0
[  384.662975]  set_task_cpu+0xa8/0x1f0
[  384.666540]  try_to_wake_up+0x150/0x3d4
[  384.670365]  wake_up_q+0x64/0xc0
[  384.673582]  __up_write+0xd0/0x1c0
[  384.676974]  up_write+0x4c/0x2b0
[  384.680191]  cppc_set_perf+0x120/0x2d0
[  384.683931]  cppc_cpufreq_set_target+0xe0/0x1a4 [cppc_cpufreq]
[  384.689756]  __cpufreq_driver_target+0x74/0x140
[  384.694277]  sugov_work+0x64/0x80
[  384.697580]  kthread_worker_fn+0xe0/0x230
[  384.701580]  kthread+0x138/0x140
[  384.704797]  ret_from_fork+0x10/0x18


More logs can be found checking out dmesg logs on:
https://arr-cki-prod-datawarehouse-public.s3.amazonaws.com/index.html?prefix=datawarehouse-public/2021/07/16/338525814/build_aarch64_redhat%3A1431434591/tests/storage_software_RAID_testing/
https://arr-cki-prod-datawarehouse-public.s3.amazonaws.com/index.html?prefix=datawarehouse-public/2021/07/16/338525814/build_aarch64_redhat%3A1431434591/tests/xfstests_btrfs/
https://arr-cki-prod-datawarehouse-public.s3.amazonaws.com/index.html?prefix=datawarehouse-public/2021/07/16/338525814/build_aarch64_redhat%3A1431434591/tests/xfstests_ext4/
https://arr-cki-prod-datawarehouse-public.s3.amazonaws.com/index.html?prefix=datawarehouse-public/2021/07/16/338525814/build_aarch64_redhat%3A1431434591/tests/xfstests_xfs/

Thank you,
Bruno Goncalves

