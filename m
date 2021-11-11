Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 538FF44D031
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 03:59:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231272AbhKKDC0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 22:02:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbhKKDCX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 22:02:23 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA594C061766
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 18:59:34 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id n12so1113253lfe.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 18:59:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=a6bvux9h4Tr+KwqfPK/pFOv6v4cxO/N2b3R9XEEhqfA=;
        b=KDQJS33Ko67BZRHhm8SAexUqACFOdnsqgxdgYVDPFDQC+8MvPteA2hm9UbIRtTJkQh
         Oc+2RR8+ufsH87ZEI5srk3pL2ZDjtvw0rDIQLu/NPMC1JcMH/jjeuIkZ7eFejmALs6zZ
         BEpvk/xRtgnnUuT32K8Dr7rcVhceHBuDl0RKJpeBPGdV22wUhEAQv7wI5qIQ9WxNUQF1
         xTCOn7UfKj3BSiMmgUnDA/5eUr7XYsLbWpAmWuPz7w6Z6mk4U/QUn/nfDwVvko29h7l5
         MeOS75sIYUHTRgy3ZVaPt5+Jixb+UH/oorFRbabxocfXzmryICvQWLbhdQ10STL+d3nD
         z4AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a6bvux9h4Tr+KwqfPK/pFOv6v4cxO/N2b3R9XEEhqfA=;
        b=OgXJmcAyDjKB7+c8B1xaVSmduwPFXLi+Cec+lhhu3g9G+CoqvzzybQkVJjnBD5JSuW
         cop++sl49WK4+xa1ID9Xspsyup1fUNU3Dl30WDQtXMu5daGC8VXfOTWwQ72RPcG3Qf9B
         LLkwOOv9Z3tP/n0zxHFoQomwvQWDm957HgVxjMmSOA7llDQcznT2KMt90LBjDIQ9yfei
         7CPfay1JG9I6f38snHux+nPEm8JFHmjEBLprwq21sQdNSmV9KglguzSeK0JWfGhvGK9v
         yA51lJNcHFCZNjgW449bRnbRlN5IsGRkohFe5Bk5f9v1ITSoEknpdnpUWL8SMJsOdLhB
         2Yag==
X-Gm-Message-State: AOAM530VVFwuYcxdqi2UqpUgvmK52+CXwsaxyEQ3t0QRwpjYIvgBAyz5
        n+kVHQ3FS5mDNxqnDFULb2R8MKr9rEIMgFBUlc4taw==
X-Google-Smtp-Source: ABdhPJxzhDNEDPMkTAH3kZ7hEGWYTrqJQHm6P1MmxF31i/OnkWBxMRzmcgwDgpnaj6QeOUpbdkvavT2rep1HOK4mom0=
X-Received: by 2002:a05:6512:31c3:: with SMTP id j3mr3746996lfe.8.1636599572953;
 Wed, 10 Nov 2021 18:59:32 -0800 (PST)
MIME-Version: 1.0
References: <20211111015037.4092956-1-almasrymina@google.com> <CAMZfGtWj5LU0ygDpH9B58R48kM8w3tnowQDD53VNMifSs5uvig@mail.gmail.com>
In-Reply-To: <CAMZfGtWj5LU0ygDpH9B58R48kM8w3tnowQDD53VNMifSs5uvig@mail.gmail.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Wed, 10 Nov 2021 18:59:21 -0800
Message-ID: <CALvZod6bXJR5YKHYiOkc1tSMzGB2EnB8KeLEh3SF2uP6DWYcpQ@mail.gmail.com>
Subject: Re: [PATCH v6] hugetlb: Add hugetlb.*.numa_stat file
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     Mina Almasry <almasrymina@google.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@suse.com>,
        David Rientjes <rientjes@google.com>,
        Jue Wang <juew@google.com>, Yang Yao <ygyao@google.com>,
        Joanna Li <joannali@google.com>,
        Cannon Matthews <cannonmatthews@google.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 10, 2021 at 6:36 PM Muchun Song <songmuchun@bytedance.com> wrote:
>
[...]
> > +struct hugetlb_cgroup_per_node {
> > +       /* hugetlb usage in pages over all hstates. */
> > +       atomic_long_t usage[HUGE_MAX_HSTATE];
>
> Why do you use atomic? IIUC, 'usage' is always
> increased/decreased under hugetlb_lock except
> hugetlb_cgroup_read_numa_stat() which is always
> reading it. So I think WRITE_ONCE/READ_ONCE
> is enough.

Oh this is me misguiding Mina, sorry about that. Yes, READ_ONCE()
should be good enough in hugetlb_cgroup_read_numa_stat().
