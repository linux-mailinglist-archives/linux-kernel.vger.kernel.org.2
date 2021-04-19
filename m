Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C8AD364A22
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 20:53:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240340AbhDSSxd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 14:53:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233654AbhDSSxc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 14:53:32 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 215E8C06174A
        for <linux-kernel@vger.kernel.org>; Mon, 19 Apr 2021 11:53:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
        Reply-To:Cc:Content-ID:Content-Description;
        bh=N9TETHBPbbSqb/VoLAM4Ni8pA63gJ95JiyjztuQdV+o=; b=bJiDKamkTgPf86ocXig+w7FedJ
        ha3RGCnDi68uGQgcsCteQ4pBbO164qtIjgh7MIEGK4sWGOJZ6YjWH65f8e/7ZJs9FdAb21Cy/3l7S
        kc8+jO7BFfHTRAozw9gPdWpzt0nVo1H8xzW7P2tdIoz1kehlp9kqC6781Fg2mNcZloJKfxEi+Ua0x
        kEShzVRbz13W4OouSDDd819pLx5/ApFN2rPwLobpeW/GA2eX5JMFrb5jfELATWmyD/IOvX5TIW9FX
        ibIBj0HjvdjUqyY06oeJ1op3acilUHyTWhFGfueNg+CcvNf+8qGnLSKsVQl72EYg6pdnn0C5iR04h
        JNtnc3iQ==;
Received: from [2601:1c0:6280:3f0::df68]
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lYZ0d-00E9nw-Vf; Mon, 19 Apr 2021 18:52:41 +0000
Subject: Re: [PATCH] smp: add a best_effort version of
 smp_call_function_many()
To:     Luigi Rizzo <lrizzo@google.com>, linux-kernel@vger.kernel.org,
        peterz@infradead.org, axboe@kernel.dk, paulmck@kernel.org
References: <20210419184455.2987243-1-lrizzo@google.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <d7371d20-e2d8-c5d1-b59b-850d86bf7a83@infradead.org>
Date:   Mon, 19 Apr 2021 11:52:33 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210419184455.2987243-1-lrizzo@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi--

On 4/19/21 11:44 AM, Luigi Rizzo wrote:

> 
> Signed-off-by: Luigi Rizzo <lrizzo@google.com>
> ---
>  include/linux/smp.h | 10 ++++++
>  kernel/smp.c        | 75 +++++++++++++++++++++++++++++++++++++--------
>  2 files changed, 72 insertions(+), 13 deletions(-)
> 

> diff --git a/kernel/smp.c b/kernel/smp.c
> index aeb0adfa0606..75155875fadc 100644
> --- a/kernel/smp.c
> +++ b/kernel/smp.c

> @@ -693,8 +715,32 @@ static void smp_call_function_many_cond(const struct cpumask *mask,
>  			csd_lock_wait(csd);
>  		}
>  	}
> +	return busy ? cfd->cpumask : NULL;
>  }
>  
> +/**
> + * Extended version of smp_call_function_many(). Same constraints.
> + * @mode == 0 same as wait = false, returns 0;
> + * @mode == 1 same as wait = true, returns 0;
> + * @mode = SMP_CFM_BEST_EFFORT: skips CPUs with previous pending requests,
> + *     returns 0 and *mask unmodified if no CPUs are skipped,
> + *     -EBUSY if CPUs are skipped, and *mask is the set of skipped CPUs

Please convert those comments to real kernel-doc format.
(Documentation/doc-guide/kernel-doc.rst)

> + */
> +int __smp_call_function_many(struct cpumask *mask, smp_call_func_t func,
> +			     void *info, int mode)
> +{

thanks.
-- 
~Randy

