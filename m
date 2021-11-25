Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AB3D45E2E6
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 23:05:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345593AbhKYWI4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 17:08:56 -0500
Received: from mout.kundenserver.de ([212.227.126.134]:47767 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345883AbhKYWGz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 17:06:55 -0500
Received: from mail-wm1-f42.google.com ([209.85.128.42]) by
 mrelayeu.kundenserver.de (mreue009 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MAfQe-1mjnFu3gRE-00B6fB for <linux-kernel@vger.kernel.org>; Thu, 25 Nov 2021
 23:03:42 +0100
Received: by mail-wm1-f42.google.com with SMTP id k37-20020a05600c1ca500b00330cb84834fso9362104wms.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Nov 2021 14:03:42 -0800 (PST)
X-Gm-Message-State: AOAM532usrGACouox0sROr0Wh2LycYA+6WK4hT4aRGtA3Ea8DhO/u8KO
        eIkyX8LP6hkM1ObJ1ldpXj9GMHWA3vEoacD2xIg=
X-Google-Smtp-Source: ABdhPJxNqrpGiwNkEFIJ+GcWnr9u+pKtzCJn7XveBJ1xlA/jPsnuxoQSgc5xfSsYLVHplWsvU3brV0cs8lSwxeqygew=
X-Received: by 2002:a1c:1c1:: with SMTP id 184mr11677329wmb.1.1637877822595;
 Thu, 25 Nov 2021 14:03:42 -0800 (PST)
MIME-Version: 1.0
References: <20211125213203.86693-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20211125213203.86693-1-andriy.shevchenko@linux.intel.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 25 Nov 2021 23:03:26 +0100
X-Gmail-Original-Message-ID: <CAK8P3a3Pu-ygd9dkhS=d2ZGKjbt0V=mdxaEG8tXUhueSKMJXQg@mail.gmail.com>
Message-ID: <CAK8P3a3Pu-ygd9dkhS=d2ZGKjbt0V=mdxaEG8tXUhueSKMJXQg@mail.gmail.com>
Subject: Re: [PATCH v1 00/10] misc: at25: Code cleanups and improvements
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Prchal <jiri.prchal@aksignal.cz>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:adXvJyT5J5OsZqEIK+gdEBAhVoGZF8G2vUvcz4pwCbdlYjh+3/h
 gPHNtB9C7Hi382RJVHkQSHMzQPSuZ2clDubWorj3eEt0j/2YeyhzxSzhYty+S7OFEwjZCsi
 LTPWN470nuaXE4AcswB5eSPdEguzn04wtzcCEAUnbO5NhsMUEP4LWcihmYg3QGzMefSYpEy
 gCVse3Dhb2kNowzSDxLag==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:l0mKNvCOGgI=:ZcfRcfy1jIB5duG4djlK3O
 QSzPrS8WTYS1cpnACt6WihBiHOVqjNF1+n0D1ZpYNHU10JwSOPRaJjDiuBuVlGu0RAEXV5gf1
 pCQkCb5VoQc67cYFAE8gp0a8rgEvKcolCafc7SaseY+VC1f+tPgQKagtMT4jYQ0HDkfWHNae4
 qW8+pa4DlIYYls7Zs1M1cZz/pa2W3uscSMU+TPlFjNzjcc1hNvMsKEj8sa8TXau8JLEu/iqjD
 AAxnjEesJenoROAXCGaQz9cLLFdCmP5rW8/IMnc+rkY3A66Osg2l/ZCXxMBkXyftqfIkTQzFw
 LgYNVeV/ytOo+fWeH2K2NjGtycVDG3ivBteEktK7ecgeMrl5EHeEcDim07qg6IHLhJtBoOqPY
 /dFMcw6jWl2DO8BXe2MgLz13oekIiJYkZt2OB8riC8tV3g0uAIzfPdqto2yGs49vzqDqbnTpO
 uzk4iqlae7Xx6j+KRyLO8c7pRFkFSBP15ypV67HJTHCkmzUwA+mch0PicVBW955r/EOIuM49R
 UPlZxmeSDS4lstuMAKNnUBm+g/SrBxZGLAjD7Gq0xMtnnAhH2IjsqOtU6OGX00q2SaAwvpWnN
 O9IR0RVJoMyD1OlWt5m409CVNEXW6a/hTJYkhW64c3Xs6El1Q/l7oINWXmg9B7LxCIk9u9Y2h
 ZeeWvM2b9vd6ZbYzju6q+pmAuxGVY/saSH/F3WNha8Lpgv+qu+kainXoYhd1wnp0yZsc9CVUl
 FD/V8AY3T4d17Rw2k4MYin4QYexPPL8uTch7ly1Nwljj+tvLA+IKEA8cRo1uOYbWcqRRvs8bj
 fAGzohMOxg+IEs3zt8d0YR5GSc9BxI+rG1+5uxHYnmR/e9yvZI=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 25, 2021 at 10:31 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> Code cleanups and improvements. Please read individual commit messages.
>
> Series depends on the fixes series [1] sent earlier.
>
> [1]: https://lore.kernel.org/lkml/20211125212729.86585-2-andriy.shevchenko@linux.intel.com/T/#u
>
> Andy Shevchenko (10):
>   misc: at25: Use at25->chip instead of local chip everywhere in
>     ->probe()
>   misc: at25: Unshadow error codes in at25_fw_to_chip()
>   misc: at25: Check new property ("address-width") first
>   misc: at25: Get platform data via dev_get_platdata()
>   misc: at25: Get rid of intermediate storage for AT25 chip data
>   misc: at25: Switch to use BIT() instead of custom approaches
>   misc: at25: Factor out at_fram_to_chip()
>   misc: at25: Reorganize headers for better maintenance
>   misc: at25: Replace commas by spaces in the ID tables
>   misc: at25: Align comment style

These also look good to me,

Acked-by: Arnd Bergmann <arnd@arndb.de>

It would be nice to change the three remaining board files that fill
struct spi_eeprom so they use device properties and unify the
rest of the probe path. Not sure how much of a change that would
be.

         Arnd
