Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 140E73ACB68
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 14:54:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232426AbhFRM43 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 08:56:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231744AbhFRM41 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 08:56:27 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31B2EC06175F
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jun 2021 05:54:18 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id x14so13886782ljp.7
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jun 2021 05:54:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JXlMHuJslvLspuDNaWQXZmE6ewC06SDVouNHyl9Mhu0=;
        b=yuqbX81E1iI96EkRzPFPyslmqvh7KlQiq3VNKVLf5rNyQMopUTqXgybkSlFgrPioap
         dbAJA+0TSCHQoVUyDgviga0EhMrkPJOQCgqsgWdKIPlbrd17a47I7Lj9+Na6+o9aBIBD
         PIfYIzHihFBiicLyBGQCtroxkoNy5+S71D79Yr6iwaz+Pg5SZwX2NKuwq7o0E1p+YYr2
         AvQBZv2G7bvfJBKgrjjyITI8I2DAPenG2KnHoF2YbLTRNhd5GkiIhneC/q1bGHwtlwVj
         n3LQbY0WGggI+5iBExXKcKXfLVB7dVH0b9Xun3u8DRaAIZR33FmYBNMR7xwpekrzd1mt
         bRLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JXlMHuJslvLspuDNaWQXZmE6ewC06SDVouNHyl9Mhu0=;
        b=rma+0lKw2foQolgDU6MM6JfvlS0nqr/N/Mh06eKCWBY2RlYZDjNpS/HIaFxkuM1t/t
         CMJPPqX5j9cWR/tgBcXRw9/rNGhMSt9rhn5aWqxsxMsQdQDtp2cxMKCTFwR/Wsy28UkW
         mCof0OmRGvacaa97FoacYhmwMHBdRccVnblocaPpi4CJKcUh7kV1vGZlD5MHsWvO6eYq
         AcWP90zwbgA0aW7ieT1TUVTl07G26psitpsgdl59lR+0FWqfKvC5Ri4KjbvBZXA7gaG6
         th3kuJiGXuCeEkNYbdbLq9hkZAKTMxhSG8fN6jsz3Hkf6ClePDXbItDqbi6vHC2ElCbC
         mrCQ==
X-Gm-Message-State: AOAM530AX8qMatVOFQKcamFv/LuWGH4f3J/mkWY57GAWpCkiNsdlagbm
        nUv3eM+rgpweQE3gUd/WjrjzwTxQYT3V/StAVq4Btg==
X-Google-Smtp-Source: ABdhPJw77jjB8iYIuAzA4HYUKxB0s5H4KNds4QQ1hT23g7Hti7hSjTrLrrVIs5e7mWsDLzfdui5CV3tscXXNGHKLbMQ=
X-Received: by 2002:a2e:9003:: with SMTP id h3mr1546346ljg.467.1624020856487;
 Fri, 18 Jun 2021 05:54:16 -0700 (PDT)
MIME-Version: 1.0
References: <2142129092ff9aa00e600c42a26c4015b7f5ceec.1623813516.git.luto@kernel.org>
 <YMnPezLs6vb418Wz@hirez.programming.kicks-ass.net> <YMnQVoKvM5G34Yan@hirez.programming.kicks-ass.net>
 <20210616103446.GC22278@shell.armlinux.org.uk> <YMncQv1uT5QyQ84w@hirez.programming.kicks-ass.net>
 <20210616132226.GD22278@shell.armlinux.org.uk> <20210616150456.GC22433@arm.com>
 <20210616152326.GG22278@shell.armlinux.org.uk> <20210616154529.GD22433@arm.com>
 <20210616160050.GE22433@arm.com> <20210616162716.GH22278@shell.armlinux.org.uk>
In-Reply-To: <20210616162716.GH22278@shell.armlinux.org.uk>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 18 Jun 2021 14:54:05 +0200
Message-ID: <CACRpkdYHoC66K7W6mUMqKfAJkcKeopBnAq8Rq+tLSdLo61jtAQ@mail.gmail.com>
Subject: Re: [PATCH 7/8] membarrier: Remove arm (32) support for SYNC_CORE
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Krzysztof Halasa <khalasa@piap.pl>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 16, 2021 at 6:27 PM Russell King (Oracle)
<linux@armlinux.org.uk> wrote:

> Arnd tells me that the current remaining ARM11MPCore users are:
> - CNS3xxx (where there is some martinal interest in the Gateworks
>   Laguna platform)
> - Similar for OXNAS
> - There used to be the Realview MPCore tile - I haven't turned that on
>   in ages, and it may be that the 3V cell that backs up the encryption
>   keys is dead so it may not even boot.

I have this machine with 4 x ARM11 MPCore, it works like a charm.
I use it to test exactly this kind of stuff, I know if a kernel works
on ARM11MPCore it works on anything because of how fragile
it is.

> So it seems to come down to a question about CNS3xxx and OXNAS. If
> these aren't being used, maybe we can drop ARM11MPCore support and
> the associated platforms?
>
> Linus, Krzysztof, Neil, any input?

I don't especially need to keep the ARM11MPCore machine alive,
it is just a testchip after all. The Oxnas is another story, that has wide
deployment and was contributed recently (2016) and has excellent
support in OpenWrt so I wouldn't really want
to axe that.

Yours,
Linus Walleij
