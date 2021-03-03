Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 119B232BFE1
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 01:00:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380037AbhCCSNy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 13:13:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384100AbhCCPgW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 10:36:22 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3048AC061763
        for <linux-kernel@vger.kernel.org>; Wed,  3 Mar 2021 07:27:58 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id m22so37746252lfg.5
        for <linux-kernel@vger.kernel.org>; Wed, 03 Mar 2021 07:27:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=B7e8ps8+6KgtwjvkMtXtTUb/RUWQBqnIoQ/7yrVtwxM=;
        b=T3smYZREz3wZWOrOSabPyhBR1Ae/LDRY6AZCilnUYUMM5nMBXkOAhVBhw42fX5HQKP
         HhkbLxIvWgFs6YOQC+ZdY2/X2zs5Z+NfwmjNQceUwTVUXN7cJ6mk0kCf9ZguGvQoBH5x
         Ae/DKwVkOz1w8Uu0dg67GrEFQvegQ4wdvkdL7gmrBLyLSS9nt7j3K7AzKPCvW4ucVWEM
         kvYxd1lOv9fT/PQADKysIpq/+1xniWBx+88T8HXNSDCLNva7WKKLWnQKYV4hSR7Y5l0V
         FguLvQybJDffzc496glALtZFHwt74u/lZttgBD+EtgrzIJpxtsin0Gy495PcfYtytwFW
         WTGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=B7e8ps8+6KgtwjvkMtXtTUb/RUWQBqnIoQ/7yrVtwxM=;
        b=UmvrEi5rgGYy3RVJcV7/p/jDna8ct1h8HGmQARiT1t6p2LfOhC3DLb+P/sgfN/LNE+
         goOI7xU0XEaBrzHCv+EiavpXHRwhSEFyP07oUgVffkqMFTRpufpc7HRaEZ5sG4UAnQup
         o4UFXKqiI4yZtY+874pt+WkN41pkMOrfqp9AynBC7PUJpMrtNzBAQA6lFU3yJYt5pVim
         //+2eJzhsAqUj3z3V2GK1YeOy0lOjOYhtGStIQfc4m+CgxVu2I2HyY7XJ9LwuSG6YBOj
         ZkoQ4pvnpqIzIYuOT4E7HryDEXCIZ2+/+BMXapQ2jBwS4l8ULzWbjm3WI27/koATtMzN
         K/Rg==
X-Gm-Message-State: AOAM532DjiGxj8HPT6twi5ayW+8quOA1t29KE2jHhJLZbP0kvVjYsIVg
        MMox8bIKfDkHKg9b1+diEV3z1pJGlmSjEZEnMfIHWA==
X-Google-Smtp-Source: ABdhPJxwSZfkYhtJWwEjy73tyu94P/P5s2En+mmWPKHZ4Ff70sGNABOhy3vBB9KOx8oiJgQnlsb7bBHfgb4lHbxSFgA=
X-Received: by 2002:a19:4c08:: with SMTP id z8mr14810793lfa.157.1614785276573;
 Wed, 03 Mar 2021 07:27:56 -0800 (PST)
MIME-Version: 1.0
References: <20210303142310.6371-1-noltari@gmail.com> <20210303142310.6371-2-noltari@gmail.com>
In-Reply-To: <20210303142310.6371-2-noltari@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 3 Mar 2021 16:27:45 +0100
Message-ID: <CACRpkdb56dB+f89Neuix=KKtAsYSTHKuCifhmmzN7jy2LuUbdQ@mail.gmail.com>
Subject: Re: [PATCH v3 01/14] gpio: regmap: set gpio_chip of_node
To:     =?UTF-8?B?w4FsdmFybyBGZXJuw6FuZGV6IFJvamFz?= <noltari@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Michael Walle <michael@walle.cc>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        Jonas Gorski <jonas.gorski@gmail.com>,
        Necip Fazil Yildiran <fazilyildiran@gmail.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 3, 2021 at 3:23 PM =C3=81lvaro Fern=C3=A1ndez Rojas <noltari@gm=
ail.com> wrote:

> This is needed for properly registering gpio regmap as a child of a regma=
p
> pin controller.
>
> Signed-off-by: =C3=81lvaro Fern=C3=A1ndez Rojas <noltari@gmail.com>
> ---
>  v3: introduce patch needed for properly parsing gpio-ranges.

Oops a little bug. I suggest that I merge this into the pinctrl tree
together with the rest of the patches when we are done with review.

Yours.
Linus Walleij
