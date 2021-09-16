Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92F1540D104
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 02:49:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233463AbhIPAub (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 20:50:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:49228 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233405AbhIPAua (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 20:50:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 78A9761186
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 00:49:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631753350;
        bh=0fKIb1wSJtzBX6f3dXc+/Xbaxxti6nBaEoOdmYLZUIk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=WCvnczTQPx2dh1r9Q2ZKG5wBOfjDM8AxcKQHwq5bUKOcy/kF4rvxBJv9Tn/T9Gjll
         ysjVntR1bAPllMoGBE0Lr6QgPig14HlVYVgp4mglTOu9sBKg5WDY5nKghhUsUirveX
         vd5/OfJ1mUx3hbzdHVLGy/9JYEQSiw0OyTq3vdGuPJDgqY2g1oPdgU9/gqB61SsQtV
         jAAZtlLKseywDxOGO04SYZAr1mzmLV+5H8ndbtuc8u275zUs69aBO1NdetVUkP6ccS
         L/PeQEd0lIMjohnGzF1Q6nStfu//tF+xGPVO0qq6XbFW6ZNXQ3lmqmMk5oZp8Eyxxw
         YnJIHB/CLVcvw==
Received: by mail-lf1-f49.google.com with SMTP id b18so10350207lfb.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 17:49:10 -0700 (PDT)
X-Gm-Message-State: AOAM531j3X+9DqErtb0Oyqdf7XloCwknjDsOtZKQQetaZLfW4tPSzDPg
        Gi9w4YhRJr76rG7pMWgoNW0XS08T12tb2oB3RYM=
X-Google-Smtp-Source: ABdhPJwZWPa7mrnasG5fOmbf2PwdvOe0X12pKkbc9DRuVQ2YmRoDJWly+mMIvlfW0LUkmJZBCBhrPIVa0wvTyC+zIME=
X-Received: by 2002:a2e:3307:: with SMTP id d7mr2546833ljc.292.1631753348776;
 Wed, 15 Sep 2021 17:49:08 -0700 (PDT)
MIME-Version: 1.0
References: <20210911092139.79607-1-guoren@kernel.org> <20210911092139.79607-3-guoren@kernel.org>
 <20210915074727.GB20024@lst.de>
In-Reply-To: <20210915074727.GB20024@lst.de>
From:   Guo Ren <guoren@kernel.org>
Date:   Thu, 16 Sep 2021 08:48:57 +0800
X-Gmail-Original-Message-ID: <CAJF2gTSHvm5h8ZjB40jnCpT15YxA1eanMO8kghRbLWV1xqv9jg@mail.gmail.com>
Message-ID: <CAJF2gTSHvm5h8ZjB40jnCpT15YxA1eanMO8kghRbLWV1xqv9jg@mail.gmail.com>
Subject: Re: [RFC PATCH V4 2/6] riscv: errata: pgtable: Add custom Svpbmt
 supported for Allwinner D1
To:     Christoph Hellwig <hch@lst.de>
Cc:     Anup Patel <anup.patel@wdc.com>, Atish Patra <atish.patra@wdc.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        =?UTF-8?Q?Christoph_M=C3=BCllner?= <christoph.muellner@vrull.eu>,
        Philipp Tomsich <philipp.tomsich@vrull.eu>,
        liush <liush@allwinnertech.com>, wefu@redhat.com,
        =?UTF-8?B?V2VpIFd1ICjlkLTkvJ8p?= <lazyparser@gmail.com>,
        Drew Fustini <drew@beagleboard.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        taiten.peng@canonical.com, aniket.ponkshe@canonical.com,
        heinrich.schuchardt@canonical.com, gordan.markus@canonical.com,
        Guo Ren <guoren@linux.alibaba.com>,
        Arnd Bergmann <arnd@arndb.de>, Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <maxime@cerno.tech>,
        Daniel Lustig <dlustig@nvidia.com>,
        Greg Favor <gfavor@ventanamicro.com>,
        Andrea Mondelli <andrea.mondelli@huawei.com>,
        Jonathan Behrens <behrensj@mit.edu>,
        Xinhaoqu <xinhaoqu@huawei.com>,
        Bill Huffman <huffman@cadence.com>,
        Nick Kossifidis <mick@ics.forth.gr>,
        Allen Baum <allen.baum@esperantotech.com>,
        Josh Scheid <jscheid@ventanamicro.com>,
        Richard Trauben <rtrauben@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 15, 2021 at 3:47 PM Christoph Hellwig <hch@lst.de> wrote:
>
> This is the wrong way around.  We need to design around the PBMT
> definitions.
I've defined them in arch/riscv/include/asm/pgtable-bits.h first, that
follow current latest draft. Then I undefine them in
errata/thead/errata.c to illustrate we should follow standard PBMT,
not a custom one.

> If we want to hack in support for completely broken SOCs
> that intentionally violate the specification it should be done after
> the fact,
When c9xx was released in 2018, there is no clear direction for how to
solve the non-coherent problem. We just thought PBMT is the correct
direction, but we can't predict how encoding exactly in the highest
bits. (Maybe we should keep the highest bits zero for _P/SXXX in
pgtable.h, but it was really hard to guess at that time.) So don't
imply we "intentionally" here! When the svpbmt is frozen in the
future, we would follow that in our next-generation processor.

> in a separate patch, using alternatives and clearly documenting
> how broken these SOCs are.
Okay, I would separate errata into another patch.

About documenting, I've illustrated c9xx PTE format's detail and using
undef _PAGE_XXX to show that we replaced standard's in errata:

+/*
+ * T-HEAD C9xx PTE format:
+ * | 63 | 62 | 61 | 60 | 59-8 | 7 | 6 | 5 | 4 | 3 | 2 | 1 | 0
+ *   SO   C    B    SH   RSW    D   A   G   U   X   W   R   V
+ *   ^    ^    ^    ^    ^
+ * BIT(63): SO - Strong Order
+ * BIT(62): C  - Cacheable
+ * BIT(61): B  - Bufferable
+ * BIT(60): SH - Shareable
+ *
+ * MT_MASK : [63 - 59]
+ * MT_PMA  : C + SH
+ * MT_NC   : (none)
+ * MT_IO   : SO
+ */
+#undef _PAGE_MT_MASK
+#undef _PAGE_MT_PMA
+#undef _PAGE_MT_NC
+#undef _PAGE_MT_IO
+
+#define _PAGE_MT_MASK  0xf800000000000000
+#define _PAGE_MT_PMA   0x5000000000000000
+#define _PAGE_MT_NC    0x0
+#define _PAGE_MT_IO    0x8000000000000000
+#endif


-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
