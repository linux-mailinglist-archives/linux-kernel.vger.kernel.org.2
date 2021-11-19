Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DD4045764E
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Nov 2021 19:21:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233721AbhKSSYm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Nov 2021 13:24:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231751AbhKSSYl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Nov 2021 13:24:41 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ED06C061574
        for <linux-kernel@vger.kernel.org>; Fri, 19 Nov 2021 10:21:39 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id g18so10042773pfk.5
        for <linux-kernel@vger.kernel.org>; Fri, 19 Nov 2021 10:21:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5lDjGwaLStX0YuF6X4qKDjVvX33y5EJ3EcAHIHofVYs=;
        b=Gg68D7+NRLoihQXvo2MkeMqRaJNvBqxEaQGb3LhwdToXCi2zv4dX0OZw5O5XAbuIf7
         k66KnrXo+4Rg0sbM49HCZJ2/SoUlDJHJ2UbBVRdHGBAeDXwvZOQfzUi80IiEjBjXvxgO
         AuYT29UFM7/aANaFS/nd4NImAs1oTFL8szHN/N7H0HJagAi+jBNPX/p/ozLbIGR3dKsn
         Lod+as3RORU2OksSKaOiWXeID77MSffOhVav7TnAfjLsi8Rttm1JUFgncn4gN2Zyb9dU
         KPK5rDrrsG5w0UOoVJ4mQSYnpcAvlxnJLEoMOMlYoQu4MFMTyX76UGecplEILgmk3vYZ
         dWLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=5lDjGwaLStX0YuF6X4qKDjVvX33y5EJ3EcAHIHofVYs=;
        b=Uo01aZtdwXW9wFTL8N2JWUaLdELI8ZUbhB+qMbqFarAqYuKupBcJ2PnZW3kutEFy69
         fXZRJ7MobphdoxgmGU5SCCBKkeceb5j4+I+OElZvxZ5qzkCssAXOJfs2PK8N1TE7dvpO
         L1NkSFwg20hZ4eZeJLPe+2HAzmyTGILgkEzm4XFREqeXL+ffXqH72GmIJErXqLPKQDEr
         lZezGGI3KzbF+6Ut5DMIlcSBfFSvdtjn8WqvZkxlmjYPEWyyHcao/p+ZvwDG34RP/zjP
         1Wt5p+NFCmYrgyHfhF8mIAHKg3+tB979Nd2OAfR/FG3Bl0l76fCh2HHdrasMOfi744xl
         g5RA==
X-Gm-Message-State: AOAM531Zz9Hj2O8Ru1sG8+mCPJ/R7GFaEomrmI/crB4rvXBkL8mktRjk
        XLk7yhvW1n4ypM/mcRLx848=
X-Google-Smtp-Source: ABdhPJxUnRUZPlQ+xy3cvarH0Xj9D8ZawPd7IJA9TqDKvtd4AiLILq1TixU7XvAqkPVyayKGGO/ilg==
X-Received: by 2002:a63:3348:: with SMTP id z69mr18864195pgz.177.1637346099083;
        Fri, 19 Nov 2021 10:21:39 -0800 (PST)
Received: from google.com ([2620:15c:211:201:9e42:f629:9f4e:600f])
        by smtp.gmail.com with ESMTPSA id l21sm11582938pjt.24.2021.11.19.10.21.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Nov 2021 10:21:38 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Fri, 19 Nov 2021 10:21:37 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v2 7/9] locking/rwlocks: introduce write_lock_nested
Message-ID: <YZfrMTAXV56HFWJY@google.com>
References: <20211115185909.3949505-1-minchan@kernel.org>
 <20211115185909.3949505-8-minchan@kernel.org>
 <20211119103516.24uhxrkdcy4vq25k@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211119103516.24uhxrkdcy4vq25k@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 19, 2021 at 11:35:16AM +0100, Sebastian Andrzej Siewior wrote:
