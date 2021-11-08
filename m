Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0426F448222
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Nov 2021 15:48:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240605AbhKHOvM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 09:51:12 -0500
Received: from mxout01.lancloud.ru ([45.84.86.81]:37842 "EHLO
        mxout01.lancloud.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237063AbhKHOvK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 09:51:10 -0500
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout01.lancloud.ru 9841620E927D
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
Message-ID: <ea08bd47-63cc-459f-4703-fc60c728bd02@omp.ru>
Date:   Mon, 8 Nov 2021 17:48:11 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH v0 35/42] sh: Check notifier registration return value
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>, LKML <linux-kernel@vger.kernel.org>
CC:     <linux-sh@vger.kernel.org>
References: <20211108101157.15189-1-bp@alien8.de>
 <20211108101157.15189-36-bp@alien8.de>
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
Organization: Open Mobile Platform
In-Reply-To: <20211108101157.15189-36-bp@alien8.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.11.198]
X-ClientProxiedBy: LFEXT02.lancloud.ru (fd00:f066::142) To
 LFEX1907.lancloud.ru (fd00:f066::207)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08.11.2021 13:11, Borislav Petkov wrote:

> From: Borislav Petkov <bp@suse.de>
> 
> Avoid homegrown notifier registration checks.
> 
> No functional changes.
> 
> Signed-off-by: Borislav Petkov <bp@suse.de>
> Cc: linux-sh@vger.kernel.org
> ---
>   arch/sh/kernel/cpu/sh4a/setup-sh7724.c | 11 +++++++----
>   1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/sh/kernel/cpu/sh4a/setup-sh7724.c b/arch/sh/kernel/cpu/sh4a/setup-sh7724.c
> index 0d990ab1ba2a..8dfbb8149f66 100644
> --- a/arch/sh/kernel/cpu/sh4a/setup-sh7724.c
> +++ b/arch/sh/kernel/cpu/sh4a/setup-sh7724.c
> @@ -1277,11 +1277,14 @@ static struct notifier_block sh7724_post_sleep_notifier = {
>   
>   static int __init sh7724_sleep_setup(void)
>   {
> -	atomic_notifier_chain_register(&sh_mobile_pre_sleep_notifier_list,
> -				       &sh7724_pre_sleep_notifier);
> +	if (atomic_notifier_chain_register(&sh_mobile_pre_sleep_notifier_list,
> +					   &sh7724_pre_sleep_notifier))
> +		pr_warn("SH7724 pre-sleep notifier already registered\n");
> +
> +	if (atomic_notifier_chain_register(&sh_mobile_post_sleep_notifier_list,
> +					   &sh7724_post_sleep_notifier))
> +		pr_warn("SH7724 pre-sleep notifier already registered\n");

   s/pre/post/? :-)

>   
> -	atomic_notifier_chain_register(&sh_mobile_post_sleep_notifier_list,
> -				       &sh7724_post_sleep_notifier);
>   	return 0;
>   }
>   arch_initcall(sh7724_sleep_setup);

MBR, Sergey
