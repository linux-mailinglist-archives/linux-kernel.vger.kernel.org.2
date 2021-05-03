Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F667371615
	for <lists+linux-kernel@lfdr.de>; Mon,  3 May 2021 15:41:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234341AbhECNlx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 May 2021 09:41:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:59390 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233582AbhECNlv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 May 2021 09:41:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1CA376135C
        for <linux-kernel@vger.kernel.org>; Mon,  3 May 2021 13:40:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620049258;
        bh=kDHp/u/XlkkElW5panY+EF4GuxDYCLM2E/E+MRBnmgw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=lDNOaBUD1+iVyLopOEazzUM26NZmQ5xx626vPAUEWjcNWOrG4oaERXYRqHapX4umo
         puLyrkFXqLO7vD7A3ER7nB5LafkSBF6WqlMrwjpL6PjlBssj08/gl9vV4gSweu4VCC
         33Riy2QXglPCoExcqxhcUaKXtDsruGICv6Tj5DMueVm0QvlXjZLMBkd5v3ZbMic+Zf
         ldYuX9JnDnnCg8C69EF10vZPiN6VeK6gy4VYjsTraXayey9yHPKcAo/mJTWQMjZ+9M
         vta7B9uu9SUPR3G/3C5c7upm0SH2t1eHRFiamgOVGHUPZ4SjZlt+uy8+nzacVcf5nh
         wvoXYqRsnPWgA==
Received: by mail-ed1-f50.google.com with SMTP id d14so6280700edc.12
        for <linux-kernel@vger.kernel.org>; Mon, 03 May 2021 06:40:58 -0700 (PDT)
X-Gm-Message-State: AOAM533IlAqqtfu6z5i5XquTrHVqQmdHS1XxkzO6IH7xARB5o9yj2glu
        YZOWSVrY1UfxhPyfw7659p5GbHRzntfJKkTmWg==
X-Google-Smtp-Source: ABdhPJxaUUj8YuV+bodAkcEIbkvlYFm/2wKUaZy6dbeGDfe+boHNb68By1TYcIoaJhsGVEJFWlOKAeRRg0p50rVCAiw=
X-Received: by 2002:a05:6402:1e4:: with SMTP id i4mr19837242edy.62.1620049256517;
 Mon, 03 May 2021 06:40:56 -0700 (PDT)
MIME-Version: 1.0
References: <20210503115736.2104747-1-gregkh@linuxfoundation.org> <20210503115736.2104747-68-gregkh@linuxfoundation.org>
In-Reply-To: <20210503115736.2104747-68-gregkh@linuxfoundation.org>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 3 May 2021 08:40:45 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+h=6o6tNpJ+mkB+RyiWY=R3S2_jW4cwWmBKsp8D=yTDg@mail.gmail.com>
Message-ID: <CAL_Jsq+h=6o6tNpJ+mkB+RyiWY=R3S2_jW4cwWmBKsp8D=yTDg@mail.gmail.com>
Subject: Re: [PATCH 67/69] video: imsttfb: check for ioremap() failures
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Finn Thain <fthain@telegraphics.com.au>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 3, 2021 at 7:01 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> We should check if ioremap() were to somehow fail in imsttfb_probe() and
> handle the unwinding of the resources allocated here properly.
>
> Ideally if anyone cares about this driver (it's for a PowerMac era PCI
> display card), they wouldn't even be using fbdev anymore.  Or the devm_*
> apis could be used, but that's just extra work for diminishing
> returns...
>
> Cc: Finn Thain <fthain@telegraphics.com.au>
> Cc: Rob Herring <robh@kernel.org>
> Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/video/fbdev/imsttfb.c | 21 ++++++++++++++++++---
>  1 file changed, 18 insertions(+), 3 deletions(-)

Reviewed-by: Rob Herring <robh@kernel.org>
