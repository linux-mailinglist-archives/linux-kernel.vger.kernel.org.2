Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 663CD413B67
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 22:31:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234866AbhIUUdT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 16:33:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234860AbhIUUdS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 16:33:18 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F500C061574
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 13:31:49 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id a20so193722ilq.7
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 13:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DqY1Vo6rBjxwgRtTp30JVZpZOPnNe0pyZj0C2CZjUVw=;
        b=s0cRXLXPw9jzQRveUiI1hg8xKNbO9dZyF2j+462NYaizVy6T8uCV4/hjprvYfdzWoK
         r8HUEPyj0WrjpFykalEkeT/7dDkaocbHBiT2BZinKxnDQFMeUk53wGxO+Co0J9kxk6Jt
         oSEf4JD0TCudSACXdHtE03OK1CPUU/fEHrUOkdw30QlzhQIejrA+w8Kp3eqlCXBlfkps
         FXYuGnR774tuVhqaT5so2vdhgli8oMSgpIG23ZA2UdgKnLBh3yp4YnGv7homD1JeRmPk
         4f0hAgQ7rseaAk2efIoej5cChF6dVIwvmRcTOx9vpxtkWFOBFc+qJfDefVwHQb8kV054
         l5rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DqY1Vo6rBjxwgRtTp30JVZpZOPnNe0pyZj0C2CZjUVw=;
        b=QmYe5dCTts22ez5df5iDyVuGcqXS9fifBhxQjIcjwfJic8qX6xRpculcOYNjD7tTkY
         ABJc8a4WXIOnfby9XKQ/Mw1XqYzQA59ZqfUZfUer7ui2lc2njbAbGpiZc9mkuX+CTQLq
         vg1BxvHnpyFSpx3ZuO6KLo8gU8fput/cm5N7uIaNpmlx7ualpU7qe87ugSqcrQogiPKS
         o8FtB9UG+B9DYyT0eQQEJgNF3pAM+UeRb4XMrcU6X5AGye6Y4qUzDMi8hOlgEaDOAOcb
         xaoKG6NrHpvSHRTM8WWLuHa7D65N/nL/COHfVNaCcMBvJ9n0xZf4kmuM1x2L1TjiJpWm
         gPxA==
X-Gm-Message-State: AOAM53279c9oAVNHh+vcqvKgeP1mh2ukrWMBEMTgKoS+vJ0nKN+/A1dj
        6VDh52/hBx9Zj8uR0Yyr/WaCAKQKQfb9OVPN8IIAlQ==
X-Google-Smtp-Source: ABdhPJy/5LOJ1t7rciSg2coqG7vYdq9My9omf2cUTTzqP+0E/xzv+H0jDFAATqw4pOEYuLVu+tbD/iysVAF7ZiZr5R0=
X-Received: by 2002:a92:de07:: with SMTP id x7mr23230621ilm.239.1632256308713;
 Tue, 21 Sep 2021 13:31:48 -0700 (PDT)
MIME-Version: 1.0
References: <20210921163323.944352-1-axelrasmussen@google.com>
 <YUoaDr2wsW8wtk5Z@t490s> <CAJHvVcj68inRrpmw0pJq9qFc20JzG8+s7b31HkXQcsLcAJN_0Q@mail.gmail.com>
 <YUowr6phZU4v7dds@t490s>
In-Reply-To: <YUowr6phZU4v7dds@t490s>
From:   Axel Rasmussen <axelrasmussen@google.com>
Date:   Tue, 21 Sep 2021 13:31:12 -0700
Message-ID: <CAJHvVcgz18qU9vjPimOhJ5YswfJnLN0tQGfsgjCh6M7ckvhfgA@mail.gmail.com>
Subject: Re: [PATCH 1/3] userfaultfd/selftests: fix feature support detection
To:     Peter Xu <peterx@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, Linux MM <linux-mm@kvack.org>,
        Linuxkselftest <linux-kselftest@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 21, 2021 at 12:21 PM Peter Xu <peterx@redhat.com> wrote:
