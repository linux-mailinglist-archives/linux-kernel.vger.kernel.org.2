Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F500415D13
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 13:51:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240697AbhIWLwk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 07:52:40 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:46044
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240636AbhIWLwg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 07:52:36 -0400
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com [209.85.208.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 3E3373F32A
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 11:51:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1632397864;
        bh=wGcNO2IXTBVLJmMzaDNfXw1CRQSpWdqfS3q/Z8Q4M1Y=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=tKMEvmjCEgtN6yyDqe6vn+SRVDXCZIObXIlOxXPPiwI5CwtAhvyR3S9JZg3FZyir5
         8ULqu0ZpQv2vd50OX3mGoLt9fWnrWpiubLy71iPWV/h2Iw6KeLlctjzA0yJNmr0uzX
         uOoG/CvZqyhy4H4qPYwobFjm+nLEnVb4QfAsoWkChJIycj9lbtiodr9y5I71or6NPg
         akWx945NP8CeN2yze3o3xTQlncFLLyprMULW9L6BaIHjknw455xq93Qc0lW4AUBq6N
         PhJSnMx0jvx8AVXpMCXIvvsOzyfGA1AZmWSECHl7mc/V1eNEmnDQOAEzvqsfuosaok
         SCtLi1nNzXA3Q==
Received: by mail-ed1-f72.google.com with SMTP id r23-20020a50d697000000b003d824845066so6528839edi.8
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 04:51:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=wGcNO2IXTBVLJmMzaDNfXw1CRQSpWdqfS3q/Z8Q4M1Y=;
        b=Q2AoRO0tIbWnN0Gpt0NvbXpSCz/RkL1UXLPHT/2creVCqcAUS+S/iWC2neeUPyP4sR
         QISL52b/29EQalRmtdTQu8HJcftiQi+ez9q3ITuN0Rukq33Fj2x1DnII86QmYlI7AAXw
         Dk/5TN4cRMeLkYlOPFpbVICEu+PvoAV14cCbGECnqLTqJTaGOOMWS5lSpZsBCVvuKzUi
         wGSc5FIszWhDGT97Cz1tsYkVstVFH1643MRqYH88lQx1eOqLNmEX1Yc8vYjybNsE1Zek
         eqAiBNn2ICKdYe0kjfG2icgqv2Ip4hCO8twKu3aeS9F9Hu4jB4EAXEm+4VStpmt/UN95
         foWg==
X-Gm-Message-State: AOAM531Z+ksxnScqCaUL4aooXbLa9CezqneUAnlsKsqFeFNhmEwr9pjD
        zJIi9YN+O5H/LFWpbs5+A83n3A+BFvdsgCQyE77/Pv9Ko5nfaG+qeSPUSWgAYW4nWreAfVc8s5E
        OjxTSMqV0H1cH3CvjFtYB9X7ol6/cxOl0k+44tPbJXdpJv+9aXszbAxIXDw==
X-Received: by 2002:aa7:db85:: with SMTP id u5mr4876802edt.234.1632397863961;
        Thu, 23 Sep 2021 04:51:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyzN+eiUB6TLkCud6NtqS90/s5C7jzCEwCWLoZO5rT0CasG/3cmMrbqmMTzSzy8MtmxB9LUuh7ZBIDENSSGBa0=
X-Received: by 2002:aa7:db85:: with SMTP id u5mr4876783edt.234.1632397863817;
 Thu, 23 Sep 2021 04:51:03 -0700 (PDT)
MIME-Version: 1.0
References: <20210923072716.913826-1-guoren@kernel.org> <6d7b1668c1f562a5ef426bb2519f9784@mailhost.ics.forth.gr>
 <CAAhSdy0YDP3Nk8N9fnrKgS+3Rjt=5tLCh20upmUGK9SK67nNvg@mail.gmail.com>
 <0861cc74d3886e685e9aa5d13ddcd781@mailhost.ics.forth.gr> <16de95480d279b086cf0c612461e4235@mailhost.ics.forth.gr>
 <CAAeLtUDu0yaDBcuC06nX1WUQC9k4eNuWjvAFrpkP_h0nf5BZAw@mail.gmail.com> <88696248a0c19a5dff660354b837514d@mailhost.ics.forth.gr>
In-Reply-To: <88696248a0c19a5dff660354b837514d@mailhost.ics.forth.gr>
From:   Alexandre Ghiti <alexandre.ghiti@canonical.com>
Date:   Thu, 23 Sep 2021 13:50:52 +0200
Message-ID: <CA+zEjCsO2CyhrfGGA4ceAH=LBOyqWF4U7F91VheTdr6wEJj1pw@mail.gmail.com>
Subject: Re: [PATCH] riscv: Add RISC-V svpbmt extension
To:     Nick Kossifidis <mick@ics.forth.gr>
Cc:     Philipp Tomsich <philipp.tomsich@vrull.eu>,
        Anup Patel <anup@brainfault.org>, Guo Ren <guoren@kernel.org>,
        Anup Patel <anup.patel@wdc.com>,
        Atish Patra <atish.patra@wdc.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        =?UTF-8?Q?Christoph_M=C3=BCllner?= <christoph.muellner@vrull.eu>,
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
        Greg Favor <gfavor@ventanamicro.com>,
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

On Thu, Sep 23, 2021 at 12:11 PM Nick Kossifidis <mick@ics.forth.gr> wrote:
>
> =CE=A3=CF=84=CE=B9=CF=82 2021-09-23 13:04, Philipp Tomsich =CE=AD=CE=B3=
=CF=81=CE=B1=CF=88=CE=B5:
> >
> > How if we expand this to a mmu subnode in cpu@x and add a booleans for
> > adornments like svnapot and svpbmt?
> > The older mmu-type could then treated to indicate a mmu w/o any
> > adornments specified.  I am aware that this generates an additional
> > parsing-path that will be maintained, but it will allow future
> > properties to be grouped.
> >
> > cpu@0 {
> > ...
> > mmu {
> > type =3D "riscv,sv39";
> > supports-svpbmt;
> > }
> > ...
> > }
>
> I was about to propose the same thing, we can do this now without
> breaking backwards compatibility, we don't really use mmu-type property
> at this point, we are either sv39 or nommu.

Indeed, this property is only informative and not useful since we can
directly "ask" the hw what it supports (cf sv48 patchset). And it
cannot actually be used to force a certain svXX since reading the
device tree happens way too late in the boot process (I have this
issue with my sv48 patchset where I used to read the device tree to
set the size of the address space, but it actually breaks KASAN).

Isn't there a way to know if it supports svPBMT at runtime?

Alex

>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
