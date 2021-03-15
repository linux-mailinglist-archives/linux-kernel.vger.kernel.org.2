Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C85A633AF7C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 11:02:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbhCOKCQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 06:02:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbhCOKB7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 06:01:59 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A546C061574
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 03:01:58 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id g185so30995509qkf.6
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 03:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h4nyVWQ8u3H2CmvohdpUdT/g1Ns3H/e5opYIRqjRzAk=;
        b=vVzEB3k8ulU6ce5qiAfuHpsDVOsup84jxGxcT9kC+7Gvw0zmPM+40eReDTsFBTGJcz
         migUxren62j1VMGxCZYGTQUfH7o2rAdckblfANMfpOw/2HReP2mqphTySn1brlxMv6+v
         8sdYSTpVaynxa5lixZaNOVHUOW6b5CWjnMqNx0m2FsMiUk1MMYFOq/9XAOvgpCCqiM1c
         +p1uxFN2VI7kj1Fm0PeOmdtxUjW8muYXSCez6QH6JaD6eWa2bCIYLI/O6/8OaO48eZX2
         X4wMwKy9FFibLZhD5GtwAAZQ/yocREPUlgl7cdTcF19W5EAjEaIYN7fyJLOCfyqD5YpF
         63Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h4nyVWQ8u3H2CmvohdpUdT/g1Ns3H/e5opYIRqjRzAk=;
        b=VnwKFzWNL13xjyFSIBC11t3vaJ2iAmFcGcBvA6knLWhf2HTnghmfwwYSij8p/Et3OF
         SLQ5lG81QVAm8qUkbTWN7+nF/EHZWzBVB6Nsj0DwuDik3eGWilMinrD/qAc7tXHzTNRJ
         7yRlq+mPD5zgGytU2/6nHNODs/XP8igI3z1ObU6UTt2WwvfUevGCnddbH/3qulUMwG9f
         GMAZeT8tV7avYmQiPU4TpRruf0kNKySIH3kTpimcIZHuJ6L+XV4ANS/4HLeR4ofVCDr+
         qzfnFFWJWeyS4bEYyANRdxbQo7u9TQWg0P+A2cON9UrwlRAzcQM/pyVlV4b37s1Ih6r7
         3QNw==
X-Gm-Message-State: AOAM5320WDUO2tnVOla9l4WQU2UlIp0gtm3He+Wj/1OGBhbqQ42UDxnq
        8zY4bds979dBjLQofp2GORC2wEs2vm/aezFld3ZerA==
X-Google-Smtp-Source: ABdhPJxc7Mnqhqj/p9e2wAz87w00XYiDOSM8ibr4DZBbgBltgqSN/eUtVAqHij+2zdxwhzwVQMkE/lzS+G7fKE5Utf4=
X-Received: by 2002:a37:96c4:: with SMTP id y187mr25603220qkd.231.1615802517127;
 Mon, 15 Mar 2021 03:01:57 -0700 (PDT)
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
 <CAK8P3a221xG9dM1UZXNGhjkVyxn6sjscSYdsFwWO6CVB_HQhXw@mail.gmail.com> <48347b4d-9194-16f2-95a0-c3eb55ca9a80@huawei.com>
In-Reply-To: <48347b4d-9194-16f2-95a0-c3eb55ca9a80@huawei.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 15 Mar 2021 11:01:45 +0100
Message-ID: <CACT4Y+a58QHkas=5t51Aou9GDHDtjyiGwtruUZgbe-iVmTp0Mw@mail.gmail.com>
Subject: Re: arm64 syzbot instances
To:     John Garry <john.garry@huawei.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        syzkaller <syzkaller@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Maydell <peter.maydell@linaro.org>,
        =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 15, 2021 at 10:45 AM John Garry <john.garry@huawei.com> wrote:
> >> It does not happen too often on syzbot so far, so let's try to do the
> >> right thing first.
> >> I've filed: https://bugs.launchpad.net/qemu/+bug/1918917
> >> with a link to this thread. To be fair, I don't fully understand what
> >> I am talking about, I hope I proxied your description properly.
> >
> > Thanks, looks good. I provided a little more detail in a comment there.
> >
> >          Arnd
> > .
> >
>
>  From looking at the bug report, my impression is that this is a qemu
> issue, as the logical IO space is mapped to the PCI host bridge IO
> space, and qemu does not handle accesses to that CPU addressable region
> at all. As Arnd said.
>
> However, we really should not be accessing logical IO ports 0 or 0x2f8
> at all via ttyS3 if not enumerated from PCI device at that logical IO
> port. That is what I think anyway, as who knows what device - if any -
> really exists at that location. That is why I had this patch to just
> stop accesses to legacy IO port regions on arm64:
>
> https://lore.kernel.org/lkml/1610729929-188490-2-git-send-email-john.garry@huawei.com/

Hi John,

Thanks for the info.

The patch is from January, but it's not merged yet, right?
It will fix the crash we see, right?
