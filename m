Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6674A320C0F
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Feb 2021 18:21:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230144AbhBURVO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Feb 2021 12:21:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230080AbhBURVM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Feb 2021 12:21:12 -0500
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A1D0C061574
        for <linux-kernel@vger.kernel.org>; Sun, 21 Feb 2021 09:20:31 -0800 (PST)
Received: by mail-lj1-x22c.google.com with SMTP id u4so51436087ljh.6
        for <linux-kernel@vger.kernel.org>; Sun, 21 Feb 2021 09:20:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1n2zpG7cHXlB4u2S86Y+gInpnLD+p104QKzinp9h42Y=;
        b=dkbcdUj3grPtP7YR+RIgiBnrrU0KMLtqsmUi9119oi4tP+hBtquamOBS+QTnZI7HPV
         bzWbtDQoPzf2XZBko1ommZdxvdWOB2BP73/xzPi3E+gGiHN6J5G00JoWnpSvGXDRwDyH
         JUZAwdoMEwqEMoQMK6MZbSg0rz6mnd1zB0o3E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1n2zpG7cHXlB4u2S86Y+gInpnLD+p104QKzinp9h42Y=;
        b=FK7F93eLMX2QJ3RTT7ElOjFk2nIG0bxkOb+6Cym24RZzqGp4wd+q9WRrKr7dywOGG3
         58bc01zLXdndcbbj07rrhncCSPHnNj2qjG64vJTUxa2aBMapHWGqKiKQ0b0ZKLu3IsuS
         Zf6KAnukslhdlC8500yVLihAOne+HJnER6LHiNRhrT8txhTCiRjQS2xchffAloZZyWle
         ynFuiLv/0yoBx+S81Kl3J6fhJF01Llr2BXl5IL2Rz6RYDGqsJcgtAB5n+1O3PIibR9q2
         EsRDVc0naOCgh46lHnYAt+YF6gHwcAsrINkmL3GOPetmT1N0Vx/NTMJmn644VLYG7uhX
         Ueng==
X-Gm-Message-State: AOAM532VBXK+559bmjSb+U82Z2SrE+ZhW2FuSTK7/v9qkbkwZRhawT2u
        PdIq2M8phNpedYOu+ZLxB1enby7TKUwpow==
X-Google-Smtp-Source: ABdhPJx+VOfRHCIjM0IZmNYmGoZZtsHnkc5lbvKaN2tj4XzWqOV7wO2h+E/xeYXzQEvzi+J4FgEe9w==
X-Received: by 2002:a2e:94c:: with SMTP id 73mr6535191ljj.229.1613928029240;
        Sun, 21 Feb 2021 09:20:29 -0800 (PST)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com. [209.85.208.176])
        by smtp.gmail.com with ESMTPSA id w21sm1619521lfe.33.2021.02.21.09.20.27
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 21 Feb 2021 09:20:28 -0800 (PST)
Received: by mail-lj1-f176.google.com with SMTP id a22so51374908ljp.10
        for <linux-kernel@vger.kernel.org>; Sun, 21 Feb 2021 09:20:27 -0800 (PST)
X-Received: by 2002:a2e:8255:: with SMTP id j21mr9188616ljh.507.1613928027705;
 Sun, 21 Feb 2021 09:20:27 -0800 (PST)
MIME-Version: 1.0
References: <0000000000001fb73f05bb767334@google.com> <0000000000000ca18b05bbc556d6@google.com>
 <CAHk-=wiEBTD884i-U9DU7aDdRxXuz66Q1r-rKTiJUzZoYFgp+g@mail.gmail.com>
 <YDFJKR5uG1N+g9TL@zeniv-ca.linux.org.uk> <YDFjNRv+DNL/Xh8W@zeniv-ca.linux.org.uk>
 <CAHk-=wgJuiASyuFSBR9GgN2iPSL7Ep7G_GR1kKsGTL=qhDTDUg@mail.gmail.com>
In-Reply-To: <CAHk-=wgJuiASyuFSBR9GgN2iPSL7Ep7G_GR1kKsGTL=qhDTDUg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 21 Feb 2021 09:20:11 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgquwCP3hd-v+kc9eAL71omFLgnBMrvrw=ix3gm5mnpwA@mail.gmail.com>
Message-ID: <CAHk-=wgquwCP3hd-v+kc9eAL71omFLgnBMrvrw=ix3gm5mnpwA@mail.gmail.com>
Subject: Re: WARNING in iov_iter_revert (2)
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     syzbot <syzbot+3d2c27c2b7dc2a94814d@syzkaller.appspotmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        snovitoll@gmail.com,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 20, 2021 at 4:45 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> I don't think the ttyprintk weirdness was intentional. I'd fix that,
> but in the meantime clearly we should make do_tty_write() protect
> against this insanity, and do something like
>
>    --- a/drivers/tty/tty_io.c
>    +++ b/drivers/tty/tty_io.c
>    @@ -961,6 +961,9 @@ static inline ssize_t do_tty_write(
>                 ret = write(tty, file, tty->write_buf, size);
>                 if (ret <= 0)
>                         break;
>    +            /* ttyprintk historical oddity */
>    +            if (ret > size)
>    +                    break;

Actually, we need to move the

                written += ret;

line up above this thing too, so that we get the expected insane
return value to user space.

Of course, if ttyprintk gets fixed, this is all moot, but I've applied
this patch for now (since I was doing Greg's tty pull).

I've marked it as "fixing" 9bb48c82aced ("tty: implement write_iter")
even if the real cause is much older - the WARNING is new.

             Linus

PS. Just lost power again. Oh joy.
