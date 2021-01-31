Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C23B5309F9A
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 00:57:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229926AbhAaX5H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jan 2021 18:57:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbhAaX44 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jan 2021 18:56:56 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24BE3C061573
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jan 2021 15:56:14 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id a12so20378699lfb.1
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jan 2021 15:56:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yRoG5qVuxYKudfRmW0vqrzuE2IgF/ZVOGkujh8O168s=;
        b=Wb1bWoEBRs+EDZTJX4jLJucJ8zHUULtPY6M3Sr8oyEbYzHf8h5KMedkvxLdFh8SUzi
         J5CJO4RISE+uEPslRqXACZMIyp5D34On2lLMtRSk+ZuDHYNrMWjCpo1Uw96uIcNCS7xN
         PBIr3o5yQGrrSQBXmN5w30dHWXglXwecX8EqA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yRoG5qVuxYKudfRmW0vqrzuE2IgF/ZVOGkujh8O168s=;
        b=JxIeoO1fkyYfpuLcXgHMt+qBwJjDtIOu9xmOrbE013vkll1cV1FYJxGSWxLBag7S9F
         jI2xbeOPmIfP/E0lV5a+OoNP//kFjEl+Kftx5cqUe0JJeI72l8H/beFRHqaRaJYHikWe
         9MG7u31dAW8BNfDWiVYRsIR9u8whUOnG3vg75PYvoTS8eSXwDqdknPZZ9rax4sF7ipcK
         5QpQGDwlHNwlHE8J6k9YZkfJFd9DC+cxhiPrNQ9vSZEcMWaTiJVxufK+HwbqJlJ3CsD2
         kEnz1NBibgPd2Qqen+kHRSzxNaMfoESCSxYHfPZdVVAEGElYESifZMnYdcdQZQVRCDtH
         hgAw==
X-Gm-Message-State: AOAM5305AFBaES3Xl8jKjF/XLx9cp4Fo2NHiqMQr4eXSNILuAfvXcZNa
        vgaiGseiXqAPaXdP1PmSIktRfkLbfNCo9Q==
X-Google-Smtp-Source: ABdhPJwu6acH8zM3PUXJEUBRRfoonisCjv7e/Yd2lpsp74olY5WUFf/3zw6s+IZ8ps2cFywuZI5E8Q==
X-Received: by 2002:a19:8983:: with SMTP id l125mr7013043lfd.182.1612137371928;
        Sun, 31 Jan 2021 15:56:11 -0800 (PST)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com. [209.85.208.175])
        by smtp.gmail.com with ESMTPSA id a1sm661217lfi.202.2021.01.31.15.56.10
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 31 Jan 2021 15:56:11 -0800 (PST)
Received: by mail-lj1-f175.google.com with SMTP id v15so14393027ljk.13
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jan 2021 15:56:10 -0800 (PST)
X-Received: by 2002:a2e:8116:: with SMTP id d22mr8355574ljg.48.1612137370575;
 Sun, 31 Jan 2021 15:56:10 -0800 (PST)
MIME-Version: 1.0
References: <CAP045Ao_Zb0HGg0=bvUeV6GjX=-3fz0ScsvM_jE7VsZcVk_-tg@mail.gmail.com>
 <C479ACCB-A1A5-4422-8120-999E8D54314B@amacapital.net> <CAP045AoMRNjvVd1PdHvdf-nn3LNpTDp66sp+SAmZgNU888iFQQ@mail.gmail.com>
 <CAP045ApWnr=UQrBrv3fHj-C6EweukMWEyrCgsiY6Bt_i1Vdj6A@mail.gmail.com> <CAHk-=wgqRgk0hjvpjHNixK7xSOS_F3fpt3bL9ZUJVhCL3oGgyw@mail.gmail.com>
In-Reply-To: <CAHk-=wgqRgk0hjvpjHNixK7xSOS_F3fpt3bL9ZUJVhCL3oGgyw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 31 Jan 2021 15:55:54 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgOp10DO9jtMC=B=RoTLWe7MFTS5pH4JeZ78-tbqTY1vw@mail.gmail.com>
Message-ID: <CAHk-=wgOp10DO9jtMC=B=RoTLWe7MFTS5pH4JeZ78-tbqTY1vw@mail.gmail.com>
Subject: Re: [REGRESSION] x86/entry: TIF_SINGLESTEP handling is still broken
To:     Kyle Huey <me@kylehuey.com>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        open list <linux-kernel@vger.kernel.org>,
        "Robert O'Callahan" <rocallahan@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 31, 2021 at 3:35 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> I wonder if the simple solution is to just
>
>  (a) always set one of the SYSCALL_WORK_EXIT bits on the child in
> ptrace (exactly to catch the child on system call exit)
>
>  (b) basically revert 299155244770 ("entry: Drop usage of TIF flags in
> the generic syscall code") and have the syscall exit code check the
> TIF_SINGLESTEP flag

Actually, (b) looks unnecessary - as long as we get to
syscall_exit_work(), the current code will work fine.

So maybe just add a dummy SYSCALL_WORK_SYSCALL_EXIT_TRAP, and set that
flag whenever a singestep is requested for a process that is currently
in a system call?

IOW, make it a very explicit "do TF for system calls", rather than the
old code that was doing so implicitly and not very obviously. Hmm?

                    Linus