> On 2021-11-15 10:59:07 [-0800], Minchan Kim wrote:
> > diff --git a/include/linux/rwlock_rt.h b/include/linux/rwlock_rt.h
> > index 49c1f3842ed5..efd6da62c893 100644
> > --- a/include/linux/rwlock_rt.h
> > +++ b/include/linux/rwlock_rt.h
> > @@ -28,6 +28,7 @@ extern void rt_read_lock(rwlock_t *rwlock);
> >  extern int rt_read_trylock(rwlock_t *rwlock);
> >  extern void rt_read_unlock(rwlock_t *rwlock);
> >  extern void rt_write_lock(rwlock_t *rwlock);
> > +extern void rt_write_lock_nested(rwlock_t *rwlock, int subclass);
> >  extern int rt_write_trylock(rwlock_t *rwlock);
> >  extern void rt_write_unlock(rwlock_t *rwlock);
> >
> > @@ -83,6 +84,11 @@ static __always_inline void write_lock(rwlock_t *rwlock)
> >  	rt_write_lock(rwlock);
> >  }
> >  
> > +static __always_inline void write_lock_nested(rwlock_t *rwlock, int subclass)
> > +{
> > +	rt_write_lock_nested(rwlock, subclass);
> > +}
> > +
> 
> These two hunks as-is don't work. You need a CONFIG_DEBUG_LOCK_ALLOC block and
> in the !CONFIG_DEBUG_LOCK_ALLOC case you need
> 
> #define rt_write_lock_nested(lock, subclass)     rt_write_lock(((void)(subclass), (lock)))

Guess you meant #define write_lock_nested.

> 
> >  static __always_inline void write_lock_bh(rwlock_t *rwlock)
> >  {
> >  	local_bh_disable();
> > diff --git a/kernel/locking/spinlock_rt.c b/kernel/locking/spinlock_rt.c
> > index b2e553f9255b..b82d346f1e00 100644
> > --- a/kernel/locking/spinlock_rt.c
> > +++ b/kernel/locking/spinlock_rt.c
> > @@ -239,6 +239,18 @@ void __sched rt_write_lock(rwlock_t *rwlock)
> >  }
> >  EXPORT_SYMBOL(rt_write_lock);
> >  
> > +#ifdef CONFIG_DEBUG_LOCK_ALLOC
> > +void __sched rt_write_lock_nested(rwlock_t *rwlock, int subclass)
> > +{
> > +	___might_sleep(__FILE__, __LINE__, 0);
> 
> This _must_ be rtlock_might_resched() like it is done in rt_write_lock()
> above.

I should have Cced you. Thanks for the catch.
If it's fine, Andrew, could you fold it?

Thank you.

From 81f8721bc76d5f8c94770e53c6ad2e41aec8ab21 Mon Sep 17 00:00:00 2001
From: Minchan Kim <minchan@kernel.org>
Date: Fri, 19 Nov 2021 10:15:00 -0800
Subject: [PATCH] locking/rwlocks: fix write_lock_nested for RT

Fix build break of write_lock_nested for RT.

Suggested-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Minchan Kim <minchan@kernel.org>
---
 include/linux/rwlock_rt.h    | 4 ++++
 kernel/locking/spinlock_rt.c | 2 +-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/include/linux/rwlock_rt.h b/include/linux/rwlock_rt.h
index efd6da62c893..8544ff05e594 100644
--- a/include/linux/rwlock_rt.h
+++ b/include/linux/rwlock_rt.h
@@ -84,10 +84,14 @@ static __always_inline void write_lock(rwlock_t *rwlock)
 	rt_write_lock(rwlock);
 }
 
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
 static __always_inline void write_lock_nested(rwlock_t *rwlock, int subclass)
 {
 	rt_write_lock_nested(rwlock, subclass);
 }
+#else
+#define write_lock_nested(lock, subclass)	rt_write_lock(((void)(subclass), (lock)))
+#endif
 
 static __always_inline void write_lock_bh(rwlock_t *rwlock)
 {
diff --git a/kernel/locking/spinlock_rt.c b/kernel/locking/spinlock_rt.c
index b82d346f1e00..b501aef820d5 100644
--- a/kernel/locking/spinlock_rt.c
+++ b/kernel/locking/spinlock_rt.c
@@ -242,7 +242,7 @@ EXPORT_SYMBOL(rt_write_lock);
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 void __sched rt_write_lock_nested(rwlock_t *rwlock, int subclass)
 {
-	___might_sleep(__FILE__, __LINE__, 0);
+	rtlock_might_resched();
 	rwlock_acquire(&rwlock->dep_map, subclass, 0, _RET_IP_);
 	rwbase_write_lock(&rwlock->rwbase, TASK_RTLOCK_WAIT);
 	rcu_read_lock();
-- 
2.34.0.rc2.393.gf8c9666880-goog

