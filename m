Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5629D33F79A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 18:55:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232883AbhCQRzO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 13:55:14 -0400
Received: from mga01.intel.com ([192.55.52.88]:34125 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232847AbhCQRyn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 13:54:43 -0400
IronPort-SDR: Z4Vc0M65Ff4yXBNKwp7xBTq0bzN/rD/Zpgu+i196+KAuC930VaCB/pyyGtH0kUYKMKy9d2ETkR
 LJSBPO9cq9Zw==
X-IronPort-AV: E=McAfee;i="6000,8403,9926"; a="209487447"
X-IronPort-AV: E=Sophos;i="5.81,257,1610438400"; 
   d="scan'208";a="209487447"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2021 10:54:42 -0700
IronPort-SDR: R/gavvYAnNIyWCXbDt1vV2YSEXMSHgGHpFVsMx+Mc/3C5bl92CGgom/DgTQUrjFLs02TUWf58r
 olXG8MV4/CVQ==
X-IronPort-AV: E=Sophos;i="5.81,257,1610438400"; 
   d="scan'208";a="388925626"
Received: from rchatre-mobl3.amr.corp.intel.com (HELO [10.212.176.237]) ([10.212.176.237])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2021 10:54:41 -0700
Subject: Re: [PATCH] kernel: cpu: resctrl: Minor typo fix in the file
 pseudo_lock.c
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>, fenghua.yu@intel.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, linux-kernel@vger.kernel.org
Cc:     rdunlap@infradead.org
References: <20210317084016.3787380-1-unixbhaskar@gmail.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
Message-ID: <b29afbff-67f4-397b-e289-c3e21755fec0@intel.com>
Date:   Wed, 17 Mar 2021 10:54:40 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210317084016.3787380-1-unixbhaskar@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bhaskar,

Thank you very much for catching this typo.

My feedback [1] to a previous patch from you applies here also. The 
prefix should be "x86/resctrl:" for contributions to this area.

[1] 
https://lore.kernel.org/lkml/7e3a5c13-db5c-7399-2b80-f1284786ea77@intel.com/

On 3/17/2021 1:40 AM, Bhaskar Chowdhury wrote:
> 
> s/derefence/dereference/
> 
> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
> ---
>   arch/x86/kernel/cpu/resctrl/pseudo_lock.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
> index e916646adc69..43990a882b36 100644
> --- a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
> +++ b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
> @@ -1307,7 +1307,7 @@ int rdtgroup_pseudo_lock_create(struct rdtgroup *rdtgrp)
>   		 * If the thread does not get on the CPU for whatever
>   		 * reason and the process which sets up the region is
>   		 * interrupted then this will leave the thread in runnable
> -		 * state and once it gets on the CPU it will derefence
> +		 * state and once it gets on the CPU it will dereference
>   		 * the cleared, but not freed, plr struct resulting in an
>   		 * empty pseudo-locking loop.
>   		 */
> --
> 2.30.2
> 

Reinette
