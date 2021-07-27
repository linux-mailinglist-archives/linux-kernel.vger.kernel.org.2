Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF8FC3D78D6
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 16:50:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232670AbhG0OuF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 10:50:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:53724 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236703AbhG0Osl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 10:48:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627397308;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YXmM12DqOPBR5NdVwUREplw8bRkXLvYyDpOpgDwvZdY=;
        b=TsOo9+sWIBfsMQi6v6P5KFpOyUPN1ceIfQBLWHskMM2VWUcFmwvFAlIoEbleWWmxh6eS2k
        dMqM6LC6zb4dGFFbNLa6sxrqIatPgCaSRzVIfTy9fFeW6DmagUzJO0v+far7HI7Oe8DVuW
        4Y3z+w9rJGU3hzSiwNzukvOAOPB02jE=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-554-OyXT86sXPfSOgSScDIQqiw-1; Tue, 27 Jul 2021 10:48:27 -0400
X-MC-Unique: OyXT86sXPfSOgSScDIQqiw-1
Received: by mail-oi1-f198.google.com with SMTP id w69-20020aca49480000b029025a12f99699so8975127oia.16
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jul 2021 07:48:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YXmM12DqOPBR5NdVwUREplw8bRkXLvYyDpOpgDwvZdY=;
        b=kld16DpvlUDhwEbpuybB42A4Rt+y2mL3Ke1lvdRYpP1egWlYFP1hwcnM4NFmIDhbv3
         V+wctx99+mTLDqTtG6PJb3tCg6FeAvfm5fcUm8e7soxK/rBBbXRTif4iVpYsoiZHPbOQ
         zCliWVt8JXuFr/UJanva279AiqCFejs2ZsXNjfy34y4pH6zBBEYOmd9G3NAM6vX8GAcN
         cO989by3PqJfnm/8suZj7rOUXWqW/Po/9tzVzyHD74u0PGHaBsCT1ibpCQaxrMJGLMGF
         BRmCCnz0gaoz+l6efcXXeXpcIV2uQWZFdyed1TNu0txIiCMgQoxyhxKd63OhiBpQEsxv
         JK3Q==
X-Gm-Message-State: AOAM532q8Kxyst7bd+Ov1fU8uK+Iom1KCrnWjtpQI2XzDgNHgn6fgNp7
        oB3llQq+lpuPN5xV9opAO9J14009F4W2JH+F/Vung4fDPXt5aContKT/s3YKnQLJhT/LTD4SUsH
        aDg/G9Q4k2Hx+91U7lR0qFcqhDlfML6I1KRS13RXa
X-Received: by 2002:a4a:8f13:: with SMTP id e19mr13855538ool.39.1627397306503;
        Tue, 27 Jul 2021 07:48:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwbSCHz+DFACHBh/TryjE1O8fOUSyOcjG+5vSFGJtblIBosX0AONxh6gSZnoYexl5iDmCItlb3dw2Kyy8Q+0A4=
X-Received: by 2002:a4a:8f13:: with SMTP id e19mr13855527ool.39.1627397306321;
 Tue, 27 Jul 2021 07:48:26 -0700 (PDT)
MIME-Version: 1.0
References: <87sg04p315.fsf@oc8242746057.ibm.com> <edb79b68-6dd0-ced5-17a0-fda7516d3529@rasmusvillemoes.dk>
 <CA+QYu4pDGHj--z6yUrkhFs7oW-LUrY23i+-vKJwLPWaCO=z4vA@mail.gmail.com>
 <YQAQFMDMk09wS6Qv@bombadil.infradead.org> <CA+QYu4qSw_W=hdOARxjfisRjx4Lpy-MSe1ZovfUtVb2GGMynkg@mail.gmail.com>
 <YQAWc/6I6MnOGZn1@bombadil.infradead.org> <CA+QYu4ofYOqcuCYohFnYYO+XhAjKfpyGQ4KJr5vE4Fo=whv7UA@mail.gmail.com>
 <YQAbZhCwLS7vb/ag@bombadil.infradead.org>
