Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A8A241A3D0
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 01:27:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238113AbhI0X3e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 19:29:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238012AbhI0X3d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 19:29:33 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38AA9C061575
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 16:27:55 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id y28so84100338lfb.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 16:27:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CNjVwNOreCVnGXxMa3eIII8LsiZt1BUYV58xP4ke9qY=;
        b=LhhH7IkIw+kfY7/iSu76gPEPRrZndBwB657Z3DEs/uhyyKaP/yz+ZiC7G3z1aYXLv+
         oKHnddZUWUjkKvdrXsl+/RNuYMn7NCeZmHHsweuWXBYhpixdbRNt+DEdqODe+dPKGeBF
         EwjTRFI+mcuuUzg6VvCI0Lw63lws375MhE9jhGs2qPtjNVwKwWLYdU+cwLt7HHzS45TO
         yaCRwnqlXtDUxUbhGt97b8a7Z+7yE5IonNMzC/MtIAhf2QrqS4XcknUlcOwd3bT53z8T
         kroZMh93UYDUNe4FcAQj5/PjBia8JuaXINvq7QaXhH6uoklT5EOyE+bX8sSlQ1cYr7g4
         V2nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CNjVwNOreCVnGXxMa3eIII8LsiZt1BUYV58xP4ke9qY=;
        b=AqRZXMM1BKWPP1bXIXPGzQPBFSOIVBqv53kL6gV7H6WSZbFPf+y0AILpXnvisX1iAp
         hBUKvkc2VItcBmnW8pa+RibUsJxxFK7gthBU3NckmNWUwhHs1R/pLmFP7jfXizA1AuWs
         rdgycBpLJLG5HdgC1SbE7zCtGyMrFx6wOXC+zPoBpF8voswpNVf/ITruB3PPL88ADvuC
         FwHOg+z32MRbn22wV88fe6nA76KR8H/p8hgnCXmYE5vtshLXi4JeK14hq956egCnVBoV
         oUJZhtyCnBlo7yIzzQQaLlfo/zWzIFLwpnM2BO1G1DTjxorUqdeglSa9Cn+L/iwKRGUP
         7FfQ==
X-Gm-Message-State: AOAM533qFDwyA7ihaUJt2wVfz9LDS1oY6jZPHmXbq0retGKkvkY1bxB3
        1ACKDavRgq9z7R43LY/GB9u/CD9x2MtHg71DNmn+VFjE+gM=
X-Google-Smtp-Source: ABdhPJw2EKvcRwRwNeXo4O2UwnzB+EKOgNqmwCSfbJZNDJd24C3ZQdno4QJnb9j9a92AOGS1jLIZjqOQhzQIdH7wjiE=
X-Received: by 2002:a2e:510a:: with SMTP id f10mr2595006ljb.358.1632785273575;
 Mon, 27 Sep 2021 16:27:53 -0700 (PDT)
MIME-Version: 1.0
References: <20210927141045.1597593-1-arnd@kernel.org>
In-Reply-To: <20210927141045.1597593-1-arnd@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 28 Sep 2021 01:27:41 +0200
Message-ID: <CACRpkdbirEZiKQxSWSsiwwvpui5Pw6vON-C-=BLJei0s8znLxg@mail.gmail.com>
Subject: Re: [PATCH] [RFC] mtd: fixup CFI on ixp4xx
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Linus Walleij <linusw@kernel.org>,
        Imre Kaloz <kaloz@openwrt.org>,
        Krzysztof Halasa <khalasa@piap.pl>,
        Arnd Bergmann <arnd@arndb.de>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        linux-mtd@lists.infradead.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 27, 2021 at 4:10 PM Arnd Bergmann <arnd@kernel.org> wrote:

> From: Arnd Bergmann <arnd@arndb.de>
>
> drivers/mtd/maps/ixp4xx.c requires MTD_CFI_BE_BYTE_SWAP to be set
> in order to compile.
>
> drivers/mtd/maps/ixp4xx.c:57:4: error: #error CONFIG_MTD_CFI_BE_BYTE_SWAP required
>
> This patch avoids the #error output by enforcing the policy in
> Kconfig. Not sure if this is the right approach, but it helps doing
> randconfig builds.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

> Any other ideas for how to address it?

We will "soon" have IXP4xx transitioned to device tree and then
physmap-ixp4xx.c is used instead, and this entire driver can be
deleted. I will get there, we just need to remember to mop of cruft
like this at the end of it.

Yours,
Linus Walleij
