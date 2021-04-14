Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63B1935FBAC
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 21:31:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353402AbhDNTbz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 15:31:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353397AbhDNTbx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 15:31:53 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 120C6C06175F
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 12:31:29 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id u4so24503795ljo.6
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 12:31:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8tmkl21nBTrgg+zi0wiLnvNOnvLGFNGElqoYB3gSO4k=;
        b=fcsPK/9hZwnNtEOdCgJlxw05JK+JnScQC6KTDZz/6X9MVaflY6Jqqe4mj4BbDYGIn6
         D5cRaqLVGf110aJOYDRuUskjfvklEd0pqbbD6FIOHNNLHu3Y3CC1Te8apRSktxKYlGWX
         ozpACYQ9P5BsjDg3WbdRsGj5aS6Iw1MmwYSsk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8tmkl21nBTrgg+zi0wiLnvNOnvLGFNGElqoYB3gSO4k=;
        b=jO2TSOjRp7JfxGU0t2t9hABO1jas5EhEaG+xk+3hsMbVQ6X/cQaKq/Dd/4cno/7QuE
         DbUJk6pwf2Rrt/ycZqviBfYU/nRnOEN9LoHLHy0K5EkUrS/L2ZxdmCyXGLVYgDcg1uwV
         oQtcoGN5MjOWjASk4uqjVZsPCv/UwRsfJWdAUpYxUQimVeBkIeMz1QvKL7MbV5DYBLb0
         CpQnPlwwIkknAhwN7qHdlq+En53w2TviGYID8NGZlG2WPXn9xzpsVIHr24D7kiA0trUh
         L51fnb7Qhm/vs1XrgC365FZmHiI+DrKmjNz4LZoxgx0LLYFLQxAHC/RNUNvLRZv6sDf2
         kbAw==
X-Gm-Message-State: AOAM533zmpGK//kvemA1ZJzSl0yt1aX8OhHzbVGLUpd0iFG5rToIlbf6
        Qq8UJAh6XKkyHDxT8bPy3ZaRc0H77/iZ1kuA
X-Google-Smtp-Source: ABdhPJw76IsggHxtavMX4oZ6fGvp+yOwkwKyBou5xLO3+yzPll8rw+49hjKKeFjVLRsJsjAIyAooXQ==
X-Received: by 2002:a05:651c:386:: with SMTP id e6mr24242286ljp.468.1618428687133;
        Wed, 14 Apr 2021 12:31:27 -0700 (PDT)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com. [209.85.208.174])
        by smtp.gmail.com with ESMTPSA id k6sm157165lfm.216.2021.04.14.12.31.26
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Apr 2021 12:31:26 -0700 (PDT)
Received: by mail-lj1-f174.google.com with SMTP id a25so11208613ljm.11
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 12:31:26 -0700 (PDT)
X-Received: by 2002:a2e:8893:: with SMTP id k19mr9184503lji.465.1618428685906;
 Wed, 14 Apr 2021 12:31:25 -0700 (PDT)
MIME-Version: 1.0
References: <20210414184604.23473-1-ojeda@kernel.org> <20210414184604.23473-8-ojeda@kernel.org>
In-Reply-To: <20210414184604.23473-8-ojeda@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 14 Apr 2021 12:31:10 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiVY56LzwV_G075NEFwsdf-p7GOTy_cB7-UU9b=49rB1g@mail.gmail.com>
Message-ID: <CAHk-=wiVY56LzwV_G075NEFwsdf-p7GOTy_cB7-UU9b=49rB1g@mail.gmail.com>
Subject: Re: [PATCH 07/13] Rust: Kernel crate
To:     ojeda@kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        rust-for-linux@vger.kernel.org,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Geoffrey Thomas <geofft@ldpreload.com>,
        Finn Behrens <me@kloenk.de>,
        Adam Bratschi-Kaye <ark.email@gmail.com>,
        Wedson Almeida Filho <wedsonaf@google.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 14, 2021 at 11:47 AM <ojeda@kernel.org> wrote:
>
> +#[alloc_error_handler]
> +fn oom(_layout: Layout) -> ! {
> +    panic!("Out of memory!");
> +}
> +
> +#[no_mangle]
> +pub fn __rust_alloc_error_handler(_size: usize, _align: usize) -> ! {
> +    panic!("Out of memory!");
> +}

Again, excuse my lack of internal Rust knowledge, but when do these
end up being an issue?

If the Rust compiler ends up doing hidden allocations, and they then
cause panics, then one of the main *points* of Rustification is
entirely broken. That's 100% the opposite of being memory-safe at
build time.

An allocation failure in some random driver must never ever be
something that the compiler just turns into a panic. It must be
something that is caught and handled synchronously and results in an
ENOMEM error return.

So the fact that the core patches have these kinds of

    panic!("Out of memory!");

things in them as part of just the support infrastructure makes me go
"Yeah, that's fundamentally wrong".

And if this is some default that is called only when the Rust code
doesn't have error handling, then once again - I think it needs to be
a *build-time* failure, not a runtime one. Because having unsafe code
that will cause a panic only under very special situations that are
hard to trigger is about the worst possible case.

             Linus
