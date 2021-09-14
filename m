Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A26540AB80
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 12:17:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231352AbhINKSe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 06:18:34 -0400
Received: from foss.arm.com ([217.140.110.172]:42444 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229968AbhINKSd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 06:18:33 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 89EC36D;
        Tue, 14 Sep 2021 03:17:16 -0700 (PDT)
Received: from C02TD0UTHF1T.local (unknown [10.57.21.233])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DD7763F59C;
        Tue, 14 Sep 2021 03:17:14 -0700 (PDT)
Date:   Tue, 14 Sep 2021 11:17:09 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Dan Li <ashimida@linux.alibaba.com>
Cc:     catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Laura Abbott <labbott@kernel.org>
Subject: Re: [PATCH] [RFC]arm64:Mark __stack_chk_guard as __ro_after_init
Message-ID: <20210914101709.GA29127@C02TD0UTHF1T.local>
References: <1631612642-102881-1-git-send-email-ashimida@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1631612642-102881-1-git-send-email-ashimida@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 14, 2021 at 05:44:02PM +0800, Dan Li wrote:
> __stack_chk_guard is setup once while init stage and never changed
> after that.
> 
> Although the modification of this variable at runtime will usually
> cause the kernel to crash (so dose the attacker), it should be marked
> as _ro_after_init, and it should not affect performance if it is
> placed in the ro_after_init section.
> 
> This should also be the case on the ARM platform, or am I missing
> something?
> 
> Signed-off-by: Dan Li <ashimida@linux.alibaba.com>

FWIW, this makes sense to me:

Acked-by: Mark Rutland <mark.rutland@arm.com>

Looking at the history, this was added to arm64 in commit:

  c0c264ae5112d1cd ("arm64: Add CONFIG_CC_STACKPROTECTOR")

... whereas __ro_after_init was introduced around 2 years later in
commit:

  c74ba8b3480da6dd ("arch: Introduce post-init read-only memory")

... so we weren't deliberately avoiding __ro_after_init, and there are
probably a significant number of other variables we could apply it to.

Mark.

> ---
>  arch/arm64/kernel/process.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
> index c8989b9..c858b85 100644
> --- a/arch/arm64/kernel/process.c
> +++ b/arch/arm64/kernel/process.c
> @@ -60,7 +60,7 @@
>  
>  #if defined(CONFIG_STACKPROTECTOR) && !defined(CONFIG_STACKPROTECTOR_PER_TASK)
>  #include <linux/stackprotector.h>
> -unsigned long __stack_chk_guard __read_mostly;
> +unsigned long __stack_chk_guard __ro_after_init;
>  EXPORT_SYMBOL(__stack_chk_guard);
>  #endif
>  
> -- 
> 2.7.4
> 
