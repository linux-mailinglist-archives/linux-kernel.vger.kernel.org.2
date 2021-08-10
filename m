Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B67363E41B0
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 10:37:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234004AbhHIIhl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 04:37:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:25617 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233903AbhHIIhk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 04:37:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628498240;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4zFuJFjv7Ipoe76Y1gRIQ97+xgK+EKCcRN1n5Om9DKw=;
        b=ZgZqXTCYd3uiZfYid87oOvYM9QqKqfN49q/7i/6c10y62rabRh1fLDk+CYBZ3j4zNv3mrw
        KsVDF5vjYENAQ6t7LTaBB3bh5QrhKeF6KS0E2nGCREZNluRFPp/Fuygn9zCFZgeZEJjIvA
        8i53De6UgKdm3erZc75uduCHhurACZg=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-220-gYe1LvleM0CdWKXB2u4VeA-1; Mon, 09 Aug 2021 04:37:18 -0400
X-MC-Unique: gYe1LvleM0CdWKXB2u4VeA-1
Received: by mail-ed1-f71.google.com with SMTP id g3-20020a0564024243b02903be33db5ae6so4403051edb.18
        for <linux-kernel@vger.kernel.org>; Mon, 09 Aug 2021 01:37:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4zFuJFjv7Ipoe76Y1gRIQ97+xgK+EKCcRN1n5Om9DKw=;
        b=FTrnJZurSW9N5L3es/2Y0QqupI8o7i8s96ZYnOTRbhePuQjVGg5foMtcTqaoGSkv4O
         s7i0XIZOczMaTmvvdx/BiGpycs/PHclfqVILCkGfBvnVih3iZP1oON1RwqXLpgeTqdqt
         srGivVNmrlO9Jr2r2T6PjNAh0JsRy6bogwzIFLZG8CgeWBD29zPi5HwPrI0tEVXpeMi1
         VupDYi+e33VTyrcQ2ufipp2paHmKniap6Buwu7I8KDbu/nf4G88KTrvPcbfD7DtmGi/t
         dZ8lOboWrJUcIBnZXFtkbpcvR18X2yMXA/ZWfFbv58lxdAKM3rlg+WFTRGD+0mAdaP6R
         8SMg==
X-Gm-Message-State: AOAM530EJ0iPYzOe/05TcZbGFkzrpdjbGJmxQMiGjvTkdARxt4RKEXXa
        1MC76m9yDIWj2FkNarcRZTXUZUvQ0MpabHf2QFBShjbbRKAs02WFLDDUTPzuFT+DlNTFCZpP3y3
        iH8QcPgG3gMfLia0jSaX6OPed
X-Received: by 2002:aa7:d14b:: with SMTP id r11mr1782828edo.259.1628498237672;
        Mon, 09 Aug 2021 01:37:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxKNxwEsj+x2THIlv9zeYGA+s+C8pcSHCNUrpZGYVIEAkWyJQp3S5D/aRvXISxF3+JkGCcXPA==
X-Received: by 2002:aa7:d14b:: with SMTP id r11mr1782808edo.259.1628498237475;
        Mon, 09 Aug 2021 01:37:17 -0700 (PDT)
Received: from localhost.localdomain ([151.29.52.108])
        by smtp.gmail.com with ESMTPSA id g11sm7767671edt.85.2021.08.09.01.37.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Aug 2021 01:37:17 -0700 (PDT)
Date:   Mon, 9 Aug 2021 10:37:15 +0200
From:   Juri Lelli <juri.lelli@redhat.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        josh@joshtriplett.org, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org, peterz@infradead.org,
        tglx@linutronix.de, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        joel@joelfernandes.org, rcu@vger.kernel.org
Subject: Re: [PATCH] rcu: Make rcu_normal_after_boot writable on RT
Message-ID: <YRDpO6CC0LEWcj8a@localhost.localdomain>
References: <20210805080123.16320-1-juri.lelli@redhat.com>
 <20210805160337.GI4397@paulmck-ThinkPad-P17-Gen-1>
 <20210806080455.wkhlebgt7howjcrk@linutronix.de>
 <20210806174411.GQ4397@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210806174411.GQ4397@paulmck-ThinkPad-P17-Gen-1>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/08/21 10:44, Paul E. McKenney wrote:
> On Fri, Aug 06, 2021 at 10:04:55AM +0200, Sebastian Andrzej Siewior wrote:
> > On 2021-08-05 09:03:37 [-0700], Paul E. McKenney wrote:
> > > Makes sense to me!
> > > 
> > > But would another of the -rt people be willing to give an Acked-by?
> > > For example, maybe they would prefer this kernel boot parameter to be
> > > exposed only if (!PREEMPT_RT || NO_HZ_FULL).  Or are there !NO_HZ_FULL
> > > situations where rcu_normal_after_boot makes sense?
> > 
> > Julia crafted that "rcu_normal_after_boot = 1" for RT after we had more
> > and more synchronize_rcu_expedited() users popping up. I would like to
> > keep that part (default value) since it good to have for most users.
> > 
> > I don't mind removing CONFIG_PREEMPT_RT part here if there are legitimate
> > use cases for using "rcu_normal_after_boot = 0".
> > Paul suggested initially to restrict that option for PREEMPT_RT and I
> > would follow here Paul's guidance to either remove it or restrict it to
> > NO_HZ_FULL in RT's case (as suggested).
> 
> Given what I know now, I suggest the following:
> 
> o	Restrict the option to !PREEMPT_RT unless NO_HZ_FULL.
> 	Maybe "!defined(CONFIG_PREEMPT_RT) || defined(CONFIG_NO_HZ_FULL)".
> 
> 	If there is some non-NO_HZ_FULL PREEMPT_RT configuration that
> 	tolerates expedited grace periods, this would need to change.
> 
> o	Change the permissions from "0" to "0444", if desired.	If you
> 	would rather not, I can do this in a follow-up patch.  (No idea
> 	why I let such an ugly serviceability issue through, but the
> 	previous pair of module_param() instances have the same problem.)
> 
> Anything I am missing?

Not that I can think of right now. :)

Will implement your suggestions and submit v2 soon. Thank again to you
and Sebastian for the review!

Best,
Juri

