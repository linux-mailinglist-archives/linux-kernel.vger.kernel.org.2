Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3CE344ACE5
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Nov 2021 12:50:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343600AbhKILw5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Nov 2021 06:52:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343588AbhKILw4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Nov 2021 06:52:56 -0500
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DF2EC061766
        for <linux-kernel@vger.kernel.org>; Tue,  9 Nov 2021 03:50:10 -0800 (PST)
Received: by mail-ot1-x336.google.com with SMTP id o15-20020a9d410f000000b0055c942cc7a0so7741924ote.8
        for <linux-kernel@vger.kernel.org>; Tue, 09 Nov 2021 03:50:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ALBcIFK0M2sDqjczdXHc9NoWo8sCRANOPePxtQKC6v0=;
        b=WiNjKmsahtkj7noZ9ffdWo8zufH5fxNGTifxSgsaMThK1Bc25ubh55+CHeuGaG7dca
         IUJu9SE+F1ZklwyVbmXyyhhwcj0fg+IcXAUeMkT2TM5AtPRpH3WjiiGM0JbYuy1FNyNo
         W/m4prG/Qo/AI9tmUfrtEwc1xzSfJ8Q+7ZXo7dZw2gmjbx0/oFHLRnz+TXr7yb4yt4rw
         DbpNSz1GfVi/hAHf/6iZhz37emGktf2XV99bWXojbMU9ELu6783fpV36atKSUBhOD6FP
         qt5X3Lt9oO+YFKDBZilTPQ4bEsJUs+P+vARkfPy4jNZXysxqcTZkkSfcAc6qC7oUWOwo
         t/8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ALBcIFK0M2sDqjczdXHc9NoWo8sCRANOPePxtQKC6v0=;
        b=JMLjfQ64jBOhcG1uBouy1uOxJY88WSWYEri+S0g7XqV3/86FPIwFxjqoKWtzCHaxJO
         w6tdbdG2WOosnuDtuTkQ/hCE+40ijXhbb3u9IGGA0q62CSZ4vyxOkrgQ8Q1cWDglrhXo
         B1hVHiW0neBd7L+phvegC1Y+qR+FzV+OSj2zFVwBS7djbjiEoARSqu9g3T5rWBb2BsQP
         lzw9dNuptUCEgphDPRdDZWr5eogVxcgnMWRVvySxhFQh6Zn28D0Mgqgz1U4zkmDW2qFe
         IpNzD7gpxDvpTkqq3o4PzpYvd21acINqsiCti5ad9kXmioxdC8cg6+BynFzHx3rTa7ax
         Nr6Q==
X-Gm-Message-State: AOAM533LxzK9PCdv+M8Ia/lvALVLfJZf8Z5sw9Y8m2exJ/dOr5shNMy7
        8ZMXkznWDdVqOUYIwLqtplxKCK1FGTgkWFc9AsMt+lGzHzc=
X-Google-Smtp-Source: ABdhPJykswbjVxAwy6QccCD6a4oKxQG8ZBoSavSKVwonmEEZcj7+3DiAKXMLdnvkMbWw05xgzSkhW8FiyFJlI+8TVv8=
X-Received: by 2002:a9d:ed6:: with SMTP id 80mr5272989otj.35.1636458609456;
 Tue, 09 Nov 2021 03:50:09 -0800 (PST)
MIME-Version: 1.0
References: <20211105130338.241100-1-arnd@kernel.org>
In-Reply-To: <20211105130338.241100-1-arnd@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 9 Nov 2021 12:49:58 +0100
Message-ID: <CACRpkdYKs==og5pSsSxMXXozkexybJEnTHZWUr1ObsqAsGPuRA@mail.gmail.com>
Subject: Re: [RFC 1/3] gpiolib: remove irq_to_gpio() definition
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     linux-gpio@vger.kernel.org, Bartosz Golaszewski <brgl@bgdev.pl>,
        linux-m68k@lists.linux-m68k.org, geert@linux-m68k.org,
        gerg@linux-m68k.org, linux@armlinux.org.uk,
        linux-arm-kernel@lists.infradead.org, linux-sh@vger.kernel.org,
        dalias@libc.org, ysato@users.sourceforge.jp,
        Arnd Bergmann <arnd@arndb.de>,
        Fu Wei <tekkamanninja@gmail.com>, Alex Shi <alexs@kernel.org>,
        Hu Haowen <src.res@email.cn>,
        linux-doc-tw-discuss@lists.sourceforge.net,
        Jonathan Corbet <corbet@lwn.net>,
        Drew Fustini <drew@beagleboard.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 5, 2021 at 2:03 PM Arnd Bergmann <arnd@kernel.org> wrote:

> From: Arnd Bergmann <arnd@arndb.de>
>
> All implementations other than coldfire have returned an error since
> the avr32 and blackfin architectures got removed, and the last user in
> driver code was removed in 2016, so just remove this old interface.
>
> The only reference is now in the Chinese documentation, which should be
> changed to remove this reference as well.
>
> Cc: Fu Wei <tekkamanninja@gmail.com>
> Cc: Alex Shi <alexs@kernel.org>
> Cc: Hu Haowen <src.res@email.cn>
> Cc: linux-doc-tw-discuss@lists.sourceforge.net
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Thanks for doing this Arnd. I had it on my mind some years
ago but I think Coldfire or something was still using it and didn't
think about it as the last user disappeared.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
