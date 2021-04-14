Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 565FD35FE65
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 01:25:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235181AbhDNXZ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 19:25:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233136AbhDNXZZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 19:25:25 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DF45C061574
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 16:25:02 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id l14so22179186ljb.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 16:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CLbBTpjjt41QwROOmav9UyaOIjiz2GHQ1pdcG8Srixk=;
        b=VeP6IaajA77cFYvkuq8w+FxgsvKrtgTzKQkHsIUnbj3C5Jk22V4ZM9+zvZz37SPn5z
         TiQFCz/zT4vgS9uX4hRXotaSG7MLSStLMHrMXh0f0Rt/DJ38PQ9fpl7jzwvjtQeKgP8V
         Hx7UrZxMHdpm7+Tdggh/yOwOC1UOULzuqCLXra+jaDoh/GLN/nwdvuMUfuw3FJigXg4r
         /itKl6AchlHXWQsYtLaHMJxdUXNaT8xXG6nbMCYqVNOhYlcjAagZpB+7XqECkRedTxAs
         V31chxUfLNJEoewg9EHRlGhb4wWK0RQjRemX1GS5F3dJbU+MIRYMN+PBzRboJiJY0Dsa
         Ogig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CLbBTpjjt41QwROOmav9UyaOIjiz2GHQ1pdcG8Srixk=;
        b=H8kFLeGWD/4g7a0lpXMGHdtTPNu56bb5+plPLKvLJbPLaut8ottiB5M5/Bl7RvcZEt
         yu3zetgopoosvQnE4Fv8FPGEQafh8JGa45lRRb2wZ+bEHU/p6WQsleG3eGf6qfw8oyO3
         iKLszdBsnsV2sMewg7UyJYhX251cgDZDaRtjYlRcQnBHmEGPla2rNu5BEpUlB1PMQDfs
         zEHJHZhe0Rgg9Kp0KY2YM6bx7IRfHRk61L8s3Xl04DbUty8SsaDgKyGctJ7U+hR25p+r
         GXiJxwigBvNHqGdWwSWawN7+JXb64r8fLXQiVLikjN/S3MGhN2v4eTzJ1WenwONvsdRU
         nBqQ==
X-Gm-Message-State: AOAM5315UzTH5S5rnTxiLAjvzrduM0TteTKW7XNe/i6Atl1qoeXnB6XR
        onbe1c173QkZvoTl/i6fXt/Qg7Ri1qhofrVtgP5kYQ==
X-Google-Smtp-Source: ABdhPJznGa7Wth739yNjYu+WxC0CwVPRykaGcZdlpatQMKWs83I9ZIGfrqt/typWvysIBPbCfZdRKV/p/qOn75Gm3Yo=
X-Received: by 2002:a2e:b817:: with SMTP id u23mr212619ljo.116.1618442697752;
 Wed, 14 Apr 2021 16:24:57 -0700 (PDT)
MIME-Version: 1.0
References: <20210414184604.23473-1-ojeda@kernel.org> <20210414184604.23473-10-ojeda@kernel.org>
 <CAHk-=wjdZ1KksHHHuekeAx9kKFXEyt+rg0P=yRD1Bia_01wucg@mail.gmail.com>
In-Reply-To: <CAHk-=wjdZ1KksHHHuekeAx9kKFXEyt+rg0P=yRD1Bia_01wucg@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 14 Apr 2021 16:24:45 -0700
Message-ID: <CAKwvOd=Vo3wwm-egc6fTa7gD4dsrc77OvBhUy8e+VM=LujRCfg@mail.gmail.com>
Subject: Re: [PATCH 09/13] Samples: Rust examples
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        rust-for-linux@vger.kernel.org,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Geoffrey Thomas <geofft@ldpreload.com>,
        Finn Behrens <me@kloenk.de>,
        Adam Bratschi-Kaye <ark.email@gmail.com>,
        Wedson Almeida Filho <wedsonaf@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 14, 2021 at 12:35 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Wed, Apr 14, 2021 at 11:47 AM <ojeda@kernel.org> wrote:
> >
> > From: Miguel Ojeda <ojeda@kernel.org>
> >
> > A set of Rust modules that showcase how Rust modules look like
> > and how to use the abstracted kernel features.
>
> Honestly, I'd like to see a real example. This is fine for testing,
> but I'd like to see something a bit more real, and a bit less special
> than the Android "binder" WIP that comes a few patches later.
>
> Would there be some kind of real driver or something that people could
> use as a example of a real piece of code that actually does something
> meaningful?

Are you suggesting that they "rewrite it in Rust?" :^P *ducks*

(sorry, I couldn't help myself) Perhaps it would be a good exercise to
demonstrate some of the benefits of using Rust for driver work?
--
Thanks,
~Nick Desaulniers