In-Reply-To: <YQAbZhCwLS7vb/ag@bombadil.infradead.org>
From:   Bruno Goncalves <bgoncalv@redhat.com>
Date:   Tue, 27 Jul 2021 16:48:14 +0200
Message-ID: <CA+QYu4pMF2zfB1U4ORb5bgO1fqcanELc4h=rhfteba6JJVR5dw@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] init/initramfs.c: do unpacking asynchronously
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Alexander Egorenkov <egorenar@linux.ibm.com>,
        akpm@linux-foundation.org, bp@alien8.de, corbet@lwn.net,
        gregkh@linuxfoundation.org, jeyu@kernel.org,
        linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        torvalds@linux-foundation.org, Dave Young <dyoung@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 27, 2021 at 4:42 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
>
> On Tue, Jul 27, 2021 at 04:27:08PM +0200, Bruno Goncalves wrote:
> > On Tue, Jul 27, 2021 at 4:21 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
> > >
> > > On Tue, Jul 27, 2021 at 04:12:54PM +0200, Bruno Goncalves wrote:
> > > > On Tue, Jul 27, 2021 at 3:55 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
> > > > >
> > > > > On Tue, Jul 27, 2021 at 09:31:54AM +0200, Bruno Goncalves wrote:
> > > > > > On Mon, Jul 26, 2021 at 1:46 PM Rasmus Villemoes
> > > > > > <linux@rasmusvillemoes.dk> wrote:
> > > > > > >
> > > > > > > On 24/07/2021 09.46, Alexander Egorenkov wrote:
> > > > > > > > Hello,
> > > > > > > >
> > > > > > > > since e7cb072eb988 ("init/initramfs.c: do unpacking asynchronously"), we
> > > > > > > > started seeing the following problem on s390 arch regularly:
> > > > > > > >
> > > > > > > > [    5.039734] wait_for_initramfs() called before rootfs_initcalls
> > > > >
> > > > > So some context here, which might help.
> > > > >
> > > > > The initramfs_cookie is initialized until a a rootfs_initcall() is
> > > > > called, in this case populate_rootfs(). The code is small, so might
> > > > > as well include it:
> > > > >
> > > > > static int __init populate_rootfs(void)
> > > > > {
> > > > >         initramfs_cookie = async_schedule_domain(do_populate_rootfs, NULL,
> > > > >                                                  &initramfs_domain);
> > > > >         if (!initramfs_async)
> > > > >                 wait_for_initramfs();
> > > > >         return 0;
> > > > > }
> > > > > rootfs_initcall(populate_rootfs);
> > > > >
> > > > > The warning you see comes from a situation where a wait_for_initramfs()
> > > > > gets called but we haven't yet initialized initramfs_cookie.  There are
> > > > > only a few calls for wait_for_initramfs() in the kernel, and the only
> > > > > thing I can think of is that somehow s390 may rely on a usermode helper
> > > > > early on, but not every time.
> > > > >
> > > > > What umh calls does s390 issue?
> > > > >
> > > > > > Unfortunately, we haven't been able to find the root cause, but since
> > > > > > June 23rd we haven't hit this panic...
> > > > > >
> > > > > > Btw, this panic we were hitting only when testing kernels from "scsi"
> > > > > > and "block" trees.
> > > > >
> > > > > Do you use drdb maybe?
> > > >
> > > > No, the machines we were able to reproduce the problem don't have drdb.
> > >
> > > Are there *any* umh calls early on boot on the s390 systems? If so
> > > chances are that is the droid you are looking for.
> >
> > Sorry Luis,
> >
> > I was just replying the question mentioning an old thread
> > (https://lore.kernel.org/lkml/CA+QYu4qxf2CYe2gC6EYnOHXPKS-+cEXL=MnUvqRFaN7W1i6ahQ@mail.gmail.com/T/#u)
> > on ppc64le.
> >
> > regarding the "umh" it doesn't show anything on ppc64le boot.
>
> There is not a single pr_*() call on kernel/umh.c, and so unless the
> respective ppc64le / s390 umh callers have a print, we won't know if you
> really did use a print.
>
> Can you reproduce the failure? How often?

The ppc64le panic we were able to reproduce it often using specific
machines, but last time we've hit this panic was on June 23rd when we
tested commit 444ef33be31f3c27ea24e60d5d9f2de9247d64be on
https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git
since then we haven't hit the panic anymore.

Bruno

>
>   Luis
>

