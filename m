Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F1E736320C
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Apr 2021 21:46:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237048AbhDQTq7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Apr 2021 15:46:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236779AbhDQTq6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Apr 2021 15:46:58 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03255C061574;
        Sat, 17 Apr 2021 12:46:30 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id i3so10465398edt.1;
        Sat, 17 Apr 2021 12:46:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eSOJMwvIJkQU2JYaT7cb2vTqKYf6iPw1ySzK9GIZ1mE=;
        b=sfo1ZL4IgQFU2a/GIYfPYPNoASv/hTC8EXtSdm5D8WaqKRLhRkrGTSIlZ26izkLwi7
         w8x8K1vXttMQP13GzODDnpCdBVZuLTzQShERLxCHX6TLEXSIpAd3rAL3lbQ0PADABVsH
         YA5oOOEDjpHvzT/dP4RT/ZiRiEy034kX0JZxZk4o0Y5UBO6syzwfb+agbs+R2SEAW/+k
         +OjJ/dxGqwRhv1jXxskU7kAj61la0qlDD05y6GXTjp+TAgYASdkoyH5u01sTyuaRKWoj
         tEEDftgbbEIZuZs1B9ITJFiDDo60JnR6r8JW3YxgECy43nvTm9y7MT2PKG5r1+fyzNsl
         yBOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eSOJMwvIJkQU2JYaT7cb2vTqKYf6iPw1ySzK9GIZ1mE=;
        b=S3rc71BOQgEA2eFV3JQrfibVYUGyS2EW8a9/HgceCBbIaGMBJDs0A/XiD9cOLnYxMg
         GTyHCEtuMoKsO7fIDDXTdmB9c/HaGADjyuqOTy4NCLd/v5dCt998Iy6UpuhVK/cOlxqV
         LrpSSAFjfNTYTFrAEytyc5IqdCBjcC6a+RP2GNzvyhj4JJJ6sjMiAvMusTPZzMkYcN+e
         KPKIVDJJwXbz23iXn7WSdBrJ966arLu1tPuYg3pCV21egQRfIEHqoFAxPRqVn737DikJ
         ZDAZwPQ/xN0TglXxRxDkz6cNjP60JYJNv9R+pDxn/kXfHntIpSY8c17Hc8xXzyvk7fko
         yu1g==
X-Gm-Message-State: AOAM531WZhtpFqbrdf8GdJLmTW1/RI7+cZ3QDtqp0d7x9b53aeMSqQzg
        p8kzRsJaOdWFMc5F7L9qIxO2bL6IwhSlxYKGbSw=
X-Google-Smtp-Source: ABdhPJwupn1AHPWkgNX5S4iHwJNtNuew20GI+CF5/KvqzL8rItIj/uzGeoXQIWZUulBDltLD4HWNwDeHrrCts+tPxAQ=
X-Received: by 2002:a05:6402:4415:: with SMTP id y21mr16888070eda.70.1618688788715;
 Sat, 17 Apr 2021 12:46:28 -0700 (PDT)
MIME-Version: 1.0
References: <20210326205135.6098-1-info@alexander-lochmann.de>
 <CA+fCnZcTi=QLGC_LCdhs+fMrxkqX66kXEuM5ewOmjVjifKzUrw@mail.gmail.com> <CACT4Y+Y_PfAhjV26xYf8wcEv0MYygC14c_92hBN8gqOACK7Oow@mail.gmail.com>
In-Reply-To: <CACT4Y+Y_PfAhjV26xYf8wcEv0MYygC14c_92hBN8gqOACK7Oow@mail.gmail.com>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Sat, 17 Apr 2021 21:46:18 +0200
Message-ID: <CA+fCnZczmfDROOLbQ-7w7a+-YXM-D4z+Jo-_7FZF+3G0yKYc4A@mail.gmail.com>
Subject: Re: [PATCHv3] Introduced new tracing mode KCOV_MODE_UNIQUE.
To:     Dmitry Vyukov <dvyukov@google.com>,
        Alexander Lochmann <info@alexander-lochmann.de>
Cc:     Andrey Konovalov <andreyknvl@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Randy Dunlap <rdunlap@infradead.org>,
        Andrew Klychkov <andrew.a.klychkov@gmail.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Aleksandr Nogikh <nogikh@google.com>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        Maciej Grochowski <maciej.grochowski@pm.me>,
        kasan-dev <kasan-dev@googlegroups.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 16, 2021 at 10:42 AM Dmitry Vyukov <dvyukov@google.com> wrote:
>
> On Sat, Mar 27, 2021 at 3:56 PM Andrey Konovalov <andreyknvl@gmail.com> wrote:
> >
> > On Fri, Mar 26, 2021 at 9:52 PM Alexander Lochmann
> > <info@alexander-lochmann.de> wrote:
> > >
> >
> > Hi Alexander,
> >
> > > It simply stores the executed PCs.
> > > The execution order is discarded.
> > > Each bit in the shared buffer represents every fourth
> > > byte of the text segment.
> > > Since a call instruction on every supported
> > > architecture is at least four bytes, it is safe
> > > to just store every fourth byte of the text segment.
> >
> > What about jumps?
>
> KCOV adds call __sanitizer_cov_trace_pc per coverage point. So besides
> the instructions in the original code, we also always have this call.

Ah, I see. This should be explained in the changelog.

This means that a KCOV user will need the kernel binary to recover the
actual PCs that were covered, as the information about the lower two
bits is lost, right? This needs to be explained as well.

Thanks!
