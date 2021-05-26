Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C0CE390E52
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 04:32:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232103AbhEZCeI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 22:34:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231497AbhEZCeH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 22:34:07 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10E35C061574
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 19:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:
        Subject:Sender:Reply-To:Cc:Content-ID:Content-Description;
        bh=YohF4HXNBund6EoKjIDpmqaBJ1aaR/rUfQwrCndNGa0=; b=S6dK31bg36Dbf2kTSI2xYt89in
        0lvGYY4t2UVJp0GFT1bRw1GPWpCJ+vskMLboCGIEZlAJd6Bt/OOxPFSiMNjLCM9P343L2Y2AI9cYa
        r81XvYkE3RM6nxmm0rpssmM9wQkKHabxgKpLVtmqArRA8fWkTQdEuU8ESgmtFPAUKtqL9aQYpyFoV
        g5AF7qP4CIKhxC5dwqm+h8IEqQ6XwB05MNzALpWbpvUrK2jh+n7Jyug9rtDWA5HRvWUMlU9cgBEza
        kjciiP7o5jbfuwHnI3Zs3Pdk+VoebziY0GhGsBSnde+I7uMzaKIRf/bWxk2N66lbE2fp1jDdEaXkE
        HdkOY5aw==;
Received: from [2601:1c0:6280:3f0::7376]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lljLX-00A8c0-38; Wed, 26 May 2021 02:32:35 +0000
Subject: Re: [PATCH 1/1] sched/topology: Fix a spelling mistake in error
 message
To:     Zhen Lei <thunder.leizhen@huawei.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20210526021856.9060-1-thunder.leizhen@huawei.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <42d36255-c1a6-956a-b56b-0c09eee125ec@infradead.org>
Date:   Tue, 25 May 2021 19:32:34 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210526021856.9060-1-thunder.leizhen@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/25/21 7:18 PM, Zhen Lei wrote:
> The misspelled word 'borken' should be 'broken'.
> 
> Fixes: 6ae72dff3759 ("sched: Robustify topology setup")
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---
>  kernel/sched/topology.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> index 55a0a243e871..80295e224442 100644
> --- a/kernel/sched/topology.c
> +++ b/kernel/sched/topology.c
> @@ -1937,7 +1937,7 @@ static struct sched_domain *build_sched_domain(struct sched_domain_topology_leve
>  
>  		if (!cpumask_subset(sched_domain_span(child),
>  				    sched_domain_span(sd))) {
> -			pr_err("BUG: arch topology borken\n");
> +			pr_err("BUG: arch topology broken\n");

Would "borked" or "b0rken" be clearer?

>  #ifdef CONFIG_SCHED_DEBUG
>  			pr_err("     the %s domain not a subset of the %s domain\n",
>  					child->name, sd->name);
> 


I.e., this is misspelt on purpose.

Reply to a previous version of this patch:
  https://lore.kernel.org/lkml/1493036801.6266.12.camel@gmx.de/

cheers.
-- 
~Randy

