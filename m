Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B142C3590A8
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 01:50:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232735AbhDHXvK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 19:51:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232426AbhDHXvJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 19:51:09 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3043C061760
        for <linux-kernel@vger.kernel.org>; Thu,  8 Apr 2021 16:50:56 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 12so6721962lfq.13
        for <linux-kernel@vger.kernel.org>; Thu, 08 Apr 2021 16:50:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XLF2Hy47tG/NhXLeWFJjwjLlXpGjFs6Bt2Vh546exGI=;
        b=U1nu8PCKZ2rC+hNkH/1FtHr0pHi1eBFqU8nKatafLTnVUf8YWjf3+Y9lxaTCmPnC6N
         1maOTah5U5Ugwluf4SbyJDC0T/VIm4gmhPdxCSV5suWLxAoQA6cU1UWIC534ya5fYLAp
         8IzK2dToo8y36YbKoGVCbAg0EPiSom+ZJL01Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XLF2Hy47tG/NhXLeWFJjwjLlXpGjFs6Bt2Vh546exGI=;
        b=dRdYXZcnxhVwCBWSCJS8tIlg4go+P9az0FRYluJtRY+wm98d4FM/ErEErvukYjwjrE
         pmOksWXiusB8d7dHPgnMcUvDtBfYTv7CLh/b/xDyCI4mPP8i98w481L8z5qipPmWF1hs
         YmBNC2GlKojXjzVuUMJ1IvJBmb8ZwWZi96hIlA+UnFpC4JWHIoGBwMIteH4YMKVloVSR
         y9w59Lblp98YhHgSpxqnCg3euA3xzqD9Fnup4jQ+hyeP2PkWPo1mbGLtvw6UGWaZn5uk
         egv5D4Yla6B3iv/Du3oa+4ziTaqALURaQp9EyI3tOSTyxuEhoS3gqsY7pudb8owCpBVT
         rJ3Q==
X-Gm-Message-State: AOAM532EpL5m7CHzH+SGcXOSLlMAdm1KRrOwtzPMFl/M2+fmK1bB7R99
        ier9X68UEd8XlTTELtSkXDIbfhTnH/vAMg==
X-Google-Smtp-Source: ABdhPJzuEJYplaGO8q5KMNtc/ZmTx6O74TvzkVnKSQw2IDksPPrYcX54gWGw/b8ZJbKdJo3KYzmJLw==
X-Received: by 2002:ac2:5a5b:: with SMTP id r27mr8246270lfn.255.1617925855276;
        Thu, 08 Apr 2021 16:50:55 -0700 (PDT)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com. [209.85.167.52])
        by smtp.gmail.com with ESMTPSA id l5sm78017lja.87.2021.04.08.16.50.54
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Apr 2021 16:50:54 -0700 (PDT)
Received: by mail-lf1-f52.google.com with SMTP id d13so6819326lfg.7
        for <linux-kernel@vger.kernel.org>; Thu, 08 Apr 2021 16:50:54 -0700 (PDT)
X-Received: by 2002:ac2:5974:: with SMTP id h20mr5012619lfp.40.1617925853980;
 Thu, 08 Apr 2021 16:50:53 -0700 (PDT)
MIME-Version: 1.0
References: <20210408145057.GN2531743@casper.infradead.org>
 <161789062190.6155.12711584466338493050.stgit@warthog.procyon.org.uk>
 <161789066013.6155.9816857201817288382.stgit@warthog.procyon.org.uk>
 <46017.1617897451@warthog.procyon.org.uk> <136646.1617916529@warthog.procyon.org.uk>
In-Reply-To: <136646.1617916529@warthog.procyon.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 8 Apr 2021 16:50:38 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi_XrtTanTwoKs0jwnjhSvwpMYVDJ477VtjvvTXRjm5wQ@mail.gmail.com>
Message-ID: <CAHk-=wi_XrtTanTwoKs0jwnjhSvwpMYVDJ477VtjvvTXRjm5wQ@mail.gmail.com>
Subject: Re: [RFC][PATCH] mm: Split page_has_private() in two to better handle PG_private_2
To:     David Howells <dhowells@redhat.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Jeff Layton <jlayton@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@lst.de>,
        Josef Bacik <josef@toxicpanda.com>,
        Linux-MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-cachefs@redhat.com, linux-afs@lists.infradead.org,
        "open list:NFS, SUNRPC, AND..." <linux-nfs@vger.kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>, ceph-devel@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 8, 2021 at 2:15 PM David Howells <dhowells@redhat.com> wrote:
>
> mm: Split page_has_private() in two to better handle PG_private_2

From a look through the patch and some (limited) thinking about it, I
like the patch. I think it clarifies the two very different cases, and
makes it clear that one is about that page cleanup, and the other is
about the magical reference counting. The two are separate issues,
even if for PG_private both happen to be true.

So this seems sane to me.

That said, I had a couple of reactions:

> diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
> index 04a34c08e0a6..04cb440ce06e 100644
> --- a/include/linux/page-flags.h
> +++ b/include/linux/page-flags.h
> @@ -832,14 +832,27 @@ static inline void ClearPageSlabPfmemalloc(struct page *page)
>
>  #define PAGE_FLAGS_PRIVATE                             \
>         (1UL << PG_private | 1UL << PG_private_2)

I think this should be re-named to be PAGE_FLAGS_CLEANUP, because I
don't think it makes any other sense to "combine" the two PG_private*
bits any more. No?

> +static inline int page_private_count(struct page *page)
> +{
> +       return test_bit(PG_private, &page->flags) ? 1 : 0;
> +}

Why is this open-coding the bit test, rather than just doing

        return PagePrivate(page) ? 1 : 0;

instead? In fact, since test_bit() _should_ return a 'bool', I think even just

        return PagePrivate(page);

should work and give the same result, but I could imagine that some
architecture version of "test_bit()" might return some other non-zero
value (although honestly, I think that should be fixed if so).

                Linus
