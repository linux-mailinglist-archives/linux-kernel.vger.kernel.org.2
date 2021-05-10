Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19C54378DAC
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 15:47:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349651AbhEJMtv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 08:49:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243214AbhEJLsT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 07:48:19 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 348C2C061377
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 04:43:23 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id md17so9591992pjb.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 04:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kZxLubrmtkSSGN/7OtV4HwrFaM1RJo3wj918s02beZQ=;
        b=YTzrULu+sL5wvlatHOauzFa1/mBVLpmasj2zRDFPcaSmcIFGtcaQLdDPtdb2JLGAfN
         yT3avmcRAoiS8PteXDIJK0kMfGFtbpbz9qMCapQ3uMAXwVwFNEgd9TJ7q7iA5jdnixEb
         1X0pENoiBzh8DXEysspfiiX0OeBPYURtdvY5U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kZxLubrmtkSSGN/7OtV4HwrFaM1RJo3wj918s02beZQ=;
        b=HtsIKHSLnnSKSIsDM+IuuDvK89T2ksi2dEb7TDsacZMkHFK78PXk+cHGMIMI8T7/Rg
         IDc69M3f7qS00WoOPaS1CtOq9uXl71qt5m0/07kEQRThTufxTzLUGaa8cJDloN8aFDXz
         4FszgkROvW8GO/EhOoFwaSWvOyqO1lEiiDA63ca3EXyjsUi43Ta812E0t3is08gdKIoc
         lIEkiPsVMOj3AejHKxNkhM7csc3eJoy4NY54Z+w0Au8SJaCsOFNzb2oGsWJ3Ag3aQcE2
         dwwiGyPoiN+NVN45x0ComGTsQja93cNKLNy7oVqPC44ib+J04gbXCrJ4NX7VfxLteIca
         Lp4Q==
X-Gm-Message-State: AOAM533UPzQXI85h3v+dOE6QCe/AobVH2dV9XxDa9SXT3IkLSODcxL4n
        zHMpOssKkpFnziJkJ6Br3xpTdw==
X-Google-Smtp-Source: ABdhPJxAQBJ87zJRYRFNZ40G53yKaTgrIFKploTwJbdvsNCD7RAdkW4GIdebUrBv40tqUAT9FPRj+g==
X-Received: by 2002:a17:90b:505:: with SMTP id r5mr27248407pjz.121.1620647002797;
        Mon, 10 May 2021 04:43:22 -0700 (PDT)
Received: from google.com ([2409:10:2e40:5100:b1d:8aee:8284:2f76])
        by smtp.gmail.com with ESMTPSA id b23sm11153446pjo.26.2021.05.10.04.43.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 May 2021 04:43:22 -0700 (PDT)
Date:   Mon, 10 May 2021 20:43:16 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Luo Jiaxing <luojiaxing@huawei.com>,
        sergey.senozhatsky@gmail.com, rostedt@goodmis.org,
        john.ogness@linutronix.de, linux-kernel@vger.kernel.org,
        linuxarm@huawei.com, bobo.shaobowang@huawei.com
Subject: Re: [PATCH] printk: stop spining waiter when console resume to flush
 prb
Message-ID: <YJkcVOfuSBFjI1Bt@google.com>
References: <1620288026-5373-1-git-send-email-luojiaxing@huawei.com>
 <YJPxj83F1sBjHHAE@alley>
 <YJP4F1UIt/eRZ96s@google.com>
 <YJP5MnkJ8pJevXM6@google.com>
 <YJVsgPc66lhaAUN0@alley>
 <YJjuRV57eO3Pp/bp@google.com>
 <YJkIK9cyHr46UAFP@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YJkIK9cyHr46UAFP@alley>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (21/05/10 12:17), Petr Mladek wrote:
> > 	rcu_read_lock();
> > 	...
> > 	console_unlock_preemptible();
> > 	...
> > 	rcu_read_unlock();
> > 
> > lockdep_assert_preemption_enabled() is not entirely reliable - it
> > depends on __lockdep_enabled, provided that system in question has
> > CONFIG_PROVE_LOCKING set.
>
> I understand the concern. I think that I would be able to sleep with
> this. I believe that such problems would be discovered soon.
>
> Also I doubt that it would spread that quickly. It is the same as
> with printk_deferred(). It is just a workaround for a problem
> that only few people are aware of.
>
> If it is still a concern, we could make it static and block
> any patches that would make it public.
>
> But it does not make sense to fight over this now.

Is any attempt to have alternative fixup solutions and discussions is
going to be labeled as a fight? Up to you, I'm personally not having
any fights.

> I am not sure that console_unlock_preemptible() is worth it after all.
> Luo has to prove that it might fix a real life problem.

Good point.

> I am sorry but I am not going to continue in this discussion.
[..]
> The current plan is to move console work to kthreads (separate
> preemptive context). Using IRQ is a complete opposite way.

I'm not objecting future directions.

I'm discussing current fixup proposals. And I'm not very super comfortable
with the approach that introduces dynamic duality to printk behaviour: new
printk behaviour or the old one, and that API is system wide available. That
IRQ thing is not beautiful, bit it's already there and it's working and we
now how it behaves. That's it.
