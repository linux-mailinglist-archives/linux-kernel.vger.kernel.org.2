Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4615366721
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 10:42:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236687AbhDUImW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 04:42:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231354AbhDUImV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 04:42:21 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90A90C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 01:41:47 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id i190so28064561pfc.12
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 01:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7oNq/GoX/wWyLVMqPPyPFw2WqRnLII9SMnWeBDHEYWM=;
        b=UH3HvBtxuqUSRCRg7af5/NPOrhED4cbywm/RTd6mU8QwXHcZttyQmIrvmoLFsTj5b+
         9WvKBjrF8BTbQNYhgitrYasQ3jOxo69pf9TvvDhclm/SuuSNJN/i9bQ1A+TlG0pC2Nbo
         ERS8J0dML+Pb/MAVuou1GQqerAju9NroN8OzQYQbOHIsPzvXb+SdeMDKcHzjDeKE/ZjA
         u/NEirp2CXwJU0wy7BM02lFlHWuhy1kOHjjUawQh59xLCamL+LvVJoj1rLCiyy8gAynU
         grXR5qWZCNV/JBpthPCfyG6WBraQsfJI8DjC3L3IP5BF48CIcHrVIMisYS7ye98B9dvU
         Wq7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7oNq/GoX/wWyLVMqPPyPFw2WqRnLII9SMnWeBDHEYWM=;
        b=ITgerseF/jGos1ORNRQSuA5KpOeJXVoxFXB2juBld2LJMU+uM/7KHLKxSgZDKzvc7t
         s305F0xclNKLNugFtoN8gz4usWB7eGDiteFreoH6HkJUzgNZc3W13T0CybtoEzEudDHQ
         Ye9opyLw4818WSeQyyIed/mx94uRH6BCFmD0oZ++6fqqZz+NG+vNPHfBI9cPbC1d3dLf
         pCQIpp7hPwmjvNqGCLNqkj/qaUiMk1g+6IAVKY2PeJ2GqSkTwsIQJK5KJ//Nl+eAcfn+
         QcK7JSsGGs42n/+E0TkbnELVyUuwJl+DKceizN7aW6/MzcMtEFC0KRolbTWi5i4pNDDC
         xRjg==
X-Gm-Message-State: AOAM532eBJRbzBFpIYNWQkHe1hmdBBtRrJhBpBTlBHGoI0X4lwWUbjuU
        2PcvdjAwi52+Qh2b7RrCKFGJ/9TB94DV+sqD3H9Lrg==
X-Google-Smtp-Source: ABdhPJyKinwWDm4DQYXcFdrKAq8xyp3HIKdOBPENuNYeXBT1tsmLHOAaBNvNmn6iP9jjqZC6um0la3MYOIJ/9AnUwDA=
X-Received: by 2002:a63:1665:: with SMTP id 37mr21286782pgw.31.1618994507206;
 Wed, 21 Apr 2021 01:41:47 -0700 (PDT)
MIME-Version: 1.0
References: <20210421060259.67554-1-songmuchun@bytedance.com>
 <YH/cVoUCTKu/UkqB@dhcp22.suse.cz> <CAMZfGtWh4tRiMrOTLvv5GHM1JUCt9b+UHf_DwLev32S=+iLW8g@mail.gmail.com>
 <20210421082103.GE22456@linux>
In-Reply-To: <20210421082103.GE22456@linux>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Wed, 21 Apr 2021 16:41:10 +0800
Message-ID: <CAMZfGtXsXViJTWrMoECCaCD+2mF7zB5n61aFJvVgpGTaUVEC4A@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] mm: hugetlb: fix a race between
 memory-failure/soft_offline and gather_surplus_pages
To:     Oscar Salvador <osalvador@suse.de>
Cc:     Michal Hocko <mhocko@suse.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 21, 2021 at 4:21 PM Oscar Salvador <osalvador@suse.de> wrote:
>
> On Wed, Apr 21, 2021 at 04:15:00PM +0800, Muchun Song wrote:
> > > The hwpoison side of this looks really suspicious to me. It shouldn't
> > > really touch the reference count of hugetlb pages without being very
> > > careful (and having hugetlb_lock held). What would happen if the
> > > reference count was increased after the page has been enqueed into the
> > > pool? This can just blow up later.
> >
> > If the page has been enqueued into the pool, then the page can be
> > allocated to other users. The page reference count will be reset to
> > 1 in the dequeue_huge_page_node_exact(). Then memory-failure
> > will free the page because of put_page(). This is wrong. Because
> > there is another user.
>
> Note that dequeue_huge_page_node_exact() will not hand over any pages
> which are poisoned, so in this case it will not be allocated.

But softoffline does not set page hwpoison before
__get_hwpoison_page(). So the page still can be
allocated. Right?

> But it is true that we might need hugetlb lock, this needs some more
> thought.
>
> I will have a look.
>
> --
> Oscar Salvador
> SUSE L3
