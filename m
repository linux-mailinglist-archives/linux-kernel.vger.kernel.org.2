Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F40E4583D1
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Nov 2021 14:32:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237990AbhKUNfP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Nov 2021 08:35:15 -0500
Received: from mout.kundenserver.de ([212.227.126.134]:55073 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233735AbhKUNfP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Nov 2021 08:35:15 -0500
Received: from mail-oi1-f169.google.com ([209.85.167.169]) by
 mrelayeu.kundenserver.de (mreue010 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MTR6K-1nE32o3bzg-00Togb for <linux-kernel@vger.kernel.org>; Sun, 21 Nov 2021
 14:32:07 +0100
Received: by mail-oi1-f169.google.com with SMTP id 7so32100548oip.12
        for <linux-kernel@vger.kernel.org>; Sun, 21 Nov 2021 05:32:06 -0800 (PST)
X-Gm-Message-State: AOAM530pQ2ksPz4gdC22WjE5jMvY6irKEEPxs6Rl4uTP/BiPR2X33st9
        qrqCoX1GASi0ct/xhwNYmiWdu7JKNlVwFFWEvrA=
X-Google-Smtp-Source: ABdhPJxyHs8jQYRTeBiFU+eq5P3zltew6Z+4qTqSrV5gRgP3Dvi6VV6vXAp+I7ZNArHgO4PgQip0GKQ6vpyfaInpxkg=
X-Received: by 2002:aca:accd:: with SMTP id v196mr14710148oie.108.1637501525594;
 Sun, 21 Nov 2021 05:32:05 -0800 (PST)
MIME-Version: 1.0
References: <20211119113644.1600-1-alx.manpages@gmail.com> <20211120130104.185699-1-alx.manpages@gmail.com>
 <20211120130104.185699-9-alx.manpages@gmail.com>
In-Reply-To: <20211120130104.185699-9-alx.manpages@gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Sun, 21 Nov 2021 14:31:49 +0100
X-Gmail-Original-Message-ID: <CAK8P3a0asgPE3oh6fagLT434zTw6xbpqk-ioG1XCJcM2GOsHVQ@mail.gmail.com>
Message-ID: <CAK8P3a0asgPE3oh6fagLT434zTw6xbpqk-ioG1XCJcM2GOsHVQ@mail.gmail.com>
Subject: Re: [PATCH v2 08/20] Implement container_of_safe() in terms of container_of()
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
X-Provags-ID: V03:K1:01DceEpeobilPRWPnRYhgiWzugCf4ijy18SXwNyVTU+29RpNXUN
 p0c2EUjLtrf3KHEGLEpad/Nuj4mefyS6NV4FH4zBYqtzDCIiHELpo8RWjKErWlWRIWRJrGx
 ZzoSJ8BNm2DdzJ4J62tH346ePsf7qWaQZB6a5H7PKrPoULGquz5Gkzcyg2Tk0M88djmXomm
 ljaTf1xwiFFk9xB7ilp/w==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Y7434Wx7BFE=:xJYxJIuAKIxuZ6TwnOGTqR
 gukezLETeYtoetcxBuNP7fy1dT/G5UdorYhR6YR1oIyj/XLA4Kw1bIMOyP2kDCooFs4Kn8npi
 SxnMFabcI2wwUVdqWwbk+fZQeuCW59VwCSFF4hKjJfcMFai+/Vpz5auh0e3gKBF+w4a5LQ7q6
 AarnQ1Qz2bOplihvhLAmutaSEIhwXQGhn9K7kbeGunTgd2XSEn/+y4OPNwOueJXPtc7bxqxLr
 n2kPIntOfGGpjbLrgDf9nFpWwXpplbCmQ41kDCh4DrXs7xwLACMAmQpt+tuFputNSoFhMHJRi
 tKiJYFjnce7AsT16EDSwqXiMGOw9gyqMmb8G9a659PMtxQ5t8H3SeXviZmB7IZnrtmju6TnDL
 6z+r7KqcyiD6/5KwCd4807jUkXC5s6/RMRSDRPrDgehS2YkHDJGiJZPiTNoBfSkihIWM/dHEp
 UoHagQ+KyQK/t3p0Wfk1vTgkedarCTs1ovduOAqzyjN5y3KMtzwlUG0hFM0pBTtWhBuZFWlR9
 izRnV/MC4JkJy++ZoTM/m8X02h0kFhYemWvt7aPrj8vwMpLQrJsc7XXTRWSSGkw5gwb0QvScj
 /J8lI1eEHFqSckkJ7OsW0TASk4xYWmK3cISTxncuIDsBxkGamdHyveqJ2dPOmXn0sUy6OLjg4
 D5KxZfIN/gEhV4koE2UVra8U+vKT471QaAbGNVzwZav4c/uyfupWmb2IHg88lIlH2g2dfcVos
 C5jHei6AR5SB1ftQk1FmS7/rMcds45BYnARoegS2pDyVlumg7FrAsi3bbWtkVDaan20ML6f78
 5xsy1GMBwo+5AA+sX5CNR+NxQzRTh0i1gDR3SM1mDHAXXhceY0=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 20, 2021 at 2:00 PM Alejandro Colomar
<alx.manpages@gmail.com> wrote:
>
> There's no more a need for the temporary variable __mptr,
> since now it's only passed to functions that accept a 'const void *',
> and everything can convert automatically to it,
> reducing the need for the cast too.

The purpose of the temporary variable is to avoid evaluating the macro
multiple times, this is still required.

>   * If IS_ERR_OR_NULL(ptr), ptr is returned unchanged.
>   */
> -#define container_of_safe(ptr, type, member) ({                                \
> -       void *__mptr = (void *)(ptr);                                   \
> -       static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
> -                     __same_type(*(ptr), void),                        \
> -                     "pointer type mismatch in container_of_safe()");  \
> -       IS_ERR_OR_NULL(__mptr) ? ERR_CAST(__mptr) :                     \
> -               ((type *)(__mptr - offsetof(type, member))); })
> +#define container_of_safe(ptr, type, member)                           \
> +       (IS_ERR_OR_NULL(ptr) ? ERR_CAST(ptr) : container_of(type, member))

It's possible that you may find a way to improve this macro using
__auto_type, as a way to reduce the macro expansion further.

        Arnd