>
> On Tue, Sep 21, 2021 at 11:26:14AM -0700, Axel Rasmussen wrote:
> > On Tue, Sep 21, 2021 at 10:44 AM Peter Xu <peterx@redhat.com> wrote:
> > >
> > > Hi, Axel,
> > >
> > > On Tue, Sep 21, 2021 at 09:33:21AM -0700, Axel Rasmussen wrote:
> > > > diff --git a/tools/testing/selftests/vm/userfaultfd.c b/tools/testing/selftests/vm/userfaultfd.c
> > > > index 10ab56c2484a..2366caf90435 100644
> > > > --- a/tools/testing/selftests/vm/userfaultfd.c
> > > > +++ b/tools/testing/selftests/vm/userfaultfd.c
> > > > @@ -79,10 +79,6 @@ static int test_type;
> > > >  #define ALARM_INTERVAL_SECS 10
> > > >  static volatile bool test_uffdio_copy_eexist = true;
> > > >  static volatile bool test_uffdio_zeropage_eexist = true;
> > > > -/* Whether to test uffd write-protection */
> > > > -static bool test_uffdio_wp = false;
> > > > -/* Whether to test uffd minor faults */
> > > > -static bool test_uffdio_minor = false;
> > >
> > > IMHO it's not a fault to have these variables; they're still the fastest way to
> > > do branching.  It's just that in some cases we should set them to "false"
> > > rather than "true", am I right?
> > >
> > > How about we just set them properly in set_test_type?  Say, we can fetch the
> > > feature bits in set_test_type rather than assuming it's only related to the
> > > type of memory.
> >
> > We could do that, but it would require opening a userfaultfd, issuing
> > a UFFDIO_API ioctl, and getting the feature bits in set_test_type. And
> > then I guess just closing the UFFD again, as we aren't yet setting up
> > for any particular test. To me, it seemed "messier" than this
> > approach.
> >
> > Another thing to consider is, for the next patch we don't just want to
> > know "does this kernel support $FEATURE in general?" but also "is
> > $FEATURE supported for this particular memory region I've
> > registered?", and we can't have a single global answer to that.
>
> Could I ask why?  For each run, the memory type doesn't change, isn't it?  Then
> I think the capability it should support is a constant?

Ah, it has to do with us asserting the list of expected ioctls. The
kernel changes the list of ioctls it reports in response to a
UFFDIO_REGISTER, depending on the particular kind of vma being
registered, **as well as what mode(s) it is being registered with**.

So for example, consider the hugetlb_shared test. When registering,
the kernel might set the UFFDIO_CONTINUE bit or not, depending on
whether we registered with the MINOR mode bit set in particular. So it
will be present in one test case, but not in another, and so the set
of expected ioctls has to be computed at test time, rather than in
set_test_type.

>
> Btw, note that "open an uffd, detect features, close uffd quickly" during setup
> phase is totally fine to me just for probing the capabilities, and instead of
> thinking it being messy I see it a very clean approach..
>
> > It seemed a bit cleaner to me to write the code as if I was dealing with that
> > case, and then re-use the infrastructure I'd built for patch 2/3.
>
> I didn't comment on patch 2, but I had the same confusion - aren't all these
> information constant after we settle the hardware, the kernel and the memory
> type to test?
>
> >
> > Basically, I didn't initially have a goal of getting rid of these
> > variables, but it ended up being the cleanest way (IMHO).
> >
> > Just trying to explain the thinking. :) In the end, I think it's a
> > stylistic choice and don't feel super strongly about it, either way
> > could work. So, I can change it if you or others do feel strongly.
>
> I have no strong opinion as long as the code works (which I trust you on :).
> We can keep it in Andrew's queue unless you do feel the other way is better.
>
> Thanks,
>
> --
> Peter Xu
>
