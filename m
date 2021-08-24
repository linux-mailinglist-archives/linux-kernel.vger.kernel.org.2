Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 607683F5C8B
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 12:58:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236423AbhHXK7S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 06:59:18 -0400
Received: from foss.arm.com ([217.140.110.172]:34006 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236377AbhHXK7O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 06:59:14 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E98931476;
        Tue, 24 Aug 2021 03:58:28 -0700 (PDT)
Received: from C02TD0UTHF1T.local (unknown [10.57.90.204])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 16BDD3F66F;
        Tue, 24 Aug 2021 03:58:26 -0700 (PDT)
Date:   Tue, 24 Aug 2021 11:58:24 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     jing yangyang <cgel.zte@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        jing yangyang <jing.yangyang@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: Re: [PATCH linux-next] firmware/psci: fix application of sizeof to
 pointer
Message-ID: <20210824105824.GC96738@C02TD0UTHF1T.local>
References: <61d3cc7e5cd4a819381fcb22e1853d6f48a0c927.1629212319.git.jing.yangyang@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <61d3cc7e5cd4a819381fcb22e1853d6f48a0c927.1629212319.git.jing.yangyang@zte.com.cn>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 19, 2021 at 07:30:16PM -0700, jing yangyang wrote:
> sizeof when applied to a pointer typed expression gives the size of
> the pointer.
> 
> ./drivers/firmware/psci/psci_checker.c:158:41-47: ERROR application of sizeof to pointer
> 
> This issue was detected with the help of Coccinelle.
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: jing yangyang <jing.yangyang@zte.com.cn>

From looking at the git history, we should add:

  Fixes: 7401056de5f8d4ea ("drivers/firmware: psci_checker: stash and use topology_core_cpumask for hotplug tests)"

With that:

  Acked-by: Mark Rutland <mark.rutland@arm.com>

Lorenzo, how do we normally direct these patches?

Thanks,
Mark.


> ---
>  drivers/firmware/psci/psci_checker.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/firmware/psci/psci_checker.c b/drivers/firmware/psci/psci_checker.c
> index 9a369a2..116eb46 100644
> --- a/drivers/firmware/psci/psci_checker.c
> +++ b/drivers/firmware/psci/psci_checker.c
> @@ -155,7 +155,7 @@ static int alloc_init_cpu_groups(cpumask_var_t **pcpu_groups)
>  	if (!alloc_cpumask_var(&tmp, GFP_KERNEL))
>  		return -ENOMEM;
>  
> -	cpu_groups = kcalloc(nb_available_cpus, sizeof(cpu_groups),
> +	cpu_groups = kcalloc(nb_available_cpus, sizeof(*cpu_groups),
>  			     GFP_KERNEL);
>  	if (!cpu_groups) {
>  		free_cpumask_var(tmp);
> -- 
> 1.8.3.1
> 
> 
