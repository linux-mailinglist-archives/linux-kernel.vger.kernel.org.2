Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71009453BE5
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 22:48:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231389AbhKPVu5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 16:50:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbhKPVu4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 16:50:56 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3616C061570
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 13:47:58 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id i8-20020a7bc948000000b0030db7b70b6bso3146599wml.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 13:47:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=CH+wOU8IkpDGfrPMJt+XhHiyZDF6T70EhzybBc8lVmM=;
        b=qEwFgJ4U7LTjWdRCTYx0yi6+SIjDlyTtX2cbtRLGNQrkc13D/DB/O5DJw9Y9of0/LO
         pXATjSXWlIB1hiT+NIkT6g2XxmSKx8Z0CwdEP4aMWyB0FmTcJUSYFcMrGNGQ+y6FluvS
         mzZ1tQE0pk8WAqb1b0tRiFOEzN8AJsFZrgVd2O7mQxozfBz0aT703TZUQHVxLwBGrhT7
         5Ag2Cwtm+bBIQQVOYoj5n+RUNZ3o2VQgsOQa1qyiXoUhhJYtZfK24vMZHQ5SaBP2q+3C
         JZQ0Bt1u/kSixXsHaW6xsRvvOBtjyj+b8i9TN/CcdSWOuY2nzdQ+WpaoJPVXLYjCkwwv
         uQEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CH+wOU8IkpDGfrPMJt+XhHiyZDF6T70EhzybBc8lVmM=;
        b=25i0gtgxutieIQJPzgDlWdPY0+IPH8Vm18gZq7+PLajqPTsOYew+vGKM6cEr087GdU
         3AJGxpeZH7q8eJM/EaIiYcWgRBneUqjG5KSpO2r4r7+Yb/Sw/OVYPn/hqPloWOEHxgjo
         18NQapxzDfFVeXawkWF0EOT6lsMd12AjlSdSFImUpwl9EbWIK9MoKxoNaAOtpJC9K9+c
         jMNgiJ8XAwyPSwzA9gx4sbYtY4Q+ohaGnmENFF6gWl5SeMEIg+NnYrcHcR7DCQtmG2pb
         KhaYnKy3Fm9ZqefGITlMuEZ/AHsTOGuOeRv72ly3A4fpgvOupoSVa9aBjTugxBwEkfA9
         yjqw==
X-Gm-Message-State: AOAM53243drpOk8jV+9ytqwCmGslHTIlT/TnCUgRqmhGDsqAm7ysrawA
        19/v6NUK4sgO0Ntxv5aMp/Sj8g==
X-Google-Smtp-Source: ABdhPJz/gXu7UjAE8Pg+B9OjTYttzkEf3y6nVZxkFEaWbbvKwFMnOuHZAAj6ceBKrZZsh1t2dH7tvA==
X-Received: by 2002:a7b:c4c4:: with SMTP id g4mr11223073wmk.93.1637099277010;
        Tue, 16 Nov 2021 13:47:57 -0800 (PST)
Received: from elver.google.com ([2a00:79e0:15:13:ee27:74df:199e:beab])
        by smtp.gmail.com with ESMTPSA id v7sm18040254wrq.25.2021.11.16.13.47.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Nov 2021 13:47:56 -0800 (PST)
Date:   Tue, 16 Nov 2021 22:47:50 +0100
From:   Marco Elver <elver@google.com>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Mina Almasry <almasrymina@google.com>, paulmck@kernel.org,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
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
        LKML <linux-kernel@vger.kernel.org>, kasan-dev@googlegroups.com
