Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A147C3803D6
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 08:55:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232410AbhENG4k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 02:56:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232806AbhENG4g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 02:56:36 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A7CCC061574
        for <linux-kernel@vger.kernel.org>; Thu, 13 May 2021 23:55:25 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id l7so33608044edb.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 May 2021 23:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=t0liGRDtfvW+Hd6TB9/6L6IGf9mv2RbxGFEQgpEYAkk=;
        b=PaQGeLBDvCsfMgBY+xQBlsQlYHecPL6o1ooJCSBjHCtO0OFXL46QouL3pNlt39kccy
         b2RGS0icoPz+VKh/GUt78j34CNIkc7FRjnP4Eh7MYsJPR+Qco4naJvAqMxA5kvZAScWF
         w01760z0uGqsRKEByvozM3o1Wk71NKV9dJ+mK+KYU0jy7G93ksEYNQac/kg5zhO50zHs
         PcWynnKCuNy/sULaZwUfSRLw7wBoyCG4kYz6E/rSnYA1drQl70I2YCYo6MYUn5YChR0K
         DeJmcyqTCcNUY7LRqy6jNSwVg7BYn9EdMJcynCUaKd6ACdEGuOeExjYMU668+KpyV4ZQ
         16Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=t0liGRDtfvW+Hd6TB9/6L6IGf9mv2RbxGFEQgpEYAkk=;
        b=GTbHa6nICEjkOrWjl4Ir5QoJRYyFJOPLDr+YjYlXQKgXjMfuUpRbXyUnT6rExzNR0Y
         Vw5gy14HR2WeRTiAvhLJ9KhwTJlfX/iUMSpY0BJ49XBbajk3MitumuxYs0YlM3wsVOSz
         CAMWjkk9XMps30h025ncAjd6ZtsjIOY/Tf9/SNCxBLVSYlG5uNIHPkilkux4n5+poPDx
         RMbnVNdkvxTGBYgf+PP2/waI62CfSAr7UVSIKQbJEuTvEUAOs55ZmvoTWMIPZTfGxWYm
         eY5wIRrSWYFUC7MQ1A2OFy7YLkScYkUnFJ3U9YKPWt0XWgHUgyd+IE88LEccy0Br66Ab
         TRfQ==
X-Gm-Message-State: AOAM531lBiIsvlSt1e/IVt/Kf7lj58BzqNf1q0o0MONfjycOMNg/Ok4y
        ljTyB65KXOPSffB9n4toVj8=
X-Google-Smtp-Source: ABdhPJxBy0XTCUbGBrjCRC2pU1/SVomIxXfWFcx8IWAzfb9mJ/fw4gZNjc+/OSdhrmxiY9RESzuDxQ==
X-Received: by 2002:aa7:dd57:: with SMTP id o23mr16230192edw.98.1620975324226;
        Thu, 13 May 2021 23:55:24 -0700 (PDT)
Received: from gmail.com (0526E777.dsl.pool.telekom.hu. [5.38.231.119])
        by smtp.gmail.com with ESMTPSA id i19sm3000844ejd.114.2021.05.13.23.55.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 May 2021 23:55:23 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Fri, 14 May 2021 08:55:22 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Paul Gortmaker <paul.gortmaker@windriver.com>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: Re: [PATCH] sched/isolation: reconcile rcu_nocbs= and nohz_full=
Message-ID: <YJ4e2j+FewuJ4zdZ@gmail.com>
References: <20210419042659.1134916-1-paul.gortmaker@windriver.com>
 <20210422212448.GJ975577@paulmck-ThinkPad-P17-Gen-1>
 <YJ0X6MciAc36TMJc@gmail.com>
 <20210513142216.GZ975577@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210513142216.GZ975577@paulmck-ThinkPad-P17-Gen-1>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Paul E. McKenney <paulmck@kernel.org> wrote:

> On Thu, May 13, 2021 at 02:13:28PM +0200, Ingo Molnar wrote:
> > 
> > * Paul E. McKenney <paulmck@kernel.org> wrote:
> > 
> > > On Mon, Apr 19, 2021 at 12:26:59AM -0400, Paul Gortmaker wrote:
> > > > We have a mismatch between RCU and isolation -- in relation to what is
> > > > considered the maximum valid CPU number.
> > > > 
> > > > This matters because nohz_full= and rcu_nocbs= are joined at the hip; in
> > > > fact the former will enforce the latter.  So we don't want a CPU mask to
> > > > be valid for one and denied for the other.
> > > > 
> > > > The difference 1st appeared as of v4.15; further details are below.
> > > 
> > > I pulled this into -rcu for testing and further review.
> > > 
> > > If it should instead go through some other tree:
> > > 
> > > Acked-by: Paul E. McKenney <paulmck@kernel.org>
> > 
> > Thanks - added this fix to tip:sched/core.
> 
> Very good, I will drop it from -rcu later today, Pacific Time.

Thank you!

	Ingo
