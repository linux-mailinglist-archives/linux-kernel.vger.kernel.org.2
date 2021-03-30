Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5542734EAFA
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 16:49:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232105AbhC3Osg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 10:48:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232020AbhC3OsV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 10:48:21 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DCC2C061574
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 07:48:20 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id u9so25229378ejj.7
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 07:48:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bCrN/zdes5zzmbCYt/LU4SIwaX9a7ijlLHxZ2TSxl/k=;
        b=g4Z8jpHr/ljXyoKgIekeKh2oI+5Ja+ycgyrS5qZMXmvUPSLL7LE9JsrwMgn8QvCzQq
         e3U+L3R+xwqUSs1iEaihwQWddeqaKIy76U40OSzCAO21VcStW49Ex8FJEU+7GzBT6+fH
         DN9H2MarTMj4412WbYOaVUDNBVlYk+y+DYKsCQwyysuIfOk43FWfCMzQ5HQ5VD93O7Zg
         Z1lECNqqXbP1zvF3ZKcC6/NgJ7Cc987hvIXNz4J6e9iTvENI8P4Y24klkW8N57lfqWnA
         8rtoJUzgj/39R8N0Xs3l+3EcW78v3f+JUAbtue6eY7toKsqkvK3RS2CXNPtCmETMxa64
         hznA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bCrN/zdes5zzmbCYt/LU4SIwaX9a7ijlLHxZ2TSxl/k=;
        b=mTH32DGR3BHpX+UtGQLEF0i7FHxt3/KZOgb6ux8HUIgq57VvA7Ynm4z2Kl1uRkXzST
         +0P5q03w0L2fQ0e1Yui0fdlDXcgULErO9NH+T9+c3hCeH0Te4lwRAXE/lxB6a3M23hen
         hK/JDNapfKUAO3Ho9a23w2Q44r4pxnn0X1zRZlCmVTralbq3RHjxV6txD6zPPhgX9V16
         wigbdSgTWydGAk0KWBdoQVrngk7ZoCTMeaBHfluDuwt8+kXNexzZs9IcOS+uzpKy/3Vq
         x4hj/iqE+ihRLMbBGJ8NH1B5Fxdn2XdP9FWdmrmBss5SimTtqcTrPTAPUUNuksTPMtHL
         sCdQ==
X-Gm-Message-State: AOAM5337TBLBMiwymFcWwCVWhV4xoRnKSmoy+6PZJpzlZPIfEYECo7vH
        s/gnPNbFxTs3A39pdf/NJNORsiRkPVdt0CUG5vgvLEw6cxY=
X-Google-Smtp-Source: ABdhPJy0MGo+RGhx1YuHiMmxqiEC12bg+chRddoyxrEKZFzlBfpWCluMk4UEDIs8LrxP8WIClITtcax+Vh15TMibKc8=
X-Received: by 2002:a17:906:1fd6:: with SMTP id e22mr34540372ejt.481.1617115699375;
 Tue, 30 Mar 2021 07:48:19 -0700 (PDT)
MIME-Version: 1.0
References: <20210326112650.307890-1-slyfox@gentoo.org> <4e23d404-5125-6c9c-4aa7-5eff0fa1ba33@redhat.com>
 <469d6417-64a5-fe99-1214-bb0351833b74@suse.cz> <CA+fCnZcZvBT97y3zEatnTvi+RBW5bCrQRim9uK6wobYQOdgNhg@mail.gmail.com>
 <a32ffcd0-136f-4cc6-341b-16926e3787bd@suse.cz>
In-Reply-To: <a32ffcd0-136f-4cc6-341b-16926e3787bd@suse.cz>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Tue, 30 Mar 2021 16:48:08 +0200
Message-ID: <CA+fCnZdgKpGKGSyY6rmoqzDPTdTOB4DCvQk1NjreUPMRLH3XSQ@mail.gmail.com>
Subject: Re: [PATCH] mm: page_alloc: ignore init_on_free=1 for page alloc
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     David Hildenbrand <david@redhat.com>,
        Sergei Trofimovich <slyfox@gentoo.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 30, 2021 at 12:07 AM Vlastimil Babka <vbabka@suse.cz> wrote:
>
> On 3/30/21 12:00 AM, Andrey Konovalov wrote:
> > On Mon, Mar 29, 2021 at 2:10 PM Vlastimil Babka <vbabka@suse.cz> wrote:
> >>
> >> > commit 855a9c4018f3219db8be7e4b9a65ab22aebfde82
> >> > Author: Andrey Konovalov <andreyknvl@gmail.com>
> >> > Date:   Thu Mar 18 17:01:40 2021 +1100
> >> >
> >> >     kasan, mm: integrate page_alloc init with HW_TAGS
> >>
> >> But the mmotm patch/-next commit also changes post_alloc_hook()
> >>
> >> Before the patch it was:
> >> kernel_unpoison_pages(page, 1 << order);
> >> ...
> >> kernel_init_free_pages(page, 1 << order);
> >>
> >> Now it is (for !kasan_has_integrated_init()):
> >>
> >> kernel_init_free_pages(page, 1 << order);
> >>
> >> kernel_unpoison_pages(page, 1 << order);
> >>
> >> That has to be wrong, because we init the page with zeroes and then call
> >> kernel_unpoison_pages() which checks for the 0xaa pattern. Andrey?
> >
> > It's similar to free_pages_prepare(): kernel_unpoison_pages() and
> > want_init_on_alloc() are exclusive, so the order shouldn't matter. Am
> > I missing something?
>
> Yeah, when the allocation has __GFP_ZERO, want_init_on_alloc() will return true
> even with the static branches disabled.

Ah, I see. I'll post a fix soon.

Thank you!
