Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE9E645AA0A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 18:25:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239464AbhKWR2I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 12:28:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239347AbhKWR17 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 12:27:59 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3087C061714
        for <linux-kernel@vger.kernel.org>; Tue, 23 Nov 2021 09:24:49 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id m27so92489075lfj.12
        for <linux-kernel@vger.kernel.org>; Tue, 23 Nov 2021 09:24:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=q3v5tuwubo1Sqo25YljRMSH93aSZXvRl+wIvvd6U3ZU=;
        b=s8FdILRbB4MwUJbbgSZDLZfX0YADrX+/ZT4Zo71UIBs1oOGadqltv5BJq2CTkv69dX
         l8/jXRHRPisXvAZVPECWU9RPJHffQ7jMla5ycK9bddKxvcjZRGgDIkdIHbZxJsP/068k
         E2mq9s6gdobiEE6L1P0GaJEwH4LpyS6Wc4vCNYuCNFHS8gLz15105s/9wFi0qRLBVfjj
         nh8/S+xSZBtqTYGTkHXpHwzYg1BiYtckmH99kmBzUae8c+6POz8xN6LgwzMreoYVxN1j
         FGGS6xmSfk78jXVLQRNxDDi7wtpM7T44V+IjJ8Q58hUy7kSn0t3/XwxKgFHxZWTicrD0
         GMWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q3v5tuwubo1Sqo25YljRMSH93aSZXvRl+wIvvd6U3ZU=;
        b=GbOZd42j85L3o6sptTfrB3qDZ7nrs/ueUs2Dx1nzYaBn4PhWJGk0TyOawm8RlV1RO3
         TcbS4gxyh7M6k1jyFH8/ISBy71WHUSKxlqq4bpIc5lNgR7mCXwXthtqxKJnTmJNFBoCn
         cP+lozbNAJ2NwmIEIUUa2xV8V8TMHgcbynjqajpnv1efJTC87kq4vwbmgrMhuYZmyYgQ
         KvGTVcHU1kjd9K3GOih16BHjhkakowMkPeanbYuaEX/4aLQmbqXkgMaDqCKwGGas3P1C
         CBgXLc3GA1cA0shnNV54MQxGQAElVqSBHOS81IgC74UbAnxCs8DRolZnOGLkucEHHs2F
         MuAA==
X-Gm-Message-State: AOAM5303SojXWFwbRv5DOi9Bo+BNxCnSkd5mc554bc8Zp5YyitlBNkuZ
        SqNwvLJ/TLqR7LpI8ZGJ6c1eJRR8PwoizsafnK9xgQ==
X-Google-Smtp-Source: ABdhPJzdfyB+tuEZ9WOI2PZj5AtUOHkQkdMYqJipk1D2jhejMhTzG2S03AnTr00LSAxyDn+S36UL3Qhz1QQ4uyt3N5k=
X-Received: by 2002:a19:6412:: with SMTP id y18mr6804576lfb.494.1637688288026;
 Tue, 23 Nov 2021 09:24:48 -0800 (PST)
MIME-Version: 1.0
References: <20211120201230.920082-1-shakeelb@google.com> <25b36a5c-5bbd-5423-0c67-05cd6c1432a7@redhat.com>
 <CALvZod5L1C1DV_DVs9O3xZm6CJnriunAoj89YLDdCp7ef5yBxA@mail.gmail.com>
 <1b30d06d-f9c0-1737-13e6-2d1a7d7b8507@redhat.com> <CALvZod5sFQbf3t_ZDW6ob+BqVtezn-c7i1UyOeev6Lwch96=7g@mail.gmail.com>
 <92fe0c31-b083-28c4-d306-da8a3cd891a3@redhat.com> <CALvZod4C1V6Gk96oMCMguaqChjggH0KH3KKcU1QOmjRG+QEAbQ@mail.gmail.com>
 <c61a6f30-ed62-7773-3371-981102f6804f@redhat.com>
In-Reply-To: <c61a6f30-ed62-7773-3371-981102f6804f@redhat.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Tue, 23 Nov 2021 09:24:36 -0800
Message-ID: <CALvZod7xTfg5aeQC7-EaOZJ47Twb8CkoS6u4C=8+y+AX-NREVw@mail.gmail.com>
Subject: Re: [PATCH] mm: split thp synchronously on MADV_DONTNEED
To:     David Hildenbrand <david@redhat.com>
Cc:     "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Yang Shi <shy828301@gmail.com>, Zi Yan <ziy@nvidia.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 23, 2021 at 9:20 AM David Hildenbrand <david@redhat.com> wrote:
>
> On 23.11.21 18:17, Shakeel Butt wrote:
> > On Tue, Nov 23, 2021 at 8:57 AM David Hildenbrand <david@redhat.com> wrote:
> >>
> > [...]
> >>>>
> >>>> I do wonder which these locking contexts are exactly, and if we could
> >>>> also do the same thing on ordinary munmap -- because I assume it can be
> >>>> similarly problematic for some applications.
> >>>
> >>> This is a good question regarding munmap. One main difference is
> >>> munmap takes mmap_lock in write mode and usually performance critical
> >>> applications avoid such operations.
> >>
> >> Maybe we can extend it too most page zapping, if that makes things simpler.
> >>
> >
> > Do you mean doing sync THP split for most of page zapping functions
> > (but only if that makes things simpler)?
> >
>
> Yes -- if there are no downsides.
>

I will try. At the moment the assumption of "Not null zap_details
implies leave swap entries" is giving me a headache.

Thanks for the suggestions and your time.
