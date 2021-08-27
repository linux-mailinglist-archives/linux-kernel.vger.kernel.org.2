Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B12B3FA158
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Aug 2021 00:01:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232069AbhH0WCI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Aug 2021 18:02:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231906AbhH0WCH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Aug 2021 18:02:07 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0546C0613D9
        for <linux-kernel@vger.kernel.org>; Fri, 27 Aug 2021 15:01:17 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id s3so13883407ljp.11
        for <linux-kernel@vger.kernel.org>; Fri, 27 Aug 2021 15:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=1NBCZHDBC3agX6qUDWxS/sUA8KECnbDSJSUvK1teHUE=;
        b=vya4Ci96dqVssvsKtO6Ky36OkdOYMqKQ7Bf80v+7qQXJORddaI3afkZs0nlWeyRUiA
         L9nevJXB89Hpxyf99YAvCD2+1vdnzeByk7WAefBWKM3RgVQQ/jWVOU4FErLo6eEPSLPy
         j2JTBlou956o3wGG+aeeubFrCyuIzKG8HtfkpYBehdY59jE6cVO6twK5DGpABAXjNS0U
         KY6ZLy46Cnw5BqiheiegjviLI+QZkFEHvm51YcBJ9fqvgw6w160R+A04gxBKG9V0KkRb
         NZVxwbtyUNs/aYiqocol/4e0KjaxLqT4AFVpXeF5zx5dQ7/HiWOj18VR4M5L3oYj4Yqx
         8CWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=1NBCZHDBC3agX6qUDWxS/sUA8KECnbDSJSUvK1teHUE=;
        b=cICSXSwXV9qLcliMFUW/uf+84SriNaHt+K065Q8ajSDY3MwJUOjtHyBg0K+8Zn3jqW
         oFU0bPVuFiB19w29UB2A9EkMnNbQTZugw1UZC1F5/wDrgHcg5ljRu2IDSstKqVMlG0PT
         LQABMuj0ORm+VV8LxiWOrddgU3PkzAm3GxuBRrGp+sWNS0F4O97atjBKzXQNJBA8B2yi
         EEMmdn8xdwu9v9EiiOvFK+VlnYXt4nsNMl1vnHsM3mOlfHh2ARypOUf4F+b/g174z1UK
         3NFyq1JKDfT651ZLhGyEEPyfbUDCAV8cGkEo7N5XfAsuGDXlxfmJk0SsT7ct00w/eBi3
         gJIg==
X-Gm-Message-State: AOAM5311OR6FTVnHknTVvE07wCHwVs6NEMgcIGnWWhnWjKnxmQkwEGtb
        PFSM6wnU6/hegIHbyAw8FyfD7hipGtl5H3DFJXQIvQ==
X-Google-Smtp-Source: ABdhPJwRyYwaNqaX2jdc0YER25YnA9lp11v416ANcmrIu89LVDwvrIh7LbAcBYMiZdbq1yqmDlgy1uaEFk0yGHvwAFw=
X-Received: by 2002:a05:651c:4c7:: with SMTP id e7mr4299691lji.438.1630101676071;
 Fri, 27 Aug 2021 15:01:16 -0700 (PDT)
MIME-Version: 1.0
References: <20210724224424.2085404-1-linus.walleij@linaro.org>
 <20210724224424.2085404-2-linus.walleij@linaro.org> <20210821042010.GA1759866@roeck-us.net>
In-Reply-To: <20210821042010.GA1759866@roeck-us.net>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 28 Aug 2021 00:01:05 +0200
Message-ID: <CACRpkdYObGTWni3sSa21iNsgikzj7t9MA6y4TNgkBTTYQt+coA@mail.gmail.com>
Subject: Re: [PATCH 2/2] clocksource/drivers/fttmr010: Be stricter on IRQs
To:     Guenter Roeck <linux@roeck-us.net>,
        Andrew Jeffery <andrew@aj.id.au>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
        Joel Stanley <joel@jms.id.au>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 21, 2021 at 6:20 AM Guenter Roeck <linux@roeck-us.net> wrote:
> On Sun, Jul 25, 2021 at 12:44:24AM +0200, Linus Walleij wrote:

> > Make sure we check that the right interrupt occurred before
> > calling the event handler for timer 1. Report spurious IRQs
> > as IRQ_NONE.
> >
> > Cc: C=C3=A9dric Le Goater <clg@kaod.org>
> > Cc: Joel Stanley <joel@jms.id.au>
> > Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
>
> This patch results in boot stalls with several qemu aspeed emulations
> (quanta-q71l-bmc, palmetto-bmc, witherspoon-bmc, ast2500-evb,
> romulus-bmc, g220a-bmc). Reverting this patch together with
> "clocksource/drivers/fttmr010: Clear also overflow bit on AST2600"
> fixes the problem. Bisect log is attached.

Has it been tested on real hardware?

We are reading register 0x34 TIMER_INTR_STATE for this.
So this should reflect the state of raw interrupts from the timers.

I looked in qemu/hw/timer/aspeed_timer.c
and the aspeed_timer_read() looks dubious.
It rather looks like this falls down to returning whatever
was written to this register and not reflect which IRQ
was fired at all.

Andrew: have you tested this when developing the
QEMU driver?

Yours,
Linus Walleij
