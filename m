Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FB0E3FA79C
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Aug 2021 23:26:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233916AbhH1V1f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Aug 2021 17:27:35 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:47959 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232532AbhH1V1e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Aug 2021 17:27:34 -0400
Received: from mail-wr1-f45.google.com ([209.85.221.45]) by
 mrelayeu.kundenserver.de (mreue011 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MQdtO-1mgjKe2KGs-00Ng03; Sat, 28 Aug 2021 23:26:42 +0200
Received: by mail-wr1-f45.google.com with SMTP id u16so16201750wrn.5;
        Sat, 28 Aug 2021 14:26:42 -0700 (PDT)
X-Gm-Message-State: AOAM530A0LiUb5m55CRPyLg2BpilximUExHXKjFmbgu5kb36U/dW/UEl
        /Fvaq/T9nepORjziTFtMXobrY6W5ELwjGkfp0Sk=
X-Google-Smtp-Source: ABdhPJwvDnsDJcn3wIhFHRhkw8EPD/pggXR8T4gD9Xh87dD/CiOcm+8HpoR7LLiItw7WlQGpC2ld22sA7ZHK6OreHnU=
X-Received: by 2002:adf:b781:: with SMTP id s1mr10383658wre.165.1630186002171;
 Sat, 28 Aug 2021 14:26:42 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1630083668.git.christophe.jaillet@wanadoo.fr> <612A50C4.2080209@gmail.com>
In-Reply-To: <612A50C4.2080209@gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Sat, 28 Aug 2021 23:26:26 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1=tZkb-rxj5Ys_FgUa=qoKPD6fpPjEMHXDL0QwwS0zgg@mail.gmail.com>
Message-ID: <CAK8P3a1=tZkb-rxj5Ys_FgUa=qoKPD6fpPjEMHXDL0QwwS0zgg@mail.gmail.com>
Subject: Re: [PATCH v1 0/4] char: xillybus: Remove usage of the deprecated
 'pci-dma-compat.h' API
To:     Eli Billauer <eli.billauer@gmail.com>
Cc:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Arnd Bergmann <arnd@arndb.de>,
        gregkh <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:SfZd/6/VPd+vpSJtwx98oNSjKSxpNw4Dj18VzVx1viyfokFzESd
 wka5xkyUfXDzcKtpH8aY2+X0PEqBErPaEnz4+VoHk5bLlU5LkRkSZBSKTYFWEVUgupriGZr
 3LxbfkIaxA3aQbAUcEK5SrWFo1dNzrClxdomhxEQYivC47fZ/PDIXCxm63jbIV5YWykJXB8
 KlDSXErMH0zSjSTmJ1DOw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:m86IDzp4oNs=:ZyFwd5QinI1i2btLgw+xMm
 qgb98PObe1/9td3pZRMt8C6PpPs3+SiiyMAJEIVwm6f9zdMNt0axPXkl8748nGRRLVy5XG1di
 E+VyHckvfm0NQkZOXJcHGmlzpuYgEcMXdw/f2Fj7+BYKSGXANvL+L8H6A1PFcO6+K4iY5tCb9
 1AwNKlXPQp29r8JHxH8Lmc2nHp5JNsxsYTHYvUMfE83mDyZqRG0dZXjFtn3p+3g9Kj4uSv6oz
 OfO8shRm4lZeAmTof4MTvUyrkN52+zBUg6fGWnPwv1Fk1jkKpxkPCJHR2sxQ+fM4L/R1K+dK4
 BGCREerzvECjJXTzgSN/s4Fg3cDGJ7GCMf3q/9XXieHBhXJ1zEaqUTZZxFna+Hii4TbT9VpXr
 bR9PSKFEm4U47kAO0DvbKg8M+CpOhAfw/c1GaHLtEJcZUt4+uWC9bzdftET7kGYLDC2P0OBtx
 5+Bu4vuD1VwAqWbofZVaTABX1kCefzmiNj6nGALzpIn1OE6uqku6LDqGPLcUdutj22/uijEP9
 Q875mTbRj0IjpqC2aMPqEuRWEw5+tMIg1qtZePGmb66mEFqcL5rBpFI3nWx+W/EAZO+w4/+EH
 dYAVDcLUIQfW+dCqTkLjUhUAXq1elmlMHlJJPHgv4vt0YL5OENNT7MNWViCVUN1+Buq0N5Ktg
 3BESG7asFqp1knedtjrYXGMP7kF1BAqVeRP5bdxQPDw8bPLeud+rGtqce7pch/GR71/Lshjz7
 ECsq9TFYg+IEcUONwTwf4jFA/69kH+uPrio4jA==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 28, 2021 at 5:07 PM Eli Billauer <eli.billauer@gmail.com> wrote:
>
> On 27/08/21 20:17, Christophe JAILLET wrote:
> > In [1], Christoph Hellwig has proposed to remove the wrappers in
> > include/linux/pci-dma-compat.h.
> >
> Xillybus' driver is an example for why this is a good idea. But has this
> been decided upon? Are we sure that there isn't a single platform where
> the DMA mapping for PCI is different from non-PCI, and that such
> platform will never be?

Yes.

> If so, is there any reference to that decision?

The documentation was updated 11 years ago to only describe the modern
linux/dma-mapping.h interfaces and mark the old bus-specific ones as
no longer recommended, see 216bf58f4092 ("Documentation: convert
PCI-DMA-mapping.txt to use the generic DMA API").

> I think the best way is to put a comment at the top of pci-dma-compat.h
> saying that the functions in that header file are deprecated and will go
> away soon. That would, more than anything else, convince people like me
> to get rid of those PCI-DMA function calls.

The only reason for keeping the old interface around any day longer would
be to identify drivers that have been unmaintained for the past decade
and ignored all the previous cleanup patches that got sent to them.

       Arnd
