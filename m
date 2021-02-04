Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD4BF30ED6E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 08:36:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234508AbhBDHdt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 02:33:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233173AbhBDHdm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 02:33:42 -0500
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7219FC0613D6
        for <linux-kernel@vger.kernel.org>; Wed,  3 Feb 2021 23:33:01 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id r23so313977ljh.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Feb 2021 23:33:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mVefbxEsGh9zkzfC1oY5DTuWOWgG+z41sRnOeNBLDiE=;
        b=RMhuOnzSHH/+k63L/smA9k18SLyi9Kn18dVA486qpcwAxQsuyq90SWofxMCQgFoZ0D
         qNlE1XuYlA2DC80aqDH57A0Knv7eE0i7MPe/DZrTINiltSxKwVdIzUbtKkjYheV6T6V/
         LtEVMPpuxm80Zp9K1Lf8Ezm0j5It5U/pq+Qi8asnmNX6aHC0m/yAf5vMBau4rwRAoEMJ
         r1Vc0xw/eTjc2CxHjHpC05dBvgYX6Q1fwhqsP48Y8RGNoS1pG+rQVeVSx23r7SONcE7G
         alh3bBAKZhKRuGKp/851XtzD+4EXTEtu95SZYVgxk0xyq9Pl2jb8o8QHLtyZVJKmK8yb
         aVbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mVefbxEsGh9zkzfC1oY5DTuWOWgG+z41sRnOeNBLDiE=;
        b=GfvPn26k55yZvNHSWEQZT0HFK64QuxTehZ8ODyTcMXCNFdOR2rOQ7+C4j3PsiZTQaT
         5wmHtqEcsx8Q5vyH7fqjAuMbDNx4BjLSCLDuE8rT1LeCMnvYsY9oH9p2+mj/AoNC1wZU
         mlJ/A7HZOj/K8UwNUvloLW65YJPPoQ9SmXEkLpxwMiB7to027LdRhSjVje4bmvgZGIzy
         KBU7VE8UiUUe5Qa3xoLK3Na2CRf9QGS7Vz/Zh7zeNmsB4lXizGAjRg22kNLt1lVmb5SA
         yXqVQuL9d7Z3DM6D32GSVin66EStiy34/IbbWdx9oTCyE6rIXPWi9acWeT9QIHYaiYEB
         OkEg==
X-Gm-Message-State: AOAM532z8vow6FaL4mN4dlYFZiC9ZvL3KkGQe5oslgzQRc3nmfwtJ1li
        VDGYfJfUhiPqB16Ds/kuQcwR+dinnjikp3DQM+QHbw==
X-Google-Smtp-Source: ABdhPJwBLCCqZOi/7mMT+j+lhfXFW008mVnat/YMTxJNMizUpj8H4Ra5Q8eCq4oP0GmSdeRlsTk13BDj5jtxAm31gJw=
X-Received: by 2002:a2e:9857:: with SMTP id e23mr3948643ljj.209.1612423979844;
 Wed, 03 Feb 2021 23:32:59 -0800 (PST)
MIME-Version: 1.0
References: <alpine.DEB.2.22.394.2101210959060.100764@www.lameter.com>
 <d7fb9425-9a62-c7b8-604d-5828d7e6b1da@suse.cz> <CAKfTPtDy3Ynk2nGCTWiXjz9-4vuSHB3pGuafoTUBPFNO1ac3PA@mail.gmail.com>
 <786571e7-b9a2-4cdb-06d5-aa4a4b439b7e@suse.cz> <20210123051607.GC2587010@in.ibm.com>
 <CAKfTPtAjyVmS5VYvU6DBxg4-JEo5bdmWbngf-03YsY18cmWv_g@mail.gmail.com>
 <66652406-25e4-a9e7-45a1-8ad14d2e8a36@suse.cz> <20210126230305.GD30941@willie-the-truck>
 <alpine.DEB.2.22.394.2101270907260.673600@www.lameter.com>
 <81424d71-c479-4c4a-de14-0a9b3f636e23@suse.cz> <20210203111009.GB2869122@in.ibm.com>
In-Reply-To: <20210203111009.GB2869122@in.ibm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Thu, 4 Feb 2021 08:32:48 +0100
Message-ID: <CAKfTPtBLnig+M0pjoYEYtDbVLT=J5fkn9__RrsiTrUB_51XcZw@mail.gmail.com>
Subject: Re: [RFC PATCH v0] mm/slub: Let number of online CPUs determine the
 slub page order
To:     Bharata B Rao <bharata@linux.ibm.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>, Christoph Lameter <cl@linux.com>,
        Will Deacon <will@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>, guro@fb.com,
        Shakeel Butt <shakeelb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        aneesh.kumar@linux.ibm.com, Jann Horn <jannh@google.com>,
        Michal Hocko <mhocko@kernel.org>,
        Catalin Marinas <Catalin.Marinas@arm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Feb 2021 at 12:10, Bharata B Rao <bharata@linux.ibm.com> wrote:
>
> On Wed, Jan 27, 2021 at 12:04:01PM +0100, Vlastimil Babka wrote:
> > On 1/27/21 10:10 AM, Christoph Lameter wrote:
> > > On Tue, 26 Jan 2021, Will Deacon wrote:
> > >
> > >> > Hm, but booting the secondaries is just a software (kernel) action? They are
> > >> > already physically there, so it seems to me as if the cpu_present_mask is not
> > >> > populated correctly on arm64, and it's just a mirror of cpu_online_mask?
> > >>
> > >> I think the present_mask retains CPUs if they are hotplugged off, whereas
> > >> the online mask does not. We can't really do any better on arm64, as there's
> > >> no way of telling that a CPU is present until we've seen it.
> > >
> > > The order of each page in a kmem cache --and therefore also the number
> > > of objects in a slab page-- can be different because that information is
> > > stored in the page struct.
> > >
> > > Therefore it is possible to retune the order while the cache is in operaton.
> >
> > Yes, but it's tricky to do the retuning safely, e.g. if freelist randomization
> > is enabled, see [1].
> >
> > But as a quick fix for the regression, the heuristic idea could work reasonably
> > on all architectures?
> > - if num_present_cpus() is > 1, trust that it doesn't have the issue such as
> > arm64, and use it
> > - otherwise use nr_cpu_ids
> >
> > Long-term we can attempt to do the retuning safe, or decide that number of cpus
> > shouldn't determine the order...
> >
> > [1] https://lore.kernel.org/linux-mm/d7fb9425-9a62-c7b8-604d-5828d7e6b1da@suse.cz/
>
> So what is preferrable here now? Above or other quick fix or reverting
> the original commit?

I'm fine with whatever the solution as long as we can use keep using
nr_cpu_ids when other values like num_present_cpus, don't reflect
correctly the system

Regards,
Vincent

>
> Regards,
> Bharata.
