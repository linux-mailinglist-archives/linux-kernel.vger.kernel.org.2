Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A14AF343BA1
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 09:23:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbhCVIXT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 04:23:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229944AbhCVIWw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 04:22:52 -0400
Received: from mail-vs1-xe2d.google.com (mail-vs1-xe2d.google.com [IPv6:2607:f8b0:4864:20::e2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9046EC061574;
        Mon, 22 Mar 2021 01:22:52 -0700 (PDT)
Received: by mail-vs1-xe2d.google.com with SMTP id e13so6992404vsl.5;
        Mon, 22 Mar 2021 01:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BrxVdUfvSN1VoDe8lzYvoiY9t5xWvXAzEC58gOaoxBQ=;
        b=hktJKPn/Czs4IK+PSk7VQhBPLkF/qqjhCN1WGUk95qdp7jndFFprSx6/qPPK04mikX
         O+jsk48GvkMGskN1wme7UXApSuQ/bx8s3QpfcVjC6tBZqb3sf7UpAo2elxw2eprgrrxu
         8Dza8hTvu9K/s0JUTQ6zL/I7v07zJQO1gR7xCwXMFHGn3NBEKxAr7xilGHWTjc5qsWm0
         ZX00cRgEPwnbkmL6jtPg3Gbh5E+M21jk18X/wPnfrxtaHgJziPinbgcid1+UpfKxGl0N
         IKwee1Ay5+2yNuSL/GfGl0ZnX6ECS1T6FRJ6XnDaew/KpcEoZSfKILC8ma/H1I8ZV47h
         AzFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BrxVdUfvSN1VoDe8lzYvoiY9t5xWvXAzEC58gOaoxBQ=;
        b=bOmkH2tK5QtjcLISxyC/bKQbuGu4ZCswWWxvZxA4QaWJFuZckX9swQHwYIFiRSHBPL
         V9fu7B1T3+bXDOkm49RwYij8jJ9HMPfwUXFR1Cnk6F+sF0ykLKGJ2dOeWo7t7g1AHL1h
         /oKUjIzImgEx6CR9WuT8Ku7aOHfxWFwZStsYbaijRkpEtz1fu1ucxcW/INiMnq9o7FHq
         /zKIkV/fLAumcgZNR3Q3gXyoSCpeYr5h9YI78wWkoeDcGGA53wqiK57RQxJfG7oWEXMF
         te1gJUICpZm/y4HDrX2PFvSeIZ7odShFtbljQkkfzO45KGvq/FKB8SFtdTyRKzriqeFO
         LX+Q==
X-Gm-Message-State: AOAM530Jd0Ux2DVuKFAt5lcH6jsQM3ToAVYtz66Mv+k7NWU6LL4tkGW0
        /0WwCx60I4ChMwWhWKr0wHjdUmiEpTAWjC4vYo0=
X-Google-Smtp-Source: ABdhPJyRdxZ6AOIDbY0G8bb6mAYfqmhAIgt/azIs+Y2r4ZFpzKFBS7U1NLYz7jgC81ZEb4FZXnE6h9O3y2tnu/0t93s=
X-Received: by 2002:a67:6506:: with SMTP id z6mr7889261vsb.27.1616401371850;
 Mon, 22 Mar 2021 01:22:51 -0700 (PDT)
MIME-Version: 1.0
References: <CAMmOe3SaBn9+XzjhZC8QxmZnHQkvB0R=nV4NaRRyMRF6EfcvvA@mail.gmail.com>
 <CANiq72m=kDd97+n1Zxwi5+7M8cwreoq1P_u5YZ25Dcyx40jNdA@mail.gmail.com>
 <CAMmOe3TNt2vgX=fp77yvOx7s3+CeDonkd=Unb-y2hau66M-fsg@mail.gmail.com> <20210322065300.dgory3vfe5jjfvak@gpm.stappers.nl>
In-Reply-To: <20210322065300.dgory3vfe5jjfvak@gpm.stappers.nl>
From:   Adam Bratschi-Kaye <ark.email@gmail.com>
Date:   Mon, 22 Mar 2021 09:22:41 +0100
Message-ID: <CAHaybgkt0jy_G8cO88CJ9H2MiiakqfZGjAo3f37056amLPhcEg@mail.gmail.com>
Subject: Re: drivers/char/rust_example fails to load 2021-03-20 builds
To:     Geert Stappers <stappers@stappers.nl>
Cc:     Joshua Abraham <j.abraham1776@gmail.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        rust-for-linux@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> How to tell "use older parts in toolchain"?
> Yeah, probably a Rust newbie question, still a sincere question.
> Was a older version installed? How to tell `rustup` to keep old
> versions? Was done with a cargo.toml entry? Or with file
> `rust-toolchain`?  Please tell   (Please spoon feed me ;-)

Using `rust-toolchain.toml` should work.
Another option would be to override the default version for the given
directory with
`rustup override set nightly-2021-02-20`.

You could also set the global default `rustc` to a specific nightly release:
`rustup default nightly-2021-02-20`.

More info here: https://rust-lang.github.io/rustup/overrides.html
