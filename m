Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF0573A2F1C
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 17:14:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231578AbhFJPQm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 11:16:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:27039 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231542AbhFJPQe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 11:16:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623338078;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IR1boR4bTvPzYZX9eQCIo5EDpNKOwQbZFVHgurBzUOc=;
        b=DpNSyGU84SWo6Zc+5qYEgjTENNW3X/YJRw2M5Hqy67vZryFXiWn3kAV24Kwnzdie9KaaY1
        zoSLaJdCwp5j2G8w/7LCpghpbkwW1wnOmmxLxWH7mtqPmS5XL4YcVKbsCFCGri/zmuNOUv
        L0tkFSE5m+UHk3Fs2Os8rW2wM0NSbec=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-60-zLG-AsIMPX2JbdX-16yUwA-1; Thu, 10 Jun 2021 11:14:36 -0400
X-MC-Unique: zLG-AsIMPX2JbdX-16yUwA-1
Received: by mail-ot1-f70.google.com with SMTP id 88-20020a9d06e10000b029030513a66c79so42591otx.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jun 2021 08:14:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IR1boR4bTvPzYZX9eQCIo5EDpNKOwQbZFVHgurBzUOc=;
        b=lHDYf3UU/YOdg5FzJkLICamlXPcUH+6VB9v09YPpJQk0A9Q/XaU3UPqNLBuSZ+e6KS
         +ABs6rJht4j2S7FkjQ2v6yEBGi79/jG7PbUFRXnSWSXq9npsRZz79nx4Vz0er6AVd/BX
         FHwjSx1G/KvynvQ//2MyIRDdgK2+9rrKnmFJKy2oPBb40PqRLjZYeEcX9Ymx8eXAXg5X
         yUPl5k1RNafIX9G6zMLbXLvdKk/VP6Fj8CZ5k/EeONSHtSwqzqUK8/jtdtjVsbeBjIMT
         a460IlTz6FAFqGMYQNAndjt3EXdik7eouvLaFnj6KSzIL3Bd8oCvcBp+R1dRD9d/Zn++
         OA0Q==
X-Gm-Message-State: AOAM533U2+G1J0G758jnqAuBqOSpVeiUfiYhit/dbqhfc4wDICiBrq5R
        +T5jRkbuuR9xtmnm7pAMNEFjdlCvxS4Cs3dcFc8TrEUdqv8/PeqURjroIMGVCVzWcOP6ivJxutK
        ZAsiXU0e2u0tbja3U0hjlcni4VN0zmzyVXeRS+qvR
X-Received: by 2002:a4a:ba87:: with SMTP id d7mr2759070oop.6.1623338075907;
        Thu, 10 Jun 2021 08:14:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJziw0EYuHCZ8HFFYlt2bHj+dzjSaIrRYNyd/8dQ/sy+Uvyqf3UHmfsbWZWa6B9lMp9rAKSWMb8LWg99xCNZ+yU=
X-Received: by 2002:a4a:ba87:: with SMTP id d7mr2759052oop.6.1623338075657;
 Thu, 10 Jun 2021 08:14:35 -0700 (PDT)
MIME-Version: 1.0
References: <CA+QYu4qxf2CYe2gC6EYnOHXPKS-+cEXL=MnUvqRFaN7W1i6ahQ@mail.gmail.com>
 <d13db73d-0806-00cd-ff84-5f5b03ffbef6@rasmusvillemoes.dk>
In-Reply-To: <d13db73d-0806-00cd-ff84-5f5b03ffbef6@rasmusvillemoes.dk>
From:   Bruno Goncalves <bgoncalv@redhat.com>
Date:   Thu, 10 Jun 2021 17:14:24 +0200
Message-ID: <CA+QYu4oFGkP1G+9TqGtqffgOEBycSMKtFbV-1X+kL4NeTyEegg@mail.gmail.com>
Subject: Re: Panic on ppc64le using kernel 5.13.0-rc3
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     linux-kernel@vger.kernel.org, CKI Project <cki-project@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 10, 2021 at 3:02 PM Rasmus Villemoes
<linux@rasmusvillemoes.dk> wrote:
>
> On 10/06/2021 13.47, Bruno Goncalves wrote:
> > Hello,
> >
> > We've observed in some cases kernel panic when trying to boot on
> > ppc64le using a kernel based on 5.13.0-rc3. We are not sure if it
> > could be related to patch
> > https://lore.kernel.org/lkml/20210313212528.2956377-2-linux@rasmusvillemoes.dk/
> >
>
> Thanks for the report. It's possible, but I'll need some help from you
> to get more info.
>
> First, can you send me the .config?

The .config is on
https://s3.us-east-1.amazonaws.com/arr-cki-prod-datawarehouse-public/datawarehouse-public/2021/06/09/317881801/build_ppc64le_redhat:1332368174/kernel-block-ppc64le-d3f02e52f5548006f04358d407bbb7fe51255c41.config

>
> >
> > [    1.516075] wait_for_initramfs() called before rootfs_initcalls
>
> This is likely because you have CONFIG_UEVENT_HELPER_PATH set to some
> non-empty path (/sbin/hotplug perhaps). This did get reported once before:
>

CONFIG_UEVENT_HELPER_PATH is not set. In the .config we have "#
CONFIG_UEVENT_HELPER is not set"


> https://lore.kernel.org/lkml/45556f52-cd2f-5512-ba65-81e4acee21ff@rasmusvillemoes.dk/
>
> I think I should go and prepare a patch that moves the
> usermodehelper_enable() call to after initramfs unpacking has been
> initiated.
>
> But until then, can you check if you do have UEVENT_HELPER_PATH set, and
> if so, does changing it to the empty string make a change wrt this crash?
>
>
> > [    1.559757] PCI: CLS 128 bytes, default 128
> > [    1.560150] Trying to unpack rootfs image as initramfs...
>
> OK, so now we got to populate_rootfs() and have kicked off a worker to
> do the unpacking. Meanwhile, PID1 goes on to do other initcalls.
>
> ...
>
> > [    1.764430] Initramfs unpacking failed: no cpio magic
>
> Whoa, that's not good. Did something scramble over the initramfs memory
> while it was being unpacked? It's been .2 seconds since the start of the
> unpacking, so it's unlikely the very beginning of the initramfs is corrupt.
>
> Can you try booting with initramfs_async=0 on the command line and see
> if the kernel still crashes?

We are not able to reproduce it 100% of the time, but sure I can try
with this option and see what happens.

We've also seen:
Initramfs unpacking failed: junk within compressed archive

This can be seen on the other 2 console logs that I provided the link to.

Bruno
>
> > [    1.766204] Freeing initrd memory: 18176K
> ...
>
>
> > [    1.787649] Run /init as init process
> > [    1.787793] Failed to execute /init (error -2)
> > [    1.787801] Run /sbin/init as init process
> > [    1.787842] Run /etc/init as init process
> > [    1.787880] Run /bin/init as init process
> > [    1.787921] Run /bin/sh as init process
> > [    1.787978] Kernel panic - not syncing: No working init found.  Try
>
> Yeah, well, this is expected when unpacking the initramfs failed.
>
> So I think the problem is the "no cpio magic", i.e. the initramfs got
> corrupted somehow. But I don't have any idea why that would happen -
> freeing the initramfs memory only happens after unpacking is done
> (naturally...).
>
> Rasmus
>

