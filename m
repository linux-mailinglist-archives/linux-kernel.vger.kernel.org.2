Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 966CB391105
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 08:53:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232614AbhEZGy0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 02:54:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232873AbhEZGyR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 02:54:17 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B444CC06175F
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 23:52:45 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id m18so4954414wrv.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 23:52:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/znqg1OOEOkpe1PlvX4e2tvzePQ2MBWWAzj1f4mifRA=;
        b=YkcubT8PcJJygKVhehW7gGTKV+h4QCEFb8F6LA+KClVOJp8fbhSVGTIkFTJ26FbEEx
         TBNoX3jOnx/+y9jbTFtHuX+Kt0xmuBhu9e2VBAfAB9y1YZBAAjnDNMWimxDU8MII+mqx
         uhAqbZ34e3GMBAH/uDUqYV7GGCp1dls1N5NcYu+bK/6Q+T/WCvBbmC3OmF6Nv9uXOMdA
         KPUbIH0O+CdSa4bitEXQeAIFrDDs0ute0vcxchzb+n+GtV6XWr8/x6C1K6giCQHyChjL
         3hguWr4HRSt4j8vq+VoZOr0bHEs3jONw8qz1ffVQ0jO6DtZFsFI/EQ4gH2G9yvYUrlc0
         ZUsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=/znqg1OOEOkpe1PlvX4e2tvzePQ2MBWWAzj1f4mifRA=;
        b=oxZSXt1eBKYKI+IRyjfJkEiB/g1/2tXywM4vE/4av9NgnluiTC7le1tdA/s+l/DFYB
         RKyu1PQqHy5kgMBL0KAMRwPzYB2bPjKDelyPFBoxi93uVs4h1g+9yrt6btvEoFpRP/QI
         /5Gxst9tctZ9i47iL5QYVRsfLZRMPYT5Q8yGGWesBTyiXOTAIe8eHRN3M82/OjahJXrP
         QhJ/mSeDU+PjZOw1YsjOm/cll/FdrUwyCbjNRcrUoSBh4yXdCBg3CR5NFDb9veykcmDK
         PZsDuAUue+Q988fsonh6TxpYuN3BxxnY0Kd45GPMZbnGork+XErCEz3twcug3GLCCdW7
         jxYw==
X-Gm-Message-State: AOAM532YD2Pc43I55g9NT0iiJUy8G67KAzXsM6xXymkWhkuyv00romdO
        VKVa5NvqsTFXyPf0LYbpQ7U=
X-Google-Smtp-Source: ABdhPJxta9Z2IutGYZNPVfBjn/NH8QRX3JNcTKjOn6sKFCK0JwQYRbsoG3VNp/L7NoJxOQ04MD+FVw==
X-Received: by 2002:a05:6000:108b:: with SMTP id y11mr31094821wrw.166.1622011964386;
        Tue, 25 May 2021 23:52:44 -0700 (PDT)
Received: from gmail.com (0526ECF1.unconfigured.pool.telekom.hu. [5.38.236.241])
        by smtp.gmail.com with ESMTPSA id f16sm18797598wrm.47.2021.05.25.23.52.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 May 2021 23:52:44 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Wed, 26 May 2021 08:52:42 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] sched/topology: Fix a spelling mistake in error
 message
Message-ID: <YK3wOkX6I78j73zD@gmail.com>
References: <20210526021856.9060-1-thunder.leizhen@huawei.com>
 <42d36255-c1a6-956a-b56b-0c09eee125ec@infradead.org>
 <5571d34f-1965-8d8e-3033-6352dd0dcaee@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5571d34f-1965-8d8e-3033-6352dd0dcaee@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Leizhen (ThunderTown) <thunder.leizhen@huawei.com> wrote:

> 
> 
> On 2021/5/26 10:32, Randy Dunlap wrote:
> > On 5/25/21 7:18 PM, Zhen Lei wrote:
> >> The misspelled word 'borken' should be 'broken'.
> >>
> >> Fixes: 6ae72dff3759 ("sched: Robustify topology setup")
> >> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> >> ---
> >>  kernel/sched/topology.c | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> >> index 55a0a243e871..80295e224442 100644
> >> --- a/kernel/sched/topology.c
> >> +++ b/kernel/sched/topology.c
> >> @@ -1937,7 +1937,7 @@ static struct sched_domain *build_sched_domain(struct sched_domain_topology_leve
> >>  
> >>  		if (!cpumask_subset(sched_domain_span(child),
> >>  				    sched_domain_span(sd))) {
> >> -			pr_err("BUG: arch topology borken\n");
> >> +			pr_err("BUG: arch topology broken\n");
> > 
> > Would "borked" or "b0rken" be clearer?
> 
> These two words don't seem to exist at all. Linux is an open-source
> code for the world, so it's better to use a more common word.

What?

Please google:

    "borken" meaning

Please stop these pointless patches.

Thanks,

	Ingo
