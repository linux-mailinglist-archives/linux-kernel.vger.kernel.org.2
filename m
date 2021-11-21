Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB6D84583CC
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Nov 2021 14:23:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238167AbhKUNZ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Nov 2021 08:25:59 -0500
Received: from mout.kundenserver.de ([217.72.192.75]:46559 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235784AbhKUNZ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Nov 2021 08:25:58 -0500
Received: from mail-oi1-f181.google.com ([209.85.167.181]) by
 mrelayeu.kundenserver.de (mreue109 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MhDEq-1mAnQU2Ip0-00eNrR for <linux-kernel@vger.kernel.org>; Sun, 21 Nov
 2021 14:22:52 +0100
Received: by mail-oi1-f181.google.com with SMTP id u74so32065547oie.8
        for <linux-kernel@vger.kernel.org>; Sun, 21 Nov 2021 05:22:52 -0800 (PST)
X-Gm-Message-State: AOAM532+41yuoYi07N+OrOidACkIQJfLtOKyDqsTHrzyRfKylyEsPCPK
        TsYsMevn29WT1Gl0UGd6BK/i0UVXDq+MdEQJUBc=
X-Google-Smtp-Source: ABdhPJybfj2Q05kRsPidGHVDIIvlvg+f4Wl8ZN+iqjQ1GX5CzQraZCZa8cfvJntrul20Et+GsvTB3RSZ1sNVT+pxfqc=
X-Received: by 2002:a54:4e93:: with SMTP id c19mr14354275oiy.11.1637500971244;
 Sun, 21 Nov 2021 05:22:51 -0800 (PST)
MIME-Version: 1.0
References: <20211119113644.1600-1-alx.manpages@gmail.com> <20211120130104.185699-1-alx.manpages@gmail.com>
 <20211120130104.185699-19-alx.manpages@gmail.com>
In-Reply-To: <20211120130104.185699-19-alx.manpages@gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Sun, 21 Nov 2021 14:22:35 +0100
X-Gmail-Original-Message-ID: <CAK8P3a13pWLNdE6-BP8GEtSait66=V+Wo7GPWP-FkyXMHP5tPQ@mail.gmail.com>
Message-ID: <CAK8P3a13pWLNdE6-BP8GEtSait66=V+Wo7GPWP-FkyXMHP5tPQ@mail.gmail.com>
Subject: Re: [PATCH v2 17/20] linux/array_size.h: Add __is_array(a) to help readability
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
X-Provags-ID: V03:K1:IA2El5SrIAoN9i+8tiMblwu/ohhKvZFeUz/0joHnOYE+5a0HEp4
 kb8w32a7nVKFxGERVzPAPZwmJ6gci/An+4YECMXzWY24FfYr/OTY82kY2E7JMqpoAucHy7t
 JVF+2Utygq4Zyo7il9+HGuBtIpibj6KaJcd/UzEv1K8SeMFuU/4yP+f9Kk/Y78tA1fPWHlF
 fMvSIGlSzqq0A5D/nm1Qg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:tEPBtjaAT+Y=:FZSdNOLIaEfkT4yJGyQ7c/
 3nJ3Vl/ncoHi/ejZFKRSbA84jlMKw43uPdkn/pstBTaKMMz4Ci246sqMpbpT9uCsgaMuC+dZR
 a4f1ApoKUymcYuQtSU2EmljmxDJsmPht6bRBvdDkmE/mi4V3RSWUFkVOi6cci4EDAGFS+5rC7
 m9mq2q/Lhxw7esKw9zA9+q/AX24Cu5ywJ95t1nJbFVX8pJhlKoKEJFuFcl594nuwi8oRwoeZN
 ajhhhoxuJ/hLmNrH42NSR8wMfvYNeCGUhX7GsFg+lAl/QdGs03D5HKbkgrgVVH4d8Fz9SfQyM
 JA5jVpPGyw3MB9G6Giao3YP5j4+zc3aQUin3tnb/rkyIkrbKl4uyl7FRcRedajHaAXQKCNL/e
 b0ljaB3h2g7pXfbZnvK/Edx1XaOrzgf6F6QP1jsErfnjNfpS7VnZBDZAnG5BXZtJbIOK0P5XO
 UVsLqY3mgHYMjzRnZKUam9sl4460cfS5tc1/9hvmLRFE5JsQRsBwDOuNr6PrGeFyjar1j0N/0
 v7K21G84qlGcaqjLh+H5VMCr5ijsQyY924HXk31sbA+bqULxRfD2lPKYqz+j2nxfmgUgI4eOW
 wPc8Gb/zvCAnpnegNFdz3oofCLV7KvNU/aFYHf5ZB7b7JJr2sD4Ykm6b41UrkfnevbfW0SBTG
 cTwAHRTL+/BypbtZu63pmDL9NhhJSDqWGl1RXXQXl/6pkUFEI3Zc1Z+fRHGHP+Jje2prxSJGH
 YBPhW7pO+nxQwzlZ9No03ejyNHuaViAYrE1YOAqbr5ApwA5Bz6Xtj8tDnolCsQlH67G95aIiO
 ir0E4PolU79nGmzWXLzamENIQN5pHNWnSlawVIauFqloO/rqiQ=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 20, 2021 at 2:01 PM Alejandro Colomar
<alx.manpages@gmail.com> wrote:
>
>  /* &a[0] degrades to a pointer: a different type from an array */
> -#define __must_be_array(a)  __must_be(!__same_type((a), &(a)[0]))
> +#define __is_array(a)  (!__same_type((a), &(a)[0]))
> +
> +#define __must_be_array(a)  __must_be(__is_array(a))

I'd go the other way here if you want to improve this, and open-code it
to avoid nested macros. That produces more readable error messages
with recent compilers that try to unwind each macro one at a time.

      Arnd
