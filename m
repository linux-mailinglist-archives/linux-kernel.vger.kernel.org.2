Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EF7533B00D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 11:35:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbhCOKfL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 06:35:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbhCOKev (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 06:34:51 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E3E7C061574
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 03:34:51 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id h3so7465830qvh.8
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 03:34:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Oj3gkISQvzX18ve66XyOC8TkVVIvr6zfjGYpR+G+oBo=;
        b=gBkZsQIvurZhYsAr2X62O6XOW5n2qf3SIJwCbmE4qRW5OVBPaaYoQojtA5qGv+P4D7
         J5ESkix3Ek+4x+pHemIehDaEiBkO+jsBfUzSni1dLZ70uQPw6ztcJaNwHM3BrVXvFC+H
         nUvZHSOoKZcB/E7ySPrwHUGGjuSaAbngrAysbL/lVTVoWYlRmnQbw7qslyrRfVXO2Nt+
         TPyOtGMPNsCh1Fc9bWCXlAQ7OcYLTOeFjL4bI+qfSQXz4jnb6k1x3DwKgwbUx/YHGAnD
         BjHx3I8WYo7KY0KVcpL4i7BjR/fPTuaeL5WyYo3OpFKgo6Orx+/SyCrNAO37kT5mHRwa
         efxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Oj3gkISQvzX18ve66XyOC8TkVVIvr6zfjGYpR+G+oBo=;
        b=K1WEjK9aBpt1NPXZadwY2p7f5eHf9u2xoGMIFg4er6kkpNId00cUPYdbG4dHJgmSIS
         YaqDaC7Og5Z1vzzj9LuhhRVJCeXzjFzN/Aj7VCvnjYx1qh9O3EzQ1yAnmN5eqn6Zbiek
         21Ei96y4YsCO2oBNK/SDeQqLO1iaUn3Nw3P+ykzl8N9m8wlvdhehV+dZdkC3PXQ23GXK
         F2nLOPRVoWwelzSTZaljf65m5fAlo/xqp17xoit6J/yBQEwwG7z5OH/ZnSyzhCcHPO+J
         XsxHke2zqkMwJMv/x05RfsNImK8CDSNhqA8s9z4L2ihSJner/eDTIkbCjndjKyeaG20t
         DsLA==
X-Gm-Message-State: AOAM532qjPToxrT9L02Yg3SvuXybO6bLfThBJHpbg0fGTQHAhleDix4o
        Zlb0LaqA6jqnGxqmILVhsECjklPeLJMOdBB69HFm0g==
X-Google-Smtp-Source: ABdhPJxFf29UoxS1C+/R78QtvuxEYytHJ78grXVQfeGYp/DCYk5azut2p/Cn0YGp/ujiPOHdLdx40Knvj/RvARBxN3k=
X-Received: by 2002:ad4:410d:: with SMTP id i13mr9792315qvp.44.1615804489956;
 Mon, 15 Mar 2021 03:34:49 -0700 (PDT)
MIME-Version: 1.0
References: <CACT4Y+beyZ7rjmy7im0KdSU-Pcqd4Rud3xsxonBbYVk0wU-B9g@mail.gmail.com>
 <CAK8P3a1xBt6ucpVMhQrw4fGiLDZaJZ4_kn+qy9xAuykRRih6FA@mail.gmail.com>
 <CACT4Y+YeeEkF65O40DMLB=cggiowZUxXDs++BNTrDMO94j=NvA@mail.gmail.com>
 <CAK8P3a0HVu+x0T6+K3d0v1bvU-Pes0F0CSjqm5x=bxFgv5Y3mA@mail.gmail.com>
 <CACT4Y+aWMD283vYMfoGM1fir_fPF7MPqe+vLjaoQD2iZUV4c-A@mail.gmail.com>
 <CAK8P3a2NEcHG+nOUCc6-DPeFKkc-GF-LEOkynhNdgxiXBHdQaw@mail.gmail.com>
 <CACT4Y+bLdCw+nWndwnv6W9=0EhNNxi=n5Zp032hZE1j0QBMkaA@mail.gmail.com>
 <CAK8P3a0yxbeY0z=6EQhvBN8NWF++1Cww4tRaSwrUQFt3A-BMaw@mail.gmail.com>
 <CACT4Y+aTbdE1CeUOgCKLJ3XpjazN5=yTmToXN_03M9EQ_hhayg@mail.gmail.com>
 <CAK8P3a221xG9dM1UZXNGhjkVyxn6sjscSYdsFwWO6CVB_HQhXw@mail.gmail.com>
 <48347b4d-9194-16f2-95a0-c3eb55ca9a80@huawei.com> <CACT4Y+a58QHkas=5t51Aou9GDHDtjyiGwtruUZgbe-iVmTp0Mw@mail.gmail.com>
 <56d33822-e577-c8a8-673b-675d6920c379@huawei.com>
In-Reply-To: <56d33822-e577-c8a8-673b-675d6920c379@huawei.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 15 Mar 2021 11:34:38 +0100
Message-ID: <CACT4Y+YYa9mXtiQ0cqNaWtT0EkhGimJb6mVT+iXwHPAyBRE0Qw@mail.gmail.com>
Subject: Re: arm64 syzbot instances
To:     John Garry <john.garry@huawei.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        syzkaller <syzkaller@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Maydell <peter.maydell@linaro.org>,
        =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
        Jiahui Cen <cenjiahui@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 15, 2021 at 11:31 AM John Garry <john.garry@huawei.com> wrote:
>
> On 15/03/2021 10:01, Dmitry Vyukov wrote:
> > On Mon, Mar 15, 2021 at 10:45 AM John Garry<john.garry@huawei.com>  wrote:
> >>>> It does not happen too often on syzbot so far, so let's try to do the
> >>>> right thing first.
> >>>> I've filed:https://bugs.launchpad.net/qemu/+bug/1918917
> >>>> with a link to this thread. To be fair, I don't fully understand what
> >>>> I am talking about, I hope I proxied your description properly.
> >>> Thanks, looks good. I provided a little more detail in a comment there.
> >>>
> >>>           Arnd
> >>> .
> >>>
> >>   From looking at the bug report, my impression is that this is a qemu
> >> issue, as the logical IO space is mapped to the PCI host bridge IO
> >> space, and qemu does not handle accesses to that CPU addressable region
> >> at all. As Arnd said.
> >>
> >> However, we really should not be accessing logical IO ports 0 or 0x2f8
> >> at all via ttyS3 if not enumerated from PCI device at that logical IO
> >> port. That is what I think anyway, as who knows what device - if any -
> >> really exists at that location. That is why I had this patch to just
> >> stop accesses to legacy IO port regions on arm64:
> >>
> >> https://lore.kernel.org/lkml/1610729929-188490-2-git-send-email-john.garry@huawei.com/
> > Hi John,
> >
> > Thanks for the info.
> >
> > The patch is from January, but it's not merged yet, right?
> > It will fix the crash we see, right?
> > .
>
> It's not merged, and it probably would solve this issue. But following
> discussion with Arnd when it was originally posted, I still need to do
> some analysis whether it is the proper thing to do.

OK, I will tell syzbot about the fixing patch.

> However, as mentioned, the fundamental issue looks like qemu IO port
> access, so it would be good to check that first.

I've filed https://bugs.launchpad.net/qemu/+bug/1918917 for qemu.

> On a related topic, I will cc colleague Jiahui Cen, who I think was
> doing some work arm on qemu support in a related area, so may share some
> experience here.
>
> Jiahui Cen did have a patch to fix logical PIO code from this work [0],
> which is not merged, but I don't think would help here. I will cc you on it.
>
> Thanks,
> John
>
> [0]
> https://lore.kernel.org/lkml/006ad6ce-d6b2-59cb-8209-aca3f6e53fec@huawei.com/
