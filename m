Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B384356DC0
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 15:48:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347452AbhDGNsG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 09:48:06 -0400
Received: from foss.arm.com ([217.140.110.172]:57484 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S245529AbhDGNsE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 09:48:04 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CE1DE11FB;
        Wed,  7 Apr 2021 06:47:54 -0700 (PDT)
Received: from [192.168.1.179] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 126733F792;
        Wed,  7 Apr 2021 06:47:53 -0700 (PDT)
Subject: Re: [PATCH] arm: ptdump: convert to DEFINE_SHOW_ATTRIBUTE
To:     Jisheng Zhang <Jisheng.Zhang@synaptics.com>,
        Russell King <linux@armlinux.org.uk>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20210330112015.738f4365@xhacker.debian>
From:   Steven Price <steven.price@arm.com>
Message-ID: <1f066306-570e-dfc7-8b4f-f787a6d40554@arm.com>
Date:   Wed, 7 Apr 2021 14:48:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210330112015.738f4365@xhacker.debian>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/03/2021 04:20, Jisheng Zhang wrote:
> Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.
> 
> Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>

Reviewed-by: Steven Price <steven.price@arm.com>

> ---
>   arch/arm/mm/ptdump_debugfs.c | 13 +------------
>   1 file changed, 1 insertion(+), 12 deletions(-)
> 
> diff --git a/arch/arm/mm/ptdump_debugfs.c b/arch/arm/mm/ptdump_debugfs.c
> index 8df9afac8d81..318de969ae0f 100644
> --- a/arch/arm/mm/ptdump_debugfs.c
> +++ b/arch/arm/mm/ptdump_debugfs.c
> @@ -11,18 +11,7 @@ static int ptdump_show(struct seq_file *m, void *v)
>   	ptdump_walk_pgd(m, info);
>   	return 0;
>   }
> -
> -static int ptdump_open(struct inode *inode, struct file *file)
> -{
> -	return single_open(file, ptdump_show, inode->i_private);
> -}
> -
> -static const struct file_operations ptdump_fops = {
> -	.open		= ptdump_open,
> -	.read		= seq_read,
> -	.llseek		= seq_lseek,
> -	.release	= single_release,
> -};
> +DEFINE_SHOW_ATTRIBUTE(ptdump);
>   
>   void __init ptdump_debugfs_register(struct ptdump_info *info, const char *name)
>   {
> 

