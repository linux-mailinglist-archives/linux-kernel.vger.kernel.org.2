Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A67F83A5101
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jun 2021 23:34:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231311AbhFLVgD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Jun 2021 17:36:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbhFLVgC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jun 2021 17:36:02 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23C60C061574
        for <linux-kernel@vger.kernel.org>; Sat, 12 Jun 2021 14:33:52 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id d2so14429253ljj.11
        for <linux-kernel@vger.kernel.org>; Sat, 12 Jun 2021 14:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cttjN6hHK8ZfFZCCvG0xFSEaYGvtzoV+qTXYo7qsc7k=;
        b=JYQfkbvfKl/sPzEiSMj0gpLCOnO9JgnJ/vuXvIfL60Bi/8rJK41ki8J2OlrUoFw5jM
         3iQeF8y0m9PcG96gg7waRWPDDLFEgfHiT/KF360yZZCnWH7kVrla8Jvfg+2mc/S3CGq7
         4MMnJ4VaRZUc80knmVKyV7v0TzALS1vNeePxw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cttjN6hHK8ZfFZCCvG0xFSEaYGvtzoV+qTXYo7qsc7k=;
        b=STCUdotTFdyhX19ZKu3U7M3Cs2g1MfHXek3AcoRePDB3eivpStekXiYnVJaEUei0vB
         luJSZaKcCSUriArlWQxAZRd6NKZ40qSJtQYMjU/80bzLtkC3IjJO8Vau5iYQgO7AOuh5
         Gu1oHRjqTpGoOgb4AKCtAf/J2Vw09YP+Rwy9xKLLgeW1QD/yJnp8hdnnX7r4nWc2d1UU
         RGckGPyn9rlKS0UXYjOoz91UkJUsM5gc0iNrfn0wzkZXHz6z1Gt2hTqQH1lrxxra2IdT
         plB8j21YSSKhvWZxa/N2SAznfitwRVm5YKMgnbUtqTRzohe8A7pMpopeMUf01cGA1Z4E
         S5Dg==
X-Gm-Message-State: AOAM532PY07VMgKdHb5ty+Pq2BI/M07ylGeOv0mMUflGM4Wm1tdP1OCB
        eO9KWrIrJVpUEHwKhUKXCRSGcIr38ZeqpDh+QVY=
X-Google-Smtp-Source: ABdhPJwQUu/vhwvtZuBDquD3N9LAZ+Dfu95/h7MdKov8ZSyeXOU6qPfej8VMJAgufOwPNBTj/02taQ==
X-Received: by 2002:a05:651c:1057:: with SMTP id x23mr7718062ljm.467.1623533628899;
        Sat, 12 Jun 2021 14:33:48 -0700 (PDT)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com. [209.85.167.52])
        by smtp.gmail.com with ESMTPSA id r3sm1226483ljc.20.2021.06.12.14.33.47
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 12 Jun 2021 14:33:47 -0700 (PDT)
Received: by mail-lf1-f52.google.com with SMTP id p17so14202292lfc.6
        for <linux-kernel@vger.kernel.org>; Sat, 12 Jun 2021 14:33:47 -0700 (PDT)
X-Received: by 2002:ac2:43b9:: with SMTP id t25mr6993774lfl.253.1623533627053;
 Sat, 12 Jun 2021 14:33:47 -0700 (PDT)
MIME-Version: 1.0
References: <20210531170123.243771-1-agruenba@redhat.com> <20210531170123.243771-6-agruenba@redhat.com>
 <YLUY/7pcFMibDnRn@zeniv-ca.linux.org.uk> <YMUjQYtBCIxHvsYV@zeniv-ca.linux.org.uk>
In-Reply-To: <YMUjQYtBCIxHvsYV@zeniv-ca.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 12 Jun 2021 14:33:31 -0700
X-Gmail-Original-Message-ID: <CAHk-=whcnziOWqVESWKJ6Y1_sG2S2AOa1vv5yKzUGs5gM7qYpQ@mail.gmail.com>
Message-ID: <CAHk-=whcnziOWqVESWKJ6Y1_sG2S2AOa1vv5yKzUGs5gM7qYpQ@mail.gmail.com>
Subject: Re: [RFC 5/9] iov_iter: Add iov_iter_fault_in_writeable()
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Andreas Gruenbacher <agruenba@redhat.com>,
        cluster-devel <cluster-devel@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jan Kara <jack@suse.cz>, Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 12, 2021 at 2:12 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> Actually, is there any good way to make sure that write fault is triggered
> _without_ modification of the data?  On x86 lock xadd (of 0, that is) would
> probably do it and some of the other architectures could probably get away
> with using cmpxchg and its relatives, but how reliable it is wrt always
> triggering a write fault if the page is currently read-only?

I wouldn't worry about the CPU optimizing a zero 'add' away (extra
work for no gain in any normal situation).

But any architecture using 'ldl/stc' to do atomics would do it in
software for at least cmpxchg (ie just abort after the "doesn't
match").

Even on x86, it's certainly _possible_ that a non-matching cmpxchg
might not have done the writability check, although I would find that
unlikely (ie I would expect it to do just one TLB lookup, and just one
permission check, whether it then writes or not).

And if the architecture does atomic operations using that ldl/stc
model, I could (again) see the software loop breaking out early
(before the stc) on the grounds of "value didn't change".

Although it's a lot less likely outside of cmpxchg. I suspect an "add
zero" would work just fine even on a ldl/stc model.

That said, reads are obviously much easier, and I'd probably prefer
the model for writes to be to not necessarily pre-fault anything at
all, but just write to user space with page faults disabled.

And then only if that fails do you do anything special. And at that
point, even walking the page tables by hand might be perfectly
acceptable - since we know it's going to fault anyway, and it might
actually be cheaper to just do it by hand with GUP or whatever.

          Linus
