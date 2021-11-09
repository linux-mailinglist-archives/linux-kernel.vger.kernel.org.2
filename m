Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2BC144AF38
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Nov 2021 15:10:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234382AbhKIONS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Nov 2021 09:13:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236764AbhKIONO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Nov 2021 09:13:14 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2D26C061766
        for <linux-kernel@vger.kernel.org>; Tue,  9 Nov 2021 06:10:27 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id b2-20020a1c8002000000b0032fb900951eso2003818wmd.4
        for <linux-kernel@vger.kernel.org>; Tue, 09 Nov 2021 06:10:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=immu-ne.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jc4X9K7wC5BIh1zikkF4jw2nguZARGhOjunpR6TnJco=;
        b=HGZDAepzUlnAsrB0tIJBgUoe0UOBZ8bb2VaaCk7nC3DZNmTcMSacC5SPwTG+P2MTYF
         Ul75B0MWTqWGT9b+VvMy3NcQkRuw3JMMakakeNuB1iMf8LN1tTJCh0gzA4ltapAVHxhz
         yT8pnflhp8rgeJ2603BCreVzLxi+donMXcYT7GTyfextTpFlAdDXD33Q4k8Uh/Gy5h0F
         /CCo6sKIoebRLTWolc0KUV3kKHOh7xPPBA+8WcvfgdoUGtwbz2NHxsHM//uZAvVdIkUW
         TzAaJpKhYCQQ6ilLRqpwiQ2BqvL8kdfqhGt8t6N4xEZLG5SxQW/vYPcceWWZg7mW8Evb
         ELtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jc4X9K7wC5BIh1zikkF4jw2nguZARGhOjunpR6TnJco=;
        b=E/UumTjc1G1G3CqHThPowZB/qQ06lS0YvL51AF6pbv4LaPbo1yJc9A+unRoYW0SNqv
         iMC4t+2mkhUkBIv9+X/u6Phd2EkmjbaK1TV6nogXzmBHwmKnyuTU32S05fcrmoJXgPrv
         Vjm5rRyTqTi5hd0qaahYdtLorL39nM2Xaxio2hH/3WE/K3iU/AWNxEFxI5dUHdFrm260
         mRPgn6i0Wt5hpEKJJFGzcoTeZQq6VxZQfee9z5LudBGZLPblIzCcGru/t2qlahHs/6eD
         DdvFYTSfAd5poE1WiEldKjW7pet8VioNYOzfuvrCRtHgReCY+cy9SLzeliiBiJrDmySn
         t1QQ==
X-Gm-Message-State: AOAM530E5cA9Sqeqv+xQJdCo0pEFA+fxjWlN0cJj0qBxn43Fvmm/4oP5
        fu5e9GnSQxCDKaDcyKMtKpZJhdCXV7UdXEy+jiF1Sw==
X-Google-Smtp-Source: ABdhPJwmraAi36sxQjgq0SiGOsprYn6RZMLwuDgzOrqj3oRdRMRNFiTcxJdUVkpmj3w6/o16vgfPRAdW3QnPTVuqiG0=
X-Received: by 2002:a05:600c:1990:: with SMTP id t16mr7529868wmq.48.1636467026385;
 Tue, 09 Nov 2021 06:10:26 -0800 (PST)
MIME-Version: 1.0
References: <20211109000130.42361-1-hans-gert.dahmen@immu.ne>
 <YYoSPjF3M05dR0PX@kroah.com> <42cea157-55a2-bd12-335b-6348f0ff6525@immu.ne>
 <YYpNOMtp7Kwf0fho@kroah.com> <CAHifhD4f676jiQ52siiKQTjUFXFm6Sto8pQjF07w5y+gqrUvFQ@mail.gmail.com>
 <YYpsq/umygfTb8mM@kroah.com>
In-Reply-To: <YYpsq/umygfTb8mM@kroah.com>
From:   Hans-Gert Dahmen <hans-gert.dahmen@immu.ne>
Date:   Tue, 9 Nov 2021 15:10:15 +0100
Message-ID: <CAHifhD6K5hbpHS-X+2L=pfUe+7OpyTbB7uyh8WGbdaeBMwoYPg@mail.gmail.com>
Subject: Re: [PATCH] firmware: export x86_64 platform flash bios region via sysfs
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        Philipp Deppenwiese <philipp.deppenwiese@immu.ne>,
        Mauro Lima <mauro.lima@eclypsium.com>,
        Richard Hughes <hughsient@gmail.com>,
        platform-driver-x86@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Di., 9. Nov. 2021 um 13:42 Uhr schrieb Greg KH <gregkh@linuxfoundation.org>:
> ...
>
> Do you have a pointer to these complex and buggy drivers anywhere?

I am talking about the linux-mtd intel-spi driver for example, but I
feel that this gets the discussion in the wrong direction.

>
> > The situation is like, if you
> > have that CPU, you have the hardware, so it is implicitly bound or it
> > just will not execute on a machine code level.
>
> What do you mean "implicitly bound"?  How does this tie into the driver
> model such that it will only be autoloaded, and have the driver bind to
> the hardware, that it knows it can control?
>
> That is what needs to be fixed here, you are just claiming that it can
> talk to the hardware without having any check at all for this.

This memory mapping is magically provided by the thing on the CPU
front side bus, the south bridge f.e. It is there from the instant the
system powers on and it cannot be turned off. It is the CPU reset
vector that is used to boot any system. The memory range is required
by the x86_64 architectural specification. Every x86_64 system out
there has got it by definition. I do understand your concerns, but
this thing is a very special feature of the system architecture and so
the usual rules do not apply here.

>
> > I feel like your
> > requirement is somewhat impossible to satisfy and I really don't know
> > what to do. Please, can anyone help me by pointing out a proper
> > example elsewhere in the kernel?
>
> What resource in the system describes the hardware you wish to bind to?
> Write a driver for _that_ resource, and have it be properly autoloaded
> when that resource is present in the system.
>
> You have hundreds of examples running on your system today, but as I do
> not know where this hardware is described specifically, it's hard to be
> able to point you to an example that works like that.
>
> So again, what hardware signature describes the resource you wish to
> bind to?

As I said above the mapping is just required to be there but it is not
bound to any specific hardware. In practice every south-bridge on
every x86_64 mainboard in existence provides it. It does not have any
signature in a DMI table or a PCI ID or any of the like. It does not
need any descriptor because it is a given thing or the system could
not have booted. It is inherently tied to how the x86_64 architecture
works.
The only hardware dependency I can imagine there is, is that we are
running on x86_64. I have checked back with other developers and they
do agree. So is there a way to write a driver that is probed when we
are on a certain CPU architecture and that provides me a means to hook
into a probing flow where I can set up my sysfs default group to
safely add the attributes to userspace? Otherwise I'd say I am sure
that I understand your points and insist that the code is not broken
because of the very special circumstances.

Hans-Gert
