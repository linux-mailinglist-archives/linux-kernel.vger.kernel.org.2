Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87F6F4128E4
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 00:31:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237996AbhITWdT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 18:33:19 -0400
Received: from mail-pl1-f172.google.com ([209.85.214.172]:40594 "EHLO
        mail-pl1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238078AbhITWbR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 18:31:17 -0400
Received: by mail-pl1-f172.google.com with SMTP id n18so12028905plp.7
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 15:29:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MofHaBdRGnwseYgSAsKI1CDQXPPyzkLtR0xxeOwgj8E=;
        b=MQhMF7zep7yiKbDABdUvx7q7geCQEQYp/09p4aZsgyzxyBvI18kH2bTRDO02r2LDFg
         CP/KlDKoAC7Le/fILMF/oDrs374nH3CatM/a4gATaXyFKBuyovsswLwHQXY7jp3pQKzM
         GhOCIPDHWCBsAckwnRonfOjPg1FSqsGn3c/0lkMAa7+D8NWJpYtuSdV3Bx0YNs/920Bv
         lO4Y9lkf3SimOnKtSF5t5JvAZOQWIaQ0nq4pTldMFWVOHtLLGkjQtnXASx22B2Nybtko
         9oTVKGIn7II5NFB/OU31fZc4JzKKlZwPQOsC1669A6YSDiMzyNDz4Hd9RYXteSBmg6uM
         Ab5Q==
X-Gm-Message-State: AOAM533LI/3Um+ioCL5SJSNW4VsEWQ8GtjpiFx76V6ndMOf1OCMS68y5
        Mxvf63TQQIgubm4YJ4YA3Fs=
X-Google-Smtp-Source: ABdhPJywX2Nx36bpG9Miqst8Bbp3rSetU1+dy7FuO4oGjYkUzFhVXOZw9nglgJF6uVNiIyMaMH4Ihw==
X-Received: by 2002:a17:902:cacb:b0:13a:5f28:e4cb with SMTP id y11-20020a170902cacb00b0013a5f28e4cbmr24833661pld.37.1632176989573;
        Mon, 20 Sep 2021 15:29:49 -0700 (PDT)
Received: from sultan-box.localdomain ([204.152.215.247])
        by smtp.gmail.com with ESMTPSA id q18sm15490909pfj.46.2021.09.20.15.29.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Sep 2021 15:29:49 -0700 (PDT)
Date:   Mon, 20 Sep 2021 15:29:46 -0700
From:   Sultan Alsawaf <sultan@kerneltoast.com>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Mel Gorman <mgorman@suse.de>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: Mark the OOM reaper thread as freezable
Message-ID: <YUkLWuJYrvNp+tMh@sultan-box.localdomain>
References: <20210918233920.9174-1-sultan@kerneltoast.com>
 <YUiBRdrkjIdB/rSN@dhcp22.suse.cz>
 <YUiu42krQjSTVPnc@sultan-box.localdomain>
 <YUjGIuQciY7HNj+Y@dhcp22.suse.cz>
 <YUjeF6YsHKljSFis@sultan-box.localdomain>
 <YUjvVP8pFL3Be9Jv@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YUjvVP8pFL3Be9Jv@dhcp22.suse.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 20, 2021 at 10:30:12PM +0200, Michal Hocko wrote:
> We usually tend to provide Fixes where there has been something fixed.
> It seems just confusing if it is used for non functional changes,
> cleanups etc. Thera are gray zones of course.

Got it, thanks. So no tag would be used in such a case?

> I am not sure I follow. My understanding is that we need to make sure
> oom_reaper is not running after the quiescent state as it is changing
> user space address space. For that I believe we need to freeze the
> kthread at a proper moment. That is currently the entry point and maybe
> we can extend that even to the reaping loop but I haven't really
> explored that. PF_FREEZER_SKIP would skip over the reaper and that could
> result in it racing with the snapshotting no?

Kthreads cannot be implicitly frozen; it's not like PREEMPT. From what I've read
in the freezer code, two things must occur for a kthread to freeze: the kthread
must have PF_NOFREEZE unset (via set_freezable(), as is done in the patch I've
submitted here), and the kthread must have an explicit call into the freezer,
such as via wait_event_freezable().

Right now, oom_reaper is totally ignored by the freezer because PF_NOFREEZE is
set by default in all kthreads. As such, oom_reaper can keep running while
system-wide freezing occurs. If you think this can mangle snapshots, then
perhaps there is a real bug here after all.

It sounds like you don't want oom_reaper to slow down system-wide freezing, but
at the same time, you want oom_reaper to participate in system-wide freezing?
I'm not sure how you could achieve that, aside from maybe inserting a call into
the freezer while iterating through each vma, akin to adding a cond_resched().

My PF_FREEZER_SKIP suggestion was just to emphasize that oom_reaper is currently
skipping the freezer anyway due to PF_NOFREEZE, and that you could set
PF_FREEZER_SKIP to make it skip the freezer a little faster if you wanted.

> Is this something to really worry about?

I'm trying to emphasize that the current usage of wait_event_freezable() in
oom_repear behaves *exactly* like wait_event_interruptible() but with some extra
overhead.

Sultan