Subject: Re: [PATCH v6] hugetlb: Add hugetlb.*.numa_stat file
Message-ID: <YZQnBoPqMGhtLxnJ@elver.google.com>
References: <CAMZfGtVjrMC1+fm6JjQfwFHeZN3dcddaAogZsHFEtL4HJyhYUw@mail.gmail.com>
 <CAHS8izPjJRf50yAtB0iZmVBi1LNKVHGmLb6ayx7U2+j8fzSgJA@mail.gmail.com>
 <CALvZod7VPD1rn6E9_1q6VzvXQeHDeE=zPRpr9dBcj5iGPTGKfA@mail.gmail.com>
 <CAMZfGtWJGqbji3OexrGi-uuZ6_LzdUs0q9Vd66SwH93_nfLJLA@mail.gmail.com>
 <6887a91a-9ec8-e06e-4507-b2dff701a147@oracle.com>
 <CAHS8izP3aOZ6MOOH-eMQ2HzJy2Y8B6NYY-FfJiyoKLGu7_OoJA@mail.gmail.com>
 <CALvZod7UEo100GLg+HW-CG6rp7gPJhdjYtcPfzaPMS7Yxa=ZPA@mail.gmail.com>
 <YZOeUAk8jqO7uiLd@elver.google.com>
 <CAHS8izPV20pD8nKEsnEYicaCKLH7A+QTYphWRrtTqcppzoQAWg@mail.gmail.com>
 <CALvZod6zGa15CDQTp+QOGLUi=ap_Ljx9-L5+S6w84U6xTTdpww@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALvZod6zGa15CDQTp+QOGLUi=ap_Ljx9-L5+S6w84U6xTTdpww@mail.gmail.com>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 16, 2021 at 12:59PM -0800, Shakeel Butt wrote:
> On Tue, Nov 16, 2021 at 12:48 PM Mina Almasry <almasrymina@google.com> wrote:
[...]
> > > Per above, probably unlikely, but allowed. WRITE_ONCE should prevent it,
> > > and at least relieve you to not worry about it (and shift the burden to
> > > WRITE_ONCE's implementation).
> > >
> >
> > Thank you very much for the detailed response. I can add READ_ONCE()
> > at the no-lock read site, that is no issue.
> >
> > However, for the writes that happen while holding the lock, the write
> > is like so:
> > +               h_cg->nodeinfo[page_to_nid(page)]->usage[idx] += nr_pages;
> >
> > And like so:
> > +               h_cg->nodeinfo[page_to_nid(page)]->usage[idx] -= nr_pages;
> >
> > I.e. they are increments/decrements. Sorry if I missed it but I can't
> > find an INC_ONCE(), and it seems wrong to me to do something like:
> >
> > +               WRITE_ONCE(h_cg->nodeinfo[page_to_nid(page)]->usage[idx],
> > +
> > h_cg->nodeinfo[page_to_nid(page)] + nr_pages);

From what I gather there are no concurrent writers, right?

WRITE_ONCE(a, a + X) is perfectly fine. What it says is that you can
have concurrent readers here, but no concurrent writers (and KCSAN will
still check that). Maybe we need a more convenient macro for this idiom
one day..

Though I think for something like

	h_cg->nodeinfo[page_to_nid(page)]->usage[idx] += nr_pages;

it seems there wants to be an temporary long* so that you could write
WRITE_ONCE(*usage, *usage + nr_pages) or something.

> > I know we're holding a lock anyway so there is no race, but to the
> > casual reader this looks wrong as there is a race between the fetch of
> > the value and the WRITE_ONCE(). What to do here? Seems to me the most
> > reasonable thing to do is just READ_ONCE() and leave the write plain?
> >
> >
> 
> How about atomic_long_t?

That would work of course; if this is very hot path code it might be
excessive if you don't have concurrent writers.

Looking at the patch in more detail, the counter is a stat counter that
can be read from a stat file, correct? Hypothetically, what would happen
if the reader of 'usage' reads approximate values?

If the answer is "nothing", then this could classify as an entirely
"benign" data race and you could only use data_race() on the reader and
leave the writers unmarked using normal +=/-=. Check if it fits
"Data-Racy Reads for Approximate Diagnostics" [1].

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/memory-model/Documentation/access-marking.txt#n74
