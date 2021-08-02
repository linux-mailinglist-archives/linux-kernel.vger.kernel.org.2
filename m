Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5FBD3DD496
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 13:22:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233445AbhHBLWt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 07:22:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:59052 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233243AbhHBLWt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 07:22:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E646C60F36;
        Mon,  2 Aug 2021 11:22:37 +0000 (UTC)
Date:   Mon, 2 Aug 2021 12:22:35 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        coresight@lists.linaro.org, anshuman.khandual@arm.com,
        will@kernel.org, james.morse@arm.com, mathieu.poirier@linaro.org,
        mike.leach@linaro.org, leo.yan@linaro.org, maz@kernel.org,
        mark.rutland@arm.com
Subject: Re: [PATCH 07/10] arm64: Add erratum detection for TRBE overwrite in
 FILL mode
Message-ID: <20210802112235.GC18685@arm.com>
References: <20210728135217.591173-1-suzuki.poulose@arm.com>
 <20210728135217.591173-8-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210728135217.591173-8-suzuki.poulose@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 28, 2021 at 02:52:14PM +0100, Suzuki K Poulose wrote:
> Arm Neoverse-N2 and the Cortex-A710 cores are affected
> by a CPU erratum where the TRBE will overwrite the trace buffer
> in FILL mode. The TRBE doesn't stop (as expected in FILL mode)
> when it reaches the limit and wraps to the base to continue
> writing upto 3 cache lines. This will overwrite any trace that
> was written previously.
> 
> Add the Neoverse-N2 erratumi(#2139208) and Cortex-A710 erratum
> (#2119858) to the  detection logic.
> 
> This will be used by the TRBE driver in later patches to work
> around the issue. The detection has been kept with the core
> arm64 errata framework list to make sure :
>   - We don't duplicate the framework in TRBE driver
>   - The errata detection is advertised like the rest
>     of the CPU errata.
> 
> Note that the Kconfig entries will be added after we have added
> the work around in the TRBE driver, which depends on the cpucap
> from here.
> 
> Cc: Will Deacon <will@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Anshuman Khandual <anshuman.khandual@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Cc: Mike Leach <mike.leach@linaro.org>
> cc: Leo Yan <leo.yan@linaro.org>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
