Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E449D3DD4A9
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 13:27:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233423AbhHBL1n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 07:27:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:33668 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233255AbhHBL10 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 07:27:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 59C1A60FC2;
        Mon,  2 Aug 2021 11:27:15 +0000 (UTC)
Date:   Mon, 2 Aug 2021 12:27:12 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        coresight@lists.linaro.org, anshuman.khandual@arm.com,
        will@kernel.org, james.morse@arm.com, mathieu.poirier@linaro.org,
        mike.leach@linaro.org, leo.yan@linaro.org, maz@kernel.org,
        mark.rutland@arm.com
Subject: Re: [PATCH 10/10] arm64: errata: Add workaround for TSB flush
 failures
Message-ID: <20210802112712.GE18685@arm.com>
References: <20210728135217.591173-1-suzuki.poulose@arm.com>
 <20210728135217.591173-11-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210728135217.591173-11-suzuki.poulose@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 28, 2021 at 02:52:17PM +0100, Suzuki K Poulose wrote:
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

With Marc's comments addressed:

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
