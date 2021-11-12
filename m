Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6D6844EC3B
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Nov 2021 18:51:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235562AbhKLRyg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Nov 2021 12:54:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235545AbhKLRye (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Nov 2021 12:54:34 -0500
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7003DC061766
        for <linux-kernel@vger.kernel.org>; Fri, 12 Nov 2021 09:51:43 -0800 (PST)
Received: by mail-io1-xd2d.google.com with SMTP id w22so12211828ioa.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Nov 2021 09:51:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=d8avzr6wPrjPv+JUzN0xTbX7fIrvQVTvK2cgonQvGgY=;
        b=q2FImbJIxqa/zSpv+XP26u2kaeyM2pnxXhxV15j9aA6VoQTUjNeoSG96T6SPsjVyDj
         zg4ONjkYoEv3lMk37nGA0MwqCrhNi/tF3Ka3rsuqKh8Ua6Sp0FtkrBahB1SOGspd+7BS
         G4eTT7SCBm0NKBa4mhmMVHAP5mDKglXymYnAsFVhP+CuBNwacjHCHw8oyHWcYupJFNEi
         a3Gdbnnj25KUbEtlFMXsiq/cwU/tBLUOi7wRNOv+2/Vl+0Qi3ckQO0x+LXueD+jrD2IZ
         qQRoaKdRQAQBU9oQi26GCOKGSXKDVd/07nLHkn83MZWR0aAJRvqTw9RO9qKtXTDNcgn7
         3EPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=d8avzr6wPrjPv+JUzN0xTbX7fIrvQVTvK2cgonQvGgY=;
        b=tnVQ/hcQqHuUGGu5Z/2HE6/xlQjMwIJbRKhQR0lLp21tl4/WSc1BXIbXM2qQ10Gx+4
         VRYQ7ZzBPDlYpj3gZZkZRgsdE8J+iWBekfqrXBNdbswX4tWpAtYj5i+jfMaEjSBaqK9j
         fPnRoJtAANPT2WRHFY6P85RaUjFos5gbTofeo+45E5+g5WAJWuz9Rz6KLTOsYTP3a9G/
         PQ/oXnxs9p+r78ELQyTO5+cP8TyMU9fO6zZqvS9Og9XyuD8nGb34Yy7fFrJHwf2ut3Lv
         C1IzJ1VAlnEPImIrCXX8mwFFBa4VI1D9ELgALY9gic1bEUZt1LKE/Ju9p1FsLpNym7u9
         9LwQ==
X-Gm-Message-State: AOAM532G/c7e6KcrAvFgxlxHcHaGcP+mKm/xBWpRGa2nUAPD0q7xxd27
        fS1OfUNVUjYktByfZQnujfbRpi6N2YGys9/VcA==
X-Google-Smtp-Source: ABdhPJwAi6FlvPzGqWgpjZxR8vrHrAK6g4Vn+8pfbpEpAOEs6m0vFEOD+lTa9yoRaD5j0SO/9KWpJWK8dn3ITsSwJ8M=
X-Received: by 2002:a6b:d20f:: with SMTP id q15mr11199752iob.39.1636739502836;
 Fri, 12 Nov 2021 09:51:42 -0800 (PST)
MIME-Version: 1.0
References: <87y26nmwkb.fsf@disp2133> <20211020174406.17889-9-ebiederm@xmission.com>
 <874k8htmb2.fsf@email.froward.int.ebiederm.org>
In-Reply-To: <874k8htmb2.fsf@email.froward.int.ebiederm.org>
From:   Brian Gerst <brgerst@gmail.com>
Date:   Fri, 12 Nov 2021 12:51:32 -0500
Message-ID: <CAMzpN2jkK5sAv-Kg_kVnCEyVySiqeTdUORcC=AdG1gV6r8nUew@mail.gmail.com>
Subject: Re: [PATCH 09/20] signal/vm86_32: Replace open coded BUG_ON with an
 actual BUG_ON
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        H Peter Anvin <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 12, 2021 at 10:41 AM Eric W. Biederman
<ebiederm@xmission.com> wrote:
>
> "Eric W. Biederman" <ebiederm@xmission.com> writes:
>
> > The function save_v86_state is only called when userspace was
> > operating in vm86 mode before entering the kernel.  Not having vm86
> > state in the task_struct should never happen.  So transform the hand
> > rolled BUG_ON into an actual BUG_ON to make it clear what is
> > happening.
>
> Now that this change has been merged into Linus' tree I have a report
> that it is possible to trigger this new BUG_ON.  Which obviously is not
> good.
>
> We could revert the change but I think that would just be shooting the
> messenger.
>
> Does anyone have an idea where to start to track down what is going on?
>
> A very quick skim through the code suggests that the only code path
> that calls save_v86_state that has not already accessed is
> current->thread.vm86 is handle_signal.
>
> Another quick look suggests that the only place where X86_VM_MASK gets
> set in eflags is in do_sys_vm86.  So it appears do_sys_vm86 must
> be called before v8086_mode returns true in handle_signal.
>
> Which seems to suggest that the bug on can't trigger.
>
> But that is obviously wrong.
>
> I will keep digging but if anyone has some ideas that would be appreciated.
>
> Eric

It's possible that a null pointer was passed to the vm86 syscall.
Since vm86 mode usually requires memory to be mapped at address 0 this
wouldn't trigger a fault when reading the vm86_struct data.  It should
be fine to remove !vm86->user_vm86 from the BUG_ON(), since the write
to userspace can handle a fault.

--
Brian Gerst
