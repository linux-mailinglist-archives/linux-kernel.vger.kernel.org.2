Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AC2944EB04
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Nov 2021 17:05:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235284AbhKLQIL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Nov 2021 11:08:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235256AbhKLQIJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Nov 2021 11:08:09 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59CC6C061766
        for <linux-kernel@vger.kernel.org>; Fri, 12 Nov 2021 08:05:18 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id b15so39365959edd.7
        for <linux-kernel@vger.kernel.org>; Fri, 12 Nov 2021 08:05:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BsZMys5WNyqk7+eesMlJ0N4sIj1/7PpfJUrs7lTDm78=;
        b=qSe5dncvcro+nK81vw/dpUP7DK9mDBMm1Oq2cUYzxGBclz+xQIBFN753+BejD6xfmj
         wwS/37uCdl+M3JvfhLpOdvVOm2A+tlkEDDdpC74HBr/vVh/ya7EfKxZPBspz+OeF0Wgw
         CBgAbd8EFuGRGD6CyEwuDEamu799G1gUUp/e44B0nxNx/++a2sVdJ2JjO7l3Iga1Sn/P
         c4zeNTM6FI2qd7iRThz/PtrcJjWAUr2/UZqF2QIHsVCjRf+++tKAks+5TFlOnStJNoJr
         8S9XS2dhVUhyzrrO5JDqZ+zRsd+8bKWRBsf7cTd6SU+trDb7GKMMSfBfln3bkItL8QdV
         lGRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BsZMys5WNyqk7+eesMlJ0N4sIj1/7PpfJUrs7lTDm78=;
        b=X3fliv/DPJpBNHbB+HBr4O12+PVHUS1R6Qk9iMGAJXta05sm9yz36/V2NFKZn58tzj
         ww+Y+xPUDdBGS9hBdKy4VUkcG0iN/EzwmwpNHzjQb9mf5MQuc2FAX8bW6P++abxQy5yv
         1J0TLRPkX0bKHbwuXcp5LbEjY4PEfO5hk+3gfzb2PekF/Bf+roRqj6dw3Oq6KNxxkTn9
         PWt0ixTYliG2Lvp6C0nJstqmM0do586ltCo5jBcrcPF73UUD8bICAXCNNwertVzrX4uY
         bu2tAyAbNtN/zfBJxUux1h6lXKxzvH7xR4kF0n1jlRGdbBQxl1rE78yTRsMPwNxVvxxh
         LHHw==
X-Gm-Message-State: AOAM530bs27rEvZv7iD9cR5hhgmTV+6iqhxLUl8zM4zm9pZUPtj6nqDa
        thju3F0XjLseqTG/2qGxfuY=
X-Google-Smtp-Source: ABdhPJyGMUgrfNLQeMjQE9dHheGptOccfM+CZnYN3cHCLob+EPYizaEguAOkNSfiCV6ZGw6pgQ9Grg==
X-Received: by 2002:a50:d49d:: with SMTP id s29mr9137023edi.55.1636733116918;
        Fri, 12 Nov 2021 08:05:16 -0800 (PST)
Received: from localhost.localdomain (host-82-61-38-115.retail.telecomitalia.it. [82.61.38.115])
        by smtp.gmail.com with ESMTPSA id hc16sm2772058ejc.12.2021.11.12.08.05.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Nov 2021 08:05:16 -0800 (PST)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Marco Elver <elver@google.com>
Cc:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        syzbot <syzbot+5f47a8cea6a12b77a876@syzkaller.appspotmail.com>
Subject: Re: [syzbot] BUG: sleeping function called from invalid context in __might_resched
Date:   Fri, 12 Nov 2021 17:05:14 +0100
Message-ID: <1805242.PYQNYDVmnG@localhost.localdomain>
In-Reply-To: <CANpmjNMg62oXEQpuSccZdv-cx9txy2TH_4FQphaLEpSQTqZ1cQ@mail.gmail.com>
References: <000000000000f43bb905d06c8b7f@google.com> <8755565.Ff9ToCiNAG@localhost.localdomain> <CANpmjNMg62oXEQpuSccZdv-cx9txy2TH_4FQphaLEpSQTqZ1cQ@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, November 12, 2021 2:58:14 PM CET Marco Elver wrote:
> On Fri, 12 Nov 2021 at 13:22, Fabio M. De Francesco
> <fmdefrancesco@gmail.com> wrote:
> [...]
> > I think that this "BUG" is a false positive.
> >
> > In do_con_write(), Just before the call of console_lock() there is an
> > in_interrupt() check that, if it evaluates to true, makes this function 
to
> > return "count" and prevents the SAC bug.
> 
> It's not complaining about being in an interrupt, but rather
> interrupts disabled, i.e. still an atomic context.

Yes, still in an atomic context. 

Actually, I've never talked about being "in an interrupt", but I've just said 
that the in_interrupt() macro prevents to fall into the code that might 
sleep. 

Now I suppose that this is the place for in_atomic(). Isn't it?

I wrongly thought that in_interrupt() returns non-zero from any kind of 
atomic context.

Thanks,

Fabio

> > >  do_con_write+0x10f/0x1e40 drivers/tty/vt/vt.c:2908
> > >  con_write+0x21/0x40 drivers/tty/vt/vt.c:3295
> > >  n_hdlc_send_frames+0x24b/0x490 drivers/tty/n_hdlc.c:290
> > >  tty_wakeup+0xe1/0x120 drivers/tty/tty_io.c:534
> > >  __start_tty drivers/tty/tty_io.c:806 [inline]
> > >  __start_tty+0xfb/0x130 drivers/tty/tty_io.c:799
> > >  n_tty_ioctl_helper+0x299/0x2d0 drivers/tty/tty_ioctl.c:880
> 
>        ^^ n_tty_ioctl_helper() disabled interrupts via
> spin_lock_irq(&tty->flow.lock)
> 




