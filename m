Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDA5139478D
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 21:47:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbhE1TtU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 15:49:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbhE1TtT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 15:49:19 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 685E3C061574
        for <linux-kernel@vger.kernel.org>; Fri, 28 May 2021 12:47:43 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id h21so3547910qtu.5
        for <linux-kernel@vger.kernel.org>; Fri, 28 May 2021 12:47:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=fBQTuIrRObljYiAiQhOy0hTVZeNpDRQfZj9ERCQLL5Y=;
        b=LsL+FQL7sWMgpzcKy6Q1Gbck26USg350N8Nf27eEzqCfwuM4ilJVwP/MKB1RSWDSbs
         xiedGDA/nvSNqgjlNzbEyb4S5CkpdHSGjb3hXngGzl2v0eMUnFZ5q6fC+xWkhE8d9YY7
         GfLJFIl/yJsA6pSMgt004lMBBfU7YHnI0eLrX3Cq8IobE+VGi6aVhBtOO7LPeHJJWhhP
         EyqXDQ7FugqxkxRNxwoJg4JOEXyKlbWlxDHvYNTURn3jqFkEX2iAlpfvrH/ywB+2hCBM
         444UvlL25AUTr6Z0CaxUP0z5FsAGVv0GDX3Daw5rmdrN6gUWfjHraI9u1m40vSgDdQhr
         lbyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=fBQTuIrRObljYiAiQhOy0hTVZeNpDRQfZj9ERCQLL5Y=;
        b=FVu1SDRN++cbdzk80NikavgO0phhcIyG55Qv+8XR5wcwNWG4LYdPaeZpAe5nGHTiYM
         WxlW5bDAu4xskFWtds2SAFlKliPLbaqK67jm6PR+gm4/wQAjeCf/c/OwdOqPbhDi1wnH
         HQ+GuF01aRNl0YxpfKeiU7jdBK7hWjvh1kKNZMslh+EksMdqRs0Gitpe/eaWTV8jkqbx
         JfA8zSC/1Zu0Jf2zkOzJgBNN2uGfXMiwAeTAkPYz4f/2If9pUyCFrbsR5O9G2wXxUU4h
         C14S1JyUfRpRchaa0WpFfrR10/4cUY5hGg0Ld6pxH/nenG61qhTbScClVJafAAxfuTmd
         YVZw==
X-Gm-Message-State: AOAM531/G5HdrwNVHzLU75Gu5zRolaxL0zBFv7VeB4q30E1xo7fVQGTF
        WnyJqyOphIPLmdkWikGqD8RpwQ==
X-Google-Smtp-Source: ABdhPJy3YGXWy3UOsCkYVU8lqiO+VFMB+sSnOZoZp6sVzHqxjLzgeEs6n4uTixoZeBXmD4WoYffK1g==
X-Received: by 2002:ac8:758f:: with SMTP id s15mr4973564qtq.180.1622231262185;
        Fri, 28 May 2021 12:47:42 -0700 (PDT)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 90sm4086771qtg.9.2021.05.28.12.47.40
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Fri, 28 May 2021 12:47:41 -0700 (PDT)
Date:   Fri, 28 May 2021 12:47:31 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Yang Shi <shy828301@gmail.com>
cc:     hughd@google.com, willy@infradead.org, jhubbard@nvidia.com,
        kirill.shutemov@linux.intel.com, vbabka@suse.cz,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] mm: dump_page: print total mapcount for compound
 page
In-Reply-To: <20210528175403.4506-1-shy828301@gmail.com>
Message-ID: <alpine.LSU.2.11.2105281222500.22433@eggly.anvils>
References: <20210528175403.4506-1-shy828301@gmail.com>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 May 2021, Yang Shi wrote:

> The total mapcount is a useful information for debugging, but we can't
> call total_mapcount() directly since it calls some assertions which may
> be triggered as commit 6dc5ea16c86f ("mm,
> dump_page: do not crash with bad compound_mapcount()") met.
> 
> We could implement yet another implementation for dump_page() but
> it has the limitation when individual mapcount of subpages is corrupted.
> 
> Actually the total mapcount could be decoded from refcount, pincount and
> compound mapcount although it may be not very precise due to some
> transient references.
> 
> Signed-off-by: Yang Shi <shy828301@gmail.com>
> ---
> I think we are on the same page that the total mapcount is useful

Well, it may be useful (and used to be shown) in the case we've been
thinking of; but there the critical fact, page_mapped(), is evident from
the fact that your VM_WARN_ON_ONCE_PAGE(page_mapped) is shown at all:
being a number, total_mapcount() tells a little more, but not a lot.

> information and it would be ideal to print this information when dumpping

Yes, I admit I did say "ideal": but not at this cost.
I'm sorry for pointing you down (something like) this path.
If total_mapcount() itself had been assuredly safe, it would
have been nice to add in; but not this substitute.

> page if possible.  But how to implement it safely seems controversial.
> Some ideas and potential problems have been discussed by
> https://lore.kernel.org/linux-mm/alpine.LSU.2.11.2105261733110.16920@eggly.anvils/.
> 
> So I prepared this patch to show a possible approach to get some
> feedback.  The same thing could be decoded by the reader of page dump
> as well by using the same formula used by this patch.  However it sounds
> more convenient to have kernel do the math.
>  
>  mm/debug.c | 35 +++++++++++++++++++++++++++++------
>  1 file changed, 29 insertions(+), 6 deletions(-)

Adding that code to come up with a deceptive approximation to a number
which most sites won't care about: speaking for me, I'll say no.

Hugh
