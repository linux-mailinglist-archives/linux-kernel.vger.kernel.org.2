Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 218FD4139D5
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 20:13:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232487AbhIUSOv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 14:14:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229990AbhIUSOr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 14:14:47 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ECDCC061575
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 11:13:18 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id g41so1179675lfv.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 11:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EW1vW7sWjftd7hrs0dLX4IMwefEJeY8UuH5WCPSWExA=;
        b=LZJuB9HS05MS44ICxvif8myY5ie/+eFNBBomTnoXTSqdYFutmN16Rl/OjOLkZZh6jQ
         72pjRft7V+Wg6EUsnSOgvRWWq82TlnqfhIMtpVZDHpU7AnAXxIhhHDjqFLeMBbO7op3M
         v+4rG8XZGjTqtzgkqZQt07pEhpBpxQS1aBjTk+4MBijZG5ISNv7YFGJwaTxUe8F3hvH3
         1qZ1QCO2vr+49tpOCMCCLQHXfvzLfpUt/Y9QP6NAySr9mkROwv7XaqX0F/8RLQRLgFri
         O8v6fRSXBZax1tldtMvaevvAoGhAxOFmu+vocFyUGYkt/45OxJgu7tC8JPU6fF5KeKT8
         3M8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EW1vW7sWjftd7hrs0dLX4IMwefEJeY8UuH5WCPSWExA=;
        b=K7llpAFlWWp3zVuKfz8Izf7KA2KcMJ8fJKLYjUcL+HZXFF8VCyomCEATc6V2pPKcBJ
         +d7QbslZHsVhO38eW2UX9HucJMDxHncIDdgmsmZe7Yp73Wq9qvYB3OuWP7VZnxkSN/NM
         alqUxPaf8nbQadDsGtjsaU5rC2Sx5A5FwaXeWm2Tds9S4Mwg7/CReS8Act2rQlArTpP6
         khd61FRMnHCqnzJXvGY4Y3nTd3h5Emx630jTf7Npu5sf/Zgc393//oNQurRDYedDNvP7
         mMuIFwaRadjNaAkn26j3TGdCM/4cnj3FcJTrfbw3EMRvqXUQb5sxQfZrzknPMmOOXKcY
         6lmQ==
X-Gm-Message-State: AOAM532PFb1IWy7O7E4gZg1lxoaXbPD9hCtw4/4KLddHzWIpbmklFBsC
        zMWxOjNylf+aCmluUmWa3hS5sxL6JKabh1EhK55jTw==
X-Google-Smtp-Source: ABdhPJyHNbMQuJb6Tgu7TZrvW5IeIkg4OaG9Y6i4c0e5aLwDyZE47u/VgQ/J+p/1JvRrc8gmONqFKIBQHcXEe0PYUGY=
X-Received: by 2002:a2e:b5a7:: with SMTP id f7mr29396764ljn.19.1632247996570;
 Tue, 21 Sep 2021 11:13:16 -0700 (PDT)
MIME-Version: 1.0
References: <20210921122146.13132-1-lukas.bulwahn@gmail.com>
In-Reply-To: <20210921122146.13132-1-lukas.bulwahn@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 21 Sep 2021 20:13:05 +0200
Message-ID: <CACRpkdbW+rP4mj6RWCAJRnW7yWTnfZXBcRnKO=mfdwFL-qVhGg@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: fix typo in DRM DRIVER FOR SAMSUNG S6D27A1 PANELS
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Markuss Broks <markuss.broks@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>,
        phone-devel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 21, 2021 at 2:22 PM Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:

> Commit ebd8cbf1fb96 ("drm/panel: s6d27a1: Add driver for Samsung S6D27A1
> display panel") introduces a new section DRM DRIVER FOR SAMSUNG S6D27A1
> PANELS with a minor typo in one of its file entries.
>
> Hence, ./scripts/get_maintainer.pl --self-test=patterns complains:
>
>   warning: no file matches  F:  driver/gpu/drm/panel/panel-samsung-s6d27a1.c
>
> So, repair the entry and make get_maintainer.pl happy.
>
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> ---
> applies cleanly on next-20210920
>
> Linus, please pick this minor quick clean-up patch on drm-misc-next
> (on top of the commit mentioned above).

Patch applied!

Yours,
Linus Walleij
