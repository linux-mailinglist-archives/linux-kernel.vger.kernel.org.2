Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6135935C535
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 13:32:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240469AbhDLLc1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 07:32:27 -0400
Received: from foss.arm.com ([217.140.110.172]:47650 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237792AbhDLLcV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 07:32:21 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CDDA731B;
        Mon, 12 Apr 2021 04:32:02 -0700 (PDT)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3EDEC3F694;
        Mon, 12 Apr 2021 04:32:01 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Ruifeng Zhang <ruifeng.zhang0110@gmail.com>, linux@armlinux.org.uk,
        sudeep.holla@arm.com, gregkh@linuxfoundation.org,
        rafael@kernel.org, a.p.zijlstra@chello.nl,
        dietmar.eggemann@arm.com, mingo@kernel.org,
        ruifeng.zhang1@unisoc.com, nianfu.bai@unisoc.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] arm: topology: parse the topology from the dt
In-Reply-To: <20210412070819.23493-1-ruifeng.zhang0110@gmail.com>
References: <20210412070819.23493-1-ruifeng.zhang0110@gmail.com>
Date:   Mon, 12 Apr 2021 12:31:59 +0100
Message-ID: <87y2dnn3gw.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

On 12/04/21 15:08, Ruifeng Zhang wrote:
> From: Ruifeng Zhang <ruifeng.zhang1@unisoc.com>
>
> The arm topology still parse from the MPIDR, but it is incomplete.  When
> the armv8.3 cpu runs in aarch32 mode, it will parse out the wrong topology.
>
> armv7 (A7) mpidr is:
> [11:8]      [7:2]       [1:0]
> cluster     reserved    cpu
>
> armv8.3 (A55) mpidr is:
> [23:16]     [15:8]      [7:0]
> cluster     cpu         thread
>
> For compatibility to keep the function of get capacity from default
> cputype, renamed arm parse_dt_topology to get_cputype_capacity and delete
> related logic of parse from dt.
> Arm using the same parse_dt_topology function as arm64.
>
> The arm device boot step is to look for the default cputype and get cpu
> capacity firstly. Then parse the topology and capacity from dt to replace
> default values.
>

I'm afraid I don't get it.

CONFIG_COMPAT lets you run 32-bit stuff at EL0, but the kernel is still
arm64. So if you take your armv8.3 system, the topology parsed by the
kernel will be the same regardless of CONFIG_COMPAT.

Could you elaborate on what problem you are trying to fix here?
