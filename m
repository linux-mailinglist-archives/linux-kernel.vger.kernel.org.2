Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12C6133C7E9
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 21:44:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232147AbhCOUnm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 16:43:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229962AbhCOUnK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 16:43:10 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEBAFC06174A
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 13:43:09 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id e7so59062924lft.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 13:43:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XC8bY/c6LlHvD9TH9UevY57CN7cJD6ZiGwwB++TkJO4=;
        b=eFzH9DHywvAGTJGl198bwljRgMQFqNDykZUJG+UuyF83Q9df2rYSrU3dKMNZl7Z4j/
         17/8qsalGdf/AYWeLR7MS54AUyiv+ShaAFq7tTDGqC0cp9F63qYNqNgCMEIgBMxyFeZ5
         XCkj5+csYUiGPv1zdQvRdDlwTB8A74Ak2pwww=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XC8bY/c6LlHvD9TH9UevY57CN7cJD6ZiGwwB++TkJO4=;
        b=ElCiCZdMgN4X6+FGMJyd9a7/dMfsowye8kNMLFRgwpXSMZsg/ZSQ3Dcj31AFMRiJe9
         5jGdBG4/FA9Cy7Zo4Sii61V/1NO198b12quFpOyr5P5ZXsOzXboOb6PsfV/x1R6a3uJ+
         uj5pjlJBOZLnRfp8ryFhwL0tBfZAcZzsGJaHTlRx46SHnbe0d0Vjha+NFj8jCNP4Zynb
         Awdp/jB5YjSyJW8NPgNpF87M9h0XRql1ixjPTNhh/cr/SmlEGtREcu5r53tulcGOE1zk
         gwsY4wSW/k9UZZrlpmUYhBh7qPCKwItk9vwtnbEw7/jfCqB0RmHISIjKuv3yJpruE1ff
         8wFg==
X-Gm-Message-State: AOAM533u2pY0QRAuocs2RYynnpv79J78p8bcDRnGJGEr+2y7svL6zQN4
        qlEZn7uYBaMHJbWjZlKEgWxvWetE71lqTw==
X-Google-Smtp-Source: ABdhPJxwlJdAOR85jvbZihI/goKyeWRasUcVPe2tw7WWYjxuNIWKEezxt4T0Yq5xunRIrj9WVl/E9w==
X-Received: by 2002:a19:7e45:: with SMTP id z66mr9000635lfc.612.1615840987864;
        Mon, 15 Mar 2021 13:43:07 -0700 (PDT)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com. [209.85.167.44])
        by smtp.gmail.com with ESMTPSA id x19sm2766765lfr.198.2021.03.15.13.43.06
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Mar 2021 13:43:07 -0700 (PDT)
Received: by mail-lf1-f44.google.com with SMTP id p21so58912581lfu.11
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 13:43:06 -0700 (PDT)
X-Received: by 2002:a05:6512:a8c:: with SMTP id m12mr9067488lfu.253.1615840986403;
 Mon, 15 Mar 2021 13:43:06 -0700 (PDT)
MIME-Version: 1.0
References: <20210315062808.GA837@xsang-OptiPlex-9020>
In-Reply-To: <20210315062808.GA837@xsang-OptiPlex-9020>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 15 Mar 2021 13:42:50 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi1KcOZo4JeRDgJCU0gB5v16q6GJsFtF365MSfM8hH3zA@mail.gmail.com>
Message-ID: <CAHk-=wi1KcOZo4JeRDgJCU0gB5v16q6GJsFtF365MSfM8hH3zA@mail.gmail.com>
Subject: Re: [mm] f3344adf38: fxmark.hdd_btrfs_DWAL_63_bufferedio.works/sec
 -52.4% regression
To:     kernel test robot <oliver.sang@intel.com>
Cc:     Muchun Song <songmuchun@bytedance.com>,
        Shakeel Butt <shakeelb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Roman Gushchin <guro@fb.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Chris Down <chris@chrisdown.name>,
        Yafang Shao <laoar.shao@gmail.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        kernel test robot <lkp@intel.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        Feng Tang <feng.tang@intel.com>, zhengjun.xing@intel.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 14, 2021 at 11:30 PM kernel test robot
<oliver.sang@intel.com> wrote:
>
> FYI, we noticed a -52.4% regression of fxmark.hdd_btrfs_DWAL_63_bufferedio.works/sec

That's quite the huge regression.

But:

> due to commit: f3344adf38bd ("mm: memcontrol: optimize per-lruvec stats counter memory usage")

That's _literally_ just changing a dynamically allocated per-cpu array
of "long[]" to an array of "s32[]" and in the process shrinking it
from 304 bytes to 152 bytes.

> in testcase: fxmark
> on test machine: 288 threads Intel(R) Xeon Phi(TM) CPU 7295 @ 1.50GHz with 80G memory

I think this must be some really random memory layout issue that
causes some false sharing or similar.

And it's not even that some fundamental data structure gets a
different layout, it literally is just either:

 (a) the (now smaller) array is allocated from a differently chunk,
and that then causes random cache effects with something else

 (b) the (old, and bigger) array was more spread out, and as a result
had different fields in different cachelines and less false sharing

Normally I'd say that (b) is the obvious case, except for the fact
that this is a __percpu array.

So in the common case there shouldn't be any cache contention _within_
the array itself. Any cache contention should be with something else
very hot that the change now randomly makes be in the same cache way
or whatever.

Afaik, only the flushing of the vmstats batches does access the percpu
arrays from other CPUs, so (b) is not _entirely_ impossible if
memcg_flush_percpu_vmstats() were to be very very very hot.

But the profile data doesn't show anything remotely like that.

In fact, the actual report seems to show things improving, ie things
like elapsed time going down:

>       1361            -9.5%       1232        fxmark.time.elapsed_time
>       1361            -9.5%       1232        fxmark.time.elapsed_time.max
>      25.67            +9.1%      28.00        fxmark.time.percent_of_cpu_this_job_got
>     343.68            -2.0%     336.76        fxmark.time.system_time
>      23.66            +2.5       26.12        mpstat.cpu.all.sys%

but I don't know what the benchmark actually does, so maybe it just
repeats things until it hits a certain confidence interval, and thus
"elapsed time" is immaterial.

Honestly, normally if I were to get a report about "52% regression"
for a commit that is supposed to optimize something, I'd just revert
the commit as a case of "ok, that optimization clearly didn't work".

But there is absolutely no sign that this commit is actually the
culprit, or explanation for why that should be, and what could be
going on.

So I'm going to treat this as a "bisection failure, possibly due to
random code or data layout changes". Particularly since this seems to
be a 4-socket Xeon Phi machine, which I think is likely a very very
fragile system if there is some odd cache layout issue.

If somebody can actually figure out what happened there, that would be
good, but for now it goes into my "archived as a random outlier"
folder.

                 Linus
