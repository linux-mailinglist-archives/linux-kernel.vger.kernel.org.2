Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1976A3207DA
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Feb 2021 01:48:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229863AbhBUAqr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Feb 2021 19:46:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229811AbhBUAqk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Feb 2021 19:46:40 -0500
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF080C061574
        for <linux-kernel@vger.kernel.org>; Sat, 20 Feb 2021 16:45:59 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id u4so44386848ljh.6
        for <linux-kernel@vger.kernel.org>; Sat, 20 Feb 2021 16:45:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZH9LxqmdK4WuGCkSanDTOuYEMBk6Ae5+wTyCpsy2cQ0=;
        b=KH3Zy4AmYAnSUiR8Z0SlgMZdokgu/97Q1tbAKHOQ/3KCSD8MC2z00FJLXqx8XpPPN+
         wwbs+442hga5jO/x2Z2lOibpainN4le+ACi2knTBFTwbsqOMEjx0MQpIgBJlMYb/pZXu
         tH8rjYArrknBZHuCOEEnxQslWyWdKN+Q3RFPs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZH9LxqmdK4WuGCkSanDTOuYEMBk6Ae5+wTyCpsy2cQ0=;
        b=AN8a+TYX58pkTiy/Ye/+QkSbvy+IKI8/5JmLz+XZYVqSuCS0vPehlgYfU7BnZ0aij4
         Ev74zBBWWuREUKMcDFMw3YOH59Ir5NaXeviKZ9w3QMmcJ64WuoEWt+4gM/uVoJehYOTG
         fqVxDF058Wqp48Qx+3pjMaXRJbdM3sKd6CKcDn6KYmOuDdc3xCgZtGMtnFmEKbffq7BS
         pwLA4X+rFJkZPaXrRAB9Ybj93V2raqi9vkGKfN94lU836Nxa7UsB4UIM8+Varp2kFPve
         sZnLK/z/4hrQRAh6IQxqvLCips8ZzJQSqwx76iAILcRCN6CCl4N2DFqmC1MA238w6dAg
         +C9w==
X-Gm-Message-State: AOAM5329IvCLzYAG6xLjGug8R2ixZjvG7FIrGW8Xi/63KOS6B28C4DTf
        /Pi+C2Ao9UvHjuUXxlXJgiIkmBs+uwq3lA==
X-Google-Smtp-Source: ABdhPJw4ExKyEBBwwkKewJCB/H0iLA2O90Dvd+SpmMWhFT7D527q8lyTUTgEuAfSIn3tH4E/iPmz5A==
X-Received: by 2002:a05:6512:519:: with SMTP id o25mr9819709lfb.529.1613868357772;
        Sat, 20 Feb 2021 16:45:57 -0800 (PST)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com. [209.85.208.173])
        by smtp.gmail.com with ESMTPSA id k9sm1474766ljg.59.2021.02.20.16.45.56
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 20 Feb 2021 16:45:57 -0800 (PST)
Received: by mail-lj1-f173.google.com with SMTP id c17so44460341ljn.0
        for <linux-kernel@vger.kernel.org>; Sat, 20 Feb 2021 16:45:56 -0800 (PST)
X-Received: by 2002:a2e:3910:: with SMTP id g16mr9773864lja.61.1613868356421;
 Sat, 20 Feb 2021 16:45:56 -0800 (PST)
MIME-Version: 1.0
References: <0000000000001fb73f05bb767334@google.com> <0000000000000ca18b05bbc556d6@google.com>
 <CAHk-=wiEBTD884i-U9DU7aDdRxXuz66Q1r-rKTiJUzZoYFgp+g@mail.gmail.com>
 <YDFJKR5uG1N+g9TL@zeniv-ca.linux.org.uk> <YDFjNRv+DNL/Xh8W@zeniv-ca.linux.org.uk>
In-Reply-To: <YDFjNRv+DNL/Xh8W@zeniv-ca.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 20 Feb 2021 16:45:40 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgJuiASyuFSBR9GgN2iPSL7Ep7G_GR1kKsGTL=qhDTDUg@mail.gmail.com>
Message-ID: <CAHk-=wgJuiASyuFSBR9GgN2iPSL7Ep7G_GR1kKsGTL=qhDTDUg@mail.gmail.com>
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

[ Let's see how long this lasts, but I've got a generator for the
laptop, and hopefully I'll be able to start doing pulls tonight, and
get "real" power tomorrow ]

On Sat, Feb 20, 2021 at 11:30 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> IOW, it's not iov_iter_revert() being weird or do_tty_write() misuing it -
> it's tpk_write() playing silly buggers.

Ok, that's actually not as bad I was was afraid it might be.

> Do we want to preserve that weirdness of /dev/ttyprintk writes?
> That's orthogonal to the iov_iter uses in there.

I don't think the ttyprintk weirdness was intentional. I'd fix that,
but in the meantime clearly we should make do_tty_write() protect
against this insanity, and do something like

   --- a/drivers/tty/tty_io.c
   +++ b/drivers/tty/tty_io.c
   @@ -961,6 +961,9 @@ static inline ssize_t do_tty_write(
                ret = write(tty, file, tty->write_buf, size);
                if (ret <= 0)
                        break;
   +            /* ttyprintk historical oddity */
   +            if (ret > size)
   +                    break;

                /* FIXME! Have Al check this! */
                if (ret != size)

in there. Because right now we clearly do strange and not-so-wonderful
things if the write routine returns a bigger value than it was
passed.. Not limited to that iov_iter_revert() thing, but the whole
loop.

Comments?

              Linus
