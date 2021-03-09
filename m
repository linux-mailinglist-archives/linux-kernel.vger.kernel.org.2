Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71CFB33249F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 13:02:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230372AbhCIMB6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 07:01:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230183AbhCIMBy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 07:01:54 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAB71C06174A;
        Tue,  9 Mar 2021 04:01:53 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id u4so26663201lfs.0;
        Tue, 09 Mar 2021 04:01:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tNgJ/13OtvwF9T9vbyUBrplwIfPpk37A2INU8/7rV6k=;
        b=qlMi95vQwcItgwgFEnUyvqFWG1fYZ1SviJ++bBW5EimlJei48ImOA/y7Ahp5y3OOHW
         FQQaRs4wYjP+oV8hHPayS7IJn8bLn1BIII6z9++3ERMykw2dzLEqUlJsfno6tFnyWVKh
         ai4hdFbNgVqQxHYM3yVKbyjuB/V/TPgTeMKRr0yGycpOojA5E/E9WDXfba/NFgfTOAGp
         6Dtqlzg/BRWs/GMfus/Ovw46N2z434QPZMsGaFxkPUIK7QxqQmjF2nzD+zGGqaM78h+C
         02zahWd56DZDjZXZdqppPayuoXdh0Be/c8EcYrKC79Vvuhox1AjOSysa1K43aR0Vy2W6
         YkyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tNgJ/13OtvwF9T9vbyUBrplwIfPpk37A2INU8/7rV6k=;
        b=BYWn0N97YSnWEU1vuGHlJnnAuCtDdic/oYwRFCOUJyTvfQG7NIWjmKfb/tUHJa9Ips
         K8sGyYx1lBHmFD/z6FG+wzjEHocbvOgKaigicdH85l+7jLksDVh75ncxuhrfSSC3/O9f
         SB8hOACwz5zuJ3U/QBxQE36KH/NvAfaZBqOH03pWBAPukXE2UQq1+kKWfspfvPjsBtTr
         iJzYEeKQKy4V+JnKI3RAankAs86ONwTuqzhDceUrSOYkjTOat1MXAMQbFeOMrDzThwPr
         rZzxKINLq++XLeSflbAhw+zA2Av20fb1r0mYk1dwvhf6WXUGdoMu8QcM7go4WuZvtOSY
         +B4w==
X-Gm-Message-State: AOAM5339SDz7hSPNiNtL0mi2785kEtjAzX3xogDxHoNMBP01wWY4l/59
        qeh8ZFbRV5Lb9QBDOSah0ZmfJCHbu9cjgp8+YD8=
X-Google-Smtp-Source: ABdhPJzb/XFcufOkuakq7r1+apy6JsOG33ywNv/IFeHphXrlWgDJX8xgaT2YLBA6NYp5oibxMN5tjKOwcasypuZK4PE=
X-Received: by 2002:ac2:520f:: with SMTP id a15mr16719769lfl.223.1615291312274;
 Tue, 09 Mar 2021 04:01:52 -0800 (PST)
MIME-Version: 1.0
References: <1615270520-16951-1-git-send-email-dillon.minfei@gmail.com> <1615270520-16951-2-git-send-email-dillon.minfei@gmail.com>
In-Reply-To: <1615270520-16951-2-git-send-email-dillon.minfei@gmail.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Tue, 9 Mar 2021 09:01:40 -0300
Message-ID: <CAOMZO5CUekq_NSCag=fhGrNuxvt_E335Z+qYWCHi8sP8zKJgXg@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: imx6ull: fix ubi filesystem mount failed
To:     dillon.minfei@gmail.com
Cc:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Parthiban Nallathambi <parthiban@linumiz.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dillon,

On Tue, Mar 9, 2021 at 3:15 AM <dillon.minfei@gmail.com> wrote:
>
> From: dillon min <dillon.minfei@gmail.com>
>
> since Micron MT29F2G08ABAEAWP's ecc error management:
>
> |Description                            | Requirement
> |Minimum required ECC                   | 4-bit ECC per 528 bytes
> |Minimum ECC with internal ECC enabled  | 4-bit ECC per 516 bytes (user data) +
>                                          8bytes (parity data)
>
> to avoid unnecessary overheads related to bigger ecc calculations.
> need choose to use fsl,use-minimum-ecc, else will run into ecc error.
>
> [    9.449265] ubi0: scanning is finished
> [    9.463968] ubi0 warning: ubi_io_read: error -74 (ECC error) while reading
> 22528 bytes from PEB 513:4096, read only 22528 bytes, retry
> [    9.486940] ubi0 warning: ubi_io_read: error -74 (ECC error) while reading
> 22528 bytes from PEB 513:4096, read only 22528 bytes, retry
> [    9.509906] ubi0 warning: ubi_io_read: error -74 (ECC error) while reading
> 22528 bytes from PEB 513:4096, read only 22528 bytes, retry
> [    9.532845] ubi0 error: ubi_io_read: error -74 (ECC error) while reading
> 22528 bytes from PEB 513:4096, read 22528 bytes
>
> Fixes: f9ecf10cb88c ("ARM: dts: imx6ull: add MYiR MYS-6ULX SBC")
> Signed-off-by: dillon min <dillon.minfei@gmail.com>

Reviewed-by: Fabio Estevam <festevam@gmail.com>
