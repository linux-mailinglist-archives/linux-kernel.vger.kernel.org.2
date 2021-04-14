Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A806635FC86
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 22:22:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232605AbhDNUWg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 16:22:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232705AbhDNUWd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 16:22:33 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA4CCC061760
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 13:22:10 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id e14so22534933lfn.11
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 13:22:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6thTORuT8bN7jwK094fMT/y8sU4GZakkr5R6ovUTdHI=;
        b=UAoa76Qtsf0pbMc9IJqG9ooEMfjhEIrknCxndD8VY6cPrguml69YvPFqGmlzuBSQzh
         FrdelVohMGw/UXPitS8jaS0vYBU01i6SIHCs/u+B0uDNa1/+o7AFCQGtYFo/uY/vW9FE
         e35iod5n6V1pTvp83DTqqYHvpeFqDSO7Dx/Rk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6thTORuT8bN7jwK094fMT/y8sU4GZakkr5R6ovUTdHI=;
        b=Tl8pt3RHXqmgvm15ZitmuHvaDZhg2mlqgOmjiTu76uJ5OzQw2ubFSHpd6oCfEjBVgs
         Xlddj+Tb7cqZJpkVWhJNLDxaXCJVpr585SJt1NxrTyCXrlepj8DtHbikZreAWB32h5IM
         43sQY0dzMGf/r3yM4MmrEWwzc7eBJwwAIxcIVNGWseAkiMw1yLJXFMtfnwGQ4W5gBbmU
         bDDfttUfm8H0AVPhq+AOQ1MbdVMSZizzQ519/2h8S3xxan+roIY+liy8YyPXYoBBqmHg
         TYBZ31KV74n6Y8LlqSOxrRII2i/7yaktmmxLHVc0fSWB5zdGKhJSHm+ziwxfOox906ge
         C0pg==
X-Gm-Message-State: AOAM530hKb863H8bqfVzWzci0mprxlM0caFe4SgVDLBwT7EupuOCnWuH
        LaycqCQye7zReHEbZaJ5MYpmmpa6qxocDShE
X-Google-Smtp-Source: ABdhPJx+hWmFootQkTwPh84o+Oa8Gakf5vlf5M2WL63HsL0EwsmrCczujENftYnlBangf/7bLGpH3g==
X-Received: by 2002:a05:6512:3187:: with SMTP id i7mr14029085lfe.340.1618431729207;
        Wed, 14 Apr 2021 13:22:09 -0700 (PDT)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com. [209.85.167.45])
        by smtp.gmail.com with ESMTPSA id h20sm193129lfm.274.2021.04.14.13.22.08
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Apr 2021 13:22:08 -0700 (PDT)
Received: by mail-lf1-f45.google.com with SMTP id 12so35186444lfq.13
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 13:22:08 -0700 (PDT)
X-Received: by 2002:a05:6512:1286:: with SMTP id u6mr16109842lfs.377.1618431727841;
 Wed, 14 Apr 2021 13:22:07 -0700 (PDT)
MIME-Version: 1.0
References: <20210414184604.23473-1-ojeda@kernel.org> <20210414200953.GX2531743@casper.infradead.org>
In-Reply-To: <20210414200953.GX2531743@casper.infradead.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 14 Apr 2021 13:21:52 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgdhVW3+YFHG5Le=mZMYf3mGjgv1f-Td=254bj9fYd7fg@mail.gmail.com>
Message-ID: <CAHk-=wgdhVW3+YFHG5Le=mZMYf3mGjgv1f-Td=254bj9fYd7fg@mail.gmail.com>
Subject: Re: [PATCH 00/13] [RFC] Rust support
To:     Matthew Wilcox <willy@infradead.org>
Cc:     ojeda@kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        rust-for-linux@vger.kernel.org,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 14, 2021 at 1:10 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> There's a philosophical point to be discussed here which you're skating
> right over!  Should rust-in-the-linux-kernel provide the same memory
> allocation APIs as the rust-standard-library, or should it provide a Rusty
> API to the standard-linux-memory-allocation APIs?

Yeah, I think that the standard Rust API may simply not be acceptable
inside the kernel, if it has similar behavior to the (completely
broken) C++ "new" operator.

So anything that does "panic!" in the normal Rust API model needs to
be (statically) caught, and never exposed as an actual call to
"panic()/BUG()" in the kernel.

So "Result<T, E>" is basically the way to go, and if the standard Rust
library alloc() model is based on "panic!" then that kind of model
must simply not be used in the kernel.

             Linus

           Linus
