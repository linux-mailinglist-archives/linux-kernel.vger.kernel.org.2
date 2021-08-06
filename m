Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85BE63E243D
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 09:41:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238064AbhHFHl2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 03:41:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:45764 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236250AbhHFHl0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 03:41:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628235670;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KQ5uAG6ZB/PH2y+g6j7pYC8+D6CZBF5GiL6FM0n8k9c=;
        b=HH1mPM+XAXV+e8ZjHsh94p5efFvfrCZtjp7zwKshNa8iWviaO8KKZF1YJcG9dHwccEj1kn
        vjE/AyRkSZbYEQ00FMpA6/Ahuw4FuvR38vIfKYT0Sb6RoD9UfuuIsHFtwIAufH4gy/rqPW
        KfKakh9sBjIE+7rluGblWPZD9RnHwaA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-204-HQEBg0q6NtihrEBDANk30A-1; Fri, 06 Aug 2021 03:41:09 -0400
X-MC-Unique: HQEBg0q6NtihrEBDANk30A-1
Received: by mail-wm1-f72.google.com with SMTP id c41-20020a05600c4a29b0290253935d0f82so3576300wmp.9
        for <linux-kernel@vger.kernel.org>; Fri, 06 Aug 2021 00:41:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KQ5uAG6ZB/PH2y+g6j7pYC8+D6CZBF5GiL6FM0n8k9c=;
        b=KCRc0/4oJfsXx2A7NsoDaq9SVhp063D1xjlF4W/qse0eGuZZ82jlGOxU3+xJTXvqek
         zV25vYn1kAsfw9ElQx97qwau7kTs4HrHCjKzMOisdoLmUziHoZQzs7WOqy1Irj0QQkXk
         zQWrrYRXGpy7zJnCnWBKs3FZS9OfCr8ebRs3XMRoZXdV/3BlEBIWPFbq0DKP/WLV3sNL
         cvtu+LedObyl0S3VgVhqUJIi7llJFaPOSEG8dHIgLIm3D/NOu4FBUIq6PzQiZl0Re0D0
         DcZ5D/O42ayCL6+Fd2AI9iTno0RW60lLL5kOecS9RsGchNLsCGNtCHYOomUJtSN+Paue
         R4eQ==
X-Gm-Message-State: AOAM5307HxPf+PhSg4wBvBxoiGqJb0M0paPBI4WUnLsySs82v6F4rfa3
        basQ4UHSZ7qVZ0DFisSH8ooA3YQjc3/jcbmIDk6vCUBFewPw8HwOweAKyOosP6xXgr5l7iQFaBL
        gAACQAdqDJEL4mvg9Kl7QQOyz
X-Received: by 2002:a05:600c:acd:: with SMTP id c13mr1865578wmr.189.1628235668426;
        Fri, 06 Aug 2021 00:41:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxIeNVbyEjFQvuP/nx50mEMfowwJ3pAuJBOT2KcCoGtQAps+DXKwvNw1Otz+500Hn8lnUNw8w==
X-Received: by 2002:a05:600c:acd:: with SMTP id c13mr1865564wmr.189.1628235668273;
        Fri, 06 Aug 2021 00:41:08 -0700 (PDT)
Received: from localhost.localdomain ([151.29.52.108])
        by smtp.gmail.com with ESMTPSA id l7sm7614019wmj.9.2021.08.06.00.41.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Aug 2021 00:41:07 -0700 (PDT)
Date:   Fri, 6 Aug 2021 09:41:05 +0200
From:   Juri Lelli <juri.lelli@redhat.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     josh@joshtriplett.org, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org, peterz@infradead.org,
        bigeasy@linutronix.de, tglx@linutronix.de, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        joel@joelfernandes.org, rcu@vger.kernel.org
Subject: Re: [PATCH] rcu: Make rcu_normal_after_boot writable on RT
Message-ID: <YQznkbdkwE/356Vo@localhost.localdomain>
References: <20210805080123.16320-1-juri.lelli@redhat.com>
 <20210805160337.GI4397@paulmck-ThinkPad-P17-Gen-1>
 <20210805210824.GA1203206@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210805210824.GA1203206@paulmck-ThinkPad-P17-Gen-1>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Thanks for reviewing Paul.

On 05/08/21 14:08, Paul E. McKenney wrote:
> On Thu, Aug 05, 2021 at 09:03:37AM -0700, Paul E. McKenney wrote:
> > On Thu, Aug 05, 2021 at 10:01:23AM +0200, Juri Lelli wrote:
> > > Certain configurations (e.g., systems that make heavy use of netns)
> > > need to use synchronize_rcu_expedited() to service RCU grace periods
> > > even after boot.
> > > 
> > > Even though synchronize_rcu_expedited() has been traditionally
> > > considered harmful for RT for the heavy use of IPIs, it is perfectly
> > > usable under certain conditions (e.g. nohz_full).
> > > 
> > > Make rcupdate.rcu_normal_after_boot= again writeable on RT, but keep
> > > its default value to 1 (enabled) to avoid regressions. Users who need
> > > synchronize_rcu_expedited() will boot with rcupdate.rcu_normal_after_
> > > boot=0 in the kernel cmdline.
> > > 
> > > Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
> > 
> > Makes sense to me!
> > 
> > But would another of the -rt people be willing to give an Acked-by?
> > For example, maybe they would prefer this kernel boot parameter to be
> > exposed only if (!PREEMPT_RT || NO_HZ_FULL).  Or are there !NO_HZ_FULL
> > situations where rcu_normal_after_boot makes sense?
> 
> Ah, and this will also need to be reflected in the WARN_ON_ONCE()
> in synchronize_rcu_expedited_wait() in kernel/rcu/tree_exp.h.

Indeed. Will add the change as soon as I receive indication about your
first point.

Best,
Juri

