Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BFAA39BFBE
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 20:35:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230407AbhFDShL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 14:37:11 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:56167 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230161AbhFDShK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 14:37:10 -0400
Received: from mail-wr1-f43.google.com ([209.85.221.43]) by
 mrelayeu.kundenserver.de (mreue011 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MXXdn-1ls9S808UR-00Yyey; Fri, 04 Jun 2021 20:35:23 +0200
Received: by mail-wr1-f43.google.com with SMTP id m18so10231375wrv.2;
        Fri, 04 Jun 2021 11:35:22 -0700 (PDT)
X-Gm-Message-State: AOAM530Wc5/DTeSSfFQ3l3HthMkHBH1oWk8zFYw0A0Pl5jKssSLRcDst
        TYlikTDubz1/NlyW0xeUeXppIT3C2FUFVi8F2uo=
X-Google-Smtp-Source: ABdhPJxERBDztGap2tMeeCVda43Ious9cLlsWPwTXGV01hDgX+xRbkwxcD2X8jt1oNQSa3O2nrllQDYOEr19Z8vD4+o=
X-Received: by 2002:adf:fe4f:: with SMTP id m15mr5424092wrs.361.1622831722675;
 Fri, 04 Jun 2021 11:35:22 -0700 (PDT)
MIME-Version: 1.0
References: <20210604120639.1447869-1-alex@ghiti.fr> <CAK8P3a1TiSNoqUEjTaqPyqnU8d0-p-yZkrsvmXt5fo4Rkfue_w@mail.gmail.com>
 <CAM4kBBK467AZ-qhmtREe9mr_bp3QcCEptQcFAApnbrvPc6bkuA@mail.gmail.com>
In-Reply-To: <CAM4kBBK467AZ-qhmtREe9mr_bp3QcCEptQcFAApnbrvPc6bkuA@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 4 Jun 2021 20:33:39 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1dSaYbQi1Csbp2LDcruj3+Ae6VVgNDXatSjTU77G7d0Q@mail.gmail.com>
Message-ID: <CAK8P3a1dSaYbQi1Csbp2LDcruj3+Ae6VVgNDXatSjTU77G7d0Q@mail.gmail.com>
Subject: Re: [PATCH -fixes] riscv: Fix BUILTIN_DTB for sifive and microchip soc
To:     Vitaly Wool <vitaly.wool@konsulko.com>
Cc:     Alexandre Ghiti <alex@ghiti.fr>, Rob Herring <robh+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        DTML <devicetree@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:nzBUb3DvPak7cPgBEfmp9lK3RkmQRCOTLLKjSnngLBEGJbEDTqj
 mS8OBBXtWOuYe+Y/3kVZmr5DPWnhNzhoMwFfG3ZtGfIhLpZsAXvPHQzFeKZHcd7jJaaeR5A
 qfDJctD2kcKT+mXe0WT0Q9xCKF0gMghfWC6rBUZQGdgRJU2ppx1V/gSsTBDUJqcrCHTyEGN
 bctsJ/tRSypStbCIit26g==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:FKTAksBkgMg=:SAGeGdeq4rtaf6wJAqdo4g
 wAx5rig+hBIBf1edn7baUhS0h008fG6yTeuzwlqh/0c3pS2rVEM0bee1Yi9IVcfKf/BHqsncI
 5tEOiBIdjMEBRbCx0FlqCIxwuCRiIDF6O3EBC98oRA5dkgz8IvKESTxTixrLj6IeOT9o6atZs
 g2wowtP5Z9LxWpK14wfIFwvZmfH6x7gyg0xyFIWpFd/F+hdRkQcsxLJQr+ipOW93Z/ei/J4iQ
 anaTfNrWyKVPzx0asTxwvDeeqCLtIgXcctsmpuWSJFZtr1vcOXro9kDm1FrpeUO2a6pMYGuQL
 TQd05xvsnDelI1vf1kBXRqSAGpiWAr6lEE7O6zIz/yLTJwlIeIt+MMKYwWBcHS08D/oW1ANrj
 u4EmThvz6/l7uaASXu2ImY6OXzhdnL7+/7zuZgBCUz2VmpYZ5WHnaq0WG0SXVKO5EVWYv5N8w
 tYhFi5XWF4/cvDxfWxXq6VNhZiBRZDxm6JHdh9uBj2caqOOcmvtG0Dpwjb42Qe5NqyOymqEfi
 kqfK97ly6QwAHBwWazHSxM=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 4, 2021 at 7:45 PM Vitaly Wool <vitaly.wool@konsulko.com> wrote:
> On Fri, Jun 4, 2021 at 3:18 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > On Fri, Jun 4, 2021 at 2:06 PM Alexandre Ghiti <alex@ghiti.fr> wrote:
> > >
> > > Fix BUILTIN_DTB config which resulted in a dtb that was actually not built
> > > into the Linux image: in the same manner as Canaan soc does, create an object
> > > file from the dtb file that will get linked into the Linux image.
> > >
> > > Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>
> >
> > Along the same lines as the comment that Jisheng Zhang made on the fixed
> > address, building a dtb into the kernel itself fundamentally breaks generic
> > kernel images.
> >
> > I can understand using it on K210, which is extremely limited and wouldn't
> > run a generic kernel anyway, but for normal platforms like microchip and
> > sifive, it would be better to disallow CONFIG_BUILTIN_DTB in Kconfig
> > and require a non-broken boot loader.
>
> can't quite agree here. If we take XIP, it does make sense to have
> BUILTIN_DTB, since 1) this will not be a generic kernel anyway 2) we
> may want to skip the bootloader altogether or at least make it as thin
> as possible and 3) copying device tree binaries from bootloader to RAM
> as opposed to having it handy compiled in the kernel will be just a
> waste of RAM.

Indeed, it does make sense in combination with XIP. Maybe there could
be a Kconfig option that depends on CONFIG_EXPERT and that can
be used to guard non-generic options like this?

       Arnd
