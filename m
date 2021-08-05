Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 261203E174B
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 16:48:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233257AbhHEOsO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 10:48:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240169AbhHEOsN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 10:48:13 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C828C0613D5
        for <linux-kernel@vger.kernel.org>; Thu,  5 Aug 2021 07:47:59 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id z18so9391926ybg.8
        for <linux-kernel@vger.kernel.org>; Thu, 05 Aug 2021 07:47:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aNRFA0xHYvsj+J9YdjrFskUG7plA6e+netmc1ghlmYc=;
        b=JPlSLTf0EXj5HpMsmiwxiOBcDdEGb6xSGYjqOs+Cr/F1tlEP6Cvo0/MnH0NcTxCsJY
         KijF+/0d4w6/cTarap/o17LrDCMX+2k0OMEKBkgg6TfzZ+cMYW2Y7p8766A6asPQm/IB
         3wO2St0rTIkwm8UQiZLMuDIJxxZlP/xAjnStOsBnjIU2Q8N0trBHu5XRYC60Dv/QNUBg
         lGeQM2yPF2+7wZXJM+oiKiZWwn70Ur8mSFockBE2CwIsCEPp+iQfwyayZeRit9b8/a+x
         wXw5BBZ1inO0v7oObJyI8C1TU+8D+ByQd2Wf/sn4a1tlqnGkBn9V0JnOW4QVlIjCf2+G
         1Qng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aNRFA0xHYvsj+J9YdjrFskUG7plA6e+netmc1ghlmYc=;
        b=jISALtCi/PtQ+8D9MBVKzCnabVHQMHVKSpsJVBvA7dmExAdzl7AEdf14mQPjIkmEDv
         UIxnWNftAI5fAa7Uj02yHx4k+XpLl+IqYgumPSIl+DJ5miZdocJSZY8X9fSkAGwBUJum
         DhdQHMJLcVWHOPX/TaXxgqV72nCgJLKLDz41cTS/gyluHS9n0i1cz91xUBl3aybc03pX
         FuEh13kDEgHfHNrskf4Q5FGD3RAwyYKBqviPx8/9wzI5Mru/0dhIVmxoZAYxE8gYXiJ1
         J9u/DTOxmzb6ToVV7DEDgE4v4uWvF52xlOEV/QdkJ0rGo6w98VrzHmi9jeEZEDZ8ilUw
         Q8Gg==
X-Gm-Message-State: AOAM532U9sx/M2tfqyAJsnhbUQvi8lDm4KSgbGjUOskyuBF9VO8PwHuY
        zxDG6eAJ4S2dBSI2xi4Lil0nvy8NYONp7X4P2pK0SA==
X-Google-Smtp-Source: ABdhPJw1cjIBTuWImtIDhw4+p7ut3PyQKtwmSxub/L/bBLh3Kbcmdw+YqXAbOBm2bArVwnHOKsjljDOAI0Kg7v8uw/s=
X-Received: by 2002:a25:fc5:: with SMTP id 188mr6354267ybp.51.1628174878801;
 Thu, 05 Aug 2021 07:47:58 -0700 (PDT)
MIME-Version: 1.0
References: <1628125617-49538-1-git-send-email-linyunsheng@huawei.com>
 <YQtDynWsDxZ/T41e@casper.infradead.org> <19955a79-3a6a-9534-7665-7f868eb7db1f@huawei.com>
 <YQunSivvZZFRETYn@enceladus> <bfdfd736-68b2-635b-0c59-017574620f8c@huawei.com>
In-Reply-To: <bfdfd736-68b2-635b-0c59-017574620f8c@huawei.com>
From:   Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date:   Thu, 5 Aug 2021 17:47:22 +0300
Message-ID: <CAC_iWjJex2Ceo8J8z_kSXHSg0QCfPRW09wrhEbKbYRZ2iJBxhQ@mail.gmail.com>
Subject: Re: [PATCH net] page_pool: mask the page->signature before the checking
To:     Yunsheng Lin <linyunsheng@huawei.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Matteo Croce <mcroce@microsoft.com>,
        Alexander Duyck <alexander.duyck@gmail.com>,
        Networking <netdev@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        linuxarm@openeuler.org, chenhao288@hisilicon.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Right, mind sending a v2 with a comment explaining why we need to mask?

Other than that

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

On Thu, 5 Aug 2021 at 12:31, Yunsheng Lin <linyunsheng@huawei.com> wrote:
>
> On 2021/8/5 16:54, Ilias Apalodimas wrote:
> > On Thu, Aug 05, 2021 at 10:14:39AM +0800, Yunsheng Lin wrote:
> >> On 2021/8/5 9:50, Matthew Wilcox wrote:
> >>> On Thu, Aug 05, 2021 at 09:06:57AM +0800, Yunsheng Lin wrote:
> >>>> As mentioned in commit c07aea3ef4d4 ("mm: add a signature
> >>>> in struct page"):
> >>>> "The page->signature field is aliased to page->lru.next and
> >>>> page->compound_head."
> >>>>
> >>>> And as the comment in page_is_pfmemalloc():
> >>>> "lru.next has bit 1 set if the page is allocated from the
> >>>> pfmemalloc reserves. Callers may simply overwrite it if they
> >>>> do not need to preserve that information."
> >>>>
> >>>> The page->signature is or???ed with PP_SIGNATURE when a page is
> >>>> allocated in page pool, see __page_pool_alloc_pages_slow(),
> >>>> and page->signature is checked directly with PP_SIGNATURE in
> >>>> page_pool_return_skb_page(), which might cause resoure leaking
> >>>> problem for a page from page pool if bit 1 of lru.next is set for
> >>>> a pfmemalloc page.
> >>>>
> >>>> As bit 0 is page->compound_head, So mask both bit 0 and 1 before
> >>>> the checking in page_pool_return_skb_page().
> >>>
> >>> No, you don't understand.  We *want* the check to fail if we were low
> >>> on memory so we return the emergency allocation.
> >>
> >> If the check failed, but the page pool assume the page is not from page
> >> pool and will not do the resource cleaning(like dma unmapping), as the
> >> page pool still use the page with pfmemalloc set and dma map the page
> >> if pp_flags & PP_FLAG_DMA_MAP is true in __page_pool_alloc_pages_slow().
> >>
> >> The returning the emergency allocation you mentioned seems to be handled
> >> in __page_pool_put_page(), see:
> >>
> >> https://elixir.bootlin.com/linux/latest/source/net/core/page_pool.c#L411
> >>
> >> We just use the page with pfmemalloc one time and do the resource cleaning
> >> before returning the page back to page allocator. Or did I miss something
> >> here?
> >>
> >>> .
> >>>
> >
> > I think you are right here.  What happens is that the original
> > pp->signature is OR'ed after the allocation in order to preserve any
> > existing bits.  When those are present though the if which will trigger the
> > recycling will fail and those DMA mapping will be left stale.
> >
> > If we mask the bits during the check (as your patch does), we'll end up not
> > recycling the page anyway since it has the pfmemalloc bit set. The page
> > pool recycle function will end up releasing the page and the DMA mappings right?
>
> Yes.
> The problem might be magnified when frag page in page pool is added, because
> page pool only hold one ref of the page, and page_pool_return_skb_page() might
> dec the page ref twice if the frag page has two users, supposing the above
> checking fail with the pfmemalloc page, leaving to the below log:
>
> [   49.584990] BUG: Bad page state in process iperf  pfn:20af242
> [   49.584992] page:(____ptrval____) refcount:-1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x20af242
>
> >
> > Regards
> > /Ilias
> > .
> >
