Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CBE8312FD1
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 11:56:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232772AbhBHKzM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 05:55:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:34965 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232679AbhBHKnI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 05:43:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612780898;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=E8ybXA8c9mSioRzW+0/Reesj0ONr5p9VGIF8lBxAzkM=;
        b=O4pfYm9oWZ4kNiOxbJb1nsivZPEG47WAViPfLuFymsczn917bqWAFApCIcL+YWRwxhDft3
        v+cJPfW7qBsHAFd4sbbeM4dNFbI69pJ7oTprX3hvBUhu8a2Fe2m0WOqKPXgtC0eTmKEE8B
        SM9fMIJz5Qj3PR0j0fge80/j0KFqWyA=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-490-KveiCOiAMTyRUUYhB43SaA-1; Mon, 08 Feb 2021 05:41:36 -0500
X-MC-Unique: KveiCOiAMTyRUUYhB43SaA-1
Received: by mail-ej1-f69.google.com with SMTP id by8so337678ejc.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Feb 2021 02:41:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=E8ybXA8c9mSioRzW+0/Reesj0ONr5p9VGIF8lBxAzkM=;
        b=MWSNAA7+er+hE6gwDnkixIsn8HaSwMj+w9FfTkIUzKjGGobUf3sfGeYhmdXWKNmN/e
         c9RJFS83n8x9syGIQu5yxQv0RSNfPugRoSPZV75gL37o1tno3WTz8aVw0oWaZrGaXLbO
         AL5OOs6OoHqy82A91lTYzRR4Lr8r1YaTfPAg8Qv0f1ncbLpfJXI8QGowvD0e6QP7Zgij
         bRwrH5kNyYr9kBmxW5Vq6I6G3CXQsXSZ+D/Z6CuDWHA9XfGU8zHrD8ZyqR5+unETJl0i
         F/ZCyYgG7TpDDDR6NYDdaS90BGQ63rKxiI167AlNY61wAaYVAma5R9SF6T11HJEs4Rgw
         YUIQ==
X-Gm-Message-State: AOAM530/YhiRfdKFSZpM4kPiHDX1ZKR52egYEekts2331bpjPuqg/N2q
        RAFP+E+olHHcZVtgfaE+4+07eNycTxmcW8gF+DBsUuQD3Tm/X+rPH0GNUSPRfUAvax6i09UkBNl
        o8OEuwFYC0eNUT0IK9JiKFAKy
X-Received: by 2002:a17:906:d7bc:: with SMTP id pk28mr10871095ejb.370.1612780895127;
        Mon, 08 Feb 2021 02:41:35 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzUjvugi/UkGHl5KGDf3fmcfCvhjFf3sf/CJUxG586Q88cwfYTCBYLNLLyuT/hJHgo4jXeexQ==
X-Received: by 2002:a17:906:d7bc:: with SMTP id pk28mr10871082ejb.370.1612780894887;
        Mon, 08 Feb 2021 02:41:34 -0800 (PST)
Received: from localhost.localdomain ([151.29.106.174])
        by smtp.gmail.com with ESMTPSA id g2sm8272848ejk.108.2021.02.08.02.41.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Feb 2021 02:41:34 -0800 (PST)
Date:   Mon, 8 Feb 2021 11:41:31 +0100
From:   Juri Lelli <juri.lelli@redhat.com>
To:     trix@redhat.com
Cc:     mingo@redhat.com, peterz@infradead.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched/deadline: fix BUG_ON() ENQUEUE_REPLENISH check
Message-ID: <20210208104131.GB5756@localhost.localdomain>
References: <20210206204851.3673588-1-trix@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210206204851.3673588-1-trix@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 06/02/21 12:48, trix@redhat.com wrote:
> From: Tom Rix <trix@redhat.com>
> 
> When the BUG_ON check for (flags != ENQUEUE_REPLENISH) was created, the
> flag was set to ENQUEUE_REPLENISH in rt_mutex_setprio(), now it is or-ed
> in.  So the checking logic needs to change.
> 
> Fixes: 1de64443d755 ("sched/core: Fix task and run queue sched_info::run_delay inconsistencies")
> Signed-off-by: Tom Rix <trix@redhat.com>
> ---
>  kernel/sched/deadline.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index 1508d126e88b..f50d20b7fe7c 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -1561,7 +1561,7 @@ static void enqueue_task_dl(struct rq *rq, struct task_struct *p, int flags)
>  		 * the throttle.
>  		 */
>  		p->dl.dl_throttled = 0;
> -		BUG_ON(!is_dl_boosted(&p->dl) || flags != ENQUEUE_REPLENISH);
> +		BUG_ON(!is_dl_boosted(&p->dl) || !(flags & ENQUEUE_REPLENISH));

Uhu, isn't this actually the else branch of "if (is_dl_boosted())"? If
yes, I don't see how this is not always triggering. :-/

Thanks,
Juri

