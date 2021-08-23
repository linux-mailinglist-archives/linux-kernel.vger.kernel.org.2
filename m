Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 945FF3F4641
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 09:58:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235443AbhHWH7K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 03:59:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235275AbhHWH7H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 03:59:07 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC811C061575
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 00:58:25 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id j13so11296620ybj.9
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 00:58:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=A4LdKTAjdulkWp1Ey9+qLuBWHOHSRlpXXa8uWwlXNjo=;
        b=GslNxTVCcaBeHsIHdetgMcBsNjshjeP/C6kPGlWqGcT78U70fD6TFPTuGye0Chi+x0
         IXwyzql5xIXrd/4S1mW8KoLCeV7ZI3oNe7CNNK0eE6qm5CfB+w5xOe7j1SL+47mRaNOe
         ShhB6r3ngHUOoYI6ZRO+tZ6dF5vniJIKdlrJehAFPO2ehLPLElmTAYxwZd9viBkZaY9O
         VQaJQmey03oZVBDbxJxm16JJqFbgn48h+gyzdxmQaqKcFBVHcPH9yrlysDmXez99T8JA
         XUMhjQSV47tT2xXnrEwjvugrx0bqSBcAssa04Gyqq6xqAku9Z3J/Xrya4U4qDd/V0qkp
         6CWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=A4LdKTAjdulkWp1Ey9+qLuBWHOHSRlpXXa8uWwlXNjo=;
        b=ei1FEYYsAO0VJYW8ATl17RDn2hRjvwjwT/GvGxv4MR1oTaY8ltogDRaMKQvkh/RMg/
         Erw8X1RLTsVMcS5nO1UWJxZgAad3XvsxvlJv0V3wqKjAz0DMptem+vedboxLrTZ6CqGU
         rq8Q10ZrwEh+uFj5RL6KDcDhbqBrbW7R/XVw19dOLNuwnAgzKvJZhe5Ixq6QsEqSoCCN
         8nOgJb+d/8nTGp1vDZt2qOC2K+5AmPfa3uCqMBGFcCRf4w2IcjMPGHdUoK+bRsUHkmKb
         GZWO/X2EjPg/p1Ip+/zd6gyZy+DDHukjcKqL5OL3OsdAEwNNto6u+RHSunX6XcPrgswE
         JOaQ==
X-Gm-Message-State: AOAM531seaT2HLaImvajaovLeLtnTE2XaE4ALhMJJtYEXxxUqDVLiQqP
        FoGpaSbcJp6WwiewAI7sWy2r6mD1rKiK0VEq3qWMMA==
X-Google-Smtp-Source: ABdhPJwjNaJ0hN3PHVi5IZ2QI8E+CCiS9LJzKyaG004QjwuuEnEOsH6ar0YZsZ6ezMCs/rcpcY3iHXosrDILyt8vmvA=
X-Received: by 2002:a25:abf1:: with SMTP id v104mr589768ybi.25.1629705505102;
 Mon, 23 Aug 2021 00:58:25 -0700 (PDT)
MIME-Version: 1.0
References: <20210817080118.9201-1-lukas.bulwahn@gmail.com>
In-Reply-To: <20210817080118.9201-1-lukas.bulwahn@gmail.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Mon, 23 Aug 2021 09:58:14 +0200
Message-ID: <CAMpxmJVvz8G4XgE=12HVNgcdgwLgWnDY7M7oifBpNT76O2YWUA@mail.gmail.com>
Subject: Re: [PATCH] gpio: remove the obsolete MX35 3DS BOARD MC9S08DZ60 GPIO functions
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Fabio Estevam <festevam@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio <linux-gpio@vger.kernel.org>,
        kernel-janitors <kernel-janitors@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 17, 2021 at 10:01 AM Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:
>
> Commit e1324ece2af4 ("ARM: imx: Remove i.MX35 board files") removes the
> config MACH_MX35_3DS in arch/arm/mach-imx/Kconfig.
>
> Hence, since then, the MX35 3DS BOARD MC9S08DZ60 GPIO functions are dead
> code as its config GPIO_MC9S08DZ60 depends on the config MACH_MX35_3DS.
>
> Luckily, ./scripts/checkkconfigsymbols.py warns on non-existing configs:
>
> MACH_MX35_3DS
> Referencing files: drivers/gpio/Kconfig
>
> Remove the obsolete MX35 3DS BOARD MC9S08DZ60 GPIO functions.
>
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>

Patch applied, thanks!

Bart
