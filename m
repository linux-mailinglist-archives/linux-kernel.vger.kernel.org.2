Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C095E3A206E
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 00:50:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230302AbhFIWwt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 18:52:49 -0400
Received: from mout.gmx.net ([212.227.17.21]:46473 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229534AbhFIWws (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 18:52:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1623279046;
        bh=RqYY8u4hv2d4yF1SHizsrOunrlB6Tr2rnQRqCPVIT8g=;
        h=X-UI-Sender-Class:Subject:To:References:Cc:From:Date:In-Reply-To;
        b=Enb3Q6wVgYyAeopCGtOkQKtd8pT1X6DSncgVJrONiKhseE9Yh1AuyoTNfApfq72qe
         ezVXD7lQv7p+XG2zM3pLb0f1oKNO+4wc7DTiu6rxa176k902FzKIm9q7xz1mTQ7lFm
         BWu7q/pCVwtPF+8i9hApRYGda5rzyoEA1ivzqoaQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.20.60] ([92.116.185.40]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MLi8m-1lZRck1euO-00Hd83; Thu, 10
 Jun 2021 00:50:46 +0200
Subject: Re: linux-parisc compile failure in current git
To:     Masahiro Yamada <masahiroy@kernel.org>
References: <892b6ab7-862c-1c0a-2996-0f8408e5043d@linux.ee>
Cc:     linux-parisc@vger.kernel.org, Meelis Roos <mroos@linux.ee>,
        Linux Kernel Development <linux-kernel@vger.kernel.org>
From:   Helge Deller <deller@gmx.de>
Message-ID: <89515325-fc21-31da-d238-6f7a9abbf9a0@gmx.de>
Date:   Thu, 10 Jun 2021 00:49:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <892b6ab7-862c-1c0a-2996-0f8408e5043d@linux.ee>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:O0uJEiZ2FGMw/+evDii6PW7w6K6ab3yAG10hnCH8hu/zuimYYE8
 94QoAvNhUgl0DPda8bCbR4mKfIvW6jVMc7BML0BG9t5NB77saWwXU1dBiSGr8Ujp6BrUbBi
 KFTfwmbDSsrpQEilL1x9VevfFbs6jfcCaOi3Zs+YM+yqNDWECm43/s1G45EUjDWEZ1P2Yco
 lFcegheN1sCpzR0iFvJBA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:XPmM8H2AZ2s=:P4Bih2VmFSw3xEGaj57lAA
 o6mjshkeOeThbUiLqPA3dx9itsfx1dS6kftlJ/TYWENDa3FTurqt+F6FwYXdRKG+CmLph7r0o
 eoqtDk4SZEwqxGnYezyrWKAyiZwekqSe5cOQ6KZ6E70zxtu5H8sW+56+iqPSLhWOgJ4GeDRc9
 mfp+VMo94d1vpGK9uiVkz0WwzhOLAeuGx5r3ckyXX9T3+TKE8h2pdvXtkdUa5J3PhQlKzkQjW
 ChCY1yi3ZmK2IJdJI2YSVXPLUqa5OVAGYksU+RXxRZXFLlxd6+nCltPbpHOmjMkBC8BpnKITK
 3p8h1YQ0VQgLz4I+iikDNNQXuzyQGV1fKWFl5m3LpaJmDbK5rjvwalSvfq2h4MokpXFyOtcvG
 nKgPYoQCaHDH7CBcwNdI4GwnCE0GDg5m7nFmRkC2k09/rSn5skPmIzHK6NU/BqL98Bopk1q6Y
 OzX9WO+r+rWiGnPNj+mw0oz+9v1fCfnuOB7EuLxRWlKgyd/q64kjjnNvJ72w0fVRT9vAr1RW4
 YwS/6Lq8hPdyZuRlnFvFTmde1tEbF+3G0HARqCEUYtrpt7qIzU8C0YZ0+cIbCbb+mQp2jNyV3
 eeRivHIL6ichf5LEM85ZNHhYhKfox/Y+ZWDIRWVqzix/ZUx72VfDDAm482GP32x6OuZteqCw2
 PzneVPKSFhSo9lcRf4SQ8iFrejMpzoJLkdr8NPxF/FjidXwZCeicbWOg+fAzsn/uQQz4CUIbf
 126cNJ/GxS4LCzgL0qhX/g92yg1ZuxLfoVRsLgKa+G/Rc2QYE+YQu508TAUf4r4xdUIqx59VL
 xPvA+qHQR4QVoPoDkYGHWfzrJ03DlEqFkU31wYCVUfruFVZDYz3kmKttCjEyAdCFEdJZsJDFt
 OAdXZptIxiOVqinx+epKcc6e8CyhcU7ej29bvWjPO0StBEyAqMbC7yLqwLqc4XSCOjXf/BmYA
 Qw5OT899NEmw13wQdl2jEM64w8vO1igrKggehQpqfAsQmwB3ODMdpGc0wS8zBsytRSNDZaAzJ
 mvXOHekXtG/ugVekhKh7fsSkGjJy5hf2ifG64x1ApJtWlvenr7nN3FSwnXF/LFCqPWbPTng+J
 yBy4mdUBvBI43FfbBNKFcJPHFm8pk7/Gkty
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/1/21 12:21 PM, Meelis Roos wrote:
> Upstream Linux git fails to compile on gentoo hppa -=C2=A0 .config below=
.
> I have 2 gcc-s as always:
> $ gcc-config -l
>  =C2=A0[1] hppa2.0-unknown-linux-gnu-9.3.0
>  =C2=A0[2] hppa2.0-unknown-linux-gnu-10.2.0 *
>
>  =C2=A0[3] hppa64-unknown-linux-gnu-10.2.0 *


I see the same issue too, but only when compiling natively on a parisc mac=
hine.
Cross-compiling on a x86 box works nicely.

First I thought it's a problem with setting the "cross_compiling" flag in =
./Makefile.
But that's not sufficient.

On a x86 machine (which builds fine) I get
SRCARCH=3Dparisc SUBARCH=3Dx86 UTS_MACHINE=3Dparisc
The arch/parisc/kernel/asm-offsets.c file gets preprocessed via:
hppa64-linux-gnu-gcc

On a native 32bit parisc machine I have:
SRCARCH=3Dparisc SUBARCH=3Dparisc UTS_MACHINE=3Dparisc
Here the arch/parisc/kernel/asm-offsets.c file gets preprocessed via:
gcc
Instead here the native hppa64-linux-gnu-gcc (cross compiler) should have =
been used too, since
we build a 64-bit hppa kernel (CONFIG_64BIT is set).
Note, on hppa we don't have an "-m64" compiler flag as on x86.

Mashahiro, do you maybe have an idea what gets wrong here, or which
patch has changed the behaviour how the asm-offsets.c file gets preprocess=
ed?

Thanks,
Helge


> $ hppa2.0-unknown-linux-gnu-gcc -v
> Using built-in specs.
> COLLECT_GCC=3Dhppa2.0-unknown-linux-gnu-gcc
> COLLECT_LTO_WRAPPER=3D/usr/libexec/gcc/hppa2.0-unknown-linux-gnu/10.2.0/=
lto-wrapper
> Target: hppa2.0-unknown-linux-gnu
> Configured with: /var/tmp/portage/sys-devel/gcc-10.2.0-r5/work/gcc-10.2.=
0/configure --host=3Dhppa2.0-unknown-linux-gnu --build=3Dhppa2.0-unknown-l=
inux-gnu --prefix=3D/usr --bindir=3D/usr/hppa2.0-unknown-linux-gnu/gcc-bin=
/10.2.0 --includedir=3D/usr/lib/gcc/hppa2.0-unknown-linux-gnu/10.2.0/inclu=
de --datadir=3D/usr/share/gcc-data/hppa2.0-unknown-linux-gnu/10.2.0 --mand=
ir=3D/usr/share/gcc-data/hppa2.0-unknown-linux-gnu/10.2.0/man --infodir=3D=
/usr/share/gcc-data/hppa2.0-unknown-linux-gnu/10.2.0/info --with-gxx-inclu=
de-dir=3D/usr/lib/gcc/hppa2.0-unknown-linux-gnu/10.2.0/include/g++-v10 --w=
ith-python-dir=3D/share/gcc-data/hppa2.0-unknown-linux-gnu/10.2.0/python -=
-enable-languages=3Dc,c++,fortran --enable-obsolete --enable-secureplt --d=
isable-werror --with-system-zlib --enable-nls --without-included-gettext -=
-enable-checking=3Drelease --with-bugurl=3Dhttps://bugs.gentoo.org/ --with=
-pkgversion=3D'Gentoo 10.2.0-r5 p6' --disable-esp --enable-libstdcxx-time =
--enable-shared --enable-threads=3Dposix
> --enable-__cxa_atexit --enable-clocale=3Dgnu --disable-multilib --disabl=
e-fixed-point --enable-libgomp --disable-libssp --disable-libada --disable=
-systemtap --disable-vtable-verify --disable-libvtv --without-zstd --enabl=
e-lto --without-isl --disable-libsanitizer --enable-default-pie --disable-=
default-ssp
>
> hppa64-unknown-linux-gnu-gcc -v
> Using built-in specs.
> COLLECT_GCC=3Dhppa64-unknown-linux-gnu-gcc
> COLLECT_LTO_WRAPPER=3D/usr/libexec/gcc/hppa64-unknown-linux-gnu/10.2.0/l=
to-wrapper
> Target: hppa64-unknown-linux-gnu
> Configured with: /var/tmp/portage/sys-devel/kgcc64-10.2.0/work/gcc-10.2.=
0/configure --host=3Dhppa2.0-unknown-linux-gnu --target=3Dhppa64-unknown-l=
inux-gnu --build=3Dhppa2.0-unknown-linux-gnu --prefix=3D/usr --bindir=3D/u=
sr/hppa2.0-unknown-linux-gnu/hppa64-unknown-linux-gnu/gcc-bin/10.2.0 --inc=
ludedir=3D/usr/lib/gcc/hppa64-unknown-linux-gnu/10.2.0/include --datadir=
=3D/usr/share/gcc-data/hppa64-unknown-linux-gnu/10.2.0 --mandir=3D/usr/sha=
re/gcc-data/hppa64-unknown-linux-gnu/10.2.0/man --infodir=3D/usr/share/gcc=
-data/hppa64-unknown-linux-gnu/10.2.0/info --with-gxx-include-dir=3D/usr/l=
ib/gcc/hppa64-unknown-linux-gnu/10.2.0/include/g++-v10 --with-python-dir=
=3D/share/gcc-data/hppa64-unknown-linux-gnu/10.2.0/python --enable-languag=
es=3Dc --enable-obsolete --enable-secureplt --disable-werror --with-system=
-zlib --enable-nls --without-included-gettext --with-bugurl=3Dhttps://bugs=
.gentoo.org/ --with-pkgversion=3D'Gentoo 10.2.0 p1' --disable-libstdcxx-pc=
h --enable-poison-system-directories --disable-shared
> --disable-libquadmath --disable-libatomic --disable-threads --without-he=
aders --disable-bootstrap --enable-__cxa_atexit --enable-clocale=3Dgnu --d=
isable-multilib --disable-libgomp --disable-libssp --enable-lto --without-=
isl --disable-libsanitizer
> Thread model: single
> Supported LTO compression algorithms: zlib zstd
> gcc version 10.2.0 (Gentoo 10.2.0 p1)
>
>
>
>
>  =C2=A0 SYNC=C2=A0=C2=A0=C2=A0 include/config/auto.conf.cmd
>  =C2=A0 UPD=C2=A0=C2=A0=C2=A0=C2=A0 include/config/kernel.release
>  =C2=A0 UPD=C2=A0=C2=A0=C2=A0=C2=A0 include/generated/utsrelease.h
>  =C2=A0 CC=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 arch/parisc/kernel/asm-offsets.=
s
> In file included from ./arch/parisc/include/asm/bitops.h:203,
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 from ./include/linux/bitops.h:32,
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 from ./include/linux/kernel.h:12,
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 from ./arch/parisc/include/asm/bug.h:5,
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 from ./include/linux/bug.h:5,
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 from ./include/linux/thread_info.h:12,
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 from ./include/asm-generic/current.h:5,
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 from ./arch/parisc/include/generated/asm/curre=
nt.h:1,
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 from ./include/linux/sched.h:12,
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 from arch/parisc/kernel/asm-offsets.c:18:
> ./include/asm-generic/bitops/__fls.h: In function =E2=80=98__fls=E2=80=
=99:
> ./include/asm-generic/bitops/__fls.h:18:21: warning: left shift count >=
=3D width of type [-Wshift-count-overflow]
>  =C2=A0=C2=A0 18 |=C2=A0 if (!(word & (~0ul << 32))) {
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 ^~
> ./include/asm-generic/bitops/__fls.h:20:8: warning: left shift count >=
=3D width of type [-Wshift-count-overflow]
>  =C2=A0=C2=A0 20 |=C2=A0=C2=A0 word <<=3D 32;
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 ^~~
> ./include/asm-generic/bitops/__fls.h:23:21: warning: left shift count >=
=3D width of type [-Wshift-count-overflow]
>  =C2=A0=C2=A0 23 |=C2=A0 if (!(word & (~0ul << (BITS_PER_LONG-16)))) {
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 ^~
> ./include/asm-generic/bitops/__fls.h:27:21: warning: left shift count >=
=3D width of type [-Wshift-count-overflow]
>  =C2=A0=C2=A0 27 |=C2=A0 if (!(word & (~0ul << (BITS_PER_LONG-8)))) {
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 ^~
> ./include/asm-generic/bitops/__fls.h:31:21: warning: left shift count >=
=3D width of type [-Wshift-count-overflow]
>  =C2=A0=C2=A0 31 |=C2=A0 if (!(word & (~0ul << (BITS_PER_LONG-4)))) {
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 ^~
> ./include/asm-generic/bitops/__fls.h:35:21: warning: left shift count >=
=3D width of type [-Wshift-count-overflow]
>  =C2=A0=C2=A0 35 |=C2=A0 if (!(word & (~0ul << (BITS_PER_LONG-2)))) {
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 ^~
> ./include/asm-generic/bitops/__fls.h:39:21: warning: left shift count >=
=3D width of type [-Wshift-count-overflow]
>  =C2=A0=C2=A0 39 |=C2=A0 if (!(word & (~0ul << (BITS_PER_LONG-1))))
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 ^~
> In file included from ./arch/parisc/include/asm/processor.h:17,
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 from ./arch/parisc/include/asm/thread_info.h:8=
,
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 from ./include/linux/thread_info.h:59,
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 from ./include/asm-generic/current.h:5,
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 from ./arch/parisc/include/generated/asm/curre=
nt.h:1,
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 from ./include/linux/sched.h:12,
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 from arch/parisc/kernel/asm-offsets.c:18:
> ./arch/parisc/include/asm/pdc.h: At top level:
> ./arch/parisc/include/asm/pdc.h:75:10: warning: =E2=80=98struct pdc_memo=
ry_table=E2=80=99 declared inside parameter list will not be visible outsi=
de of this definition or declaration
>  =C2=A0=C2=A0 75 |=C2=A0=C2=A0 struct pdc_memory_table *tbl, unsigned lo=
ng entries);
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 ^~~~~~~~~~~~~~~~
> ./arch/parisc/include/asm/pdc.h:74:30: warning: =E2=80=98struct pdc_memo=
ry_table_raddr=E2=80=99 declared inside parameter list will not be visible=
 outside of this definition or declaration
>  =C2=A0=C2=A0 74 | int pdc_mem_mem_table(struct pdc_memory_table_raddr *=
r_addr,
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ^~~~~~~~~~=
~~~~~~~~~~~~
> In file included from ././include/linux/compiler_types.h:65,
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 from <command-line>:
> ./include/linux/smp.h:34:26: error: requested alignment =E2=80=9820=E2=
=80=99 is not a positive power of 2
>  =C2=A0=C2=A0 34 |=C2=A0 __aligned(sizeof(struct __call_single_data));
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ^~~~~~~~~~~~~~~~~~
> ./include/linux/compiler_attributes.h:52:68: note: in definition of macr=
o =E2=80=98__aligned=E2=80=99
>  =C2=A0=C2=A0 52 | #define __aligned(x)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 __attribute__((__aligned__(x)))
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 ^
> In file included from ./include/linux/mm.h:33,
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 from ./include/linux/pid_namespace.h:7,
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 from ./include/linux/ptrace.h:10,
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 from arch/parisc/kernel/asm-offsets.c:20:
> ./include/linux/pgtable.h: In function =E2=80=98pud_index=E2=80=99:
> ./include/linux/pgtable.h:59:18: warning: right shift count >=3D width o=
f type [-Wshift-count-overflow]
>  =C2=A0=C2=A0 59 |=C2=A0 return (address >> PUD_SHIFT) & (PTRS_PER_PUD -=
 1);
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ^~
> ./include/linux/pgtable.h: In function =E2=80=98pgd_offset_pgd=E2=80=99:
> ./include/linux/pgtable.h:66:29: warning: right shift count >=3D width o=
f type [-Wshift-count-overflow]
>  =C2=A0=C2=A0 66 | #define pgd_index(a)=C2=A0 (((a) >> PGDIR_SHIFT) & (P=
TRS_PER_PGD - 1))
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ^~
> ./include/linux/pgtable.h:106:16: note: in expansion of macro =E2=80=98p=
gd_index=E2=80=99
>  =C2=A0 106 |=C2=A0 return (pgd + pgd_index(address));
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ^~~~~~~~~
> In file included from ./include/linux/stringhash.h:7,
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 from ./include/linux/dcache.h:15,
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 from ./include/linux/fs.h:8,
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 from ./include/linux/huge_mm.h:8,
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 from ./include/linux/mm.h:726,
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 from ./include/linux/pid_namespace.h:7,
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 from ./include/linux/ptrace.h:10,
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 from arch/parisc/kernel/asm-offsets.c:20:
> ./include/linux/hash.h: In function =E2=80=98hash32_ptr=E2=80=99:
> ./include/linux/hash.h:99:14: warning: right shift count >=3D width of t=
ype [-Wshift-count-overflow]
>  =C2=A0=C2=A0 99 |=C2=A0 val ^=3D (val >> 32);
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ^~
> In file included from arch/parisc/kernel/asm-offsets.c:22:
> arch/parisc/kernel/asm-offsets.c: In function =E2=80=98main=E2=80=99:
> arch/parisc/kernel/asm-offsets.c:272:36: warning: right shift count >=3D=
 width of type [-Wshift-count-overflow]
>  =C2=A0 272 |=C2=A0 DEFINE(ASM_PGD_ENTRY, PAGE_OFFSET >> PGDIR_SHIFT);
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 ^~
> ./include/linux/kbuild.h:6:62: note: in definition of macro =E2=80=98DEF=
INE=E2=80=99
>  =C2=A0=C2=A0=C2=A0 6 |=C2=A0 asm volatile("\n.ascii \"->" #sym " %0 " #=
val "\"" : : "i" (val))
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ^~~
> make[1]: *** [scripts/Makefile.build:117: arch/parisc/kernel/asm-offsets=
.s] Error 1
> make: *** [Makefile:1232: prepare0] Error 2
> mroos@rp2470 ~/linux $ git pull && make oldconfig && make=C2=A0 && echo =
OK
> Already up to date.
> #
> # No change to .config
> #
>  =C2=A0 CC=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 arch/parisc/kernel/asm-offsets.=
s
> In file included from ./arch/parisc/include/asm/bitops.h:203,
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 from ./include/linux/bitops.h:32,
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 from ./include/linux/kernel.h:12,
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 from ./arch/parisc/include/asm/bug.h:5,
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 from ./include/linux/bug.h:5,
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 from ./include/linux/thread_info.h:12,
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 from ./include/asm-generic/current.h:5,
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 from ./arch/parisc/include/generated/asm/curre=
nt.h:1,
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 from ./include/linux/sched.h:12,
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 from arch/parisc/kernel/asm-offsets.c:18:
> ./include/asm-generic/bitops/__fls.h: In function =E2=80=98__fls=E2=80=
=99:
> ./include/asm-generic/bitops/__fls.h:18:21: warning: left shift count >=
=3D width of type [-Wshift-count-overflow]
>  =C2=A0=C2=A0 18 |=C2=A0 if (!(word & (~0ul << 32))) {
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 ^~
> ./include/asm-generic/bitops/__fls.h:20:8: warning: left shift count >=
=3D width of type [-Wshift-count-overflow]
>  =C2=A0=C2=A0 20 |=C2=A0=C2=A0 word <<=3D 32;
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 ^~~
> ./include/asm-generic/bitops/__fls.h:23:21: warning: left shift count >=
=3D width of type [-Wshift-count-overflow]
>  =C2=A0=C2=A0 23 |=C2=A0 if (!(word & (~0ul << (BITS_PER_LONG-16)))) {
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 ^~
> ./include/asm-generic/bitops/__fls.h:27:21: warning: left shift count >=
=3D width of type [-Wshift-count-overflow]
>  =C2=A0=C2=A0 27 |=C2=A0 if (!(word & (~0ul << (BITS_PER_LONG-8)))) {
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 ^~
> ./include/asm-generic/bitops/__fls.h:31:21: warning: left shift count >=
=3D width of type [-Wshift-count-overflow]
>  =C2=A0=C2=A0 31 |=C2=A0 if (!(word & (~0ul << (BITS_PER_LONG-4)))) {
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 ^~
> ./include/asm-generic/bitops/__fls.h:35:21: warning: left shift count >=
=3D width of type [-Wshift-count-overflow]
>  =C2=A0=C2=A0 35 |=C2=A0 if (!(word & (~0ul << (BITS_PER_LONG-2)))) {
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 ^~
> ./include/asm-generic/bitops/__fls.h:39:21: warning: left shift count >=
=3D width of type [-Wshift-count-overflow]
>  =C2=A0=C2=A0 39 |=C2=A0 if (!(word & (~0ul << (BITS_PER_LONG-1))))
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 ^~
> In file included from ./arch/parisc/include/asm/processor.h:17,
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 from ./arch/parisc/include/asm/thread_info.h:8=
,
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 from ./include/linux/thread_info.h:59,
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 from ./include/asm-generic/current.h:5,
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 from ./arch/parisc/include/generated/asm/curre=
nt.h:1,
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 from ./include/linux/sched.h:12,
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 from arch/parisc/kernel/asm-offsets.c:18:
> ./arch/parisc/include/asm/pdc.h: At top level:
> ./arch/parisc/include/asm/pdc.h:75:10: warning: =E2=80=98struct pdc_memo=
ry_table=E2=80=99 declared inside parameter list will not be visible outsi=
de of this definition or declaration
>  =C2=A0=C2=A0 75 |=C2=A0=C2=A0 struct pdc_memory_table *tbl, unsigned lo=
ng entries);
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 ^~~~~~~~~~~~~~~~
> ./arch/parisc/include/asm/pdc.h:74:30: warning: =E2=80=98struct pdc_memo=
ry_table_raddr=E2=80=99 declared inside parameter list will not be visible=
 outside of this definition or declaration
>  =C2=A0=C2=A0 74 | int pdc_mem_mem_table(struct pdc_memory_table_raddr *=
r_addr,
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ^~~~~~~~~~=
~~~~~~~~~~~~
> In file included from ././include/linux/compiler_types.h:65,
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 from <command-line>:
> ./include/linux/smp.h:34:26: error: requested alignment =E2=80=9820=E2=
=80=99 is not a positive power of 2
>  =C2=A0=C2=A0 34 |=C2=A0 __aligned(sizeof(struct __call_single_data));
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ^~~~~~~~~~~~~~~~~~
> ./include/linux/compiler_attributes.h:52:68: note: in definition of macr=
o =E2=80=98__aligned=E2=80=99
>  =C2=A0=C2=A0 52 | #define __aligned(x)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 __attribute__((__aligned__(x)))
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 ^
> In file included from ./include/linux/mm.h:33,
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 from ./include/linux/pid_namespace.h:7,
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 from ./include/linux/ptrace.h:10,
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 from arch/parisc/kernel/asm-offsets.c:20:
> ./include/linux/pgtable.h: In function =E2=80=98pud_index=E2=80=99:
> ./include/linux/pgtable.h:59:18: warning: right shift count >=3D width o=
f type [-Wshift-count-overflow]
>  =C2=A0=C2=A0 59 |=C2=A0 return (address >> PUD_SHIFT) & (PTRS_PER_PUD -=
 1);
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ^~
> ./include/linux/pgtable.h: In function =E2=80=98pgd_offset_pgd=E2=80=99:
> ./include/linux/pgtable.h:66:29: warning: right shift count >=3D width o=
f type [-Wshift-count-overflow]
>  =C2=A0=C2=A0 66 | #define pgd_index(a)=C2=A0 (((a) >> PGDIR_SHIFT) & (P=
TRS_PER_PGD - 1))
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ^~
> ./include/linux/pgtable.h:106:16: note: in expansion of macro =E2=80=98p=
gd_index=E2=80=99
>  =C2=A0 106 |=C2=A0 return (pgd + pgd_index(address));
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ^~~~~~~~~
> In file included from ./include/linux/stringhash.h:7,
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 from ./include/linux/dcache.h:15,
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 from ./include/linux/fs.h:8,
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 from ./include/linux/huge_mm.h:8,
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 from ./include/linux/mm.h:726,
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 from ./include/linux/pid_namespace.h:7,
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 from ./include/linux/ptrace.h:10,
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 from arch/parisc/kernel/asm-offsets.c:20:
> ./include/linux/hash.h: In function =E2=80=98hash32_ptr=E2=80=99:
> ./include/linux/hash.h:99:14: warning: right shift count >=3D width of t=
ype [-Wshift-count-overflow]
>  =C2=A0=C2=A0 99 |=C2=A0 val ^=3D (val >> 32);
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ^~
> In file included from arch/parisc/kernel/asm-offsets.c:22:
> arch/parisc/kernel/asm-offsets.c: In function =E2=80=98main=E2=80=99:
> arch/parisc/kernel/asm-offsets.c:272:36: warning: right shift count >=3D=
 width of type [-Wshift-count-overflow]
>  =C2=A0 272 |=C2=A0 DEFINE(ASM_PGD_ENTRY, PAGE_OFFSET >> PGDIR_SHIFT);
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 ^~
> ./include/linux/kbuild.h:6:62: note: in definition of macro =E2=80=98DEF=
INE=E2=80=99
>  =C2=A0=C2=A0=C2=A0 6 |=C2=A0 asm volatile("\n.ascii \"->" #sym " %0 " #=
val "\"" : : "i" (val))
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ^~~
> make[1]: *** [scripts/Makefile.build:117: arch/parisc/kernel/asm-offsets=
.s] Error 1
> make: *** [Makefile:1232: prepare0] Error 2
>
>
> .config:
> #
> # Automatically generated file; DO NOT EDIT.
> # Linux/parisc 5.13.0-rc4 Kernel Configuration
> #
> CONFIG_CC_VERSION_TEXT=3D"gcc (Gentoo 10.2.0-r5 p6) 10.2.0"
> CONFIG_CC_IS_GCC=3Dy
> CONFIG_GCC_VERSION=3D100200
> CONFIG_CLANG_VERSION=3D0
> CONFIG_AS_IS_GNU=3Dy
> CONFIG_AS_VERSION=3D23502
> CONFIG_LD_IS_BFD=3Dy
> CONFIG_LD_VERSION=3D23502
> CONFIG_LLD_VERSION=3D0
> CONFIG_CC_CAN_LINK=3Dy
> CONFIG_CC_CAN_LINK_STATIC=3Dy
> CONFIG_CC_HAS_ASM_GOTO=3Dy
> CONFIG_CC_HAS_ASM_INLINE=3Dy
> CONFIG_IRQ_WORK=3Dy
> CONFIG_BUILDTIME_TABLE_SORT=3Dy
>
> #
> # General setup
> #
> CONFIG_BROKEN_ON_SMP=3Dy
> CONFIG_INIT_ENV_ARG_LIMIT=3D32
> # CONFIG_COMPILE_TEST is not set
> CONFIG_LOCALVERSION=3D""
> CONFIG_LOCALVERSION_AUTO=3Dy
> CONFIG_BUILD_SALT=3D""
> CONFIG_HAVE_KERNEL_GZIP=3Dy
> CONFIG_HAVE_KERNEL_BZIP2=3Dy
> CONFIG_HAVE_KERNEL_LZMA=3Dy
> CONFIG_HAVE_KERNEL_XZ=3Dy
> CONFIG_HAVE_KERNEL_LZO=3Dy
> CONFIG_HAVE_KERNEL_LZ4=3Dy
> # CONFIG_KERNEL_GZIP is not set
> # CONFIG_KERNEL_BZIP2 is not set
> # CONFIG_KERNEL_LZMA is not set
> # CONFIG_KERNEL_XZ is not set
> CONFIG_KERNEL_LZO=3Dy
> # CONFIG_KERNEL_LZ4 is not set
> CONFIG_DEFAULT_INIT=3D""
> CONFIG_DEFAULT_HOSTNAME=3D"rp2470"
> CONFIG_SWAP=3Dy
> CONFIG_SYSVIPC=3Dy
> CONFIG_SYSVIPC_SYSCTL=3Dy
> CONFIG_POSIX_MQUEUE=3Dy
> CONFIG_POSIX_MQUEUE_SYSCTL=3Dy
> # CONFIG_WATCH_QUEUE is not set
> CONFIG_CROSS_MEMORY_ATTACH=3Dy
> # CONFIG_USELIB is not set
> # CONFIG_AUDIT is not set
> CONFIG_HAVE_ARCH_AUDITSYSCALL=3Dy
>
> #
> # IRQ subsystem
> #
> CONFIG_GENERIC_IRQ_PROBE=3Dy
> # end of IRQ subsystem
>
> CONFIG_LEGACY_TIMER_TICK=3Dy
> CONFIG_BPF=3Dy
>
> #
> # BPF subsystem
> #
> CONFIG_BPF_SYSCALL=3Dy
> # CONFIG_BPF_UNPRIV_DEFAULT_OFF is not set
> # CONFIG_BPF_PRELOAD is not set
> # end of BPF subsystem
>
> CONFIG_PREEMPT_NONE=3Dy
> # CONFIG_PREEMPT_VOLUNTARY is not set
> # CONFIG_PREEMPT is not set
>
> #
> # CPU/Task time and stats accounting
> #
> CONFIG_TICK_CPU_ACCOUNTING=3Dy
> # CONFIG_BSD_PROCESS_ACCT is not set
> # CONFIG_TASKSTATS is not set
> # CONFIG_PSI is not set
> # end of CPU/Task time and stats accounting
>
> #
> # RCU Subsystem
> #
> CONFIG_TINY_RCU=3Dy
> # CONFIG_RCU_EXPERT is not set
> CONFIG_SRCU=3Dy
> CONFIG_TINY_SRCU=3Dy
> CONFIG_TASKS_RCU_GENERIC=3Dy
> CONFIG_TASKS_TRACE_RCU=3Dy
> # end of RCU Subsystem
>
> # CONFIG_IKCONFIG is not set
> # CONFIG_IKHEADERS is not set
> CONFIG_LOG_BUF_SHIFT=3D17
> CONFIG_PRINTK_SAFE_LOG_BUF_SHIFT=3D13
> CONFIG_GENERIC_SCHED_CLOCK=3Dy
>
> #
> # Scheduler features
> #
> # end of Scheduler features
>
> CONFIG_CGROUPS=3Dy
> # CONFIG_MEMCG is not set
> # CONFIG_BLK_CGROUP is not set
> # CONFIG_CGROUP_SCHED is not set
> # CONFIG_CGROUP_PIDS is not set
> # CONFIG_CGROUP_RDMA is not set
> # CONFIG_CGROUP_FREEZER is not set
> # CONFIG_CGROUP_HUGETLB is not set
> # CONFIG_CGROUP_DEVICE is not set
> # CONFIG_CGROUP_CPUACCT is not set
> CONFIG_CGROUP_BPF=3Dy
> # CONFIG_CGROUP_MISC is not set
> # CONFIG_CGROUP_DEBUG is not set
> CONFIG_SOCK_CGROUP_DATA=3Dy
> CONFIG_NAMESPACES=3Dy
> CONFIG_UTS_NS=3Dy
> CONFIG_IPC_NS=3Dy
> CONFIG_USER_NS=3Dy
> CONFIG_PID_NS=3Dy
> CONFIG_NET_NS=3Dy
> # CONFIG_CHECKPOINT_RESTORE is not set
> # CONFIG_SCHED_AUTOGROUP is not set
> # CONFIG_SYSFS_DEPRECATED is not set
> # CONFIG_RELAY is not set
> # CONFIG_BLK_DEV_INITRD is not set
> # CONFIG_BOOT_CONFIG is not set
> CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE=3Dy
> # CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
> CONFIG_SYSCTL=3Dy
> CONFIG_SYSCTL_EXCEPTION_TRACE=3Dy
> CONFIG_SYSCTL_ARCH_UNALIGN_ALLOW=3Dy
> # CONFIG_EXPERT is not set
> CONFIG_MULTIUSER=3Dy
> CONFIG_SGETMASK_SYSCALL=3Dy
> CONFIG_SYSFS_SYSCALL=3Dy
> CONFIG_FHANDLE=3Dy
> CONFIG_POSIX_TIMERS=3Dy
> CONFIG_PRINTK=3Dy
> CONFIG_BUG=3Dy
> CONFIG_ELF_CORE=3Dy
> CONFIG_BASE_FULL=3Dy
> CONFIG_FUTEX=3Dy
> CONFIG_FUTEX_PI=3Dy
> CONFIG_EPOLL=3Dy
> CONFIG_SIGNALFD=3Dy
> CONFIG_TIMERFD=3Dy
> CONFIG_EVENTFD=3Dy
> CONFIG_SHMEM=3Dy
> CONFIG_AIO=3Dy
> CONFIG_IO_URING=3Dy
> CONFIG_ADVISE_SYSCALLS=3Dy
> CONFIG_MEMBARRIER=3Dy
> CONFIG_KALLSYMS=3Dy
> # CONFIG_KALLSYMS_ALL is not set
> CONFIG_KALLSYMS_BASE_RELATIVE=3Dy
> CONFIG_USERFAULTFD=3Dy
> # CONFIG_EMBEDDED is not set
> CONFIG_HAVE_PERF_EVENTS=3Dy
>
> #
> # Kernel Performance Events And Counters
> #
> # CONFIG_PERF_EVENTS is not set
> # end of Kernel Performance Events And Counters
>
> CONFIG_VM_EVENT_COUNTERS=3Dy
> CONFIG_SLUB_DEBUG=3Dy
> # CONFIG_COMPAT_BRK is not set
> # CONFIG_SLAB is not set
> CONFIG_SLUB=3Dy
> CONFIG_SLAB_MERGE_DEFAULT=3Dy
> # CONFIG_SLAB_FREELIST_RANDOM is not set
> # CONFIG_SLAB_FREELIST_HARDENED is not set
> # CONFIG_SHUFFLE_PAGE_ALLOCATOR is not set
> # CONFIG_PROFILING is not set
> # end of General setup
>
> CONFIG_PARISC=3Dy
> CONFIG_CPU_BIG_ENDIAN=3Dy
> CONFIG_MMU=3Dy
> CONFIG_STACK_GROWSUP=3Dy
> CONFIG_ARCH_DEFCONFIG=3D"arch/parisc/configs/generic-64bit_defconfig"
> CONFIG_GENERIC_BUG=3Dy
> CONFIG_GENERIC_HWEIGHT=3Dy
> CONFIG_GENERIC_CALIBRATE_DELAY=3Dy
> CONFIG_STACKTRACE_SUPPORT=3Dy
> CONFIG_PGTABLE_LEVELS=3D3
>
> #
> # Processor type and features
> #
> # CONFIG_PA7000 is not set
> # CONFIG_PA7100LC is not set
> # CONFIG_PA7200 is not set
> # CONFIG_PA7300LC is not set
> CONFIG_PA8X00=3Dy
> CONFIG_PA20=3Dy
> CONFIG_PREFETCH=3Dy
> # CONFIG_MLONGCALLS is not set
> CONFIG_64BIT=3Dy
> CONFIG_PARISC_PAGE_SIZE_4KB=3Dy
> CONFIG_PARISC_SELF_EXTRACT=3Dy
> # CONFIG_SMP is not set
> CONFIG_IRQSTACKS=3Dy
> CONFIG_ARCH_SELECT_MEMORY_MODEL=3Dy
> CONFIG_ARCH_SPARSEMEM_ENABLE=3Dy
> CONFIG_ARCH_FLATMEM_ENABLE=3Dy
> CONFIG_ARCH_SPARSEMEM_DEFAULT=3Dy
> # CONFIG_HZ_100 is not set
> CONFIG_HZ_250=3Dy
> # CONFIG_HZ_300 is not set
> # CONFIG_HZ_1000 is not set
> CONFIG_HZ=3D250
> CONFIG_COMPAT=3Dy
> CONFIG_SYSVIPC_COMPAT=3Dy
> CONFIG_AUDIT_ARCH=3Dy
> # CONFIG_KEXEC is not set
> # CONFIG_KEXEC_FILE is not set
> # end of Processor type and features
>
> #
> # Firmware Drivers
> #
> # CONFIG_FW_CFG_SYSFS is not set
> # CONFIG_GOOGLE_FIRMWARE is not set
>
> #
> # Tegra firmware driver
> #
> # end of Tegra firmware driver
> # end of Firmware Drivers
>
> #
> # Bus options (PCI, PCMCIA, EISA, GSC, ISA)
> #
> # CONFIG_GSC is not set
> CONFIG_PCI_LBA=3Dy
> CONFIG_IOSAPIC=3Dy
> CONFIG_IOMMU_SBA=3Dy
> # end of Bus options (PCI, PCMCIA, EISA, GSC, ISA)
>
> #
> # PA-RISC specific drivers
> #
> CONFIG_SUPERIO=3Dy
> CONFIG_CHASSIS_LCD_LED=3Dy
> CONFIG_PDC_CHASSIS=3Dy
> CONFIG_PDC_CHASSIS_WARN=3Dy
> CONFIG_PDC_STABLE=3Dy
> # end of PA-RISC specific drivers
>
> #
> # General architecture-dependent options
> #
> CONFIG_SET_FS=3Dy
> # CONFIG_KPROBES is not set
> CONFIG_JUMP_LABEL=3Dy
> # CONFIG_STATIC_KEYS_SELFTEST is not set
> CONFIG_HAVE_64BIT_ALIGNED_ACCESS=3Dy
> CONFIG_HAVE_KPROBES=3Dy
> CONFIG_HAVE_KRETPROBES=3Dy
> CONFIG_HAVE_KPROBES_ON_FTRACE=3Dy
> CONFIG_HAVE_ARCH_TRACEHOOK=3Dy
> CONFIG_GENERIC_SMP_IDLE_THREAD=3Dy
> CONFIG_HAVE_REGS_AND_STACK_ACCESS_API=3Dy
> CONFIG_HAVE_ARCH_JUMP_LABEL=3Dy
> CONFIG_HAVE_ARCH_JUMP_LABEL_RELATIVE=3Dy
> CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG=3Dy
> CONFIG_HAVE_ARCH_SECCOMP=3Dy
> CONFIG_HAVE_ARCH_SECCOMP_FILTER=3Dy
> CONFIG_SECCOMP=3Dy
> CONFIG_SECCOMP_FILTER=3Dy
> # CONFIG_SECCOMP_CACHE_DEBUG is not set
> CONFIG_LTO_NONE=3Dy
> CONFIG_HAVE_VIRT_CPU_ACCOUNTING_GEN=3Dy
> CONFIG_HAVE_MOD_ARCH_SPECIFIC=3Dy
> CONFIG_MODULES_USE_ELF_RELA=3Dy
> CONFIG_HAVE_SOFTIRQ_ON_OWN_STACK=3Dy
> CONFIG_ARCH_HAS_ELF_RANDOMIZE=3Dy
> CONFIG_HAVE_ARCH_HASH=3Dy
> CONFIG_CLONE_BACKWARDS=3Dy
> CONFIG_COMPAT_32BIT_TIME=3Dy
> CONFIG_CPU_NO_EFFICIENT_FFS=3Dy
> CONFIG_ARCH_HAS_STRICT_KERNEL_RWX=3Dy
> CONFIG_STRICT_KERNEL_RWX=3Dy
>
> #
> # GCOV-based kernel profiling
> #
> # end of GCOV-based kernel profiling
> # end of General architecture-dependent options
>
> CONFIG_RT_MUTEXES=3Dy
> CONFIG_BASE_SMALL=3D0
> CONFIG_MODULES=3Dy
> # CONFIG_MODULE_FORCE_LOAD is not set
> CONFIG_MODULE_UNLOAD=3Dy
> # CONFIG_MODULE_FORCE_UNLOAD is not set
> # CONFIG_MODVERSIONS is not set
> # CONFIG_MODULE_SRCVERSION_ALL is not set
> # CONFIG_MODULE_SIG is not set
> CONFIG_MODULE_COMPRESS_NONE=3Dy
> # CONFIG_MODULE_COMPRESS_GZIP is not set
> # CONFIG_MODULE_COMPRESS_XZ is not set
> # CONFIG_MODULE_COMPRESS_ZSTD is not set
> # CONFIG_MODULE_ALLOW_MISSING_NAMESPACE_IMPORTS is not set
> CONFIG_MODPROBE_PATH=3D"/sbin/modprobe"
> CONFIG_INIT_ALL_POSSIBLE=3Dy
> CONFIG_BLOCK=3Dy
> CONFIG_BLK_SCSI_REQUEST=3Dy
> CONFIG_BLK_DEV_BSG=3Dy
> # CONFIG_BLK_DEV_BSGLIB is not set
> # CONFIG_BLK_DEV_INTEGRITY is not set
> # CONFIG_BLK_DEV_ZONED is not set
> # CONFIG_BLK_CMDLINE_PARSER is not set
> # CONFIG_BLK_WBT is not set
> # CONFIG_BLK_SED_OPAL is not set
> # CONFIG_BLK_INLINE_ENCRYPTION is not set
>
> #
> # Partition Types
> #
> # CONFIG_PARTITION_ADVANCED is not set
> CONFIG_MSDOS_PARTITION=3Dy
> CONFIG_EFI_PARTITION=3Dy
> # end of Partition Types
>
> CONFIG_BLOCK_COMPAT=3Dy
> CONFIG_BLK_MQ_PCI=3Dy
>
> #
> # IO Schedulers
> #
> CONFIG_MQ_IOSCHED_DEADLINE=3Dm
> # CONFIG_MQ_IOSCHED_KYBER is not set
> # CONFIG_IOSCHED_BFQ is not set
> # end of IO Schedulers
>
> CONFIG_INLINE_SPIN_UNLOCK_IRQ=3Dy
> CONFIG_INLINE_READ_UNLOCK=3Dy
> CONFIG_INLINE_READ_UNLOCK_IRQ=3Dy
> CONFIG_INLINE_WRITE_UNLOCK=3Dy
> CONFIG_INLINE_WRITE_UNLOCK_IRQ=3Dy
>
> #
> # Executable file formats
> #
> CONFIG_BINFMT_ELF=3Dy
> CONFIG_COMPAT_BINFMT_ELF=3Dy
> CONFIG_ELFCORE=3Dy
> CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS=3Dy
> CONFIG_BINFMT_SCRIPT=3Dy
> CONFIG_BINFMT_MISC=3Dy
> CONFIG_COREDUMP=3Dy
> # end of Executable file formats
>
> #
> # Memory Management options
> #
> CONFIG_SELECT_MEMORY_MODEL=3Dy
> # CONFIG_FLATMEM_MANUAL is not set
> CONFIG_SPARSEMEM_MANUAL=3Dy
> CONFIG_SPARSEMEM=3Dy
> CONFIG_SPARSEMEM_EXTREME=3Dy
> CONFIG_SPLIT_PTLOCK_CPUS=3D4
> # CONFIG_COMPACTION is not set
> # CONFIG_PAGE_REPORTING is not set
> CONFIG_PHYS_ADDR_T_64BIT=3Dy
> CONFIG_VIRT_TO_BUS=3Dy
> # CONFIG_KSM is not set
> CONFIG_DEFAULT_MMAP_MIN_ADDR=3D4096
> CONFIG_ARCH_SUPPORTS_MEMORY_FAILURE=3Dy
> # CONFIG_MEMORY_FAILURE is not set
> CONFIG_NEED_PER_CPU_KM=3Dy
> # CONFIG_CLEANCACHE is not set
> # CONFIG_FRONTSWAP is not set
> # CONFIG_CMA is not set
> # CONFIG_ZPOOL is not set
> # CONFIG_ZBUD is not set
> # CONFIG_ZSMALLOC is not set
> CONFIG_STACK_MAX_DEFAULT_SIZE_MB=3D100
> # CONFIG_IDLE_PAGE_TRACKING is not set
> # CONFIG_PERCPU_STATS is not set
>
> #
> # GUP_TEST needs to have DEBUG_FS enabled
> #
> # end of Memory Management options
>
> CONFIG_NET=3Dy
> CONFIG_SKB_EXTENSIONS=3Dy
>
> #
> # Networking options
> #
> CONFIG_PACKET=3Dy
> CONFIG_PACKET_DIAG=3Dm
> CONFIG_UNIX=3Dy
> CONFIG_UNIX_SCM=3Dy
> CONFIG_UNIX_DIAG=3Dm
> # CONFIG_TLS is not set
> CONFIG_XFRM=3Dy
> # CONFIG_XFRM_USER is not set
> # CONFIG_XFRM_INTERFACE is not set
> # CONFIG_XFRM_SUB_POLICY is not set
> # CONFIG_XFRM_MIGRATE is not set
> # CONFIG_XFRM_STATISTICS is not set
> # CONFIG_NET_KEY is not set
> # CONFIG_XDP_SOCKETS is not set
> CONFIG_INET=3Dy
> CONFIG_IP_MULTICAST=3Dy
> # CONFIG_IP_ADVANCED_ROUTER is not set
> # CONFIG_IP_PNP is not set
> # CONFIG_NET_IPIP is not set
> # CONFIG_NET_IPGRE_DEMUX is not set
> CONFIG_NET_IP_TUNNEL=3Dm
> # CONFIG_IP_MROUTE is not set
> CONFIG_SYN_COOKIES=3Dy
> # CONFIG_NET_IPVTI is not set
> # CONFIG_NET_FOU is not set
> # CONFIG_NET_FOU_IP_TUNNELS is not set
> # CONFIG_INET_AH is not set
> # CONFIG_INET_ESP is not set
> # CONFIG_INET_IPCOMP is not set
> CONFIG_INET_TUNNEL=3Dm
> CONFIG_INET_DIAG=3Dm
> CONFIG_INET_TCP_DIAG=3Dm
> CONFIG_INET_UDP_DIAG=3Dm
> CONFIG_INET_RAW_DIAG=3Dm
> # CONFIG_INET_DIAG_DESTROY is not set
> # CONFIG_TCP_CONG_ADVANCED is not set
> CONFIG_TCP_CONG_CUBIC=3Dy
> CONFIG_DEFAULT_TCP_CONG=3D"cubic"
> # CONFIG_TCP_MD5SIG is not set
> CONFIG_IPV6=3Dy
> CONFIG_IPV6_ROUTER_PREF=3Dy
> CONFIG_IPV6_ROUTE_INFO=3Dy
> CONFIG_IPV6_OPTIMISTIC_DAD=3Dy
> # CONFIG_INET6_AH is not set
> # CONFIG_INET6_ESP is not set
> # CONFIG_INET6_IPCOMP is not set
> CONFIG_IPV6_MIP6=3Dm
> CONFIG_INET6_TUNNEL=3Dm
> # CONFIG_IPV6_VTI is not set
> CONFIG_IPV6_SIT=3Dm
> CONFIG_IPV6_SIT_6RD=3Dy
> CONFIG_IPV6_NDISC_NODETYPE=3Dy
> CONFIG_IPV6_TUNNEL=3Dm
> # CONFIG_IPV6_MULTIPLE_TABLES is not set
> # CONFIG_IPV6_MROUTE is not set
> # CONFIG_IPV6_SEG6_LWTUNNEL is not set
> # CONFIG_IPV6_SEG6_HMAC is not set
> # CONFIG_IPV6_RPL_LWTUNNEL is not set
> # CONFIG_MPTCP is not set
> # CONFIG_NETWORK_SECMARK is not set
> # CONFIG_NETWORK_PHY_TIMESTAMPING is not set
> # CONFIG_NETFILTER is not set
> # CONFIG_BPFILTER is not set
> # CONFIG_IP_DCCP is not set
> # CONFIG_IP_SCTP is not set
> # CONFIG_RDS is not set
> # CONFIG_TIPC is not set
> # CONFIG_ATM is not set
> # CONFIG_L2TP is not set
> # CONFIG_BRIDGE is not set
> # CONFIG_NET_DSA is not set
> # CONFIG_VLAN_8021Q is not set
> # CONFIG_DECNET is not set
> # CONFIG_LLC2 is not set
> # CONFIG_ATALK is not set
> # CONFIG_X25 is not set
> # CONFIG_LAPB is not set
> # CONFIG_PHONET is not set
> # CONFIG_6LOWPAN is not set
> # CONFIG_IEEE802154 is not set
> # CONFIG_NET_SCHED is not set
> # CONFIG_DCB is not set
> # CONFIG_BATMAN_ADV is not set
> # CONFIG_OPENVSWITCH is not set
> # CONFIG_VSOCKETS is not set
> CONFIG_NETLINK_DIAG=3Dm
> # CONFIG_MPLS is not set
> # CONFIG_NET_NSH is not set
> # CONFIG_HSR is not set
> # CONFIG_NET_SWITCHDEV is not set
> # CONFIG_NET_L3_MASTER_DEV is not set
> # CONFIG_QRTR is not set
> # CONFIG_NET_NCSI is not set
> # CONFIG_CGROUP_NET_PRIO is not set
> # CONFIG_CGROUP_NET_CLASSID is not set
> CONFIG_NET_RX_BUSY_POLL=3Dy
> CONFIG_BQL=3Dy
> CONFIG_BPF_STREAM_PARSER=3Dy
>
> #
> # Network testing
> #
> # CONFIG_NET_PKTGEN is not set
> # end of Network testing
> # end of Networking options
>
> # CONFIG_HAMRADIO is not set
> # CONFIG_CAN is not set
> # CONFIG_BT is not set
> # CONFIG_AF_RXRPC is not set
> # CONFIG_AF_KCM is not set
> CONFIG_STREAM_PARSER=3Dy
> # CONFIG_WIRELESS is not set
> # CONFIG_RFKILL is not set
> # CONFIG_NET_9P is not set
> # CONFIG_CAIF is not set
> # CONFIG_CEPH_LIB is not set
> # CONFIG_NFC is not set
> # CONFIG_PSAMPLE is not set
> # CONFIG_NET_IFE is not set
> # CONFIG_LWTUNNEL is not set
> CONFIG_DST_CACHE=3Dy
> CONFIG_GRO_CELLS=3Dy
> CONFIG_NET_SOCK_MSG=3Dy
> # CONFIG_FAILOVER is not set
> CONFIG_ETHTOOL_NETLINK=3Dy
>
> #
> # Device Drivers
> #
> CONFIG_HAVE_PCI=3Dy
> CONFIG_PCI=3Dy
> # CONFIG_PCIEPORTBUS is not set
> CONFIG_PCIEASPM=3Dy
> CONFIG_PCIEASPM_DEFAULT=3Dy
> # CONFIG_PCIEASPM_POWERSAVE is not set
> # CONFIG_PCIEASPM_POWER_SUPERSAVE is not set
> # CONFIG_PCIEASPM_PERFORMANCE is not set
> # CONFIG_PCIE_PTM is not set
> # CONFIG_PCI_MSI is not set
> CONFIG_PCI_QUIRKS=3Dy
> # CONFIG_PCI_DEBUG is not set
> # CONFIG_PCI_STUB is not set
> # CONFIG_PCI_IOV is not set
> # CONFIG_PCI_PRI is not set
> # CONFIG_PCI_PASID is not set
> # CONFIG_HOTPLUG_PCI is not set
>
> #
> # PCI controller drivers
> #
>
> #
> # DesignWare PCI Core Support
> #
> # end of DesignWare PCI Core Support
>
> #
> # Mobiveil PCIe Core Support
> #
> # end of Mobiveil PCIe Core Support
>
> #
> # Cadence PCIe controllers support
> #
> # end of Cadence PCIe controllers support
> # end of PCI controller drivers
>
> #
> # PCI Endpoint
> #
> # CONFIG_PCI_ENDPOINT is not set
> # end of PCI Endpoint
>
> #
> # PCI switch controller drivers
> #
> # CONFIG_PCI_SW_SWITCHTEC is not set
> # end of PCI switch controller drivers
>
> # CONFIG_CXL_BUS is not set
> # CONFIG_PCCARD is not set
> # CONFIG_RAPIDIO is not set
>
> #
> # Generic Driver Options
> #
> # CONFIG_UEVENT_HELPER is not set
> CONFIG_DEVTMPFS=3Dy
> CONFIG_DEVTMPFS_MOUNT=3Dy
> CONFIG_STANDALONE=3Dy
> CONFIG_PREVENT_FIRMWARE_BUILD=3Dy
>
> #
> # Firmware loader
> #
> CONFIG_FW_LOADER=3Dy
> CONFIG_EXTRA_FIRMWARE=3D""
> # CONFIG_FW_LOADER_USER_HELPER is not set
> # CONFIG_FW_LOADER_COMPRESS is not set
> # end of Firmware loader
>
> CONFIG_ALLOW_DEV_COREDUMP=3Dy
> # CONFIG_DEBUG_DRIVER is not set
> # CONFIG_DEBUG_DEVRES is not set
> # CONFIG_DEBUG_TEST_DRIVER_REMOVE is not set
> # CONFIG_TEST_ASYNC_DRIVER_PROBE is not set
> CONFIG_GENERIC_CPU_DEVICES=3Dy
> # end of Generic Driver Options
>
> #
> # Bus devices
> #
> # CONFIG_MHI_BUS is not set
> # end of Bus devices
>
> # CONFIG_CONNECTOR is not set
> # CONFIG_GNSS is not set
> # CONFIG_MTD is not set
> # CONFIG_OF is not set
> CONFIG_ARCH_MIGHT_HAVE_PC_PARPORT=3Dy
> # CONFIG_PARPORT is not set
> CONFIG_BLK_DEV=3Dy
> # CONFIG_BLK_DEV_NULL_BLK is not set
> CONFIG_CDROM=3Dm
> # CONFIG_BLK_DEV_PCIESSD_MTIP32XX is not set
> CONFIG_BLK_DEV_LOOP=3Dm
> CONFIG_BLK_DEV_LOOP_MIN_COUNT=3D8
> # CONFIG_BLK_DEV_CRYPTOLOOP is not set
> # CONFIG_BLK_DEV_DRBD is not set
> # CONFIG_BLK_DEV_NBD is not set
> # CONFIG_BLK_DEV_SX8 is not set
> # CONFIG_BLK_DEV_RAM is not set
> # CONFIG_CDROM_PKTCDVD is not set
> # CONFIG_ATA_OVER_ETH is not set
> # CONFIG_BLK_DEV_RBD is not set
> # CONFIG_BLK_DEV_RSXX is not set
>
> #
> # NVME Support
> #
> # CONFIG_BLK_DEV_NVME is not set
> # CONFIG_NVME_FC is not set
> # CONFIG_NVME_TCP is not set
> # end of NVME Support
>
> #
> # Misc devices
> #
> # CONFIG_DUMMY_IRQ is not set
> # CONFIG_PHANTOM is not set
> # CONFIG_TIFM_CORE is not set
> # CONFIG_ENCLOSURE_SERVICES is not set
> # CONFIG_HP_ILO is not set
> # CONFIG_SRAM is not set
> # CONFIG_DW_XDATA_PCIE is not set
> # CONFIG_PCI_ENDPOINT_TEST is not set
> # CONFIG_XILINX_SDFEC is not set
> # CONFIG_C2PORT is not set
>
> #
> # EEPROM support
> #
> # CONFIG_EEPROM_93CX6 is not set
> # end of EEPROM support
>
> # CONFIG_CB710_CORE is not set
>
> #
> # Texas Instruments shared transport line discipline
> #
> # end of Texas Instruments shared transport line discipline
>
> #
> # Altera FPGA firmware download module (requires I2C)
> #
> # CONFIG_GENWQE is not set
> # CONFIG_ECHO is not set
> # CONFIG_MISC_ALCOR_PCI is not set
> # CONFIG_MISC_RTSX_PCI is not set
> # CONFIG_HABANA_AI is not set
> # CONFIG_PVPANIC is not set
> # end of Misc devices
>
> CONFIG_HAVE_IDE=3Dy
> # CONFIG_IDE is not set
>
> #
> # SCSI device support
> #
> CONFIG_SCSI_MOD=3Dy
> # CONFIG_RAID_ATTRS is not set
> CONFIG_SCSI=3Dy
> CONFIG_SCSI_DMA=3Dy
> # CONFIG_SCSI_PROC_FS is not set
>
> #
> # SCSI support type (disk, tape, CD-ROM)
> #
> CONFIG_BLK_DEV_SD=3Dy
> CONFIG_CHR_DEV_ST=3Dm
> CONFIG_BLK_DEV_SR=3Dm
> CONFIG_CHR_DEV_SG=3Dy
> CONFIG_CHR_DEV_SCH=3Dm
> # CONFIG_SCSI_CONSTANTS is not set
> # CONFIG_SCSI_LOGGING is not set
> CONFIG_SCSI_SCAN_ASYNC=3Dy
>
> #
> # SCSI Transports
> #
> CONFIG_SCSI_SPI_ATTRS=3Dy
> # CONFIG_SCSI_FC_ATTRS is not set
> # CONFIG_SCSI_ISCSI_ATTRS is not set
> # CONFIG_SCSI_SAS_ATTRS is not set
> # CONFIG_SCSI_SAS_LIBSAS is not set
> # CONFIG_SCSI_SRP_ATTRS is not set
> # end of SCSI Transports
>
> CONFIG_SCSI_LOWLEVEL=3Dy
> # CONFIG_ISCSI_TCP is not set
> # CONFIG_ISCSI_BOOT_SYSFS is not set
> # CONFIG_SCSI_CXGB3_ISCSI is not set
> # CONFIG_SCSI_CXGB4_ISCSI is not set
> # CONFIG_SCSI_BNX2_ISCSI is not set
> # CONFIG_BE2ISCSI is not set
> # CONFIG_BLK_DEV_3W_XXXX_RAID is not set
> # CONFIG_SCSI_HPSA is not set
> # CONFIG_SCSI_3W_9XXX is not set
> # CONFIG_SCSI_3W_SAS is not set
> # CONFIG_SCSI_ACARD is not set
> # CONFIG_SCSI_AACRAID is not set
> CONFIG_SCSI_AIC7XXX=3Dm
> CONFIG_AIC7XXX_CMDS_PER_DEVICE=3D32
> CONFIG_AIC7XXX_RESET_DELAY_MS=3D5000
> CONFIG_AIC7XXX_DEBUG_ENABLE=3Dy
> CONFIG_AIC7XXX_DEBUG_MASK=3D0
> CONFIG_AIC7XXX_REG_PRETTY_PRINT=3Dy
> # CONFIG_SCSI_AIC79XX is not set
> # CONFIG_SCSI_AIC94XX is not set
> # CONFIG_SCSI_MVSAS is not set
> # CONFIG_SCSI_MVUMI is not set
> # CONFIG_SCSI_DPT_I2O is not set
> # CONFIG_SCSI_ADVANSYS is not set
> # CONFIG_SCSI_ARCMSR is not set
> # CONFIG_SCSI_ESAS2R is not set
> # CONFIG_MEGARAID_NEWGEN is not set
> # CONFIG_MEGARAID_LEGACY is not set
> # CONFIG_MEGARAID_SAS is not set
> # CONFIG_SCSI_MPT3SAS is not set
> # CONFIG_SCSI_MPT2SAS is not set
> # CONFIG_SCSI_SMARTPQI is not set
> # CONFIG_SCSI_UFSHCD is not set
> # CONFIG_SCSI_HPTIOP is not set
> # CONFIG_SCSI_BUSLOGIC is not set
> # CONFIG_SCSI_MYRB is not set
> # CONFIG_SCSI_SNIC is not set
> # CONFIG_SCSI_DMX3191D is not set
> # CONFIG_SCSI_FDOMAIN_PCI is not set
> # CONFIG_SCSI_IPS is not set
> # CONFIG_SCSI_INITIO is not set
> # CONFIG_SCSI_INIA100 is not set
> # CONFIG_SCSI_STEX is not set
> CONFIG_SCSI_SYM53C8XX_2=3Dy
> CONFIG_SCSI_SYM53C8XX_DMA_ADDRESSING_MODE=3D1
> CONFIG_SCSI_SYM53C8XX_DEFAULT_TAGS=3D16
> CONFIG_SCSI_SYM53C8XX_MAX_TAGS=3D64
> CONFIG_SCSI_SYM53C8XX_MMIO=3Dy
> # CONFIG_SCSI_QLOGIC_1280 is not set
> # CONFIG_SCSI_QLA_ISCSI is not set
> # CONFIG_SCSI_DC395x is not set
> # CONFIG_SCSI_AM53C974 is not set
> # CONFIG_SCSI_WD719X is not set
> # CONFIG_SCSI_DEBUG is not set
> # CONFIG_SCSI_PMCRAID is not set
> # CONFIG_SCSI_PM8001 is not set
> # CONFIG_SCSI_DH is not set
> # end of SCSI device support
>
> # CONFIG_ATA is not set
> # CONFIG_MD is not set
> # CONFIG_TARGET_CORE is not set
> CONFIG_FUSION=3Dy
> CONFIG_FUSION_SPI=3Dm
> # CONFIG_FUSION_SAS is not set
> CONFIG_FUSION_MAX_SGE=3D128
> CONFIG_FUSION_CTL=3Dm
> # CONFIG_FUSION_LOGGING is not set
>
> #
> # IEEE 1394 (FireWire) support
> #
> # CONFIG_FIREWIRE is not set
> # CONFIG_FIREWIRE_NOSY is not set
> # end of IEEE 1394 (FireWire) support
>
> CONFIG_NETDEVICES=3Dy
> CONFIG_NET_CORE=3Dy
> # CONFIG_BONDING is not set
> # CONFIG_DUMMY is not set
> # CONFIG_WIREGUARD is not set
> # CONFIG_EQUALIZER is not set
> # CONFIG_NET_FC is not set
> # CONFIG_NET_TEAM is not set
> # CONFIG_MACVLAN is not set
> # CONFIG_IPVLAN is not set
> # CONFIG_VXLAN is not set
> # CONFIG_GENEVE is not set
> # CONFIG_BAREUDP is not set
> # CONFIG_GTP is not set
> # CONFIG_MACSEC is not set
> CONFIG_NETCONSOLE=3Dy
> CONFIG_NETPOLL=3Dy
> CONFIG_NET_POLL_CONTROLLER=3Dy
> CONFIG_TUN=3Dm
> # CONFIG_TUN_VNET_CROSS_LE is not set
> # CONFIG_VETH is not set
> # CONFIG_NLMON is not set
> # CONFIG_ARCNET is not set
> CONFIG_ETHERNET=3Dy
> # CONFIG_NET_VENDOR_3COM is not set
> # CONFIG_NET_VENDOR_ADAPTEC is not set
> # CONFIG_NET_VENDOR_AGERE is not set
> # CONFIG_NET_VENDOR_ALACRITECH is not set
> # CONFIG_NET_VENDOR_ALTEON is not set
> # CONFIG_ALTERA_TSE is not set
> # CONFIG_NET_VENDOR_AMAZON is not set
> # CONFIG_NET_VENDOR_AMD is not set
> # CONFIG_NET_VENDOR_AQUANTIA is not set
> # CONFIG_NET_VENDOR_ARC is not set
> # CONFIG_NET_VENDOR_ATHEROS is not set
> # CONFIG_NET_VENDOR_BROADCOM is not set
> # CONFIG_NET_VENDOR_BROCADE is not set
> # CONFIG_NET_VENDOR_CADENCE is not set
> # CONFIG_NET_VENDOR_CAVIUM is not set
> # CONFIG_NET_VENDOR_CHELSIO is not set
> # CONFIG_NET_VENDOR_CISCO is not set
> # CONFIG_NET_VENDOR_CORTINA is not set
> # CONFIG_DNET is not set
> CONFIG_NET_VENDOR_DEC=3Dy
> CONFIG_NET_TULIP=3Dy
> # CONFIG_DE2104X is not set
> CONFIG_TULIP=3Dy
> CONFIG_TULIP_MWI=3Dy
> CONFIG_TULIP_MMIO=3Dy
> CONFIG_TULIP_NAPI=3Dy
> CONFIG_TULIP_NAPI_HW_MITIGATION=3Dy
> # CONFIG_DE4X5 is not set
> # CONFIG_WINBOND_840 is not set
> # CONFIG_DM9102 is not set
> # CONFIG_ULI526X is not set
> # CONFIG_NET_VENDOR_DLINK is not set
> # CONFIG_NET_VENDOR_EMULEX is not set
> # CONFIG_NET_VENDOR_EZCHIP is not set
> # CONFIG_NET_VENDOR_GOOGLE is not set
> # CONFIG_NET_VENDOR_HUAWEI is not set
> # CONFIG_NET_VENDOR_INTEL is not set
> # CONFIG_NET_VENDOR_MICROSOFT is not set
> # CONFIG_JME is not set
> # CONFIG_NET_VENDOR_MARVELL is not set
> # CONFIG_NET_VENDOR_MELLANOX is not set
> # CONFIG_NET_VENDOR_MICREL is not set
> # CONFIG_NET_VENDOR_MICROCHIP is not set
> # CONFIG_NET_VENDOR_MICROSEMI is not set
> # CONFIG_NET_VENDOR_MYRI is not set
> # CONFIG_FEALNX is not set
> # CONFIG_NET_VENDOR_NATSEMI is not set
> # CONFIG_NET_VENDOR_NETERION is not set
> # CONFIG_NET_VENDOR_NETRONOME is not set
> # CONFIG_NET_VENDOR_NI is not set
> # CONFIG_NET_VENDOR_NVIDIA is not set
> # CONFIG_NET_VENDOR_OKI is not set
> # CONFIG_ETHOC is not set
> # CONFIG_NET_VENDOR_PACKET_ENGINES is not set
> # CONFIG_NET_VENDOR_PENSANDO is not set
> # CONFIG_NET_VENDOR_QLOGIC is not set
> # CONFIG_NET_VENDOR_QUALCOMM is not set
> # CONFIG_NET_VENDOR_RDC is not set
> # CONFIG_NET_VENDOR_REALTEK is not set
> # CONFIG_NET_VENDOR_RENESAS is not set
> # CONFIG_NET_VENDOR_ROCKER is not set
> # CONFIG_NET_VENDOR_SAMSUNG is not set
> # CONFIG_NET_VENDOR_SEEQ is not set
> # CONFIG_NET_VENDOR_SOLARFLARE is not set
> # CONFIG_NET_VENDOR_SILAN is not set
> # CONFIG_NET_VENDOR_SIS is not set
> # CONFIG_NET_VENDOR_SMSC is not set
> # CONFIG_NET_VENDOR_SOCIONEXT is not set
> # CONFIG_NET_VENDOR_STMICRO is not set
> # CONFIG_NET_VENDOR_SUN is not set
> # CONFIG_NET_VENDOR_SYNOPSYS is not set
> # CONFIG_NET_VENDOR_TEHUTI is not set
> # CONFIG_NET_VENDOR_TI is not set
> # CONFIG_NET_VENDOR_VIA is not set
> # CONFIG_NET_VENDOR_WIZNET is not set
> # CONFIG_NET_VENDOR_XILINX is not set
> # CONFIG_FDDI is not set
> # CONFIG_HIPPI is not set
> # CONFIG_PHYLIB is not set
> # CONFIG_MDIO_DEVICE is not set
>
> #
> # PCS device drivers
> #
> # end of PCS device drivers
>
> # CONFIG_PPP is not set
> # CONFIG_SLIP is not set
>
> #
> # Host-side USB support is needed for USB Network Adapter support
> #
> # CONFIG_WLAN is not set
> # CONFIG_WAN is not set
> # CONFIG_WWAN is not set
> # CONFIG_VMXNET3 is not set
> # CONFIG_NET_FAILOVER is not set
> # CONFIG_ISDN is not set
> # CONFIG_NVM is not set
>
> #
> # Input device support
> #
> CONFIG_INPUT=3Dy
> # CONFIG_INPUT_FF_MEMLESS is not set
> # CONFIG_INPUT_SPARSEKMAP is not set
> # CONFIG_INPUT_MATRIXKMAP is not set
>
> #
> # Userland interfaces
> #
> # CONFIG_INPUT_MOUSEDEV is not set
> # CONFIG_INPUT_JOYDEV is not set
> # CONFIG_INPUT_EVDEV is not set
> # CONFIG_INPUT_EVBUG is not set
>
> #
> # Input Device Drivers
> #
> # CONFIG_INPUT_KEYBOARD is not set
> # CONFIG_INPUT_MOUSE is not set
> # CONFIG_INPUT_JOYSTICK is not set
> # CONFIG_INPUT_TABLET is not set
> # CONFIG_INPUT_TOUCHSCREEN is not set
> # CONFIG_INPUT_MISC is not set
> # CONFIG_RMI4_CORE is not set
>
> #
> # Hardware I/O ports
> #
> # CONFIG_SERIO is not set
> # CONFIG_GAMEPORT is not set
> # end of Hardware I/O ports
> # end of Input device support
>
> #
> # Character devices
> #
> CONFIG_TTY=3Dy
> CONFIG_VT=3Dy
> CONFIG_CONSOLE_TRANSLATIONS=3Dy
> CONFIG_VT_CONSOLE=3Dy
> CONFIG_HW_CONSOLE=3Dy
> # CONFIG_VT_HW_CONSOLE_BINDING is not set
> CONFIG_UNIX98_PTYS=3Dy
> # CONFIG_LEGACY_PTYS is not set
> # CONFIG_LDISC_AUTOLOAD is not set
>
> #
> # Serial drivers
> #
> CONFIG_SERIAL_EARLYCON=3Dy
> CONFIG_SERIAL_8250=3Dy
> # CONFIG_SERIAL_8250_DEPRECATED_OPTIONS is not set
> # CONFIG_SERIAL_8250_16550A_VARIANTS is not set
> # CONFIG_SERIAL_8250_FINTEK is not set
> CONFIG_SERIAL_8250_CONSOLE=3Dy
> CONFIG_SERIAL_8250_PCI=3Dy
> # CONFIG_SERIAL_8250_EXAR is not set
> CONFIG_SERIAL_8250_NR_UARTS=3D4
> CONFIG_SERIAL_8250_RUNTIME_UARTS=3D4
> # CONFIG_SERIAL_8250_EXTENDED is not set
> # CONFIG_SERIAL_8250_DW is not set
> # CONFIG_SERIAL_8250_RT288X is not set
>
> #
> # Non-8250 serial port support
> #
> # CONFIG_SERIAL_UARTLITE is not set
> # CONFIG_PDC_CONSOLE is not set
> CONFIG_SERIAL_CORE=3Dy
> CONFIG_SERIAL_CORE_CONSOLE=3Dy
> # CONFIG_SERIAL_JSM is not set
> # CONFIG_SERIAL_SCCNXP is not set
> # CONFIG_SERIAL_ALTERA_JTAGUART is not set
> # CONFIG_SERIAL_ALTERA_UART is not set
> # CONFIG_SERIAL_ARC is not set
> # CONFIG_SERIAL_RP2 is not set
> # CONFIG_SERIAL_FSL_LPUART is not set
> # CONFIG_SERIAL_FSL_LINFLEXUART is not set
> # end of Serial drivers
>
> # CONFIG_SERIAL_NONSTANDARD is not set
> # CONFIG_N_GSM is not set
> # CONFIG_NOZOMI is not set
> # CONFIG_NULL_TTY is not set
> # CONFIG_SERIAL_DEV_BUS is not set
> # CONFIG_VIRTIO_CONSOLE is not set
> # CONFIG_IPMI_HANDLER is not set
> # CONFIG_HW_RANDOM is not set
> # CONFIG_APPLICOM is not set
> CONFIG_DEVMEM=3Dy
> # CONFIG_RAW_DRIVER is not set
> CONFIG_DEVPORT=3Dy
> # CONFIG_TCG_TPM is not set
> # CONFIG_XILLYBUS is not set
> # end of Character devices
>
> CONFIG_RANDOM_TRUST_BOOTLOADER=3Dy
>
> #
> # I2C support
> #
> # CONFIG_I2C is not set
> # end of I2C support
>
> # CONFIG_I3C is not set
> # CONFIG_SPI is not set
> # CONFIG_SPMI is not set
> # CONFIG_HSI is not set
> # CONFIG_PPS is not set
>
> #
> # PTP clock support
> #
> # CONFIG_PTP_1588_CLOCK is not set
>
> #
> # Enable PHYLIB and NETWORK_PHY_TIMESTAMPING to see the additional clock=
s.
> #
> # end of PTP clock support
>
> # CONFIG_PINCTRL is not set
> # CONFIG_GPIOLIB is not set
> # CONFIG_W1 is not set
> # CONFIG_POWER_RESET is not set
> # CONFIG_POWER_SUPPLY is not set
> # CONFIG_HWMON is not set
> # CONFIG_THERMAL is not set
> # CONFIG_WATCHDOG is not set
> CONFIG_SSB_POSSIBLE=3Dy
> # CONFIG_SSB is not set
> CONFIG_BCMA_POSSIBLE=3Dy
> # CONFIG_BCMA is not set
>
> #
> # Multifunction device drivers
> #
> # CONFIG_MFD_MADERA is not set
> # CONFIG_HTC_PASIC3 is not set
> # CONFIG_LPC_ICH is not set
> # CONFIG_LPC_SCH is not set
> # CONFIG_MFD_INTEL_PMT is not set
> # CONFIG_MFD_JANZ_CMODIO is not set
> # CONFIG_MFD_KEMPLD is not set
> # CONFIG_MFD_MT6397 is not set
> # CONFIG_MFD_RDC321X is not set
> # CONFIG_MFD_SM501 is not set
> # CONFIG_MFD_SYSCON is not set
> # CONFIG_MFD_TI_AM335X_TSCADC is not set
> # CONFIG_MFD_TQMX86 is not set
> # CONFIG_MFD_VX855 is not set
> # end of Multifunction device drivers
>
> # CONFIG_REGULATOR is not set
> # CONFIG_RC_CORE is not set
> # CONFIG_MEDIA_CEC_SUPPORT is not set
> # CONFIG_MEDIA_SUPPORT is not set
>
> #
> # Graphics support
> #
> # CONFIG_AGP is not set
> CONFIG_VGA_ARB=3Dy
> CONFIG_VGA_ARB_MAX_GPUS=3D16
> # CONFIG_DRM is not set
>
> #
> # ARM devices
> #
> # end of ARM devices
>
> #
> # Frame buffer Devices
> #
> # CONFIG_FB is not set
> # end of Frame buffer Devices
>
> #
> # Backlight & LCD device support
> #
> # CONFIG_LCD_CLASS_DEVICE is not set
> # CONFIG_BACKLIGHT_CLASS_DEVICE is not set
> # end of Backlight & LCD device support
>
> #
> # Console display driver support
> #
> CONFIG_DUMMY_CONSOLE=3Dy
> CONFIG_DUMMY_CONSOLE_COLUMNS=3D160
> CONFIG_DUMMY_CONSOLE_ROWS=3D64
> CONFIG_STI_CONSOLE=3Dy
> # end of Console display driver support
> # end of Graphics support
>
> # CONFIG_SOUND is not set
>
> #
> # HID support
> #
> # CONFIG_HID is not set
> # end of HID support
>
> CONFIG_USB_OHCI_LITTLE_ENDIAN=3Dy
> # CONFIG_USB_SUPPORT is not set
> # CONFIG_MMC is not set
> # CONFIG_MEMSTICK is not set
> # CONFIG_NEW_LEDS is not set
> # CONFIG_ACCESSIBILITY is not set
> # CONFIG_INFINIBAND is not set
> CONFIG_RTC_LIB=3Dy
> CONFIG_RTC_CLASS=3Dy
> CONFIG_RTC_HCTOSYS=3Dy
> CONFIG_RTC_HCTOSYS_DEVICE=3D"rtc0"
> CONFIG_RTC_SYSTOHC=3Dy
> CONFIG_RTC_SYSTOHC_DEVICE=3D"rtc0"
> # CONFIG_RTC_DEBUG is not set
> CONFIG_RTC_NVMEM=3Dy
>
> #
> # RTC interfaces
> #
> CONFIG_RTC_INTF_SYSFS=3Dy
> CONFIG_RTC_INTF_PROC=3Dy
> CONFIG_RTC_INTF_DEV=3Dy
> CONFIG_RTC_INTF_DEV_UIE_EMUL=3Dy
> # CONFIG_RTC_DRV_TEST is not set
>
> #
> # I2C RTC drivers
> #
>
> #
> # SPI RTC drivers
> #
>
> #
> # SPI and I2C RTC drivers
> #
>
> #
> # Platform RTC drivers
> #
> # CONFIG_RTC_DRV_DS1286 is not set
> # CONFIG_RTC_DRV_DS1511 is not set
> # CONFIG_RTC_DRV_DS1553 is not set
> # CONFIG_RTC_DRV_DS1685_FAMILY is not set
> # CONFIG_RTC_DRV_DS1742 is not set
> # CONFIG_RTC_DRV_DS2404 is not set
> # CONFIG_RTC_DRV_STK17TA8 is not set
> # CONFIG_RTC_DRV_M48T86 is not set
> # CONFIG_RTC_DRV_M48T35 is not set
> # CONFIG_RTC_DRV_M48T59 is not set
> # CONFIG_RTC_DRV_MSM6242 is not set
> # CONFIG_RTC_DRV_BQ4802 is not set
> # CONFIG_RTC_DRV_RP5C01 is not set
> # CONFIG_RTC_DRV_V3020 is not set
>
> #
> # on-CPU RTC drivers
> #
> CONFIG_RTC_DRV_GENERIC=3Dy
> # CONFIG_RTC_DRV_FTRTC010 is not set
>
> #
> # HID Sensor RTC drivers
> #
> # CONFIG_RTC_DRV_GOLDFISH is not set
> # CONFIG_DMADEVICES is not set
>
> #
> # DMABUF options
> #
> # CONFIG_SYNC_FILE is not set
> # CONFIG_DMABUF_MOVE_NOTIFY is not set
> # CONFIG_DMABUF_DEBUG is not set
> # CONFIG_DMABUF_HEAPS is not set
> # end of DMABUF options
>
> # CONFIG_AUXDISPLAY is not set
> # CONFIG_UIO is not set
> # CONFIG_VFIO is not set
> # CONFIG_VIRT_DRIVERS is not set
> # CONFIG_VIRTIO_MENU is not set
> # CONFIG_VDPA is not set
> # CONFIG_VHOST_MENU is not set
>
> #
> # Microsoft Hyper-V guest support
> #
> # end of Microsoft Hyper-V guest support
>
> # CONFIG_GREYBUS is not set
> # CONFIG_COMEDI is not set
> # CONFIG_STAGING is not set
> # CONFIG_GOLDFISH is not set
> # CONFIG_COMMON_CLK is not set
> # CONFIG_HWSPINLOCK is not set
> # CONFIG_MAILBOX is not set
> # CONFIG_IOMMU_SUPPORT is not set
>
> #
> # Remoteproc drivers
> #
> # CONFIG_REMOTEPROC is not set
> # end of Remoteproc drivers
>
> #
> # Rpmsg drivers
> #
> # CONFIG_RPMSG_VIRTIO is not set
> # end of Rpmsg drivers
>
> #
> # SOC (System On Chip) specific Drivers
> #
>
> #
> # Amlogic SoC drivers
> #
> # end of Amlogic SoC drivers
>
> #
> # Broadcom SoC drivers
> #
> # end of Broadcom SoC drivers
>
> #
> # NXP/Freescale QorIQ SoC drivers
> #
> # end of NXP/Freescale QorIQ SoC drivers
>
> #
> # i.MX SoC drivers
> #
> # end of i.MX SoC drivers
>
> #
> # Enable LiteX SoC Builder specific drivers
> #
> # end of Enable LiteX SoC Builder specific drivers
>
> #
> # Qualcomm SoC drivers
> #
> # end of Qualcomm SoC drivers
>
> # CONFIG_SOC_TI is not set
>
> #
> # Xilinx SoC drivers
> #
> # end of Xilinx SoC drivers
> # end of SOC (System On Chip) specific Drivers
>
> # CONFIG_PM_DEVFREQ is not set
> # CONFIG_EXTCON is not set
> # CONFIG_MEMORY is not set
> # CONFIG_IIO is not set
> # CONFIG_NTB is not set
> # CONFIG_VME_BUS is not set
> # CONFIG_PWM is not set
>
> #
> # IRQ chip support
> #
> # end of IRQ chip support
>
> # CONFIG_IPACK_BUS is not set
> # CONFIG_RESET_CONTROLLER is not set
>
> #
> # PHY Subsystem
> #
> # CONFIG_GENERIC_PHY is not set
> # CONFIG_BCM_KONA_USB2_PHY is not set
> # CONFIG_PHY_PXA_28NM_HSIC is not set
> # CONFIG_PHY_PXA_28NM_USB2 is not set
> # end of PHY Subsystem
>
> # CONFIG_POWERCAP is not set
> # CONFIG_MCB is not set
> # CONFIG_RAS is not set
> # CONFIG_USB4 is not set
>
> #
> # Android
> #
> # CONFIG_ANDROID is not set
> # end of Android
>
> # CONFIG_LIBNVDIMM is not set
> # CONFIG_DAX is not set
> CONFIG_NVMEM=3Dy
> CONFIG_NVMEM_SYSFS=3Dy
> # CONFIG_NVMEM_RMEM is not set
>
> #
> # HW tracing support
> #
> # CONFIG_STM is not set
> # CONFIG_INTEL_TH is not set
> # end of HW tracing support
>
> # CONFIG_FPGA is not set
> # CONFIG_SIOX is not set
> # CONFIG_SLIMBUS is not set
> # CONFIG_INTERCONNECT is not set
> # CONFIG_COUNTER is not set
> # end of Device Drivers
>
> #
> # File systems
> #
> # CONFIG_VALIDATE_FS_PARSER is not set
> CONFIG_FS_IOMAP=3Dy
> # CONFIG_EXT2_FS is not set
> # CONFIG_EXT3_FS is not set
> CONFIG_EXT4_FS=3Dy
> CONFIG_EXT4_USE_FOR_EXT2=3Dy
> CONFIG_EXT4_FS_POSIX_ACL=3Dy
> CONFIG_EXT4_FS_SECURITY=3Dy
> # CONFIG_EXT4_DEBUG is not set
> CONFIG_JBD2=3Dy
> # CONFIG_JBD2_DEBUG is not set
> CONFIG_FS_MBCACHE=3Dy
> # CONFIG_REISERFS_FS is not set
> # CONFIG_JFS_FS is not set
> # CONFIG_XFS_FS is not set
> # CONFIG_GFS2_FS is not set
> # CONFIG_BTRFS_FS is not set
> # CONFIG_NILFS2_FS is not set
> # CONFIG_F2FS_FS is not set
> # CONFIG_FS_DAX is not set
> CONFIG_FS_POSIX_ACL=3Dy
> CONFIG_EXPORTFS=3Dy
> # CONFIG_EXPORTFS_BLOCK_OPS is not set
> CONFIG_FILE_LOCKING=3Dy
> CONFIG_MANDATORY_FILE_LOCKING=3Dy
> # CONFIG_FS_ENCRYPTION is not set
> # CONFIG_FS_VERITY is not set
> CONFIG_FSNOTIFY=3Dy
> CONFIG_DNOTIFY=3Dy
> CONFIG_INOTIFY_USER=3Dy
> CONFIG_FANOTIFY=3Dy
> # CONFIG_QUOTA is not set
> # CONFIG_AUTOFS4_FS is not set
> CONFIG_AUTOFS_FS=3Dm
> CONFIG_FUSE_FS=3Dm
> CONFIG_CUSE=3Dm
> # CONFIG_VIRTIO_FS is not set
> # CONFIG_OVERLAY_FS is not set
>
> #
> # Caches
> #
> # CONFIG_FSCACHE is not set
> # end of Caches
>
> #
> # CD-ROM/DVD Filesystems
> #
> # CONFIG_ISO9660_FS is not set
> # CONFIG_UDF_FS is not set
> # end of CD-ROM/DVD Filesystems
>
> #
> # DOS/FAT/EXFAT/NT Filesystems
> #
> # CONFIG_MSDOS_FS is not set
> # CONFIG_VFAT_FS is not set
> # CONFIG_EXFAT_FS is not set
> # CONFIG_NTFS_FS is not set
> # end of DOS/FAT/EXFAT/NT Filesystems
>
> #
> # Pseudo filesystems
> #
> CONFIG_PROC_FS=3Dy
> # CONFIG_PROC_KCORE is not set
> CONFIG_PROC_SYSCTL=3Dy
> CONFIG_PROC_PAGE_MONITOR=3Dy
> # CONFIG_PROC_CHILDREN is not set
> CONFIG_KERNFS=3Dy
> CONFIG_SYSFS=3Dy
> CONFIG_TMPFS=3Dy
> CONFIG_TMPFS_POSIX_ACL=3Dy
> CONFIG_TMPFS_XATTR=3Dy
> # CONFIG_TMPFS_INODE64 is not set
> CONFIG_ARCH_SUPPORTS_HUGETLBFS=3Dy
> CONFIG_HUGETLBFS=3Dy
> CONFIG_HUGETLB_PAGE=3Dy
> CONFIG_MEMFD_CREATE=3Dy
> # CONFIG_CONFIGFS_FS is not set
> # end of Pseudo filesystems
>
> # CONFIG_MISC_FILESYSTEMS is not set
> # CONFIG_NETWORK_FILESYSTEMS is not set
> # CONFIG_NLS is not set
> # CONFIG_UNICODE is not set
> CONFIG_IO_WQ=3Dy
> # end of File systems
>
> #
> # Security options
> #
> # CONFIG_KEYS is not set
> # CONFIG_SECURITY_DMESG_RESTRICT is not set
> # CONFIG_SECURITY is not set
> # CONFIG_SECURITYFS is not set
> CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR=3Dy
> CONFIG_HARDENED_USERCOPY=3Dy
> CONFIG_HARDENED_USERCOPY_FALLBACK=3Dy
> # CONFIG_STATIC_USERMODEHELPER is not set
> CONFIG_DEFAULT_SECURITY_DAC=3Dy
> CONFIG_LSM=3D"yama,loadpin,safesetid,integrity,selinux,smack,tomoyo,appa=
rmor"
>
> #
> # Kernel hardening options
> #
>
> #
> # Memory initialization
> #
> CONFIG_INIT_STACK_NONE=3Dy
> # CONFIG_INIT_ON_ALLOC_DEFAULT_ON is not set
> # CONFIG_INIT_ON_FREE_DEFAULT_ON is not set
> # end of Memory initialization
> # end of Kernel hardening options
> # end of Security options
>
> CONFIG_CRYPTO=3Dy
>
> #
> # Crypto core or helper
> #
> CONFIG_CRYPTO_ALGAPI=3Dy
> CONFIG_CRYPTO_ALGAPI2=3Dy
> CONFIG_CRYPTO_HASH=3Dy
> CONFIG_CRYPTO_HASH2=3Dy
> # CONFIG_CRYPTO_MANAGER is not set
> # CONFIG_CRYPTO_USER is not set
> CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=3Dy
> # CONFIG_CRYPTO_NULL is not set
> # CONFIG_CRYPTO_CRYPTD is not set
> # CONFIG_CRYPTO_AUTHENC is not set
> # CONFIG_CRYPTO_TEST is not set
>
> #
> # Public-key cryptography
> #
> # CONFIG_CRYPTO_RSA is not set
> # CONFIG_CRYPTO_DH is not set
> # CONFIG_CRYPTO_ECDH is not set
> # CONFIG_CRYPTO_ECDSA is not set
> # CONFIG_CRYPTO_ECRDSA is not set
> # CONFIG_CRYPTO_SM2 is not set
> # CONFIG_CRYPTO_CURVE25519 is not set
>
> #
> # Authenticated Encryption with Associated Data
> #
> # CONFIG_CRYPTO_CCM is not set
> # CONFIG_CRYPTO_GCM is not set
> # CONFIG_CRYPTO_CHACHA20POLY1305 is not set
> # CONFIG_CRYPTO_AEGIS128 is not set
> # CONFIG_CRYPTO_SEQIV is not set
> # CONFIG_CRYPTO_ECHAINIV is not set
>
> #
> # Block modes
> #
> # CONFIG_CRYPTO_CBC is not set
> # CONFIG_CRYPTO_CFB is not set
> # CONFIG_CRYPTO_CTR is not set
> # CONFIG_CRYPTO_CTS is not set
> # CONFIG_CRYPTO_ECB is not set
> # CONFIG_CRYPTO_LRW is not set
> # CONFIG_CRYPTO_OFB is not set
> # CONFIG_CRYPTO_PCBC is not set
> # CONFIG_CRYPTO_XTS is not set
> # CONFIG_CRYPTO_KEYWRAP is not set
> # CONFIG_CRYPTO_ADIANTUM is not set
> # CONFIG_CRYPTO_ESSIV is not set
>
> #
> # Hash modes
> #
> # CONFIG_CRYPTO_CMAC is not set
> # CONFIG_CRYPTO_HMAC is not set
> # CONFIG_CRYPTO_XCBC is not set
> # CONFIG_CRYPTO_VMAC is not set
>
> #
> # Digest
> #
> CONFIG_CRYPTO_CRC32C=3Dy
> # CONFIG_CRYPTO_CRC32 is not set
> # CONFIG_CRYPTO_XXHASH is not set
> # CONFIG_CRYPTO_BLAKE2B is not set
> # CONFIG_CRYPTO_BLAKE2S is not set
> # CONFIG_CRYPTO_CRCT10DIF is not set
> # CONFIG_CRYPTO_GHASH is not set
> # CONFIG_CRYPTO_POLY1305 is not set
> # CONFIG_CRYPTO_MD4 is not set
> # CONFIG_CRYPTO_MD5 is not set
> # CONFIG_CRYPTO_MICHAEL_MIC is not set
> # CONFIG_CRYPTO_RMD160 is not set
> # CONFIG_CRYPTO_SHA1 is not set
> # CONFIG_CRYPTO_SHA256 is not set
> # CONFIG_CRYPTO_SHA512 is not set
> # CONFIG_CRYPTO_SHA3 is not set
> # CONFIG_CRYPTO_SM3 is not set
> # CONFIG_CRYPTO_STREEBOG is not set
> # CONFIG_CRYPTO_WP512 is not set
>
> #
> # Ciphers
> #
> # CONFIG_CRYPTO_AES is not set
> # CONFIG_CRYPTO_AES_TI is not set
> # CONFIG_CRYPTO_BLOWFISH is not set
> # CONFIG_CRYPTO_CAMELLIA is not set
> # CONFIG_CRYPTO_CAST5 is not set
> # CONFIG_CRYPTO_CAST6 is not set
> # CONFIG_CRYPTO_DES is not set
> # CONFIG_CRYPTO_FCRYPT is not set
> # CONFIG_CRYPTO_CHACHA20 is not set
> # CONFIG_CRYPTO_SERPENT is not set
> # CONFIG_CRYPTO_SM4 is not set
> # CONFIG_CRYPTO_TWOFISH is not set
>
> #
> # Compression
> #
> # CONFIG_CRYPTO_DEFLATE is not set
> # CONFIG_CRYPTO_LZO is not set
> # CONFIG_CRYPTO_842 is not set
> # CONFIG_CRYPTO_LZ4 is not set
> # CONFIG_CRYPTO_LZ4HC is not set
> # CONFIG_CRYPTO_ZSTD is not set
>
> #
> # Random Number Generation
> #
> # CONFIG_CRYPTO_ANSI_CPRNG is not set
> # CONFIG_CRYPTO_DRBG_MENU is not set
> # CONFIG_CRYPTO_JITTERENTROPY is not set
> # CONFIG_CRYPTO_USER_API_HASH is not set
> # CONFIG_CRYPTO_USER_API_SKCIPHER is not set
> # CONFIG_CRYPTO_USER_API_RNG is not set
> # CONFIG_CRYPTO_USER_API_AEAD is not set
>
> #
> # Crypto library routines
> #
> # CONFIG_CRYPTO_LIB_BLAKE2S is not set
> # CONFIG_CRYPTO_LIB_CHACHA is not set
> # CONFIG_CRYPTO_LIB_CURVE25519 is not set
> CONFIG_CRYPTO_LIB_POLY1305_RSIZE=3D1
> # CONFIG_CRYPTO_LIB_POLY1305 is not set
> # CONFIG_CRYPTO_LIB_CHACHA20POLY1305 is not set
> # CONFIG_CRYPTO_HW is not set
>
> #
> # Certificates for signature checking
> #
> # end of Certificates for signature checking
>
> CONFIG_BINARY_PRINTF=3Dy
>
> #
> # Library routines
> #
> # CONFIG_PACKING is not set
> CONFIG_BITREVERSE=3Dy
> CONFIG_GENERIC_STRNCPY_FROM_USER=3Dy
> CONFIG_GENERIC_NET_UTILS=3Dy
> # CONFIG_CORDIC is not set
> # CONFIG_PRIME_NUMBERS is not set
> CONFIG_GENERIC_PCI_IOMAP=3Dy
> # CONFIG_CRC_CCITT is not set
> CONFIG_CRC16=3Dy
> # CONFIG_CRC_T10DIF is not set
> # CONFIG_CRC_ITU_T is not set
> CONFIG_CRC32=3Dy
> # CONFIG_CRC32_SELFTEST is not set
> CONFIG_CRC32_SLICEBY8=3Dy
> # CONFIG_CRC32_SLICEBY4 is not set
> # CONFIG_CRC32_SARWATE is not set
> # CONFIG_CRC32_BIT is not set
> # CONFIG_CRC64 is not set
> # CONFIG_CRC4 is not set
> # CONFIG_CRC7 is not set
> # CONFIG_LIBCRC32C is not set
> # CONFIG_CRC8 is not set
> # CONFIG_RANDOM32_SELFTEST is not set
> # CONFIG_XZ_DEC is not set
> CONFIG_HAS_IOMEM=3Dy
> CONFIG_HAS_IOPORT_MAP=3Dy
> CONFIG_HAS_DMA=3Dy
> CONFIG_DMA_OPS=3Dy
> CONFIG_NEED_SG_DMA_LENGTH=3Dy
> CONFIG_NEED_DMA_MAP_STATE=3Dy
> CONFIG_ARCH_DMA_ADDR_T_64BIT=3Dy
> # CONFIG_DMA_API_DEBUG is not set
> CONFIG_DQL=3Dy
> CONFIG_NLATTR=3Dy
> # CONFIG_IRQ_POLL is not set
> CONFIG_FONT_SUPPORT=3Dy
> # CONFIG_FONTS is not set
> CONFIG_FONT_8x8=3Dy
> CONFIG_FONT_8x16=3Dy
> CONFIG_SG_POOL=3Dy
> CONFIG_ARCH_NO_SG_CHAIN=3Dy
> CONFIG_SBITMAP=3Dy
> # CONFIG_STRING_SELFTEST is not set
> # end of Library routines
>
> CONFIG_GENERIC_LIB_DEVMEM_IS_ALLOWED=3Dy
>
> #
> # Kernel hacking
> #
>
> #
> # printk and dmesg options
> #
> CONFIG_PRINTK_TIME=3Dy
> # CONFIG_PRINTK_CALLER is not set
> CONFIG_CONSOLE_LOGLEVEL_DEFAULT=3D7
> CONFIG_CONSOLE_LOGLEVEL_QUIET=3D4
> CONFIG_MESSAGE_LOGLEVEL_DEFAULT=3D4
> # CONFIG_BOOT_PRINTK_DELAY is not set
> # CONFIG_DYNAMIC_DEBUG is not set
> # CONFIG_DYNAMIC_DEBUG_CORE is not set
> CONFIG_SYMBOLIC_ERRNAME=3Dy
> CONFIG_DEBUG_BUGVERBOSE=3Dy
> # end of printk and dmesg options
>
> #
> # Compile-time checks and compiler options
> #
> # CONFIG_DEBUG_INFO is not set
> CONFIG_FRAME_WARN=3D1024
> # CONFIG_STRIP_ASM_SYMS is not set
> # CONFIG_READABLE_ASM is not set
> # CONFIG_HEADERS_INSTALL is not set
> # CONFIG_DEBUG_SECTION_MISMATCH is not set
> CONFIG_SECTION_MISMATCH_WARN_ONLY=3Dy
> CONFIG_ARCH_WANT_FRAME_POINTERS=3Dy
> # CONFIG_FRAME_POINTER is not set
> # CONFIG_DEBUG_FORCE_WEAK_PER_CPU is not set
> # end of Compile-time checks and compiler options
>
> #
> # Generic Kernel Debugging Instruments
> #
> CONFIG_MAGIC_SYSRQ=3Dy
> CONFIG_MAGIC_SYSRQ_DEFAULT_ENABLE=3D0xffff
> CONFIG_MAGIC_SYSRQ_SERIAL=3Dy
> CONFIG_MAGIC_SYSRQ_SERIAL_SEQUENCE=3D"s"
> # CONFIG_DEBUG_FS is not set
> CONFIG_HAVE_ARCH_KGDB=3Dy
> # CONFIG_KGDB is not set
> CONFIG_ARCH_HAS_UBSAN_SANITIZE_ALL=3Dy
> # CONFIG_UBSAN is not set
> # end of Generic Kernel Debugging Instruments
>
> CONFIG_DEBUG_KERNEL=3Dy
> CONFIG_DEBUG_MISC=3Dy
>
> #
> # Memory Debugging
> #
> # CONFIG_PAGE_EXTENSION is not set
> # CONFIG_DEBUG_PAGEALLOC is not set
> # CONFIG_PAGE_OWNER is not set
> # CONFIG_PAGE_POISONING is not set
> # CONFIG_DEBUG_RODATA_TEST is not set
> # CONFIG_DEBUG_OBJECTS is not set
> # CONFIG_SLUB_DEBUG_ON is not set
> # CONFIG_SLUB_STATS is not set
> # CONFIG_DEBUG_STACK_USAGE is not set
> # CONFIG_SCHED_STACK_END_CHECK is not set
> # CONFIG_DEBUG_VM is not set
> CONFIG_DEBUG_MEMORY_INIT=3Dy
> CONFIG_HAVE_DEBUG_STACKOVERFLOW=3Dy
> # CONFIG_DEBUG_STACKOVERFLOW is not set
> CONFIG_CC_HAS_WORKING_NOSANITIZE_ADDRESS=3Dy
> # end of Memory Debugging
>
> # CONFIG_DEBUG_SHIRQ is not set
>
> #
> # Debug Oops, Lockups and Hangs
> #
> # CONFIG_PANIC_ON_OOPS is not set
> CONFIG_PANIC_ON_OOPS_VALUE=3D0
> CONFIG_PANIC_TIMEOUT=3D0
> CONFIG_LOCKUP_DETECTOR=3Dy
> CONFIG_SOFTLOCKUP_DETECTOR=3Dy
> # CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC is not set
> CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC_VALUE=3D0
> CONFIG_DETECT_HUNG_TASK=3Dy
> CONFIG_DEFAULT_HUNG_TASK_TIMEOUT=3D120
> # CONFIG_BOOTPARAM_HUNG_TASK_PANIC is not set
> CONFIG_BOOTPARAM_HUNG_TASK_PANIC_VALUE=3D0
> CONFIG_WQ_WATCHDOG=3Dy
> # CONFIG_TEST_LOCKUP is not set
> # end of Debug Oops, Lockups and Hangs
>
> #
> # Scheduler Debugging
> #
> # CONFIG_SCHED_DEBUG is not set
> # CONFIG_SCHEDSTATS is not set
> # end of Scheduler Debugging
>
> # CONFIG_DEBUG_TIMEKEEPING is not set
>
> #
> # Lock Debugging (spinlocks, mutexes, etc...)
> #
> # CONFIG_DEBUG_RT_MUTEXES is not set
> # CONFIG_DEBUG_SPINLOCK is not set
> # CONFIG_DEBUG_MUTEXES is not set
> # CONFIG_DEBUG_RWSEMS is not set
> # CONFIG_DEBUG_ATOMIC_SLEEP is not set
> # CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
> # CONFIG_LOCK_TORTURE_TEST is not set
> # CONFIG_WW_MUTEX_SELFTEST is not set
> # CONFIG_SCF_TORTURE_TEST is not set
> # CONFIG_CSD_LOCK_WAIT_DEBUG is not set
> # end of Lock Debugging (spinlocks, mutexes, etc...)
>
> # CONFIG_DEBUG_IRQFLAGS is not set
> # CONFIG_STACKTRACE is not set
> # CONFIG_WARN_ALL_UNSEEDED_RANDOM is not set
> # CONFIG_DEBUG_KOBJECT is not set
>
> #
> # Debug kernel data structures
> #
> # CONFIG_DEBUG_LIST is not set
> # CONFIG_DEBUG_PLIST is not set
> # CONFIG_DEBUG_SG is not set
> # CONFIG_DEBUG_NOTIFIERS is not set
> # CONFIG_BUG_ON_DATA_CORRUPTION is not set
> # end of Debug kernel data structures
>
> # CONFIG_DEBUG_CREDENTIALS is not set
>
> #
> # RCU Debugging
> #
> # CONFIG_RCU_SCALE_TEST is not set
> # CONFIG_RCU_TORTURE_TEST is not set
> # CONFIG_RCU_REF_SCALE_TEST is not set
> # CONFIG_RCU_TRACE is not set
> # CONFIG_RCU_EQS_DEBUG is not set
> # end of RCU Debugging
>
> # CONFIG_DEBUG_WQ_FORCE_RR_CPU is not set
> # CONFIG_DEBUG_BLOCK_EXT_DEVT is not set
> CONFIG_HAVE_FUNCTION_TRACER=3Dy
> CONFIG_HAVE_FUNCTION_GRAPH_TRACER=3Dy
> CONFIG_HAVE_DYNAMIC_FTRACE=3Dy
> CONFIG_HAVE_DYNAMIC_FTRACE_WITH_REGS=3Dy
> CONFIG_HAVE_FTRACE_MCOUNT_RECORD=3Dy
> CONFIG_HAVE_SYSCALL_TRACEPOINTS=3Dy
> CONFIG_TRACING_SUPPORT=3Dy
> # CONFIG_FTRACE is not set
> # CONFIG_SAMPLES is not set
> # CONFIG_STRICT_DEVMEM is not set
>
> #
> # parisc Debugging
> #
> CONFIG_TRACE_IRQFLAGS_SUPPORT=3Dy
> # end of parisc Debugging
>
> #
> # Kernel Testing and Coverage
> #
> # CONFIG_KUNIT is not set
> # CONFIG_NOTIFIER_ERROR_INJECTION is not set
> # CONFIG_FAULT_INJECTION is not set
> CONFIG_CC_HAS_SANCOV_TRACE_PC=3Dy
> # CONFIG_RUNTIME_TESTING_MENU is not set
> # end of Kernel Testing and Coverage
> # end of Kernel hacking
>

