Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E50793FE686
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 02:34:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242156AbhIBATo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 20:19:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:49640 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229898AbhIBATm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 20:19:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0A56B610A4;
        Thu,  2 Sep 2021 00:18:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630541925;
        bh=wTvLeD55f/+cT30LFk/ZUgKiLqiOwst0EprdgeqjHco=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=W5rwDc+WtZTjMsZXQP/vmM2B3QxWtYh7u9gR9LKrnv82l4ifBZGyKEdYZflIPoB9y
         AcJyT5lvGIvbGECjfQlSYMDiUU9a5sB9T/2jIGwQGqzO4xziNiOht9eit/OXdkguxL
         ZDDLv13iCfD4wNvXdYVmnAWnBfqNbCRZHHLHiAxf47tKeDFtY11ANr6ITf78eI4cfT
         hmPflu3jjKeL8PvSMKw8auBs+yWRCXAUN2ziNB55jpVTNQ1mAnO/ObS1glGL6CvWo3
         yP7BJU1zq/eidcYqFI31XR/gwo6UUKHs4KGMPfuIDnPIDRA4H/jcffFhWCXdiE59pn
         OjC6jZuiyR8xw==
Received: by mail-ed1-f54.google.com with SMTP id g22so115702edy.12;
        Wed, 01 Sep 2021 17:18:44 -0700 (PDT)
X-Gm-Message-State: AOAM530MIS7GEOs6WsOx+vEsjQNPCRuUvq4diG4HdzZfyd6NRL9IqBEt
        3ooMgPuhveY70H5VyTWsxUN2OnJqKtKeb3g88Q==
X-Google-Smtp-Source: ABdhPJw/7oq9uNIa4Chpq9FqQ2f/nRpfYy4Edcpxq276fzkXwPouM5aTdUgqjj1eGflUgkM8vSZ7aYo8+GzJ6W4bfGM=
X-Received: by 2002:a50:9b52:: with SMTP id a18mr586841edj.165.1630541923672;
 Wed, 01 Sep 2021 17:18:43 -0700 (PDT)
MIME-Version: 1.0
References: <20210830041729.237252-1-anup.patel@wdc.com> <20210830041729.237252-7-anup.patel@wdc.com>
 <YS7Xk/Np2yc1/wrb@robh.at.kernel.org> <CAAhSdy2e8bPXkTodpbtNeEVX-iCxVeyNLYBkL0aCQBZ7wbSCzw@mail.gmail.com>
In-Reply-To: <CAAhSdy2e8bPXkTodpbtNeEVX-iCxVeyNLYBkL0aCQBZ7wbSCzw@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 1 Sep 2021 19:18:32 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJ_Uc5UqCFojUYioXYJycbcBCF-nGryJiTMkhkN5MJhpw@mail.gmail.com>
Message-ID: <CAL_JsqJ_Uc5UqCFojUYioXYJycbcBCF-nGryJiTMkhkN5MJhpw@mail.gmail.com>
Subject: Re: [RFC PATCH v3 06/11] dt-bindings: timer: Update SiFive CLINT
 bindings for IPI support
To:     Anup Patel <anup@brainfault.org>
Cc:     Anup Patel <anup.patel@wdc.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Atish Patra <atish.patra@wdc.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 1, 2021 at 7:00 AM Anup Patel <anup@brainfault.org> wrote:
>
> On Wed, Sep 1, 2021 at 6:59 AM Rob Herring <robh@kernel.org> wrote:
> >
> > On Mon, Aug 30, 2021 at 09:47:24AM +0530, Anup Patel wrote:
> > > The Linux RISC-V now treats IPIs as regular per-CPU IRQs. This means
> > > we have to create a IPI interrupt domain to use CLINT IPI functionality
> > > hence requiring a "interrupt-controller" and "#interrupt-cells" DT
> > > property in CLINT DT nodes.
> > >
> > > Impact of this CLINT DT bindings change only affects Linux RISC-V
> > > NoMMU kernel and has no effect of existing M-mode runtime firmwares
> > > (i.e. OpenSBI).
> >
> > It appears to me you should fix Linux to not need these 2 useless
> > properties. I say useless because #interrupt-cells being 0 is pretty
> > useless.
>
> Linux IRQCHIP framework only probes IRQCHIP DT nodes which
> have "interrupt-controller" DT property.

Right, I believe I wrote that... So what would it look like to fix
that? The simplest thing is just drop the check for
'interrupt-controller'. That's just a sanity check and we have other
ways to do that now (schemas). Do you need this early? You can always
implement your own initcall.


> The "interrupt-cells" DT property
> can be removed because as an interrupt controller SiFive CLINT
> will only provide IPIs to arch code.

The schema will disagree.

Rob
