Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 008E837BC19
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 13:56:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230217AbhELL5F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 07:57:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230145AbhELL5E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 07:57:04 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BE62C061574
        for <linux-kernel@vger.kernel.org>; Wed, 12 May 2021 04:55:56 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id l7so30316682ybf.8
        for <linux-kernel@vger.kernel.org>; Wed, 12 May 2021 04:55:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aNPb1/57+5ny+pvaCXDmUs3FXsI3utW5iRWUWfHbabI=;
        b=FJOxExQtPoHD1RHrcjDEaob9dDt5Wqym1gYzphjMrHEqE7740cdgfWxvY6SuIznd5U
         wR5gtt6cBZLJEz+HFUJjc2Yz/Oqk21pcVTj+LAw7p3BhiX4sCYMvMCOadI9TkbHOGlxM
         YbT+zSSe/ADP4ZnULjhsLHvDLLLpnCKI9RUbtKoP9Jy9jvvhR56GKL+fjc7+4nEFNuaS
         gzEQ176lPHqGBITWds8rFjX1VPANHo4Xkn6fSsM5k4DaOFnpZvNieqdCo67W19wdX2D2
         a9HhQTiAq+Q0z/dZB91FbR3b93UwqaJEi7/FMJ7yIBkejWfK6K+lImMJ5IE9VaRrskcG
         DcdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aNPb1/57+5ny+pvaCXDmUs3FXsI3utW5iRWUWfHbabI=;
        b=IHkQh83rVoPI4p7A8O1b3XqAV8v1cLCEc1mXemnv5thNTkT+6Yre9X4bNIO4rUCtlL
         sRTT+JG5heYjDjs4TBcs5husg5TQuYw8JrrMEMer++RjojbEvVnqUlU83KJ0QWq9RjA1
         NknMVBERwTXczZ3R9BpsgUjtAQ6QRKuf9CJIE17TC0PGrbfhNqQFIHFbfHrWcVbVMS4W
         JlE5CWXoZ3V1/gCGWaIquNWUxwCrrhLRnjNQ4ND5chbRGGUVmzYHKBxvS8piGhv1t+Xs
         eB7xeCIDbdTxoopHAoTRrYdK2XdnZmQv4MV5Kpkb0V5wbk4c0MqJtKFiaB4/wSzdjkyb
         oQ3A==
X-Gm-Message-State: AOAM531fxkkEYEsCTBlcAzvh0ZVUlBtDXTTh63CQ8XGlZ1FdsV3FfNFs
        q7BD46ubxE/fPzLd4cjNPutb1CucBN+nYADejg9R1w==
X-Google-Smtp-Source: ABdhPJwZcRGvQGKt99glxvdWCFBLUljr0pyP1dW5k8kK5RnI0ZS+M4PeURiB/d1gE4Dtw3oxk/386eXqpaAuWByMSqY=
X-Received: by 2002:a25:238c:: with SMTP id j134mr18215223ybj.302.1620820555592;
 Wed, 12 May 2021 04:55:55 -0700 (PDT)
MIME-Version: 1.0
References: <20210510194633.11943-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20210510194633.11943-1-andriy.shevchenko@linux.intel.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Wed, 12 May 2021 13:55:44 +0200
Message-ID: <CAMpxmJU0vreXf-5bEwk07oDdvOLP4rU507_Q-W3=CDQ43s+W5g@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] gpio: xilinx: convert to use bitmap API
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Srinivas Neeli <srinivas.neeli@xilinx.com>,
        linux-gpio <linux-gpio@vger.kernel.org>,
        arm-soc <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Yury Norov <yury.norov@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 10, 2021 at 9:46 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> The change in the series has been inspired by [1], which, I think,
> can be improved. Here I present the view how it may be done.
>
> [1]: cover.1617380819.git.syednwaris@gmail.com
>
> In v2:
> - folding followup fix into patch 4
> - added Tested-by (Srinivas)
> - added Ack (Yuri)
> - added Rb (Michal)
> - rebased on top of v5.13-rc1
>
> Andy Shevchenko (5):
>   bitmap: Make bitmap_remap() and bitmap_bitremap() available to users
>   gpio: xilinx: Correct kernel doc for xgpio_probe()
>   gpio: xilinx: Introduce xgpio_read_chan() / xgpio_write_chan()
>   gpio: xilinx: Switch to use bitmap APIs
>   gpio: xilinx: No need to disable IRQs in the handler
>
>  drivers/gpio/gpio-xilinx.c | 385 +++++++++++++++++++------------------
>  lib/bitmap.c               |   5 +-
>  2 files changed, 198 insertions(+), 192 deletions(-)
>
> --
> 2.30.2
>

Series applied, thanks a lot!

Bartosz
