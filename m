Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BAA43FBEA7
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 00:00:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238708AbhH3WBU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 18:01:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229887AbhH3WBT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 18:01:19 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D92EC061575
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 15:00:25 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id c8so21654082lfi.3
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 15:00:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uYlBlJUZCU/7kMrFTGU96lZyM3/kDNjer1E+JP/0kd4=;
        b=hJmaJhUl1LGA1vy8JW9tWtkF+cIUn1PrNk+Bt2bsBTV74zp4szgl/7uE14qGqbg72e
         qlyQUFbqoGY1fLFP6cp39nwHFD8NvnOdK1KMlgy8gDOsteMvlcECq7OjMVqPbUJ1Odtj
         U/42IQxgtpPMOj/iyEeXe398IDtZS4aeFOu8I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uYlBlJUZCU/7kMrFTGU96lZyM3/kDNjer1E+JP/0kd4=;
        b=hexU7Z6nguslcp6bdEMn3IcIMdiq36ekHe4QOLGOOaejwJXjpgmco8A4cmheIWPjMd
         svL5VY4KNSIRb6JJYqhzz9LUpBB7Yaqux0XGNL1osv2ggT6wTJNBxCIiOUs9wEvyp0v+
         wqGEoz10V2ujZCYZV96Ot68SZ/naDTClv1Xu6ZROC5Aw6N4Je0c9T6LoL96VlJgyprtu
         nSUcLvRhA5Kd/NZsb7vWzXsAFxKr+maOq8sxb0PkzcsSZ5fXKCxqH0vjz78PRfrwfHKM
         /gwUxjWeCRlN6Vp0uUr9ErioHLBB29kza/Tv472PaORw9pBmrKEZlgVPrrXOsgwcRJF4
         n1Yw==
X-Gm-Message-State: AOAM531fR+i6mgZcYs7X2Cr7I/NaS/op/tgUd4aGDxhaFzVbnkk9steK
        dd+wI++qh1sq1C9fboouFeE20bFAVpfHQhnak/U=
X-Google-Smtp-Source: ABdhPJyuWCPlUbzKBul3FNaB8xnSftwX9jF8RIzGAKxcH9GBPqSIQv5vpcxtd8YTeScLdUsPm/K9Ng==
X-Received: by 2002:a19:6d18:: with SMTP id i24mr18374002lfc.451.1630360823589;
        Mon, 30 Aug 2021 15:00:23 -0700 (PDT)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id i12sm1983692ljm.116.2021.08.30.15.00.22
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Aug 2021 15:00:22 -0700 (PDT)
Received: by mail-lf1-f43.google.com with SMTP id m18so20052705lfl.10
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 15:00:22 -0700 (PDT)
X-Received: by 2002:a05:6512:228f:: with SMTP id f15mr6503289lfu.253.1630360822453;
 Mon, 30 Aug 2021 15:00:22 -0700 (PDT)
MIME-Version: 1.0
References: <20210830154702.247681585@linutronix.de> <20210830162545.374070793@linutronix.de>
 <YS0ylo9nTHD9NiAp@zn.tnic> <87zgsyg0eg.ffs@tglx> <YS1HXyQu2mvMzbL/@zeniv-ca.linux.org.uk>
 <CAHk-=wgbeNyFV3pKh+hvh-ZON3UqQfkCWnfLYAXXA9cX2iqsyg@mail.gmail.com> <YS1OE6FRi4ZwEF8j@zeniv-ca.linux.org.uk>
In-Reply-To: <YS1OE6FRi4ZwEF8j@zeniv-ca.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 30 Aug 2021 15:00:06 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh57tMaJxcH=kWE4xdKLjayKSDEVvMwHG4fKZ5tUHF6mg@mail.gmail.com>
Message-ID: <CAHk-=wh57tMaJxcH=kWE4xdKLjayKSDEVvMwHG4fKZ5tUHF6mg@mail.gmail.com>
Subject: Re: [patch 01/10] x86/fpu/signal: Clarify exception handling in restore_fpregs_from_user()
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        LKML <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 30, 2021 at 2:33 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> There's a place where we care about #PF vs. #MC (see upthread)...

Interestingly (or perhaps not), that case is a problem case in general
for "fault_in_pages_readable()".

That function will only access data every PAGE_SIZE bytes, but if we
have other exceptions that can happen at a cacheline granularity, the
whole "retry after faulting pages in" may fail.

So that kind of

 - try to copy from user space

 - if that fails, do fault_in_pages_readable() and retry

loop can loop forever.

restore_fpregs_from_user() is odd and special in trying to deal with
it by looking at the error code. I'm n ot convinced it's the right
thing to do, since it just means that all the other places we do this
can be problematic.

But since the Intel machine check stuff is so misdesigned and doesn't
work on any normal machines, most people can't test any of this, none
of this matters, and it's only broken on those "serious enterprise
machines" setups that people think are better, but are actually just
almost entirely untested and thus don't work right.

I'm not sure what the right model here is. We might need to make
fault_in_pages_readable() do things a cacheline at a time, at which
point those repeat loops start working, and the error code thing
becomes pointless.

What I _am_ sure about is that the error code model doesn't work. It
may work in that one special case, but that just means that all the
non-special cases are broken.

So I'll argue that it's a fundamentally broken model, and that
_ASM_EXTABLE_FAULT thing is not just confusing, but actively hurtful.

            Linus
