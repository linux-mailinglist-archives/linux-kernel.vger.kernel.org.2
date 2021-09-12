Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4FB4407FB0
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Sep 2021 21:23:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235382AbhILTYP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Sep 2021 15:24:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236054AbhILTYN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Sep 2021 15:24:13 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CAA8C061574
        for <linux-kernel@vger.kernel.org>; Sun, 12 Sep 2021 12:22:58 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id i28so13153884ljm.7
        for <linux-kernel@vger.kernel.org>; Sun, 12 Sep 2021 12:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=icaZ++IQwpOMX9N6IMshitoyKferMUIIxVmwr7l+HK0=;
        b=fKJf9kOqS17oV6zAPKn7u0FATEtdWOqi2Us5WwsE4b6ciaMC5TmfeVJ0bonaGDtgTM
         XErQbeZ1f3mxCBxg+S58gQQAhYtfHi8KxSjDpBUKRvzUy/MJJbIXLVDww7HiekJh+9wV
         FNZB4IIPCO9PnbDimxvSwRlsaxF9B710aj4cw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=icaZ++IQwpOMX9N6IMshitoyKferMUIIxVmwr7l+HK0=;
        b=7Zjxu0HM0Roh2KualIZEcIUlrFwNdtmBZhaX62VK3Jm0v5sQzgpv9JkyKq7aPc0R3Z
         dZk1PIKuGuXY9YzWTczNCPueUlDBbQoOdcBSPISGP6mECxA5ubuo4h7yXMRk9HecSQVa
         ZbIqyCmhPLTCOWgQ2bdqcx+uKA8ZacbZ2mRub3v7H9za5H068AQogLp28KhPvc3jRVUe
         C+5w/rkDC4xDeSP9pT5fv5U/+nzoTnE7jwdKMMbDmviJnae9g2igSMpj5QhBhUWyWomT
         qpQNmYLI1bMFRIZvBN8Chq3BeLYk6g8Ig9MBSdWJl/TNAdvrVVP0IhEQUBfgzkmg5qJI
         tlcg==
X-Gm-Message-State: AOAM531wM5+3tRYHDR9PHzrZErnxTuP1ELW8Av07IQBK/TJ7ljjkXpZS
        32BEdv00ZT1zwLjyejGQHCZkiQu8Fx5WgBRJXcg=
X-Google-Smtp-Source: ABdhPJyRafR9Fh6tEjnOvtepD7MONSg900lznvJE9XUiwPQwVOiFZ0MUv0y7DPYSTh9bkwH8As1D/A==
X-Received: by 2002:a2e:a903:: with SMTP id j3mr7292459ljq.347.1631474576664;
        Sun, 12 Sep 2021 12:22:56 -0700 (PDT)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id f9sm27921lfp.273.2021.09.12.12.22.55
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Sep 2021 12:22:55 -0700 (PDT)
Received: by mail-lf1-f41.google.com with SMTP id k4so16280512lfj.7
        for <linux-kernel@vger.kernel.org>; Sun, 12 Sep 2021 12:22:55 -0700 (PDT)
X-Received: by 2002:a05:6512:3da5:: with SMTP id k37mr6371928lfv.655.1631474575000;
 Sun, 12 Sep 2021 12:22:55 -0700 (PDT)
MIME-Version: 1.0
References: <YT4IvKLQHm9mfpR+@kroah.com> <CAHk-=wh7FYyewcJkozsjA95yj0AYvmpMDoZd0RxQ3ZbMMdXUdQ@mail.gmail.com>
 <202109121213.A47D575@keescook>
In-Reply-To: <202109121213.A47D575@keescook>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 12 Sep 2021 12:22:39 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiVEEzLPLTkb9U6YB-2qXpbuqP3a1q=gRx8Nkg-dpLeqw@mail.gmail.com>
Message-ID: <CAHk-=wiVEEzLPLTkb9U6YB-2qXpbuqP3a1q=gRx8Nkg-dpLeqw@mail.gmail.com>
Subject: Re: [GIT PULL] Misc driver fix for 5.15-rc1
To:     Kees Cook <keescook@chromium.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 12, 2021 at 12:17 PM Kees Cook <keescook@chromium.org> wrote:
>
> This was done to deal with the various mangling of reports (i.e.
> "summaries") I've been getting from CI systems that run LKDTM.

.. and what makes LKDTM so special?

IOW, what about ALL THE OTHER REPORTS?

And no, my argument is most definitely not "ok, everything should do this".

It's the reverse. The CI systems should be the ones that are fixed,
not random messages from random places in the kernel have version
information added.

A CI report that doesn't report the version of the kernel is kind of
fundamentally broken, wouldn't you agree?

The fix is not to add the kernel version string into every single
message you print out.

             Linus
