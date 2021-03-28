Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C1DC34BD8C
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Mar 2021 19:22:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231367AbhC1RWC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Mar 2021 13:22:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:58486 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230451AbhC1RVx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Mar 2021 13:21:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 29DA16197E;
        Sun, 28 Mar 2021 17:21:51 +0000 (UTC)
Date:   Sun, 28 Mar 2021 18:21:48 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Chen Lifu <chenlifu@huawei.com>
Cc:     will@kernel.org, valentin.schneider@arm.com, maz@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        heying24@huawei.com, yuehaibing@huawei.com, weiyongjun1@huawei.com,
        johnny.chenyi@huawei.com
Subject: Re: [PATCH -next] arm64: smp: Add missing prototype for some smp.c
 functions
Message-ID: <20210328172147.GA19252@arm.com>
References: <20210327070651.70773-1-chenlifu@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210327070651.70773-1-chenlifu@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 27, 2021 at 03:06:51PM +0800, Chen Lifu wrote:
> In commit eb631bb5bf5b
> ("arm64: Support arch_irq_work_raise() via self IPIs") a new
> function "arch_irq_work_raise" was added without a prototype
> in header irq_work.h
> 
> In commit d914d4d49745
> ("arm64: Implement panic_smp_self_stop()") a new
> function "panic_smp_self_stop" was added without a prototype
> in header irq_work.h
> 
> We get the following warnings on W=1:
> arch/arm64/kernel/smp.c:842:6: warning: no previous prototype
> for ‘arch_irq_work_raise’ [-Wmissing-prototypes]
> arch/arm64/kernel/smp.c:862:6: warning: no previous prototype
> for ‘panic_smp_self_stop’ [-Wmissing-prototypes]
> 
> Fix the same by adding the missing prototype in header irq_work.h
> 
> Signed-off-by: Chen Lifu <chenlifu@huawei.com>
> ---
>  arch/arm64/include/asm/irq_work.h | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/arm64/include/asm/irq_work.h b/arch/arm64/include/asm/irq_work.h
> index a1020285ea75..f766e2190e7c 100644
> --- a/arch/arm64/include/asm/irq_work.h
> +++ b/arch/arm64/include/asm/irq_work.h
> @@ -2,6 +2,9 @@
>  #ifndef __ASM_IRQ_WORK_H
>  #define __ASM_IRQ_WORK_H
>  
> +extern void arch_irq_work_raise(void);
> +extern void panic_smp_self_stop(void);

The second prototype makes more sense in arch/arm64/include/asm/smp.h
where we already have crash_smp_send_stop().

-- 
Catalin
