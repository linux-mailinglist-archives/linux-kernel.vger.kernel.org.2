Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B62C33685D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 01:08:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229920AbhCKAIF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 19:08:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbhCKAHz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 19:07:55 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB5AEC061574
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 16:07:54 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id x4so29974973lfu.7
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 16:07:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kgq4Y5PHhYdVA57Cks4DEvoLb2HPLnl2GjvjQyQnhTE=;
        b=BJAs+tLZlJi11RsuQGLvzja6T+eulKzxor3UQfPfxutgav9ImPpdFrWrSDP9yKsl19
         CexOX3SackIZzgCPwC1QJVVO4agnzUBfiz2YcfW3X+Cpf5UJkNZm3AXKJ+IM+ywtdCDQ
         Vz+XpPv93qc/UVOsqTQGOi4pTmWzXAdyx3s2omaCbkCBKIqR3tZyDZtJw+99zLh8gwjG
         5qREnabnzZFLMnYmaP1/nTWAE+/ixA6REu8T69DBNI8lB2SVoVrXVnFL0JFsBObaDhlx
         ndm3ARMdXji28awuXA7o0K4H6H5J4Q67WH5JQgIotEziPVv4Dgbq63bLgC+eBgrrsjhh
         hMWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kgq4Y5PHhYdVA57Cks4DEvoLb2HPLnl2GjvjQyQnhTE=;
        b=aKdbNAEoFqQuF75GS+l/4XJEXZYoR7PM0QX2OM/OgWjbteM65TrWzN/cpg3V96ydN+
         tg8UMaps0Sn8tnx+UIaWxuJXetzYalsC3c1B5Z/wSjntQC4lhHRbHnXcXDEXPpK7T88Z
         xZgUUuHBVVehgLRihnAJr/Nk65TyPJYD86JoslNZ4uT5bG5E1t9hDfNyWlNKJAN6W4iY
         11pHm+20rvKzgsBLdeXILhy/awFfPCh2Oqqme6P8+PbPxY6pTFnq7OaV27quDrFF/zZo
         qSDeZgKhlnlaVM4kPegk1wzYd/CHtx4ZiC2vZ6ppy6ttdFymTMpAuNJn4nuBcJA0EthC
         87iQ==
X-Gm-Message-State: AOAM532yNl8GwgGu8iX2wndlyjLtCP/0ilBQiUksJM+pUgrhbF6aHdfk
        cX4CW9ddgBxo/9EMs9UzdBrl3WY06RZYqcDm+mRlnQ==
X-Google-Smtp-Source: ABdhPJwUappJtdm8yRMVifYLvbx0dllat4gXBrBmitf8oYZjjQAAkBgV6Ie6yTsSfetKd2qgPAzfg549AzQnJ2grqTA=
X-Received: by 2002:a19:4c08:: with SMTP id z8mr579121lfa.157.1615421273415;
 Wed, 10 Mar 2021 16:07:53 -0800 (PST)
MIME-Version: 1.0
References: <20210309205921.15992-1-brgl@bgdev.pl> <20210309205921.15992-9-brgl@bgdev.pl>
In-Reply-To: <20210309205921.15992-9-brgl@bgdev.pl>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 11 Mar 2021 01:07:42 +0100
Message-ID: <CACRpkdbdRrcTfhzvAMbBxyrvUQMJfc3FWJhgtLLGH1+W796Dgw@mail.gmail.com>
Subject: Re: [PATCH v3 08/11] gpio: sim: new testing module
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Joel Becker <jlbec@evilplan.org>, Christoph Hellwig <hch@lst.de>,
        Shuah Khan <shuah@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Kent Gibson <warthog618@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 9, 2021 at 9:59 PM Bartosz Golaszewski <brgl@bgdev.pl> wrote:

> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>
> Implement a new, modern GPIO testing module controlled by configfs
> attributes instead of module parameters. The goal of this driver is
> to provide a replacement for gpio-mockup that will be easily extensible
> with new features and doesn't require reloading the module to change
> the setup.
>
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>

This looks really useful and helpful and clean to me!
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
