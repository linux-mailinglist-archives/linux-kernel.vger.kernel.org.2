Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23B5644BCDE
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 09:29:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230322AbhKJIby (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 03:31:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230286AbhKJIbw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 03:31:52 -0500
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0375C061764
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 00:29:05 -0800 (PST)
Received: by mail-oi1-x22e.google.com with SMTP id bf8so3880903oib.6
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 00:29:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=f7rHKPXF7IbvrxgZBgwaRfmurIG9HqN9DpJB72wC+bI=;
        b=TuB7tlTlxNHJ06giSMcvKP5BOduliRU9Wes+BVl8jRlSWGR3FOyQqy+C6b/4/JF22I
         xLP1ip3PpAsa5FPNqLzHoXDq9IQlGTO2CQ2v/acPdM3w5ZysyMIyMC8AarTjopkU7Eue
         x7YjTocStBQ45qy16SWD2Fejhl16N3PrMRDNR6q/SGfIFm5vXWXHtaTjQ5F0Hjh8ABnS
         +8TQFzoFcl2LmKr7Uue/nnd1fcfUVsR8DEkDxgnRBbruYHHHs+wh9PZ67QbtQKtMuIYQ
         oehJVgH8VUG0UFomg/6EedRCxpDDMmrKiiY98mlS/mUv1HxTbnHm7lQ6JP/s/qxur8sb
         B2xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=f7rHKPXF7IbvrxgZBgwaRfmurIG9HqN9DpJB72wC+bI=;
        b=JT69OWxGWp+zGu65KHskHFDu9OCy5r76ipWQJyDHOV/fbecDnJcIN4MYQHPqWmyB6J
         KBhoCy+zGMOFjCy6T8wiGlAr7WQp58S/2XeUIOV0zsOHjdw9kZDSIveYIw7MvE/LaZvq
         PUyrIPajRxqzIW6qfNTg99bYFg0HD+E6NbdVoiDqh20vkgh7OpRF5fD2w4GV1IIX7yBE
         kwqz6jRsRY4zR+BdAstL3PXX5BLCTxoBGroTPYXXD9Ec8J/fnLgYIVOJEyKkuCrFeOKu
         gOcXywybVZB7lyKwDxSYAzvLhpy+e9VnQa5hLxUqRQ7g91KGis7Y23YdBPrPHBRgyuKM
         7URA==
X-Gm-Message-State: AOAM531Bgfd6lYn4jVPnp1dPsExdxGObuqVuHl3bL9CqzHRw/UuPzUv1
        yGUb4eLwJuKPlvn47czovh2dtcUWfSL/4z7QmpgE6Q==
X-Google-Smtp-Source: ABdhPJyaEL5vlz5N6A4nMGJI6OOxAb6rO5+DSFGzls44RzkLp58y9QExK/RBI8PkIc3s+dGBR+D8Ys2jtTo0M+HHy4U=
X-Received: by 2002:a54:4791:: with SMTP id o17mr11897170oic.114.1636532945359;
 Wed, 10 Nov 2021 00:29:05 -0800 (PST)
MIME-Version: 1.0
References: <20211028141938.3530-1-lukas.bulwahn@gmail.com> <20211028141938.3530-11-lukas.bulwahn@gmail.com>
In-Reply-To: <20211028141938.3530-11-lukas.bulwahn@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 10 Nov 2021 09:28:53 +0100
Message-ID: <CACRpkdakmQinPTHfV7m_Zbwh78k12gf9if4b1xiyEEW004KDCg@mail.gmail.com>
Subject: Re: [PATCH 10/13] arm: nomadik: drop selecting obsolete CLKSRC_NOMADIK_MTU_SCHED_CLOCK
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Russell King <linux@armlinux.org.uk>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Sekhar Nori <nsekhar@ti.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Linus Walleij <linusw@kernel.org>,
        Imre Kaloz <kaloz@openwrt.org>,
        Krzysztof Halasa <khalasa@piap.pl>,
        Avi Fishman <avifishman70@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel@lists.infradead.org, openbmc@lists.ozlabs.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 28, 2021 at 4:20 PM Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:

> Commit 85b6fcadcf66 ("clocksource/drivers/ux500: Drop Ux500 custom
> SCHED_CLOCK") removes a sched_clock workaround and its corresponding
> config CLKSRC_NOMADIK_MTU_SCHED_CLOCK. Since then, selecting
> CLKSRC_NOMADIK_MTU_SCHED_CLOCK in ./arch/arm/mach-nomadik/Kconfig has no
> effect and ./scripts/checkkconfigsymbols.py warns:
>
> CLKSRC_NOMADIK_MTU_SCHED_CLOCK
> Referencing files: arch/arm/mach-nomadik/Kconfig
>
> Simply drop selecting the obsolete CLKSRC_NOMADIK_MTU_SCHED_CLOCK.
>
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>

Patch applied to my Nomadik tree!

Yours,
Linus Walleij
