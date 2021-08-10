Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 802A03E58D4
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 13:04:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240020AbhHJLEg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 07:04:36 -0400
Received: from relay.sw.ru ([185.231.240.75]:40252 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240026AbhHJLEd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 07:04:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=virtuozzo.com; s=relay; h=Content-Type:MIME-Version:Date:Message-ID:From:
        Subject; bh=IWF7YnjMUZ36VVps825FuadCPSXkcIXXEF9D9EXb+Jw=; b=jfqhwSlskPaXHRioD
        gd3dJw7xEkdzxwW4uAG6nzxFaR86y7Gm1PXlTlit1dPLVildLYwWGKwRXkFIx2euTkd/3JthQm+mD
        PC8/8C9ptqj/YCqDDcHqlnAVgJMBPfAl/dQUQnGDI+uCVZ0Pdhcs+T+q7Zh3KpGmUv35hP90WB1Go
        =;
Received: from [10.93.0.56]
        by relay.sw.ru with esmtp (Exim 4.94.2)
        (envelope-from <vvs@virtuozzo.com>)
        id 1mDPYG-006wYL-96; Tue, 10 Aug 2021 14:04:08 +0300
Subject: Re: [PATCH] mm: use in_task() in __gfp_pfmemalloc_flags()
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org, kernel@openvz.org
References: <f748aef6-9def-bea1-de7f-5ff88d7b3285@virtuozzo.com>
 <20210809112448.3d7d8f2522e18e75ba6e31c0@linux-foundation.org>
From:   Vasily Averin <vvs@virtuozzo.com>
Message-ID: <8bbc1658-03b2-f64e-d11a-153da3eb723a@virtuozzo.com>
Date:   Tue, 10 Aug 2021 14:04:07 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210809112448.3d7d8f2522e18e75ba6e31c0@linux-foundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/9/21 9:24 PM, Andrew Morton wrote:
> On Mon, 9 Aug 2021 11:23:29 +0300 Vasily Averin <vvs@virtuozzo.com> wrote:
> 
>> obsoleted in_interrupt() include task context with disabled BH,
>> it's better to use in_task() instead.
> 
> Are these just blind conversions, or have you verified in each case
> that it is correct to newly take these code paths inside
> local_bh_disable()?
> 
> If "yes" then please provide the reasoning in each changelog?

I cannot say that it is blind conversion.
In all fixed patches in_interrupt() is used to identify task context and access current.
it is incorrect because in_interrupt() include task context with disabled BH
Recently I hit some bug and spend a lot of time for its investigation.
Right now I investigate some other issue in neighborhood, noticed sadly familiar pattern
and decided fix them too. Then noticed few more similar places.
   
In fact I would like to replace all such places in mm in one patch.

Do you want to consider each of these cases separately?

In this particular case in_interrupt() is used to prevent current access.
I think it is safe to look at current->flags and call oom_reserves_allowed()
for tasks with disabled BH and I believe this should provide more correct result.

Historically this check was added to handle interrupt context and said nothing
special about task context with disabled BH.

Could you  please clarify wich kind of arguments should I provide?

Thank you,
	Vasily Averin
