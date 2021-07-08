Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA0973C1477
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jul 2021 15:40:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231921AbhGHNm6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jul 2021 09:42:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231152AbhGHNm5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jul 2021 09:42:57 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A84FC061574
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jul 2021 06:40:15 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id r132so8994815yba.5
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jul 2021 06:40:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JeBVWsbWOT+Wo/FxJAgeQ+5Dtzc9jQjwBH9z1csOAl0=;
        b=S7yp8ZYPdK3xCJH76ogcQ3WNYKFNhyiZWqWRgZLnqFYMBBNXLBcOYSNhRR1PyDL25T
         tYgSTxiU9z94G8BynrhcTjCKWbzOWEWQHM/nIlYIbW5MTfbFVt+x2IsZhCkXmbFCRKpA
         /Lz7SwU3nIuTOWQPgfNMfo1FeH/I5Tg+BuuHR1GX+iAx4bU3MudcP7AQu7dJiY0xhBvA
         z17XhO7wYwk8nUE6ER5qYWPI4oVhGfdstPaklgSniD0vB6YQpbe02f0HYHw2By8OTrp+
         4AOVy3vuZgohfC8PnZRTRQYt0YL1tAmCPAlQQ4YnsOjAbsFLRWLhhQxAorKQ/bCLdAeH
         mJAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JeBVWsbWOT+Wo/FxJAgeQ+5Dtzc9jQjwBH9z1csOAl0=;
        b=JzJ1HA8M/lb3Rrvp4f3Gk+vC0TiQWHKLHmRZVR+rKPyVH6DY74noGHqON+Re7VwVrU
         0NySYCW8mfEuvYs90DEo+fjA3dL9s/hrV7Q0QYTNRsMLdVQT6OiIoQeeCrV0JmccfaTT
         JAkauyEuZTf6sF88DMNw7/dwo+rd8Akue6mRe9ZL1xbm/fL3Lsof3dy24hMyXu2B+Vu3
         RApb06FrCjhQCP4987GOPP6qsdQd9xSXl0tplz6aPFUhzRFzgb1inkUNh9dFqAzo9VQR
         k5IjZlrPHhFgwElJXD1lIL9SRFfkZMbRZYXmsHQ9A1Shdkjn6h09wdyfC7R7uXjQjQCU
         t9Gw==
X-Gm-Message-State: AOAM530Lk6AlU1cixFCFHW0w/a18Jne2cOiGpewAUuzPADDM9pjk+ePh
        8NP85wDXgzS9/CwW06zuLAQwDxG3Z0rcHjCwmXaKC+/z
X-Google-Smtp-Source: ABdhPJx4xwpTR3OAjGSmYCe1jeUNioBN+m8L6JQcgu7QKc3knfPJNKQKr/Gv1Q1DQqgclX4S2mWGkoT8ggWYPCc5fZY=
X-Received: by 2002:a25:6c04:: with SMTP id h4mr39916637ybc.122.1625751614749;
 Thu, 08 Jul 2021 06:40:14 -0700 (PDT)
MIME-Version: 1.0
References: <20210616074645.429578-1-bmeng.cn@gmail.com>
In-Reply-To: <20210616074645.429578-1-bmeng.cn@gmail.com>
From:   Bin Meng <bmeng.cn@gmail.com>
Date:   Thu, 8 Jul 2021 21:40:03 +0800
Message-ID: <CAEUhbmWZL3QoS_qNe8xEPrBWm0+hLauLAhm9-Wxt2jSDntP=5Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] riscv: dts: unleashed: Add gpio card detect to mmc-spi-slot
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        David Abdurachmanov <david.abdurachmanov@sifive.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>
Cc:     Bin Meng <bin.meng@windriver.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 16, 2021 at 3:46 PM Bin Meng <bmeng.cn@gmail.com> wrote:
>
> From: Bin Meng <bin.meng@windriver.com>
>
> Per HiFive Unleashed schematics, the card detect signal of the
> micro SD card is connected to gpio pin #11, which should be
> reflected in the DT via the <gpios> property, as described in
> Documentation/devicetree/bindings/mmc/mmc-spi-slot.txt.
>
> [1] https://sifive.cdn.prismic.io/sifive/c52a8e32-05ce-4aaf-95c8-7bf8453f8698_hifive-unleashed-a00-schematics-1.pdf
>
> Signed-off-by: Bin Meng <bin.meng@windriver.com>
> ---
>
>  arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dts | 1 +
>  1 file changed, 1 insertion(+)
>

Ping?
