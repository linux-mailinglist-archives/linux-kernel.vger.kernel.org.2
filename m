Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E36A4409E40
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 22:37:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244541AbhIMUiU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 16:38:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244538AbhIMUiS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 16:38:18 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1B85C061764
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 13:37:01 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id k13so23725954lfv.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 13:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:cc;
        bh=uNcqj9xjWIfQIY0QflXDG20YjitmguOx4ywcCWl73/U=;
        b=ilWLGdi3Cf8peiOJcbZixLNgXePN5jQ7FtqkR0ne0wGyCRK96xVTx6VujOtvGJnwOA
         t29LDmRG+oQphsKQLnpgKx0qT0UFM0awAHItWH/qAMoFwuMy1QfcQ+Htb6PtxMKA0yfi
         FfYper/cc47ppbEIm94dxrSsOZzWauuRFeUEGD1On65oseTwVG4b7swRd5bBE7KJ9ugH
         muU1CEublYt5PHRS7COzLUHbPECVYPxwPrD9v0OcSC5aw/MKDfgo+UWjHNk1XfiEJZSA
         QEUvgjOv/V+CZ1qNhRAAq28FWdx6nR1p3+erxw08PjXPab3mgwlZu/7cKFrCj+ejmrOK
         9Pmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:cc;
        bh=uNcqj9xjWIfQIY0QflXDG20YjitmguOx4ywcCWl73/U=;
        b=I/NTKbvMebsWWDxS5ht+PAuztLIZ0R98bNCGUdfkVBFuUTxyfZL4GHVVikguEGlbis
         QA0dvgVHUxE1O5srtLsKIThLMWP3lzZwjzf8/XRJqAQGo82bRI1206oFSO/eMRGg0Blr
         eF5Fz3TwfbOCU0c5XxzOTTJ/xiT2RikC2QXCpl4phpYqewOoWpPPCWg3JBeBd0hskDLU
         oDylug7tEDrLC2ieCVBB8N/opgywjfSFQl9aoyjbRZP7KwoOyloX4s4u5sLED4NCAcef
         tjkwF47bvGMATWy2rGx/ItD3YMBAnco6aW9udhtM0Sm7ePXD20m7LCeTTNapJV4iOWeU
         ZWYA==
X-Gm-Message-State: AOAM533FBhbSAIPVeo231vgrooH5MK41uaV6PoAd44dse/tBlGqlclId
        wVyxhSKyyfSKqray3JJfGPwP5BQIRP710tnRjAOq+g==
X-Received: by 2002:a05:6512:1114:: with SMTP id l20mt4770203lfg.550.1631565420008;
 Mon, 13 Sep 2021 13:37:00 -0700 (PDT)
MIME-Version: 1.0
References: <20210913131113.390368911@linuxfoundation.org> <20210913131114.028340332@linuxfoundation.org>
 <CA+G9fYtdPnwf+fi4Oyxng65pWjW9ujZ7dd2Z-EEEHyJimNHN6g@mail.gmail.com>
 <YT+RKemKfg6GFq0S@kroah.com> <CAKwvOdmOAKTkgFK4Oke1SFGR_NxNqXe-buj1uyDgwZ4JdnP2Vg@mail.gmail.com>
 <CAKwvOdmCS5Q7AzUL5nziYVU7RrtRjoE9JjOXfVBWagO1Bzbsew@mail.gmail.com>
 <CA+icZUVuRaMs=bx775gDF88_xzy8LFkBA5xaK21hFDeYvgo12A@mail.gmail.com>
 <CAKwvOdmN3nQe8aL=jUwi0nGXzYQGic=NA2o40Q=yeHeafSsS3g@mail.gmail.com>
 <CAHk-=whwREzjT7=OSi5=qqOkQsvMkCOYVhyKQ5t8Rdq4bBEzuw@mail.gmail.com> <CAKwvOdkf3B41RRe8FDkw1H-0hBt1_PhZtZxBZ5pj0pyh7vDLmA@mail.gmail.com>
In-Reply-To: <CAKwvOdkf3B41RRe8FDkw1H-0hBt1_PhZtZxBZ5pj0pyh7vDLmA@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 13 Sep 2021 13:36:49 -0700
Message-ID: <CAKwvOdkpsvNK2x+=S80crW0reFBH-vwuNop7-2mFayajFMcqog@mail.gmail.com>
Subject: Re: [PATCH 5.14 018/334] nbd: add the check to prevent overflow in __nbd_ioctl()
Cc:     Sedat Dilek <sedat.dilek@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Baokun Li <libaokun1@huawei.com>,
        open list <linux-kernel@vger.kernel.org>,
        linux-stable <stable@vger.kernel.org>,
        Hulk Robot <hulkci@huawei.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        lkft-triage@lists.linaro.org, llvm@lists.linux.dev,
        Kees Cook <keescook@chromium.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Arnd Bergmann <arnd@kernel.org>
Content-Type: text/plain; charset="UTF-8"
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 13, 2021 at 1:16 PM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Mon, Sep 13, 2021 at 1:10 PM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > On Mon, Sep 13, 2021 at 1:02 PM Nick Desaulniers
> > <ndesaulniers@google.com> wrote:
> > >
> > > Ha! I pulled+rebased and this code disappeared...I thought I had
> > > rebased on the wrong branch or committed work to master accidentally.
> > > Patch to stable-only inbound.
> >
> > Side note: for stable, can you look into using _Generic() instead of
> > __builtin_choose_expression() with typeof, or some
> > __builtin_types_compatible_p() magic?
> >
> > Yes, yes, we use __builtin_choose_expression() elsewhere, but we've
> > started using _Generic(), and it's really the more natural model - in
> > addition to being the standard C one.
> >
> > Of course, there may be some reason why _Generic() doesn't work, but
> > it _is_ the natural fit for any "for type X, do Y" kind of thing.
> >
> > No?
>
> Man, c'mon, I just got the __builtin_choose_expression() working! It's
> not...too bad...ish. (Besides, I'd actually have to learn how to use
> _Generic...I've never quite gotten anything I've written trying to use
> it to actually compile).
>
> Do we have access to _Generic in GCC 4.9?

Follow up thread, sorry/not sorry for not taking the full cc list:
https://lore.kernel.org/stable/20210913203201.1844253-1-ndesaulniers@google.com/
-- 
Thanks,
~Nick Desaulniers
