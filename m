Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E939393263
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 17:24:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235806AbhE0P0S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 11:26:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235649AbhE0P0Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 11:26:16 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35DB0C061760
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 08:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=gsCvi6MoyUojzZX/QcuxoxF20z67+doV0L14wz3bp3A=; b=LndObd/HhT+oHmvCROlxmKCot4
        yS/RTY4Ca/AfQwSzShBkmymF7tVWq+iP7zDVqNwrG71L2iy6wcKQl1zMkBCLjxr4ZvteZe08ez0+s
        YKYHZVlb1GWOgi9TnNHB1eo3uebL9jDAjDkClCPWDKDwuuXNtxWFcg2ITxCUfSARskA3oxeYt36Qr
        OOeoAMsEeUvo96yHJRA0OF5GiCcCYsNVn6vdKnb0Piql4duanE/vwbF3VpYM99366A82ruokoKmjF
        A1sY5JCLKJxrFy5heasJCnlldzflvr/OrYSWEj+5rLPfdBoktF6vrXcF8rNT1rDmD5X7U2MUVKnS9
        yxVxOTdw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lmHrG-005fis-En; Thu, 27 May 2021 15:23:43 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 1E89230022C;
        Thu, 27 May 2021 17:23:36 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C31392011BE60; Thu, 27 May 2021 17:23:36 +0200 (CEST)
Date:   Thu, 27 May 2021 17:23:36 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     jiwei.sun.bj@qq.com
Cc:     mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, linux-kernel@vger.kernel.org, sjiwei@163.com
Subject: Re: [PATCH] sched/core: Fix two typos in comments
Message-ID: <YK+5eKc4kx4+ALD1@hirez.programming.kicks-ass.net>
References: <tencent_7D91EF2DD1EEC279A83EBE3EFDEB0138A107@qq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_7D91EF2DD1EEC279A83EBE3EFDEB0138A107@qq.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 27, 2021 at 11:18:05PM +0800, jiwei.sun.bj@qq.com wrote:
> From: Jiwei Sun <jiwei.sun.bj@qq.com>
> 
> Signed-off-by: Jiwei Sun <jiwei.sun.bj@qq.com>
> ---
>  kernel/sched/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 5226cc26a095..c75766b7fb44 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -7665,7 +7665,7 @@ static void balance_push(struct rq *rq)
>  	 * required to complete the hotplug process.
>  	 *
>  	 * XXX: the idle task does not match kthread_is_per_cpu() due to
> -	 * histerical raisins.
> +	 * historical reasons.

Google: "humour".
