Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 175BB3673D9
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 21:58:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245583AbhDUT7A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 15:59:00 -0400
Received: from foss.arm.com ([217.140.110.172]:40832 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244346AbhDUT66 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 15:58:58 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 16F9F11D4;
        Wed, 21 Apr 2021 12:58:25 -0700 (PDT)
Received: from e113632-lin (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CF0B33F774;
        Wed, 21 Apr 2021 12:58:23 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Beata Michalska <beata.michalska@arm.com>,
        linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        corbet@lwn.net, linux-doc@vger.kernel.org
Subject: Re: [RFC PATCH 0/3] Rework CPU capacity asymmetry detection
In-Reply-To: <1618578085-29584-1-git-send-email-beata.michalska@arm.com>
References: <1618578085-29584-1-git-send-email-beata.michalska@arm.com>
Date:   Wed, 21 Apr 2021 20:58:21 +0100
Message-ID: <87zgxrtnoi.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/04/21 14:01, Beata Michalska wrote:
> Verified on (mostly):
>     - QEMU (version 4.2.1) with variants of possible asymmetric topologies
>       - machine: virt
>       - modifying the device-tree 'cpus' node for virt machine:
>
>       qemu-system-aarch64 -kernel $KERNEL_IMG
>           -drive format=qcow2,file=$IMAGE
>           -append 'root=/dev/vda earlycon console=ttyAMA0 sched_debug
>            loglevel=15 kmemleak=on' -m 2G  --nographic  -cpu cortex-a57
>           -machine virt -smp cores=6 -machine dumpdtb=$CUSTOM_DTB.dtb
>
>       $KERNEL_PATH/scripts/dtc/dtc -I dtb -O dts $CUSTOM_DTB.dts >
>       $CUSTOM_DTB.dtb
>
>       (modify the dts)
>
>       $KERNEL_PATH/scripts/dtc/dtc -I dts -O dtb $CUSTOM_DTB.dts >
>       $CUSTOM_DTB.dtb
>
>       qemu-system-aarch64 -kernel $KERNEL_IMG
>           -drive format=qcow2,file=$IMAGE
>           -append 'root=/dev/vda earlycon console=ttyAMA0 sched_debug
>            loglevel=15 kmemleak=on' -m 2G  --nographic  -cpu cortex-a57
>           -machine virt -smp cores=6 -machine dtb=$CUSTOM_DTB.dtb
>

Thanks to your QEMU wizardry, I've also tested this on a few funky
topologies such as:

  DIE [                     ]
  MC  [       ][            ]
       0  1  2  3  4  5  6  7
       L  L  M  L  L  M  B  B

and

  DIE [                ]
  MC  [          ][    ]
       0  1  2  3  4  5
       L  L  M  M  B  B

+ some hotplug ops, and the resulting SD_ flags all made sense to me.

Tested-by: Valentin Schneider <valentin.schneider@arm.com>

For patches 1, 3:
Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>

>
> Beata Michalska (3):
>   sched/core: Introduce SD_ASYM_CPUCAPACITY_FULL sched_domain flag
>   sched/topology: Rework CPU capacity asymmetry detection
>   sched/doc: Update the CPU capacity asymmetry bits
>
>  Documentation/scheduler/sched-capacity.rst |   6 +-
>  Documentation/scheduler/sched-energy.rst   |   2 +-
>  include/linux/sched/sd_flags.h             |  10 +
>  kernel/sched/topology.c                    | 339 +++++++++++++++++++++++++----
>  4 files changed, 314 insertions(+), 43 deletions(-)
>
> --
> 2.7.4
