Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 888DE3A121D
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 13:14:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238320AbhFILQa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 07:16:30 -0400
Received: from mail-lj1-f169.google.com ([209.85.208.169]:36741 "EHLO
        mail-lj1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237918AbhFILQ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 07:16:26 -0400
Received: by mail-lj1-f169.google.com with SMTP id 131so31171297ljj.3
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jun 2021 04:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QugCigS9fOj5XysW+4Oue4xRZg7LzQZSMpAyh31Q1WM=;
        b=bpqS0X+jjnWtLoSwLxKHqkguPp+mF7DTHL/j5d6kq3p1JKUIV6ZTdzAPgh7f4Y3QCF
         sjZPpWZBjkFJ/pwfeNbt5zp5zBjZCvMC2HwEHborK1gBOFVI/mfKhjwojDMpOsPdcy0C
         HD4gfAeOfQSzZfGF0nkSpeqtq3bUHchBgqiegOmo7FkQLPWaWu+eTU1EuQwNsshs+TT4
         nJam8YO/zprZfzlPkyo+8M5zxs9RAoMM4QNn0vSTf+yPAjlgMETHk1Wo0Su1dNKGDsLT
         nu2redsHNb37b55YrhIpVyqdbBmmIZgJ48mdTETRD43HNC9lEZRX5+9AX6jd4RoW1Lvx
         tvjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QugCigS9fOj5XysW+4Oue4xRZg7LzQZSMpAyh31Q1WM=;
        b=DcjsVJBxHI7P+dCLWQ8R7ZZZXpYjLzDomtBoO3vkLMoneC/RReGhwDwaXCv3xfwagC
         sQKP/8hH0Wv1buDpdMa0bjg0e1j96DDSqsPh62YBOzDCK2voL2CTl9m1KMTQQ/eBLOmG
         YF52gUDqNFsBS+V9zy10t2yxUk1pO+DicymE+hrMikJWyqM0AoK/MUaUaDwSQTRQYidI
         I5q3tnIXhQRXti5GAMPP0DTrg+eZ1aSjLbMyN8Yu/GPDChTKa5uEuaHGvIWbQy4fUP2z
         bK1BP/wqMB4+Rp9vwouNhE4uHaWq43pPMnLN58goXGec3UZSTXZe1ZanzOnGBF2bWrwP
         f/uw==
X-Gm-Message-State: AOAM530PwG+cFh10VyR4+F1UuoEAV9035BawPoa3bLDw44nZhGH+Bvp1
        8wBZ4uZ5NWoyje1sG8mmj6KnaXcDDza67t08to5Frg==
X-Google-Smtp-Source: ABdhPJxo8J+WXMxRas2USR7baWmM68fVP/NSPDHs/rukMxOLcTL8Zz+rwryBtfYk+IPjKYzdwxIbTXKinVZtj6GmKLs=
X-Received: by 2002:a05:651c:1057:: with SMTP id x23mr21221750ljm.467.1623237202587;
 Wed, 09 Jun 2021 04:13:22 -0700 (PDT)
MIME-Version: 1.0
References: <1623134048-56051-1-git-send-email-zou_wei@huawei.com>
In-Reply-To: <1623134048-56051-1-git-send-email-zou_wei@huawei.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 9 Jun 2021 13:13:11 +0200
Message-ID: <CACRpkdYvU0aO5sEdDNH6C5FwO4yBMdCwY-0so5YTpBvyZqM58w@mail.gmail.com>
Subject: Re: [PATCH -next v2] pinctrl: mcp23s08: Fix missing unlock on error
 in mcp23s08_irq()
To:     Zou Wei <zou_wei@huawei.com>
Cc:     Radim Pavlik <radim.pavlik@tbs-biometrics.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 8, 2021 at 8:16 AM Zou Wei <zou_wei@huawei.com> wrote:

> Add the missing unlock before return from function mcp23s08_irq()
> in the error handling case.
>
> v1-->v2:
>    remove the "return IRQ_HANDLED" line
>
> Fixes: 897120d41e7a ("pinctrl: mcp23s08: fix race condition in irq handler")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Zou Wei <zou_wei@huawei.com>

Patch applied.

Yours,
Linus Walleij
