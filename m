Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABAE9415431
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 01:49:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238550AbhIVXvD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 19:51:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230414AbhIVXvC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 19:51:02 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 878B6C061574
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 16:49:31 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id r18so3123105qvy.8
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 16:49:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=9mxL9itJL30hA2ley9kwo18RYuXg6auysoy6Grk0OGs=;
        b=SkP783GC4LijxbJdc1E4WGaC5xZ/9RCcFAY2aXNxMPfPCyZd5cexsFDFGFJtqpa667
         xLIMTuzjctGopzaqj7hsr5KlG7MMBI+/i8RR7foSmi19Jqe3b1KC7ze3CTS3+XxC5wsE
         kF7n5O81rK4Y/yN0Us1Sr7mzoNntCi1rnWW0Z1ghZy/m7I/HILWYKa1ldxUF9kfrD1/V
         gBt1VnWsFUDrI5DmGCb2OkhFFw1bP/jsWlpNvHZSnn1Pg1bzEHbu6mxvT8QdUPvxLy+2
         g/0Su6cfhoiFlnmw4X6agEmNTRB8zc9R+l3t7ytGmWWXRanjLtlW4aKPP4jOZjll1I2t
         IMVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=9mxL9itJL30hA2ley9kwo18RYuXg6auysoy6Grk0OGs=;
        b=blShWgWA5tP5un7ifEpbfl+2s+Ug4p+TCqQ7Ua6HCQYWULf+bw/FaNzMad3eHO3omf
         ROrke3ww5pZQ2JkGzTE3X2KrqPhiuHQbClcWa0jidOU7G98fW9E43Vdh4wX+6qM1A7l3
         mVgQ9STyPE4+EgJoWj/p9R/A0kyLn2bWz+31orsFSt8NKR1fMoCJCaFaizGhDC9j3GDJ
         HjWO5g8aoagxlGBtDvhDRbKwkoob3PjlHNdt9AjsK3WBjAHEGpxCTGGhJuxOCBlpndL9
         MwLHwTWo9swbQiIiCaAGYAnkRiQa0nL8/LS7GZlllNgeBWJmG3go9FEdco70jPq3oqrR
         5Pbg==
X-Gm-Message-State: AOAM533f/xCBxYG606UBf1BBfrlGMreTdFK6WZjlRkB+uU0YeU1uEOdg
        3H4MjmqAr5N2MPlsDJ5JqFiFIQq3EarFfw==
X-Google-Smtp-Source: ABdhPJyyWsN88pzuGp0n6KZjfknD/MGtGK//T0ahVFDcilvlLIo5RFHG/ZfKJljVj0e8m84fD7/SXQ==
X-Received: by 2002:a0c:9d07:: with SMTP id m7mr1829637qvf.60.1632354570003;
        Wed, 22 Sep 2021 16:49:30 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id o145sm2877089qke.120.2021.09.22.16.49.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Sep 2021 16:49:29 -0700 (PDT)
Date:   Wed, 22 Sep 2021 16:49:17 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.anvils
To:     Yang Shi <shy828301@gmail.com>
cc:     Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Hugh Dickins <hughd@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] mm: khugepaged: don't carry huge page to the next
 loop for !CONFIG_NUMA
In-Reply-To: <CAHbLzkoHghYQaqridYuWY=YUm4AB7sQDbCjbmGgr5iXx=nsETg@mail.gmail.com>
Message-ID: <e5da8162-8360-a380-dfbb-d6b9899d508f@google.com>
References: <20210817202146.3218-1-shy828301@gmail.com> <CAHbLzkpkDXyEZ2izMwpkwLg9fN7qsQ+soR+iu6sd8RfOSqhS-A@mail.gmail.com> <20210831233839.afaenhn32nx6m2fq@box.shutemov.name> <CAHbLzkrXOM0Ow3YbZnj9RyvTJ8fwaUCzAizOMR5MP=TkxeLywg@mail.gmail.com>
 <07fd6599-88cc-e353-26f0-5de3eeea5b9f@suse.cz> <CAHbLzkoHghYQaqridYuWY=YUm4AB7sQDbCjbmGgr5iXx=nsETg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Sep 2021, Yang Shi wrote:
> On Wed, Sep 1, 2021 at 3:26 AM Vlastimil Babka <vbabka@suse.cz> wrote:
> > On 9/1/21 05:46, Yang Shi wrote:
> > > On Tue, Aug 31, 2021 at 4:38 PM Kirill A. Shutemov <kirill@shutemov.name> wrote:
> > >> On Mon, Aug 30, 2021 at 11:49:43AM -0700, Yang Shi wrote:
> > >> > Gently ping...
> > >> >
> > >> > Does this patch make sense? BTW, I have a couple of other khugepaged
> > >> > related patches in my queue. I plan to send them with this patch
> > >> > together. It would be great to hear some feedback before resending
> > >> > this one.
> > >>
> > >> I don't really care for !NUMA optimization. I believe that most of setups
> > >> that benefit from THP has NUMA enabled compile time.
> > >
> > > Agreed.
> > >
> > >>
> > >> But if you wanna to go this path, make an effort to cleanup other
> > >> artifacts for the !NUMA optimization: the ifdef has to be gone and all
> > >> callers of these helpers has to be revisited. There's more opportunities to
> > >> cleanup. Like it is very odd that khugepaged_prealloc_page() frees the
> > >> page.
> > >
> > > Yes, they are gone in this patch. The only remaining for !NUMA is
> > > khugepaged_find_target_node() which just returns 0.
> >
> > As Kirill pointed out, there's also khugepaged_prealloc_page() where the
> > only remaining variant does actually no preallocation, just freeing of an
> > unused page and some kind of "sleep after first alloc fail, break after
> > second alloc fail" logic.
> > This could now be moved to khugepaged_do_scan() loop itself and maybe it
> > will be easier to follow.
> 
> Aha, I see. Misunderstood him. I'm supposed that you mean move into
> khugepaged_scan_mm_slot().

It may not be possible, but I'd always imagined that a cleanup of this
kind would get rid of all those "struct page **hpage" artifacts.

Hugh
