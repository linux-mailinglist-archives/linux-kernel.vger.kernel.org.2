Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4949389A2C
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 01:55:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230194AbhESX4i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 19:56:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230185AbhESX4e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 19:56:34 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AA9FC061760
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 16:55:12 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id q7so20335245lfr.6
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 16:55:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zJt4FvOdaHnERK7zPswPmt+3fi+oS0bIfqgJwwAG+cs=;
        b=J/puEMOqZ8T7DKVZKypmjoPKYZMTdm7d14F3rAgMbCOnsJToM3PxHQae9wcGe0qK+N
         1GbFwe+U3EFT1xj8JIqlx8z8eybFL2ZwItzst7aaCoYtGmxQv2XXNupjR0xn4X6k3mF2
         JSvrhlnnPppLwlydiZfepQUHKVhGW31Q5YRRJkK7zmr7AiLoqTsl4Kf8GR9U22edkAIq
         sAB8UGa/P2IQr/qz6iKBVH4BFfn1cqMKz9p0CQ20QFCV9+8F0FHaMi0jMop5a4HmH2tq
         ZB89rgPrhEmrOkDDNwkqKd/gDO05zbaYh3+XmoVpQgCol+MpN+jfG1aFoKGKRZe3Phum
         GxAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zJt4FvOdaHnERK7zPswPmt+3fi+oS0bIfqgJwwAG+cs=;
        b=L9ysiFNMn0nr2grkS0wFXcnxv+VTOdxcl8mGNl6KqPVEpsklJEYYi+F6ss+9QKoiQL
         jdvNnWGqbY+bwgiJZQOq2wL+LbRitcrQbtI+BlPi+X7EN8fACTIuoSSxCiWVeTiAx/B9
         Z+EQuqZypPQnvXkCWcN8ovXPX6DOt4QTiNVHz/0XWFr1UMEtJlBmSGuilfB5ngxfjxq4
         Y6bBzlADP5Frv0RdagbeiVE/SrRFS2WnrBN62N8u3mYbafIe2ZsTcJQslEzbrkfZUve9
         kpiNGWyBVbGGAnhkalt39bWA0wU+MYwiSiUH+66KoxvgLA7bE10c1Djf7Yuj1cnJtvte
         h1rA==
X-Gm-Message-State: AOAM530JCv9M8RQ+BZSk6jjjyssZO/X60O4KpW2qPB+1jWXSvnQg/7Vu
        isAPLkL9Ld/Sl1b1RFDhENhhBHoSr7VlsqlvHBiUxA==
X-Google-Smtp-Source: ABdhPJyfBZRTzjC/9N+poQDvG5+7aOsGGoNjXyeSwTGurMLagNUJVa7/uQRokc6Sj+EI5moCmHs3OO5kaEMwNq7bjU0=
X-Received: by 2002:a19:b0b:: with SMTP id 11mr1383425lfl.291.1621468510806;
 Wed, 19 May 2021 16:55:10 -0700 (PDT)
MIME-Version: 1.0
References: <20210516061425.8757-1-aardelean@deviqon.com>
In-Reply-To: <20210516061425.8757-1-aardelean@deviqon.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 20 May 2021 01:55:00 +0200
Message-ID: <CACRpkdb6Y4j0Pq5B+WaHy6akvczc-1foABFSq=uHpUg9=GL1GQ@mail.gmail.com>
Subject: Re: [PATCH] gpio: gpio-stmpe: fully use convert probe to device-managed
To:     Alexandru Ardelean <aardelean@deviqon.com>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        alexandre.torgue@foss.st.com,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 16, 2021 at 8:14 AM Alexandru Ardelean
<aardelean@deviqon.com> wrote:

> The driver doesn't look like it can be built as a kmod, so leaks cannot
> happen via a rmmod mechanism.
> The remove hook was removed via commit 3b52bb960ec6 ("gpio: stmpe: make
> it explicitly non-modular").
>
> The IRQ is registered via devm_request_threaded_irq(), making the driver
> only partially device-managed.
>
> In any case all resources should be made device-managed, mostly as a good
> practice. That way at least the unwinding on error is happening in reverse
> order (as the probe).
>
> This change also removes platform_set_drvdata() since the information is
> never retrieved to be used in the driver.
>
> Signed-off-by: Alexandru Ardelean <aardelean@deviqon.com>

Nice!
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
