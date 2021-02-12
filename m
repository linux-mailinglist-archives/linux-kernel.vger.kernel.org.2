Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8A6F319C10
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 10:47:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230203AbhBLJqR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 04:46:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:43592 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229497AbhBLJqK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 04:46:10 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id B2ADF64E77
        for <linux-kernel@vger.kernel.org>; Fri, 12 Feb 2021 09:45:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613123128;
        bh=BbEhXej3UDqv6ywrb7c2WICTBWGHFl7FT92DDfTe4YU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=tS20NBgYQIoH115aNkqNxzaqAG3B5nWvML0gh99ZTG8BZ0n6WXKgKpu1n1ceD1HbI
         6HQXdSwYVPkRsRUqoKPJxJcN+VEdUr+y3CGIaQ/JImFgBjmM5ClhBqHU2/106IqY6i
         bc+PwHRSkgn7EKx+T1RIhj7VeQ5jJdIBXIMxJKFXLUiiOPdW0oH8Y8Zo2d1E+QLJKB
         wuL6+iwunPOXlgi7mu1jl3uG/WP+M/dFOgwPt8Ra6MGzXjg6b2C8pU4RL4+OKgfBce
         ttj2uAD0V8cs1BimVjUYeKXgmeK4gDJCDQr7XLDpCyrff3khYvr/kkh5S3cIdu12fN
         ZmbNS8u/XTqLg==
Received: by mail-oi1-f173.google.com with SMTP id d20so9349715oiw.10
        for <linux-kernel@vger.kernel.org>; Fri, 12 Feb 2021 01:45:28 -0800 (PST)
X-Gm-Message-State: AOAM531QgZTmkNC70DVlCIn2Z0VRe5wc/TICaP1LrkHiBYg75Rep31cg
        1bi3nMmbL804p1uIBCpjxiOD8CHZ8b7qSEOerhs=
X-Google-Smtp-Source: ABdhPJzD5e6QclZTBQwRsZoRCLLpZYukyOSqBEinruy8DlGlhxaUvUSfA98nK6oNeB0RIfdhYI9xQOfnExujeCY4C9Y=
X-Received: by 2002:aca:2117:: with SMTP id 23mr1286794oiz.4.1613123128011;
 Fri, 12 Feb 2021 01:45:28 -0800 (PST)
MIME-Version: 1.0
References: <1612774577-55943-1-git-send-email-luojiaxing@huawei.com>
 <1612774577-55943-2-git-send-email-luojiaxing@huawei.com> <fab1e871-08e4-fc71-9dbf-9bcacf18e2e1@ti.com>
 <CAK8P3a0m4ocfLyJZ5wMxyKESYUJ5um5sb5MyAzC8ckCb6qAH5g@mail.gmail.com>
 <d5465b81-bb53-49ee-a556-40d208deb765@ti.com> <a61ef337fd1c4538a47fe855920f95d3@hisilicon.com>
In-Reply-To: <a61ef337fd1c4538a47fe855920f95d3@hisilicon.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Fri, 12 Feb 2021 10:45:12 +0100
X-Gmail-Original-Message-ID: <CAK8P3a3SHQNjF5ZpqHQweG7BQ52Xi1hQKDiMVKq4aNK_7VDw6w@mail.gmail.com>
Message-ID: <CAK8P3a3SHQNjF5ZpqHQweG7BQ52Xi1hQKDiMVKq4aNK_7VDw6w@mail.gmail.com>
Subject: Re: [Linuxarm] Re: [PATCH for next v1 1/2] gpio: omap: Replace
 raw_spin_lock_irqsave with raw_spin_lock in omap_gpio_irq_handler()
To:     "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
Cc:     Grygorii Strashko <grygorii.strashko@ti.com>,
        luojiaxing <luojiaxing@huawei.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        "open list:GPIO SUBSYSTEM <linux-gpio@vger.kernel.org>,
        linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxarm@openeuler.org" <linuxarm@openeuler.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 12, 2021 at 6:05 AM Song Bao Hua (Barry Song)
<song.bao.hua@hisilicon.com> wrote:
> > -----Original Message-----

> >
> > Note. there is also generic_handle_irq() call inside.
>
> So generic_handle_irq() is not safe to run in thread thus requires
> an interrupt-disabled environment to run? If so, I'd rather this
> irqsave moved into generic_handle_irq() rather than asking everyone
> calling it to do irqsave.

In a preempt-rt kernel, interrupts are run in task context, so they clearly
should not be called with interrupts disabled, that would defeat the
purpose of making them preemptible.

generic_handle_irq() does need to run with in_irq()==true though,
but this should be set by the caller of the gpiochip's handler, and
it is not set by raw_spin_lock_irqsave().

       Arnd
