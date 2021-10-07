Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 882AD425698
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 17:31:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241012AbhJGPdK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 11:33:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240882AbhJGPdJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 11:33:09 -0400
Received: from mail-ua1-x934.google.com (mail-ua1-x934.google.com [IPv6:2607:f8b0:4864:20::934])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFCC7C061746
        for <linux-kernel@vger.kernel.org>; Thu,  7 Oct 2021 08:31:15 -0700 (PDT)
Received: by mail-ua1-x934.google.com with SMTP id c33so4539574uae.9
        for <linux-kernel@vger.kernel.org>; Thu, 07 Oct 2021 08:31:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6eZtlPFWAta9cWAbKSnTEB89ZaaeeH9U6d/DiOEDJ4A=;
        b=dSEFfmniVED8B0xlIitfvX1io/mo+EB6OxRxCeRsqQQOqXu8Y72WwneAxwuNDoe69v
         BltyEpHe86PnqfjjHAUK1PjmNBgotm95hdp4tKWXeJykq2KNmKOHSrFfxX7toaIjPOfJ
         7KqGxdqAgndPB2tVNBcbqIHAtAWWhn/cuALeqgZrgREUg4TJAk85Ca53Z3Jm66fno/uE
         Q1Sh5R/ov3gQgUKc//zHbyd+xFxb8U+MZye4mJIvvC7RWb+DGs8q8cjv+7Qcn1kLhZZf
         xs3u5tMlYkDPCJj0auNZsSPVhyF1ybFBz00i/6KF34LWbR1REswR8stXwDQl0FSLq61r
         AduQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6eZtlPFWAta9cWAbKSnTEB89ZaaeeH9U6d/DiOEDJ4A=;
        b=0P/tUoNnjSHG+yuqHYwIP2oEx2cW3RIOwArq609OouIX91lo02EkTY7o4RClEdRAf6
         /PbRupfvxChZW4RJFNCM+reZpTS+1WyZcbpsUuF/f/A7ZJoUyWmfFkhffXLpOFso9eFu
         j1NMECcUADUw2NJCJwV2FqZ22dp4hrmPbFdc0bVyPDbPTPlJDA2UPJrFp48HCL+Uf6pY
         hOf0Y53R9tnv6Pqy3NLbPjhLaHrsphu5g7cgcV6KqZhOqwv0nzrCymCao31o6WyDgebl
         JamD8tpiSs7Cz5iUstr8F3eAG1iLwKw6b7wR/romsuzC3RpkV5lWksvPn4U2gZRO1UFP
         njtw==
X-Gm-Message-State: AOAM533U0il77dAP3h2DzqFdyw++EEvK+d8K10T4vdqWKZmS4bmZ9fMW
        qebfLs3yGklw1aH44jAe/Pd/bSH0y9CdpfmuQC13sA==
X-Google-Smtp-Source: ABdhPJzJnBuoD5URWYj80Agkqe+rghbldVV6ScEzSmK94NikdpG2KTBrSoM/XAT9r2zcxGPvCBrwXT1z5VtSuHdXSzk=
X-Received: by 2002:ab0:708e:: with SMTP id m14mr2737190ual.104.1633620675136;
 Thu, 07 Oct 2021 08:31:15 -0700 (PDT)
MIME-Version: 1.0
References: <20211007135635.2717-1-semen.protsenko@linaro.org> <CAOMZO5DNF8pO__+Yjn32KEXDG_rq7LoOt=aKrsBz8gPfuxUxPw@mail.gmail.com>
In-Reply-To: <CAOMZO5DNF8pO__+Yjn32KEXDG_rq7LoOt=aKrsBz8gPfuxUxPw@mail.gmail.com>
From:   Sam Protsenko <semen.protsenko@linaro.org>
Date:   Thu, 7 Oct 2021 18:31:03 +0300
Message-ID: <CAPLW+4kEaJGbSFcY-Pex2jZdenjAfLakqy1ezGMKOAGHnab5Kg@mail.gmail.com>
Subject: Re: [PATCH v3] clk: Add clk_set_parent debugfs node
To:     Fabio Estevam <festevam@gmail.com>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Mike Tipton <mdtipton@codeaurora.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andy Shevchenko <andy@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Oct 2021 at 17:17, Fabio Estevam <festevam@gmail.com> wrote:
>
> Hi Sam,
>
> On Thu, Oct 7, 2021 at 10:57 AM Sam Protsenko
> <semen.protsenko@linaro.org> wrote:
> >
> > Useful for testing mux clocks. One can write the index of the parent to
> > set into clk_parent node, starting from 0. Example
> >
> >     # cd /sys/kernel/debug/clk/mout_peri_bus
> >     # cat clk_possible_parrents
>
> s/clk_possible_parrents/clk_possible_parents

Thanks, will be fixed.
