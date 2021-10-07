Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4A09425767
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 18:10:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241999AbhJGQMs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 12:12:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:60022 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241906AbhJGQMr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 12:12:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 121826103C;
        Thu,  7 Oct 2021 16:10:50 +0000 (UTC)
Date:   Thu, 7 Oct 2021 17:10:48 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        maz@kernel.org, mark.rutland@arm.com, james.morse@arm.com,
        anshuman.khandual@arm.com, leo.yan@linaro.org,
        mike.leach@linaro.org, mathieu.poirier@linaro.org, will@kernel.org,
        lcherian@marvell.com, coresight@lists.linaro.org
Subject: Re: [PATCH v2 15/17] arm64: Add erratum detection for TRBE write to
 out-of-range
Message-ID: <YV8cCBS1XWKLv+4G@arm.com>
References: <20210921134121.2423546-1-suzuki.poulose@arm.com>
 <20210921134121.2423546-16-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210921134121.2423546-16-suzuki.poulose@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 21, 2021 at 02:41:19PM +0100, Suzuki K Poulose wrote:
> Arm Neoverse-N2 and Cortex-A710 cores are affected by an erratum where the
> trbe, under some circumstances, might write upto 64bytes to an address after
> the Limit as programmed by the TRBLIMITR_EL1.LIMIT. This might -
> 
>   - Corrupt a page in the ring buffer, which may corrupt trace from a
>     previous session, consumed by userspace.
>   - Hit the guard page at the end of the vmalloc area and raise a fault.
> 
> To keep the handling simpler, we always leave the last page from the
> range, which TRBE is allowed to write. This can be achieved by ensuring
> that we always have more than a PAGE worth space in the range, while
> calculating the LIMIT for TRBE. And then the LIMIT pointer can be adjusted
> to leave the PAGE (TRBLIMITR.LIMIT -= PAGE_SIZE), out of the TRBE range
> while enabling it. This makes sure that the TRBE will only write to an area
> within its allowed limit (i.e, [head-head+size]) and we do not have to handle
> address faults within the driver.
> 
> Cc: Anshuman Khandual <anshuman.khandual@arm.com>
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Cc: Mike Leach <mike.leach@linaro.org>
> Cc: Leo Yan <leo.yan@linaro.org>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
