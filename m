Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E09733E24F5
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 10:15:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243888AbhHFIPl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 04:15:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243591AbhHFIPO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 04:15:14 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1099FC0617B1
        for <linux-kernel@vger.kernel.org>; Fri,  6 Aug 2021 01:14:53 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id b6so18327lff.10
        for <linux-kernel@vger.kernel.org>; Fri, 06 Aug 2021 01:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/jD/avfm2p41lo9b5VPwnKdxplJeoAf0dQTUMIW6jWE=;
        b=vEkPvb8W6TaWes4EedDII8c+Hoks3fgwjH5i3tESoywvbi7+98gqjT1/CM62CxTu7R
         sJjuz8NqygDBFUjysOc2cQi5CjhufOz7NFHxlO5F8FW1+zkPZXUNcOdvVStjyVxV4oEW
         PpQvWbCMnBbu2NCyjE0OjKNnhXTbQH9D6qkRVwb/bgGgaDcroZ66hT9C87pHwxmNUai8
         G+gGgr/lqFp8hodH48urk+xyPv7iGKaigPVe8DLDdA0cu1HdvhrEROjNGcwa8AQgzLqb
         +fDxpiywqEV62svQFJe06JHnjPD5X5q1qVn2db7DDTjsnXdoAEiMpQc2jajc61RpZ8HH
         5JZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/jD/avfm2p41lo9b5VPwnKdxplJeoAf0dQTUMIW6jWE=;
        b=t1wDXYBNwE7SRp2xdd6poQ3xUc/jw6hISRvMCnKXzuiGt0tjtOYSB8EIE1S4z6Ypyv
         aL4bpbNHvsfq8Ydxnkr0mBVrI1F6a8m0DSF3k7Lx7UGRO6KzbAn37egjKtT0uCbjEiFI
         oDMHjVlV6NLuxvT3Z20DVklfeuufgwndMpBibw8fBMWkTmiHuYANqQ+8nVCMEn3Bwm+v
         x5nGJmCm7U7PHOOzR2U15w78yILRcR3ruAHN+hdUDhZaLFZGey+Gp6PZhIHJhTfiUIwo
         X048Obic0OhFwBvLjburBJDsX1CE6RHDNlCSx8sBlrlWdtnL3/JajAXE4crRYxOhedZh
         gJTQ==
X-Gm-Message-State: AOAM53040paI9pf5wMmzRGGWCJobGFQuPVn5EdlpGA1bGnT0NJrBELWe
        HKPUwe11qfTLMCw4R52++5NPX2azW2sx3gH2txQBLg==
X-Google-Smtp-Source: ABdhPJwoQQ/ih127w1+ABBOgpekbdUrfbMfwZAngBKpgvv00NTFv2YUzJVTJkvebBkmnU9fO3Kcjc0VMMqIjlV/IlNs=
X-Received: by 2002:ac2:5d4a:: with SMTP id w10mr6912020lfd.529.1628237691324;
 Fri, 06 Aug 2021 01:14:51 -0700 (PDT)
MIME-Version: 1.0
References: <20210801233314.3150754-1-linus.walleij@linaro.org>
 <20210801233314.3150754-2-linus.walleij@linaro.org> <YQejHNP1AzFHZ6gK@google.com>
 <CACRpkdaK0pBgmFSazjJ5NOj9rF9DzUyCfumxyi8PNaS_61_=Ww@mail.gmail.com>
 <YQuaiW/MSZY4bmok@google.com> <162820748053.19113.16240444817751473992@swboyd.mtv.corp.google.com>
In-Reply-To: <162820748053.19113.16240444817751473992@swboyd.mtv.corp.google.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 6 Aug 2021 10:14:40 +0200
Message-ID: <CACRpkdZfb4szcERUynqOaGrV5A1LbDSo-gSebW8dYmFE_=P6XQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] mfd: db8500-prcmu: Handle missing FW variant
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Lee Jones <lee.jones@linaro.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk <linux-clk@vger.kernel.org>,
        phone-devel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 6, 2021 at 1:51 AM Stephen Boyd <sboyd@kernel.org> wrote:

> > I assume they will not require an immutable branch, as the turn-over
> > in this file is very low.
>
> Seems fine to go through mfd. Isn't there some other ux500 patch on the
> list though?

Not for clocking, maybe more MFD stuff so merging to MFD should be
the best option.

Yours,
Linus Walleij
