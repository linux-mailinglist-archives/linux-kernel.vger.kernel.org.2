Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CD68408ABE
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 14:09:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239848AbhIMMKe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 08:10:34 -0400
Received: from foss.arm.com ([217.140.110.172]:57178 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239815AbhIMMKd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 08:10:33 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F0FEC31B;
        Mon, 13 Sep 2021 05:09:17 -0700 (PDT)
Received: from C02TD0UTHF1T.local (unknown [10.57.16.84])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4B58E3F59C;
        Mon, 13 Sep 2021 05:09:16 -0700 (PDT)
Date:   Mon, 13 Sep 2021 13:09:08 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     cgel.zte@gmail.com
Cc:     catalin.marinas@arm.com, will@kernel.org, pcc@google.com,
        maz@kernel.org, peterz@infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Lv Ruyi <lv.ruyi@zte.com.cn>, Zeal Robot <zealci@zte.com.cn>
Subject: Re: [PATCH] arm64/kernel: remove duplicate include in process.c
Message-ID: <20210913120908.GA9450@C02TD0UTHF1T.local>
References: <20210902011126.29828-1-lv.ruyi@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210902011126.29828-1-lv.ruyi@zte.com.cn>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 01, 2021 at 06:11:26PM -0700, cgel.zte@gmail.com wrote:
> From: Lv Ruyi <lv.ruyi@zte.com.cn>
> 
> Remove all but the first include of linux/sched.h from process.c
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Lv Ruyi <lv.ruyi@zte.com.cn>
> ---
>  arch/arm64/kernel/process.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
> index 19100fe8f7e4..1a1213cca173 100644
> --- a/arch/arm64/kernel/process.c
> +++ b/arch/arm64/kernel/process.c
> @@ -18,7 +18,6 @@
>  #include <linux/mman.h>
>  #include <linux/mm.h>
>  #include <linux/nospec.h>
> -#include <linux/sched.h>
>  #include <linux/stddef.h>
>  #include <linux/sysctl.h>
>  #include <linux/unistd.h>

For the benefit of other reviewers, while it's not obvious from the
patch context, arlier in the includes (which aren't currently sorted),
there's a block with:

| #include <linux/sched.h>
| #include <linux/sched/debug.h>
| #include <linux/sched/task.h>
| #include <linux/sched/task_stack.h>

... and so this patch looks good to me:

Acked-by: Mark Rutland <mark.rutland@arm.com>

IMO it would be nice to sort the includes if that's not too churny (but
that should be a separate patch).

Thanks,
Mark.
