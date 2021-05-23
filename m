Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BBF638DBCB
	for <lists+linux-kernel@lfdr.de>; Sun, 23 May 2021 18:04:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231881AbhEWQF3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 May 2021 12:05:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231800AbhEWQF0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 May 2021 12:05:26 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 979B6C061574;
        Sun, 23 May 2021 09:03:58 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id y7so11516374eda.2;
        Sun, 23 May 2021 09:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gJkD6i4SEo6SHdZ7GGHPrHMiskGVfh8CdW3Nufpvn2I=;
        b=CnI3Abzt5Xv9BhXQL8KS9PW5422NN27D1tSFTpWB4Knv/ZRbOmrQ1ShJYV9KlqeGHS
         z7Fe4E7REfieJoL5gru+JIA1CUtP5Bhrn8Zp54hRj4apLyiRkK26gDNXlL/C4Im/NCpi
         BNqOYkHoIJCH8en6v7t4x2mrcOGf8k+MSGL6fTt3478Dou+Zeuhynm0cDXoc0hG8pzPJ
         Tb8FGtTw2RTOBQGnSkSFnS49eAApdPQYIv7HKTS4/xHBnSD+PMKBCm2mmOl+6fSAT7GA
         ovFDq21Va8xrotyiZVPDxWiGC1wLh3V7uPvJxHRXlGrD0g+kfn69UrKiFhnQ5xAoqAKI
         guCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gJkD6i4SEo6SHdZ7GGHPrHMiskGVfh8CdW3Nufpvn2I=;
        b=A7jifdV87PDyktMdQ0u4Eyf3496V+UtGUucKRgDHCGbJSVj55uHWZQWGYAt1ezB4g9
         w9/vOUFQOUuzNnEwasuM7B4g893Xg9fbgBU8DTZwG/Vw5bGV6/2JNMTMO3bht3EazepQ
         OYc4yJDDV/VNn2NkJhiUA9j9avG/vOc0LkqHtItTiHlKwSGbdqI53iP4MCOq7xyLHMTN
         kco7hwa4Lz7UqrfabaKaxiCHuiSQUqI0d78tKkvIgZRRdmc3PgHjtPAjeURZB9kVpkuC
         IqlNdBRpY4bD3USn0eF11JxIAuKTpn9HPBLxx8W7xNowizeJL8BRoxT21lq/EaoIPr+W
         YOSQ==
X-Gm-Message-State: AOAM533wROP7SL8EbUmzJw1B3N8b7AdDp4YodvstOyd2PLQpPQg1q7Of
        GUMVjyG7tYvf0ei86gunr2EZmsOhao88CkeXurU=
X-Google-Smtp-Source: ABdhPJxFDpHabe9W6/7esigrOS2kY4rmQITdh3xVTXAkjKPgodavQcSx3o8iM0vUCzjfrFm/ao20QTXEe9xq6Na96dM=
X-Received: by 2002:a50:9346:: with SMTP id n6mr21297997eda.365.1621785837181;
 Sun, 23 May 2021 09:03:57 -0700 (PDT)
MIME-Version: 1.0
References: <79df054046224bbb0716a8c5c2082650290eec86.1621616013.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <79df054046224bbb0716a8c5c2082650290eec86.1621616013.git.christophe.jaillet@wanadoo.fr>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sun, 23 May 2021 18:03:46 +0200
Message-ID: <CAFBinCCBo4fYoO=2NiWTEixPuJo2Q=J1o1+yfi4Oc32SLi=GAw@mail.gmail.com>
Subject: Re: [PATCH] usb: dwc3: meson-g12a: Disable the regulator in the error
 handling path of the probe
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     balbi@kernel.org, gregkh@linuxfoundation.org,
        Neil Armstrong <narmstrong@baylibre.com>, khilman@baylibre.com,
        jbrunet@baylibre.com, linux-usb@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christophe,

On Fri, May 21, 2021 at 6:55 PM Christophe JAILLET
<christophe.jaillet@wanadoo.fr> wrote:
>
> If an error occurs after a successful 'regulator_enable()' call,
> 'regulator_disable()' must be called.
>
> Fix the error handling path of the probe accordingly.
>
> The remove function doesn't need to be fixed, because the
> 'regulator_disable()' call is already hidden in 'dwc3_meson_g12a_suspend()'
> which is called via 'pm_runtime_set_suspended()' in the remove function.
>
> Fixes: c99993376f72 ("usb: dwc3: Add Amlogic G12A DWC3 glue")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
for me this makes sense so:
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

> ---
> Please review carefully.
>
> I'm not that sure about:
>    The remove function doesn't need to be fixed, because the
>    'regulator_disable()' call is already hidden in 'dwc3_meson_g12a_suspend()'
>    which is called via 'pm_runtime_set_suspended()' in the remove function.
>
> This is more a guess than anything else!
I am not 100% sure about the suspend code-path, so I am hoping that
someone else (for example Neil) can also review your patch


Best regards,
Martin
