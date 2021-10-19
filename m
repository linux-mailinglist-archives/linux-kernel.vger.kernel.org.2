Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DCBE433947
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 16:51:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbhJSOxu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 10:53:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:56514 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232363AbhJSOxp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 10:53:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634655092;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jNZbYCm4L3nEmVjXY9zlfyw5oLY07ajTFGFsydEKogk=;
        b=T0ozVcHj6KMMqQ+50fYAqU+Sw7lCl7RMiYpqUqwtHOU2aTcuY9oUKDmydZy7SV4OvGBLt9
        HWwK8ary9B3UN0F13ZkCieTsZnGtHd3rKk30Ds3iktkN9yIrwH+zzRzS+ILzGL3h1ou4t0
        al7GV+7xJr4K+GBZzD+QtmkToK4Ivug=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-265-UsGW6vaSN8eVW9F4nHehiA-1; Tue, 19 Oct 2021 10:51:28 -0400
X-MC-Unique: UsGW6vaSN8eVW9F4nHehiA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 29F3F801FCE;
        Tue, 19 Oct 2021 14:51:27 +0000 (UTC)
Received: from x2.localnet (unknown [10.22.33.180])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 58D9C7092D;
        Tue, 19 Oct 2021 14:51:01 +0000 (UTC)
From:   Steve Grubb <sgrubb@redhat.com>
To:     paul@paul-moore.com, eparis@redhat.com, rgb@redhat.com,
        linux-audit@redhat.com
Cc:     wangweiyang2@huawei.com, linux-audit@redhat.com,
        linux-kernel@vger.kernel.org,
        Gaosheng Cui <cuigaosheng1@huawei.com>
Subject: Re: [PATCH -next, v3 2/2] audit: return early if the rule has a lower priority
Date:   Tue, 19 Oct 2021 10:51:00 -0400
Message-ID: <5543735.DvuYhMxLoT@x2>
Organization: Red Hat
In-Reply-To: <20211016072351.237745-3-cuigaosheng1@huawei.com>
References: <20211016072351.237745-1-cuigaosheng1@huawei.com> <20211016072351.237745-3-cuigaosheng1@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Saturday, October 16, 2021 3:23:51 AM EDT Gaosheng Cui wrote:
> It is not necessary for audit_filter_rules() functions to check
> audit fileds of the rule with a lower priority, and if we did,
> there might be some unintended effects, such as the ctx->ppid
> may be changed unexpectedly, so return early if the rule has
> a lower priority.
> 
> Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>
> ---
>  kernel/auditsc.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/auditsc.c b/kernel/auditsc.c
> index 42d4a4320526..b517947bfa48 100644
> --- a/kernel/auditsc.c
> +++ b/kernel/auditsc.c
> @@ -470,6 +470,9 @@ static int audit_filter_rules(struct task_struct *tsk,
>  	u32 sid;
>  	unsigned int sessionid;
> 
> +	if (ctx && rule->prio <= ctx->prio)
> +		return 0;
> +

Just wondering something... If the first thing we do is to decide to return, 
should we have called the function in the first place? I wonder if this test 
should be used to break out of the rule iteration loops so that we don't keep 
calling only to return ?

-Steve

>  	cred = rcu_dereference_check(tsk->cred, tsk == current || 
task_creation);
> 
>  	for (i = 0; i < rule->field_count; i++) {
> @@ -737,8 +740,6 @@ static int audit_filter_rules(struct task_struct *tsk,
>  	}
> 
>  	if (ctx) {
> -		if (rule->prio <= ctx->prio)
> -			return 0;
>  		if (rule->filterkey) {
>  			kfree(ctx->filterkey);
>  			ctx->filterkey = kstrdup(rule->filterkey, GFP_ATOMIC);




