Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4597D4016C3
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Sep 2021 09:11:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239950AbhIFHKu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Sep 2021 03:10:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239828AbhIFHKq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Sep 2021 03:10:46 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5426BC061757
        for <linux-kernel@vger.kernel.org>; Mon,  6 Sep 2021 00:09:42 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id n24so7448646ion.10
        for <linux-kernel@vger.kernel.org>; Mon, 06 Sep 2021 00:09:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=t6hG9tjceGU3kqViByrG+996KWcAe362teOFSdA60G4=;
        b=jSxDw3iEBpqW+qFNyYXJtKA0bpHj6GXzxG3qcwsmRo6dXmDQ2kSqURUZxgnfOczqi7
         6NuJ5GGZKkyRgg9nECZ08OiJi4xT+yRsTtOvo3WJJcHEQiqICpLq/CuS29QUNhS1AMWQ
         9TLsFanGHWEF5U/9caJd5zGEUYH6iPeTQO6Bc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=t6hG9tjceGU3kqViByrG+996KWcAe362teOFSdA60G4=;
        b=U5tOVOMx6AY2bCvt/QsH+qsvzoWA57wHyYtHGqlF0C1yJyNMi9Sm13ZpaxGAqVqdQ/
         K3aKb3KPPZtpWsPoePgQKW+1TkViJYXuoV2rZ8x8ZWftg1x+eA1GyBAQAML/dAmSJpUp
         5H1NG/5rabjz9bGDStScbOrgU+UMeDdPQCgyoCD6rA8IECe7xCZZEfAVtcQcdXDjmYX9
         RKRIG66QfyvwXZ1NCMfIz5xUtUEu10JMmH1Y9fUP6Q0fsXyEKtpJ1v6ShZQlySPZlTSr
         BVKhyy+WvC8Z+XCT35esmEs7y5oWVdYtWs5Cb+u5ciRfD/lR6iSuHStdZW0hQ8iwJitq
         80dA==
X-Gm-Message-State: AOAM5321mB4u92KmEW+j3DUMBlNSvsyu4o5rMqqVCJpBtDcaFT7rqGGs
        Rtvs7pwa8bECfjk3gaiHKvGDfEuXKm1NHw==
X-Google-Smtp-Source: ABdhPJyPekkoWW6uJ2SQxuQR04PEVaFccBvV6vO5gkhG3Ct6GwU9eISJvOCUdJlI1VBj0EyEY8VTuQ==
X-Received: by 2002:a05:6638:3782:: with SMTP id w2mr7175055jal.56.1630912181421;
        Mon, 06 Sep 2021 00:09:41 -0700 (PDT)
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com. [209.85.166.46])
        by smtp.gmail.com with ESMTPSA id d8sm4013769ilv.55.2021.09.06.00.09.39
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Sep 2021 00:09:40 -0700 (PDT)
Received: by mail-io1-f46.google.com with SMTP id m11so7467082ioo.6
        for <linux-kernel@vger.kernel.org>; Mon, 06 Sep 2021 00:09:39 -0700 (PDT)
X-Received: by 2002:a6b:f610:: with SMTP id n16mr8835657ioh.139.1630912179530;
 Mon, 06 Sep 2021 00:09:39 -0700 (PDT)
MIME-Version: 1.0
References: <4c96691f21293dea1c3584f80a58138e2a2f9219.1630736273.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <4c96691f21293dea1c3584f80a58138e2a2f9219.1630736273.git.christophe.jaillet@wanadoo.fr>
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Mon, 6 Sep 2021 09:09:28 +0200
X-Gmail-Original-Message-ID: <CANiDSCsJB-WMPwrfLK2i_oZHnS4Oo+WBx_inPDOfnDSXcAhhPg@mail.gmail.com>
Message-ID: <CANiDSCsJB-WMPwrfLK2i_oZHnS4Oo+WBx_inPDOfnDSXcAhhPg@mail.gmail.com>
Subject: Re: [PATCH] media: uvcvideo: Fix a memory leak in error handling code
 in 'uvc_gpio_parse()'
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     laurent.pinchart@ideasonboard.com, mchehab@kernel.org,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christophe

Indeed, there is a bug, uvc_delete will not free the entity because it
has not been added yet.

Thanks for catching it up.

Reviewed by: Ricardo Ribalda <ribalda@chromium.org>

On Sat, 4 Sept 2021 at 08:20, Christophe JAILLET
<christophe.jaillet@wanadoo.fr> wrote:
>
> Memory allocated in 'uvc_alloc_entity()' should be freed if an error
> occurs after it.
>
> Reorder the code in order to avoid the leak.
>
> Fixes: 2886477ff987 ("media: uvcvideo: Implement UVC_EXT_GPIO_UNIT")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>  drivers/media/usb/uvc/uvc_driver.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
> index b1b055784f8d..a4c45424ba7e 100644
> --- a/drivers/media/usb/uvc/uvc_driver.c
> +++ b/drivers/media/usb/uvc/uvc_driver.c
> @@ -1533,10 +1533,6 @@ static int uvc_gpio_parse(struct uvc_device *dev)
>         if (IS_ERR_OR_NULL(gpio_privacy))
>                 return PTR_ERR_OR_ZERO(gpio_privacy);
>
> -       unit = uvc_alloc_entity(UVC_EXT_GPIO_UNIT, UVC_EXT_GPIO_UNIT_ID, 0, 1);
> -       if (!unit)
> -               return -ENOMEM;
> -
>         irq = gpiod_to_irq(gpio_privacy);
>         if (irq < 0) {
>                 if (irq != EPROBE_DEFER)
> @@ -1545,6 +1541,10 @@ static int uvc_gpio_parse(struct uvc_device *dev)
>                 return irq;
>         }
>
> +       unit = uvc_alloc_entity(UVC_EXT_GPIO_UNIT, UVC_EXT_GPIO_UNIT_ID, 0, 1);
> +       if (!unit)
> +               return -ENOMEM;
> +
>         unit->gpio.gpio_privacy = gpio_privacy;
>         unit->gpio.irq = irq;
>         unit->gpio.bControlSize = 1;
> --
> 2.30.2
>


-- 
Ricardo Ribalda
