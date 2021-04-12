Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AF6435C81F
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 16:03:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242077AbhDLOED (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 10:04:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238998AbhDLOEA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 10:04:00 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DEC5C06174A
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 07:03:41 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id v140so21604642lfa.4
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 07:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Txa0jtEnzVHszI7+7RurZSdLkTftdeKdRRITuMLu8Aw=;
        b=PKU//OewynQNd7SeSC4KENGCXLIca0cApDWlmgkcNZDG1kpsbr0rPgil0AfgvOY6dl
         xyI6oUsEgz7I5NjvX0nmU5gKYvslpr/DlU2IIRtDHNsKTNj5mYTMWpVOpf0jlmmt/S1y
         CUUPJrpfVC9XLPr2/2KydVFWwL1JDLBVppMWOyO+Az5d4syy4eLTXKVvpJh2no8LrH7e
         ex2ev3hbHYWC5eF6K2hYH3cFW/+lq19/RnT0xtAF8Di+nXWZY6q/eFfZ0rQhHO906gw/
         8g5iI2BKxf1UF0j4bm0jF5b9TGq687Vz2mq2c0Pjjaq4ByhtTs/YAEQgxKfs2aA9Fml4
         jqyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Txa0jtEnzVHszI7+7RurZSdLkTftdeKdRRITuMLu8Aw=;
        b=paGrxJBNmVFOFsvF8RCN4o5LojcHTjJdCNsWaW+fcrTNE0ZGRs2nMn+N4j71Co0wc2
         rUAl7E3a+bPdkJofD3zpEmIn888veKN/Kap7k8MfH5HSIka8oABr9A3j4k/cF+YL4pfv
         DTCpEzhdNvGs4fAi/fpSBwTyx6he6kcjEzUcQXzkecC4tdUdeQXGQUeWJSb/CEWv29uz
         DDm67tdK6vj+Vq+Lhd9eNLN5ipC9cJzdL4Yyb0S5E+z016lR6wG6p3jPbVK6HWpgAJsB
         5DSX088LGpb07UeTTGoBFYKB3yZ4/4TtERMgzle3vIlLRaCO/kYflRqHgiLhE3ErV3mq
         uQIg==
X-Gm-Message-State: AOAM533pzxyQHDmnZww73Rx6nwukwgtCsPt0PyKDTsscK2PydMy/DOVf
        V9HaSZKeu0Ey3B+dyI3+vpklaE5rC478iT7/Z1EKlg==
X-Google-Smtp-Source: ABdhPJwdMgH1vZSbLM2ftjQCiG02Bjb8iz3/wBlG8KsX8dUvbr+SMIdSWmWYv9eRFDg9nnny7qYgsT+gUxtHK7Iklhc=
X-Received: by 2002:ac2:546c:: with SMTP id e12mr4490386lfn.299.1618236219038;
 Mon, 12 Apr 2021 07:03:39 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1617642417.git.tim.c.chen@linux.intel.com>
 <CALvZod7StYJCPnWRNLnYQV8S5CBLtE0w4r2rH-wZzNs9jGJSRg@mail.gmail.com>
 <CAHbLzkrPD6s9vRy89cgQ36e+1cs6JbLqV84se7nnvP9MByizXA@mail.gmail.com>
 <CALvZod69-GcS2W57hAUvjbWBCD6B2dTeVsFbtpQuZOM2DphwCQ@mail.gmail.com> <CAHbLzkoce41b-pJ5x=6nRhex_xBdC-+cYACBw9HKtA87H71A-Q@mail.gmail.com>
In-Reply-To: <CAHbLzkoce41b-pJ5x=6nRhex_xBdC-+cYACBw9HKtA87H71A-Q@mail.gmail.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Mon, 12 Apr 2021 07:03:27 -0700
Message-ID: <CALvZod4vYiT-OnQ8gmhs+NurMV+kSFptMig4FJS7RAAcJJeDNA@mail.gmail.com>
Subject: Re: [RFC PATCH v1 00/11] Manage the top tier memory in a tiered memory
To:     Yang Shi <shy828301@gmail.com>
Cc:     Tim Chen <tim.c.chen@linux.intel.com>,
        Michal Hocko <mhocko@suse.cz>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Ying Huang <ying.huang@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        David Rientjes <rientjes@google.com>,
        Linux MM <linux-mm@kvack.org>,
        Cgroups <cgroups@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 8, 2021 at 1:50 PM Yang Shi <shy828301@gmail.com> wrote:
>
[...]

> >
> > The low and min limits have semantics similar to the v1's soft limit
> > for this situation i.e. letting the low priority job occupy top tier
> > memory and depending on reclaim to take back the excess top tier
> > memory use of such jobs.
>
> I don't get why low priority jobs can *not* use top tier memory?

I am saying low priority jobs can use top tier memory. The only
difference is to limit them upfront (using limits) or reclaim from
them later (using min/low/soft-limit).

> I can
> think of it may incur latency overhead for high priority jobs. If it
> is not allowed, it could be restricted by cpuset without introducing
> in any new interfaces.
>
> I'm supposed the memory utilization could be maximized by allowing all
> jobs allocate memory from all applicable nodes, then let reclaimer (or
> something new if needed)

Most probably something new as we do want to consider unevictable
memory as well.

> do the job to migrate the memory to proper
> nodes by time. We could achieve some kind of balance between memory
> utilization and resource isolation.
>

Tradeoff between utilization and isolation should be decided by the user/admin.
