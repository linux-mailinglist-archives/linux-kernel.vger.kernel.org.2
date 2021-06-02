Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F2CA3986FC
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 12:53:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230314AbhFBKyo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 06:54:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbhFBKyn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 06:54:43 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B674C061574
        for <linux-kernel@vger.kernel.org>; Wed,  2 Jun 2021 03:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=iDBIURM5kgTiq51sI9dk7wb4eYi3ZtbjT3fobwqaHD8=; b=mEbMc+afiLjvbvFTvm5AJVuDQ
        m75xu+nPbDxutrccK4S2pxs/ZuN46QWGfbtyDx3EAmQJXIs9rZ1sXxFKkR9bOcAIeMJLT4zwa4YYQ
        87xhr6kEYu9Sk+xpJvSOSu8s7gVGy6z+WHpS0iSxbkT+ZSAriegQPS483tdb/w+8r+gOUNCaV43QG
        QinDhaYp660YazDb6rcWQ/WPXE9dZZIXne2QpjMw7F/d1APUsUa4oDH2eO4vbQiy/BzmOXakKA6t5
        DaQj6kjqM0iKqvvDupYSpBYXJZzP2TrCa8lZrM9maZSoJ3KxYHl7VcgXQ6T+6RVa4jLsMQKMAwB0x
        k0FyWYwFA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:44622)
        by pandora.armlinux.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <linux@armlinux.org.uk>)
        id 1loOUa-00013y-NV; Wed, 02 Jun 2021 11:52:56 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1loOUa-00014f-17; Wed, 02 Jun 2021 11:52:56 +0100
Date:   Wed, 2 Jun 2021 11:52:56 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Jungseung Lee <js07.lee@gmail.com>
Subject: Re: [PATCH v2 7/7] ARM: mm: Fix PXN process with LPAE feature
Message-ID: <20210602105255.GK30436@shell.armlinux.org.uk>
References: <20210602070246.83990-1-wangkefeng.wang@huawei.com>
 <20210602070246.83990-8-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210602070246.83990-8-wangkefeng.wang@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Jun 02, 2021 at 03:02:46PM +0800, Kefeng Wang wrote:
> When user code execution with privilege mode, it will lead to
> infinite loop in the page fault handler if ARM_LPAE enabled,
> 
> The issue could be reproduced with
>   "echo EXEC_USERSPACE > /sys/kernel/debug/provoke-crash/DIRECT"
> 
> Lets' fix it by adding the check in do_page_fault() and panic
> when ARM_LPAE enabled.
> 
> Fixes: 1d4d37159d01 ("ARM: 8235/1: Support for the PXN CPU feature on ARMv7")
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---
>  arch/arm/mm/fault.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mm/fault.c b/arch/arm/mm/fault.c
> index 7cfa9a59d3ec..279bbeb33b48 100644
> --- a/arch/arm/mm/fault.c
> +++ b/arch/arm/mm/fault.c
> @@ -257,8 +257,14 @@ do_page_fault(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
>  		vm_flags = VM_WRITE;
>  	}
>  
> -	if (fsr & FSR_LNX_PF)
> +	if (fsr & FSR_LNX_PF) {
>  		vm_flags = VM_EXEC;
> +#ifdef CONFIG_ARM_LPAE
> +		if (addr && addr < TASK_SIZE && !user_mode(regs))
> +			die_kernel_fault("execution of user memory",
> +					 addr, fsr, regs);
> +#endif
> +	}

Do we need to do this test here?

Also, is this really LPAE specific? We have similar protection on 32-bit
ARM using domains to disable access to userspace except when the user
accessors are being used, so I would expect kernel-mode execution to
also cause a fault there.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
