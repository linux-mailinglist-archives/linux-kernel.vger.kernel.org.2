Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA18C41A8B3
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 08:14:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238815AbhI1GQg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 02:16:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234543AbhI1GQd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 02:16:33 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 295A0C061575
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 23:14:54 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id u32so8667565ybd.9
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 23:14:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Xl0BfBGgxrV775K+OAAR9ROcoUMbviR83515iJHs9Pg=;
        b=ZiY2B+kaLqTnRMorpc1rM8lvjhYPPwu0524KzOYs7ONOS0oWDg8M6W4k9uWwhCtdRF
         m0CorqPXNUqxOQoT1Mk5EEviGajopuysCX6L2FoqEi9R722Sb/9j396aesS7T0ZESy7q
         0h3anQ6wOSc1GsuDYvbe1hfFqZjo6wuVSGfag=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Xl0BfBGgxrV775K+OAAR9ROcoUMbviR83515iJHs9Pg=;
        b=SI/nZawoyZe1g/sIDfHyVH3SxrygDI8XUCcR0m3EjMPkmDpWuODytK2+aOdYtpXRAL
         sbFwERwb4oLhtH3A2wn0I328si0qQxLsKiquw09/oDpQ41WiDaGC6rXE6bhAFAQG1sKN
         osnknLGsoMkiVYPPT1PNzQTPpHY/rkRbEaS4Qr2eBX7nkkuh+CVvMTnD3G5oA/rRKmJp
         0eJyO0tGScbUupJjSPtI8H+nH4SOAj+7MAnoCpmyx/ehKXK7kgvDsxpBuAQlbiIjti5s
         Ghn6vZcnTqffOQbjTWTaA2SSAHUtf5laKZOu/OVOnsrYoDWkB6HhG761L2uQnqxvdRQn
         tqlg==
X-Gm-Message-State: AOAM5315zmBk/lA4FaO8eIF3zwzJl4hNyDFJMqlTvEwyGn9vo/Gyhz/F
        /l9hPrd4q3E6577qYUZPI5MXvoIw5rj2ZE/mMGbS
X-Google-Smtp-Source: ABdhPJzjnD/7v7qxbp+vpteOKkEmbYlUJ9dcmK8qoIOObjDqP29xq3zKWgGXI6UIcxGi99anDY4+a1jEM5Shobp6S1s=
X-Received: by 2002:a05:6902:1549:: with SMTP id r9mr5059591ybu.204.1632809693291;
 Mon, 27 Sep 2021 23:14:53 -0700 (PDT)
MIME-Version: 1.0
References: <20210923172107.1117604-1-guoren@kernel.org> <CAOnJCUJWnDB+uRxDh=YSbGW4bf5RQvke03iCTYMYHPsw3cwnHQ@mail.gmail.com>
 <CAOnJCULrE595ex3gBTnu4GnPazO4mg8Tkrtbv6j8iLWe+sKJSA@mail.gmail.com>
 <0790abcfa1174e0e9b5e7b185f87ced9@mailhost.ics.forth.gr> <CAAhSdy2-y4xpM9PCrS0vgCN9ngFiBygeDOWcbgsX6Myb4XjDQg@mail.gmail.com>
 <CAOnJCULg36kNiDV6ymTSRff8yYZvFKpxm5uh=cAicQT44OcLYw@mail.gmail.com> <CA+Qh7T=p4+p0c8XF4YiVaCmc--HtjTLdn6=YNa4SBb8yZk2maA@mail.gmail.com>
