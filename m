Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BC52361D85
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 12:09:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241943AbhDPJdL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 05:33:11 -0400
Received: from foss.arm.com ([217.140.110.172]:37234 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239848AbhDPJdK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 05:33:10 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D4A0F106F;
        Fri, 16 Apr 2021 02:32:45 -0700 (PDT)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4ACA53FA35;
        Fri, 16 Apr 2021 02:32:44 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Ruifeng Zhang <ruifeng.zhang0110@gmail.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     linux@armlinux.org.uk, sudeep.holla@arm.com,
        Greg KH <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>, a.p.zijlstra@chello.nl,
        mingo@kernel.org, ruifeng.zhang1@unisoc.com, nianfu.bai@unisoc.com,
        linux-arm-kernel@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 0/1] arm: topology: parse the topology from the dt
In-Reply-To: <CAG7+-3Nv=m0pd8t0eQEUv5zSeg86hfkKcs_VLzsbzWFabYbTTQ@mail.gmail.com>
References: <20210414122326.5255-1-ruifeng.zhang0110@gmail.com> <8735vrmnc7.mognet@arm.com> <b7a76995-f6c3-67c5-b14e-d40587495d7e@arm.com> <CAG7+-3Nv=m0pd8t0eQEUv5zSeg86hfkKcs_VLzsbzWFabYbTTQ@mail.gmail.com>
Date:   Fri, 16 Apr 2021 10:32:35 +0100
Message-ID: <87wnt2lglo.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/04/21 15:47, Ruifeng Zhang wrote:
> For more requirements, if all cores in one physical cluster, the
> {aff2} of all cores are the same value.
> i.e. the sc9863a,
> core0: 0000000081000000
> core1: 0000000081000100
> core2: 0000000081000200
> core3: 0000000081000300
> core4: 0000000081000400
> core5: 0000000081000500
> core6: 0000000081000600
> core7: 0000000081000700
>
> According to MPIDR all cores will parse to the one cluster, but it's
> the big.LITTLE system, it's need two logic cluster for schedule or
> cpufreq.
> So I think it's better to add the logic of parse topology from DT.

Ah, so it's a slightly different issue, but still one that requires a
different means of specifying topology.
