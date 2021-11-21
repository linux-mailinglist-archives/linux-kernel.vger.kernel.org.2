Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EC064583CE
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Nov 2021 14:26:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238211AbhKUN3N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Nov 2021 08:29:13 -0500
Received: from mout.kundenserver.de ([212.227.126.130]:57897 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235784AbhKUN3M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Nov 2021 08:29:12 -0500
Received: from mail-oi1-f182.google.com ([209.85.167.182]) by
 mrelayeu.kundenserver.de (mreue009 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1Mw9Lw-1mYMOo0yv6-00s2vU for <linux-kernel@vger.kernel.org>; Sun, 21 Nov 2021
 14:26:06 +0100
Received: by mail-oi1-f182.google.com with SMTP id n66so32128788oia.9
        for <linux-kernel@vger.kernel.org>; Sun, 21 Nov 2021 05:26:06 -0800 (PST)
X-Gm-Message-State: AOAM5334RfijOGlEtSJAZ1gKcQcEhY6f6t+3CleBg2jufArD4WN8U6d5
        8+fOdD6rATO6zRuxYAlicjIJKoJNu06mZ/G454M=
X-Google-Smtp-Source: ABdhPJwNN24n1mXVUvzKaIcP/WXQ8kfXklHIpb8zwLIoq6/o03CSGMCii43OyKXPAOBrJxyZOOghJMaOxF8+3F5g8ow=
X-Received: by 2002:a54:4e93:: with SMTP id c19mr14369622oiy.11.1637501164925;
 Sun, 21 Nov 2021 05:26:04 -0800 (PST)
MIME-Version: 1.0
References: <20211119113644.1600-1-alx.manpages@gmail.com> <20211120130104.185699-1-alx.manpages@gmail.com>
 <20211120130104.185699-17-alx.manpages@gmail.com>
In-Reply-To: <20211120130104.185699-17-alx.manpages@gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Sun, 21 Nov 2021 14:25:48 +0100
X-Gmail-Original-Message-ID: <CAK8P3a1svD_pog3-ZKnQAv=Li3=U9kB_ApXQOkzH-UCLtaQMEQ@mail.gmail.com>
Message-ID: <CAK8P3a1svD_pog3-ZKnQAv=Li3=U9kB_ApXQOkzH-UCLtaQMEQ@mail.gmail.com>
Subject: Re: [PATCH v2 15/20] linux/compiler.h: Implement __must_be_array() in
 terms of __must_be()
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
X-Provags-ID: V03:K1:RjLFzcSTnI8qSSTBhmRSTpfMnO5nCdQgRltQHAgCUrL6g7mGW0E
 0J32KnQ8LHoyNZJjTyR9TRileadEw/5oW3RLo0ptGQrHKdzhVBFvA+0i4NNy2swsn+41M20
 HiumTp0Dv4d9p3FHAZ/RHf8wTabYh5MFmN5X4H37m6+5Sktx3z+jKVN+WAF3PbD4cq2GJix
 IzUTKIez21am84ZMGYUYw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:QFTiBu4MsrQ=:iz+7f3Q3isi9BcurtSV+Zk
 2+aGju+cWkeM5vt6J4VG+QQg+jTYFU5d/qSQuNgAQvEar3Xr1fYf09cW9nW/ec5LmdrhJyhTb
 WHf2cI1Kbgiknuxlgzt+NbCFbmngSGigHtzYMcMAWkpQoVPUBQLAT02Bp2QcTIoqPiKwpgNdK
 /MjKs/WP1NMtjFsFhKnXF8pWFPFnuI1oDn9lS00N9YkLXMPd2AYbvxPidFlIVeLChxwP7+E3f
 DS7SKPGon97AvCH70idxduRpnughL32wkZp670Ntw1TSVLagD4YHlFC7QwbTggSVi76G67DJ3
 nTdXNKfYhBlJye2Ne7XAF8KwvNiumRCV2KB/3WHcGF7l/NbkeMs7mXZGmHvbDVlYlUlqUmjWJ
 3BMcADaKydOQVh9ybNMhNCp18RxSBuNiMZ164uq7IGKJgYpDqscjfVHm9sMxdd7SW4J7BdC2I
 axsvmwlAZbHt7sGBTLRe4Y+W0ewpeOM5MVvtSoNlbIDUVu7uEiqG/as/OO+XomL71X/cB0Sb2
 CIvhrsXU+udsdRdkM0nbRW++hPan7SCjvUdE/1mP41D5Uo8T+wLZws44SyC7ZeBO9h57NYMum
 itCf0GERFsLfe6GiPRdqoyzf/JcGi0gqO7dIiO4lgDcrLDLaSBSEhLltkhDUXynAjrOSDaNun
 PG6zGbfKXX9LbmV7XsaK6PVOWk0RMFHvzjaTLK/RLbLDKRGafU6xSdpPuYUhoVgg2msbDdzqv
 MmadDL111RyjD6Krc49uJGPjweoa668BvmcyeMY3JMo5XOkWDO/4PRTKrLceUAhdG9GbrYv1C
 UFKZ7zDD8FcD8l1Fji3MiiwK2jWgbCkdG1fRuviPNNzaIEhXHo=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 20, 2021 at 2:00 PM Alejandro Colomar
<alx.manpages@gmail.com> wrote:

> @@ -255,7 +255,7 @@ static inline void *offset_to_ptr(const int *off)
>  #endif /* __ASSEMBLY__ */
>
>  /* &a[0] degrades to a pointer: a different type from an array */
> -#define __must_be_array(a)     BUILD_BUG_ON_ZERO(__same_type((a), &(a)[0]))
> +#define __must_be_array(a)  __must_be(!__same_type((a), &(a)[0]))

Please go the other way here and change all users of __must_be() to use
BUILD_BUG_ON_ZERO() or BUILD_BUG_ON() for consistency.

        Arnd
