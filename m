Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31176338F2C
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 14:54:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231233AbhCLNxa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 08:53:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229909AbhCLNxD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 08:53:03 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B93B8C061574
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 05:53:03 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id t18so5189321pjs.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 05:53:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aih4YwIUaxwo1xIQPYb13vTPOicVAxjDZ9nf+fTCPBc=;
        b=CZjD9K3Aw7FwEtP7Ty5YY5HLoe5+N9ftfgu69EqzTEUiByHeETAIg0GnzuFLX8fiox
         sKSbB7tYONMHAjZc9DhtE9cVjRPlRITx57XsY0ZVGgvOcRsaT4joDGey/sB2v+CC704l
         uXHjT1PB8xd9SoxZbfYj7xxfNfb/vSuE0bS7S9U/0TClGTQ9sYE+P+w6C1OdPeOBzxSp
         U/XZcRKt59Vpl4MU8KWPrKe01taXowQp2gQsmwhx2bFnoldsecj4IViNDIBDqF4I9DcH
         rUXh838KJucvFvVw66wccD7UG28p/4dbIPPehLCsqmd0+mbbbS1VzV7aVGd/v3WyOBVK
         Ocmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aih4YwIUaxwo1xIQPYb13vTPOicVAxjDZ9nf+fTCPBc=;
        b=a0+f6bSlhmb/u5KbvytHq7XiU/VXH2qf+bzmXJKsshBnuEmWuh0LjEnB/b7B4GF0eJ
         amRU/rUzd16pnup7KOxRZrZwW0CkBMQD8bdr4v6+/Pl+WNg5IdPrUVsgvb6eU6qALRWd
         f117ekWlERPAJ0YaxBcgdOd/ZHswFYjWPhs1zW+xFbuciIweOH2wU+RHpY0UmXCz/+ZQ
         P9L/4p/rYRVqxY2MmJ46MqXWerCmfcwNEQebziQcHpV9nGL9kYOYfqf3iUqU3377x9xH
         d4E5DJvCTMQUNaY5Uwf7qSlGptrbQ9IcsdTDDOu09fJXl6YrXVqQFpq5KgvTk6u1VdJL
         9AbQ==
X-Gm-Message-State: AOAM531prOc4IgbDm6K4zWPqDvLOJIK0Mi6wT5VBXFh+atx+b4SDDkxx
        0hYaIDo5MCcGdoO/UPQsYsFo4QKoZDt0dytchjvUDA==
X-Google-Smtp-Source: ABdhPJzs5IsAsolvlcB9EgNi2ACAWXfkQZL/2b8MIoeYQbEAkzD9gIojtI1jcmDWxKeyD3JjoXyCra9W0I/uQ9AIMmk=
X-Received: by 2002:a17:90a:8c08:: with SMTP id a8mr14442823pjo.136.1615557183176;
 Fri, 12 Mar 2021 05:53:03 -0800 (PST)
MIME-Version: 1.0
References: <f6efb2f36fc1f40eb22df027e6bc956cac71745e.1615498565.git.andreyknvl@google.com>
 <6cb4988a241f086be7e7df3eea79416a53377ade.1615498565.git.andreyknvl@google.com>
 <YEtH3oADQeTx1+bK@elver.google.com>
In-Reply-To: <YEtH3oADQeTx1+bK@elver.google.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Fri, 12 Mar 2021 14:52:52 +0100
Message-ID: <CAAeHK+w=3E+oowUUWfnF=SX9KYYqbV+hp1OsUFPpJf8HGnJx9g@mail.gmail.com>
Subject: Re: [PATCH 09/11] kasan: docs: update shadow memory section
To:     Marco Elver <elver@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alexander Potapenko <glider@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 12, 2021 at 11:52 AM Marco Elver <elver@google.com> wrote:
>
> On Thu, Mar 11, 2021 at 10:37PM +0100, Andrey Konovalov wrote:
> [...]
> > -The kernel maps memory in a number of different parts of the address
> > -space. This poses something of a problem for KASAN, which requires
> > -that all addresses accessed by instrumented code have a valid shadow
> > -region.
> > -
> > -The range of kernel virtual addresses is large: there is not enough
> > -real memory to support a real shadow region for every address that
> > -could be accessed by the kernel.
> > +The kernel maps memory in several different parts of the address space.
> > +The range of kernel virtual addresses is large: there is not enough real
> > +memory to support a real shadow region for every address that could be
> > +accessed by the kernel. Therefore, KASAN only maps real shadow for certain
> > +parts of the address space.
> >
> >  By default
> >  ~~~~~~~~~~
>
> While we're here, can we change this "By default" heading which seems
> wrong -- the paragraph starts with "By default, ..." as well.
>
> Perhaps "Default Behaviour"?

Sounds good, thanks!
