Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4237447201
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Nov 2021 08:24:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234887AbhKGH0C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Nov 2021 02:26:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:56471 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234856AbhKGH0B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Nov 2021 02:26:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636269798;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3RtXOitkDbgmdNskpNGQcKeBZZxTugWOTNvXI1LA5eE=;
        b=YPgsXdH8p1shZUdjF2EZQH3hVc0RUjG6mKLOF1gBr1j0TNP8BuVi53gx0cs6/o6t33VEAK
        nmhzwK7QRRRrR31OvHp2g+aWqtwXBy/YZtpskN2B6FMT6JFWplF3RC7WhwpQd+W7FCRkrs
        KS0K8Mn98kjyCM1t20ErdXgh6aG1oag=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-325-AYe3rI45PIeP6rDoYUTcMw-1; Sun, 07 Nov 2021 02:23:16 -0500
X-MC-Unique: AYe3rI45PIeP6rDoYUTcMw-1
Received: by mail-ed1-f70.google.com with SMTP id z21-20020a05640240d500b003e3340a215aso1409379edb.10
        for <linux-kernel@vger.kernel.org>; Sun, 07 Nov 2021 00:23:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3RtXOitkDbgmdNskpNGQcKeBZZxTugWOTNvXI1LA5eE=;
        b=fGT4YgwRG08nvZuvG8Z2bLveETvmgsgqrAaC5D2I+MNtKREHsaNAKljGXjqeG9f2oF
         O38inrVGtYfPSd8sYPibZMRPwCV+f/qIWspgWrmi9ChhnZh4A4ZUybOH1rHvmDKW3Uho
         /OWlLHmHH/5ogyIj7u5iReaz3z56ny5KJ83g88GLMbJJEEM6KF4Mfyn4hl65jfS+k1mv
         Ejg3vE/7q4GuO798I8+AOsAyOCF/W+ODhJm2uIc+sHpk+MO+W9MZ5nctyigf6imYa71Y
         oJ8qSVu5S3cnf8Pl0uCPbr26wMna/cy/tDDiwAOKufG0Z5YkNZenEr2CFAW6HpCrRYM3
         xWjA==
X-Gm-Message-State: AOAM533snbM32Yx5HHFvKSi8m17nWqwSY2tCOOUzlXZglzcJGLYErTP6
        lCCvyITGadjiab8lQjOeqdx6L7uW/NJ2c2L68hTefPgWZ5lhx3nfhcqT+PH6LuxX4C7lRmF525X
        0SvMdImknGcjrP98MtvXrr+3IONkoJdCgGtlCtI11
X-Received: by 2002:a17:906:38db:: with SMTP id r27mr85071573ejd.338.1636269795647;
        Sun, 07 Nov 2021 00:23:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzc1hDrt/xpwiHiY5HIv5cMTET4wPhXlkE0U9ViPpgyODZ9hbdRxlZZsANe0jpLXhSz8/oNdv2YoMc9tNBgi2M=
X-Received: by 2002:a17:906:38db:: with SMTP id r27mr85071546ejd.338.1636269795503;
 Sun, 07 Nov 2021 00:23:15 -0700 (PDT)
MIME-Version: 1.0
References: <20211025040607.92786-1-wefu@redhat.com> <20211025040607.92786-3-wefu@redhat.com>
 <YXZU/3/YmRGFrOXK@infradead.org> <CA+YCwKkX64A8p9vfLJHC3+LqOWyDg99eDBR0mjfB=H45BOyJLQ@mail.gmail.com>
 <20211102060734.GB27015@lst.de>
In-Reply-To: <20211102060734.GB27015@lst.de>
From:   Wei Fu <wefu@redhat.com>
Date:   Sun, 7 Nov 2021 15:23:00 +0800
Message-ID: <CA+YCwKntSMv56zFP9wzysbQAWixDGA1R4Nyrmhc4Tn=_Byc+TQ@mail.gmail.com>
Subject: Re: [RESEND PATCH V3 2/2] riscv: add RISC-V Svpbmt extension supports
To:     Christoph Hellwig <hch@lst.de>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Anup Patel <anup.patel@wdc.com>,
        Atish Patra <atish.patra@wdc.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Guo Ren <guoren@kernel.org>,
        =?UTF-8?Q?Christoph_M=C3=BCllner?= <christoph.muellner@vrull.eu>,
        Philipp Tomsich <philipp.tomsich@vrull.eu>,
        Liu Shaohua <liush@allwinnertech.com>,
        =?UTF-8?B?V2VpIFd1ICjlkLTkvJ8p?= <lazyparser@gmail.com>,
        Drew Fustini <drew@beagleboard.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
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
        Nick Kossifidis <mick@ics.forth.gr>,
        Allen Baum <allen.baum@esperantotech.com>,
        Josh Scheid <jscheid@ventanamicro.com>,
        Richard Trauben <rtrauben@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chistoph,

On Tue, Nov 2, 2021 at 2:07 PM Christoph Hellwig <hch@lst.de> wrote:
>
> On Mon, Oct 25, 2021 at 06:55:09PM +0800, Wei Fu wrote:
> > How about this macro:
> > #define _SVPBMT_PMA         0x0UL
> > #define _SVPBMT_NC         BIT(61)
> > #define _SVPBMT_IO         BIT(62)
> > #define _SVPBMT_MASK         GENMASK(62, 61)
>
> Personally I find these macros highly confusing.
>
> #define _SVPBMT_PMA     0UL
> #define _SVPBMT_NC      (1UL << 61)
> #define _SVPBMT_IO      (1UL << 62).
> #define _SVPBMT_MASK    (_SVPBMT_NC  | _SVPBMT_IO)
>
> is much eaier to follow.  Note that we can probably just drop
> _SVPBMT_PMA entirely to make this even more readable.

sure, I can do this , thanks

>
> > > Also why not use the standard names for these _PAGE bits used by
> > > most other architectures?
> >
> > Which names are you suggesting? Would you mind providing an example ?
> > _PAGE_BIT_   for _PAGE_KERNEL_ ??
>
> Use _PAGE_NOCACHE for _SVPBMT_NC, and _PAGE_IO for _SVPBMT_IO.

OK, Sure , will do

Great thanks

>

