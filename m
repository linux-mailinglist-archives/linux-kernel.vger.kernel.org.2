Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 339A43311E8
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 16:16:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbhCHPQS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 10:16:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230047AbhCHPQF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 10:16:05 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B97BC06175F
        for <linux-kernel@vger.kernel.org>; Mon,  8 Mar 2021 07:16:05 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id dm26so15188656edb.12
        for <linux-kernel@vger.kernel.org>; Mon, 08 Mar 2021 07:16:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=wME0xxypILqfkGLAgLbk6QlOoimfje6iWFu2oEHWfOs=;
        b=n0RdWFb3wQqQnw/sAXyDL81fOug2MleJFDzS9JHqJa0Xf/qxNoBmnvMYUgDZwTcYF+
         rYOXffjH/llx/sf/D5I0Gf9zZCatLig7eBUI+6yU1cupnL/YEbHvxJ1BrIrpFOmh9NKM
         6+R+6zxoYU8hwDNHKyhnCqwmPXpOioanlM5z9Jh/OEu88RIpHdu95lXQ+oyIloNX+zuE
         ERLhcYqYKlHLSOjifxsIe26Dtx9ZZdWZFQLgOf431yV5Prm0Ri9tmMXTuBRA9V+4rZGD
         kULkYNbckRRXsNuQBV7HQlKnoAqDcoGkZEWOP0KTZcRsndJXIvXw1mHiiSmYRpLVEgAC
         QjWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=wME0xxypILqfkGLAgLbk6QlOoimfje6iWFu2oEHWfOs=;
        b=XrpFRIHsYfODHHzE8xfyfMZSqKdSirEiuSjXQMb5JVgM19g23xg2d2ew9w6ZXu0o84
         f01ZCfeZ7xY7KKvDiJ24WxHrnDm1Z991dyOG0Prmvj/51TpWW4AM1nq9eer0L/v7BT+K
         XfG6q0DnQjG8211askgqez5zlL2xnLqAwRwmLliCggOHvCMeSyv2QaO3X96aluWOPYLu
         IalwMWT50z2/785OdCFt9+JtG62+5rUgfJuai3aWSD17+SSqkd5imYUlBn/GEMjAHXQ5
         qd6jjBgmA5cgKJYcFcWL/mj/kMh7GipwurX2mc6qQGh4BzfyJ3AK5/kCS4/NMdlFI7mm
         +dZQ==
X-Gm-Message-State: AOAM5314ddPd6BH0UInGkSqeByHP2fuFDIFjUKEEWLlFj73FLoEP27zx
        6YkfrXJt09gh351Viv/sy2olzq/T02IY5U7oH3I5/A==
X-Google-Smtp-Source: ABdhPJxBFaI+hm/G4Y0wTEXCDtli4Oap8zfigY5PX7vLldku4lyAIN75HyumbkvqaFZfvVhuxHIhzsRYSYaQMIP0cKk=
X-Received: by 2002:a05:6402:b31:: with SMTP id bo17mr22440599edb.113.1615216564092;
 Mon, 08 Mar 2021 07:16:04 -0800 (PST)
MIME-Version: 1.0
References: <20210303203444.3140677-1-j.neuschaefer@gmx.net>
In-Reply-To: <20210303203444.3140677-1-j.neuschaefer@gmx.net>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Mon, 8 Mar 2021 16:15:53 +0100
Message-ID: <CAMpxmJXs+hVS4c7PBfE8U73q15utehRdfZKz70cP3b-4Rb0Nvw@mail.gmail.com>
Subject: Re: [PATCH] docs: driver-api: gpio: consumer: Mark another line of
 code as such
To:     =?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Cc:     linux-gpio <linux-gpio@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        linux-doc <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 3, 2021 at 9:43 PM Jonathan Neusch=C3=A4fer
<j.neuschaefer@gmx.net> wrote:
>
> Make it so that this #include line is rendered in monospace, like other
> code blocks.
>
> Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
> ---
>  Documentation/driver-api/gpio/consumer.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/driver-api/gpio/consumer.rst b/Documentation/d=
river-api/gpio/consumer.rst
> index 22271c342d923..3366a991b4aa7 100644
> --- a/Documentation/driver-api/gpio/consumer.rst
> +++ b/Documentation/driver-api/gpio/consumer.rst
> @@ -12,7 +12,7 @@ Guidelines for GPIOs consumers
>
>  Drivers that can't work without standard GPIO calls should have Kconfig =
entries
>  that depend on GPIOLIB or select GPIOLIB. The functions that allow a dri=
ver to
> -obtain and use GPIOs are available by including the following file:
> +obtain and use GPIOs are available by including the following file::
>
>         #include <linux/gpio/consumer.h>
>
> --
> 2.30.1
>

Patch applied, thanks!

Bartosz
