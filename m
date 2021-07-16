Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8A2A3CB63F
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 12:45:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239428AbhGPKsn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jul 2021 06:48:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238724AbhGPKsl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jul 2021 06:48:41 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1B7AC06175F
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jul 2021 03:45:45 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id v1so12365206edt.6
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jul 2021 03:45:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3flRRS1i6t5c9P+PfXfZyD/X4s/02S8yg63leN3E44E=;
        b=tcft6vARSOcqkDF5Hk5zu2hzbTG/lnZjVZmTdyoj+JueGcB5ac+AoV1cvBSs7f8MXF
         pKFGGFB49A5SbM024wv8Ogh3+EEnjX5F3Hk/QEgN19vMSitkzrBF6NX0wWfQcV91P78a
         7XIguPiUxBhqu8zj+HuknLjqJAyH0VI6G/breynPOJogzqXdqQIbPDhTRNIcLHquu7Ck
         DDpvapslUw+Z3q5HkElx2B6D8deXRXvOGg5uEITAGrfZHspNG3hPSrcZ+5taQCdFRgH+
         SN/rGsHKjlMP40BxAVG3QVR0bv2BGtuL5e9nRbhoXSJvENc4jhdGR1+5xZRDkzdSTrGB
         of9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3flRRS1i6t5c9P+PfXfZyD/X4s/02S8yg63leN3E44E=;
        b=JeabvnZ0BnKzXekFjcyThP+LgQhCXtgzZcNx/60UKcL/Ar3i4AIYo+vueKf1la040A
         Ph3w1kIBbSKhtzhlVWrQmcnxihtRAwmfeTlMgdDzzS96eKOaNYQQLRcMjewX6BTnitZK
         zRxspHf7OMbnQm/e29czFG0sLqcgGdQ2YkboJvY7vAqzOY5aqJUAnvo+qbAmFFUyOHLN
         DcLDnDKcDTWb2GiBLymorFRd5JbAD7LA8HNLDtkMoNcztGYJAx0mDWvA8d8IUAHoe3R2
         HpnJBY7SQrGvPATTSHPuLZo2pLreIUlvtG3GZDtvd12vfJT51z/bvYp7nRTF5JFK3kLX
         QAOQ==
X-Gm-Message-State: AOAM5303qhbbEt7Ogz0JmXlaFsEfoykshGss1/5Emr2BErKbUFH3SE/Y
        IFkAElYgFsY1JjM6kkqtp5w=
X-Google-Smtp-Source: ABdhPJyo7YYgurNB7ZHc/qd9z9fXFIikEWGBtjJ58IFeujC7/fXbackii057Ubl6xNZFG+lb22vEJg==
X-Received: by 2002:aa7:c1cc:: with SMTP id d12mr13879985edp.282.1626432344402;
        Fri, 16 Jul 2021 03:45:44 -0700 (PDT)
Received: from localhost.localdomain ([5.176.51.215])
        by smtp.gmail.com with ESMTPSA id qo6sm2755332ejb.122.2021.07.16.03.45.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jul 2021 03:45:44 -0700 (PDT)
Date:   Fri, 16 Jul 2021 13:45:33 +0300
From:   Pavel Skripkin <paskripkin@gmail.com>
To:     Lai Jiangshan <jiangshanlai@gmail.com>
Cc:     Yang Yingliang <yangyingliang@huawei.com>,
        LKML <linux-kernel@vger.kernel.org>, Tejun Heo <tj@kernel.org>,
        Xu Qiang <xuqiang36@huawei.com>
Subject: Re: [PATCH v3] workqueue: fix UAF in pwq_unbound_release_workfn()
Message-ID: <20210716134533.17e82d88@gmail.com>
In-Reply-To: <20210715215219.061a2f25@gmail.com>
References: <20210714091934.3124170-1-yangyingliang@huawei.com>
        <CAJhGHyA+8p7mHR4o2VoAFTxKKtAC4Aeq1cwtszaVj-OS63KUgA@mail.gmail.com>
        <20210715215219.061a2f25@gmail.com>
