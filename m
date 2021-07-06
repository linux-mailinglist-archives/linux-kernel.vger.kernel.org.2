Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 285953BDC80
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jul 2021 19:52:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230192AbhGFRxB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jul 2021 13:53:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbhGFRxB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jul 2021 13:53:01 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3960AC061574
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jul 2021 10:50:21 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id nd37so35507845ejc.3
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jul 2021 10:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6DuWZClbtqSNRCL74r09dT/s/L0004bm2wkFZOdkvpw=;
        b=ZK5ph7qgcPxnERLJlXiaKwif1UGvAh0MNRyOUwu1anV3qdewHWs7RJ3fNaIC25N/eG
         VdPmq3DIY/QQbUTWx027eaOcuuwyDfEYrzkBpkUlTlnFgRgTy4yjpFYJUcksvve3frt4
         vmHo+Yb/TyQaXZYUfwNGSFUqJRGQeCexQh+rNcA4LZFZR3sK+Khuk7W5exjgrb8QuSuf
         NZbOIDiL/H/S7FwP80p3QyEEw81k6CnKxSVVqPevZ8OjHWnaa1BS0lZJpBOA/KEl3AKk
         I+O1ZbZXR+5aSWrFeGFM6Jcl9iJGm17EHYvA3SQmCPkaF5K+HU8aQjnvb6g7cER7cewK
         0jDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6DuWZClbtqSNRCL74r09dT/s/L0004bm2wkFZOdkvpw=;
        b=WNaiabA5Qa+cUp/YKoUjfVJiV8cVtSBh2APt/MRfzqel/hUZEQ1GDRlsEOMbhCxO8o
         vO9OAjnYBvTssvl1IdHRRcaYX5nigqkOUHpmpyho3DWjBnRyq/FLRD5fUdJ2TyAgMLbV
         VMW9yeiETwkwIeoylc59qp1HT/f9FGcXDk49J00enuDbEpRZM0nU5UfYAO2UJ5IZQoAQ
         pH0k0pV7qyqf5zoIlauJW8/s4n9nYCcfe7Dv3w0CuYbN4KJnK6lR/1bVfjIhkZFRqgM5
         oQtUOP5KsNsA5fAqcHFvALofvJfV6qc/LUCcn9jfb6gBhDQnWs4TRpDZP+ZcAIWZ5pJq
         Yx3w==
X-Gm-Message-State: AOAM530Te9mdFRrNuaHfIeaZz1HNCUzP/BljYZ8FB1U14iPRooFFB5Ql
        7qA2S6hbZqUtoXC489ZPKiC5Kyy8jx4YakEfi90=
X-Google-Smtp-Source: ABdhPJz9S+/08teCkrSYtov5TVXHjlhnkYqXtiynqti4U2t6y6GyLIbc6CDS+kdJpadP1XHXIbp3FuZ6ZiufSdFBQEs=
X-Received: by 2002:a17:906:5d12:: with SMTP id g18mr19803542ejt.186.1625593819751;
 Tue, 06 Jul 2021 10:50:19 -0700 (PDT)
MIME-Version: 1.0
References: <YJ4yBmIV6RJCo42U@google.com> <s5hk0o18tio.wl-tiwai@suse.de>
 <YJ5cHdv6MVmAKD3b@google.com> <YKDYQfDf7GiMfGCN@google.com>
 <YKDYbaprE3K2QpCe@google.com> <s5hbl9b6mah.wl-tiwai@suse.de>
In-Reply-To: <s5hbl9b6mah.wl-tiwai@suse.de>
From:   Max Filippov <jcmvbkbc@gmail.com>
Date:   Tue, 6 Jul 2021 10:50:08 -0700
Message-ID: <CAMo8BfKKMQkcsbOQaeEjq_FsJhdK=fn598dvh7YOcZshUSOH=g@mail.gmail.com>
Subject: Re: ALSA: intel8x0: div by zero in snd_intel8x0_update()
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        alsa-devel@alsa-project.org, Leon Romanovsky <leon@kernel.org>,
        Takashi Iwai <tiwai@suse.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Sun, May 16, 2021 at 2:50 AM Takashi Iwai <tiwai@suse.de> wrote:
>
> On Sun, 16 May 2021 10:31:41 +0200,
> Sergey Senozhatsky wrote:
> >
> > On (21/05/16 17:30), Sergey Senozhatsky wrote:
> > > On (21/05/14 20:16), Sergey Senozhatsky wrote:
> > > > > --- a/sound/pci/intel8x0.c
> > > > > +++ b/sound/pci/intel8x0.c
> > > > > @@ -691,6 +691,9 @@ static inline void snd_intel8x0_update(struct intel8x0 *chip, struct ichdev *ich
> > > > >         int status, civ, i, step;
> > > > >         int ack = 0;
> > > > >
> > > > > +       if (!ichdev->substream || ichdev->suspended)
> > > > > +               return;
> > > > > +
> > > > >         spin_lock_irqsave(&chip->reg_lock, flags);
> > > > >         status = igetbyte(chip, port + ichdev->roff_sr);
> > > > >         civ = igetbyte(chip, port + ICH_REG_OFF_CIV);
> > >
> > > This does the problem for me.
> >
> >        ^^^ does fix
>
> OK, thanks for confirmation.  So this looks like some spurious
> interrupt with the unexpected hardware bits.
>
> However, the suggested check doesn't seem covering enough, and it
> might still hit if the suspend/resume happens before the device is
> opened but not set up (and such a spurious irq is triggered).
>
> Below is more comprehensive fix.  Let me know if this works, too.
>
>
> thanks,
>
> Takashi
>
> -- 8< --
> Subject: [PATCH] ALSA: intel8x0: Don't update period unless prepared
>
> The interrupt handler of intel8x0 calls snd_intel8x0_update() whenever
> the hardware sets the corresponding status bit for each stream.  This
> works fine for most cases as long as the hardware behaves properly.
> But when the hardware gives a wrong bit set, this leads to a NULL
> dereference Oops, and reportedly, this seems what happened on a VM.
>
> For fixing the crash, this patch adds a internal flag indicating that
> the stream is ready to be updated, and check it (as well as the flag
> being in suspended) to ignore such spurious update.
>
> Cc: <stable@vger.kernel.org>
> Reported-by: Sergey Senozhatsky <senozhatsky@chromium.org>
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> ---
>  sound/pci/intel8x0.c | 7 +++++++
>  1 file changed, 7 insertions(+)

linux v5.13 booting on qemu-system-xtensa virt board gets stuck inside
snd_intel8x0_probe -> intel8x0_measure_ac97_clock with this patch.
Prior to it it boots successfully for me.
I'm curious if this issue has been reported yet.

What I see is an IRQ flood, at some point snd_intel8x0_interrupt
and timer ISR  are called in loop and execution never returns to
the interrupted function intel8x0_measure_ac97_clock.

Any idea what it could be?

--
Thanks.
-- Max
