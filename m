Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C13D13703FD
	for <lists+linux-kernel@lfdr.de>; Sat,  1 May 2021 01:23:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232801AbhD3XXu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 19:23:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:41934 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230508AbhD3XXu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 19:23:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3BFDF61420
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 23:23:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619824981;
        bh=uKGdbljdVGUHQi7F59H24hqyS4ay41ngXPz142NF5VI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=TPkhZLN8mxjWxsgT2WPk6oH1cLXMqqQ9nnNWxI2CV/P0LxdgS7LzVsu/LCcj6nit6
         DQ+JZSJYMwiLuiGeT9hGYIHEuYmR4x4m2fppC89xVc5IYdj556kY8bBBaLiX4JoZ/8
         1gZQOtXikpwQ3F20xGKHAqFucv8Cw4KGPJGoyWKpIIP96ZnCHnnPw957QRSovdurJZ
         dFTyt/QhMEYMgsGXoH0a2ZLQwTrhYGzljRHwIyTNXPv2J4X6VzNp2atvIx2BGi5fg2
         DPDux58pdd/B+A6caPBaCyyVVF9znLS/6Qbs/aLJESz314TbkYzrC+Dis97QWPz3rV
         vYzTl0Cnrm1kw==
Received: by mail-ej1-f43.google.com with SMTP id u17so107684583ejk.2
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 16:23:01 -0700 (PDT)
X-Gm-Message-State: AOAM532ebghsIqUsC5FdV6m2TxvtqnBcXTuPtg1svG0MgKiPd9Y5rkZ4
        2Wfwi6QjqJ9AR0AB4mSSv2VOT6qF8aldwekFVx6FNA==
X-Google-Smtp-Source: ABdhPJwbkpKTSR9ZXCaL5ZHH1Qt+HE/3pAODcuL1ueLvo4bd+qN0Bkl1AYINz3PbnMv34jstNqIOUi0Y8B/iArQ9Y5A=
X-Received: by 2002:a17:906:c010:: with SMTP id e16mr6883221ejz.214.1619824979806;
 Fri, 30 Apr 2021 16:22:59 -0700 (PDT)
MIME-Version: 1.0
References: <20210430204939.5152-1-sargun@sargun.me> <20210430204939.5152-3-sargun@sargun.me>
In-Reply-To: <20210430204939.5152-3-sargun@sargun.me>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Fri, 30 Apr 2021 16:22:48 -0700
X-Gmail-Original-Message-ID: <CALCETrXWFbB7v8wRKeNC-gxMqUZ9ZJUZx9nQiLu64qYi2Bx5FQ@mail.gmail.com>
Message-ID: <CALCETrXWFbB7v8wRKeNC-gxMqUZ9ZJUZx9nQiLu64qYi2Bx5FQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] seccomp: Add wait_killable semantic to seccomp
 user notifier
To:     Sargun Dhillon <sargun@sargun.me>
Cc:     Kees Cook <keescook@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Containers <containers@lists.linux-foundation.org>,
        =?UTF-8?Q?Mauricio_V=C3=A1squez_Bernal?= <mauricio@kinvolk.io>,
        Rodrigo Campos <rodrigo@kinvolk.io>,
        Tycho Andersen <tycho@tycho.pizza>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Andy Lutomirski <luto@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 30, 2021 at 1:49 PM Sargun Dhillon <sargun@sargun.me> wrote:
>
> The user notifier feature allows for filtering of seccomp notifications in
> userspace. While the user notifier is handling the syscall, the notifying
> process can be preempted, thus ending the notification. This has become a
> growing problem, as Golang has adopted signal based async preemption[1]. In
> this, it will preempt every 10ms, thus leaving the supervisor less than
> 10ms to respond to a given notification. If the syscall require I/O (mount,
> connect) on behalf of the process, it can easily take 10ms.
>
> This allows the supervisor to set a flag that moves the process into a
> state where it is only killable by terminating signals as opposed to all
> signals. The process can still be terminated before the supervisor receives
> the notification.

This is still racy, right?  If a signal arrives after the syscall
enters the seccomp code but before the supervisor gets around to
issuing the new ioctl, the syscall will erroneously return -EINTR,
right?

Can we please just fully fix this instead of piling a racy partial fix
on top of an incorrect design?

--Andy
