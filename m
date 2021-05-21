Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54DFE38C2CE
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 11:13:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235731AbhEUJO0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 05:14:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:52852 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232804AbhEUJOV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 05:14:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4DFAE613C4;
        Fri, 21 May 2021 09:12:57 +0000 (UTC)
Date:   Fri, 21 May 2021 10:12:54 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     psodagud@codeaurora.org
Cc:     will@kernel.org, Dave.Martin@arm.com, amit.kachhap@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: Re: sve_user_discard
Message-ID: <20210521091254.GA6675@arm.com>
References: <785d7bc29da6bff0dceeb712c24601fd@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <785d7bc29da6bff0dceeb712c24601fd@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 20, 2021 at 04:02:03PM -0700, psodagud@codeaurora.org wrote:
> This is regarding sve_user_disable(CPACR_EL1_ZEN_EL0EN) on every system
> call.  If a userspace task is using SVE instructions and making sys calls in
> between, it would impact the performance of the thread. On every SVE
> instructions after SVC/system call, it would trap to EL1.
> 
> I think by setting CPACR_EL1_ZEN_EL0EN flag,  the processor faults when it
> runs an SVE instruction. This approach may be taken as part of FPSIMD
> registers switching optimizations.  Can below portion of the code use
> thread.fpsimd_cpu and fpsimd_last_state variables to avoid clearing
> CPACR_EL1_ZEN_EL0EN for this kind of use cases?

There were attempts over the past couple of years to optimise the
syscall return use-case. I think the latest is this one:

https://lore.kernel.org/r/20201106193553.22946-2-broonie@kernel.org

I'll let Mark comment on his plans for reviving the series. Do you
happen to have some realistic workload that would be improved by this?
We can always write a micro-benchmark but I wonder how much this matters
in the real world.

-- 
Catalin
