Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27E0C38829D
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 00:10:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352700AbhERWL0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 18:11:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236372AbhERWLY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 18:11:24 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA828C061573
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 15:10:04 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id i22so15966955lfl.10
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 15:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gUqbTnERfQlA9FpQ+x6IqZG4L4yxkQHhw4MmocVh3QY=;
        b=FvCnWcb56yKF2FqOXH3Zt3PHvDmR1zyW2n3G+hKP5EhMQW7rFVZI4U3jWIXJZqQV8+
         h25LGnSllotmJvMZ2v6VTQE5MV7B3pNIYeXytovx3MTovDU4/+WGKw/tEFPuGqf/UR5j
         +adroXJKxvw81yWGTtfW008KBb8DMGhLA55MmCacHk67+qYcRkqdj0AouS2nkGazv8N/
         t+kajLJBjCKkZYVZRQhit85CpmGYhfJJYh6fAdq4c98ksq1sWk9U4PhIrACjJRfcoK1Y
         PWsD7L/AfZ2aO2/3cpCYfepsDHxn7nBJTsNxojGUY9u3HjpKe3fy8kcoEX9oRDIlY/O4
         9neA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gUqbTnERfQlA9FpQ+x6IqZG4L4yxkQHhw4MmocVh3QY=;
        b=sivudHaiNFVSohW4NxbNSfZn86E8+wFTosJVjwu43OJWStDzwfx9nxNyeyvz10CUBU
         fzE2W/iu6KfhIzSDREUVle08gLzsQRwi/Os42uvm83pS1/euAb/7j5+6iu68niggKYdq
         h2CbfgNqz22kN3d9Ybf6rpUTkCs7EmUsZUbPT8zZgs6iEUvJ8fDd4h0ZRSaHsYGTiXSC
         4PETQ4AbYCdLuNt3ybbhOaAcDE+boAzO0A5Hw2SByUPynsg/2x4yuailRJ7Oq7K2PiEa
         nxIXm6VpBkcTztaPgkEMsyg5ZpsXcKA2uJY4TdvTmja1nX8tSsk4rXxEhEPVPPLdppUN
         XfaQ==
X-Gm-Message-State: AOAM532hz8pOmWbSWOd8QoKG80mtwaMYfG3lqcUpcAWkG8eaiSws30V5
        WOI2I2UQ/xjy7eDbZJXBuDzt0xTHxxVwCs3FctYU/6rAryg=
X-Google-Smtp-Source: ABdhPJydRuX1IKk4wJeCw2SK5Ui/hbSgODD0qlwIJGviqOjSmkaui5IUyWaBsOubTCXqoO91ISfDH+Tgq/NqD7A1IBI=
X-Received: by 2002:a19:b0b:: with SMTP id 11mr5542481lfl.291.1621375803139;
 Tue, 18 May 2021 15:10:03 -0700 (PDT)
MIME-Version: 1.0
References: <20210518120633.GW12395@shell.armlinux.org.uk> <E1liydQ-0004Po-2c@rmk-PC.armlinux.org.uk>
In-Reply-To: <E1liydQ-0004Po-2c@rmk-PC.armlinux.org.uk>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 19 May 2021 00:09:52 +0200
Message-ID: <CACRpkdYoB9k-cGRCbXJ=WaR_brTm-w4zsYH2Co5h51qJ=yKshw@mail.gmail.com>
Subject: Re: [PATCH 1/4] ARM: change vmalloc_min to be unsigned long
To:     "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc:     Yanfei Xu <yanfei.xu@windriver.com>,
        Mike Rapoport <rppt@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hailong liu <carver4lio@163.com>,
        Tian Tao <tiantao6@hisilicon.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 18, 2021 at 2:15 PM Russell King (Oracle)
<rmk+kernel@armlinux.org.uk> wrote:

> vmalloc_min is currently a void pointer, but everywhere its used
> contains a cast - either to a void pointer when setting or back to
> an integer type when being used. Eliminate these casts by changing
> its type to unsigned long.
>
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Looks good!
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
