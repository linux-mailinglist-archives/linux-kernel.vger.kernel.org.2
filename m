Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0ED293CA8FB
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 21:02:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243663AbhGOTEh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 15:04:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240737AbhGOSz0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 14:55:26 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3073EC0613DD
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jul 2021 11:52:29 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id k27so9567476edk.9
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jul 2021 11:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kJ88EjazyOKPw/49phuHykQKOMgzYSZ8ZZOI0xPupOA=;
        b=TOXldOxGUxbSo2Y5aluU+bBZho1QOn4ViWhGvsTvkwOnOd3OTPacRrtP628JIxi/Ur
         Blxfr1UtgwHrUplNfxCDja5NMYKjeXLV+WAIUQW+onPO+q1/h+ODzbwS2cnJ+oMUgzxT
         F7H8WUS+CAvYJOCAEAARQf31WkkkyZ24/I7q9OQ9DHW3dtNp91xmirxHmE3VHYYm6N4G
         RvAl4nEV1+b7jf3E+x1XXvmLHbM++Zzm4If/0+wSWTwdJtfPp7f6uZl+8D+UKLL5vax6
         8y4/HpAyj5aTzK8wlyXGfQP3coJgLSz9BPt1JzXIp3gr+uzrXIRQA/MACmIHi/2KEiRj
         RQew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kJ88EjazyOKPw/49phuHykQKOMgzYSZ8ZZOI0xPupOA=;
        b=Wok/+bORp5b4RdyVXLcIgy7ARfxoArj1AMIoX/tODtTXDGxDhpzSOr8hMC9emSlgbN
         bOsEXsG3hvFQYufNbf1nK51yqeQDz8i7GZjrTFljWixcmbeznyoX0SET2ZNjH/Gsico3
         JMDn/uGSqNOfNQSJ9TCYc7ikGTEKgsmCCHQO7c6KrUX5t2WJgOc8NI7O+jNiXgHLfZ3x
         wlOTNWEDaW7CqsTxjsylYIZv4c7/h1nUKVJAB0QH9sspC8KHMsKjdkyJz3ODIaCfH2jt
         0XPP64GijTIH46yPiocr3M/S+g8MUVPUtfUX9nNbFQzJf4qG1i9tABqZvJUVXHVjIKD/
         ajpg==
X-Gm-Message-State: AOAM533zsCfb0sIaQlQ57u9qF1D0mI5CNbdf7RntnSxXdkp16PgxL2xK
        zTrKS5a7PnLKjEEt6iM0nyo=
X-Google-Smtp-Source: ABdhPJwz5DNX/pwKUKpOT+z7ukbh36kASOqq0eJbQN6rGL5y4AUrUQzvymupVco4qtxicU3arYTALw==
X-Received: by 2002:a05:6402:198:: with SMTP id r24mr9101473edv.93.1626375147731;
        Thu, 15 Jul 2021 11:52:27 -0700 (PDT)
Received: from localhost.localdomain ([176.30.111.253])
        by smtp.gmail.com with ESMTPSA id d19sm2803519eds.54.2021.07.15.11.52.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jul 2021 11:52:27 -0700 (PDT)
Date:   Thu, 15 Jul 2021 21:52:19 +0300
From:   Pavel Skripkin <paskripkin@gmail.com>
To:     Lai Jiangshan <jiangshanlai@gmail.com>
Cc:     Yang Yingliang <yangyingliang@huawei.com>,
        LKML <linux-kernel@vger.kernel.org>, Tejun Heo <tj@kernel.org>,
        Xu Qiang <xuqiang36@huawei.com>
Subject: Re: [PATCH v3] workqueue: fix UAF in pwq_unbound_release_workfn()
Message-ID: <20210715215219.061a2f25@gmail.com>
In-Reply-To: <CAJhGHyA+8p7mHR4o2VoAFTxKKtAC4Aeq1cwtszaVj-OS63KUgA@mail.gmail.com>
References: <20210714091934.3124170-1-yangyingliang@huawei.com>
        <CAJhGHyA+8p7mHR4o2VoAFTxKKtAC4Aeq1cwtszaVj-OS63KUgA@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8git77 (GTK+ 2.24.33; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Jul 2021 16:08:12 +0800
Lai Jiangshan <jiangshanlai@gmail.com> wrote:

> On Wed, Jul 14, 2021 at 5:16 PM Yang Yingliang
> <yangyingliang@huawei.com> wrote:
> 
> >
> > Fixes: 2d5f0764b526 ("workqueue: split apply_workqueue_attrs() into
> > 3 stages") Reported-by: Hulk Robot <hulkci@huawei.com>
> > Suggested-by: Lai Jiangshan <jiangshanlai@gmail.com>
> > Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> > ---
> > v3:
> >   drop the v2 and v1 changes, add check pwq in
> > pwq_unbound_release_workfn() v2:
> >   also use free_wqattrs_ctx() in workqueue_apply_unbound_cpumask()
> > ---
> >  kernel/workqueue.c | 20 +++++++++++++-------
> >  1 file changed, 13 insertions(+), 7 deletions(-)
> >
> 
> I'm fine with the code.
> 
> Reviewed-by: Lai Jiangshan <jiangshanlai@gmail.com>
> 
> Hello, Pavel
> 
> Could you have a test again, please?
> 

Hi, Lai!

Sorry for late response.

Yes, I have started local syzkaller instance just now, so I will share
the results tomorrow. 


> Thanks,
> Lai
> 
> > diff --git a/kernel/workqueue.c b/kernel/workqueue.c
> > index 50142fc08902..f148eacda55a 100644
> > --- a/kernel/workqueue.c
> > +++ b/kernel/workqueue.c
> > @@ -3676,15 +3676,21 @@ static void
> > pwq_unbound_release_workfn(struct work_struct *work)
> > unbound_release_work); struct workqueue_struct *wq = pwq->wq;
> >         struct worker_pool *pool = pwq->pool;
> > -       bool is_last;
> > +       bool is_last = false;
> >
> > -       if (WARN_ON_ONCE(!(wq->flags & WQ_UNBOUND)))
> > -               return;
> > +       /*
> > +        * when @pwq is not linked, it doesn't hold any reference
> > to the
> > +        * @wq, and @wq is invalid to access.
> > +        */
> > +       if (!list_empty(&pwq->pwqs_node)) {
> > +               if (WARN_ON_ONCE(!(wq->flags & WQ_UNBOUND)))
> > +                       return;
> >
> > -       mutex_lock(&wq->mutex);
> > -       list_del_rcu(&pwq->pwqs_node);
> > -       is_last = list_empty(&wq->pwqs);
> > -       mutex_unlock(&wq->mutex);
> > +               mutex_lock(&wq->mutex);
> > +               list_del_rcu(&pwq->pwqs_node);
> > +               is_last = list_empty(&wq->pwqs);
> > +               mutex_unlock(&wq->mutex);
> > +       }
> >
> >         mutex_lock(&wq_pool_mutex);
> >         put_unbound_pool(pool);
> > --
> > 2.25.1
> >


With regards,
Pavel Skripkin

