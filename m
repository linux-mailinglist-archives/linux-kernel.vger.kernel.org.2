Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BB1031C40F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Feb 2021 23:31:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229745AbhBOWai (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Feb 2021 17:30:38 -0500
Received: from mail-ej1-f51.google.com ([209.85.218.51]:40069 "EHLO
        mail-ej1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbhBOWag (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Feb 2021 17:30:36 -0500
Received: by mail-ej1-f51.google.com with SMTP id b14so7725420eju.7
        for <linux-kernel@vger.kernel.org>; Mon, 15 Feb 2021 14:30:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=05sKoXexSadkBXq5ZLjKbpzzvxIWvEZ9WIX+KtkpeFk=;
        b=hbEm1biyfMPQ9xoQ/26FfJzhfO5zc00EskdHHaT7wcWjPapSTYbJ+2p38X78sho2Zc
         ZSF8Y2wdnem5naK4FiKeqj4nQdJ/XRIxIT6vyUD/QuH0nmThAd1x29pG+TBitmMvaifh
         vA86bOc/XNw7W0I0uFIN9cOry/+MisZf1khg7bpn2gLXxMen+X/5yzs/XF6LTwFWuGjg
         AEXDBQTiGrf8dWpsicuKBc4Qlr7TPLAQSN6myNk3xdXXWmemFFTiBtq7sxDZa2MGvWkX
         39J+cYJgU4gccTpFiyYEUrNNDjLOWWZMWK0oNeDrwsB2K/mYVSbroOhR8lreknwFvgVp
         bojA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=05sKoXexSadkBXq5ZLjKbpzzvxIWvEZ9WIX+KtkpeFk=;
        b=XaokAtJ6uKbttdT9kckRD4mGxdYQsKcPDyyuYSzjoDJMR/3G8znckh6C3n02m/slXB
         lCdACLzQuSdTjvBbIUsiai/6efFwhceImgZ+kGWM+vs6CmmMCXkveudOO0tKE6CqW65x
         gUQmHCFwlsDI+HFlKpREjyZwOJOUxbR9MpNZwHkqlrZBEWAjk6XgbKmRQ8c3k3Rnq9qg
         afUL4y3LDvLd3wHB2Og+p5Cn8z6D6oE8DzPluyVpQxtvuzzUZ0VPqZoyHB0uDYQjNqbn
         A8IKBH7WuRwX/xRs09fmUIGYjx3K1JDSTtLZqgfh/u9juZweJry4HW6YzHKYdCwcOipb
         aAag==
X-Gm-Message-State: AOAM533exvKwPis4UyUI4cCcRhxg0LgrvCDRxiy6wiWXgjzy9g66Htv8
        d+SY2h8HMiqsugN6VFyfVwX2a7bfBPbHhHqC74ugGQ==
X-Google-Smtp-Source: ABdhPJwo6M51ZPNwR1JeEZZAoGD7aJzC15GZYcmvrLuRs7Mg0ECy/y7xCy7b9S+7FWMZGLydULUFXPaiPHns2xt4ags=
X-Received: by 2002:a17:906:f1d0:: with SMTP id gx16mr9784520ejb.383.1613428134360;
 Mon, 15 Feb 2021 14:28:54 -0800 (PST)
MIME-Version: 1.0
References: <20210215192237.362706-1-pasha.tatashin@soleen.com>
 <20210215192237.362706-2-pasha.tatashin@soleen.com> <CAMj1kXGxyV0=s6jVZ674O_2amkYSnwSnubnozbzD6g6GOMJE-A@mail.gmail.com>
 <CA+CK2bA7Xz0Zg5phsQi3mhnp+_PHLAAGRLgFTQNw1FjBHaXsHA@mail.gmail.com>
 <CAMj1kXESuD-von_dtzYcUMwK7TLF=qTki9bd8_iTo_isBwj13g@mail.gmail.com> <CA+CK2bDJ7Y2-vEpZrZ0fzigAfDgcJOmjhmin_GjTqioYXAYB3Q@mail.gmail.com>
In-Reply-To: <CA+CK2bDJ7Y2-vEpZrZ0fzigAfDgcJOmjhmin_GjTqioYXAYB3Q@mail.gmail.com>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Mon, 15 Feb 2021 17:28:18 -0500
Message-ID: <CA+CK2bDX9X+SdHOB=dd2kvsYfQwPvhuVNRByZW8sENuzuHRZyQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] arm64: mm: correct the inside linear map
 boundaries during hotplug check
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Tyler Hicks <tyhicks@linux.microsoft.com>,
        James Morris <jmorris@namei.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Mike Rapoport <rppt@kernel.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> >
> > Btw, the KASLR check is incorrect: memstart_addr could also be
> > negative when running the 52-bit VA kernel on hardware that is only
> > 48-bit VA capable.
>
> Good point!
>
> if (IS_ENABLED(CONFIG_ARM64_VA_BITS_52) && (vabits_actual != 52))
>     memstart_addr -= _PAGE_OFFSET(48) - _PAGE_OFFSET(52);
>
> So, I will remove IS_ENABLED(CONFIG_RANDOMIZE_BASE) again.

Hi Ard,

Actually, looking more at this, I do not see how with 52VA on a 48VA
processor start offset can become negative unless randomization is
involved.
The start of the linear map will point to the first physical address
that is reported by memblock_start_of_DRAM(). However, memstart_addr
will be negative. So, I think the current approach using
IS_ENABLED(CONFIG_RANDOMIZE_BASE) is good.

48VA processor with VA_BITS_48:
memstart_addr 40000000
start_linear_pa 40000000
end_linear_pa 80003fffffff

48VA processor with VA_BITS_52:
memstart_addr fff1000040000000   <- Negative
start_linear_pa 40000000  <- positive, and the first PA address
end_linear_pa 80003fffffff

Thank you,
Pasha
