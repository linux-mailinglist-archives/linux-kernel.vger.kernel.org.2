Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D621C42C3CC
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 16:44:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237578AbhJMOqb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 10:46:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236309AbhJMOqa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 10:46:30 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB205C061570
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 07:44:26 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id ec8so11212484edb.6
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 07:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=i6YmpBMDpvUqciTeeopqUBjl8BzBtSmMLDzw4bnotnU=;
        b=g8rAUh+kFRTFmlfkHBMXJ2/nccCJa3Ynk81USzQYq5btcl1ZPxHNeqaT0Vl6PAWNCI
         4SIuSHcdasBvAsJs7Qy/io5+NeCmm5JcaROxKyYrtmEHBRIoL6HnkASgaVz68VjguQUk
         JzL94VBaHU+1CWMbCCyuPDwbIeFvm6/cSFIKC9xwkdsei+hk+e70KmqjuNMlMn34e9qe
         3Wwr8EkatXWU1veRFZ2b5MaUjNWxiHRp40cXcMvr3Hs8VZG9pJ2sIfFA37TqMFNbMZfF
         iZU/1Kf8AbgeRN8kn9+pdEzDjzQcbJd9/WzOT03N4Y6bb9aJPS7cZ6vJSeRgRShEkQJY
         t8Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i6YmpBMDpvUqciTeeopqUBjl8BzBtSmMLDzw4bnotnU=;
        b=vGdqhlqdXa/8WHEPp6IZ/6KS9sbEZBdqP8F7sW3LkZozc39/jbIFC8WMGg4fUSsWTq
         PltR2nZ7IWJyAjTJpxMKbmQ8UpFWIkjfNqborCK4Kc3SJ98hQ4zkxqERvmZlqBBM+b6e
         hAnPZatyrWFSt/GpBwYIPv7I8Qehmjkl9ond7bpb3vsGDaWAZQOkHNpX7zWs+DBpJvCC
         JKf+vP/f7FzL7SlOcw1ZSWMjrmdUHC0SO3zO5MD5Ga/DREjCae+EixSulcf5EiCMuj26
         PbC61ozPayj+b+K/sg+zl/NFJlaHh9xSntiG4A9Yi9xjyrtvh6KOQrqzlULhOG+VA9QQ
         p8qg==
X-Gm-Message-State: AOAM531P488Nf952kQY/BFW7M+3BBBsSdmNYAmr+0xr1rTWt0Bs2Gtm1
        VtMToUPqwhT/5HzQtJXQyGVl21wMyH/H7IIvBfHhGERC
X-Google-Smtp-Source: ABdhPJzZpTdJ7emb46XqWMJlSJHnw4zoj66lDjO4a2CSC8gaYPY/D+pskCtu8Yv/I2DRiEcjawRWbiECwb4S4PLm7cs=
X-Received: by 2002:a17:907:764e:: with SMTP id kj14mr39374254ejc.349.1634136263872;
 Wed, 13 Oct 2021 07:44:23 -0700 (PDT)
MIME-Version: 1.0
References: <4369779.LvFx2qVVIh@kreacher> <2179627.iZASKD2KPV@kreacher>
In-Reply-To: <2179627.iZASKD2KPV@kreacher>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Wed, 13 Oct 2021 16:44:13 +0200
Message-ID: <CAMRc=MchN6+N_sgW6ZY4JiiVsy112S2_sc8uyqxjzFJtEAumew@mail.gmail.com>
Subject: Re: [PATCH v1 1/7] gpio-amdpt: ACPI: Use the ACPI_COMPANION() macro directly
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 12, 2021 at 7:51 PM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>
> From: Rafael J. Wysocki <rafael@kernel.org>
>
> The ACPI_HANDLE() macro is a wrapper arond the ACPI_COMPANION()
> macro and the ACPI handle produced by the former comes from the
> ACPI device object produced by the latter, so it is way more
> straightforward to evaluate the latter directly instead of passing
> the handle produced by the former to acpi_bus_get_device().
>
> Modify pt_gpio_probe() accordingly (no intentional functional impact).
>
> Signed-off-by: Rafael J. Wysocki <rafael@kernel.org>
> ---
>  drivers/gpio/gpio-amdpt.c |    4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> Index: linux-pm/drivers/gpio/gpio-amdpt.c
> ===================================================================
> --- linux-pm.orig/drivers/gpio/gpio-amdpt.c
> +++ linux-pm/drivers/gpio/gpio-amdpt.c
> @@ -72,12 +72,10 @@ static void pt_gpio_free(struct gpio_chi
>  static int pt_gpio_probe(struct platform_device *pdev)
>  {
>         struct device *dev = &pdev->dev;
> -       struct acpi_device *acpi_dev;
> -       acpi_handle handle = ACPI_HANDLE(dev);
>         struct pt_gpio_chip *pt_gpio;
>         int ret = 0;
>
> -       if (acpi_bus_get_device(handle, &acpi_dev)) {
> +       if (!ACPI_COMPANION(dev)) {
>                 dev_err(dev, "PT GPIO device node not found\n");
>                 return -ENODEV;
>         }
>
>
>

Acked-by: Bartosz Golaszewski <brgl@bgdev.pl>
