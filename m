Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1072932A9AC
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 19:48:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1581260AbhCBSln (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 13:41:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1448898AbhCBPnP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 10:43:15 -0500
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4E4FC061788
        for <linux-kernel@vger.kernel.org>; Tue,  2 Mar 2021 07:40:34 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id a17so24503760ljq.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Mar 2021 07:40:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JoOi1VQKYJA6ZW+eLQKjH4JJ8KX9VGExJXoWL2AhruY=;
        b=GYvzW/XasiKnxPmuWkbAzZbF5LKRI17d2RmV7gJqNx/LMDjfElx3+drTy5Ok9hoHwJ
         0NdMg3c5pkaBawgYqv6MiudwMsaPEa17nwXwWPm67zE7MgW9sp3OGNwagru7DWgr8Z1E
         QKyBxi71GaLJJ5dmGVyH52upR2fhfFaHdZWOXFNUf9AXub1NrEw4nfuDMZ/E6Ubu6GE2
         /bQwOW20cMAhYMK0ww++42kk2FyzfETKTs8hsjPzPJiBUlAkMz3QbkFjm4UItoI/Ztxb
         iWYfvthYa7VvqqgLM7olobJRHXXHIrzjUn10qclu/BiLjm9NEXk0zAYLhW6ejOR7PK3f
         Wr4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JoOi1VQKYJA6ZW+eLQKjH4JJ8KX9VGExJXoWL2AhruY=;
        b=e+K3Kvj3V1iTuuIkBwE2RbKLhukI9i/EuIrmQEk8p4ZjW+RpAeV8NWnn3A3dVg7/re
         U57+9hVLGAENN5khJV9UlAsdcXQ9nxWSIhapXrKBLV/5eV3nZ5ilgDxZ9jhVfXtwTmGM
         j9tXL1b+2mNFkkME4gIwB7+eYIpXm8S0G5roMhfGG3de/cWzo7g1sj8K3foRMKsVtv/2
         1Lw/jCp2lG2ogxh917cY+6H/46QfZH7Wi4sLit7gVu9KEbDimfnknjjI0EmXx1NbGw2X
         D13aLUafFZpd34DyJadAs1V3opyT872KTQzxt+cumn6Ny8Zs43VjCROuA/HbuJAywfU6
         ZWHg==
X-Gm-Message-State: AOAM531+Er6Qo3rdcTjIPq6b9BMacFVpvJv3oKrsO4OHi6gK+rFoLF48
        LJtE5E0A1jNrred1ux5LMpJrNnYIrYp80s+nvU2aLQ==
X-Google-Smtp-Source: ABdhPJxAF/jrM1Av5GDPesEvuTwFJDWud8eBzIJ9ciWNFS4BX/hg//rj+YkivMg+oKgMEexukt6ngmz5XGZ+SjvYNHU=
X-Received: by 2002:a2e:700a:: with SMTP id l10mr12521528ljc.368.1614699633208;
 Tue, 02 Mar 2021 07:40:33 -0800 (PST)
MIME-Version: 1.0
References: <20210301090519.26192-1-johan@kernel.org> <20210301090519.26192-2-johan@kernel.org>
In-Reply-To: <20210301090519.26192-2-johan@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 2 Mar 2021 16:40:22 +0100
Message-ID: <CACRpkdaif9UJ2SwyMFuYXB6U2b2ikT8QtCy9Se9zfswLkaJNkA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] gpio: fix NULL-deref-on-deregistration regression
To:     Johan Hovold <johan@kernel.org>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Saravana Kannan <saravanak@google.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        syzbot+d27b4c8adbbff70fbfde@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 1, 2021 at 10:05 AM Johan Hovold <johan@kernel.org> wrote:

> Fix a NULL-pointer deference when deregistering the gpio character
> device that was introduced by the recent stub-driver hack. When the new
> "driver" is unbound as part of deregistration, driver core clears the
> driver-data pointer which is used to retrieve the struct gpio_device in
> its release callback.
>
> Fix this by using container_of() in the release callback as should have
> been done all along.
>
> Fixes: 4731210c09f5 ("gpiolib: Bind gpio_device to a driver to enable fw_devlink=on by default")
> Cc: Saravana Kannan <saravanak@google.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Reported-by: syzbot+d27b4c8adbbff70fbfde@syzkaller.appspotmail.com
> Signed-off-by: Johan Hovold <johan@kernel.org>

Oh nice catch!
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
