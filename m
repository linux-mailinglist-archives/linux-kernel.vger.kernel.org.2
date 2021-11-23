Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9B9D45AA17
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 18:28:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238583AbhKWRb7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 12:31:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239281AbhKWRb4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 12:31:56 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79D75C06173E
        for <linux-kernel@vger.kernel.org>; Tue, 23 Nov 2021 09:28:47 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id n12so17917lfe.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Nov 2021 09:28:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0VQ/DXnMuEbx26lUPiWfkgXYKbsUMBeuhoLEdn1uwPY=;
        b=LjjIQiSAWqZ2g0LZZgrpgKZfI5OfBDS1vwZklGguJ7PGH9V/pvMAh4r5lAyFthu4EB
         Yo91sS5li38g/GvU5hE6NVpdFO3h0lq71jPgOPtozZRfYb1DfLmU8Z8MoVblkuGZb4aE
         umbqVrKyk1aDwEb772YUahRG9IkKUnK8y3tvzZf1OVOQg6my5h/21Y1IQ26cfN1CDWAk
         mNlFpZ+IT3DFTYRzyrZ5pNMIxbayTF5gIBGUVpOmQyk/0YX9pMUMKhyW7iEvua9S7hcA
         cI0HLDAeVPmkHe7vSXzPeKk3O7VK8McFSqUnsIr4l9b143K4wDyb8wP/IgJpaUf/xAck
         7Zjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0VQ/DXnMuEbx26lUPiWfkgXYKbsUMBeuhoLEdn1uwPY=;
        b=u/UVLc3DWVw5AEsjoL+2w/odE9C8IjqB9bAQ5eBmzExfb0G56Hvu4iNfXxwIKb4VCK
         yGvauD98aQbTQMQEgt2o/PB8UoBO0A3Tjy2HLes1LcozmrQX9uDHisk7QH3G19VcFPS4
         bXbJ2y8i/341uWgh7NFpGORzc8Jg5jyy0f5Z8k2F77a97NQRfVO90EkAhAPYAwDnZvgQ
         BJTkBhzNVupvLqxlDqDspuxOqRWEe90JGNUGf8zkJ+mZGasrVcjibjZUW5k12Wu3l7EX
         0AjlOezv8WlfzzcwVymmp+k0mhE6lmyKwd5VGWGhLhkd0LMwXj+l7De14yNvE/GXAcxt
         Ec1g==
X-Gm-Message-State: AOAM532+ztS4sRdgbWRNWFNa+j2bjd+yJIqNkebx37w+4OV1nxAGew7n
        NmFHJiKrZOPKgTtLe0IJZIDzTSfr047yL6pAw2Bz1Q==
X-Google-Smtp-Source: ABdhPJysD3LJp3obeHCcm6LaJbNT1NkcWYlv//jXgDLA2+KIrlDxanfCBMwXcLRyTJlpwDA8uvDhaNJKLOFm9MdGHls=
X-Received: by 2002:ac2:4d0a:: with SMTP id r10mr6444054lfi.210.1637688525482;
 Tue, 23 Nov 2021 09:28:45 -0800 (PST)
MIME-Version: 1.0
References: <20211120201230.920082-1-shakeelb@google.com> <25b36a5c-5bbd-5423-0c67-05cd6c1432a7@redhat.com>
 <CALvZod5L1C1DV_DVs9O3xZm6CJnriunAoj89YLDdCp7ef5yBxA@mail.gmail.com>
 <1b30d06d-f9c0-1737-13e6-2d1a7d7b8507@redhat.com> <CALvZod5sFQbf3t_ZDW6ob+BqVtezn-c7i1UyOeev6Lwch96=7g@mail.gmail.com>
 <92fe0c31-b083-28c4-d306-da8a3cd891a3@redhat.com> <CALvZod4C1V6Gk96oMCMguaqChjggH0KH3KKcU1QOmjRG+QEAbQ@mail.gmail.com>
 <c61a6f30-ed62-7773-3371-981102f6804f@redhat.com> <CALvZod7xTfg5aeQC7-EaOZJ47Twb8CkoS6u4C=8+y+AX-NREVw@mail.gmail.com>
 <1b400921-8bef-8073-10f9-a7cbb09cfefe@redhat.com>
In-Reply-To: <1b400921-8bef-8073-10f9-a7cbb09cfefe@redhat.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Tue, 23 Nov 2021 09:28:34 -0800
Message-ID: <CALvZod6wyF7v1v888StoXSSWtb7ujaeBUnUB8Vs2RfMzUsj+Gw@mail.gmail.com>
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

On Tue, Nov 23, 2021 at 9:26 AM David Hildenbrand <david@redhat.com> wrote:
>
> On 23.11.21 18:24, Shakeel Butt wrote:
> > On Tue, Nov 23, 2021 at 9:20 AM David Hildenbrand <david@redhat.com> wrote:
> >>
> >> On 23.11.21 18:17, Shakeel Butt wrote:
> >>> On Tue, Nov 23, 2021 at 8:57 AM David Hildenbrand <david@redhat.com> wrote:
> >>>>
> >>> [...]
> >>>>>>
> >>>>>> I do wonder which these locking contexts are exactly, and if we could
> >>>>>> also do the same thing on ordinary munmap -- because I assume it can be
> >>>>>> similarly problematic for some applications.
> >>>>>
> >>>>> This is a good question regarding munmap. One main difference is
> >>>>> munmap takes mmap_lock in write mode and usually performance critical
> >>>>> applications avoid such operations.
> >>>>
> >>>> Maybe we can extend it too most page zapping, if that makes things simpler.
> >>>>
> >>>
> >>> Do you mean doing sync THP split for most of page zapping functions
> >>> (but only if that makes things simpler)?
> >>>
> >>
> >> Yes -- if there are no downsides.
> >>
> >
> > I will try. At the moment the assumption of "Not null zap_details
> > implies leave swap entries" is giving me a headache.
>
> Not only you, did you stumble over
>
> https://lkml.kernel.org/r/20211115134951.85286-1-peterx@redhat.com
>
> already?
>

Oh thanks for the pointer. I missed that. I will take a look. Thanks again.
