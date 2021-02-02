Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5585130CF64
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 23:52:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236119AbhBBWwM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 17:52:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235948AbhBBWwA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 17:52:00 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 558B9C061573
        for <linux-kernel@vger.kernel.org>; Tue,  2 Feb 2021 14:51:20 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id m22so30524983lfg.5
        for <linux-kernel@vger.kernel.org>; Tue, 02 Feb 2021 14:51:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+9krdDlER7nO0uQSN0FBS16AynTCBOll5fbT8VYMinM=;
        b=Qlsv2h0Plid5mDH3CHuEkJ6gQAw2QIc//0ZoRgMoJmE55ll7JUzmhoz98kNWxXNK5R
         RnFI75ha8WMAFzprmVwnMtkxFQk5+KAtpEixh5rW9WIqtpR/sWSL51oAZoRJ2sltvu9u
         cwP1n7LK1CcoiBibnu23KkHAJX2oM6Tk9Q14U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+9krdDlER7nO0uQSN0FBS16AynTCBOll5fbT8VYMinM=;
        b=Eitm1vOYCsNVDyaYoqLzt55pwdPkKDP7OcM+U6qrE2ODCUmKItCno5Zf84i9YJp9AF
         FS+x8xjUjF30HkSNZYHI10LEyQ4PEpZ9NNHj55EkWVQpU8KWHnBFSw9BNxuwY8zoukfW
         ARTKS5wFc5lLWtV/Qcx7EZFJA4RpPVGwnKU0Tz0emvCoxv3sPgOZzb7qDCvfO04eo2Hn
         Q9SRA/c4UXTM4xJUQLga3NLVKpzGDxmJsc/9WsoBhhrqhE4wj4kLMkauoK1f5VB74IIl
         HeU0aIKITnsxyvDPXBWEoiILuE83tPC0Dfr6gUrW6qUMgEdvBVs3cqSDnZh2JifKg21r
         0btQ==
X-Gm-Message-State: AOAM532vQL5MBTvQ/ewuQ2eD5DWnw0CPBLZfstTHU/ZfmPT70ktGEOH5
        dLiLkFK3Afx/o2NgjUozbSx8WVCg3hIOjQ==
X-Google-Smtp-Source: ABdhPJxXkyUX+tkFY1wzjoJ5ZZ+m81oNPC8bXTe74bjbu5Zt5WoHhGH6g6EIqqJv6Xuy9HtAlNOXGA==
X-Received: by 2002:a19:155:: with SMTP id 82mr125412lfb.468.1612306278232;
        Tue, 02 Feb 2021 14:51:18 -0800 (PST)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com. [209.85.208.172])
        by smtp.gmail.com with ESMTPSA id h9sm41976lfj.24.2021.02.02.14.51.16
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Feb 2021 14:51:17 -0800 (PST)
Received: by mail-lj1-f172.google.com with SMTP id a25so26035138ljn.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Feb 2021 14:51:16 -0800 (PST)
X-Received: by 2002:a2e:b1c8:: with SMTP id e8mr7297437lja.251.1612306276462;
 Tue, 02 Feb 2021 14:51:16 -0800 (PST)
MIME-Version: 1.0
References: <20210202201846.716915-1-timur@kernel.org> <202102021351.AEDE896AB3@keescook>
 <9ce56a1c-9ea6-996b-84c6-cfde908c2ecd@kernel.org> <20210202173436.6516c676@gandalf.local.home>
In-Reply-To: <20210202173436.6516c676@gandalf.local.home>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 2 Feb 2021 14:51:00 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgaK4cz=K-JB4p-KPXBV73m9bja2w1W1Lr3iu8+NEPk7A@mail.gmail.com>
Message-ID: <CAHk-=wgaK4cz=K-JB4p-KPXBV73m9bja2w1W1Lr3iu8+NEPk7A@mail.gmail.com>
Subject: Re: [PATCH] lib/vsprintf: make-printk-non-secret printks all
 addresses as unhashed
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Timur Tabi <timur@kernel.org>, Kees Cook <keescook@chromium.org>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        roman.fietze@magna.com, John Ogness <john.ogness@linutronix.de>,
        Akinobu Mita <akinobu.mita@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 2, 2021 at 2:34 PM Steven Rostedt <rostedt@goodmis.org> wrote:
>
>   "I also suspect that everybody has already accepted that KASLR isn't
>    really working locally anyway (due to all the hw leak models with
>    cache and TLB timing), so anybody who can look at kernel messages
>    already probably could figure most of those things out."

Honestly, if you have to pass a kernel command line, and there's a big
notice in the kernel messages about this, I no longer care.

Because it means that people who _do_ care will know about it.

But I don't want it to be a kernel config option - if you do
debugging, and you want unhidden pointers, you can add it to the
kernel command line and make sure it's *your* choice and not some
random kernel config by somebody else (ie distro).

And yes, my opinion is that KASRL really only works remotely anyway. I
think we might as well accept that as a fact, and that it's unlikely
that hardware will be fixed in general, even if on _some_ hardware
might make it work better than it works in general.

Instead of fighting windmills, accept that KASRL is dead locally for
the "wide access" cases (ie not necessarily just "shell access", but
"local JIT of uncontrolled code"), but do it because the remote case
still matters, and because a lot of local accesses are fairly
constrained in that they do *not* give random code execution to the
local users (but that "fairly constrained" presumably also generally
means that they can't do dmesg).

             Linus
