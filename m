Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B035435F399
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 14:29:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350934AbhDNMYN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 08:24:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350859AbhDNMYD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 08:24:03 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EE13C061574
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 05:23:40 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id z22so4869497plo.3
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 05:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=n3pHnVtAOKVgWlmpjzwHGBjJQ2oe6Bu+ftIq6phBBzg=;
        b=CO/FOwZNC5/3FmISgRfsUJ/HWXpfAy67sm+Qr+++Zj8fxDGB2XuJ89mvEdgbcdNtvZ
         i+7r6UwFPjXfky+TI6xGLMu5hkYDgCSF7CffuAceCmbgKHzrTb7UxOr8SicS+UeFdNq7
         eMirKvduK8yXw9LexegqPtzg2Iv79fV4eySX+M7UxZXrk9kqHmQBw4AildGafZz8IzNs
         dR0OJhWUw45oQdwmBNm9oclmms6cjBlkJo+M8XkgjswwFP/AdMU2kYiMSyO5J/xWY5cb
         Gj/lmiiq6KMn95q89yyMJzMzdVRrzmAatfuYiZ4YdLm1UcQem4MNCyOIx2o6L5r4OHeC
         N2/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=n3pHnVtAOKVgWlmpjzwHGBjJQ2oe6Bu+ftIq6phBBzg=;
        b=VXnAqrHMt6FWGP7/1OzwHqDJhbCpZl+Vhd3x1o+zh4eIGwUzUlowNeT+p8eN4Uu5Ll
         ujh56iGv2UFgpoxDRlxdHpBHb7s7yeSkua/k4QX3qXQmNhnYokLiXm0YB7iRRoxkJKyj
         sK7j57rpz0n/31Sl7PlG7RrrQRdKm+10V4qe3f//G7vcvEi3vIYtU5JCWhMtAAKXS0dC
         JG7dYTrO3lKlIJ/rkrbbxl4g4j2hC3u+2biiCZBcEJLS2vbx0mLXzTVH2nn7IWI+/foz
         Htr64TsbSqMBVTgQ1wcwqMuGdd87K0mnPWSbNR/w32i1RKecCE4LdfONSO83VxwdP6Q7
         XD6Q==
X-Gm-Message-State: AOAM531D7n2tZ02jzSChMzqAJM3/CRAnsLEFinFnh9cJb/p7lzo0SOdO
        v58l6wiRjqVl/geX2TkAN+A=
X-Google-Smtp-Source: ABdhPJxY/tWfI5VrxCDSd1CFA0SysjfsU4Lny2nr4o+RfFBl8ipt66jbyIOx5Ii4GjieliGRV9ldig==
X-Received: by 2002:a17:902:74c2:b029:e9:a966:2e1b with SMTP id f2-20020a17090274c2b02900e9a9662e1bmr20751200plt.43.1618403019410;
        Wed, 14 Apr 2021 05:23:39 -0700 (PDT)
Received: from Ruifeng.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id mz18sm4960413pjb.13.2021.04.14.05.23.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Apr 2021 05:23:38 -0700 (PDT)
From:   Ruifeng Zhang <ruifeng.zhang0110@gmail.com>
To:     linux@armlinux.org.uk, sudeep.holla@arm.com,
        gregkh@linuxfoundation.org, rafael@kernel.org,
        a.p.zijlstra@chello.nl, dietmar.eggemann@arm.com, mingo@kernel.org,
        valentin.schneider@arm.com, ruifeng.zhang1@unisoc.com,
        nianfu.bai@unisoc.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/1] arm: topology: parse the topology from the dt
Date:   Wed, 14 Apr 2021 20:23:25 +0800
Message-Id: <20210414122326.5255-1-ruifeng.zhang0110@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ruifeng Zhang <ruifeng.zhang1@unisoc.com>

In Unisoc, the sc9863a SoC which using cortex-a55, it has two software
version, one of them is the kernel running on EL1 using aarch32.
                user(EL0)             kernel(EL1)
sc9863a_go      aarch32               aarch32
sc9863a         aarch64               aarch64

When kernel runs on EL1 using aarch32, the topology will parse wrong.
For example,
The MPIDR has been written to the chip register in armv8.2 format.
For example,
core0: 0000000080000000
core1: 0000000080000100
core2: 0000000080000200
...

It will parse to:
|       | aff2 | packageid | coreid |
|-------+------+-----------+--------|
| Core0 |    0 |         0 |    0   |
| Core1 |    0 |         1 |    0   |
| Core2 |    0 |         2 |    0   |
|  ...  |      |           |        |

The wrong topology is that all of the coreid are 0 and unexpected
packageid.

The reason is the MPIDR format is different between armv7 and armv8.2.
armv7 (A7) mpidr is:
[11:8]      [7:2]       [1:0]
cluster     reserved    cpu
The cortex-a7 spec DDI0464F 4.3.5
https://developer.arm.com/documentation/ddi0464/f/?lang=en

armv8.2 (A55) mpidr is:
[23:16]     [15:8]      [7:0]
cluster     cpu         thread

The current arch/arm/kernel/topology code parse the MPIDR with a armv7
format. The parse code is:
void store_cpu_topology(unsigned int cpuid)
{
    ...
    cpuid_topo->thread_id = -1;
    cpuid_topo->core_id = MPIDR_AFFINITY_LEVEL(mpidr, 0);
    cpuid_topo->package_id = MPIDR_AFFINITY_LEVEL(mpidr, 1);
    ...
}

Ruifeng Zhang (1):
  arm: topology: parse the topology from the dt

 arch/arm/kernel/topology.c    | 22 ++++++----------------
 drivers/base/arch_topology.c  |  4 ++--
 include/linux/arch_topology.h |  1 +
 3 files changed, 9 insertions(+), 18 deletions(-)

-- 
2.17.1

