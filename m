Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CFEE4457AB
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Nov 2021 17:55:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231740AbhKDQ55 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 12:57:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231898AbhKDQ54 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 12:57:56 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3962AC061714
        for <linux-kernel@vger.kernel.org>; Thu,  4 Nov 2021 09:55:18 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id b17so5671376qvl.9
        for <linux-kernel@vger.kernel.org>; Thu, 04 Nov 2021 09:55:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=y5i/ZduOW81D4EUn+I3tHviCo4oaWhUuA+1PrfJRYmc=;
        b=xHGRpmD5UBUQv1iB6YmuOVQPXdj51+ocNGLEACFiywODZIxuxYeGv1nnpgZRYLwWoL
         Dfau4z36UlxAYjcAYGsh6gvTP3KFzvftPLYJ5N4JYon/TJQP2yAHIdpRrP6pPllZ7W9Z
         rNDOeKwEVlC62PV162yQonxwx4MvXFLC4MvMR72UndPPB7Zbc+JY7Cn2J2G5yh/aW5t1
         Qq3PWjwJhnPtsHq9yqwEVtqrCIW0EGurS+qm40HAk/YBsWPGP3iba7U0tf2JIpPYOWlT
         Sz5ssJxqER7wwfegEToZrxOVDmc2GcD+GMm6CUeCRqDFb5PKm5yeux7fgRoCPckG/5/V
         rb8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=y5i/ZduOW81D4EUn+I3tHviCo4oaWhUuA+1PrfJRYmc=;
        b=anx+rZGJ05RQafDgV2ketD2SfdupbX5bmUBX7MDKeVJRps2o/vvFUbYHFEdVdVAsUt
         TV7bMWjBud4QH5FgUb16VxogKIWCaa8mdcPF9+Vx/uoMIAOVt9Ia8Gc45zDoUmpPAp1X
         5Tmx/CFPa8XjVl6b2dvyIyizEc+2ktENnZsmfcNdtiiM+3u23KRPF5zpTTFu772QFiXO
         opltUaP6lq+Kjn/E7Mr+9ry+MRoG8naCf1vyHwoMuHp493KWKn5pdNSwQcO/eSEOm90r
         t8YeAZlBDygL34nVXHAMKNPaQGtuR2QCvfzpWEKlP7P0kfZYZzuizZvHQm9KYGrHzd3C
         W8lw==
X-Gm-Message-State: AOAM5308BnfEbH1GXn+BGLN3TwnDuC1/Wxmv1xIut0XirxWgRJPrHA5I
        pY4zLNyl7x0fqUm6Jqubg6AEew==
X-Google-Smtp-Source: ABdhPJzHQVl4eP5qEhmA5APtEI9XvgnZhyGiqm5p6rb023W6muu3nW7OOU+LVPj4tvQxD5m+SkVvxA==
X-Received: by 2002:a05:6214:4019:: with SMTP id kd25mr13847312qvb.27.1636044917471;
        Thu, 04 Nov 2021 09:55:17 -0700 (PDT)
Received: from localhost (cpe-98-15-154-102.hvc.res.rr.com. [98.15.154.102])
        by smtp.gmail.com with ESMTPSA id s22sm4167463qko.88.2021.11.04.09.55.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Nov 2021 09:55:16 -0700 (PDT)
Date:   Thu, 4 Nov 2021 12:55:16 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Ravi Singh <ravi.singh1@samsung.com>
Cc:     mingo@redhat.com, peterz@infradead.org,
        linux-kernel@vger.kernel.org, a.sahrawat@samsung.com,
        v.narang@samsung.com, vishal.goel@samsung.com,
        Suren Baghdasaryan <surenb@google.com>
Subject: Re: [PATCH] psi: fix integer overflow on unsigned int multiply on 32
 bit systems
Message-ID: <YYQQdI8rjvN4ZEOd@cmpxchg.org>
References: <CGME20210913085226epcas5p2b516f0f591926c927faa9c60d211bf44@epcas5p2.samsung.com>
 <1631523095-8672-1-git-send-email-ravi.singh1@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1631523095-8672-1-git-send-email-ravi.singh1@samsung.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CC Suren

Sorry, this fell through the cracks.

On Mon, Sep 13, 2021 at 02:21:35PM +0530, Ravi Singh wrote:
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

Fixes: 0e94682b73bf psi: introduce psi monitor
Acked-by: Johannes Weiner <hannes@cmpxchg.org>

Peter would you mind taking this through -tip?

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
