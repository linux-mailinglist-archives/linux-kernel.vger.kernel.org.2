Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B07F93C20DC
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jul 2021 10:33:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231588AbhGIIgH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jul 2021 04:36:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:60782 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231494AbhGIIgG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jul 2021 04:36:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625819603;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=h+B79Qy5/sJ7KJeC72at84d0n6nQWO+ojLZQqPnJHDQ=;
        b=D0ivmjNV/qUQYhfQMn0V8PGGPK4QWRGXR5Qb6LDx2RMKC7TnuWRs/M8EUmjc7Ly0Er6V5x
        7CN+taWNWcKMg5K/y2XNPWnC+AwUTLjd+D17yXkWXDhIJEV7S1/8ZlGqB5tVkZ4K7YP2RP
        +FC9T9/N6oaD32mGJcvXGEB6Aovojps=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-277-JdUo7ZaEM1SeJ9iwFEE4-w-1; Fri, 09 Jul 2021 04:33:21 -0400
X-MC-Unique: JdUo7ZaEM1SeJ9iwFEE4-w-1
Received: by mail-ed1-f71.google.com with SMTP id z5-20020a05640235c5b0290393974bcf7eso4843523edc.2
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jul 2021 01:33:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=h+B79Qy5/sJ7KJeC72at84d0n6nQWO+ojLZQqPnJHDQ=;
        b=n4169KBrHphlIIl10n0k/RTHka4yTajokNNBXyEevg1rVKARnpN4M1UN6pCVwfHKsq
         s/A19OIhscc10R9dUZ+vahOxV1ZJJktSdldonWcWgxvybUhH+x07MD+uGRyACegTkmHJ
         450d1A4jBtAMs4LIaY1D7pYtTiuVYShKgpyhuy9kAlinCsi+HxicKDx8RABOOSypy4Mi
         Ss8gWyL+58I7B2pGiWIzkP6orLoqfT5vUDZb7MtOD97TGl5EXZQZ7D0zzRIKMb0drEIk
         Hh1xIuKHAKFqIT7Fok9JHbvvDWl0gIUBASd+hmKy/CpVNuhf11SNkXePpNu079f5tZhm
         E6Cw==
X-Gm-Message-State: AOAM533Qdjy/G/4qSYJXWm71+dr7AaM8B1yREUSykNPe79tKGs39md8b
        8+uDqYBrZmSM00Yd9mkyWWHb4hu7jVASgw3fDS52AM3JsOi9EwkWukpS5ClKJzToptgtvTt9TCI
        XdLjDhWLMUL7aCmoA8H8l7GP3
X-Received: by 2002:a05:6402:d59:: with SMTP id ec25mr44664723edb.373.1625819600762;
        Fri, 09 Jul 2021 01:33:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx0lqXvGMtO6vo1qxIuYDqCEyzuoRjXuWP8dSo6xC5eOgUa79lDArCI54NzdQKotdY04DuWSw==
X-Received: by 2002:a05:6402:d59:: with SMTP id ec25mr44664700edb.373.1625819600565;
        Fri, 09 Jul 2021 01:33:20 -0700 (PDT)
Received: from localhost.localdomain ([151.29.51.230])
        by smtp.gmail.com with ESMTPSA id g17sm2584951edb.37.2021.07.09.01.33.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jul 2021 01:33:20 -0700 (PDT)
Date:   Fri, 9 Jul 2021 10:33:18 +0200
From:   Juri Lelli <juri.lelli@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@redhat.com, linux-kernel@vger.kernel.org,
        vincent.guittot@linaro.org, rostedt@goodmis.org,
        dietmar.eggemann@arm.com, bristot@redhat.com, bsegall@google.com,
        mgorman@suse.de, Mark Simmons <msimmons@redhat.com>
Subject: Re: [PATCH] sched/rt: Fix double enqueue caused by rt_effective_prio
Message-ID: <YOgJzqOrVHUvCpch@localhost.localdomain>
References: <20210701091431.256457-1-juri.lelli@redhat.com>
 <YObOIwH7MbfagklQ@hirez.programming.kicks-ass.net>
 <YObS2Rudg4osS7Ic@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YObS2Rudg4osS7Ic@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On 08/07/21 12:26, Peter Zijlstra wrote:
> On Thu, Jul 08, 2021 at 12:06:27PM +0200, Peter Zijlstra wrote:
> > Slightly larger patch, but perhaps a little cleaner.. still pondering if
> > we can share a little more between __sched_setscheduler() and
> > rt_mutex_setprio().
> 
> Best I can seem to come up with...

Thanks for the non-lazy version of the fix!

Makes sense to me and it looks good from quick testing. I'll be doing
more extensive testing and ask Mark (cc-ed) to help with that. :)

We'll report back soon-ish.

Best,
Juri

