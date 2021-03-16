Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4367033D7E6
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 16:45:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229710AbhCPPpU convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 16 Mar 2021 11:45:20 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:39237 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232851AbhCPPpG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 11:45:06 -0400
Received: from mail-oi1-f179.google.com ([209.85.167.179]) by
 mrelayeu.kundenserver.de (mreue011 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MWzwP-1lBQLG2nFZ-00XGv5 for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021
 16:45:03 +0100
Received: by mail-oi1-f179.google.com with SMTP id u198so33589434oia.4
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 08:45:03 -0700 (PDT)
X-Gm-Message-State: AOAM531iokSjnc+iG+PuRYw9QeTBHgsP4ZqVL4HTiDi4y6SzaqldAOVV
        CPequf99bcvd2dim5I3xrng96y+FaOgmwGYEt7k=
X-Google-Smtp-Source: ABdhPJwQtyvp/sivr2QftEdYH8SddtCyezCo0jNI+ji3RO8XF8COcyvnD4V9nkGi2N3qLDq3+QnLIzsSmIgVRDXYLGQ=
X-Received: by 2002:a05:6808:313:: with SMTP id i19mr132835oie.67.1615909502415;
 Tue, 16 Mar 2021 08:45:02 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000069802205bda22b7f@google.com> <CACT4Y+Yaq-zDh5FAzHt4g-5jXrXC3rSLw6CM=kjcfR6oxJ1+CA@mail.gmail.com>
 <CAK8P3a1qtHVBY47FfCa6R9+sObzMCwxkREii+O2g8PPopw87eQ@mail.gmail.com> <CACT4Y+aC0YWU6gM32S3NoT+-wR7B1-_rhPyh4w542h21UCRRGw@mail.gmail.com>
In-Reply-To: <CACT4Y+aC0YWU6gM32S3NoT+-wR7B1-_rhPyh4w542h21UCRRGw@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 16 Mar 2021 16:44:45 +0100
X-Gmail-Original-Message-ID: <CAK8P3a0zA9pv005d_P_e64j4EwXDh75yC6gNGRVdyy-VzO+7Fw@mail.gmail.com>
Message-ID: <CAK8P3a0zA9pv005d_P_e64j4EwXDh75yC6gNGRVdyy-VzO+7Fw@mail.gmail.com>
Subject: Re: [syzbot] kernel panic: corrupted stack end in openat
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     syzbot <syzbot+0b06ef9b44d00d600183@syzkaller.appspotmail.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Linus Walleij <linus.walleij@linaro.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Provags-ID: V03:K1:7HjwDaBlTzdN/Cr9ACTp1/K/cNKL0OjIF/32kpl/8bh10OCxaEl
 0mta3vxkSGECxNmZ5lg1xeIoXx71hZx+Wxve0fM6lJW0jU7ulOUNYbPdNvDBEW0yZoyyxry
 KN20jFuAohEBaN7gzS9j2sZqL40F580Ec9hDLn1rFu867f6nJf57VhLkfP5zBxK5D0J8dcF
 81NvvLjnrj/Ty8r10dV3w==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:aJuzn7hWqFY=:BqnJMn2tzojSAcc/rTzVYM
 s/iRJ1gnP0r0yzDudPtIh3RYHfXn1GfB84Hc4xxyeQYibzEwOeFqeErU6FY/iyA8+ssXykTGz
 x1KaVxYMkMuEldHnBk0rutXoiJbJGTawBcIVM4Cbg4U1+VMSdhCgMAtwLkYOXNCxiIqbBCOwO
 x5jPV9+gsASxQEjTN/gTkR1kyllrzx/MfbhE6XP2D3CGCfDu3pddu/2ShuTxmNMmTkBR54yBV
 3aRLCkZsIuucmtxaAm/VCVmrUaZxBe5y+sgV/rID4TXXcEQatLwPfrS3i5+2CDFkaacxjhb9p
 Mf3kM1Mf29K0M7aHWguszPCo7bGJfQ/uqkW5DFfDQyymcFuRn87XS8kX907BUF5ZOLL/pG09R
 yTjBpApeU0J4W71jizU+esmbq5V+Yo6HHsHCm66ZCnYwhLzTRv+Wdy8N1/lSicQnSClrjyDFf
 Xgtwxqxu4kIfKnUnLWXnNPy6SDDinGf5ET3pLGljlaoQrZNKWwv82lbjYhRboPPBeYztcAnkx
 jzV4q708h5fxPvBWqBomJXMTWstV5zFh7kwlsCiSseCbTb0Tvm9mTDy+oDy+S8W5rBTzHcYjp
 KxSpOzN+MFFR0ZB2gT1+PazJs9egyFizry
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 16, 2021 at 11:17 AM Dmitry Vyukov <dvyukov@google.com> wrote:
> On Tue, Mar 16, 2021 at 11:02 AM Arnd Bergmann <arnd@arndb.de> wrote:
> > > On Tue, Mar 16, 2021 at 8:18 AM syzbot
>
> > > > [<8073772c>] (integrity_kernel_read) from [<8073a904>] (ima_calc_file_hash_tfm+0x178/0x228 security/integrity/ima/ima_crypto.c:484)
> > > > [<8073a78c>] (ima_calc_file_hash_tfm) from [<8073ae2c>] (ima_calc_file_shash security/integrity/ima/ima_crypto.c:515 [inline])
> > > > [<8073a78c>] (ima_calc_file_hash_tfm) from [<8073ae2c>] (ima_calc_file_hash+0x124/0x8b8 security/integrity/ima/ima_crypto.c:572)
> >
> > ima_calc_file_hash_tfm() has a SHASH_DESC_ON_STACK(), which by itself can
> > use up 512 bytes, but KASAN sometimes triples this number. However, I see
> > you do not actually have KASAN enabled, so there is probably more to it.
>
> The compiler is gcc version 10.2.1 20210110 (Debian 10.2.1-6)

Ok, building with Ubuntu 10.2.1-1ubuntu1 20201207 locally, that's
the closest I have installed, and I think the Debian and Ubuntu versions
are generally quite close in case of gcc since they are maintained by
the same packagers.

I see ima_calc_field_array_hash_tfm() shows up as one of the larger
stack users, but not alarmingly high:
../security/integrity/ima/ima_crypto.c: In function
‘ima_calc_field_array_hash_tfm’:
../security/integrity/ima/ima_crypto.c:624:1: warning: the frame size
of 664 bytes is larger than 600 bytes [-Wframe-larger-than=]
none of the other functions from the call chain have more than 600 bytes
in this combination of config/compiler/sourcetree.

In combination, I don't get to more than ~2300 bytes:

    [<818033d8>] (panic)
 52 [<8181f5b8>] (__schedule)
  0 [<81820430>] (preempt_schedule_common)
  0 [<818204dc>] (preempt_schedule)
  0 [<8048c7c0>] (kernel_init_free_pages)
148 [<804916ac>] (get_page_from_freelist
212 [<80493264>] (__alloc_pages_nodemask)
 44 [<8042f034>] (page_cache_ra_unbounded)
 36 [<8042f2c8>] (do_page_cache_ra)
 28 [<8042f418>] (ondemand_readahead)
  0 [<8042f894>] (page_cache_async_ra)
 68 [<80420ac8>] (filemap_get_pages)
120 [<80421110>] (filemap_read)
 36 [<804215f0>] (generic_file_read_iter)
  8 [<805ff430>] (ext4_file_read_iter)
 96 [<804da3cc>] (__kernel_read)
  8 [<8073772c>] (integrity_kernel_read)
412 [<8073a78c>] (ima_calc_file_hash_tfm)
164 [<8073ad08>] (ima_calc_file_hash)
106 [<8073bf84>] (ima_collect_measurement)
332 [<80738fec>] (process_measurement)
 24 [<8073979c>] (ima_file_check)
172 [<804ec66c>] (path_openat)
152 [<804ef670>] (do_filp_open)
 40 [<804d79c4>] (do_sys_openat2)

> Re printing FP, syzbot does not use custom patches:
> http://bit.do/syzbot#no-custom-patches
> But this does not seem to be syzbot-specific. It seems that any arm32
> stack overflow report will be unactionable, so I think it would be
> useful to include this into the mainline kernel to make overflow
> reports useful for everybody (and for syzbot as a side effect).

ok.

       Arnd
