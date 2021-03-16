Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 686CF33D899
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 17:04:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238367AbhCPQDf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 12:03:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238395AbhCPQD3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 12:03:29 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE2B5C06174A
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 09:03:28 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id x10so35729105qkm.8
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 09:03:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=beVxRTMBMXPpmNrXHLYtJs0EbkQrNYHRKHyxRcHuRb4=;
        b=awxSxSy4uwWFzbkMD8sxKddEysDquay9biMF9KhoimOyTg8rI0A8N5JMTqSAw9ZWC3
         bOIkkGLySwlBbw4sHieL3iZ9itgC0ILzj/+70qwyNrBE7dyRSGHbsoIqvTyW3E3FgoQd
         gM1tVxMpX6uBYFUNcK996RWmBRyTYkj7MajWME1b9WtW7np9uaWXjQ3MqLplAmG9i4H4
         FM5681UjVflvNnSWkR3dkwtXrikrXvnjYWf0S34mOGWz3B9AWXwP5W/JVIYvITwD5txy
         e58n/1O7tqNlBZZM7BefWdolZdlEkCU/672p5RfJFUJ93iUAjQ0OHGrMm8hE2UeJugh2
         sMGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=beVxRTMBMXPpmNrXHLYtJs0EbkQrNYHRKHyxRcHuRb4=;
        b=YG1YjgToWAAEpjY3Y8hYTvXacImheO3USpVoyVcl07LFher55OyUrCJBANtXIOcmOV
         vrJrdTyNGAaTxNU7zt3ZuosGE4gMbMuetbX35zkbo/XyAjdAKY5IN5TcBsS/Se+Qah/x
         LcQaOp6UFGCk+vYV3MKmGqtrTR5h2adQL98cUxAMEkCq3mjbf7mgU0CPr6sC9C7PFwFA
         kuwa5xBS8CanPAy3isaEwAx/wVcVnfxZ2Y9c+PWyIzFdtPdgEUJVNFluOqHIgjBuEKns
         qOhYgoAt3SHbOJTB9Ui+DGky8Mq1WpitNPKvO0c/Do8Fo5bdOTfhnFTJub8T4FO9iWLq
         XxWw==
X-Gm-Message-State: AOAM532KoWMvnIjUimCcFXcRw2+ldRg9ONYyV3ZAdSlnPfiCJcuHC2ZO
        gHrTl+aQeEbY2l99tG2x+mHxUD3WdSfaztx0zxQN/w==
X-Google-Smtp-Source: ABdhPJyHqFKybJ5rQin3MWnJ3Of9cFOqQpCXXsc44QzH+iUoekUd1pC6hQAeTOhuPETNmLlxujDVr3AMkVf/HKwAzh4=
X-Received: by 2002:a05:620a:981:: with SMTP id x1mr225906qkx.501.1615910607811;
 Tue, 16 Mar 2021 09:03:27 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000069802205bda22b7f@google.com> <CACT4Y+Yaq-zDh5FAzHt4g-5jXrXC3rSLw6CM=kjcfR6oxJ1+CA@mail.gmail.com>
 <CAK8P3a1qtHVBY47FfCa6R9+sObzMCwxkREii+O2g8PPopw87eQ@mail.gmail.com>
 <CACT4Y+aC0YWU6gM32S3NoT+-wR7B1-_rhPyh4w542h21UCRRGw@mail.gmail.com>
 <CAK8P3a0zA9pv005d_P_e64j4EwXDh75yC6gNGRVdyy-VzO+7Fw@mail.gmail.com> <20210316155102.GP1463@shell.armlinux.org.uk>
In-Reply-To: <20210316155102.GP1463@shell.armlinux.org.uk>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 16 Mar 2021 17:03:16 +0100
Message-ID: <CACT4Y+bzBa6+2XFD0=_VVV-XFHgiP2BAnHHGKB=i0qyvP+HXWA@mail.gmail.com>
Subject: Re: [syzbot] kernel panic: corrupted stack end in openat
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        syzbot <syzbot+0b06ef9b44d00d600183@syzkaller.appspotmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 16, 2021 at 4:51 PM Russell King - ARM Linux admin
<linux@armlinux.org.uk> wrote:
>
> On Tue, Mar 16, 2021 at 04:44:45PM +0100, Arnd Bergmann wrote:
> > On Tue, Mar 16, 2021 at 11:17 AM Dmitry Vyukov <dvyukov@google.com> wro=
te:
> > > On Tue, Mar 16, 2021 at 11:02 AM Arnd Bergmann <arnd@arndb.de> wrote:
> > > > > On Tue, Mar 16, 2021 at 8:18 AM syzbot
> > >
> > > > > > [<8073772c>] (integrity_kernel_read) from [<8073a904>] (ima_cal=
c_file_hash_tfm+0x178/0x228 security/integrity/ima/ima_crypto.c:484)
> > > > > > [<8073a78c>] (ima_calc_file_hash_tfm) from [<8073ae2c>] (ima_ca=
lc_file_shash security/integrity/ima/ima_crypto.c:515 [inline])
> > > > > > [<8073a78c>] (ima_calc_file_hash_tfm) from [<8073ae2c>] (ima_ca=
lc_file_hash+0x124/0x8b8 security/integrity/ima/ima_crypto.c:572)
> > > >
> > > > ima_calc_file_hash_tfm() has a SHASH_DESC_ON_STACK(), which by itse=
lf can
> > > > use up 512 bytes, but KASAN sometimes triples this number. However,=
 I see
> > > > you do not actually have KASAN enabled, so there is probably more t=
o it.
> > >
> > > The compiler is gcc version 10.2.1 20210110 (Debian 10.2.1-6)
> >
> > Ok, building with Ubuntu 10.2.1-1ubuntu1 20201207 locally, that's
> > the closest I have installed, and I think the Debian and Ubuntu version=
s
> > are generally quite close in case of gcc since they are maintained by
> > the same packagers.
> >
> > I see ima_calc_field_array_hash_tfm() shows up as one of the larger
> > stack users, but not alarmingly high:
> > ../security/integrity/ima/ima_crypto.c: In function
> > =E2=80=98ima_calc_field_array_hash_tfm=E2=80=99:
> > ../security/integrity/ima/ima_crypto.c:624:1: warning: the frame size
> > of 664 bytes is larger than 600 bytes [-Wframe-larger-than=3D]
> > none of the other functions from the call chain have more than 600 byte=
s
> > in this combination of config/compiler/sourcetree.
> >
> > In combination, I don't get to more than ~2300 bytes:
>
> ... which shouldn't be a problem - that's just over 1/4 of the stack
> space. Could it be the syzbot's gcc is doing something weird and
> inflating the stack frames?

It's just a stock Debian-provided gcc. Which I would assume also just
a plain gcc.
