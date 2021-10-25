Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0D8C43A842
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 01:37:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235126AbhJYXjs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 19:39:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234889AbhJYXjn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 19:39:43 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D544FC061745
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 16:37:20 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id j2so95070lfg.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 16:37:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=G9jEnj3xyHv4ymCBAOlICtoiP3KvPiyAqU8Gic5xaL0=;
        b=h6oyWndBCuvT0dDkXPKAeLffQ50rysGpHNLz6ER8UKsSnXUuy0FS/9DEHHTw6R+sEj
         T57FkLvDjPoMNyRxu3/Hi2TLe0RxtYJ0J1jRmL50PMUD7w3pBaJ/LJwaxWex+SGT/pcR
         V8bBZ7QNvS6SSKsfTZ/2L59xwpCwOsHmBySu4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=G9jEnj3xyHv4ymCBAOlICtoiP3KvPiyAqU8Gic5xaL0=;
        b=59SA1VEkAn3MvV79cTCZNG+QEbdZsw7luJJobvQEiB/3zwtlhtDjS/u6JQcy0GLsdo
         ipTX4LBJY1/TaFvhtPxetFNeeC3BXHgiD3HcWy+THcP+pGWom21hUqrJLUP3BlsGkWH1
         36F64DTiMbeQP5bt9Qi/+76pcxRaRtpffvmdmpK9nZF5RyJ1zj+R1twmM6GkGMQh97Hh
         M5RLGvgaRvySPLnzQHLT/y1t16eoacbEM71awMfS13i8lKy1hneEMgQlme9jamnNY+BP
         0OHnvZfJvf0SJ/YJ3uJfyHNkkmzpB0y7t5IhkiE9eryES5elzHxNYPNFx4XHt0DVRIsq
         8rbQ==
X-Gm-Message-State: AOAM533H9/ifxokDOZDGOyCRcisPrEk9euN3ieYWPSKFHfXLYjJAeKC5
        Ulgm/JYKIhfY6b1vz4wTQMY6M0W/o/KDpYhC
X-Google-Smtp-Source: ABdhPJwekx8IR5PrOJyqTcIyuDFnfdA48lpIy84SltWF7HEl16c+1AZf1uZ02b2jdHSezKK8CIXz6g==
X-Received: by 2002:ac2:46ec:: with SMTP id q12mr19157971lfo.543.1635205038791;
        Mon, 25 Oct 2021 16:37:18 -0700 (PDT)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com. [209.85.208.174])
        by smtp.gmail.com with ESMTPSA id g18sm627899lfr.286.2021.10.25.16.37.18
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Oct 2021 16:37:18 -0700 (PDT)
Received: by mail-lj1-f174.google.com with SMTP id 188so2430257ljj.4
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 16:37:18 -0700 (PDT)
X-Received: by 2002:a2e:a407:: with SMTP id p7mr22948041ljn.68.1635205037628;
 Mon, 25 Oct 2021 16:37:17 -0700 (PDT)
MIME-Version: 1.0
References: <20211025181634.3889666-1-willy@infradead.org> <202110251225.D01841AE67@keescook>
 <YXcKzKVX7NTAtvPh@casper.infradead.org> <202110251402.ADFA4D41BF@keescook>
 <CAHk-=wgvb72urgEM5q_SpXFv1OXnDGY8VFs8QmZPt9_n1bH0CQ@mail.gmail.com> <202110251438.1762406A5@keescook>
In-Reply-To: <202110251438.1762406A5@keescook>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 25 Oct 2021 16:37:01 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj9j8KnWzTTFCXi_xWyytFbtZ71hu32eB=nHR++X+UY=A@mail.gmail.com>
Message-ID: <CAHk-=wj9j8KnWzTTFCXi_xWyytFbtZ71hu32eB=nHR++X+UY=A@mail.gmail.com>
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

On Mon, Oct 25, 2021 at 3:30 PM Kees Cook <keescook@chromium.org> wrote:
>
> > A refcount being zero means that the data it referenced no longer exists.
>
> I don't disagree with this definition, but I would like to understand how
> some other use-cases fit into this.

I certainly hope that there are no other use-cases for 'recount_t',
because that "zero is invalid" is very much part of the semantics.

If we want other semantics, it should be a new type.

>      What about the case of what
> I see that is more like a "shared resource usage count" where the shared
> resource doesn't necessarily disappear when we reach "no users"?

So I think that's really "atomic_t".

And instead of saturating, people should always check such shared
resources for limits.

> i.e. there is some resource, and it starts its life with no one using it
> (count = 1).

You are already going off into the weeds.

That's not a natural thing to do. It's already confusing. Really. Read
that sentence yourself, and read it like an outsider.

"No one is using it, so count == 1" is a nonsensican statement on the
face of it.

You are thinking of a refcount_t trick, not some sane semantics.

Yes, we have played off-by-one games in the kernel before. We've done
it for various subtle reasons.

For example, traditionally, on x86, with atomic counting there are
three special situations: negative, 0 and positive. So if you use the
traditional x86 counting atomics (just add/sub/inc/dec, no xadd) then
there are situations where you can get more information about the
result in %eflags if you don't use zero as the initial value, but -1.

Because then you can do "inc", and if ZF is set, you know you were the
_first_ person to increment it. And when you use "dec", and SF is set
afterwards, you know you are the _last_ person to decrement it.

That was useful when things like "xadd" weren't available, and cmpxchg
loops are expensive. So we used to have counters where -1 was that
"zero point". Very similar to your "1 is the zero point".

But was it _logical_? No. It was an implementation trick. I think
we've removed all those cases because it was so subtle and confusing
(but maybe we still have it somewhere - I did not check).

So we've certainly played those kinds of games. But it had better be
for a really good reason.

> I don't see as clear a distinction between secretmem and the above
> examples.

I really don't see what's wrong with 'atomic_t', and just checking for limits.

Saturating counters are EVIL AND BAD. They are a DoS waiting to
happen. Once you saturate, the machine is basically dead. You may have
"protected" against some attack, but you did so by killing the machine
and making the resource accounting no longer work.

So if a user can ever trigger a saturating counter, that's a big big
problem in itself.

In contrast, an 'atomic_t' with a simple limit? It just works.

And it doesn't need illogical tricks to work.

Stop thinking that refcount_t is a good type. Start realizing the
downsides. Start understanding that saturation is a HORRENDOUSLY BAD
solution, and horrible QoI.

              Linus
