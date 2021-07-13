Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF70A3C743A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 18:18:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229867AbhGMQVK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 12:21:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbhGMQVG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 12:21:06 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB8E0C0613DD
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 09:18:15 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id bt15so7364200pjb.2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 09:18:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=A5YhPK+U85k0SKsYlDjEBbw9AMYz32iyaMx2KI0XJrU=;
        b=Qfwg9sDKAm5t+RWonrl91t9f06nWp0+7onIoZC3nBS9NUBXEur05hfosoHDL9VU2p+
         2Kf/R5KU+lhnSUhdi9MkfDM09b2TmogQwIijHnuiDDIIp4WVA6hJ+hDIid928ms23HgM
         slmX0nlW6DwQ4CAkltMqxGOvpkemWqcPgiHOX9aiP6mYrgKrf9JAX3DCRmh7ZGhJnOTI
         6n3GmonwtA2d3ngFbsWSdNEc5NwYClUrDvQuiT/QEpkhNqiSzzQYRoS9fL3YuPj38013
         GZpacX8lefNmjSpZPHpI0XzbxTdyuxMgKp6wVqMy9nZVfdu1sqq0jZZqqdo8DPqu9/8C
         5L7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=A5YhPK+U85k0SKsYlDjEBbw9AMYz32iyaMx2KI0XJrU=;
        b=sHR6mMpIKA+LGjkE+gXoyA9/CjPvuNw2rdadaVyLYalDdoTM5h8GPCVH45thmgLt65
         yyr4HBpErD/C1U5fvfDMHDJASokcId6CZFNDberG7D5tZ30pfhex5kx1tSppa+QBOPxg
         bMjICoiAJezB9efzZ1clupskVF9SmPmXro0N76jaxjxDVMBo9FCpfaELajVaBwha//ks
         WYMuP+IiJ57NP+nxTpSJ/qrtdladU0yhBVI9TPkqC42h75Dcj5otfHjeYEqn0L0/onRK
         wUSdlUZvMEHoXCnOPQhD4ICK22aiiZ53dJmP/Y17g+hUSkwjQSCdtJ4dq6XlEcV4JT3A
         fGWg==
X-Gm-Message-State: AOAM533V/Sr+9I0dWwWgqBTB92gu0csgXtIKxGdRDYpyvEr2OENf+kT/
        bK99ApspOlw0sYjaYK1EsrU=
X-Google-Smtp-Source: ABdhPJwVhN6L+kJszXRvnMuSIYrAht9+csgEepd9qKOYZZBY55Rj/lptLWbzmby7tlaBDRljmcRWow==
X-Received: by 2002:a17:902:ead2:b029:12a:ec28:7bc9 with SMTP id p18-20020a170902ead2b029012aec287bc9mr4034711pld.79.1626193095174;
        Tue, 13 Jul 2021 09:18:15 -0700 (PDT)
Received: from localhost (udp264798uds.hawaiiantel.net. [72.253.242.87])
        by smtp.gmail.com with ESMTPSA id j20sm17014874pfc.203.2021.07.13.09.18.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jul 2021 09:18:14 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 13 Jul 2021 06:18:13 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Lai Jiangshan <jiangshanlai@gmail.com>
Cc:     Yang Yingliang <yangyingliang@huawei.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Xu Qiang <xuqiang36@huawei.com>,
        Pavel Skripkin <paskripkin@gmail.com>
Subject: Re: [PATCH v2] workqueue: fix UAF in pwq_unbound_release_workfn()
Message-ID: <YO28xd4mlxgN6xY8@slm.duckdns.org>
References: <20210709071100.4057639-1-yangyingliang@huawei.com>
 <YOx392cwdEHMMnD0@slm.duckdns.org>
 <CAJhGHyC+oyX6fqnR1-JPnNgPuDpikU6KYr1iXrj7BDZHnjPGTA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJhGHyC+oyX6fqnR1-JPnNgPuDpikU6KYr1iXrj7BDZHnjPGTA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Lai.

On Tue, Jul 13, 2021 at 01:56:12PM +0800, Lai Jiangshan wrote:
> > Does something like the following work?
> 
> It works since it has a flush_scheduled_work() in
> alloc_and_link_pwqs(). But I don't think it works for
> workqueue_apply_unbound_cpumask() when apply_wqattrs_commit()
> is not called.

Yeah, but in that path, wq is fully initialized and will always have
existing pwqs, so the wq free path shouldn't get activated. During wq
allocation, the problem is that we're installing the first set of pwqs, so
if they fail, the workqueue doesn't have any pwqs and thus triggers
self-destruction.

> If we want to reuse the current apply_wqattrs_cleanup(), I would prefer
> something like this: (untested)
> 
> @@ -3680,15 +3676,21 @@ static void pwq_unbound_release_workfn(struct
> work_struct *work)
>                                                   unbound_release_work);
>         struct workqueue_struct *wq = pwq->wq;
>         struct worker_pool *pool = pwq->pool;
> -       bool is_last;
> +       bool is_last = false;
> 
> -       if (WARN_ON_ONCE(!(wq->flags & WQ_UNBOUND)))
> -               return;
> +       /*
> +        * when @pwq is not linked, it doesn't hold any reference to the
> +        * @wq, and @wq is invalid to access.
> +        */
> +       if (!list_empty(&pwq->pwqs_node)) {
> +               if (WARN_ON_ONCE(!(wq->flags & WQ_UNBOUND)))
> +                       return;
> 
> -       mutex_lock(&wq->mutex);
> -       list_del_rcu(&pwq->pwqs_node);
> -       is_last = list_empty(&wq->pwqs);
> -       mutex_unlock(&wq->mutex);
> +               mutex_lock(&wq->mutex);
> +               list_del_rcu(&pwq->pwqs_node);
> +               is_last = list_empty(&wq->pwqs);
> +               mutex_unlock(&wq->mutex);
> +       }
> 
>         mutex_lock(&wq_pool_mutex);
>         put_unbound_pool(pool);

But, oh yeah, this is way better.

Thanks.

-- 
tejun
