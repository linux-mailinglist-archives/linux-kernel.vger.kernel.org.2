Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93C9D343505
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Mar 2021 22:29:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231371AbhCUV1R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Mar 2021 17:27:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230248AbhCUV1B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Mar 2021 17:27:01 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D893C061574;
        Sun, 21 Mar 2021 14:27:01 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id a143so4477581ybg.7;
        Sun, 21 Mar 2021 14:27:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fVHfRHc0qZ5EWt8MwFu/oOOzKE8LHPZ992pLXlNYGD8=;
        b=K3yvHA4hYI61OqRdmSowWw76/+lR1JkIYQfOKQ1jxV4z5CtatVQTjH7E0hdpo5R0Yi
         bHuKNn1bAR7HGAXUF3oA8SEF8VjWxkHhX1AYN3cjxHizkK+QtEOV9UGD96N/fxB4KsuY
         X/Nk+c22mJzQIS1uQFlZ5SeCHBzHcMfDg8ZDR2a0DPyC79J15n3LSfAiZZEzS2ez5uhA
         apIDFrKHqeLugiCfgrI90vGe+ZJcEAbGKnVbr9Xm6SwRs2MQbc0LGRfy2gm2qDWx4zs2
         VwMAZp7i2hIrkYWDvPBLHZRsxi4R0XLgVDXyvxs12gUzgzevCFCHR+B+tAQkfqKl20tG
         D/XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fVHfRHc0qZ5EWt8MwFu/oOOzKE8LHPZ992pLXlNYGD8=;
        b=e2FmLRIj51ibwStgC4hkXISKUQYYSCl2sxKwyrrgamJ/ReWaNpEQm+8GIU8LpAoMZ1
         BljKxJswMP+F/uurzVa0uTc5ICq2ZSbEU36twM9hnMmc0Jxx6QoxGhJ2Nvcx+IgZ6UJX
         YFxL3J97LsZaTFDndHiz2L6tFNxV5sLushboGHhkYXvX+rytgn+6PmQsWiFyQ3BEXVy0
         9vn9Swl174405+WUS2S/UXM/gFGXTyCtxm5v/CuLyxCI7mB8zlF7mOhh2KAod2lU5dNL
         hZRaOx2ze6EwvCjQYmI5gm+fGq8757ohxhMf4cHpZixBWJ7XKS3Xt+dKbjZEGDryIj9u
         RrPQ==
X-Gm-Message-State: AOAM530kthk8DSjXQR4MxrOx9bNJ1xsYMtP9F6fvGOcF8lDblOuuD8Q4
        X7FjlUoylOx9dc+lQMu/krd4SE57YF8TYwLZ2p0=
X-Google-Smtp-Source: ABdhPJxm8Sly1YJMYTPdm4/PtRMgcHAipcqGUHfeeKtcgZ9W91Kz5msJ7jkLff0L+pyoEx12jinhSQyTO4A/YEY/w4w=
X-Received: by 2002:a5b:449:: with SMTP id s9mr20472849ybp.115.1616362020584;
 Sun, 21 Mar 2021 14:27:00 -0700 (PDT)
MIME-Version: 1.0
References: <20210321193705.GA13699@duo.ucw.cz> <CANiq72n=XNwH8JrPfpzTMrHujhCYVzk5BgVmifiVcTk3W_=L2A@mail.gmail.com>
 <20210321205619.GB28813@duo.ucw.cz>
In-Reply-To: <20210321205619.GB28813@duo.ucw.cz>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Sun, 21 Mar 2021 22:26:49 +0100
Message-ID: <CANiq72n0ggi388c++eei8nLBsTwF78DXDpeN7vht54kczaJkew@mail.gmail.com>
Subject: Re: Getting Rust to work
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        rust-for-linux@vger.kernel.org,
        kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 21, 2021 at 9:56 PM Pavel Machek <pavel@ucw.cz> wrote:
>
> Thanks for your work :-).

You're welcome! We're trying our best :-)

> Actually x86-32 would be useful for me. That's my test machine.

Sorry... :-( x86 32-bits, ppc64el, s390x... are some of the ones we
will look into soon, but possibly after the RFC.

> I tried, but newest in my distribution is clang-7, and kernel needs
> clang-10.

If you are under Debian-like distributions, these apt repos are easy
to set up (we use them in the CI, in fact):

    https://apt.llvm.org/

Cheers,
Miguel
