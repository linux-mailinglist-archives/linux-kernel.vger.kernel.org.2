Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 883C04457FE
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Nov 2021 18:09:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231253AbhKDRLl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 13:11:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231186AbhKDRLk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 13:11:40 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FA19C061714
        for <linux-kernel@vger.kernel.org>; Thu,  4 Nov 2021 10:09:02 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id u11so13388407lfs.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Nov 2021 10:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eIdAKVGvDiz7S21vfsZfNX/HjQfNdvj7KzU/69Bh2jM=;
        b=YJJUFo/pYbi0ApIjofC6647X/sUNI5FRCh6UJbMkjE5h8XXM1AhQjQYKLgYPRgN4Lc
         MPT75ZOlo0V8rhSGLZ9F6uoYgRTcZci9kRJdTy9PE2rFwjIu1RtHkx4a3cO71A3mwEkd
         PFsGITNC4DKMJNL7hteWPDG+xShQw0MmY/LgY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eIdAKVGvDiz7S21vfsZfNX/HjQfNdvj7KzU/69Bh2jM=;
        b=viU1ty7cgpYM26zsDb3oc7NbAxWgDi0daVM86XqLxWAhZpEqGQEA6xjB2zaUNOojB2
         kvbstu15z161KPyTMb/DxlUWu65zx4I0Zv//sRx+oGd0AiaMSy8f5gBTD1V/tHh7xnb+
         SMTLm3WLK8eay+GmO/4QMYwiKSWydwCzBwWeQxNnLyrSRuTrKVWO1ONCaYJ3AI7KO4P7
         IKVwvgJ/mHANvYO9oc4EqhBACez83peRD6wDLZdnfeHspFSrPCVlrJ2sqsCG+H9jW7Pp
         SuDcoGnHCvPUGTaNBcqXbrfBy2CGHCasjMSyVPMNo/HpOzFxREGvMFj31xGAk6G83dog
         oYrg==
X-Gm-Message-State: AOAM531ruOEikt1op75c9MxuSUvVAoOMu/YuDX7OFZ4uq74jvFxuAIKQ
        srE92GWb4YghR9NNYUVyNrfqH8n4WWwr9CDN
X-Google-Smtp-Source: ABdhPJyXpeZy4sN3ooXmAFdXMlZtFbV8k6LNjC79fovNN9uUKojQr4HruwVp23IlOwiGeMKB25AaUQ==
X-Received: by 2002:a05:6512:74b:: with SMTP id c11mr34815425lfs.615.1636045740000;
        Thu, 04 Nov 2021 10:09:00 -0700 (PDT)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com. [209.85.208.178])
        by smtp.gmail.com with ESMTPSA id q16sm140570lfu.40.2021.11.04.10.08.56
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Nov 2021 10:08:57 -0700 (PDT)
Received: by mail-lj1-f178.google.com with SMTP id r10so9467774ljj.11
        for <linux-kernel@vger.kernel.org>; Thu, 04 Nov 2021 10:08:56 -0700 (PDT)
X-Received: by 2002:a2e:a7d3:: with SMTP id x19mr27547940ljp.68.1636045736293;
 Thu, 04 Nov 2021 10:08:56 -0700 (PDT)
MIME-Version: 1.0
References: <YYP1lAq46NWzhOf0@casper.infradead.org> <CAHk-=wiKac4t-fOP_3fAf7nETfFLhT3ShmRmBq2J96y6jAr56Q@mail.gmail.com>
 <YYQQPuhVUHqfldDg@arm.com>
In-Reply-To: <YYQQPuhVUHqfldDg@arm.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 4 Nov 2021 10:08:40 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiDjjL50BBU=i8BFz3Rv5+-pGysEyCD+mcc_K_g0140oQ@mail.gmail.com>
Message-ID: <CAHk-=wiDjjL50BBU=i8BFz3Rv5+-pGysEyCD+mcc_K_g0140oQ@mail.gmail.com>
Subject: Re: flush_dcache_page vs kunmap_local
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@lst.de>,
        linux-arch <linux-arch@vger.kernel.org>,
        Ira Weiny <ira.weiny@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 4, 2021 at 9:54 AM Catalin Marinas <catalin.marinas@arm.com> wrote:
>
> We do. flush_dcache_page() is not just about virtual caches. On arm32/64
> (and powerpc), even with PIPT-like caches, we use it to flag a page's
> D-cache as no longer clean. Subsequently in set_pte_at(), if the mapping
> is executable, we do the cache maintenance to ensure the I and D caches
> are coherent with each other.

Ugh,. ok, so we have two very different use-cases for that function.

Perhaps more importantly, they have hugely different semantics. For
you, it's about pages that can be mapped executable, so it's only
relevant for mappable pages.

For the traditional broken pure virtual cache case, it's not about
user mappings at all, it's about any data structure that we might have
in highmem.

Of course, I think we got rid of most of the other uses of highmem,
and we no longer put any "normal" kernel data in highmem pages. There
used to be patches that did inodes and things like that in highmem,
and they actually depended on the "cache the virtual address so that
it's always the same" behavior.

> I wouldn't add this call to kmap/kunmap_local(), it would be a slight
> unnecessary overhead (we had a customer complaining about kmap_atomic()
> breaking write-streaming, I think the new kmap_local() solved this
> problem, if in the right context).

kmap_local() ends up being (I think) fundamentally broken for virtual
cache coherency anyway, because two different CPU's can see two
different virtual addresses at the same time for the same page (in
ways that the old kmap interfaces could not).

So maybe the answer is "let's forget about the old virtual cache
coherence issue, and make it purely about the I$ mapping case".

At that point, kmap is irrelevant from a virtual address standpoint
and so it doesn't make much sense to fliush on kunmap - but anybody
who writes to a page still needs that flush_dcache_page() thing.

                 Linus
