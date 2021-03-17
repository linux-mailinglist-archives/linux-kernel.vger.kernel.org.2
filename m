Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19E7633E8D8
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 06:15:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbhCQFOj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 01:14:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229962AbhCQFOP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 01:14:15 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1234::107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FF02C06174A
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 22:14:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
        Reply-To:Cc:Content-ID:Content-Description;
        bh=xVb9Z3C8bKi+BlcriFEqPTf9+usx4e/evvS7bsiKw2g=; b=ihzuLRhT842wOeWeQKZ3jPsLwq
        pzxewLTKtBPkmSOO4m/gjSeqVm6q8SeTubliqa8qMN34eRcNFzHn43YaCS3+hbXxfmth3O+E6veLk
        8OLHsuiRyYVHylcBX78a4+9R19qPYZ09cx+V6eS83Ke/zpqEzAztPVXr+leMSeX1m18nlVRdRgLBR
        XtALi10rMJySbjtjMdxoIHiYACyKRpd+gdLMs3ghLRfKd2zMulxGBAb8I67KlyWXTxVDjrYqG+fHh
        TBv4V/+s0rvkKSojbzC2swht41HOagM9PIE9HjcWKdTrThsmJQuwIsiSYFkPvw3z+8GWgP0q1ys6W
        okwxQOuQ==;
Received: from [2601:1c0:6280:3f0::9757]
        by merlin.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lMOVX-001bTu-Py; Wed, 17 Mar 2021 05:14:12 +0000
Subject: Re: [PATCH] kernel: Fix a typo in the file up.c
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org
References: <20210317032732.3260835-1-unixbhaskar@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <b5d63656-d01f-2e66-d630-1179b2653b53@infradead.org>
Date:   Tue, 16 Mar 2021 22:14:09 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210317032732.3260835-1-unixbhaskar@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/16/21 8:27 PM, Bhaskar Chowdhury wrote:
> 
> s/condtions/conditions/
> 
> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org>

> ---
>  Adding Andrew in the to list, becasue this file has no maintainer attached

                                 because

> 
>  kernel/up.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/up.c b/kernel/up.c
> index c6f323dcd45b..1b9b135e77dd 100644
> --- a/kernel/up.c
> +++ b/kernel/up.c
> @@ -67,7 +67,7 @@ EXPORT_SYMBOL(on_each_cpu_mask);
> 
>  /*
>   * Preemption is disabled here to make sure the cond_func is called under the
> - * same condtions in UP and SMP.
> + * same conditions in UP and SMP.
>   */
>  void on_each_cpu_cond_mask(smp_cond_func_t cond_func, smp_call_func_t func,
>  			   void *info, bool wait, const struct cpumask *mask)
> --


-- 
~Randy

