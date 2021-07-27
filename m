Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E7F83D706D
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 09:32:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235826AbhG0HcO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 03:32:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:25148 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235849AbhG0HcM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 03:32:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627371128;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=E+fq4VUrC9eOaZUekVp5PLymB8SgegwfeNnhobhj/4M=;
        b=SQTuUvbuIrhmU4UJFi/3DIDlvJyi215C9Z/QHJB8imHafV13dVaPEmKB4ZdOwVSMnb+8Ce
        0OoeTBlbSFcS2P4D9DH3qUrVjf7ap5ct8YGfxrepodEOrkPyYXoPFN6F2p2daPPhdbCu4C
        TIbnEmuiTgBqvCIBzyC1qOl7mOuY2H8=
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-530-xROUB3tjPS64T0ddde1xXw-1; Tue, 27 Jul 2021 03:32:06 -0400
X-MC-Unique: xROUB3tjPS64T0ddde1xXw-1
Received: by mail-oo1-f71.google.com with SMTP id y11-20020a4ade0b0000b0290264198007e0so8004328oot.14
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jul 2021 00:32:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E+fq4VUrC9eOaZUekVp5PLymB8SgegwfeNnhobhj/4M=;
        b=hWNnig424lbK1PMk19gcJTBMCLsBgnrrT4VgAW89iJzDTRdzXclMPg3bhS5RzTTWGZ
         NGjvHuQvDzgnynF0pqxuFhzufet3L3moNaWcqUpmj4OzAhatZVp1Ge4FK4bSCnYG5y96
         Yg6H9qhE6hZuGmrUItdCd2wysjZjZFavASIbcgwEFiuzrV3J9zHhCK3Uflxxl7KtNiBa
         SPzPJm+H000ihpVbRpRTm7YNIXOJX09WR0QZizgeOCuVud9Tmg43WL21OAcObrqTSvhK
         2mq+f9Df2Tl/uWIm7vbWPT6RcP5ZG0S7nlqoFXRUJ+3H9qEO6wbkQ7GYITg9XgHB1Wm0
         ygPg==
X-Gm-Message-State: AOAM530tHdwXA7b7O/6ufCcZ7j8VYVwfnjzE8ugH7+sJ0fcyOMKhY0yQ
        EausXN2rkkH/r7Eqak2fbMjRbGFcTeD/hqDFMiExBvbaXECBZphQzHKGv2ri7qPLb6arl9zXLCP
        a0bLB6JJYT4Zw4hGaA1lOtXluFaB9/4O9KFpcPyme
X-Received: by 2002:a9d:4682:: with SMTP id z2mr14530592ote.189.1627371126229;
        Tue, 27 Jul 2021 00:32:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyRrvwHsXf3kLWn0b7OVEoZo6THN2riHtQNX3753e0JDr3nxDmvZx0bViPol9uf0U0gGn1csIbXniuDEofZPlk=
X-Received: by 2002:a9d:4682:: with SMTP id z2mr14530586ote.189.1627371126014;
 Tue, 27 Jul 2021 00:32:06 -0700 (PDT)
MIME-Version: 1.0
References: <87sg04p315.fsf@oc8242746057.ibm.com> <edb79b68-6dd0-ced5-17a0-fda7516d3529@rasmusvillemoes.dk>
In-Reply-To: <edb79b68-6dd0-ced5-17a0-fda7516d3529@rasmusvillemoes.dk>
From:   Bruno Goncalves <bgoncalv@redhat.com>
Date:   Tue, 27 Jul 2021 09:31:54 +0200
Message-ID: <CA+QYu4pDGHj--z6yUrkhFs7oW-LUrY23i+-vKJwLPWaCO=z4vA@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] init/initramfs.c: do unpacking asynchronously
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Alexander Egorenkov <egorenar@linux.ibm.com>,
        akpm@linux-foundation.org, bp@alien8.de, corbet@lwn.net,
        gregkh@linuxfoundation.org, jeyu@kernel.org,
        linux-kernel@vger.kernel.org, mcgrof@kernel.org,
        ndesaulniers@google.com, torvalds@linux-foundation.org,
        Dave Young <dyoung@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 26, 2021 at 1:46 PM Rasmus Villemoes
<linux@rasmusvillemoes.dk> wrote:
>
> On 24/07/2021 09.46, Alexander Egorenkov wrote:
> > Hello,
> >
> > since e7cb072eb988 ("init/initramfs.c: do unpacking asynchronously"), we
> > started seeing the following problem on s390 arch regularly:
> >
> > [    5.039734] wait_for_initramfs() called before rootfs_initcalls
>
> While that message was added as part of the same patch, it's a red
> herring: It merely means that something ends up calling usermodehelper
> (perhaps a request_module) before the init sequence has come around to
> rootfs_initcalls. At that point, the rootfs is (with or without my async
> patch) entirely empty, so those usermodehelper calls have always failed
> with -ENOENT.
>
> If you have CONFIG_UEVENT_HELPER=y and CONFIG_UEVENT_HELPER_PATH set to
> a non-empty string, you can try setting the latter to the empty string.
> But the message won't go away if it's really a request_module() and not
> a uevent notification.
>
> > [    6.599433] rootfs image is not initramfs (broken padding); looks like an initrd
> > [    6.669373] Freeing initrd memory: 24828K
> >
> > It is very hard to reproduce, i haven't managed to do it yet and working
> > on it, but it occurs regularly, nearly every day once but only on a particular
> > test machine with our nightly s390 CI test runs.
>
> So this looks somewhat similar to a ppc64 report
>
> https://lore.kernel.org/lkml/CA+QYu4qxf2CYe2gC6EYnOHXPKS-+cEXL=MnUvqRFaN7W1i6ahQ@mail.gmail.com/T/#u
>
> that ended up not being caused by e7cb072eb988, since it could also be
> reproduced with that patch reverted. I don't know if Bruno found the
> root cause, adding him to cc. Also cc += Dave Young who had some input
> in that thread.

Unfortunately, we haven't been able to find the root cause, but since
June 23rd we haven't hit this panic...

Btw, this panic we were hitting only when testing kernels from "scsi"
and "block" trees.

Bruno
>
> > Although the initramfs corruption is hard to reproduce,
> > the message 'wait_for_initramfs() called before rootfs_initcalls'
> > appears regularly on each boot at least since 2021-06-24 which we just
> > noticed a couple of days ago.
> >
> > Appending 'initramfs_async=0' to the kernel command-line doesn't seem to
> > help with the 'wait_for_initramfs' message and i can still see it.
>
> Yes, that's expected. I should probably send a patch to move
> usermodehelper_enable() from do_basic_setup() to populate_rootfs(), as
> it really doesn't make sense to have usermodehelper enabled before
> there's any content in the file system. But as I said, the warning is
> harmless and merely indicates there's a bunch of futile work being done
> to call a (at that point in time) non-existing usermode program.
>
> > [    0.890962] wait_for_initramfs() called before rootfs_initcalls
> ...
> > [    1.636419] Trying to unpack rootfs image as initramfs...
> > [    1.676907] Freeing initrd memory: 26056K
>
> It would be interesting if you could boot with initramfs_async=0 enough
> times to see if you can reproduce the problem; and/or do the same with
> e7cb072eb988 reverted.
>
> Thanks,
> Rasmus
>

