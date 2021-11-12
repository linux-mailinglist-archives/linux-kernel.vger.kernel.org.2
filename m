Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EED644ECBC
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Nov 2021 19:43:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235608AbhKLSq0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Nov 2021 13:46:26 -0500
Received: from foss.arm.com ([217.140.110.172]:43544 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229892AbhKLSq0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Nov 2021 13:46:26 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ED88F101E;
        Fri, 12 Nov 2021 10:43:34 -0800 (PST)
Received: from e120937-lin (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5CD613F718;
        Fri, 12 Nov 2021 10:43:34 -0800 (PST)
Date:   Fri, 12 Nov 2021 18:43:32 +0000
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v0 06/42] firmware: Check notifier registration return
 value
Message-ID: <20211112184332.GC6655@e120937-lin>
References: <20211108101157.15189-1-bp@alien8.de>
 <20211108101157.15189-7-bp@alien8.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211108101157.15189-7-bp@alien8.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 08, 2021 at 11:11:21AM +0100, Borislav Petkov wrote:
> From: Borislav Petkov <bp@suse.de>
> 
> Avoid homegrown notifier registration checks.
> 
> No functional changes.
> 
> Signed-off-by: Borislav Petkov <bp@suse.de>
> Cc: linux-arm-kernel@lists.infradead.org
> ---

Hi Borislav,

same observations I made on ccree patch in this series holds here too.

Moreover you should use get_maintainer.pl script to properly Cc people
(reviewers/maintainers) beside mailing lists (I saw this by chance...):
as an additional note this patch also merges together two fixes for 2
completely different things (it should be split).

But, anyway, most of all, as said for ccree, I don't see the reason for
these kind of fixes given the internals of notifier core.

Thanks,
Cristian

>  drivers/firmware/arm_scmi/notify.c | 3 ++-
>  drivers/firmware/google/gsmi.c     | 6 ++++--
>  2 files changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/firmware/arm_scmi/notify.c b/drivers/firmware/arm_scmi/notify.c
> index 0efd20cd9d69..f4c42ac00c63 100644
> --- a/drivers/firmware/arm_scmi/notify.c
> +++ b/drivers/firmware/arm_scmi/notify.c
> @@ -1358,7 +1358,8 @@ static int scmi_notifier_register(const struct scmi_handle *handle,
>  	if (!hndl)
>  		return -EINVAL;
>  
> -	blocking_notifier_chain_register(&hndl->chain, nb);
> +	if (blocking_notifier_chain_register(&hndl->chain, nb))
> +		pr_warn("SCMI notifier already registered\n");
>  
>  	/* Enable events for not pending handlers */
>  	if (!IS_HNDL_PENDING(hndl)) {
> diff --git a/drivers/firmware/google/gsmi.c b/drivers/firmware/google/gsmi.c
> index adaa492c3d2d..a658e7c106c3 100644
> --- a/drivers/firmware/google/gsmi.c
> +++ b/drivers/firmware/google/gsmi.c
> @@ -1030,8 +1030,10 @@ static __init int gsmi_init(void)
>  
>  	register_reboot_notifier(&gsmi_reboot_notifier);
>  	register_die_notifier(&gsmi_die_notifier);
> -	atomic_notifier_chain_register(&panic_notifier_list,
> -				       &gsmi_panic_notifier);
> +
> +	if (atomic_notifier_chain_register(&panic_notifier_list,
> +					   &gsmi_panic_notifier))
> +		pr_warn("gsmi panic notifier already registered\n");
>  
>  	printk(KERN_INFO "gsmi version " DRIVER_VERSION " loaded\n");
>  
> -- 
> 2.29.2
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
