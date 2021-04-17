Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BE1F362D00
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Apr 2021 04:52:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235369AbhDQCxQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 22:53:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231997AbhDQCxP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 22:53:15 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5CC2C061574
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 19:52:49 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id ot17-20020a17090b3b51b0290109c9ac3c34so17385726pjb.4
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 19:52:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3y4uMJwxdfxzyakbODD1x0NzAbS7Yk2HNyccYDXmfCI=;
        b=uhJmRC/aYBTjuTZ2C05qdctiZJlM6K2Ig6e358l38mvItPTVNPJ3EWIJ7wdzpJB7vT
         3e/HSVZWbU+nI4+hXfwZckvT6bb14TlDq9eunjskYgGcNQ1qH4Lcw09LFddKDgYbhYCF
         RAOWUn/MKlyD2nDbuEgMCLz4IBdvq5dQAtGJg+vcH9orrFRqHSnDSZ+Zua/A6i1cRvb2
         FcflbOWw39G+FaGYnam0OICqLbAjA5ZhXpG+ww35/rmNZNbMX5nV+vLf06Xa8c5z/ieU
         zWfQY8oUDJH8N+5qWpAaO3fXbn6JGwVhRqcQh7Lvf9jdfZlLG7FIIE8XMl3w5lJkMq5c
         ukDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3y4uMJwxdfxzyakbODD1x0NzAbS7Yk2HNyccYDXmfCI=;
        b=ph35MCZinilgfZRH02ZDPeTekGxqQe93i5PMwl62QbORnUkaPGyVo2ALOLaBdTtNrv
         64cywE/Ws3jRlD1N01olZbbcOXk/nmgmTnU8eoNIkjTcKYyL8IdZRnL6CcErMW5klr8n
         GFwVROyzTBuPA6/rwZBlBggT8GIFl2ifSsz838Vyw9UQtuu4NA9HjWYU+BUEOzdrR/GV
         RPWFusT4mpgaGSGJKjJebIGco0xpBLE6Kzz4/ime0Cb4deSlnuWXjxzJZ1Txu9cddL0T
         A60zDR/n2edkDcUp5cD+k8B+eY3OC5CAtu4LIcsqRywn4sClpiCPPhTcLlUIauOfZqtB
         r2lw==
X-Gm-Message-State: AOAM533kImL3QE8SZn5d+4MK7Yktj2fJQZ1iQ8TnfQZyjCVU2Q7fPyUT
        PFhydtxl6QMTKV2ZQDHvmBDX13xgks//oV9Fi0GBcQ==
X-Google-Smtp-Source: ABdhPJw/MdTLGomUJTFifNOlyECCO5Kfd1e6fcMYTr7DRYck2137jMjE8g4Kt+HVeQXO4eht//z+fqK0V19E4upYe6Q=
X-Received: by 2002:a17:90a:a895:: with SMTP id h21mr12995333pjq.13.1618627969184;
 Fri, 16 Apr 2021 19:52:49 -0700 (PDT)
MIME-Version: 1.0
References: <20210416051407.54878-1-songmuchun@bytedance.com>
 <20210416051407.54878-6-songmuchun@bytedance.com> <YHmrUaho1SLSCfk7@cmpxchg.org>
In-Reply-To: <YHmrUaho1SLSCfk7@cmpxchg.org>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Sat, 17 Apr 2021 10:52:12 +0800
Message-ID: <CAMZfGtVOATBUgP7ZiyM4w9twhd1-z-gTd865r+Lb0CPtt=ZJjg@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v2 5/8] mm: memcontrol: rename
 lruvec_holds_page_lru_lock to page_matches_lruvec
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Roman Gushchin <guro@fb.com>, Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Xiongchun duan <duanxiongchun@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 16, 2021 at 11:20 PM Johannes Weiner <hannes@cmpxchg.org> wrote:
>
> On Fri, Apr 16, 2021 at 01:14:04PM +0800, Muchun Song wrote:
> > lruvec_holds_page_lru_lock() doesn't check anything about locking and is
> > used to check whether the page belongs to the lruvec. So rename it to
> > page_matches_lruvec().
> >
> > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
>
> The rename makes sense, since the previous name was defined by a
> specific use case rather than what it does. That said, it did imply a
> lock context that makes the test result stable. Without that the
> function could use a short comment, IMO. How about:
>
> /* Test requires a stable page->memcg binding, see page_memcg() */

Make sense. I will add this comment.

>
> With that,
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>

Thanks.