In-Reply-To: <CA+Qh7T=p4+p0c8XF4YiVaCmc--HtjTLdn6=YNa4SBb8yZk2maA@mail.gmail.com>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Mon, 27 Sep 2021 23:14:42 -0700
Message-ID: <CAOnJCU+tw1Lsjk8YvNumz0nztT+7p9KppufyTc5JZudi6krKwg@mail.gmail.com>
Subject: Re: [PATCH V2 1/2] riscv: Add RISC-V svpbmt extension
To:     Greg Favor <gfavor@ventanamicro.com>
Cc:     Anup Patel <anup@brainfault.org>,
        Nick Kossifidis <mick@ics.forth.gr>,
        Guo Ren <guoren@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Anup Patel <anup.patel@wdc.com>,
        Atish Patra <atish.patra@wdc.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        =?UTF-8?Q?Christoph_M=C3=BCllner?= <christoph.muellner@vrull.eu>,
        Philipp Tomsich <philipp.tomsich@vrull.eu>,
        Christoph Hellwig <hch@lst.de>,
        liush <liush@allwinnertech.com>, wefu@redhat.com,
        =?UTF-8?B?V2VpIFd1ICjlkLTkvJ8p?= <lazyparser@gmail.com>,
        Drew Fustini <drew@beagleboard.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        taiten.peng@canonical.com,
        Aniket Ponkshe <aniket.ponkshe@canonical.com>,
        Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
        Gordan Markus <gordan.markus@canonical.com>,
        Guo Ren <guoren@linux.alibaba.com>,
        Arnd Bergmann <arnd@arndb.de>, Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <maxime@cerno.tech>,
        Daniel Lustig <dlustig@nvidia.com>,
        Andrea Mondelli <andrea.mondelli@huawei.com>,
        Jonathan Behrens <behrensj@mit.edu>,
        Xinhaoqu <xinhaoqu@huawei.com>,
        Bill Huffman <huffman@cadence.com>,
        Allen Baum <allen.baum@esperantotech.com>,
        Josh Scheid <jscheid@ventanamicro.com>,
        Richard Trauben <rtrauben@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 27, 2021 at 9:49 PM Greg Favor <gfavor@ventanamicro.com> wrote:
>
> On Mon, Sep 27, 2021 at 9:26 PM Atish Patra <atishp@atishpatra.org> wrote=
:
>>
>> IMHO, if we want to support this board in upstream, we should just
>> clearly state that it is one time special exception
>> for this board only because of the following reasons
>
>
> I'm not quite following what the exception is?  If RVI's policy is follow=
ed for how software support for custom extensions (which D1 falls under) sh=
ould be handled (as part of allowing such software to be upstreamed), then =
that doesn't burden standard distros nor the community to maintain ongoing =
support.

I am a bit confused. As per our understanding, D1 doesn't fall under
custom extensions because they have non-standard conflicting
implementations of the PTE bits that violate the privilege
specification (v1.12 with svpbmt & svnapot extension merged).
Custom extensions can only be defined via satp mode (14-15). Am I
missing something?

>  And this doesn't stop a custom Linux build from being provided to users =
of the D1 board (like what any other vendor would need to do to support the=
 custom extensions on their hardware).

A custom Linux build is already floating around for the users for the
D1 board. Whether the upstream mainline kernel supports this board is
the key question here.

>
> Or are you proposing that standard binary distros would have to support D=
1's custom extension?  (And how would that even work if and when Svpbmt bec=
omes required in some rev of the OS-A platform spec - at which point the D1=
 boards have a nonconforming extension that can't be disabled and thus conf=
licts with required (Svpbmt) functionality?)

I was suggesting to support D1 in the unified kernel image built from
defconfig only if we decide to support it.
standard binary distros(such as Fedora, RHEL, Suse, Ubuntu) anyways
use custom config. They can always disable support for D1 if they want
it.

>
> Greg
>
>>
>>
>> 1. The board design predates the patch acceptance policy.
>> 2. We don't have enough affordable Linux compatible platforms today.
>> 3. Allowing running an upstream kernel on D1 helps the RISC-V software
>> ecosystem to grow.
>>
>> No more exceptions will be allowed in future for such hardware that
>> violates the spec. Period.
>>
>> > Regards,
>> > Anup
>>
>>
>>
>> --
>> Regards,
>> Atish



--
Regards,
Atish
