Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 545DE33CD01
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 06:16:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234071AbhCPFPx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 01:15:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231338AbhCPFP1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 01:15:27 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1234::107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA886C06174A
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 22:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=DM3CqIX3e9P2zVEQZzTouR1JRbXih69YCg6nzpNNxQQ=; b=lj39gMOkLFpvDl9M9ZRNX2hN7X
        ZTvuIlOEtRm650QX5D8zXlP1oRIMJnt4bzPSdV8g83VHIf72p2zSAhIICtNngakhHpQQ0lbY44yzi
        aNidyCS5N6fvoGL4kNd3bHoUgo0Wce1RyEleSfB/nMJWgDOK2BSZFdN75xnI1SqYGOwZhNOwWObj6
        3g5wlvZ2ilRxfQE1jOiRkkvlZCHoqzTDJ/QeKobY73VV+J59HeFvq2Wr51tqamiKoDiFF2NusiGil
        mPDt5LrryPwLqL6X1HZossEUE3Bxb/LGzAqbqcfj9VArMwEPJbBWO6aYs0eV6zawvTGJM8LAh/aez
        GCDlmycg==;
Received: from [2601:1c0:6280:3f0::9757]
        by merlin.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lM236-001POo-VL; Tue, 16 Mar 2021 05:15:21 +0000
Subject: Re: [PATCH] smp: kernel/panic.c - silence warnings
To:     He Ying <heying24@huawei.com>, peterz@infradead.org,
        mingo@kernel.org, frederic@kernel.org, paulmck@kernel.org,
        christophe.leroy@csgroup.eu, clg@kaod.org, qais.yousef@arm.com
Cc:     johnny.chenyi@huawei.com, linux-kernel@vger.kernel.org
References: <20210316040819.29085-1-heying24@huawei.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <2e1a9910-a266-f327-2f5e-413b2f60546a@infradead.org>
Date:   Mon, 15 Mar 2021 22:15:16 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210316040819.29085-1-heying24@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/15/21 9:08 PM, He Ying wrote:
> We found these warnings in kernel/panic.c by using sparse tool:
> warning: symbol 'panic_smp_self_stop' was not declared.
> warning: symbol 'nmi_panic_self_stop' was not declared.
> warning: symbol 'crash_smp_send_stop' was not declared.
> 
> To avoid them, add declarations for these three functions in
> include/linux/smp.h.
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: He Ying <heying24@huawei.com>
> ---
>  include/linux/smp.h | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/include/linux/smp.h b/include/linux/smp.h
> index 70c6f6284dcf..861a253cc179 100644
> --- a/include/linux/smp.h
> +++ b/include/linux/smp.h
> @@ -50,6 +50,14 @@ extern unsigned int total_cpus;
>  int smp_call_function_single(int cpuid, smp_call_func_t func, void *info,
>  			     int wait);
>  
> +/*
> + * Cpus stopping functions in panic. All have default weak definations.

                                                              definitions.

> + * Architecure dependent code may override them.

      Architecture-dependent


> + */
> +void panic_smp_self_stop(void);
> +void nmi_panic_self_stop(struct pt_regs *regs);
> +void crash_smp_send_stop(void);
> +
>  /*
>   * Call a function on all processors
>   */
> 


-- 
~Randy

