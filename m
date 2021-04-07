Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E61B0356DBF
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 15:48:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245646AbhDGNsF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 09:48:05 -0400
Received: from foss.arm.com ([217.140.110.172]:57474 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241716AbhDGNsD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 09:48:03 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 71AEF106F;
        Wed,  7 Apr 2021 06:47:53 -0700 (PDT)
Received: from [192.168.1.179] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 815D83F792;
        Wed,  7 Apr 2021 06:47:52 -0700 (PDT)
Subject: Re: [PATCH] arm: ptdump: add __init section marker to three functions
To:     Jisheng Zhang <Jisheng.Zhang@synaptics.com>,
        Russell King <linux@armlinux.org.uk>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20210330111922.2fb4eaa4@xhacker.debian>
From:   Steven Price <steven.price@arm.com>
Message-ID: <5893767f-4103-3668-0810-3a0a66dc1c9e@arm.com>
Date:   Wed, 7 Apr 2021 14:48:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210330111922.2fb4eaa4@xhacker.debian>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/03/2021 04:19, Jisheng Zhang wrote:
> They are not needed after booting, so mark them as __init to move them
> to the .init section.
> 
> Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>

Reviewed-by: Steven Price <steven.price@arm.com>

> ---
>   arch/arm/mm/dump.c           | 4 ++--
>   arch/arm/mm/ptdump_debugfs.c | 2 +-
>   2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/mm/dump.c b/arch/arm/mm/dump.c
> index 93ff0097f00b..fb688003d156 100644
> --- a/arch/arm/mm/dump.c
> +++ b/arch/arm/mm/dump.c
> @@ -420,7 +420,7 @@ void ptdump_walk_pgd(struct seq_file *m, struct ptdump_info *info)
>   	note_page(&st, 0, 0, 0, NULL);
>   }
>   
> -static void ptdump_initialize(void)
> +static void __init ptdump_initialize(void)
>   {
>   	unsigned i, j;
>   
> @@ -466,7 +466,7 @@ void ptdump_check_wx(void)
>   		pr_info("Checked W+X mappings: passed, no W+X pages found\n");
>   }
>   
> -static int ptdump_init(void)
> +static int __init ptdump_init(void)
>   {
>   	ptdump_initialize();
>   	ptdump_debugfs_register(&kernel_ptdump_info, "kernel_page_tables");
> diff --git a/arch/arm/mm/ptdump_debugfs.c b/arch/arm/mm/ptdump_debugfs.c
> index 598b636615a2..8df9afac8d81 100644
> --- a/arch/arm/mm/ptdump_debugfs.c
> +++ b/arch/arm/mm/ptdump_debugfs.c
> @@ -24,7 +24,7 @@ static const struct file_operations ptdump_fops = {
>   	.release	= single_release,
>   };
>   
> -void ptdump_debugfs_register(struct ptdump_info *info, const char *name)
> +void __init ptdump_debugfs_register(struct ptdump_info *info, const char *name)
>   {
>   	debugfs_create_file(name, 0400, NULL, info, &ptdump_fops);
>   }
> 

