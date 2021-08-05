Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD09E3E1695
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 16:11:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241935AbhHEOLc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 10:11:32 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:53633 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241767AbhHEOLY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 10:11:24 -0400
Received: from mail-wr1-f50.google.com ([209.85.221.50]) by
 mrelayeu.kundenserver.de (mreue106 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MvaO8-1n2mGv19JG-00sdeU; Thu, 05 Aug 2021 16:02:39 +0200
Received: by mail-wr1-f50.google.com with SMTP id n12so6726844wrr.2;
        Thu, 05 Aug 2021 07:02:39 -0700 (PDT)
X-Gm-Message-State: AOAM532EFEW8QRavdIayHs5iFht0Ud02FL+B2YTu5izqZFhr6JAvdq2z
        niLS9lPa+YzKGDTMTY6DUEw6ZtSsIR1FecvKApQ=
X-Google-Smtp-Source: ABdhPJx9IZJbvIVNFqSD8EaAMHGmqYjDHcu2Q9CDLbmcwVFlS1Z+L6F23N3gLM/O9axRTpzdv9Z96Atgun6IsSBoIpw=
X-Received: by 2002:adf:f446:: with SMTP id f6mr5663745wrp.361.1628172158975;
 Thu, 05 Aug 2021 07:02:38 -0700 (PDT)
MIME-Version: 1.0
References: <20210805133213.700-1-lukas.bulwahn@gmail.com>
In-Reply-To: <20210805133213.700-1-lukas.bulwahn@gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 5 Aug 2021 16:02:22 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3aNuxaEtAiewd+Wjc8hKtca0NrcV2kykkNC-qKT_HhzQ@mail.gmail.com>
Message-ID: <CAK8P3a3aNuxaEtAiewd+Wjc8hKtca0NrcV2kykkNC-qKT_HhzQ@mail.gmail.com>
Subject: Re: [PATCH] rbtree: remove unneeded explicit alignment in struct rb_node
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Michel Lespinasse <michel@lespinasse.org>,
        Davidlohr Bueso <dbueso@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mete Polat <metepolat2000@gmail.com>,
        Jesper Nilsson <jesper@jni.nu>, Arnd Bergmann <arnd@arndb.de>,
        David Woodhouse <dwmw2@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        kernel-janitors@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:7XNpPq5iYsHfDhqRQDzw2R1dBZxBT+c/X9okG2p8NNHxdAMg8vo
 GwdMHBo5KUeykq/QODG1hzrZIn44/r7Sr9liqRpP6NE2yq+xPoV5OIp3uI1UVnGePzc69Qr
 z0huAlc1HHm0zTNKmqv43SXpm/rdR/9NC8ligtIjfSyqoJSbvnpmJFNeC9Gb1zZw9HgreMD
 cVm1tS9IARBJKKOkUHiKQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:hFdSdPkGpOc=:MOYjvq2WcPq0Hu0VBhZCRC
 GcJOFqDGPVo3TcljuB4FzFtjqtTQ4V3+sRX4Tj9A2V2mzw1p7J5e/K8tGtV3G/56e6ua/2u5S
 D2QM/eEtc08cJvygTEZeYK6tGrYTvwENuaF4tkdxG73/pNysKIjze3O5PXik3PB00drPuJ0K+
 o+r8r6vz2JrgWkWJN74/XP8u/m9IU144ZRCp8fgzp5yBPxTpWU3IMqGpsuVSOka0QfKkuB2ci
 /k+uwXq01WIBe+BZP6EZZpQy2uW3OLpiuo5ve9QpDatV5T8EtUh4JXQlky2+CrqugrpcCBqPr
 gX+gVHGz8MesxTTOmByxwT0uR2AgfP7w//EFQusOUAjpPFA5sAKT/oYtLVWQKFi8bNNjRMoej
 hOVat2vo0Yt7qBQVp3J+lFgpH23TL/BoGmX9cmJZuRiZE4KOeALDwfCBAtAD0uoBZxfgcXejM
 JeNJPivLFUTlGAF3dPSvXWMn92AX0D+cj4a8jvvU7w16AdrNDoEqzsNTccLWPXsKQq6m/ojYa
 D6mZ2nfZyGddBOKxv30xVsWxrE7wl3kfUK18DqBuOvmL60gDRVTjGU3Kf6C4rX5IQuNF+63ft
 eeF3Y6yDWzJ/G74aMLyJcvvYJktFKvk2/fq4Kk83dYifGtUZhoaQEkZ1cDTMcz/vZqghGhEti
 7mPbMCjmjX+QXRXa/6uFmarXFs0jlpfqfGMSgOOoWOIg0XPkIFG6etOv+R+vKD2BsbR4DvdlU
 sM9EI2ikiumOq2auQzzgQtd8QF1FRP8GKaq0/AkbKDuYa9grfJZ9Kq+bx2uN09b2ixuzxGguZ
 aDSsCahx8ZC/LmXEOglPBfNSiRRLdSOayPBTJobkQCZclfuk+31R8v7lPTrYvXzW/lhgF9Q
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 5, 2021 at 3:32 PM Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:
>
> Commit e977145aeaad ("[RBTREE] Add explicit alignment to sizeof(long) for
> struct rb_node.") adds an explicit alignment to the struct rb_node due to
> some speciality of the CRIS architecture.
>
> The support for the CRIS architecture was removed with commit c690eddc2f3b
> ("CRIS: Drop support for the CRIS port")
>
> So, remove this now unneeded explicit alignment in struct rb_node as well.
>
> This basically reverts commit e977145aeaad ("[RBTREE] Add explicit
> alignment to sizeof(long) for struct rb_node.").
>
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Reported-by: Mete Polat <metepolat2000@gmail.com>
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> ---
> applies cleanly on next-20210804, but only x86 compile-checked.
>
> Michel, Davidlohr, Jesper, David, please ack.
>
> Mete, you might want to re-run your RBT test suite for this change.
>
> Andrew, once acked, please pick this minor cleanup into your tree.

Do you know why it needed the extra alignment on cris at the time?

The revert would appear to change the alignment to 16 bits instead
of 32 bits on m68k as well (not 8 bits as on cris), but I don't know if that
can cause problems there.

        Arnd
