Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 211D44583CD
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Nov 2021 14:25:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238187AbhKUN2T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Nov 2021 08:28:19 -0500
Received: from mout.kundenserver.de ([217.72.192.75]:49619 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235784AbhKUN2S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Nov 2021 08:28:18 -0500
Received: from mail-oi1-f178.google.com ([209.85.167.178]) by
 mrelayeu.kundenserver.de (mreue109 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MF39S-1mr1sm3j2W-00FWZm for <linux-kernel@vger.kernel.org>; Sun, 21 Nov
 2021 14:25:13 +0100
Received: by mail-oi1-f178.google.com with SMTP id n66so32125327oia.9
        for <linux-kernel@vger.kernel.org>; Sun, 21 Nov 2021 05:25:12 -0800 (PST)
X-Gm-Message-State: AOAM533cNj45RsQmLBB/QGcxQb8B+bvjIYdCPqcq8lxZA/qBgnGgo0c3
        zWR7nlyNNnRxdu2ZseF+nJ/G3snoiQ8UJqZDneA=
X-Google-Smtp-Source: ABdhPJxAWjFpccF8MUIV8xJf+Sxl8wH4gazgJ13w0fN5iNKPYJNfQHTvMBFCd4Q738130NH/Dm03Fetbr60v0lbcKHI=
X-Received: by 2002:a05:6808:e8d:: with SMTP id k13mr13707305oil.84.1637501111602;
 Sun, 21 Nov 2021 05:25:11 -0800 (PST)
MIME-Version: 1.0
References: <20211119113644.1600-1-alx.manpages@gmail.com> <20211120130104.185699-1-alx.manpages@gmail.com>
 <20211120130104.185699-18-alx.manpages@gmail.com>
In-Reply-To: <20211120130104.185699-18-alx.manpages@gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Sun, 21 Nov 2021 14:24:55 +0100
X-Gmail-Original-Message-ID: <CAK8P3a1XiyAnKPyd-pu1CXAjnsZ+nMdULSWWGasCYgiUU_WdjQ@mail.gmail.com>
Message-ID: <CAK8P3a1XiyAnKPyd-pu1CXAjnsZ+nMdULSWWGasCYgiUU_WdjQ@mail.gmail.com>
Subject: Re: [PATCH v2 16/20] linux/compiler.h, linux/array_size.h: Move
 __must_be_array() into <linux/array_size.h>
To:     Alejandro Colomar <alx.manpages@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Kees Cook <keescook@chromium.org>,
        Joe Perches <joe@perches.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:S9/JRQ1aeY/4PYzufR2PVmH1Bs3LsDmIg0xFz10vB4Q9qwiDLxs
 aC7ysjvC/VKrn1+W3y4xj6qT359fepGGY0muAEzPKNw9+dS9vlJp7S21o2KyE3z4+6ST928
 /007k7h32gVzZRH0OnJ78ek97pwXzMcvs4MfwL58wcY8Mwp+45ko6QNAUGaUAAkJfAJmbhd
 /uM+pUvmkkW6339AHA70w==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:z/x5+Os8zfI=:3REoyqLcjZq+oyr3j6seYN
 28zD2OlI6gZotpxn2+C/THzgJ2VMglDCMd1xlknSZMR/0b5rq76k81Quy5PRiRIg43h0a0cXY
 ykTrNVf9K+oAPRFiTB+Feir0OtQrOTX3HDSLlbnTQl7XVpWxeGJFYRy2gdEdLpIagzZy+2gPu
 5bomRqOFjYP0C1cUtfIHpQNmgXjv2uqH4OqjU/FNfxcdJVwNqIBhzQh30bine2KvCqiLieXQz
 I0o7Pbtabg4SV0MjZkzzgnZKZYJ2z+FpY05eRKy5PU/RUgaPXQ8cAqC+ohYyWZT8Qhm8yjrqn
 PLd86De+FhBeZrtOlHldLU8zESX7i3ynB/1mXF0bFK/13zSKe+j+ekI1dALHCwh7Cuau4jXVJ
 NjLDK8zNSwkiER5gFVXA8ttdWIb4DXbD2HEnuuqoeVJbpFG3I+/WZCbzslEv87c41GTf8EtB1
 ogENuKYUoTDbZ0hHzj8/QdBFyhPF3ORslTeIY3s9DVPz5ovzNI9XDiXuVFq3riQQyN6N14+v7
 F0edb3yWhFM0897slBNa2VkfLlUdsvs1pBV3mX/yBLKfAA7zYeYs0msz4pf7LLa5je3q6DTbS
 xR/UUS1vPZ88rt7cICmGpNa6bBrcmqkpDbbXdbm9ntweIn20vF1sP4nZCBaBlFpEouiaOVUbv
 By0BuwVijeZeEbO51TjWZhg/3sQJzNumqBzWSyDPhePWWq1oVafM5BXP1F2wiN65m6DweZjUk
 yEwh8wsPVj18tehDQK56YmgSXn1vexe2q0w1Jze2fXr1jedMMyiL9XCThmr3jBzwXZPZq9Yh6
 9oY7vkreNeHImYPIVCz4A6NROfDLXP9oXJVNR4mV5lvrhawmPU=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 20, 2021 at 2:01 PM Alejandro Colomar
<alx.manpages@gmail.com> wrote:
>
> Signed-off-by: Alejandro Colomar <alx.manpages@gmail.com>

Each patch should describe why you move this, it's not clear what the
benefit is here.

> diff --git a/drivers/gpu/drm/i915/i915_utils.h b/drivers/gpu/drm/i915/i915_utils.h
> index 7a5925072466..f6fc1c72dfa7 100644
> --- a/drivers/gpu/drm/i915/i915_utils.h
> +++ b/drivers/gpu/drm/i915/i915_utils.h
> @@ -25,6 +25,8 @@
>  #ifndef __I915_UTILS_H
>  #define __I915_UTILS_H
>
> +
> +#include <linux/array_size.h>

Avoid adding the extra whitespace here.

     Arnd
