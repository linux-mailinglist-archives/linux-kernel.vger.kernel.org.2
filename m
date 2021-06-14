Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04D523A67FF
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 15:34:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234066AbhFNNgb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 09:36:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234003AbhFNNgX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 09:36:23 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27947C061574;
        Mon, 14 Jun 2021 06:34:07 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id i4so15502603ybe.2;
        Mon, 14 Jun 2021 06:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fITfy3FoCscSzBKzsabed+L5goCIl2g/5fdsym0oiY4=;
        b=MhW8P6lVLC6p+sZK1oYqz6bb8+6FLaELyTFUYsF4bjZU3eQnYpCiMlhCpAcG8NRRcy
         CZcIifOsGderqM9MYJO1yxZJTQcfy43sC79EhFugkaZPxm8pUKeb3/mraNpqR7CirnbI
         GiOB0sP6df12h8M3WAxu+z4SanqoLAEQktHeaTXLuYkMwYO85pgchisFIO8Hbtz1SbGc
         fIg4jL7F7D6FwQiqYMPVvflIY7GnDapBpUQiWp8Pj1b6/2JGAtk2LcqvYXsSkxhsi+m8
         coz0jPd83rTTwims4dlptk1iUHWQwFeM7L+Xo3iwxw9WDFzsLmeKyw/mL6DjDxpEc6f1
         tF2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fITfy3FoCscSzBKzsabed+L5goCIl2g/5fdsym0oiY4=;
        b=Sv9oz4RygrJpAmXr0Q/0A8mmF8cfYd0KFXLFQg3mCqMZA4PmpDnFnlBFGAOjKIGP+1
         z59lrKDJ16bMnf7CaaOdp1u+i98r46ijVuZMVVyb4Aq+yU7sdre8rsfTNNVVKwG3ap+N
         K9Y9W+FaoZA2ROOfHlf9R39qFqmIE31Wd9GjCoiV/c3XJMHHvq+h3Tp6dNwgIxqW/eUf
         0CEiMwPDbGHedHDchbs3OLDG4u/WhaxQ4DsRXNg4H5n4GitahW5kQzrp6vX00+bNpRHm
         KCJIfgwpQT3vx9AKqcecq46YCvSoEN1Hq2GAyczOZ6m9wC6HRhxy+kA+J2vFn0JviZ8q
         n3vw==
X-Gm-Message-State: AOAM532qtouzsGDW5R6o8YwgrWi1nu5AlECbmcKQRF7zp+mjADZTOyI/
        SJ3cTPWZ7T37QVXntqR6EiF0t71Jrx+RF3upSoY=
X-Google-Smtp-Source: ABdhPJzylP/+U5d/VxskGMW//vGfCikjF9dkGLIxiDlPbjg6s6SPPEZY32Gk5rbGsiS4HIDDCDXM9d+uuBvguiVMSX0=
X-Received: by 2002:a25:be09:: with SMTP id h9mr25605058ybk.239.1623677646410;
 Mon, 14 Jun 2021 06:34:06 -0700 (PDT)
MIME-Version: 1.0
References: <20210612160422.330705-1-anup.patel@wdc.com> <20210612160422.330705-2-anup.patel@wdc.com>
In-Reply-To: <20210612160422.330705-2-anup.patel@wdc.com>
From:   Bin Meng <bmeng.cn@gmail.com>
Date:   Mon, 14 Jun 2021 21:33:53 +0800
Message-ID: <CAEUhbmXhDZExHpZwVUEW-xz2nq_j5SXev4pZBhG4qAtPr2riCA@mail.gmail.com>
Subject: Re: [RFC PATCH v1 01/10] RISC-V: Clear SIP bit only when using SBI
 IPI operations
To:     Anup Patel <anup.patel@wdc.com>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Atish Patra <atish.patra@wdc.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 13, 2021 at 12:07 AM Anup Patel <anup.patel@wdc.com> wrote:
>
> The software interrupt pending (i.e. [M|S]SIP) bit is writeable for
> S-mode but readonly for M-mode so we clear this bit only when using

nits: read-only

> SBI IPI operations.
>
> Signed-off-by: Anup Patel <anup.patel@wdc.com>
> ---
>  arch/riscv/kernel/sbi.c | 8 +++++++-
>  arch/riscv/kernel/smp.c | 2 --
>  2 files changed, 7 insertions(+), 3 deletions(-)
>

Otherwise,
Reviewed-by: Bin Meng <bmeng.cn@gmail.com>
