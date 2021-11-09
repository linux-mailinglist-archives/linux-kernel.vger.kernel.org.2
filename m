Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C78244A008
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Nov 2021 01:54:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236394AbhKIA50 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 19:57:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236348AbhKIA5Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 19:57:24 -0500
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4760FC0613F5
        for <linux-kernel@vger.kernel.org>; Mon,  8 Nov 2021 16:54:39 -0800 (PST)
Received: by mail-ot1-x32e.google.com with SMTP id z2-20020a9d71c2000000b0055c6a7d08b8so16177757otj.5
        for <linux-kernel@vger.kernel.org>; Mon, 08 Nov 2021 16:54:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=y/5wawZ4iCQr7l/M8N9c7Pm/2uOFf0V7hWRrRXV1YxY=;
        b=n+jlur+tkjDc+lvzvnxzvjuMCuPiLormrOIgFn5OjIIJDPQHrK7TYPu8WkNQsELu1e
         xa6Ms7ysitAQJllZkoG9r+FsT1x/JJVXiQQTYvYlfe4V1HuBUazR6CzD+341b1DQvMwR
         ehKV26SEHzwLQUzAYiT6S9szxr+CZ+pug1+BngZBPtdxAohv7pweOteMw11Opm0tNZ4J
         utDUZzCR8NkxuTy37qDOPhHzRcf/oMHy8/p3KMsuKzwOtzG+SS+L98bqykJsd9/3eYCg
         e3N1zFEeyPwFmtROdKHMB5ZaAzoSn4g+NXJpbsKNunzO9Vaq/DN+cgYhOlkQyymcldrh
         aR1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=y/5wawZ4iCQr7l/M8N9c7Pm/2uOFf0V7hWRrRXV1YxY=;
        b=ik/iGro0cw1vot8o+Jff8LoPTPJEgRcWDIMQ8lP5rO0QEGHcjqi/Vhapm/2104QkEA
         SGym51m87dKyrXLAgZkygAJZG2+CwegECTz5+q0ZQsEUuvkT38DOLEXNXLSWo3rdzeCy
         mJ5PVMB3RcJpf0tVRaiRjy1Cqoxm/0g2NqL72/sFo/+8Ct3Jd+ZVNRXGQNvF8DwG2zWD
         Dj24/k3Erk9qdXgikrpoFdmMyIOSeoCWMiRbpOnTxf5PFuRx3zOWsLQaOgM0f/c+YNJL
         e6ePidL96Je/MoFrvlNyOoDoP+vhd0dEPi3an4667++AfG/J04UUe6FWGyZyxr4HcG/j
         dIHw==
X-Gm-Message-State: AOAM533tmlTNgQcSNTPVZMZx5VmXZmGiJsdx+8rS+iJ5mFYa7EZVBVb2
        hiHE0FwPuOO4vQAemRind02JnZLGEni5QXgFiqjqPw==
X-Google-Smtp-Source: ABdhPJx6ntF9Ij4ABUlVfspt/BrE1AagUV5HYqW4lumhYW9HaJk/bpBVv2CAh2o/6TEPXu1pygB6104B8pbDewZcMzA=
X-Received: by 2002:a9d:ed6:: with SMTP id 80mr2614070otj.35.1636419278616;
 Mon, 08 Nov 2021 16:54:38 -0800 (PST)
MIME-Version: 1.0
References: <20211102161125.1144023-1-kernel@esmil.dk> <20211102161125.1144023-13-kernel@esmil.dk>
 <CAHp75VdmnnrisuP00W0KYta0KgmC+fu3WMxm959dt5X1kpiKTw@mail.gmail.com>
In-Reply-To: <CAHp75VdmnnrisuP00W0KYta0KgmC+fu3WMxm959dt5X1kpiKTw@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 9 Nov 2021 01:54:26 +0100
Message-ID: <CACRpkdZOpXC0GvoyS8KexgjxL17rjyNkPuA0KGOvesZMDLvyJg@mail.gmail.com>
Subject: Re: [PATCH v3 12/16] pinctrl: starfive: Add pinctrl driver for
 StarFive SoCs
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Emil Renner Berthing <kernel@esmil.dk>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Sagar Kadam <sagar.kadam@sifive.com>,
        Drew Fustini <drew@beagleboard.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Michael Zhu <michael.zhu@starfivetech.com>,
        Fu Wei <tekkamanninja@gmail.com>,
        Anup Patel <anup.patel@wdc.com>,
        Atish Patra <atish.patra@wdc.com>,
        Matteo Croce <mcroce@microsoft.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Huan Feng <huan.feng@starfivetech.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 2, 2021 at 9:02 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:

> > +       depends on OF
>
> So this descreases test coverage.
> Linus, can we provide a necessary stub so we may drop this dependency?

Hm it further selects OF_GPIO which depends on OF
so I don't know how that would work.

But does it decrease compile coverage a lot, even x86 has
optional OF support so I imagine it appears in x86
allyesconfig I suppose? Or am I wrong?

Yours,
Linus Walleij
