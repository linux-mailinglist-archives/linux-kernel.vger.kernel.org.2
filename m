Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E91F03611BD
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 20:09:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234492AbhDOSKD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 14:10:03 -0400
Received: from foss.arm.com ([217.140.110.172]:51992 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233916AbhDOSJ6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 14:09:58 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3E7F6106F;
        Thu, 15 Apr 2021 11:09:35 -0700 (PDT)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AA3313FA45;
        Thu, 15 Apr 2021 11:09:33 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Ruifeng Zhang <ruifeng.zhang0110@gmail.com>, linux@armlinux.org.uk,
        sudeep.holla@arm.com, gregkh@linuxfoundation.org,
        rafael@kernel.org, a.p.zijlstra@chello.nl,
        dietmar.eggemann@arm.com, mingo@kernel.org,
        ruifeng.zhang1@unisoc.com, nianfu.bai@unisoc.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/1] arm: topology: parse the topology from the dt
In-Reply-To: <20210414122326.5255-1-ruifeng.zhang0110@gmail.com>
References: <20210414122326.5255-1-ruifeng.zhang0110@gmail.com>
Date:   Thu, 15 Apr 2021 19:09:28 +0100
Message-ID: <8735vrmnc7.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/04/21 20:23, Ruifeng Zhang wrote:
> From: Ruifeng Zhang <ruifeng.zhang1@unisoc.com>
>
> In Unisoc, the sc9863a SoC which using cortex-a55, it has two software
> version, one of them is the kernel running on EL1 using aarch32.
>                 user(EL0)             kernel(EL1)
> sc9863a_go      aarch32               aarch32
> sc9863a         aarch64               aarch64
>
> When kernel runs on EL1 using aarch32, the topology will parse wrong.
> For example,
> The MPIDR has been written to the chip register in armv8.2 format.
> For example,
> core0: 0000000080000000
> core1: 0000000080000100
> core2: 0000000080000200
> ...
>
> It will parse to:
> |       | aff2 | packageid | coreid |
> |-------+------+-----------+--------|
> | Core0 |    0 |         0 |    0   |
> | Core1 |    0 |         1 |    0   |
> | Core2 |    0 |         2 |    0   |
> |  ...  |      |           |        |
>
> The wrong topology is that all of the coreid are 0 and unexpected
> packageid.
>
> The reason is the MPIDR format is different between armv7 and armv8.2.
> armv7 (A7) mpidr is:
> [11:8]      [7:2]       [1:0]
> cluster     reserved    cpu
> The cortex-a7 spec DDI0464F 4.3.5
> https://developer.arm.com/documentation/ddi0464/f/?lang=en
>
> armv8.2 (A55) mpidr is:
> [23:16]     [15:8]      [7:0]
> cluster     cpu         thread
>

What I had understood from our conversation was that there *isn't* a format
difference (at least for the bottom 32 bits) - arm64/kernel/topopology.c
would parse it the same, except that MPIDR parsing has been deprecated for
arm64.

The problem is that those MPIDR values don't match the actual topology. If
they had the MT bit set, i.e.

  core0: 0000000081000000
  core1: 0000000081000100
  core2: 0000000081000200

then it would be parsed as:

  |       | package_id | core_id | thread_id |
  |-------+------------+---------+-----------|
  | Core0 |          0 |       0 |         0 |
  | Core1 |          0 |       1 |         0 |
  | Core2 |          0 |       2 |         0 |

which would make more sense (wrt the actual, physical topology).
