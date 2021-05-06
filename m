Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA12F37540E
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 14:48:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231976AbhEFMs5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 08:48:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231533AbhEFMsy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 08:48:54 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93F5AC061761
        for <linux-kernel@vger.kernel.org>; Thu,  6 May 2021 05:47:56 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id c3so7591833lfs.7
        for <linux-kernel@vger.kernel.org>; Thu, 06 May 2021 05:47:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QzEhbEsMPT0RAPd1e91T+mtb6uxkgCOagogsHHD+eZ8=;
        b=Ks4nME/nPDpiuCR59p2B2xWzX2AYOmCJzm4REQpSn4ozFkIMOPSUaWXVEwcPIc4xyQ
         /h/8FA83Pe63a9B4OsKLVtiF+oz11lDf0JTY0Nrd9qrebslmObz5Ypz0Gz1hTRDzKP2j
         VqxNzfQVUd8RPj/vo9zPpRYyZSk4aFNGAgziomJb2ZrXcFnaEFbVdi4BRH2/5cHXHWkt
         lp9+3khZACAlWA5W6hz3CYTVxwHDfHI9CGl1MoHyCeKD8UrE3WcIrz9uSDezslqePeqc
         wV081/jHVKrG2qYS+BZVI099G5yt3aR4TATmjDcF4wJ3EMrnwEPL5Emo1GkHIqM9iFxK
         zw+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QzEhbEsMPT0RAPd1e91T+mtb6uxkgCOagogsHHD+eZ8=;
        b=K/tzEpw5CWdc5dQk6hcO1jNsF9tZsRf59OzIjhvM4tkZgbajdHJqrs3TpgPTdcAcC1
         x4Ylh7acYaNHOrkIE+sE/cZqYz19Wc1cXxkxZmp7zzu3vITCgkv3cGW5VhuWrJccZhYp
         18ClZQFZsATbOxuv3IwQXokiZrj4vQLJ5GWTiDpRz6vwFCE3aB9hOOAYevTrAJQtRBGd
         M6UZC1g7thn2DB6zGnFo8Djv1D9BHQJS/nTkhXxXkRZqDdazxliIWdmm0qlEJiRcNogJ
         RQ5L+emOlzuxQ0Qb6ml2kPVa1ShNcg4FVgzAIpBceXkc++YiP8T8Ro96GJXjPERBbkSJ
         wSSQ==
X-Gm-Message-State: AOAM532D5plFeUi0lPMya4TawGAt0eYGNsDryY7tWmB82yIzAw6pphBC
        SiPwCFOnWezOnsLEFKm1Vw6t1Q5naf3qKs889Z8yVg==
X-Google-Smtp-Source: ABdhPJwJSNb8W1vk/3K2xi7xKhIaQoHWBzIq30udueCYblsY75ozgEgTP9kUERq+loNLHdEeI4qZI/JWoOzp/xuldN4=
X-Received: by 2002:ac2:544f:: with SMTP id d15mr2712552lfn.465.1620305275123;
 Thu, 06 May 2021 05:47:55 -0700 (PDT)
MIME-Version: 1.0
References: <20210414184604.23473-1-ojeda@kernel.org> <YHiMyE4E1ViDcVPi@hirez.programming.kicks-ass.net>
 <YHj02M3jMSweoP4l@google.com> <CACRpkdat8bny=D2mAsUXcDQvFJ=9jSZSccMMZzH=10dHQ_bXrQ@mail.gmail.com>
 <CANiq72niCj9SfPhfQBMtxF+jth--cXdPQtUo5jhDDJgL6DTXZQ@mail.gmail.com>
 <CACRpkdarfkA1P0ERCXHSA=6VTBn6FXgOxB8haneQtN_4-tyQ0w@mail.gmail.com>
 <CANiq72=VA_cH9yw_LZr3P+n1AsQEEhtY4xdk76jHgimTufHRsQ@mail.gmail.com>
 <CACRpkdYodGnURuaYMBwVAY=8bU0PQoPAvTp34uYksPFmxBsT2A@mail.gmail.com>
 <CANiq72m9V3dVG59jAoR-OM+7QtJauQgrix3DZkw=oCuaaf3H5w@mail.gmail.com>
 <CACRpkdYzqy69G1Fpj4rFQFS+mYmpbQAzTszwCUBuEhe4YW4cuQ@mail.gmail.com>
 <CANiq72k+x13L+sFkjtDLahcvnpEySqk_NGow6FVMZfrV+MmHPw@mail.gmail.com>
 <CACRpkdbNv4O7zs0OpZhWa2fkXkF5arQgDOF9++zKvr+yB5yk_w@mail.gmail.com> <CANiq72njjiovAecf5pJGAuyJB8sEZ_fO92FNDZ7rH6YQSffqrw@mail.gmail.com>
In-Reply-To: <CANiq72njjiovAecf5pJGAuyJB8sEZ_fO92FNDZ7rH6YQSffqrw@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 6 May 2021 14:47:43 +0200
Message-ID: <CACRpkdYpM=38K2WLS-+R2OhWweO8Q9SFndgGC2Py7uBjjxNdAA@mail.gmail.com>
Subject: Re: [PATCH 00/13] [RFC] Rust support
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Wedson Almeida Filho <wedsonaf@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        rust-for-linux <rust-for-linux@vger.kernel.org>,
        linux-kbuild <linux-kbuild@vger.kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 5, 2021 at 4:17 PM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
> On Wed, May 5, 2021 at 1:34 PM Linus Walleij <linus.walleij@linaro.org> wrote:
> >
> > Right now it seems like those organizations and companies
> > would be some academic institutions who like rust (because they
> > study languages and compilers) and Google. But that is a
>
> Note that there are quite a few major private players already
> involved, not just Google! e.g.

I was referring to entities interested in using Rust for the
Linux kernel. Not just "using rust". And that interest is coming
from Google and a few academic institutions AFAICT.

Yours,
Linus Walleij
