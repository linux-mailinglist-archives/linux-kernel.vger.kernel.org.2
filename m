Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6D2134D781
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 20:43:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230503AbhC2Smb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 14:42:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:50164 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231426AbhC2Sl4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 14:41:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2E9BA60C3D
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 18:41:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617043316;
        bh=qD8DVxXjuG5oFwjixu2nTmjbMNhSN50oQsq45QyDSR4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=gzekNXiy/LsR92rA3cwoQQpjN1UsdrMzc+0JqHT/YEyM3kOSx35B1wfxx4o7kYIxW
         Kn61/yeHu+8A6Tke38HWVx0ff1IUfdYbg4erItEXYacU7NuH6yCq8B+vPEvBdIT/+N
         H0Tevn1NsvgitJRRMZZFHYBRIgk1D8cz95IbLb+6fPVteKNY9HbC4CKF3hf8WIDvOf
         I/JIMdmWmRBa4Zb/c9T3urt3QDMYwD9+oonZu+VFexWvbFyO7YYLOtl9zCYh8yHn5L
         nolsImpGruo6aNLY6UKjD7WcVwERF8aKXmROe8HCAWuuT7tjmEDzu4NdnTNxzFWKbq
         1/D4lAOw3vCNQ==
Received: by mail-ej1-f52.google.com with SMTP id u9so20998560ejj.7
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 11:41:56 -0700 (PDT)
X-Gm-Message-State: AOAM532pv5U2ds9kqqq4ivIWOKVNYlDt71xrKUWJfM7hExZmRY7tSnvX
        cCa8GFi14zJpc/fSGyM0Phgo5yx2iSMn037tSQ==
X-Google-Smtp-Source: ABdhPJwzl025RO7iS5jhgrL1DacHi3iVQceN+e8l1oRX/n1T6lxw+CzeM+53nWpDYFIP6oTn48MTMzC4bNfV+WLBaq0=
X-Received: by 2002:a17:906:5e01:: with SMTP id n1mr29979915eju.359.1617043314784;
 Mon, 29 Mar 2021 11:41:54 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wg89U6PLp1AGhaqUx4KAZtkvKS6kuNmb+zObQhf1jez+g@mail.gmail.com>
 <20210329020746.GA250550@roeck-us.net> <CAHk-=wiMoP9PifpuUnQ3xmAM_LmGARr+fxFuOSX1rvh2mz35Mw@mail.gmail.com>
In-Reply-To: <CAHk-=wiMoP9PifpuUnQ3xmAM_LmGARr+fxFuOSX1rvh2mz35Mw@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 29 Mar 2021 13:41:42 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKxLy3Gc8d1Q23AQaWTKLmc_a28tokZZ08rHnV2qU0iew@mail.gmail.com>
Message-ID: <CAL_JsqKxLy3Gc8d1Q23AQaWTKLmc_a28tokZZ08rHnV2qU0iew@mail.gmail.com>
Subject: Re: Linux 5.12-rc5
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

n Mon, Mar 29, 2021 at 1:05 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Sun, Mar 28, 2021 at 7:07 PM Guenter Roeck <linux@roeck-us.net> wrote:
> >
> > This is not really a new problem. I enabled devicetree unit tests
> > in the openrisc kernel and was rewarded with a crash.
> > https://lore.kernel.org/lkml/20210327224116.69309-1-linux@roeck-us.net/
> > has all the glorious details.
>
> Hmm.
>
> I'm not sure I love that patch.
>
> I don't think the patch is _wrong_ per se, but if that "require 8 byte
> alignment" is a problem, then this seems to be papering over the issue
> rather than fixing it.
>
> So your patch protects from a NULL pointer dereference, but the
> underlying issue seems to be a regression, and the fix sounds like the
> kernel shouldn't be so strict about alignment requirements.

In the interest of the DT unittests not panicking and halting boot, I
think we should handle NULL pointer.

> I guess we could make ARCH_SLAB_MINALIGN be at least 8 (perhaps only
> if the allocations is >= 8) but honestly, I don't think libfdt merits
> making such a big change. Small allocations are actually not uncommon
> in the kernel, and on 32-bit architectures I think 4-byte allocations
> are normal.
>
> So I'd be inclined to just remove the new
>
>         /* The device tree must be at an 8-byte aligned address */
>         if ((uintptr_t)fdt & 7)
>                 return -FDT_ERR_ALIGNMENT;
>
> check in scripts/dtc/libfdt/fdt.c which I assume is the source of the
> problem. Rob?

That is the source, but I'd rather not remove it as we try to avoid
any modifications from upstream. And we've found a couple of cases of
not following documented alignment requirements.

> Your patch to then avoid the NULL pointer dereference seems to be then
> an additional safety, but not fixing the actual regression.

I think the right fix is not using kmemdup which copies the unittest dtb.

Rob
