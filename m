Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 998FD3D4E49
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jul 2021 17:23:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231394AbhGYOmb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jul 2021 10:42:31 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:37055 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231252AbhGYOle (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jul 2021 10:41:34 -0400
Received: from mail-wr1-f50.google.com ([209.85.221.50]) by
 mrelayeu.kundenserver.de (mreue106 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MKKpV-1ln8QK2jmB-00LjAf for <linux-kernel@vger.kernel.org>; Sun, 25 Jul
 2021 17:21:43 +0200
Received: by mail-wr1-f50.google.com with SMTP id n12so4343810wrr.2
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jul 2021 08:21:43 -0700 (PDT)
X-Gm-Message-State: AOAM5316BYtYTU0JJznCD9QQzh6vArj4lTMDb+lJshpB9pcrpcg2lGcR
        REIISTskSk48gzY6XBl0xfwhyutShpnXTziDsmQ=
X-Google-Smtp-Source: ABdhPJy4pI0h4luhm+4JXMhENt6D2TnA8PlTq5W9CZjdcuAQGV0u44bA1tlmL1oLHEq6hqwVp90WdcdSjk0/o/sW8Ro=
X-Received: by 2002:adf:f446:: with SMTP id f6mr1909349wrp.361.1627226503350;
 Sun, 25 Jul 2021 08:21:43 -0700 (PDT)
MIME-Version: 1.0
References: <20210725104413.318932-1-geert@linux-m68k.org>
In-Reply-To: <20210725104413.318932-1-geert@linux-m68k.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Sun, 25 Jul 2021 17:21:26 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0aa-F6HbakzFRPv1JewLVHmrv-=DNnTfukdY-g4g0Txg@mail.gmail.com>
Message-ID: <CAK8P3a0aa-F6HbakzFRPv1JewLVHmrv-=DNnTfukdY-g4g0Txg@mail.gmail.com>
Subject: Re: [PATCH] m68k: Fix invalid RMW_INSNS on CPUs that lack CAS
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Greg Ungerer <gerg@uclinux.org>, kernel test robot <lkp@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:yWn0I/Naw8An0DYdUEDwH3uyx5sePhsiPir6YcHZe/aRB77GQDm
 WlHDnsfBv97Y5c1AIJBdyiPYBZ/xLlfd9ISs36wLjfXqqbiUp9IpeRHdlgGSLNlZ8z9n4zN
 Poefqvtkuss0NlPKZerh5CYlSPuhNh+nRZyqM5cDc1qXBfs9WkmwFU4u+MSg7w6O0lKLnuN
 6jEmO8CaFmjoPPQyets9A==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:WvkwxqUtSts=:Ip8daD+HwWg14LahvzYIox
 2rQ0aNZhhtsouZmNmdzRhXPWcHGgBYptjo7x0abzYob1+DQ/yGaO2F3ic1y7zeTsNyYHzJGcu
 QrzbgMVshcweqdlbPa9imXnfhbk7/uCpEyrMwIXhTjOeszgItlIRog+MAB5dsnu1cZwrjIguV
 I2gi9EKig3iNcSd9amTrW0NDT3lsQ3sEeYypZntEE4JXFPlvugBIMSsh9EYAqtelUITt4G9BR
 UQMiux5vA0B9q2ax1lRmjLRZf2q3n/LJbFiHn6Kwwd764aQRjusp3rCMLFpsiO7ajOttUjJrv
 g/zO5SZjX+H0sBngJx3OPUlskj4JmhkY1oOMunYMglGSStngc+arfN0b2YhyL0FgFzmIZAPxE
 pov+OtSt/1Wg7ucsN2neJdx5tCUi4xWEQM6FpuSZ0h6Da7RMq6H/afh1ydEwuaxdGL+TRbdGA
 kft0ekBK3h+4io4aWoHsxWAxUiAdWmEUJEw2Jbu30oBaLl/sl8IK4andEhTmYhHf1k6yECJIv
 R2ej77+7u1xAz0eUJW26uRwEkWZo110DaicmGusAtNyq5MRMh0uTdI+gSIiAybnM2n6nzGzJ2
 7rMozsCWfVl0LgwmGRrjbn3eiCcs5xWYcUWzU/fLJYnutvrcPbHpNHQKBVSIJEy0oJsdqA3T1
 ruKSsRct9qhPi0xFsItSmi8d/XxO+V2AhFaxCgkNAF9e2g1O/mw79P1T5AHJw3MxAzpeWxb5R
 PPZFQLVcImZ27cosry6XC5v/vT+1u2WnjWmXowifmD0SZmelOlN9M3kRAt521041tXkCsLNsb
 H6hIGtHZuHWyjpRMR8x/QP5p6JKZPXE2GNPZ+SuV+4skkXoxWZSbrGx3MwR3H7d1JFeXBMo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 25, 2021 at 3:02 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> When enabling CONFIG_RMW_INSNS in e.g. a Coldfire build:
>
>     {standard input}:3068: Error: invalid instruction for this architecture; needs 68020 or higher (68020 [68k, 68ec020], 68030 [68ec030], 68040 [68ec040], 68060 [68ec060]) -- statement `casl %d4,%d0,(%a6)' ignored
>
> Fix this by (a) adding a new config symbol to track if support for any
> CPU that lacks the CAS instruction is enabled, and (b) making
> CONFIG_RMW_INSNS depend on the new symbol not being set.
>
> Fixes: 0e152d80507b75c0 ("m68k: reorganize Kconfig options to improve mmu/non-mmu selections")
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

Acked-by: Arnd Bergmann <arnd@arndb.de>

> @@ -54,6 +56,7 @@ config M68000
>  config MCPU32
>         bool
>         select CPU_HAS_NO_BITFIELDS
> +       select CPU_HAS_NO_CAS
>         select CPU_HAS_NO_UNALIGNED
>         select CPU_NO_EFFICIENT_FFS
>         help

As far as I can see, there are no users for CONFIG_MCPU32
after M68360 was removed in linux-4.6, but as long as the
option is there, it makes sense to keep it correct.

     Arnd
