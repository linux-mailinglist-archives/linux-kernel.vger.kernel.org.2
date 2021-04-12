Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC2DA35D23A
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 22:50:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238697AbhDLUua (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 16:50:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236988AbhDLUu3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 16:50:29 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18011C061574
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 13:50:11 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id c4so15757061qkg.3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 13:50:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=obDs/XpxWEky4e66MRh3RwGDUsnC0qd3Ri4kxaTuKVM=;
        b=b4jBGfBgoCqAPMTDGTMJhhJRJnpch/jGiLcO6hBxq+SYk/nb+hEcnTpZsT8MFXMaWU
         Fl5GNO0aghy5wRC6TxaqcjWO3wyhgXKPYADbOwr0BWyybazAIKBnHdBvN7mEI3oERCLO
         q2/1YtzQrwFFlwYeHDeu8MwIkiqxOX/2KZHafjHZLVUvRy4Jw+BLiFqAXYxJEu5ht44L
         XswawYxlQ/UtyMldBl2rtt389f2oWy/GzZTowQJJfcdYlccYIzxBkhS0aKmHWi8p0BJV
         ribe78YGuT22I//7j6pyXjzfrEIilUwLGgcJaRbq52IqYCjNfm2VOduSesFeQ0FcFlJF
         a6FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=obDs/XpxWEky4e66MRh3RwGDUsnC0qd3Ri4kxaTuKVM=;
        b=gGVRfuNmwZadhjSuMv9ONEjxYRfA7unBrYyR3tRje/MfL+3YaUcGUMaUun02iGWa6m
         htzn7FAFOlLGHK0FI4ltm+Ammqcm675DSUA/75zDQW4FX9/1MZQXVUJl+3KF0LSKTRlj
         d9Aziudt1e0520Z/DqcFqWGzZD7NrAP3D8z0cLFqHbfeJoYQChHzo21+AFr2/wsy47xi
         cpDoQgakda0iq8T4681fsDzhKT7YQDnZ51hyzmWkRmCANv8DGCLqSWvJwKb2L/olkxXQ
         Z6Dv3zcKYP0JwbgKk2bY+1eIYP0/IwcJBii3RZUKnYlxEceZhWcom0DtkZNcIgIOPXIs
         d35A==
X-Gm-Message-State: AOAM5339NoOyvcEAvlE1q/wbOtMUBYfROJzVJ6hnnXSI+HSamX5o+hlI
        ARUcx0bKKOQyG7iwgtCtnDjIL712vx08r0Yf9qrz0VMdKIwoTQ==
X-Google-Smtp-Source: ABdhPJzOXOyeVgHecXY+yYdUMmZi1Kh2SAby+9mebJ7RaTmJRac6fpN0YXMxCQgkQAEYbBE515q2O1tZ088euwgZHdc=
X-Received: by 2002:a05:620a:20ca:: with SMTP id f10mr22371359qka.426.1618260610049;
 Mon, 12 Apr 2021 13:50:10 -0700 (PDT)
MIME-Version: 1.0
From:   Peter Geis <pgwipeout@gmail.com>
Date:   Mon, 12 Apr 2021 16:49:59 -0400
Message-ID: <CAMdYzYrQ5f-mv_VmTq_CRf9tR=j3mwRpKHNLmPFgCF9whsGFRw@mail.gmail.com>
Subject: [RFC] ITS fails to allocate on rk3568/rk3566
To:     Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <maz@kernel.org>
Cc:     "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Good Afternoon,

I am assisting with early bringup of the rk3566 based quartz64
development board for mainline linux.
I've encountered a few issues with allocating ITS on their version of
the GIC-V3.
The first issue is the ITS controller can only use 32bit addresses.
This leads to the following error:
[    0.000000] NR_IRQS: 64, nr_irqs: 64, preallocated irqs: 0
[    0.000000] GICv3: GIC: Using split EOI/Deactivate mode
[    0.000000] GICv3: 320 SPIs implemented
[    0.000000] GICv3: 0 Extended SPIs implemented
[    0.000000] GICv3: Distributor has no Range Selector support
[    0.000000] Root IRQ handler: gic_handle_irq
[    0.000000] GICv3: 16 PPIs implemented
[    0.000000] GICv3: CPU0: found redistributor 0 region 0:0x00000000fd460000
[    0.000000] ITS [mem 0xfd440000-0xfd45ffff]
[    0.000000] ITS@0x00000000fd440000: Devices doesn't stick:
f907000100190600 f907000000190600
[    0.000000] ITS@0x00000000fd440000: failed probing (-6)
[    0.000000] ITS: No ITS available, not enabling LPIs

Downstream fixed this by adding the GFP_DMA32 flag to the memory allocations.
They also force clear the GITS_BASER_SHAREABILITY_MASK.
Unfortunately while this allowed ITS to allocate on downstream, as
soon as MSIs attempted to use it all interrupts would time out.

On upstream, we observe this during allocation:
[    0.000000] ITS [mem 0xfd440000-0xfd45ffff]
[    0.000000] ITS@0x00000000fd440000: allocated 8192 Devices @3810000
(indirect, esz 8, psz 64K, shr 1)
[    0.000000] ITS@0x00000000fd440000: allocated 32768 Interrupt
Collections @3820000 (flat, esz 2, psz 64K, shr 1)
[    0.000000] GICv3: using LPI property table @0x0000000003830000
[    0.000000] GICv3: CPU0: using allocated LPI pending table
@0x0000000003840000
[    0.000000] ITS queue timeout (64 1)
[    0.000000] ITS cmd its_build_mapc_cmd failed
[    0.000000] ITS queue timeout (96 1)
[    0.000000] ITS cmd its_build_invall_cmd failed
<snip>
[    0.150282] Platform MSI: interrupt-controller@fd440000 domain created
[    0.152409] PCI/MSI:
/interrupt-controller@fd400000/interrupt-controller@fd440000 domain
created
[    0.156158] EFI services will not be available.
[    0.161168] smp: Bringing up secondary CPUs ...
[    0.170252] Detected VIPT I-cache on CPU1
[    0.170325] GICv3: CPU1: found redistributor 100 region 0:0x00000000fd480000
[    0.170356] GICv3: GIC_READ_PMR old_pmr=0xf0
[    0.170371] GICv3: GIC_READ_PMR new_pmr=0x0
[    0.170393] GICv3: CPU1: using allocated LPI pending table
@0x0000000003850000
[    1.686709] ITS queue timeout (160 1)
[    1.686733] ITS cmd its_build_mapc_cmd failed
[    3.202979] ITS queue timeout (192 1)
[    3.202999] ITS cmd its_build_invall_cmd failed
[    3.203157] CPU1: Booted secondary processor 0x0000000100 [0x412fd050]
[    3.208303] Callback from call_rcu_tasks_rude() invoked.
[    3.228487] Detected VIPT I-cache on CPU2
[    3.228559] GICv3: CPU2: found redistributor 200 region 0:0x00000000fd4a0000
[    3.228590] GICv3: GIC_READ_PMR old_pmr=0xf0
[    3.228606] GICv3: GIC_READ_PMR new_pmr=0x0
[    3.228630] GICv3: CPU2: using allocated LPI pending table
@0x0000000003860000
[    4.744675] ITS queue timeout (256 1)
[    4.744698] ITS cmd its_build_mapc_cmd failed
[    6.260797] ITS queue timeout (288 1)
[    6.260816] ITS cmd its_build_invall_cmd failed
[    6.260948] CPU2: Booted secondary processor 0x0000000200 [0x412fd050]
[    6.269204] Callback from call_rcu_tasks() invoked.
[    6.278358] Detected VIPT I-cache on CPU3
[    6.278430] GICv3: CPU3: found redistributor 300 region 0:0x00000000fd4c0000
[    6.278460] GICv3: GIC_READ_PMR old_pmr=0xf0
[    6.278476] GICv3: GIC_READ_PMR new_pmr=0x0
[    6.278501] GICv3: CPU3: using allocated LPI pending table
@0x0000000003870000
[    7.794367] ITS queue timeout (352 1)
[    7.794390] ITS cmd its_build_mapc_cmd failed
[    9.310219] ITS queue timeout (384 1)
[    9.310237] ITS cmd its_build_invall_cmd failed
[    9.310368] CPU3: Booted secondary processor 0x0000000300 [0x412fd050]
[    9.311925] smp: Brought up 1 node, 4 CPUs
[    9.318831] SMP: Total of 4 processors activated.

Also, when MSIs activate the same timeouts seen downstream happen:
[   13.884698] pci 0000:00:00.0: PCI bridge to [bus 01-ff]
[   13.886476] pcieport 0000:00:00.0: of_irq_parse_pci: failed with rc=-22
[   13.887466] pcieport 0000:00:00.0: assign IRQ: got 0
[   15.414727] ITS queue timeout (416 1)
[   15.415476] ITS cmd its_build_mapd_cmd failed
[   16.957519] ITS queue timeout (480 1)
[   16.958040] ITS cmd its_build_mapti_cmd failed
[   18.482251] ITS queue timeout (544 1)
[   18.482762] ITS cmd its_build_mapti_cmd failed
<snip>
[   70.267783] ITS queue timeout (2656 1)
[   70.268363] ITS cmd its_build_inv_cmd failed
[   70.269782] pcieport 0000:00:00.0: PME: Signaling with IRQ 64

Any assistance you can provide would be greatly appreciated.

Very Respectfully,
Peter Geis
