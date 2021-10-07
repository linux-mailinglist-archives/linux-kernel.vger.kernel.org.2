Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 887CF425765
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 18:10:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241873AbhJGQMR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 12:12:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:59790 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232589AbhJGQMQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 12:12:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6CB9D61074;
        Thu,  7 Oct 2021 16:10:20 +0000 (UTC)
Date:   Thu, 7 Oct 2021 17:10:18 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        maz@kernel.org, mark.rutland@arm.com, james.morse@arm.com,
        anshuman.khandual@arm.com, leo.yan@linaro.org,
        mike.leach@linaro.org, mathieu.poirier@linaro.org, will@kernel.org,
        lcherian@marvell.com, coresight@lists.linaro.org
Subject: Re: [PATCH v2 11/17] arm64: errata: Add workaround for TSB flush
 failures
Message-ID: <YV8b6nreysjpl0nL@arm.com>
References: <20210921134121.2423546-1-suzuki.poulose@arm.com>
 <20210921134121.2423546-12-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210921134121.2423546-12-suzuki.poulose@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 21, 2021 at 02:41:15PM +0100, Suzuki K Poulose wrote:
> Arm Neoverse-N2 (#2067961) and Cortex-A710 (#2054223) suffers
> from errata, where a TSB (trace synchronization barrier)
> fails to flush the trace data completely, when executed from
> a trace prohibited region. In Linux we always execute it
> after we have moved the PE to trace prohibited region. So,
> we can apply the workaround everytime a TSB is executed.
> 
> The work around is to issue two TSB consecutively.
> 
> NOTE: This errata is defined as LOCAL_CPU_ERRATUM, implying
> that a late CPU could be blocked from booting if it is the
> first CPU that requires the workaround. This is because we
> do not allow setting a cpu_hwcaps after the SMP boot. The
> other alternative is to use "this_cpu_has_cap()" instead
> of the faster system wide check, which may be a bit of an
> overhead, given we may have to do this in nvhe KVM host
> before a guest entry.
> 
> Cc: Will Deacon <will@kernel.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Cc: Mike Leach <mike.leach@linaro.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Anshuman Khandual <anshuman.khandual@arm.com>
> Cc: Marc Zyngier <maz@kernel.org>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
