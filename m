Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D77A740337F
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 06:55:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232795AbhIHE4p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 00:56:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232011AbhIHE4f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 00:56:35 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5C48C061757
        for <linux-kernel@vger.kernel.org>; Tue,  7 Sep 2021 21:55:27 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id d16so1355047ljq.4
        for <linux-kernel@vger.kernel.org>; Tue, 07 Sep 2021 21:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BGSSG1KppTdhFpfh0S8ytn/P5QNiyuOhgVXWuDULhJw=;
        b=CStPE9Hcsdp2M1zY8oDqlEXMK/e5mZky8VCHUR91VZTviVdYGsdmvADXEb6nRid6Eg
         AyzfyCf8pn634OVDyYLaboh2MKQybfXA96gozDLPvD9u3+wlsU46n50D/m0FqJGR5ayU
         VSuh+rFPr8/9ITNGdZWNdcCUB8bE11xCmIFdY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BGSSG1KppTdhFpfh0S8ytn/P5QNiyuOhgVXWuDULhJw=;
        b=ANJsLIqbS7puEtXgs6dtKRrSF6n9is/p1HL5yF4F/hic62/2eGKoVpMraj/KeILlWJ
         Jstfu3j7oFeItYhSX4XWTCyciTsEaFvrrpviAPqm3mcK1SqnoaWlTOmORG4LSaPxusoa
         wOVY47ZNCE0QSTd8YJDIvoPC+qC83wYB7MpiK8U7MPZGrGMEDDpJf9kifrmwbAcnPvra
         p8Nb6bII+hk7SkfoXq1+OmnlsR9HlEUdZQh0kqplXvfaZZmDBeQ+q5DbZr080RS2wQ0f
         ob6Eh3ZuFW4FKy1HvMK2PbxHGtxGJfU34jcgKOZs31lZdIP6f1/ZUHONQHuig95dUHDY
         +yGA==
X-Gm-Message-State: AOAM533zsDprTDl6wBbU6RRFFJHoW56sTnKmTK7Zrbcv5wiUWo+jS6Ip
        y3jZCsqmlVgZ894jB7hScj15+OrzTf6M/7RDIvY=
X-Google-Smtp-Source: ABdhPJyQvU0PofxgNeQ7G6HyHwfq8Ty9fmxV01vZ08iE4is+XQ25FKjgIcsm9ZXiyYPgjd9zAU5BfA==
X-Received: by 2002:a05:651c:281:: with SMTP id b1mr1366107ljo.372.1631076925502;
        Tue, 07 Sep 2021 21:55:25 -0700 (PDT)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id a18sm107815ljd.4.2021.09.07.21.55.24
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Sep 2021 21:55:25 -0700 (PDT)
Received: by mail-lf1-f48.google.com with SMTP id n2so2415793lfk.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Sep 2021 21:55:24 -0700 (PDT)
X-Received: by 2002:a05:6512:1112:: with SMTP id l18mr1314095lfg.402.1631076924200;
 Tue, 07 Sep 2021 21:55:24 -0700 (PDT)
MIME-Version: 1.0
References: <20210906142615.GA1917503@roeck-us.net> <CAHk-=wgjTePY1v_D-jszz4NrpTso0CdvB9PcdroPS=TNU1oZMQ@mail.gmail.com>
 <c3790fb9-b83f-9596-18a1-21ace987c850@roeck-us.net> <CAHk-=wi4NW3NC0xWykkw=6LnjQD6D_rtRtxY9g8gQAJXtQMi8A@mail.gmail.com>
 <20210906234921.GA1394069@roeck-us.net> <20210908042838.GA2585993@roeck-us.net>
In-Reply-To: <20210908042838.GA2585993@roeck-us.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 7 Sep 2021 21:55:08 -0700
X-Gmail-Original-Message-ID: <CAHk-=whVDMcg==vcOopR0Mci2FQ8bzJjufyCg+WPh003K2i2ww@mail.gmail.com>
Message-ID: <CAHk-=whVDMcg==vcOopR0Mci2FQ8bzJjufyCg+WPh003K2i2ww@mail.gmail.com>
Subject: Re: [PATCH] Enable '-Werror' by default for all kernel builds
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Christian Koenig <christian.koenig@amd.com>,
        Huang Rui <ray.huang@amd.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-sparc <sparclinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 7, 2021 at 9:28 PM Guenter Roeck <linux@roeck-us.net> wrote:
>
> It is seen with gcc 11.x whenever a memXXX or strXXX function parameter
> is a pointer to a fixed address.

I wonder why I don't see it with gcc 11.2 here on x86-64.

> gcc is happy if "(void *) 0xfffc1f2c"
> is passed to a global function which does nothing but return the address,
> such as:
>
> void *sanitize_address(void *address)
> {
>         return address;
> }

We have had reasons to do things like that before for somewhat similar
(well, opposite) reasons - trying to disassociate some pointer from
its originating symbol type.

Look at RELOC_HIDE().

It might be worth it having something similar for "absolute_pointer()".

Entirely untested "written-in-the-MUA" garbage:

   #define absolute_pointer(val) \
        ({ void *__res; __asm__("":"=r" (__res):"0" ((unsigned
long)(val))); __res; })

I dunno.

               Linus
