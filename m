Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78F17419EDA
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 21:05:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236011AbhI0TG7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 15:06:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235880AbhI0TG4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 15:06:56 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55DA2C061575
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 12:05:18 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id b20so82145560lfv.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 12:05:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=njYGm4bP8jNmCvAFiZ06l8r+GHPtzvHRo47ySu3ATw4=;
        b=WpoF5VpG9djMUN3T0RVGAnKMGpUra/IoZu0YoYu2B7CPTwwNjgNcKC8FXNWXh0DJZH
         acFfw8Hzzhmqsm38B6oYPJzRykCp1dhW8V1tHhoR5FzMH5Sq3dPFJWChUqzPzWjhbDN5
         bWCPIHRDbbzEqw0lQhknGBKzayIfJ3+riydfU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=njYGm4bP8jNmCvAFiZ06l8r+GHPtzvHRo47ySu3ATw4=;
        b=2X7gH/WJZwiZONKJwcEoitMFZRJjtNLLVC/jfDSY6ZD5z1qMDXborR/Ss/6151zggt
         1Zhn+MUXNwm8MjuKUzKD08f/zZmozmtT9F81nTmIn56Egk3BUCYzWsKt+3caJKMYGrFO
         o6Gq+a8sGOtDbEk/Lp+47Nz/FILYKsYee/oHWJFB5/tKHXPTwRCMEKfy6LojvtofSMEk
         evTbvh65xrKVg3AO4Vb48vaCOHhsUnd4SSJqCI4P2qRhfcJoDq1axUTqa2s9Bn/INffq
         mFHJQ99ZWdvG8yN1aNYf7Im1mX7da4oHHbuJZ1BgO/HpU4Bo9uph1DXp7QMbdPmMGS1b
         mXKg==
X-Gm-Message-State: AOAM530Sli/YdV1Wlm7rKkZHDgLN1aOvMi1bgR10NYjyKqIpa9U0TurW
        sTFrotUriJsrW2iQ06xqRfBReWSSUVDUVW75xB4=
X-Google-Smtp-Source: ABdhPJy2nS3QQy6FcRAVyW35qN5AinsDclR/eUhUI3kRCSUheK8Qd9Q/AWNGBL91tljfc4kIWha64w==
X-Received: by 2002:a05:651c:120f:: with SMTP id i15mr1420587lja.59.1632769516226;
        Mon, 27 Sep 2021 12:05:16 -0700 (PDT)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com. [209.85.167.44])
        by smtp.gmail.com with ESMTPSA id t17sm1671684lft.296.2021.09.27.12.05.13
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Sep 2021 12:05:14 -0700 (PDT)
Received: by mail-lf1-f44.google.com with SMTP id e15so82015006lfr.10
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 12:05:13 -0700 (PDT)
X-Received: by 2002:a05:651c:1250:: with SMTP id h16mr1576330ljh.68.1632769513513;
 Mon, 27 Sep 2021 12:05:13 -0700 (PDT)
MIME-Version: 1.0
References: <YUvWm6G16+ib+Wnb@moria.home.lan> <bc22b4d0-ba63-4559-88d9-a510da233cad@suse.cz>
 <YVIH5j5xkPafvNds@casper.infradead.org> <YVII7eM7P42riwoI@moria.home.lan>
 <YVIJg+kNqqbrBZFW@casper.infradead.org> <b57911a4-3963-aa65-1f8e-46578b3c0623@redhat.com>
 <df6ad8ab-b3a9-6264-e699-28422a74f995@suse.cz>
In-Reply-To: <df6ad8ab-b3a9-6264-e699-28422a74f995@suse.cz>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 27 Sep 2021 12:04:57 -0700
X-Gmail-Original-Message-ID: <CAHk-=whQE3eZdFgtoeRmXVsO93c-nSbdheTvtUJcztJaE_KKEw@mail.gmail.com>
Message-ID: <CAHk-=whQE3eZdFgtoeRmXVsO93c-nSbdheTvtUJcztJaE_KKEw@mail.gmail.com>
Subject: Re: Struct page proposal
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        David Howells <dhowells@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 27, 2021 at 11:53 AM Vlastimil Babka <vbabka@suse.cz> wrote:
>
> I was thinking of debug_pagealloc (unmaps free pages from direct map) but yeah,
> the list is longer.

In fact, the _original_ free page list was in the page itself, not in
'struct page'.

The original reason to move it into 'struct page' ended up being
performance, iirc.

Because of how now the free page list was always in the same cache
line set, the page allocator caused horrendous cache patterns on
direct-mapped caches.

Direct-mapped caches may thankfully be gone, and we have a lot of
other things that end up having that property of "same offset within a
page" just because of allocation patterns (task struct allocations
being but one example), but it might still be something to try to
avoid.

               Linus
