Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DA0C375DBD
	for <lists+linux-kernel@lfdr.de>; Fri,  7 May 2021 02:00:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233227AbhEGAAS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 20:00:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:43538 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233079AbhEGAAR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 20:00:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 208F4613C5
        for <linux-kernel@vger.kernel.org>; Thu,  6 May 2021 23:59:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620345559;
        bh=zt8bWHlggl9h8cOqWZ+6K4hluYlKzNhk7MdtQ+pN8o0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=YBFKSHosY/1h5SOWpUPMcsT8zpWk/YxOOPldruawOZWsEZyXIWz4GezDpxTX6q+mE
         5tsshZwgxtx8HAQifHVYSp2lFSt0B1eaE/8UXM4I5PwZUfHyoaFbB21xYJuHcX5Dt+
         9U6yvvNb+XkTdlHbdtGCdFmoYgRu3V42A/leIAp1a/scNn1YinnnDMCfrlrRSWlRve
         Hd5jKK2AhCra0WgFWirm82ZrgLHR4kBGrf2suyz9tZ4by+hSvqQGSIiwNXe5Hsl/5w
         0+DVlgqBLkX8aJM8RMzSpRgndaSC7utoJlr4FJXtgbUrIJqERbS4a3P7VA2AyWF6C2
         3lMio8jfw7e5g==
Received: by mail-ej1-f51.google.com with SMTP id zg3so10856001ejb.8
        for <linux-kernel@vger.kernel.org>; Thu, 06 May 2021 16:59:19 -0700 (PDT)
X-Gm-Message-State: AOAM530rHJfa7zjp7W0DSCUIoIYDBl57Pd2jd+g2gfVHtGMR+hcqtkUY
        hG9QsNISGh+a5xRFJb5xwyGE8lzuZtNaLLd6PABFQg==
X-Google-Smtp-Source: ABdhPJwEEc+Uu0FuOkvehhv2TwcGtzoUoMKDmPBjxunt1tNzewz+tZsx8dQXWaLxUe28dkQUjXBRSnduZU85SsoSc5M=
X-Received: by 2002:a17:906:f742:: with SMTP id jp2mr7173182ejb.199.1620345557507;
 Thu, 06 May 2021 16:59:17 -0700 (PDT)
MIME-Version: 1.0
References: <20210430204939.5152-1-sargun@sargun.me> <20210430204939.5152-3-sargun@sargun.me>
 <CALCETrXWFbB7v8wRKeNC-gxMqUZ9ZJUZx9nQiLu64qYi2Bx5FQ@mail.gmail.com>
 <CAMp4zn8A2n7EtbR_=fG99MPgpDTgn-Ju-AzQ8F2rYU9Fri3YTg@mail.gmail.com> <CACaBj2a3OGci7A9buLdmB9sMoh5dRaYN_K7p8X7esNfmPPLhvQ@mail.gmail.com>
In-Reply-To: <CACaBj2a3OGci7A9buLdmB9sMoh5dRaYN_K7p8X7esNfmPPLhvQ@mail.gmail.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Thu, 6 May 2021 16:59:05 -0700
X-Gmail-Original-Message-ID: <CALCETrX5UJ075oH6-Cm3Uxz_XZQffi_5vZOtc8Yq3ZRmKfcDhg@mail.gmail.com>
Message-ID: <CALCETrX5UJ075oH6-Cm3Uxz_XZQffi_5vZOtc8Yq3ZRmKfcDhg@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] seccomp: Add wait_killable semantic to seccomp
 user notifier
To:     Rodrigo Campos <rodrigo@kinvolk.io>
Cc:     Sargun Dhillon <sargun@sargun.me>,
        Andy Lutomirski <luto@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Containers <containers@lists.linux-foundation.org>,
        =?UTF-8?Q?Mauricio_V=C3=A1squez_Bernal?= <mauricio@kinvolk.io>,
        Tycho Andersen <tycho@tycho.pizza>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Christian Brauner <christian.brauner@ubuntu.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 6, 2021 at 12:35 PM Rodrigo Campos <rodrigo@kinvolk.io> wrote:

> We want to be woken-up in seccomp_do_user_notification() so we know we
> received a signal and notify to the supervisor about it. IMHO, we want
> an additional "if" here[2], like (haven't checked the retun codes of
> functions) "if err != 0"  and do a "wake_up_poll(&match->wqh, EPOLLIN
> | EPOLLRDNORM);" or POLLPRI or something, and then "goto wait". IOW,
> we only return when the supervisor tells us to, if a signal arrives we
> just let the supervisor know and continue waiting for a response. The
> proper response might be "I wrote partial data, return only 3 bytes",
> etc. This way we can properly emulate it.
>
> What is not clear to me, and I'd like others to comment is:
>
> 1. How should this new "the supervisor should handle signals" mode be enabled?
>    a. If we use an extra ioctl, as Andy suggested, I think we have a
> race too: from the moment the seccomp syscall is issued until the new
> ioctl is called there is a race. If the container does a syscall in
> that window, it _can_ incorrectly return EINTR as it does now. This
> race can be very small and the ioctl can make _all the next syscalls_
> wait in this new mode, so maybe the race is so small that we don't
> care in practice.

If the ioctl is sticky, it can presumably avoid the race entirely by
having whoever calls seccomp() immediately do a dummy syscall or
otherwise wait for the notifier to confirm that it has done the ioctl.
Admittedly, this may be annoying.

>    b. But if we want to really fully solve the issue, the other option
> that comes to mind is adding a new flag for the seccomp syscall, to
> signal that the supervisor will handle signals and should be
> forwarded. This way, if the container does a new syscall it will be
> put to wait in this new mode (we have the information that the new
> mode should be used already). Something like
> SECCOMP_FILTER_FLAG_NEW_LISTENER_SOMETHING (today we have
> SECCOMP_FILTER_FLAG_NEW_LISTENER). Ideally shorter :D

I like that better.

>
> 2. What should we notify to the supervisor? Only that a signal arrived
> or also which signal it was? If we do the EPOLLPRI thingy, as Andy
> mentioned in a previous thread, IIUC we will only notify that _a_
> signal arrived, but not _which_. To notify which signal arrived might
> be complex, though, (not sure, I haven't explored how that should be).

Are there any examples in the kernel of syscalls that care *which*
signal came in?  As far as I know, there are really only three states
that matter: no signal is pending, a kill is pending, or a regular
signal is pending.  (The latter means that there's a signal that is
unmasked, etc and will should therefore interrupt a syscall if the
syscall can be interrupted.
