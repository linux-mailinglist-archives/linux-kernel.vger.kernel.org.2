Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59F2E3239DA
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 10:50:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234715AbhBXJtg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 04:49:36 -0500
Received: from mail-ot1-f51.google.com ([209.85.210.51]:46404 "EHLO
        mail-ot1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234759AbhBXJs2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 04:48:28 -0500
Received: by mail-ot1-f51.google.com with SMTP id k13so1546747otn.13
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 01:47:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LOkFQkSyGmGbTSK7UVWwJcmirkVFS7HN51aqBFsnaZM=;
        b=LiKFBqX/D5KSjRrsmjyntriGkZAy6zeeT7tHtZklyiT0glBZTLJPWFkgvLULcWpa9a
         frezFxL09NiusZpw+/5engWuj0Vj5pzfQwyDiDv3VAYMYPX7aOhJ6cPC7ywhliPEQ6xA
         WS13tQ8jroKBXm9uaB0krwTJZ7Z97ANI8YAppYdEvr5WNxRlH6EueUJ7AN21RkODZsNF
         hDTKer/zlmAypD+t5NikHdwEu2KMddjSDuJncCvHERTVTADIDraERtVATJ0yuBIpwhDS
         nllDPUAW/8BcM/3Zzfo21uxThkXbJgnOTkfl9FUv1mmxHbwOvhz2+RTKgyLFOV8L7Pc3
         RxNA==
X-Gm-Message-State: AOAM531wSLHvPyl2uPzC5S0KzwtHhEh0sr/d+zEigniA4LJxkeGT06JN
        OYhBheEHGtdKQrDeO9ZqeELS7WVZpdTsdTc8QCc=
X-Google-Smtp-Source: ABdhPJzbt796VXqH/2Q5eGwqQ/2vS4JY7MHMruI8T9KuXwsCXs4Kb5ejbxELgtMu/ApwS3m6yACL0Bf78v2qiM0TivA=
X-Received: by 2002:a9d:77d6:: with SMTP id w22mr24104785otl.145.1614160052930;
 Wed, 24 Feb 2021 01:47:32 -0800 (PST)
MIME-Version: 1.0
References: <20210223152707.408995-1-johannes@sipsolutions.net> <d2c3b464d782809298670b1ecbc199f56d776600.camel@sipsolutions.net>
In-Reply-To: <d2c3b464d782809298670b1ecbc199f56d776600.camel@sipsolutions.net>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 24 Feb 2021 10:47:21 +0100
Message-ID: <CAMuHMdWymKxYQHPC4Rqc1A7WSdQZDm6noaedHgXqfXPttmGV6w@mail.gmail.com>
Subject: Re: [PATCH 0/7] PCI support for UML
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-um <linux-um@lists.infradead.org>,
        Arnd Bergmann <arnd@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Johannes,

On Tue, Feb 23, 2021 at 10:24 PM Johannes Berg
<johannes@sipsolutions.net> wrote:
> On Tue, 2021-02-23 at 16:27 +0100, Johannes Berg wrote:
> > In order to simulate some devices and write tests completely
> > independent of real PCI devices, we continued the development
> > of time-travel and related bits, and are adding PCI support
> > here now.
> >
> > The way it works is that it communicates with the outside (of
> > UML) with virtio, which we previously added using vhost-user,
> > and then offers a PCI bus to the inside system, where normal
> > PCI probing etc. happens, but all config space & IO accesses
> > are forwarded over virtio.
>
> I hadn't sent it out until now, but the userspace bits for all the time-
> travel and PCI-over-vhost-user are here:
>
> https://github.com/linux-test-project/usfstl/
>
> If anyone has any suggestions on a good example PCI device that already
> has a driver upstream I'd be interested - I looked for something simple
> like LED or GPIO but no such thing I could find (that wasn't platform
> dependent in some way). So far I've only implemented a virtual Intel
> WiFi NIC, but that depends on a large body of code I can't publish. As
> an example, it would be nice to write (and publish there) a simple PCI
> device implementation. :)

 bt8xxgpio?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
