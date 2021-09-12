Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CF85407F93
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Sep 2021 21:04:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235571AbhILTFL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Sep 2021 15:05:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbhILTFI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Sep 2021 15:05:08 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1F08C061574
        for <linux-kernel@vger.kernel.org>; Sun, 12 Sep 2021 12:03:53 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id y6so13135989lje.2
        for <linux-kernel@vger.kernel.org>; Sun, 12 Sep 2021 12:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jDogcRuuQQlVs/rxp1kA5nt/Kw36BqWe/g9j/B2O2sA=;
        b=A026zQ1DumORFYN9ORmGqI5E02ufbH/Z8hNBwP5b9wefv0IsnyM8SMQyk/2lKDmmYg
         d8cH4nB6SuJ3JHk4Kx/MlS7Y8vw+xJwkdGjT4lrFiIWUyO3O77xxW47m5Te4l6Qwe19C
         TG9QM4QN/r92Pc3jC/8MaDL2ECFD90855IsXk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jDogcRuuQQlVs/rxp1kA5nt/Kw36BqWe/g9j/B2O2sA=;
        b=1h4FiuSec25ymECsf16lrfUHEpM6JHXwFDdPnb/1/7XO8gooVqxbZ6cUbXZScGg4V8
         v+Vln94r8kXDASSjHhJRUA2jD9IfSpUAX1cJE31NgxuN0HZuLBcC4YBnfU8uj3TEgJVR
         lOQsh7hixqfFW3efFCeaUTWcnI1Zlj5RcLSvy+ffXZWFc2arMbexvCkvdrQPiUeLPv9P
         4VONAPAEn9FUprk4vCvlW+snXaPdgEBwjhqxmJoksd34q+JREM5uJwe3D2/FJUe+PDIc
         4UW+pSae3Rxyvp716wA5BQ0bFj8qRE6c7AhMy30wuvWSrwKgj0gyGIHbvlKZ8hZ50zpS
         oSVA==
X-Gm-Message-State: AOAM533UjSCkt3gTKAcRw42w9ySFGX3VeWo+R5haRjMwbUUMjgkumJcR
        2sHbqYZ5SBkO3ba16RBlaE84Wab7XQRYbKmnjvI=
X-Google-Smtp-Source: ABdhPJwZoEgwcP7ve9g81MkMhIVM4m3hcxQxRqzJGqQK/3JfuR9ayM+P3s9YNUV2+4fJkgKoldfpbg==
X-Received: by 2002:a2e:9215:: with SMTP id k21mr7360940ljg.60.1631473431742;
        Sun, 12 Sep 2021 12:03:51 -0700 (PDT)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com. [209.85.208.170])
        by smtp.gmail.com with ESMTPSA id q11sm672884ljp.91.2021.09.12.12.03.51
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Sep 2021 12:03:51 -0700 (PDT)
Received: by mail-lj1-f170.google.com with SMTP id i28so13094873ljm.7
        for <linux-kernel@vger.kernel.org>; Sun, 12 Sep 2021 12:03:51 -0700 (PDT)
X-Received: by 2002:a2e:1542:: with SMTP id 2mr7307296ljv.249.1631473430990;
 Sun, 12 Sep 2021 12:03:50 -0700 (PDT)
MIME-Version: 1.0
References: <YT4IvKLQHm9mfpR+@kroah.com>
In-Reply-To: <YT4IvKLQHm9mfpR+@kroah.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 12 Sep 2021 12:03:35 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh7FYyewcJkozsjA95yj0AYvmpMDoZd0RxQ3ZbMMdXUdQ@mail.gmail.com>
Message-ID: <CAHk-=wh7FYyewcJkozsjA95yj0AYvmpMDoZd0RxQ3ZbMMdXUdQ@mail.gmail.com>
Subject: Re: [GIT PULL] Misc driver fix for 5.15-rc1
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 12, 2021 at 7:03 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> It resolves a build issue that many people were hitting with your
> current tree [...]

I was like "Oh, serious build problems"..

But as far as I can tell, the "build issue" is that a couple of files
get recompiled every time you add a commit. Ok, that added possibly a
few seconds to the build.

So fixing that is good, but why is that lkdtm driver insisting on
writing the release and machine information AT ALL?

IOW, the fix seems kind of silly. The kernel release information
should just have been removed entirely, because the kernel prints that
out as the very first thing anyway, so 'dmesg' will have something
like

    Linux version 5.14.0-11181-gd8e988b62f94 (torvalds@ryzen) (clang
version 12.0.1 ...

at the very top.

So I think that whole 'lkdtm_kernel_info' thing is all kinds of pointless.

Could we please just stop pointlessly printing out kernel version data
that  is already available other ways? Just do 'dmesg', or 'uname -r'
or whatever instead of insisting on printing out redundant
information?

           Linus
