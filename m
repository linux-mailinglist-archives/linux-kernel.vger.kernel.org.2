Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1757E44E804
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Nov 2021 14:58:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234909AbhKLOBS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Nov 2021 09:01:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231131AbhKLOBR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Nov 2021 09:01:17 -0500
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 759A7C061766
        for <linux-kernel@vger.kernel.org>; Fri, 12 Nov 2021 05:58:26 -0800 (PST)
Received: by mail-oi1-x234.google.com with SMTP id u74so17998941oie.8
        for <linux-kernel@vger.kernel.org>; Fri, 12 Nov 2021 05:58:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jubXVRaV+MsgIOXu9jsAxTKvJUXrL7es6m68YCoSWeg=;
        b=bGH8g6EtUP2bepnQNMzIv0j/Uzyu4eSBibOdzY9BDkrWhY7RtqlWUGM/K/jPzTElQP
         bkolBgnlmf/wTfcsQGGkwgs6Zvui2fNVZ0uhSVtblYrT7xQlwjN3QVTE1j4UD1jepO3R
         ExtP15dLoN0vJ8tqq57xpxc3GuB2QXk1MbxAb4rGv0+SdboF3p1c0XbmNHOvMLUQ42n3
         zyazCVs28Cd7odI0JSta2QSS1S7cq8J0GfHLVVZzS9cgXeke36fviaDbSY3Kn/YWJfYq
         qOq8t8aqBM1AuV2pD3pDxTH3hUTThLLAklfAeobE1Vsmxa2SA6LAeeM0B9xGdQxD9ALN
         qHyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jubXVRaV+MsgIOXu9jsAxTKvJUXrL7es6m68YCoSWeg=;
        b=iDBIpKkVyOvIJFEXVPYYgLmW4h1D91OW0k/LtGFymdP/f+VCXb+zl5ILvu0/28AXJA
         KXHBmxmccMjRTwmT5LoPm5+A2rJrpuMzWgTe4m9jQ+PObZkLC5xbxH+vNn41T7+QRfth
         8yWE5WC1qn4Fcy4JyTt1rC0Rp+q36ws3nXxJcswLglnzMqLte1Pj+AWJnrKljqBexNUS
         HfSy73L+e2gUTrD/LVmE1MrE3hyWGpeOFaODYKM73cqTHqjh0u0DS51xIYBSyb4ieYfQ
         Bx01VsYYJmWEwkwibSh3hJjMNMFObHmjxoPAiE5jUD2kUYyS+hB9vVeGREmc3lPQnzJd
         FvDg==
X-Gm-Message-State: AOAM532PfPKi2yR8atzT1aIL24iHK1tsJyVyXmlhJlzVpsE1xYcDX5M8
        lSuHav8Wr8/NkHJuEfRZZJhJRHIWFk8EZGYbx95pLg==
X-Google-Smtp-Source: ABdhPJwlnoboPOKYxbOI93KI/Xl0ePs9TBxUJYnUxvtDtOmNFiiBhrafMYQ1dBFJ9oaKhtmoFUJWcSoDUto26aa+Qj4=
X-Received: by 2002:a05:6808:118c:: with SMTP id j12mr12778376oil.65.1636725505636;
 Fri, 12 Nov 2021 05:58:25 -0800 (PST)
MIME-Version: 1.0
References: <000000000000f43bb905d06c8b7f@google.com> <8755565.Ff9ToCiNAG@localhost.localdomain>
In-Reply-To: <8755565.Ff9ToCiNAG@localhost.localdomain>
From:   Marco Elver <elver@google.com>
Date:   Fri, 12 Nov 2021 14:58:14 +0100
Message-ID: <CANpmjNMg62oXEQpuSccZdv-cx9txy2TH_4FQphaLEpSQTqZ1cQ@mail.gmail.com>
Subject: Re: [syzbot] BUG: sleeping function called from invalid context in __might_resched
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        syzbot <syzbot+5f47a8cea6a12b77a876@syzkaller.appspotmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Nov 2021 at 13:22, Fabio M. De Francesco
<fmdefrancesco@gmail.com> wrote:
[...]
> I think that this "BUG" is a false positive.
>
> In do_con_write(), Just before the call of console_lock() there is an
> in_interrupt() check that, if it evaluates to true, makes this function to
> return "count" and prevents the SAC bug.

It's not complaining about being in an interrupt, but rather
interrupts disabled, i.e. still an atomic context.

> >  do_con_write+0x10f/0x1e40 drivers/tty/vt/vt.c:2908
> >  con_write+0x21/0x40 drivers/tty/vt/vt.c:3295
> >  n_hdlc_send_frames+0x24b/0x490 drivers/tty/n_hdlc.c:290
> >  tty_wakeup+0xe1/0x120 drivers/tty/tty_io.c:534
> >  __start_tty drivers/tty/tty_io.c:806 [inline]
> >  __start_tty+0xfb/0x130 drivers/tty/tty_io.c:799
> >  n_tty_ioctl_helper+0x299/0x2d0 drivers/tty/tty_ioctl.c:880

       ^^ n_tty_ioctl_helper() disabled interrupts via
spin_lock_irq(&tty->flow.lock)