X-Mailer: Claws Mail 3.17.8git77 (GTK+ 2.24.33; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Jul 2021 21:52:19 +0300
Pavel Skripkin <paskripkin@gmail.com> wrote:

> On Thu, 15 Jul 2021 16:08:12 +0800
> Lai Jiangshan <jiangshanlai@gmail.com> wrote:
> 
> > On Wed, Jul 14, 2021 at 5:16 PM Yang Yingliang
> > <yangyingliang@huawei.com> wrote:
> > 
> > >
> > > Fixes: 2d5f0764b526 ("workqueue: split apply_workqueue_attrs()
> > > into 3 stages") Reported-by: Hulk Robot <hulkci@huawei.com>
> > > Suggested-by: Lai Jiangshan <jiangshanlai@gmail.com>
> > > Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> > > ---
> > > v3:
> > >   drop the v2 and v1 changes, add check pwq in
> > > pwq_unbound_release_workfn() v2:
> > >   also use free_wqattrs_ctx() in workqueue_apply_unbound_cpumask()
> > > ---
> > >  kernel/workqueue.c | 20 +++++++++++++-------
> > >  1 file changed, 13 insertions(+), 7 deletions(-)
> > >
> > 
> > I'm fine with the code.
> > 
> > Reviewed-by: Lai Jiangshan <jiangshanlai@gmail.com>
> > 
> > Hello, Pavel
> > 
> > Could you have a test again, please?
> > 
> 
> Hi, Lai!
> 
> Sorry for late response.
> 
> Yes, I have started local syzkaller instance just now, so I will share
> the results tomorrow. 
> 

Hi, everyone!

With this patch applied my local syzbot instance didn't hit any of the
reported bugs [1].

Tested-by: Pavel Skripkin <paskripkin@gmail.com> 


Thank you!


[1] https://lore.kernel.org/lkml/20210708162417.777bff77@gmail.com/

With regards,
Pavel Skripkin

> 
> > Thanks,
> > Lai
> > 
> > > diff --git a/kernel/workqueue.c b/kernel/workqueue.c
> > > index 50142fc08902..f148eacda55a 100644
> > > --- a/kernel/workqueue.c
> > > +++ b/kernel/workqueue.c
> > > @@ -3676,15 +3676,21 @@ static void
> > > pwq_unbound_release_workfn(struct work_struct *work)
> > > unbound_release_work); struct workqueue_struct *wq = pwq->wq;
> > >         struct worker_pool *pool = pwq->pool;
> > > -       bool is_last;
> > > +       bool is_last = false;
> > >
> > > -       if (WARN_ON_ONCE(!(wq->flags & WQ_UNBOUND)))
> > > -               return;
> > > +       /*
> > > +        * when @pwq is not linked, it doesn't hold any reference
> > > to the
> > > +        * @wq, and @wq is invalid to access.
> > > +        */
> > > +       if (!list_empty(&pwq->pwqs_node)) {
> > > +               if (WARN_ON_ONCE(!(wq->flags & WQ_UNBOUND)))
> > > +                       return;
> > >
> > > -       mutex_lock(&wq->mutex);
> > > -       list_del_rcu(&pwq->pwqs_node);
> > > -       is_last = list_empty(&wq->pwqs);
> > > -       mutex_unlock(&wq->mutex);
> > > +               mutex_lock(&wq->mutex);
> > > +               list_del_rcu(&pwq->pwqs_node);
> > > +               is_last = list_empty(&wq->pwqs);
> > > +               mutex_unlock(&wq->mutex);
> > > +       }
> > >
> > >         mutex_lock(&wq_pool_mutex);
> > >         put_unbound_pool(pool);
> > > --
> > > 2.25.1
> > >
> 
> 
> With regards,
> Pavel Skripkin
> 
