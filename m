Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9926B39D59B
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 09:11:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230212AbhFGHMx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 03:12:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbhFGHMv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 03:12:51 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB4C9C061766
        for <linux-kernel@vger.kernel.org>; Mon,  7 Jun 2021 00:11:00 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id a2so24547283lfc.9
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jun 2021 00:11:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pJqZi3n7j9AKUs/vG9dNnCAv8v6cQQzyBgG+YQYc710=;
        b=heIRpxVgLgVE9VbdvxJ9bVlbUFs3IX84r8llXAY0+5b8E1n7RAOm1a1166iWY/gOLD
         XNZxJFIkJuMW8RVuznJEipdDCSQJy5E+KgniSp7IQJREoBsna8hcz1a5SNFKQPui8rlV
         1M+8FU5U6Z8ol8maP+iXKxQbGasIkt1OOngMn6ssuSQydwLBYoEoFEhG/jB3vMor/Yg/
         rKFedQHC1A4TagAs5f5HunysdBj4CAlO3GRJzHS8zjVg1jS4CBcmgpjm/3NKKiGdZqqz
         G10Z2zZcFVddak+M2tb/wU6iy6I2xXgkwFQQSFPN8wyaPgHWKZem/NWPJHIrmkR+nbAp
         U9uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pJqZi3n7j9AKUs/vG9dNnCAv8v6cQQzyBgG+YQYc710=;
        b=lPITopOyCQFblwntU5GZQ1NtuL2XEK+D0b6yL1VGnmRezLCtC4J+n4cR7SlxPaJSme
         ovQpV3AHkKZu52E71mR2ZdR3kR4dYR93DSxhjMA4aflcjb58Gu7Ufxo123I3kxeiVN72
         Wht/gOccfjixuAOLRXzpLMl4dXJsakUXE8xJzQWVD0uQgxJnOjIquvWNQEcZpvawFGTB
         nHWgJwbBmsk7zaFKwzJdkPCiOspT+onp2KU09Aa7zELtB2HMPORONeUA2Uza0pW6Pkez
         ekmkZ3CoBhY9qKFTvvkR3R3jHWcrPLVL4QuP65e9ja/AmSudsyNmV2SQZ8SnAq/QjSxu
         ZiyQ==
X-Gm-Message-State: AOAM531zldWmppNTDG+o3g7xgjnGe9c7hR+YVc5vWQtO1TcLcNKcPDAX
        NCusY3deNOUFe8J+/Y9CDhcoX/z0myHwQ9CHiRgUQA==
X-Google-Smtp-Source: ABdhPJwVTqQeeEbNWKQksEGrk3q9M/AgF1nnmc4hYNxFcVK0tYr6p+ohPNX2kcVIGDfNigWTl/LzEZ/LN19HxvF2LHI=
X-Received: by 2002:a05:6512:3241:: with SMTP id c1mr11434271lfr.29.1623049858937;
 Mon, 07 Jun 2021 00:10:58 -0700 (PDT)
MIME-Version: 1.0
References: <20210604055536.20606-1-sergio.paracuellos@gmail.com>
In-Reply-To: <20210604055536.20606-1-sergio.paracuellos@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 7 Jun 2021 09:10:47 +0200
Message-ID: <CACRpkdbmu32csSoptceUcaVYxXSFwk316k5Ru09KCodvLXMOPA@mail.gmail.com>
Subject: Re: [PATCH v2] pinctrl: ralink: pinctrl-rt2880: avoid to error in
 calls if pin is already enabled
To:     Sergio Paracuellos <sergio.paracuellos@gmail.com>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 4, 2021 at 7:55 AM Sergio Paracuellos
<sergio.paracuellos@gmail.com> wrote:

> In 'rt2880_pmx_group_enable' driver is printing an error and returning
> -EBUSY if a pin has been already enabled. This becomes in anoying messages
> in the caller when this happens like the following:
>
> rt2880-pinmux pinctrl: pcie is already enabled
> mt7621-pci 1e140000.pcie: Error applying setting, reverse things back
>
> To avoid this just print the already enabled message in the pinctrl
> driver and return 0 instead to don't confuse the user with a real
> bad problem.
>
> Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
> ---
> Changes in v2:
>     - Fix commit message s/is/if

I just fixed up the commit manually instead, no big deal.

Thanks!
Linus Walleij
