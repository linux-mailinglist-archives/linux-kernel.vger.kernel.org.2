Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D3873446DE
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 15:15:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230272AbhCVOO7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 10:14:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230166AbhCVOOZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 10:14:25 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3635C061574
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 07:14:24 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id r12so21545639ejr.5
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 07:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=//tPuGWWU87DrG8mckDF+aLQVmpkf7JGyamDC0ugRSQ=;
        b=UwXgYWizC0bDdZzWB229/zIOPwM+lUSe1XMYUEVWrzhX0QXHcWENQBAkOdxC8i9N8V
         ZJneoaMrZgilbi9+fWxRShRnwLHcN3y59g39XychVt+/od+o8bNtAAQsVREP8NTVYXse
         fSu/bKtCd/kulgXJiup6CFG0nitpEzz7rlL/V4YvWRQxvrsMNnLHX7Cm6BOOFC9cUJdw
         rLIXipzNGXZpZtt2UD8oCEV0KYMci//RrgS9GHSAK9kbTgK+0e+3R55BaJlwBcc1wDRV
         2tgp+Fq9DIfUpVr9Zm0GZqQ2wA6+FX8IBAPUflfEjHCTh8lYGBVMmtz5C6+bsSJarbP3
         CQ+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=//tPuGWWU87DrG8mckDF+aLQVmpkf7JGyamDC0ugRSQ=;
        b=ozPz4zJ7kkj4/GWEvAkyGtfaL5uJZTkH5oiDlry/hmtnCwOR8m8aea7Aae9zw5cgqn
         2c0Kroh027x6B7cqIiNzf59j06bHpvE9S+pPE/ZNqW02wHXHmm9a1s6zsCiPJVrmRgop
         rshGf1bvN+7sDTQ8P07f4hc2vFNd61sTfPzDgvk8+hhYyIPzBVLyMIYdoKyMqMCIZEcK
         auyhHgGNNF9bnUeAntUvy4ua4I2aX4eKe6JXJi2VShVRlL2D5sxruxvq2zUxZm83SsJa
         mpL6UHQQObknnFDrZyDzstt+16+vVCz3/SlItyTIWV3bfGiyF/G4c6mG2zCvqnD1QCDl
         hDRA==
X-Gm-Message-State: AOAM530W8LzLDBBDcrsZYwVfDoDMshPRAiEbCKBMkCd4byx6EsG2HLyg
        oyo51ReqatuU6kaVwpdQgM6vr7cSbbTBDUHPHYz/CA==
X-Google-Smtp-Source: ABdhPJzOpI1mzrjCkPTC8hfktlI1u+OWWPC35iF94Xxluvm2r/SjYKYBEC/E3yeOAqSyVjHyO1gCjL0qnYBISWOIqVc=
X-Received: by 2002:a17:906:90d8:: with SMTP id v24mr19290806ejw.547.1616422463216;
 Mon, 22 Mar 2021 07:14:23 -0700 (PDT)
MIME-Version: 1.0
References: <20210322115602.4003221-1-arnd@kernel.org>
In-Reply-To: <20210322115602.4003221-1-arnd@kernel.org>
From:   Guenter Roeck <groeck@google.com>
Date:   Mon, 22 Mar 2021 07:14:12 -0700
Message-ID: <CABXOdTdePLDV91z4st2vErRLHEDn1ZD0x0AyO+JOwpatDQb17A@mail.gmail.com>
Subject: Re: [PATCH] platform/chrome: cros_ec_typec: fix clang -Wformat warning
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Prashant Malani <pmalani@chromium.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Guenter Roeck <groeck@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Azhar Shaikh <azhar.shaikh@intel.com>,
        Utkarsh Patel <utkarsh.h.patel@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 22, 2021 at 4:56 AM Arnd Bergmann <arnd@kernel.org> wrote:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> Clang warns about using the %h format modifier to truncate an
> integer:
>
> drivers/platform/chrome/cros_ec_typec.c:1031:3: error: format specifies type 'unsigned char' but the argument has type 'unsigned int' [-Werror,-Wformat]
>                 typec->pd_ctrl_ver);
>                 ^~~~~~~~~~~~~~~~~~
> include/linux/dev_printk.h:131:47: note: expanded from macro 'dev_dbg'
>                 dev_printk(KERN_DEBUG, dev, dev_fmt(fmt), ##__VA_ARGS__); \
>                                                     ~~~     ^~~~~~~~~~~
>
> Use an explicit bit mask to limit the number to its lower eight bits
> instead.
>
> Fixes: ad7c0510c99e ("platform/chrome: cros_ec_typec: Update port info from EC")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Guenter Roeck <groeck@chromium.org>

>
> ---
>  drivers/platform/chrome/cros_ec_typec.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
> index 0811562deecc..f07b7e946560 100644
> --- a/drivers/platform/chrome/cros_ec_typec.c
> +++ b/drivers/platform/chrome/cros_ec_typec.c
> @@ -1027,8 +1027,8 @@ static int cros_typec_get_cmd_version(struct cros_typec_data *typec)
>         else
>                 typec->pd_ctrl_ver = 0;
>
> -       dev_dbg(typec->dev, "PD Control has version mask 0x%hhx\n",
> -               typec->pd_ctrl_ver);
> +       dev_dbg(typec->dev, "PD Control has version mask 0x%02x\n",
> +               typec->pd_ctrl_ver & 0xff);
>
>         return 0;
>  }
> --
> 2.29.2
>
