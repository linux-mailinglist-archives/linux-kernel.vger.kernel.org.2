Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C888F4583CF
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Nov 2021 14:27:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238220AbhKUNaN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Nov 2021 08:30:13 -0500
Received: from mout.kundenserver.de ([212.227.126.131]:58793 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236405AbhKUNaL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Nov 2021 08:30:11 -0500
Received: from mail-ot1-f49.google.com ([209.85.210.49]) by
 mrelayeu.kundenserver.de (mreue010 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MhDIw-1mAnUZ2Axm-00eJ9q for <linux-kernel@vger.kernel.org>; Sun, 21 Nov 2021
 14:27:05 +0100
Received: by mail-ot1-f49.google.com with SMTP id v15-20020a9d604f000000b0056cdb373b82so24594288otj.7
        for <linux-kernel@vger.kernel.org>; Sun, 21 Nov 2021 05:27:05 -0800 (PST)
X-Gm-Message-State: AOAM532j2j7i/Z/fbDRDiNMKgowxZcEyMK2XcsAdc8vkVSZxoeBI752r
        Z9mvj12Wi1zdiBOFto8PdvQbDxvSwBRXKYfiEwY=
X-Google-Smtp-Source: ABdhPJwgR2pheyJ8rejJ/seRZBaKJEvN7S8I2Yrw2dlGqTavoRwmlZQXKc1tOYpLfrJdCLX5wyxfQHNBqUGh/bTJ7+w=
X-Received: by 2002:a9d:4d08:: with SMTP id n8mr10711854otf.368.1637501224265;
 Sun, 21 Nov 2021 05:27:04 -0800 (PST)
MIME-Version: 1.0
References: <20211119113644.1600-1-alx.manpages@gmail.com> <20211120130104.185699-1-alx.manpages@gmail.com>
 <20211120130104.185699-16-alx.manpages@gmail.com>
In-Reply-To: <20211120130104.185699-16-alx.manpages@gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Sun, 21 Nov 2021 14:26:48 +0100
X-Gmail-Original-Message-ID: <CAK8P3a3TzHsPUf2rLamL7kxWST3YDDcZwV8bA9LU5M0akkZM-Q@mail.gmail.com>
Message-ID: <CAK8P3a3TzHsPUf2rLamL7kxWST3YDDcZwV8bA9LU5M0akkZM-Q@mail.gmail.com>
Subject: Re: [PATCH v2 14/20] linux/compiler_types.h, linux/same_type.h: Split
 __same_type() to a separate header
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
X-Provags-ID: V03:K1:iKqzvnEesxjWo6dt7XEco8/jjrkL2f2nGCMZzvTakhLxOaLw4+o
 KmAve+1Q3aEKLWhNy8+1Jq7EKfb0U0d5XgxykqFmkOxn7dR/UWSMWDChes0W45VXJzp3/Kz
 +fdCT81nZ8+6X+pgAQIQePy+ZdktpsTCbS6xXhDZw0YUq19RTDNoScWJQ6cM/E6qCkDoDft
 RpSgeeEl+F8c6co4kgU+g==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:bcipgxRFi/o=:B5xB1riotRSJ3Khb1oIgmF
 s5U0Pp7G+dbKCicerQduSmeEhQGsYPDsD2pd2tLj+n48rRg/pI46pnUvo3fx+FzeNxkinhYq7
 T/zesrpaTg+iRgQ54B9ZglY8eTteM3/u8mKu7eqVaawBnvkTEmG4qy7K2065L7GiZSHBuiAgT
 MfkGGRiqeiRvibpndAT9t5bvGmPrQBuKxVmEI7X3H5HFbrIoHOmIcGkheEtogNcUGXCDxtbL1
 qqI3DDRAf//MxQoMnEoJE9wVdGF4055IZXRDvsboA8/WBBiXpKyq/VRZwRa4L2g5uf/Se6xwj
 fy8iiGOy/rTMuYzyS75HKFX4rvbvrAfeLWi3lEwyId89I17rJrzLIphx9XNccz5/dWpSedUPb
 b0QJwsVQm5VfisMAu5PL0H4Pnl0O1Mi5wEDcmok6DxwDS0FHRhoa5Q7xygSC9BotcsGw8eFH/
 LEgRxQMWIJCukj5DZsu0hnsmHMvMI+4w5WpZMECpNcynw0DC6YH/tEVunri4PhhXjhf2sVAhF
 uae8b+IgatVxCRIJC97VfUbwWW+e3dQTeCUgBzujQsJr9AXU9/YSaqjqjmQkFk/kgfkMbA2TR
 C2Q9BbjMwjUmgE1X/a8vW3BZUdbLgIJP33Fj/ithkXzWuGV7KiE8J3XxhuMOnuw2tI8C8IJRF
 pLfq7d1XGJv9JCeSN+atMcTFXiredk2KwaUHPyZrd4MMmhmi7Wy7+iU8NztNm5PAGUGNkezAT
 tSHjr94+sCKLY3XQRwLHDzCJsOdB3jFFOn97x52nY2P4aTZSXBV6Y5qb4Ed8+fybcPZCiPbkK
 uB9V86Ln79a8PgEU1dSYDPl5Dq7W6D7UZJBdKKJYI/a5b2mw/M=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 20, 2021 at 2:00 PM Alejandro Colomar
<alx.manpages@gmail.com> wrote:
> --- /dev/null
> +++ b/include/linux/same_type.h
> @@ -0,0 +1,10 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef __LINUX_SAME_TYPE_H
> +#define __LINUX_SAME_TYPE_H
> +
> +
> +/* Are two types/vars the same type (ignoring qualifiers)? */
> +#define __same_type(a, b)  __builtin_types_compatible_p(typeof(a), typeof(b))
> +

Having a separate header for this is really silly. Please find a
header with similar
definitions that you can add this to.

       Arnd
