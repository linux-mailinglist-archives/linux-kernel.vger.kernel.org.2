Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71B8843A5B0
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 23:18:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235070AbhJYVUl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 17:20:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233372AbhJYVUk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 17:20:40 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE4F6C061745
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 14:18:17 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id o11so19140949ljg.10
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 14:18:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=C3OGKy4Xs7bfwbjubDC7Rewtx/I9W+4XjVnd2m5nUvo=;
        b=RBroiKM+cF4sG5ufDstwwgyYCJopLMqq5IPCRsdgLR2FoeiFVmpZc5CWYKQNn68vef
         +H6k6FrJz50Naugpja9jVkQQeqLNgp1G6ux8V21fyH7U2J8XyAV03wD8Ku2kugNqDtOf
         CnaE2KjBYmkGcvD75GYgG2ByTVJiCi14Xk+uI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C3OGKy4Xs7bfwbjubDC7Rewtx/I9W+4XjVnd2m5nUvo=;
        b=sD4EvZ/OcvVPERppQbJOtJpgBc6NVSDPk3K3ZI1WIhQmrh0ub1J9VtlZWhZLTexSHP
         kMMuySA3Fl2mYVIx7/fLdD4bmXrWgb1vO1coWXBLTAM7nLNWur00KGPYfqEWLBBolGDF
         VBYax/8UWFc3bLnNIv3D2tePabpU0PLQd/g0KEIFOEsEXvh6egCG/i/Ko1FJBC56nuEg
         rqhtXml0VupD0oYUXlZwQy3AJB6ikQnwBPZVCSCOLDIlW9PK/64pBck65Y9c9wzXQtuC
         9qyco5ADQ3fH6IFIxLBxws195p9qvjijwWrUwpAEFhNK1HE9XqYm/eXzyI5nVxha0jmu
         yOEQ==
X-Gm-Message-State: AOAM532QTAYd8siU2mgFz5KKt1xCY/O6eBqpNJYMBcb9+CTYxKI9r93j
        5E2W4ccG8C1+ZMhzx/QLL4pdF5zK2FO1olef
X-Google-Smtp-Source: ABdhPJwhiyqnIa13TSJJ/IGKKZ2MzpJaFZZ9oENXLM442QDlE/qMH2hmZH69KcIx3M+TqZWAE5AeCw==
X-Received: by 2002:a05:651c:1181:: with SMTP id w1mr21380412ljo.424.1635196695876;
        Mon, 25 Oct 2021 14:18:15 -0700 (PDT)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com. [209.85.208.181])
        by smtp.gmail.com with ESMTPSA id s14sm2032730lfg.230.2021.10.25.14.18.14
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Oct 2021 14:18:14 -0700 (PDT)
Received: by mail-lj1-f181.google.com with SMTP id r6so11636314ljg.6
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 14:18:14 -0700 (PDT)
X-Received: by 2002:a2e:a4b6:: with SMTP id g22mr22073215ljm.191.1635196694559;
 Mon, 25 Oct 2021 14:18:14 -0700 (PDT)
MIME-Version: 1.0
References: <20211025181634.3889666-1-willy@infradead.org> <202110251225.D01841AE67@keescook>
 <YXcKzKVX7NTAtvPh@casper.infradead.org> <202110251402.ADFA4D41BF@keescook>
In-Reply-To: <202110251402.ADFA4D41BF@keescook>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 25 Oct 2021 14:17:58 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgvb72urgEM5q_SpXFv1OXnDGY8VFs8QmZPt9_n1bH0CQ@mail.gmail.com>
Message-ID: <CAHk-=wgvb72urgEM5q_SpXFv1OXnDGY8VFs8QmZPt9_n1bH0CQ@mail.gmail.com>
Subject: Re: [PATCH] secretmem: Prevent secretmem_users from wrapping to zero
To:     Kees Cook <keescook@chromium.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Jordy Zomer <jordy@pwning.systems>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 25, 2021 at 2:04 PM Kees Cook <keescook@chromium.org> wrote:
>
> Is secretmem different? We're trying to count how many of these we have,
> this is a common pattern in, for example, the network code which does
> this kind of thing a lot.

Yes, secretmem is different.

A refcount being zero means that the data it referenced no longer exists.

That's not what the secretmem counter meant at all.

Making it a refcount was simply WRONG. It's not a refcount, it's a
usage count, and the fact that syzbot caught the warning just shows
how wrong it was.

Stop arguing for garbage. It was wrong, just admit it. The semantics
for "refcount" is something else than what that code had. As a result,
it got reverted. I've applied Willy's patch that actually makes sense.

Arguing for garbage in the name of "security" is still garbage. In
fact, it only causes confusion, and as such is likely to result in
problems - including security problems - later.

Because confusion about semantics is bad. And that was what that patch was.

And I want to state - again - how dangerous this "refcounts are always
prefereable to atomics" mental model is. Refcounts are _not_
fundamentally preferable to atomics. They are slower, bigger, and have
completely different semantics.

So if something isn't a refcount, it damn well shouldn't use "refcount_t".

             Linus
