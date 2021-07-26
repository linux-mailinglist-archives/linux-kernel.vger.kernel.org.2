Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 172E33D52C6
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 07:16:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231421AbhGZEfw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 00:35:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbhGZEfv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 00:35:51 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CE9FC061757
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jul 2021 22:16:20 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id t66so7799062qkb.0
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jul 2021 22:16:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XygC5wCkMDbFQQ9ce88kjiV4VAshB5QTsAEs+cXfzBo=;
        b=V8MXuFFKyGipObIamnLlOLefvbGxx8fkYXPtJXfQaR6zPfL/sGcnUox+MUW6t3kNhX
         BJw+rGDeH1JGkQSSG5zJynhThfUINGX2dPi+NCPN48fkRyFn+aFXi/AcO/7cJJDAM5DF
         AL6dsSpy2Ahm28uUQTYOAWlKSxNTTN0m+9KeJCuV4LpaNH9lEDGYei1zpZngRnyIGv16
         jXfdiwJK+om/0/+qnATixilPqLd6igKtGOdGYMjTe62l4xcIMK/4sYegrpvGoyHBq7pP
         l5uhhjp/yZ3Xus6oGwGx6pPMBDxHUpsiKqatKgzcknjU0EAzy2OyVNe2zzIyeK0md5Bl
         6+Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XygC5wCkMDbFQQ9ce88kjiV4VAshB5QTsAEs+cXfzBo=;
        b=G4YywF0logpbd1xvNXRVX2B4cyBAr/kH1EuvFzOqELYJdy3L2FkMot5pqNcQ3phhhN
         LRo77TWjc9nXbW5OZDBIW7bD4l1i2t/CmZNhGd2M7bvxXE6t7hjelcVxEcHhabx18/Pu
         sGpefThqfOhae9xykuSeQDzEzyJ8HLlETRdeHFWwpq8X51f0B6UsJAvSzfHoBEolx926
         QrNGoeO7Vbqeu+EPShce8VVBz3s63C2PkVmdBaKZp4xOdJ2/DraM6tJdj53uyw4fo4DJ
         YQgiiuq4VrhztwpcVTAfo6ojpah2QQdfWVISjuLFAkKf1uzg+tRo3SHpQo301Vg8a7Ov
         Xj5Q==
X-Gm-Message-State: AOAM533dDaVqyz6nFtzoZ9SidHtZya9uU/qTWzE9tLz/HBGHnB9NHFh/
        w8WtgTM07H2gdkw4l1CjrqJ5emOLGXW2vs7Rv2I=
X-Google-Smtp-Source: ABdhPJxvuO0i1cOxHKEIeKjGh7PuOqW1BCoICcn1IG0kXrcAMZC5H6irn+d1FLDu5WKxOfVJpitbnWiFrFfoLek0xww=
X-Received: by 2002:a05:620a:1278:: with SMTP id b24mr15914369qkl.250.1627276579628;
 Sun, 25 Jul 2021 22:16:19 -0700 (PDT)
MIME-Version: 1.0
References: <1627100621-19225-1-git-send-email-chihhao.chen@mediatek.com>
 <s5h7dhgi1e2.wl-tiwai@suse.de> <CAEsQvcs3P+TqQFzQetPfRycpo66eJFwnzwhk2JyCXFaCLFHmFg@mail.gmail.com>
 <s5hwnpehm7y.wl-tiwai@suse.de>
In-Reply-To: <s5hwnpehm7y.wl-tiwai@suse.de>
From:   Geraldo Nascimento <geraldogabriel@gmail.com>
Date:   Mon, 26 Jul 2021 02:16:11 +0000
Message-ID: <CAEsQvcumEDOKgUB6h2-im5QabhPfaSaU63RF8pegPt5ZCPx+Pw@mail.gmail.com>
Subject: Re: [PATCH] ALSA: usb-audio: fix incorrect clock source setting
To:     Takashi Iwai <tiwai@suse.de>
Cc:     chihhao.chen@mediatek.com, alsa-devel@alsa-project.org,
        wsd_upstream@mediatek.com, damien@zamaudio.com, tiwai@suse.com,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        matthias.bgg@gmail.com, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 25, 2021 at 7:44 AM Takashi Iwai <tiwai@suse.de> wrote:
>
> On Sat, 24 Jul 2021 17:04:13 +0200,
> Geraldo Nascimento wrote:
> >
> > On Sat, Jul 24, 2021 at 8:05 AM Takashi Iwai <tiwai@suse.de> wrote:
> > >
> > > This looks like a regression introduced by the recent commit
> > > d2e8f641257d ("ALSA: usb-audio: Explicitly set up the clock
> > > selector"), which is a fix for certain devices.  Too bad that the
> > > behavior really depends on the device...
> >
> > Dr. Iwai, perhaps we could restrict the generalized fix for the
> > Behringer UFX1604 / UFX1204 with some simple logic to devices that
> > only have *one* clock source.
> >
> > In that case the clock selector must be set to the only clock source.
> >
> > This way we keep the generalization without breaking devices with more
> > than one clock source.
> >
> > Just an idea.
>
> I don't think it's easy to generalize.  All those bugs are more or
> less BIOS bugs, and a logic doesn't apply always, just because it's a
> bug :)  For example, setting the clock selector itself should be a
> valid operation from the specification POV, while this leads to
> breakage on some devices.  So, even if we add a more generic
> workaround, we need to see which side effect is more commonly seen at
> first.
>
>
> Takashi

Hello,

Like I said in one of the other emails in this thread, it's hard to
pinpoint a cause for the breakage of Samsung USBC Headset (AKG) with
VID/PID (0x04e8/0xa051) without the lsusb -v of the device in
question.

But from the description Chihhao Chen gave in the original message,
I'm *guessing* the Clock Source for the Samsung USB Headset (AKG) runs
at 48000hz and that we'd see a 2x Clock Multiplier in the lsusb -v

This is all a wild guess, without the lsusb -v it's impossible to be
sure, but if I'm right then the valid setting for the Microphone's
Clock Selector is the Clock Multiplier, not the Clock Source, which,
remember, runs at half the clock, hence why Chihhao Chen sees half the
data rate for USB IN.

Unfortunately our kernel code presently *does* always set the Clock
Selector to the Clock Source, which is a bad assumption to make in my
humble opinion.

The only valid case for setting the Clock Selector to the Clock Source
is when there's precisely one Clock Selector, precisely one Clock
Source and no Clock Multipliers.

In that special case we may be able to touch the setting of the only
Clock Selector to match the only Clock Source.

And, frankly, the only reason we're forced to do that explicitly is
because some Behringer gear (Archwave AG DACs) gets confused and seems
to somehow keep the old rate on the Clock Selector upon sample rate
change.

Thank you,
Geraldo Nascimento
