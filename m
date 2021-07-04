Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACDD93BAF36
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Jul 2021 23:28:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230094AbhGDVa7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Jul 2021 17:30:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229998AbhGDVa5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Jul 2021 17:30:57 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06204C061762
        for <linux-kernel@vger.kernel.org>; Sun,  4 Jul 2021 14:28:21 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id f30so28807419lfj.1
        for <linux-kernel@vger.kernel.org>; Sun, 04 Jul 2021 14:28:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EbAGqDDbQnmjvsoTclpanP0h7gMK/AYm7CJnJS7LBY0=;
        b=EHudwuo4e7cs9iy4bKTttxh5r9bMEt+Or14SkbnP8XxX+YLimbIhboHjNY1YI7rJb1
         BQgZulzERbrQhHRG6dgvXGd+bH8g8ubQtBJwB6kCRYzc86HwozOTZo/k6oJHPk7lUEHT
         e8WtFHMImLSrmrRRFjuGao0CPcAtgaoBdpI9k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EbAGqDDbQnmjvsoTclpanP0h7gMK/AYm7CJnJS7LBY0=;
        b=USO8WqiKD2J0TsODsaD3pPXQt3wyCz+9vaIcP9cVpDAFwc7IHSBAM4565spV649Fn/
         UVToW+SXO0TvSHO7J+N1UzIV0L/xw5tfZapu/HCClj6S24Db2DKXchPRA2iaFpDqt6i5
         pP2nGkGUreiq23OxQd6MUvFbGPWeA98QQjQ/nwpwJVI8Mr6LsOpz0CxNykofaTvGQn0z
         frN6NKX+ks8Z9jUQiAt8EFDpC0nybgG/4xMVvwlSEZ0cQXcNlSeFihBMUBx+WFo/U1Pa
         knHVLZfE41elLhgHrxINNg8TLw/HgPMOnYrFUu0ihDZxeGwLqeM/IADfPxVVXfpMpoWS
         9w7g==
X-Gm-Message-State: AOAM530gwQvQYw3Fgo2Vf1S+R/m6UB0iSbHcVkL6i6L9EXlCB2pPGsKx
        63xKrCXd4X7pSUCPC8Lsf4MK1T1KhcyVd5dQ
X-Google-Smtp-Source: ABdhPJxIXGMn2ERgUEfi5is4UM+s4/FPb/goqIAbeH4/AlZy0IeG4wcRgkqXgcYduKtw3svJzEV2rw==
X-Received: by 2002:a05:6512:c0c:: with SMTP id z12mr8214711lfu.544.1625434099982;
        Sun, 04 Jul 2021 14:28:19 -0700 (PDT)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id d8sm889028lfi.129.2021.07.04.14.28.19
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 Jul 2021 14:28:19 -0700 (PDT)
Received: by mail-lf1-f49.google.com with SMTP id c28so5347201lfp.11
        for <linux-kernel@vger.kernel.org>; Sun, 04 Jul 2021 14:28:19 -0700 (PDT)
X-Received: by 2002:ac2:4903:: with SMTP id n3mr7787093lfi.487.1625434098906;
 Sun, 04 Jul 2021 14:28:18 -0700 (PDT)
MIME-Version: 1.0
References: <20210704202756.29107-1-ojeda@kernel.org> <20210704202756.29107-2-ojeda@kernel.org>
 <CAHk-=wisMFiBHT7dLFOtHqX=fEve3JafZjSvbd5cy=MpW4u7zQ@mail.gmail.com> <CANiq72n0SeubFWsFXkTT1V-BCQB+MzVRqC4L+PT8QtA0=C2r8Q@mail.gmail.com>
In-Reply-To: <CANiq72n0SeubFWsFXkTT1V-BCQB+MzVRqC4L+PT8QtA0=C2r8Q@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 4 Jul 2021 14:28:03 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjFa-d_Gha9KyrXb9UxTKNJY3L3D1D-f6jPSz0_AWSuLg@mail.gmail.com>
Message-ID: <CAHk-=wjFa-d_Gha9KyrXb9UxTKNJY3L3D1D-f6jPSz0_AWSuLg@mail.gmail.com>
Subject: Re: [PATCH 01/17] kallsyms: support big kernel symbols (2-byte lengths)
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        rust-for-linux <rust-for-linux@vger.kernel.org>,
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

On Sun, Jul 4, 2021 at 2:15 PM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> No particular reason. It makes sense to use LE -- I will change it.

Matthew's suggestion is denser, which is nice.

At that point, it would be neither BE nor LE. But the "LE-like" version would be

   len = data[0];
   if (len & 128)
        len += data[1] << 7;

which ends up having a tiny bit more range (it goes to 11^H32895).

Of course, if the range is expected to be just 0-300, I guess that
matters not one whit.

                Linus
