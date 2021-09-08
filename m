Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A7F84038CA
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 13:33:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349190AbhIHLdk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 07:33:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233694AbhIHLdj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 07:33:39 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 447A9C061575
        for <linux-kernel@vger.kernel.org>; Wed,  8 Sep 2021 04:32:32 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id 4so1216204qvp.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 Sep 2021 04:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=dGqDBNeImnlpPB+fs7MgCAcmpAqznzgXXA/D+4qA06o=;
        b=jzVOZYESov2a5VL3sQFR5E/Uw54T5pZbWSarFTKJb9HWHvGKCzxNi6pqflNyPSguss
         jiO16tAm4nIWFzLXq1Bk6Fm86RYfeJSVN1UmnWfxBWJClbsb+ozMRkBsx+e2+ZKkaJP1
         amAkUDZRDr/nkX9gd5QEyPJopaV26p/kuz3GdsxbRJMU+emmqzVw+mKmppUsAkL+efNM
         RsbtaWNXBVXijmKqeQaA+mz+sYzUoMQyn/xEq/s7R9BqUlE9SAOWOWqfSJIjRHCQCuLV
         DXgK7tO6XbmyyO44dSOriqyCDwtjJNU2hLFRgOlMrf5GqL8iA9TdeL3Qhu0O9qCiVMn5
         dtoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dGqDBNeImnlpPB+fs7MgCAcmpAqznzgXXA/D+4qA06o=;
        b=Y9bNT0wdcPFi2/WoyuAgj+BBBRu2d2rRzgUaL/h3fc2+ozyikFElB1townBZiez/rJ
         j88lV3Sfl+08bSAk5i0xSSYbno4YSEV972zmUGaTv9LbjO1CF1QtuyUObCl1o4VIYt0n
         qFETZZSXg2m471owqmHO7nKo9k/Tdhr5PG7x0g5LmCoPlmru5uCPdyUujbeBQwDYGfVx
         tvgXeqN1Kcd/hw07n1YiXQ9uh1X5rWcVS+A7nZEjcjgfR68aEtKeT+fNyfFf1d7ldUYV
         d6eF3/k7RZiAMFMLTwug/vZF1oUoIhNmUGpnAn+PpjVQGxrnXFAB6I8XXrzh/W03NVDC
         ghug==
X-Gm-Message-State: AOAM53312Ki1hGzR9Luit0v+zFMYXopF+x4vOraLxGLmxpUCL4j8rXdO
        9KEQ7afGhJmnrVDRbRU7/Zb/Og==
X-Google-Smtp-Source: ABdhPJxmOb2XHCvNsxDX7Z0jfaVtgPhbKAdnBalix+36RPRrrAxj9KZUPl2TI8dRvuQ0Y4EJny0DQA==
X-Received: by 2002:a0c:cb10:: with SMTP id o16mr3334416qvk.57.1631100751517;
        Wed, 08 Sep 2021 04:32:31 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:190a])
        by smtp.gmail.com with ESMTPSA id j23sm1486722qkl.65.2021.09.08.04.32.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Sep 2021 04:32:30 -0700 (PDT)
Date:   Wed, 8 Sep 2021 07:32:29 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Ravi Singh <ravi.singh1@samsung.com>
Cc:     mingo@redhat.com, peterz@infradead.org,
        linux-kernel@vger.kernel.org, a.sahrawat@samsung.com,
        v.narang@samsung.com, vishal.goel@samsung.com,
        Suren Baghdasaryan <surenb@google.com>
Subject: Re: [PATCH] psi: fix integer overflow on unsigned int multiply on 32
 bit systems
Message-ID: <YTifTWj6xsLZSjLA@cmpxchg.org>
References: <CGME20210906122653epcas5p19c46576f0be4d4a101f851a751addde8@epcas5p1.samsung.com>
 <1630931124-27197-1-git-send-email-ravi.singh1@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1630931124-27197-1-git-send-email-ravi.singh1@samsung.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CC Suren

On Mon, Sep 06, 2021 at 05:55:24PM +0530, Ravi Singh wrote:
> psi accepts window sizes upto WINDOW_MAX_US(10000000). In the case
> where window_us is larger than 4294967, the result of an
> multiplication overflows an unsigned int/long(4 bytes on 32 bit
> system).
> 
> For example, this can happen when the window_us is 5000000 so 5000000
> * 1000 (NSEC_PER_USEC) will result in 5000000000 which is greater than
> UINT_MAX(4294967295). Due to this overflow, 705032704 is stored in
> t->win.size instead of 5000000000. Now psi will be monitoring the
> window size of 705 msecs instead of 5 secs as expected by user.
> 
> Fix this by type casting the first term of the mutiply to a u64.
> 
> Issue doesnot occur on 64 bit systems because NSEC_PER_USEC is of type
> long which is 8 bytes on 64 bit systems.
> 
> Signed-off-by: Ravi Singh <ravi.singh1@samsung.com>
> Signed-off-by: Vishal Goel <vishal.goel@samsung.com>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

> ---
>  kernel/sched/psi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
> index 1652f2bb5..a2cc33dc2 100644
> --- a/kernel/sched/psi.c
> +++ b/kernel/sched/psi.c
> @@ -1145,7 +1145,7 @@ struct psi_trigger *psi_trigger_create(struct psi_group *group,
>  	t->group = group;
>  	t->state = state;
>  	t->threshold = threshold_us * NSEC_PER_USEC;
> -	t->win.size = window_us * NSEC_PER_USEC;
> +	t->win.size = (u64)window_us * NSEC_PER_USEC;
>  	window_reset(&t->win, 0, 0, 0);
>  
>  	t->event = 0;
> -- 
> 2.17.1
> 
