Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C740A35C9FC
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 17:33:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242736AbhDLPdZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 11:33:25 -0400
Received: from foss.arm.com ([217.140.110.172]:53680 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238770AbhDLPdY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 11:33:24 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DBFA111FB;
        Mon, 12 Apr 2021 08:33:05 -0700 (PDT)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4EDB73F694;
        Mon, 12 Apr 2021 08:33:04 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Ruifeng Zhang <ruifeng.zhang0110@gmail.com>
Cc:     linux@armlinux.org.uk, sudeep.holla@arm.com,
        Greg KH <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>, a.p.zijlstra@chello.nl,
        dietmar.eggemann@arm.com, mingo@kernel.org,
        ruifeng.zhang1@unisoc.com, nianfu.bai@unisoc.com,
        linux-arm-kernel@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] arm: topology: parse the topology from the dt
In-Reply-To: <CAG7+-3MsjuChoEOj11VAMX9W61UY6MmphkxWDF=-_R1A8sfvpA@mail.gmail.com>
References: <20210412070819.23493-1-ruifeng.zhang0110@gmail.com> <87y2dnn3gw.mognet@arm.com> <CAG7+-3MsjuChoEOj11VAMX9W61UY6MmphkxWDF=-_R1A8sfvpA@mail.gmail.com>
Date:   Mon, 12 Apr 2021 16:32:57 +0100
Message-ID: <87tuobmsba.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/04/21 20:20, Ruifeng Zhang wrote:
> There is a armv8.3 cpu which should work normally both on aarch64 and aarch32.
> The MPIDR has been written to the chip register in armv8.3 format.
> For example,
> core0: 0000000080000000
> core1: 0000000080000100
> core2: 0000000080000200
> ...
>
> Its cpu topology can be parsed normally on aarch64 mode (both
> userspace and kernel work on arm64).
>
> The problem is when it working on aarch32 mode (both userspace and
> kernel work on arm 32-bit),

I didn't know using aarch32 elsewhere than EL0 was something actually being
used. Do you deploy this somewhere, or do you use it for testing purposes?

> the cpu topology
> will parse error because of the format is different between armv7 and armv8.3.
> The arm 32-bit driver, arch/arm/kernel/topology will parse the MPIDR
> and store to the topology with armv7,
> and the result is all cpu core_id is 0, the bit[1:0] of armv7 MPIDR format.
>

I'm not fluent at all in armv7 (or most aarch32 compat mode stuff), but
I couldn't find anything about MPIDR format differences:

  DDI 0487G.a G8.2.113
  """
  AArch32 System register MPIDR bits [31:0] are architecturally mapped to
  AArch64 System register MPIDR_EL1[31:0].
  """

Peeking at some armv7 doc and arm/kernel/topology.c the layout really looks
just the same, i.e. for both of them, with your example of:

  core0: 0000000080000000
  core1: 0000000080000100
  core2: 0000000080000200
  ...

we'll get:

  |       | aff2 | aff1 | aff0 |
  |-------+------+------+------|
  | Core0 |    0 |    0 |    0 |
  | Core1 |    0 |    1 |    0 |
  | Core2 |    0 |    2 |    0 |
      ...

Now, arm64 doesn't fallback to MPIDR for topology information anymore since

  3102bc0e6ac7 ("arm64: topology: Stop using MPIDR for topology information")

so without DT we would get:
  |       | package_id | core_id |
  |-------+------------+---------|
  | Core0 |          0 |       0 |
  | Core1 |          0 |       1 |
  | Core2 |          0 |       2 |

Whereas with an arm kernel we'll end up parsing MPIDR as:
  |       | package_id | core_id |
  |-------+------------+---------|
  | Core0 |          0 |       0 |
  | Core1 |          1 |       0 |
  | Core2 |          2 |       0 |

Did I get this right? Is this what you're observing?

> In addition, I think arm should also allow customers to configure cpu
> topologies via DT.
