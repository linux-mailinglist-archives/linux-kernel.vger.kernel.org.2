Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB27A3A897F
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 21:30:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230043AbhFOTcF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 15:32:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229898AbhFOTcD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 15:32:03 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FED7C06175F
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 12:29:57 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id u30so53781qke.7
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 12:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=b1NdNJmbQ9vufxbdq46R0yQ5rOWLcgcQTrxTuRLsRs4=;
        b=kZmQdCqtAe6i6mcTzPE2G1TnxW5S3b3u7NHWwpD/z6z+rVhlqxQofe38Zav7pYflCb
         6TjmJhRoa0BXLTlDnKddSVw7zM/k74Plwu1Q4dNQn5RRpBWMyBbKtApXtgOUdOW+PsP2
         i3+fbThoD6+KVR8g8QPHi6Rkizkxw2FQpC0R7pXdyz7mIH5K5spJvHcPMeVOQv8JENu0
         tYtQFQ9eyCT9WqDme2JdoLd9kwKp2xnWipBrKHag4G8AY6i7Cz/mf2UVWkvHpmHgVEtg
         bgGU4fEzFlzDrN8NXje4+5ygkO87UjYU+B58pIvX82JJ5I3InE44LSHwHZfL9L+L8YdK
         bNBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=b1NdNJmbQ9vufxbdq46R0yQ5rOWLcgcQTrxTuRLsRs4=;
        b=bj7VJ889U1pZZl7C4c6GIDMJA5xWQwRJ+02QN6vZxmlbiuWBRvV1WCl/WbMW2Z8w0g
         ZObYIrjjtkFmrNLqW1oEim2yUyu9RO1ftqiNUfvPJJAYnGgGkxfTLQJnNxtDysLjsM86
         LYIH/viC2MnbrXNOsOizfKcMdaTbY1mxNq8RoEv2NNelTpTrORgW86MCeD5QLHHN6OYq
         NO8H4sWaZVbB8ZJxYL/0x/8tyS1uO4YmEoCBG+hfwyE+wFxCK7ZaNLMxkH3x646P5YZ2
         u56PgY9XHGX3aLVlgT4SZ2iGNnuWsClurDRcskFScdhsk9P43+Am0N4yh0BMu8CeNs8e
         wHMg==
X-Gm-Message-State: AOAM533bZfN9hq9ezoSUPlqPWslVftHURIjea2MsXJfo6rW+pZlGwZq2
        D78AbzIr7O4xR58VqEskKuYr+A==
X-Google-Smtp-Source: ABdhPJxP3yHeFpozEvcuka46Iijje/SKXPkiGMZdItJHdDhI9CQNqB/bOJ9eNYsjEGTObmJeG86+cA==
X-Received: by 2002:ae9:d608:: with SMTP id r8mr1245226qkk.279.1623785396646;
        Tue, 15 Jun 2021 12:29:56 -0700 (PDT)
Received: from localhost (70.44.39.90.res-cmts.bus.ptd.net. [70.44.39.90])
        by smtp.gmail.com with ESMTPSA id y128sm10310870qke.113.2021.06.15.12.29.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jun 2021 12:29:55 -0700 (PDT)
Date:   Tue, 15 Jun 2021 15:29:55 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Tejun Heo <tj@kernel.org>, Muchun Song <songmuchun@bytedance.com>,
        Michal Hocko <mhocko@kernel.org>, Roman Gushchin <guro@fb.com>,
        Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        Huang Ying <ying.huang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] memcg: periodically flush the memcg stats
Message-ID: <YMj/s26uF+cQOB2D@cmpxchg.org>
References: <20210615174435.4174364-1-shakeelb@google.com>
 <20210615174435.4174364-2-shakeelb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210615174435.4174364-2-shakeelb@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Shakeel,

On Tue, Jun 15, 2021 at 10:44:35AM -0700, Shakeel Butt wrote:
> At the moment memcg stats are read in four contexts:
> 
> 1. memcg stat user interfaces
> 2. dirty throttling
> 3. page fault
> 4. memory reclaim
> 
> Currently the kernel flushes the stats for first two cases. Flushing the
> stats for remaining two casese may have performance impact. Always
> flushing the memcg stats on the page fault code path may negatively
> impacts the performance of the applications. In addition flushing in the
> memory reclaim code path, though treated as slowpath, can become the
> source of contention for the global lock taken for stat flushing because
> when system or memcg is under memory pressure, many tasks may enter the
> reclaim path.
> 
> Instead of synchronously flushing the stats, this patch adds support of
> asynchronous periodic flushing of the memcg stats. For now the flushing
> period is hardcoded to 2*HZ but that can be changed later through maybe
> sysctl if need arise.

I'm concerned that quite a lot can happen in terms of reclaim and page
faults in 2 seconds. It's conceivable that the error of a fixed 2s
flush can actually exceed the error of a fixed percpu batch size.

The way the global vmstat implementation manages error is doing both:
ratelimiting and timelimiting. It uses percpu batching to limit the
error when it gets busy, and periodic flushing to limit the length of
time consumers of those stats could be stuck trying to reach a state
that the batching would otherwise prevent from being reflected.

Maybe we can use a combination of ratelimiting and timelimiting too?

We shouldn't flush on every fault, but what about a percpu ratelimit
that would at least bound the error to NR_CPU instead of nr_cgroups?

For thundering herds during reclaim: as long as they all tried to
flush from the root, only one of them would actually need to do the
work, and we could use trylock. If the lock is already taken, you can
move on knowing that somebody is already doing the shared flush work.
