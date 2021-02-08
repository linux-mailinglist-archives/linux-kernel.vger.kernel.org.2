Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5184B3128E2
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 03:20:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbhBHCTW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Feb 2021 21:19:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbhBHCTT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Feb 2021 21:19:19 -0500
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0408C06178A
        for <linux-kernel@vger.kernel.org>; Sun,  7 Feb 2021 18:18:39 -0800 (PST)
Received: by mail-io1-xd2e.google.com with SMTP id u8so13356393ior.13
        for <linux-kernel@vger.kernel.org>; Sun, 07 Feb 2021 18:18:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to;
        bh=J6sjjEGjfADY4vZtjQCJ46nWlyZNjX5V4f6ytqlF/5M=;
        b=uB4fPZLEdLn9XfrLJ32vRuUPmqc1WKnxtw+JZj1FSKdKnSdm+LFllOQ7O1GFPe8VDK
         rc5nfBjK3jSkaSZyFFFAUf03r4Ae3TacNBySloX8QFR2uU2wRwHpD0KagkqTSxHpf9W8
         HZNlqNXznGGki+OGcrO3pdyR9IfSUdggtFU6Vob90/W5DdSsLfBkqwjLQNua4Msvfe40
         UN/WfysuvDlU+e9LCj4MhWcN16uQQ2YGHHpeSDWT0LyNoQwjb3TelbX0X+0imp0ac+kM
         TExcwmM3z8Lu6Ul5hHxd96s7fR39dfFfxkvQ41TnajKV1NJsQVTG5sG/oF/MEImltqoT
         4CTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to;
        bh=J6sjjEGjfADY4vZtjQCJ46nWlyZNjX5V4f6ytqlF/5M=;
        b=D6bIeOj20mpLyeIGvZEBFFfCP5dwokV5wCoaoa9WGDEoUftdowMeqDoeGGIT0dAZLo
         MaPdsfMKCdAW+9yN7ZUdHGfQ2lPRROnKKGsX/CD9XZ9tIOx5wGwsnnFYedko0kPzEH2Y
         AicEcTrlLqdErebQ3gDaq4MjKGM73oaJjQu95lOhPUojmYzpikbWSTivUoit6gsofpha
         uVtsUtgDO53vXSrAHMu8CXBuo+LN8Zu136lMohHt99aSTVaj/+rhB1OcdR84JPVLwB6D
         yBVoNW6/hQfDLm6jkDoYVADfBayjJGKShHw0CYyH1qRk8FRhn2SAvtiS6YdzAo/vze4j
         ZMWw==
X-Gm-Message-State: AOAM5309LrdS1wKGCetOjZTsywbmyQFHHpzpbVoGYTCU4tae//BFmZFI
        OPwdOn1mB4JfZoqwxEiFKCi1ojACHsVSbLlgj2ZJCL3XHpI=
X-Google-Smtp-Source: ABdhPJzDLwV2caKR9rf/wJkMd2Rl3Ai0i8VbS16F932xFK5bWcEJ9XPTI2h88YXtrFQ1B9fpWJezuHTfzyyM7+g2ymo=
X-Received: by 2002:a05:6638:3795:: with SMTP id w21mr15443221jal.65.1612750719231;
 Sun, 07 Feb 2021 18:18:39 -0800 (PST)
MIME-Version: 1.0
References: <CA+icZUUhzpmoD_XrHtnFUGSpXHrVOTnVG9Q_Tek8oA8isHZe=Q@mail.gmail.com>
 <YCB3cd/XjYnoOBxE@OpenSuse>
In-Reply-To: <YCB3cd/XjYnoOBxE@OpenSuse>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Mon, 8 Feb 2021 03:18:28 +0100
Message-ID: <CA+icZUWbN3WaD-UyVB4yswi5f-kEcG+Zci4giR_ku+k+da2WFA@mail.gmail.com>
Subject: Re: [Linux v5.11-rc7] x86: entry: Leftover of _TIF_SINGLESTEP define?
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kyle Huey <me@kylehuey.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 8, 2021 at 12:27 AM Bhaskar Chowdhury <unixbhaskar@gmail.com> wrote:
>
> On 00:08 Mon 08 Feb 2021, Sedat Dilek wrote:
> >Hi,
> >
> >congrats to Linux v5.11-rc7.
> >
> >after commit 6342adcaa683 ("entry: Ensure trap after single-step on
> >system call return"):
> >
> >$ git grep '\_TIF_SINGLESTEP' arch/x86/
> >arch/x86/include/asm/thread_info.h:#define _TIF_SINGLESTEP
> > (1 << TIF_SINGLESTEP)
> >
> Does it failed the build???
>
> Just curious??
>

No, it is simply a leftover.
Kyle confirmed.

I was able to build and boot into bare metal.


- Sedat -

> >Is this a leftover and can be removed (now)?
> >
> >Thanks.
> >
> >Regards,
> >- Sedat -
> >
> >[1] https://marc.info/?l=linux-kernel&m=161273724611262&w=2
> >[2] https://git.kernel.org/linus/6342adcaa683
