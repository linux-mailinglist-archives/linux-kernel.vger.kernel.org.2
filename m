Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1B9738CAA0
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 18:10:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235705AbhEUQLW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 12:11:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbhEUQLV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 12:11:21 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE1D7C061574
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 09:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=52L6TailJfOHnT60OyLMvZwjwsLknN3CBZJe6K5Xqt4=; b=qfRtg1DLskiwonH559Z7T0iK2s
        vwvVa1S3QQUDNcQFY439w/QP8dPt89Uc/C6iho9/DnJ+0Ek92pisZz4PWfDsO6DRuNUpaQLeUKqcP
        hZsN5KJnw6OpUQRgvlsa3CdpMjnhQsYHakEg9Va0VW36OYffhP63zMnn8mihg4iwJSmQoTiVdpZUU
        Yx49xaABymi1dk55bIwVdl75pIEypKD6PPGnDWDP1c8zZ/T2GqXhaW0LtrGUkTONOb3AkjbSllmGa
        MiWYdWivs4Jol5xoSeK2K4DNKUlWZcClw8WID1aPVNiDXDhirxaZaOJ2RllqwYrXxKuvKzalFGCqE
        dECZYv5g==;
Received: from [2601:1c0:6280:3f0::7376]
        by bombadil.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lk7in-00HGV7-DF; Fri, 21 May 2021 16:09:57 +0000
Subject: Re: config SCHED_CORE
To:     Peter Zijlstra <peterz@infradead.org>,
        Hugh Dickins <hughd@google.com>
Cc:     linux-kernel@vger.kernel.org, joel@joelfernandes.org
References: <alpine.LSU.2.11.2105201954180.6100@eggly.anvils>
 <YKdm69K8k/ztd6BM@hirez.programming.kicks-ass.net>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <47848ac4-6164-57fe-de16-7ca6048aa371@infradead.org>
Date:   Fri, 21 May 2021 09:09:54 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <YKdm69K8k/ztd6BM@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/21/21 12:53 AM, Peter Zijlstra wrote:
> On Thu, May 20, 2021 at 08:06:07PM -0700, Hugh Dickins wrote:
>> Hi Peter,
>>
>> make oldconfig gave me no help at all on how to decide whether to choose
>> SCHED_CORE Y or n, beyond it recommending Y.  Maybe you'll delete that
>> option later, or maybe removing the prompt string would silence it.
> 
> Ah, you're quite right. I never seem to have gotten around to actually
> writing anything useful there :/ Similarly the documentation for all
> this seems to have gone missing too.
> 
> Joel, could I ask you to refresh the document to match the current state
> of things and repost? I still whole hartedly despise this RST crud, it
> makes it so hard to read / modify the files.
> 
> ( I think the latest version is here:
>   https://lkml.kernel.org/r/20210324214020.34142-8-joel@joelfernandes.org
> )
> 
> Anyway, how is something like the below, Joel can add a reference to the
> document once it's there.
> 
> ---
>  kernel/Kconfig.preempt | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/Kconfig.preempt b/kernel/Kconfig.preempt
> index ea1e3331c0ba..3c4566cd20ef 100644
> --- a/kernel/Kconfig.preempt
> +++ b/kernel/Kconfig.preempt
> @@ -104,4 +104,16 @@ config SCHED_CORE
>  	bool "Core Scheduling for SMT"
>  	default y
>  	depends on SCHED_SMT
> -
> +	help
> +	  This option enables Core scheduling, a means of coordinated task
> +	  selection across SMT siblings with the express purpose of creating a
> +	  Core wide privilidge boundary. When enabled -- see prctl(PR_SCHED_CORE)

	            privilege
while you are at it.

> +	  -- task selection will ensure all SMT siblings will execute a task
> +	  from the same 'core group', forcing idle when no matching task is found.
> +
> +	  This provides means of mitigation against a number of SMT side-channels;
> +	  but is, on its own, insufficient to mitigate all known side-channels.
> +	  Notable: the MDS class of attacks require more.
> +
> +	  Default enabled for anything that has SCHED_SMT, when unused there should
> +	  be no impact on performance.
> 


-- 
~Randy

