Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0608141013C
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Sep 2021 00:28:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344678AbhIQW3t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 18:29:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232719AbhIQW3r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 18:29:47 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FCB0C061574
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 15:28:24 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id b15so20415196lfe.7
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 15:28:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ATG5NnjBZl5uROxRiGQuGsgW+WoiTqVTfaTtEyWboD4=;
        b=GIxqeNwHyHeXl9iWMRj3tvHiLtIR8wE8ZDUo49LZQyHArLZ5Y8u5tw9G02aO7GfZSr
         d4RiONMGCMitnH03p/SPXvtPRfw93zOOagGcWOIiNwhcTOuc5p7DL00jY22JfoDQ/0iu
         7bkKj1eIsUgbIpiOSHKqnGnXToC3qmkdxpp6z6KKBsGatuAnXsacWt/IVR3vy0zGi0DH
         Adsc+WdzyRa3R00hPVKRIsrckqyqlxosWyPOFI8ihA2HgIJLhTzmGuvHqQcNUDJnBlRQ
         F0DUlyuusMf+8Dgjl0h2SWMmpRdhBi487vWd3auyOndzagE9ZllRxv25dHsKZ5cHyCZJ
         PCnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ATG5NnjBZl5uROxRiGQuGsgW+WoiTqVTfaTtEyWboD4=;
        b=h1Wp5ACEWa0soMXt7j8YUkxq1Av4piIGSno9SbK34nXILMtAEx6s5NvamR+kgEmRZP
         p+trM6zqLs5TiDnw3YDO2ENTPdR57+LhQCeOYYgrwOnF2iWUAItKn6PkcKWw3so8+TLl
         PVCqIJa7H4Pbs/9aER1MuPmG21ozEjoOq+54Bn4vqo23U3lGdX5CtImRDCQFVcUnMtMe
         NZxKqX2lgiAMK2xOm1HfpjNq6k8+lwU7hVygYZYAWiSJJXK2Mhzkyi1vGJ2StRVMCias
         Tcusahck3TAuDxhwwpmH/henenBXJRqKvePgGDP047EE8A/SAVTY8H8AZc9YbLpQfPow
         Zp2g==
X-Gm-Message-State: AOAM530MiH9PBMwS78RfhSQpOycdBZb5zRbgDk49g7GBTx03daXfU9Ab
        nKtSy89bZ/FFQP/5Tc/kDxKgqbIEP1OmOyDHMlF2gA==
X-Google-Smtp-Source: ABdhPJyJzS6Eh5ph0KTz0AHFM3V7mMDZRHus4peWL04EIpE/0/VyQ76dzmHnSnuRLtGQVLTH7syzF4tuj9ZRm7UveqU=
X-Received: by 2002:a05:6512:12c4:: with SMTP id p4mr10112672lfg.72.1631917702757;
 Fri, 17 Sep 2021 15:28:22 -0700 (PDT)
MIME-Version: 1.0
References: <20210911042925.556889-1-linux@roeck-us.net>
In-Reply-To: <20210911042925.556889-1-linux@roeck-us.net>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 18 Sep 2021 00:28:11 +0200
Message-ID: <CACRpkdYjSX0_y_N5nQweenfDMJYa3OEimbweN5XCVQeGsq+cBQ@mail.gmail.com>
Subject: Re: [PATCH] watchdog: ixp4xx_wdt: Fix address space warning
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        LINUXWATCHDOG <linux-watchdog@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 11, 2021 at 6:29 AM Guenter Roeck <linux@roeck-us.net> wrote:

> sparse reports the following address space warning.
>
> drivers/watchdog/ixp4xx_wdt.c:122:20: sparse:
>         incorrect type in assignment (different address spaces)
> drivers/watchdog/ixp4xx_wdt.c:122:20: sparse:
>         expected void [noderef] __iomem *base
> drivers/watchdog/ixp4xx_wdt.c:122:20: sparse:
>         got void *platform_data
>
> Add a typecast to solve the problem.
>
> Fixes: 21a0a29d16c6 ("watchdog: ixp4xx: Rewrite driver to use core")
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>

Thanks for fixing this!
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
