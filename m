Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BEFB389A17
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 01:51:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230026AbhESXwZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 19:52:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbhESXwX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 19:52:23 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 348AEC06175F
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 16:51:03 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id p20so17566680ljj.8
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 16:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0sYniuRP4wqiZIQyuEg/qe+aI6tAjP7d/4JXDzHYsZE=;
        b=oJSxYQ20m+wQOda1P23ynKuBf7Os0nvDkxJdPhD3ae9EpqZJ5EJcbVWaetqjgDTChG
         m+UY5QlrVyWMNXVavl7mV5o+QVfRaiwokaHzsQGeQaGDwkKV/dNDXu4NH9+7FAntM2ur
         vckz0r40XkvPQz3ECPnAoSbDHtpqPxvizAHIOrtnT/doJd9ny6law0sNeMYJ25K7cqLL
         Qer717RNGQ3xHnLCin95829gw8zCa2fjgrwDm7FPgGZg+RT3jUGxnLDR6t8685XzVznU
         OXJ/DbXA2usE53/9Cse6ll586+207AxFauPM4/y/+XbL5LZaG9zemRENkuUZA/1a2Djy
         GGKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0sYniuRP4wqiZIQyuEg/qe+aI6tAjP7d/4JXDzHYsZE=;
        b=nJ9FTrMIpJgcUDR/gNCdTgkRSZqcnqTiIAlBvppwHBkruApqGHUjoWs6jvpIgDYXgs
         sfL+bqNkHOBt3UfiQEPuZAuti8GpLUnFi7hrRoMRN2hbLWRIzbo4UezX+kypwebW6WJC
         W0QnglA1k3427T5GQpAmi6xBBgX/y/B5vaWBDO5hA31QJfEEPw1WKPWwGEJHu7RJA/Lx
         Go27WQQ/fXyKnyir3nvXIa2Jm4VLpJQSVYgYZqerjsobAPKK94cfVBtMjk2iM1Pp7xKh
         6kKeCz5/1Gto6OhufMYdRcEfUOqIPMK/BZtXWCVUdStKFVrUPBLHeiU4tIbvj/0xy/10
         02Yw==
X-Gm-Message-State: AOAM533402g/ubBB04+hXmHUzhNpgx8mCcUWpXxNy1aOh9n6gfBQcelE
        grtVim5NcaT4Jk+VtHbIAxqlvfXQ+I3hwqt5agXDeg==
X-Google-Smtp-Source: ABdhPJwp8DSHuZ2aQWqeW88esMeyMWsFvWsiq/HWOPEM1egcEKRRQzdxAwFFE9gysyEhGpY+ZAwyRtwQA5Uc0QHZTJg=
X-Received: by 2002:a2e:889a:: with SMTP id k26mr1150709lji.438.1621468261465;
 Wed, 19 May 2021 16:51:01 -0700 (PDT)
MIME-Version: 1.0
References: <20210512210316.1982416-1-luzmaximilian@gmail.com>
In-Reply-To: <20210512210316.1982416-1-luzmaximilian@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 20 May 2021 01:50:50 +0200
Message-ID: <CACRpkdZpm4w6Ym2p9xTsYpkU7CR531aLUUxXj54tssoqd6c9=Q@mail.gmail.com>
Subject: Re: [PATCH] pinctrl/amd: Add device HID for new AMD GPIO controller
To:     Maximilian Luz <luzmaximilian@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>, Sachi King <nakato@nakato.io>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 12, 2021 at 11:03 PM Maximilian Luz <luzmaximilian@gmail.com> wrote:

> Add device HID AMDI0031 to the AMD GPIO controller driver match table.
> This controller can be found on Microsoft Surface Laptop 4 devices and
> seems similar enough that we can just copy the existing AMDI0030 entry.
>
> Cc: <stable@vger.kernel.org> # 5.10+

Why? It's hardly a regression?

> Tested-by: Sachi King <nakato@nakato.io>
> Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>

I've applied the patch for next without the stable tag for now.

Yours,
Linus Walleij
