Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95CBC42FAA7
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 20:00:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242375AbhJOSCL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 14:02:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:60294 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237569AbhJOSCJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 14:02:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2116361212;
        Fri, 15 Oct 2021 18:00:01 +0000 (UTC)
Date:   Fri, 15 Oct 2021 18:59:58 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Xiongfeng Wang <wangxiongfeng2@huawei.com>
Cc:     mark.rutland@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        moyufeng@huawei.com
Subject: Re: [RFC PATCH v2] arm64: barrier: add macro dgh() to control memory
 accesses merging
Message-ID: <YWnBngJeIvV2S5IB@arm.com>
References: <20211015090511.92421-1-wangxiongfeng2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211015090511.92421-1-wangxiongfeng2@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 15, 2021 at 05:05:11PM +0800, Xiongfeng Wang wrote:
> diff --git a/arch/arm64/include/asm/barrier.h b/arch/arm64/include/asm/barrier.h
> index 451e11e5fd23..d71a7457d619 100644
> --- a/arch/arm64/include/asm/barrier.h
> +++ b/arch/arm64/include/asm/barrier.h
> @@ -18,6 +18,14 @@
>  #define wfe()		asm volatile("wfe" : : : "memory")
>  #define wfi()		asm volatile("wfi" : : : "memory")
>  
> +/*
> + * Data Gathering Hint:
> + * This instruction prohibits merging memory accesses with Normal-NC or
> + * Device-GRE attributes before the hint instruction with any memory accesses
> + * appearing after the hint instruction.
> + */
> +#define dgh()		asm volatile("hint #6" : : : "memory")

On its own, this patch doesn't do anything. It's more interesting to see
how it will be used and maybe come up with a common name that other
architectures would share (or just implement as no-opp). I'm not sure
there was any conclusion last time we discussed this.

-- 
Catalin
