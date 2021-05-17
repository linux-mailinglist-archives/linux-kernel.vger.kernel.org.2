Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2C47383BBC
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 19:55:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236698AbhEQRzu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 13:55:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236507AbhEQRzs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 13:55:48 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A0DBC061573
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 10:54:32 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id z1so6887743ils.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 10:54:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sargun.me; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zLSBrGc0WfP3Pu9mRhepzRhhSNQ0d1+mv4ZIuny3PCE=;
        b=apMSSFZpnC0TCNR6wciOFVOjRv8HfBGsEB0/NxZxsirwzsFUiv6nrFHwONXyfMSlEE
         A1gPKjm42FG93MI7TR/J504p6LZ3yq44igR52eJTPS8fSneRQbJ+w67uroW9BpNdf1FK
         f7jpVKFrswoQOw/92eHdDcfxYbpaJ+ymYLPl0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zLSBrGc0WfP3Pu9mRhepzRhhSNQ0d1+mv4ZIuny3PCE=;
        b=ar0Ggrn5N4cyIzncokax7JUtKcSjHqy1srqDEzBVvafaccLLZ2cRX/M1vnpSkrPduy
         rEViwG2fO2xPNVWLqxuK4XxZn6llO5/6FP4qoOKPjp8rsIrhVwIUccJ6B4n19FWG1C6w
         N/8OC3Gq08SouS3im9mnggvj+yzOJeBY4cefwoH+SuXb7C34fAzpqdczNl2s0u7RAzUM
         RYYNpi9/ik1eLzMgcSMi+UldEeJD+WKnKCgUrcqt2sY/1HcHaidhKCQewtCMKURo3YTz
         Vw1JnMAlB+B6ZmIZvla7K2eV7fwHHkNZHuE7liDC0obIvc7xgJMNizWCGQcvQZTs17tj
         ZFNQ==
X-Gm-Message-State: AOAM533eY7Daw11Z+U1ahmGTx4BNY+Y3C2L422k6lHZ9xiEXTWVEGM7x
        bDw/4O96S8c9OoSRg/A8DyQzmtRLk7HFp4re9BoemQ==
X-Google-Smtp-Source: ABdhPJz0yLEKO0WcXF7iyAjs9lEnYLEYrMbzmli7FuGJ1q9A81v4fu3+IcyiLYeLQyULoMrRAZ/WMgIDAxvC2AxDVno=
X-Received: by 2002:a92:2a0a:: with SMTP id r10mr765713ile.274.1621274071101;
 Mon, 17 May 2021 10:54:31 -0700 (PDT)
MIME-Version: 1.0
References: <20210502001851.3346-1-sargun@sargun.me> <20210502001851.3346-4-sargun@sargun.me>
 <20210511215010.GB1964106@cisco>
In-Reply-To: <20210511215010.GB1964106@cisco>
From:   Sargun Dhillon <sargun@sargun.me>
Date:   Mon, 17 May 2021 10:53:55 -0700
Message-ID: <CAMp4zn-crcdi6AR9VfAmpb0TO9sDtpdwA4C59ERqwdoQW7yTAg@mail.gmail.com>
Subject: Re: [PATCH 3/4] seccomp: Support atomic "addfd + send reply"
To:     Tycho Andersen <tycho@tycho.pizza>
Cc:     Kees Cook <keescook@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Containers <containers@lists.linux.dev>,
        Andy Lutomirski <luto@kernel.org>,
        Rodrigo Campos <rodrigo@kinvolk.io>,
        =?UTF-8?Q?Mauricio_V=C3=A1squez_Bernal?= <mauricio@kinvolk.io>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 11, 2021 at 2:50 PM Tycho Andersen <tycho@tycho.pizza> wrote:
>
> Hi,
>
> On Sat, May 01, 2021 at 05:18:50PM -0700, Sargun Dhillon wrote:
>
> [snip]
>
> > Other patches in this series add a way to block signals when a syscall
> > is put to wait by seccomp.
>
> I guess we can drop this bit from the message if the series is split.
>
Makes sense.

> > The struct seccomp_notif_resp, used when doing SECCOMP_IOCTL_NOTIF_SEND
> > ioctl() to send a response to the target, has three more fields that we
> > don't allow to set when doing the addfd ioctl() to also return. The
> > reasons to disallow each field are:
> >  * val: This will be set to the new allocated fd. No point taking it
> >    from userspace in this case.
> >  * error: If this is non-zero, the value is ignored. Therefore,
> >    it is pointless in this case as we want to return the value.
> >  * flags: The only flag is to let userspace continue to execute the
> >    syscall. This seems pointless, as we want the syscall to return the
> >    allocated fd.
> >
> > This is why those fields are not possible to set when using this new
> > flag.
>
> I don't quite understand this; you don't need a NOTIF_SEND at all
> with the way this currently works, right?
>
I reworded:

This effectively combines SECCOMP_IOCTL_NOTIF_ADDFD and
SECCOMP_IOCTL_NOTIF_SEND into an atomic opteration. The notification's
return value, nor error can be set by the user. Upon successful invocation
of the SECCOMP_IOCTL_NOTIF_ADDFD ioctl with the SECCOMP_ADDFD_FLAG_SEND
flag, the notifying process's errno will be 0, and the return value will
be the file descriptor number that was installed.

How does that sound?

> > @@ -1113,7 +1136,7 @@ static int seccomp_do_user_notification(int this_syscall,
> >                                                struct seccomp_kaddfd, list);
> >               /* Check if we were woken up by a addfd message */
> >               if (addfd)
> > -                     seccomp_handle_addfd(addfd);
> > +                     seccomp_handle_addfd(addfd, &n);
> >
> >       }  while (n.state != SECCOMP_NOTIFY_REPLIED);
> >
>
> This while() bit is introduced in the previous patch, can we fold this
> deletion into that somehow?
I'm not sure what you're getting at. This just an argument change which
also passes the notification to the addfd function. The patch is split out
to allow it to be backported to stable.

>
> Thanks,
>
> Tycho
