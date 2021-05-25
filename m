Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BD863905AE
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 17:39:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230194AbhEYPlU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 11:41:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230379AbhEYPlR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 11:41:17 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76E81C061574;
        Tue, 25 May 2021 08:39:47 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id u33so16204590qvf.9;
        Tue, 25 May 2021 08:39:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to;
        bh=TzOaj3jf5o6VRkLVFOjGwpVoOgZtE1cGZ4avVGubsYI=;
        b=pzW19cJFACaldbmmP2lvQrHzn6LaiUZQgPuXb7eYvCNCWoDee6FNp+huV8NFay1YgT
         viNzRRY7fKoOkqYh0NWE2K5W9IC1c14w0JJZ4vZ8XVEFmd8p9xgn+Q3RDZl55kgslirk
         PVJ47+ijjc7JT0wenCE7pQuc/o93P3rbVz2x8n10q+miSCYELBlD/H2uyOyghjgNLp2r
         eUQ4fHELszX5iUSjzetT4ZMtWaCmwtxk8+R2/4Rr7BNfSRAR/iqEM6nXzeJWj/SRnoyY
         69UAXLz1n/W0g+pZCwYZrbI6NMkz/PSolrSekOUvEm8j8jI7QoANrGXN9DL9kLrnfzng
         VL0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to;
        bh=TzOaj3jf5o6VRkLVFOjGwpVoOgZtE1cGZ4avVGubsYI=;
        b=UsWPXModB+vztR3wp+ga9ACWhUG/qhuR0qDcbN/f171O8+0P63mwhAFhiz9/4BCk2f
         CnaFULfzqPD74W1/cvoA/lnnGI5czdxK5Kb7WqbDW//ppR4jhsFydamUrHOfrq/mqOKI
         +/lXKClmRDaAG3iSk+8AUvBvvCEqXTlCaWefoi/acWIHQDFKKaxreZU5IJCdO7OVf5Ht
         JWQc/qzqdcC8ig05YfHwAjokh2fkU+Qb7bjvFjUd4mN1JyS8H13Up8SOvrNda6A9v4Gd
         cNDqeJxljPfmcaOB1n+s5DrldSZvoMuDHFe4iCpdknHG3zXHC7HYlCb5O3w7Yn4dEN3P
         4zsw==
X-Gm-Message-State: AOAM5305FAOQFIBtzdTUnRsTp/yvEkrkziqHt093/4IZS60W8CQkQtsk
        baUH5rUaQYSyyC/1SC8IP60=
X-Google-Smtp-Source: ABdhPJyqdHQx1PS/dk0pMYZcJ0uUYGqbxzoUhBgOJBEy7C+bCDcwyDR2MDw3BbHoTLH20AEkP9pndg==
X-Received: by 2002:ad4:4184:: with SMTP id e4mr37584072qvp.13.1621957186689;
        Tue, 25 May 2021 08:39:46 -0700 (PDT)
Received: from localhost.localdomain (ec2-35-169-212-159.compute-1.amazonaws.com. [35.169.212.159])
        by smtp.gmail.com with ESMTPSA id l65sm13262422qke.7.2021.05.25.08.39.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 May 2021 08:39:46 -0700 (PDT)
From:   SeongJae Park <sj38.park@gmail.com>
X-Google-Original-From: SeongJae Park <sjpark@amazon.de>
To:     sieberf@amazon.com
Cc:     sj38.park@gmail.com, Jonathan.Cameron@Huawei.com, acme@kernel.org,
        akpm@linux-foundation.org, alexander.shishkin@linux.intel.com,
        amit@kernel.org, benh@kernel.crashing.org,
        brendanhiggins@google.com, corbet@lwn.net, david@redhat.com,
        dwmw@amazon.com, elver@google.com, fan.du@intel.com,
        foersleo@amazon.de, greg@kroah.com, gthelen@google.com,
        guoju.fgj@alibaba-inc.com, linux-damon@amazon.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, mgorman@suse.de, minchan@kernel.org,
        mingo@redhat.com, namhyung@kernel.org, peterz@infradead.org,
        riel@surriel.com, rientjes@google.com, rostedt@goodmis.org,
        rppt@kernel.org, shakeelb@google.com, shuah@kernel.org,
        sjpark@amazon.de, snu@amazon.de, vbabka@suse.cz,
        vdavydov.dev@gmail.com, zgf574564920@gmail.com
Subject: Re: [PATCH v29 03/13] mm/damon: Adaptively adjust regions
Date:   Tue, 25 May 2021 15:39:32 +0000
Message-Id: <20210525153932.30853-1-sjpark@amazon.de>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <1b30265d-7440-1c94-f625-0087215433ee@amazon.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

Hello Fernand,


Thank you for the questions!

On Tue, 25 May 2021 17:17:05 +0200 <sieberf@amazon.com> wrote:

> Hi SeongJae,
> 
> The code looks good. Some questions for this patch:
> 
> The region merge threshold is computed on the access diff. Should the 
> diff threshold be exponential as diffs in low number of access are 
> likely to be more important? I.e if the threshold is 5, a region A with 
> 0 accesses will be merged with a region B with 4 accesses (diff=4), but 
> a region C with 50 access won't be merged with a region D with 60 
> accesses (diff=10), however it seems to me that keeping a good 
> granularity between A and B is more important than between C and D for 
> FPR. What do you think?

That totally makes sense if we have interest in only cold pages.  However,
DAMON is for more general use cases.  In some cases, people would have interest
in hot pages.  Using exponential diff might make the regions merging more
aggressive, and result in smaller overhead.  But, I think the amount of the
problem and benefit is unclear for now.  I was unable to find the overhead
becomes problematically high in my tests with production systems.  I think we
could add another option for this later, after we find it becomes a real
problem.

> 
> When the number of regions is less than half max region, region split 
> kicks in and doubles the number of region. This means that the number of 
> region will grow close to max region, then slowly decay as region 
> merges, until it reaches half max regions, then double again. This seems 
> to create a non-uniform region number distribution over time, with large 
> cycles. Also we do a lot of work when we double and no work otherwise. 
> Not sure what's the impact on measurement quality but intuitively seems 
> like keeping the number of regions constant over time would yield more 
> consistent metrics? How about we rather always split regions at each 
> iteration, and for each region we give a split probability?

Agreed, I think this makes sense.  I also planning to make the probability
adaptively changes based on current monitoring result, in future.
Nevertheless, I want to keep the logic as simple as possible for now, unless we
see clear problem and benefit there.


Thanks,
SeongJae Park

> 
> Kind regards,
> 
> --Fernand
