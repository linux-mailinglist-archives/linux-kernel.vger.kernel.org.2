Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 161E1333A38
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 11:41:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231492AbhCJKlT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 05:41:19 -0500
Received: from mail-vs1-f46.google.com ([209.85.217.46]:38467 "EHLO
        mail-vs1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230525AbhCJKk7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 05:40:59 -0500
Received: by mail-vs1-f46.google.com with SMTP id e21so6471347vsh.5;
        Wed, 10 Mar 2021 02:40:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=A3HwYVod5TOKRztYfZ5qITnVIC4tyRTRWsk+gg9JXNM=;
        b=oW/QHGDKLMzID4zTdSbTcbrhij+U6ffmZ8b4XTgox7tR++8tnyq20bA2taYHDA4ulQ
         4RIoo/5g4S2a0q3D+3PDzYLf/j2dgDW4RFyYUQtH/94C9EHwwW5g1+AH9cRDUEsr79Zu
         jF03IvGyVM7nYsCSVMVoLuicWyiVzhuQEL4SxEqgjzAT3VsyzzU2w8MKh4/Y2JuGzeSl
         kE63dIMPzt2+s+4XsPa+8bcizytEUy9f1DZBr1XAR83H8MQDwQt3Rv8BFQPHkEyreDxA
         2u4rmcpFL4UHOpxtlp3/7gphfsuhT03Xr0j8TuLbD9IbbsY6b0kxD8Nslz0ZaHFwm2q3
         ol+A==
X-Gm-Message-State: AOAM532oCKvTKkjEsUdA3e74AFq6K793uOw1GtStgpJSJnustcZldhK1
        v+gOt4o3mWhl16meFnXGMeogIASDXhOnKNr3SQo=
X-Google-Smtp-Source: ABdhPJyu8XyeCmhpXiJPJj3U/OPCe/KwuX/xfvAEkczLsuVS5aBfKCBjtBy/V6Veyr0XJFIYYgQtiOyREgjkdSOYp2I=
X-Received: by 2002:a67:8883:: with SMTP id k125mr1358079vsd.18.1615372858427;
 Wed, 10 Mar 2021 02:40:58 -0800 (PST)
MIME-Version: 1.0
References: <37859f29-dc59-d6c2-6f92-abaae32ee4ab@physik.fu-berlin.de>
 <20210309.110812.234617387417457658.davem@davemloft.net> <CAHk-=whgiPiFy9Ye_t=fV9J8VdqgZW5XQcb-1z8PgpQbVBWqCQ@mail.gmail.com>
 <20210309.162454.822491855062735992.davem@davemloft.net>
In-Reply-To: <20210309.162454.822491855062735992.davem@davemloft.net>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 10 Mar 2021 11:40:47 +0100
Message-ID: <CAMuHMdXAZzURKDWuLdUM=YZ8_OoYQAPuho8Qg3ckv3nkOujk4A@mail.gmail.com>
Subject: Re: [GIT] SPARC
To:     David Miller <davem@davemloft.net>
Cc:     "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        sparclinux <sparclinux@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

Good to see you're back!

On Wed, Mar 10, 2021 at 1:27 AM David Miller <davem@davemloft.net> wrote:
> From: Linus Torvalds <torvalds@linux-foundation.org>
> Date: Tue, 9 Mar 2021 11:27:41 -0800
> > On Tue, Mar 9, 2021 at 11:08 AM David Miller <davem@davemloft.net> wrote:
> > (And yes, I prefer lore.kernel.org over marc, although for single
> > patches it doesn't make much of a difference. For patch series, I find
> > 'b4' so convenient that I definitely want the patch to show up on
> > lore.kernel.org).
>
> Sadly, lore does not archive sparclinux@vger.kernel.org, so there
> isn't much choice in this case.

Which is only an "ask Konstantin" (CCed) away, isn't it?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
