Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B959344565E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Nov 2021 16:31:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231489AbhKDPd4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 11:33:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230102AbhKDPdz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 11:33:55 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C13FC061714
        for <linux-kernel@vger.kernel.org>; Thu,  4 Nov 2021 08:31:15 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id p16so12798227lfa.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Nov 2021 08:31:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/QAo7m/CHBig/gC/gJf3MNUDBsTpRnbUruOTSeeBqwY=;
        b=DaYc6Oru//OTng13euyJtXLjP+RvfN1sUp8v8a7RPiP8x+esGv2tIX5Jo2TqzJmu5o
         P2cHfPwbTfu4VwimsMLpflnkeXymZj/6cAq0WvglsWDx90FAFzo8kBZm1TFzgPn4GsZ3
         fkKTnJt7NIae0wBqwyykR8nNBuLUqTFHb9KrI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/QAo7m/CHBig/gC/gJf3MNUDBsTpRnbUruOTSeeBqwY=;
        b=Ye0dYqJYvVyg5hKtsxI0IRfiFv92fwnIdMx5Q7699cNIz/pEHZDZkEueQFwqP+CdMr
         GWMAkx9L0htyxhEsQsVvkkSSUwaG2tsg/zH73whELQXEnMgRSwJYdlOjRURSlFrnpfRu
         w9YQysfyNoyXYy7CghN5MjxA5L5z97pgY44glXIcs9Fb4onLsHr4a7z/Y8yYklT1ybiS
         LIEKy7GoXGHuDMd7UU4jCd8adD0ctzq8K/ro3XjvgQw+Xowi/JY90f9WB0JOY9s/kKvN
         N2/zTwdmpG8h87j008bve4fpZgR3MayA3F22IucParWiBLnYaOaKQOaRMR12YRGRBZ2a
         c1Gg==
X-Gm-Message-State: AOAM533hQnbQiH5Df3i7qaQocKvKRcfUnSwCOlUTTvjBGbkFf3Je79GB
        g6Vur3LwxSe5fzFtuRyeyIykH+q6trzoY39N
X-Google-Smtp-Source: ABdhPJw+hhhZr11zlpbbX9feAwCDWnYvkrUa+YUsAOg/McDyooIMl5e5UaGlRAZN7gTeywV4ku3IwA==
X-Received: by 2002:ac2:4254:: with SMTP id m20mr42377302lfl.338.1636039873481;
        Thu, 04 Nov 2021 08:31:13 -0700 (PDT)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com. [209.85.208.173])
        by smtp.gmail.com with ESMTPSA id j12sm299554lfe.224.2021.11.04.08.31.11
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Nov 2021 08:31:11 -0700 (PDT)
Received: by mail-lj1-f173.google.com with SMTP id y8so10202117ljm.4
        for <linux-kernel@vger.kernel.org>; Thu, 04 Nov 2021 08:31:11 -0700 (PDT)
X-Received: by 2002:a05:651c:113:: with SMTP id a19mr9236128ljb.249.1636039871361;
 Thu, 04 Nov 2021 08:31:11 -0700 (PDT)
MIME-Version: 1.0
References: <YYP1lAq46NWzhOf0@casper.infradead.org>
In-Reply-To: <YYP1lAq46NWzhOf0@casper.infradead.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 4 Nov 2021 08:30:55 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiKac4t-fOP_3fAf7nETfFLhT3ShmRmBq2J96y6jAr56Q@mail.gmail.com>
Message-ID: <CAHk-=wiKac4t-fOP_3fAf7nETfFLhT3ShmRmBq2J96y6jAr56Q@mail.gmail.com>
Subject: Re: flush_dcache_page vs kunmap_local
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        linux-arch <linux-arch@vger.kernel.org>,
        Ira Weiny <ira.weiny@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 4, 2021 at 8:03 AM Matthew Wilcox <willy@infradead.org> wrote:
>
> Linus offers the opinion that kunmap calls should imply a
> flush_dcache_page().  Christoph added calls to flush_dcache_page()
> in commit 8dad53a11f8d.  Was this "voodoo programming", or was there
> a real problem being addressed?

I don't think anybody actually uses/cares about flush_dcache_page() at
all, and pretty much all uses are random and voodoo.

No sane architecture uses pure virtual caches, and the insane ones
haven't been an issue for a long time either.

But if there are still systems with pure virtual caches, and they need
manual cache flushing, then I do think that kunmap is one of the
points that needs it, since that's the "I'm done accessing this data
through this virtual address" place.

End result: I really don't think anybody cares any more (and only
truly broken architectures ever did). I'd personally be perfectly
happy just saying "we might as well drop support for non-coherent
caches entirely".

But as long as we have those random odd "flush dcache manually"
things, I think kunmap() is one of the places that probably should
continue to do them.

Of course, the kunmap case is _doubly_ irrelevant, because we should
certainly hope that not only are those noncoherent pure virtual caches
a thing of the past, highmem itself should be going away.

Why did this come up? Do you actually have some hardware or situation
that cares?

                   Linus
