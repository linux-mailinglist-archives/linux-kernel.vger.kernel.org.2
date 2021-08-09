Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 862FA3E4858
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 17:08:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235438AbhHIPIz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 11:08:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235384AbhHIPIx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 11:08:53 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07846C0613D3
        for <linux-kernel@vger.kernel.org>; Mon,  9 Aug 2021 08:08:33 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id y7so13151671ljp.3
        for <linux-kernel@vger.kernel.org>; Mon, 09 Aug 2021 08:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4pSL+H253Ict/PkeJDTxt/nIlNW4DtN6RkcuEgCb2gU=;
        b=ryP4oz/7EDpIny7jdj8ksJtw7QouRLionXxy6Sea7BLn3DesSj2vNxjphZLhlyNsyO
         P4RnY5E36yMMrF4epKJ+cjtu49yP3NBgFeOYUw4e5B6NbI9O7lM806FdiXmbve7JiO9J
         DQ5Ekq0H9PkbO82SANEtb1ZM4c6U/67cW9teeWN+SrANGrfJv4rCCQ60OfZSjEl9I93j
         8ZAbmCP+aaQzUZtNG27L1PdLYn56Q2fFQgNUTiGVY397lUKBsAK1qK4KTESlQuouMsNK
         hdBw5MuGnrIVAg0ulZHrOQqd6J2N0oWj9fyze7FR1NgFkqZVw7DNlvvVlNKuCzwOnTUM
         gLzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4pSL+H253Ict/PkeJDTxt/nIlNW4DtN6RkcuEgCb2gU=;
        b=mmxSZ+w8bHcdaioziF1gKkv9BvVZ2tY29yeXGQAa/5JCNGYv2XW6pc3GYHDt+5RmJu
         F+xb0eySkDYWj1zMuvs2Foc/9RYmqDI1jEf/0/zZgdjuBy5dp5to44ubE50+6JebdCjA
         UPstqaBeK006rYwsiaK5gFoPfIN9VylaLftu7eHrmd+QYsRSHxrCl+Av3H3DT+VGbs9C
         XOooABiCfGMud522tOk5Rf508XrsTb9W4K71E7NaTue0t1psFz7ZiVcyyXv2naevEero
         VvHbwFSVOh+yjbOD0RY08Al6ltnXW4mS9iuar5w9RoTPspJ6fPKafuZRIktoBLNpmcvZ
         hG2g==
X-Gm-Message-State: AOAM532ljORwGUZLKEgutI2XPKSJBi36rJlgnIH+LKBOs50T4nxyHkpq
        VcJU0eXLuo3LZBNIzUAfHPxRGj7qhkwvXuzyJfSDuFHkVt0=
X-Google-Smtp-Source: ABdhPJxOLDDKtcUBcb2EFrLzlzZsTQC0lp+4wH7Wx6Gr8wvInMrxfcs/YhKM+C0Ep3We7rvsxlwCZESqig9d6FVRyRo=
X-Received: by 2002:a2e:bd81:: with SMTP id o1mr15947630ljq.65.1628521710495;
 Mon, 09 Aug 2021 08:08:30 -0700 (PDT)
MIME-Version: 1.0
References: <20210807191428.3488948-1-oupton@google.com> <CACRpkdYPEGygxAtU8jrCtnJsQr_JoYkBCRGpRFpvxGiOzUmxgg@mail.gmail.com>
 <CAOQ_QsiECN7iVDyiyos12tk__viGkFhH9b6ZfkZVAYjeKhB=pQ@mail.gmail.com>
 <87lf5c1aox.wl-maz@kernel.org> <CAOQ_Qsi-r0=YubmaTezB7Cq-RhzU3njWm+P5w-RWZcUz4kMfDA@mail.gmail.com>
 <87mtpqc2wz.wl-maz@kernel.org>
In-Reply-To: <87mtpqc2wz.wl-maz@kernel.org>
From:   Oliver Upton <oupton@google.com>
Date:   Mon, 9 Aug 2021 08:08:19 -0700
Message-ID: <CAOQ_QsiKttAwrGKuXKHmuXac4ANaJd79KNQAFwuD6h_VztJu+A@mail.gmail.com>
Subject: Re: [PATCH v2] clocksource/arm_arch_timer: Fix masking for high freq counters
To:     Marc Zyngier <maz@kernel.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Shier <pshier@google.com>,
        Raghavendra Rao Ananta <rananta@google.com>,
        Ricardo Koller <ricarkol@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 9, 2021 at 3:45 AM Marc Zyngier <maz@kernel.org> wrote:
> > On that note, I wonder how (if ever) we will be able to move away from
> > unnecessarily masking a 64 bit counter, i.e. a v8.6 or above
> > implementation. With this patch, one such counter would wrap after
> > 36.56 years, short of the 40 year guarantee we have from the
> > architecture for < v8.6 implementations. Getting it to 64 bits would
> > squarely make it someone else's problem ~585 years from now :)
>
> Hmmm. If you end-up with something that falls short of 40 years, then
> I suspect something is wrong in the way you compute the required
> width.
>
> 40 years @1GHz (which we shall call FY1G from now on) fits comfortably
> in 61 bits, and I fear that your use of ilog2() gives you one less bit
> than what it should be:
>
> log2(FY1G) ~= 60.13

Right, this is round-down behavior was deliberate. Reading the ARM ARM
D11.1.2 'The system counter', I did not find any language that
suggested the counter saturates the register width before rolling
over. So, it may be paranoid, but I presumed it to be safer to wrap
within the guaranteed interval rather than assume the sanity of the
system counter implementation. That being said, fine with rounding up
instead, so long as we don't believe there's any chance of hardware
doing something crazy.

--
Thanks,
Oliver
> Thanks,
>
>         M.
>
> --
> Without deviation from the norm, progress is not possible.
