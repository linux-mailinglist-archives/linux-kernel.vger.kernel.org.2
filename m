Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 025814583CB
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Nov 2021 14:21:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236405AbhKUNYG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Nov 2021 08:24:06 -0500
Received: from mout.kundenserver.de ([217.72.192.73]:50579 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235784AbhKUNYG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Nov 2021 08:24:06 -0500
Received: from mail-ot1-f44.google.com ([209.85.210.44]) by
 mrelayeu.kundenserver.de (mreue107 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MJEpp-1n3qYC3I4Z-00Kf02 for <linux-kernel@vger.kernel.org>; Sun, 21 Nov
 2021 14:21:00 +0100
Received: by mail-ot1-f44.google.com with SMTP id 47-20020a9d0332000000b005798ac20d72so6128947otv.9
        for <linux-kernel@vger.kernel.org>; Sun, 21 Nov 2021 05:20:59 -0800 (PST)
X-Gm-Message-State: AOAM5312lhs2mSZbPv3ZbNB3adjSKdjtSYWa/jEPHuHi/m8luh8gvCz+
        uIcGSbtKLAb5GJIyB6cMpZiVge/QdfMp6FBN+Bw=
X-Google-Smtp-Source: ABdhPJz1i/JukV66VTU8MKqRBply0WjTLYgpH5bVngE4XOASm3cEIoj6m/8TeLTJtSPEjHZuPean70z29w4Np9W2hwk=
X-Received: by 2002:a05:6830:1092:: with SMTP id y18mr17382190oto.119.1637500858478;
 Sun, 21 Nov 2021 05:20:58 -0800 (PST)
MIME-Version: 1.0
References: <20211119113644.1600-1-alx.manpages@gmail.com> <20211120130104.185699-1-alx.manpages@gmail.com>
 <20211120130104.185699-20-alx.manpages@gmail.com>
In-Reply-To: <20211120130104.185699-20-alx.manpages@gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Sun, 21 Nov 2021 14:20:42 +0100
X-Gmail-Original-Message-ID: <CAK8P3a0b7_yMExXEiH-4sKnN2Smh+BDB+=dyNvPWVcLvR_zG5w@mail.gmail.com>
Message-ID: <CAK8P3a0b7_yMExXEiH-4sKnN2Smh+BDB+=dyNvPWVcLvR_zG5w@mail.gmail.com>
Subject: Re: [PATCH v2 18/20] linux/power_of_2.h: Add __IS_POWER_OF_2(n) and
 __IS_POWER_OF_2_OR_0(n) macros
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
X-Provags-ID: V03:K1:kymwxOUYj3aE5qlO2SpW9/n53lXLJCYqVWZpX1ZtAlhJk87iQx4
 TXcatmBQ2k2upHu+nju8+qNcOqaB59wBB68wt7hMW2m7buLg4deuew3gsbRbnY2goZn59d3
 mSIwJLcyL892YU9QB0LvYPyPAM6MJ+EHzPV8f39I0P+3NjD9bq96Mcfx9eU0fjo/1/NUmgZ
 5PMTRNHDl1CNNhaYueOfg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:A0GeOipclc0=:v8oBkmSYx5aFjSIbEUeVl0
 0JKa/lvNWcPuDjCJPUgFWMc2q1dzWlI3OzLNpPBuuK968O+u5PX1Uc/gMlWZebjGwpUs+4esC
 8Xt47VuDdGx7qERhfAcEA9IdPI3D+7qkZeaXBkolLImfWjApFUcEToItPj2YsXdLMH0kr9NKN
 lIQr8D1gLr97c/V+F6Abw8whlsuNifYkFG1J+3Tk4H6GnP9AVS3gOS7j1XparIAotb4DoUSjs
 oHHtprUvyip73uwXWI4n/oIay6B8uKiWriwKOmXHSYgMbcA6bCiJn72YODAS2lUy6vlKIBf/r
 eKvaBEXLl97w14RZOM4XI1vKM8zpE9g436nsNIfK8KfrpIsLoNjBRsMMjRBnoEtEM6mJeTBxK
 TojDYUukxsW8hb1QhOTUJF8GqdQiKjigrOEhkJat+rRlbGP20/uk76atO+GU47sHVI716eFFL
 QYuFx9GJMdlZRxzlIi5iIUXPoqpcJFI5csp2rlHPmy+QYgexdWcXMhmBOY9BLMlFjJ+DFBVLp
 pwTP2XqcNcQTOOE80LpKadEzzVJFqY9lVibxhRc1nwAyyaIMv452b1oVBatUu7xwQFICIrH31
 6RbYGK1uECqJYujQVtb2zfKc8GnxPzjmln0CZ/k5XCaws91HlDGVgmmewSe1cxenmFo0cCLjV
 IuEcPDgLHZxVYpqBO6f3Ja/mkTtf9TDD/7TmttHYADyHYrHHGSxanN/B3YM2N9ILGK4yVlA95
 tBGgJrWBO/kIA5lSKUrP5MxJqBxiupgOya8WLGh9Hn+VkoYhw7+V3wOqIjkvEMPT9fgwZhrYK
 yhNWRe+WQIb9sxxxmg/OT9fcYR8QIBcKRnCX6kbicRpawiaVyg=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 20, 2021 at 2:01 PM Alejandro Colomar
<alx.manpages@gmail.com> wrote:
> +
> +#define __IS_POWER_OF_2_OR_0(n)  (((n) & ((n) - 1)) == 0)
> +#define __IS_POWER_OF_2(n)       (__IS_POWER_OF_2_OR_0(n) && ((n) != 0))
> +

There is already is_power_of_2() in include/linux/log2.h, which would
be preferred
in most cases. If you need a macro version, put it in the same file
and explain why it's
needed.

       Arnd
