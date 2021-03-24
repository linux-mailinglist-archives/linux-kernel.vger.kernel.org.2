Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6DB4347698
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 11:56:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234190AbhCXKzn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 06:55:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:39680 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231583AbhCXKzV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 06:55:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0B4E860238
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 10:55:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616583321;
        bh=3HRSx0vQyb6pYJYvI/6CnbJV9288sDH2H3+lAxm+C8w=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=HTTeSFqCRm2eFA3kDYm5IpxecooLqYU7+Qjc69tjNeaTb8ENMav69v2cSJXj7oXlO
         XVD0Q64/xKfUb+ThQjIbRf8WlgSob3Y2HZoEtqfSVOJJmLD7xyvKKCIAk76TalhO6m
         EgZbs6pHU08ySGmRI2eoUIjMEVSABw6zSZ6y2xt/LbZGJe+KeD+lksr0f2HF1F5gwz
         3rKHSnqRRDEIIkwrrNf23jbzDKbY8035Fmn5TNnMmEHkucuakhsaMLi02SCWFBNOYt
         MM94rqYBRX9/nEJ1QCdNSJmGni8s5m584s3IeAQQCy6iXFBuWrU6Ke2CtMDgxwj5Ry
         LZ5FHRabLbW5A==
Received: by mail-ot1-f45.google.com with SMTP id l12-20020a9d6a8c0000b0290238e0f9f0d8so844109otq.8
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 03:55:20 -0700 (PDT)
X-Gm-Message-State: AOAM531SDsMO1wIVoyYCdlDuDSQ06prf+37vz1iAdaxehenjJQxBRZ+L
        yamZ7EijadnqbLecFWVmJaFekBwCAJ6KtnVYln4=
X-Google-Smtp-Source: ABdhPJyYgVed5PcgLnu/TdtWYqTOmtheoQtwoBgp8ToZbJCBzcy94y+Rrv7mZMeJoTfzxJ2TEJRONX2HUv2b2FTB9r4=
X-Received: by 2002:a05:6830:148c:: with SMTP id s12mr2761572otq.251.1616583320379;
 Wed, 24 Mar 2021 03:55:20 -0700 (PDT)
MIME-Version: 1.0
References: <20210323131842.2773094-1-arnd@kernel.org> <CAKwvOdkBEQdVC73_datkwa+meitAGskDgTEr5LzX6AEnE4xd-w@mail.gmail.com>
 <87czvokgdk.wl-maz@kernel.org>
In-Reply-To: <87czvokgdk.wl-maz@kernel.org>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Wed, 24 Mar 2021 11:55:04 +0100
X-Gmail-Original-Message-ID: <CAK8P3a2kVagwETi0_t0C=eGJ6UU=AXegL94UykfQdh7H292XYQ@mail.gmail.com>
Message-ID: <CAK8P3a2kVagwETi0_t0C=eGJ6UU=AXegL94UykfQdh7H292XYQ@mail.gmail.com>
Subject: Re: [PATCH] irqchip/gic-v3: fix OF_BAD_ADDR error handling
To:     Marc Zyngier <maz@kernel.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Nathan Chancellor <nathan@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 24, 2021 at 11:14 AM Marc Zyngier <maz@kernel.org> wrote:
>
> On Tue, 23 Mar 2021 22:06:22 +0000,
> Nick Desaulniers <ndesaulniers@google.com> wrote:
> >
> > On Tue, Mar 23, 2021 at 6:18 AM Arnd Bergmann <arnd@kernel.org> wrote:
> > >
> > > From: Arnd Bergmann <arnd@arndb.de>
> > >
> > > When building with extra warnings enabled, clang points out a
> > > mistake in the error handling:
> > >
> > > drivers/irqchip/irq-gic-v3-mbi.c:306:21: error: result of comparison of constant 18446744073709551615 with expression of type 'phys_addr_t' (aka 'unsigned int') is always false [-Werror,-Wtautological-constant-out-of-range-compare]
> >
> > Looks like based on CONFIG_PHYS_ADDR_T_64BIT, phys_addr_t can be u64
> > or u32, but of_translate_address always returns a u64.  This is fine
> > for the current value of OF_BAD_ADDR, but I think there's a risk of
> > losing the top 32b of the return value of of_translate_address() here?
>
> If the DT describes a 64bit physical address, and that the (32bit)
> kernel isn't built to grok these addresses, then I'd say that the
> kernel cannot run on this HW, and that we don't need to worry much
> about this case.
>
> In general, CONFIG_PHYS_ADDR_T_64BIT must be selected by the arch code
> if anything above 32bit can be described in the PA space.

Right, this generally works fine, the OF_BAD_ADDR is just a little
hard to get right. Fortunately there are very few comparisons to
OF_BAD_ADDR in other drivers, so I don't think we have to do
anything about it. I looked through every other user of this and found
no problems there, either they use 64-bit temporaries, or they correctly
cast the results.

         Arnd
