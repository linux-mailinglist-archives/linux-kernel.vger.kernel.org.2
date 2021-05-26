Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C0DF392328
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 01:19:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234797AbhEZXV3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 19:21:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234790AbhEZXV1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 19:21:27 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6600AC061574
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 16:19:55 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id r1so2250018pgk.8
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 16:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xkFaYIRJ8Xn7aV9Ve9vLtJbZCL3Y9SjDBz6B6q1dZfo=;
        b=VckkPhgBIS+uV4vApBDjd03EF/OTJ6ZqXUg6wEZ4JsmiAwDTwPC6B2CSkysmB4KNkZ
         j4Q30TN2oKA7oeNXL88m++dFmSjTfykrALHkyVG7Rcth3dy2/r2YnKq4H3y2QmP+sNSR
         dGRID8waPsKvIdeB2tpP2pVf3X8+mJoalvf4IcT0nHpFKKYrERa/MeaYq1lTwXCzjm/u
         6IWdHlkqT+7Nk/lTEC+KcCqOKPuTs3T467OPEeT3S/TmesMm3DouZIt0B4TEgcdGFD2W
         8s6t7huPPTjA4Q5uUa7GCMVemH4hXcZu3JQvJc2dVhWY1ojz0ItoOdeBxfUMFZJiXhhp
         A1LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xkFaYIRJ8Xn7aV9Ve9vLtJbZCL3Y9SjDBz6B6q1dZfo=;
        b=Qjeiz6uzYWUgMHiJOOFHackmWZoVz8YqQ1NnnTyA8XXadGyaJQnQtLx+52IYzXV+Vn
         Ktf+FEm/jqa2+d0AWIYDwIpMI8sqMOrKAz1czKNWwWips5liB2ADGOWPdjoO03VYAglN
         OnOrVr619oC+a+8oXj3qEMAoxC9JDLGXtNUEAiMsw/PFD3rbW3I1YKurzFj9/SHHskta
         wCCdQlabDyK4hCUIBw9XJpSIh9X5ZPlaSdGx8QXZqOmitMQRqXRAzh0nGCDw2TcHl0fj
         SYs+2AWzgEJIj46EHWsEydPPD+mSg0fFXvF4Xvw2gKtPpcssjpI3ONKuqUdZbi3HQOHa
         GJEA==
X-Gm-Message-State: AOAM532fdxJI9VjhcLTpPhMyfU7RL1nAPqoF2yUx95TB0jdWBwOkI9Vr
        Zy/vaju6cCTjCveGHNN+2x+czfdQFM6LpBdHxOPF2w==
X-Google-Smtp-Source: ABdhPJzenLFO9BVYIAZxvIsE1FomgnHy3KEJZ3JK2QrLaI95VEbrUlUsZPYCX9k2jA9gaQ2n9MDB8QaA1tZo8cVjLds=
X-Received: by 2002:a63:610b:: with SMTP id v11mr873781pgb.291.1622071194712;
 Wed, 26 May 2021 16:19:54 -0700 (PDT)
MIME-Version: 1.0
References: <78359cf0-6e28-2aaa-d17e-6519b117b3db@oracle.com>
 <20210525233134.246444-1-mike.kravetz@oracle.com> <CAMZfGtVUvtCCEHN_V8iE4m9FAmiz9e5Z1CNNvnetXsrEwAVzgQ@mail.gmail.com>
 <1485e64d-e794-c24e-9688-51b0c1bc1340@oracle.com>
In-Reply-To: <1485e64d-e794-c24e-9688-51b0c1bc1340@oracle.com>
From:   Mina Almasry <almasrymina@google.com>
Date:   Wed, 26 May 2021 16:19:43 -0700
Message-ID: <CAHS8izN+-GVOp5cowjkT9WBXYf9Xg6BThWin8tWoKg2ZGFia0Q@mail.gmail.com>
Subject: Re: [External] [PATCH 0/2] Track reserve map changes to restore on error
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Muchun Song <songmuchun@bytedance.com>,
        Linux-MM <linux-mm@kvack.org>,
        open list <linux-kernel@vger.kernel.org>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Peter Xu <peterx@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 26, 2021 at 10:17 AM Mike Kravetz <mike.kravetz@oracle.com> wrote:
>
> On 5/25/21 8:19 PM, Muchun Song wrote:
> > On Wed, May 26, 2021 at 7:31 AM Mike Kravetz <mike.kravetz@oracle.com> wrote:
> >>
> >> Here is a modification to the reservation tracking for fixup on errors.
> >> It is a more general change, but should work for the hugetlb_mcopy_pte_atomic
> >> case as well.
> >>
> >> Perhaps use this as a prerequisite for your fix(es)?  Pretty sure this
> >> will eliminate the need for the call to hugetlb_unreserve_pages.
> >
> > Hi Mike,
> >
> > It seems like someone is fixing a bug, right? Maybe a link should be
> > placed in the cover letter so that someone can know what issue
> > we are facing.
> >
>
> Thanks Muchun,
>
> I wanted to first see if these patches would work in the code Mina is
> modifying.  If this works for Mina, then a more formal patch and request
> for inclusion will be sent.
>

So a quick test: I apply my patche and yours on top of linus/master,
and I remove the hugetlb_unreserve_pages() call that triggered this
conversation, and run the userfaultfd test, resv_huge_pages underflows
again, so it seems on the surface this doesn't quite work as is.

Not quite sure what to do off the top of my head. I think I will try
to debug why the 3 patches don't work together and I will fix either
your patch or mine. I haven't taken a deep look yet; I just ran a
quick test.

> I believe this issue has existed since the introduction of hugetlb
> reservations in v2.6.18.  Since the bug only shows up when we take error
> paths, the issue may not have been observed.  Mina found a similar issue
> in an error path which could also expose this issue.
> --
> Mike Kravetz
