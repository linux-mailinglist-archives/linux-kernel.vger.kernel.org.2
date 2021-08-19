Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCDAD3F21BE
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 22:43:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235210AbhHSUni (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 16:43:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230052AbhHSUnh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 16:43:37 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E7EDC061575
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 13:43:01 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id r17-20020a0568302371b0290504f3f418fbso10253487oth.12
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 13:43:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=6AuFKvgToZ7Ta1FvqLShY8VobvpryykUZKzf0fozJsI=;
        b=RAPuF9LkPlLDHQGygCJBq+C9FhAfcBI0q9lzvcbq0+vFvjDff2qqs0yqNiUGqgT6pJ
         +KGVklTDk55wQM2lKKBNAcOGMFcXIJA2F0AhgQgsblw6LNuHoHg5mhuoiNH4UVR1INZ1
         m3nzz0+xc/Q6FpA1TxXq3F+nTBmf94raaIf0+5ndKXr8ozG8cCXxbY/ZouCaLa5HlCEC
         khHdrHAv77vpam+HZ4I6Ga00T+/Ij/dSldaKRxTfKDU5xLdMx6jVfQ+DPXnp/S7UQvSg
         CU8HfbACS1oUbNjAo1+RFheI0KeQsN9mh2Ow6smeMT8M/Bi+zt6GNJYpAZfiFgbcB/hd
         yaLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=6AuFKvgToZ7Ta1FvqLShY8VobvpryykUZKzf0fozJsI=;
        b=flK6mIqpFq4U90NhjPmUXQY7ZtFIkgn1Y4B3XlOXfBHeiz3gGnZOVo1ugrsN0s5faQ
         8sILGsdqdpXlunsTuBABYNXeHEkbwKItmK649v+d24dw6EHLcxH8bPriZNNvLnldKj6o
         OXL5pSK+OYNJdEIHpsg0iHNJkbVQSe6r/5uKi92DRzhibWwHE5/7W15h2BWhmDwJeGq0
         jD2/ZC3/0d07xfQtYXhZCaxWgYaenFeGhlnStj1nJv+wQXGMN8FGkqFMjKAIQ5MTvnkS
         9cPPuG31iW5ew0sjlIM4NhCPYTkBP1Ez0g73pKwnPkIcJDH2NAl38TQSrAR2/xdaZZeR
         yMkw==
X-Gm-Message-State: AOAM533gv90+Ux08m2Dgqb2XjLRTm4o8a60Bx/mvqUnrIcWEhKXysyse
        LN9jFJx0P7lDEEeeVktPVfB5Yw==
X-Google-Smtp-Source: ABdhPJzVAfKQrGyiYF1L0Skh5bMfGADM2OCaV0cTOg8AtRAK3YmpSa2ooGXsKcRuk4MWrrk7Z3kjDQ==
X-Received: by 2002:a9d:6192:: with SMTP id g18mr13666032otk.314.1629405780110;
        Thu, 19 Aug 2021 13:43:00 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id n17sm938960otl.32.2021.08.19.13.42.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Aug 2021 13:42:59 -0700 (PDT)
Date:   Thu, 19 Aug 2021 13:42:43 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.anvils
To:     Matthew Wilcox <willy@infradead.org>
cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: Remove bogus VM_BUG_ON
In-Reply-To: <YR05JVZwfAlZO9Wh@casper.infradead.org>
Message-ID: <813d476-b6d4-456e-b5c3-5fe0455edeb3@google.com>
References: <20210818144932.940640-1-willy@infradead.org> <2197941-297c-f820-aa57-fb5167794fb1@google.com> <YR05JVZwfAlZO9Wh@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Aug 2021, Matthew Wilcox wrote:
> On Wed, Aug 18, 2021 at 09:34:51AM -0700, Hugh Dickins wrote:
> > On Wed, 18 Aug 2021, Matthew Wilcox (Oracle) wrote:
> > 
> > > It is not safe to check page->index without holding the page lock.
> > > It can be changed if the page is moved between the swap cache and the
> > > page cache for a shmem file, for example.  There is a VM_BUG_ON below
> > > which checks page->index is correct after taking the page lock.
> > > 
> > > Cc: stable@vger.kernel.org
> > > Fixes: 5c211ba29deb ("mm: add and use find_lock_entries")
> > 
> > I don't mind that VM_BUG_ON_PAGE() being removed, but question whether
> > this Fixes anything, and needs to go to stable. Or maybe it's just that
> > the shmem example is wrong - moving shmem from page to swap cache does
> > not change page->index. Or maybe you have later changes in your tree
> > which change that and do require this. Otherwise, I'll have to worry
> > why my testing has missed it for six months.
> 
> I'm sorry, I think you're going to have to worry :-(

Indeed, it seems that way; or maybe I can leave this testing to syzbot.

> Syzbot found it initially:
> 
> https://lore.kernel.org/linux-mm/0000000000009cfcda05c926b34b@google.com/

Ah, that's useful info.  Though I can quite see why you didn't mention
that originally: it looks as if syzbot hit a find_lock_entries() crash
and an irqstate warning about the same time, and its bisection went off
and found the commit that introduced those irqstate warnings: neither
the root cause of the irqstate warning, nor the cause of the
find_lock_entries() crash which it claims in the Subject.

I have briefly tried the C reproducer, but didn't get anything out of it;
and suspect it may be a reproducer of the irqstate warning rather than
the crash which interests you and me.  And I can't tell more from the
dump, no dump_page() info is shown, and the "Code:" just points into a
function epilog of assorted ud2s.

> 
> and then I hit it today during my testing (which is definitely due to
> further changes in my tree).

Okay, and it's perfectly reasonable for your tree to make changes which
require that VM_BUG_ON_PAGE to be removed. But I do not yet understand
why it needs to be removed from the current or stable tree.

I don't believe it has anything to do with swap cache. The reproducer
is mounting with "huge=within_size", and doing lots of truncation: my
supposition is that a shmem THP is being collapsed or split,
concurrently with that find_lock_entries().

I don't actually see how that would lead to this VM_BUG_ON_PAGE:
I imagine find_get_entry()'s xas_reload check after get_speculative
should be good enough - but don't know my way around XArray,
so mention this in case it triggers an Aha from you.

While there's certainly a sense in which removing the VM_BUG_ON_PAGE
removes the root cause of the crash, I don't think we understand
what is going on here yet: and therefore I'm reluctant to remove it.

But I have not given this issue much time, busy with other stuff.

> 
> I should have added:
> 
> Reported-by: syzbot+c87be4f669d920c76330@syzkaller.appspotmail.com

That's fair, it did report it, if confusingly.

Hugh

(p.s. in parentheses, to minimize confusion from going slightly
off-topic, but I think I'd be wrong not to mention a separate
issue in this area, with mmotm and linux-next since your folios
went in: doesn't happen easily, but I have twice hit the
include/linux/pagemap.h:258 VM_BUG_ON_PAGE(PageTail(page), page),
in page_cache_add_speculative() - both times when serving
filemap_map_pages(). I have not thought about it at all, but
expect that when you do, you'll simply decide that one is unsafe
and has to be deleted.)
