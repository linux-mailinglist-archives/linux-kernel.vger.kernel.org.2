Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22D7D392D2D
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 13:52:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234255AbhE0Lxa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 07:53:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234334AbhE0LxY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 07:53:24 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA8C0C0613CE
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 04:51:51 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id t17so381408ljd.9
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 04:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kinvolk.io; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AC3MmOTUuOGnepZXQGZ9Vafob+m6VNi00uwAJjSXdhg=;
        b=iyZqWizjPMOTwqAW/a19v/NIgvvIwslHpX+4ycAXvsYAh93yczNrf6UoKXR00H6+Ad
         eJkLO7BgJ1VRuOffPYI2KsAsoQwB2bTbN1pxGC7D2gPrOb/zS/8P9UNppfs7v4ftRBWd
         L5opBVj+Eigq6yuSPmw+vClubBqnsXFlYOj4Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AC3MmOTUuOGnepZXQGZ9Vafob+m6VNi00uwAJjSXdhg=;
        b=eJMpjkYEJSeLcTk1kKWhGyrZjJpV7TAEE/l7FspsChOKrY1WLC8EsyiZmKKlbAQJ09
         1bUl3u1/XwMvtg5kx07Yc/KyyQriQh2HuRDRBD4zfcRvYeXbi4+RT/N7NRPJsufV/ymR
         Kn8t+5959tLWOpvsGJ+Ty41pe6agWOnfwAz7AkGiQl9zCZanWUppF4dcoJ01xfq2/Vze
         BwA96w229z2nY4rxD6nUCxlVJOhOJrYx5fQKjxaINnlsDnIE+V7/3vPN1QUS+tbks6Gm
         O9TTslztKlOD3pQJ0Ug53Hb+uvxOUO5RJobMcXQGJ/VHijycK58DyEg5K0/KNLwqqdNn
         o5IQ==
X-Gm-Message-State: AOAM532nuDpoaW1Jyn6Yo0NSAt0lfLTTy8ZbK+GnNosxE2Y1DRSFyxDP
        P1JMyC+jbALpQzTUFnXXstDL+/lL6AUVESf3DfIgPA==
X-Google-Smtp-Source: ABdhPJwO3O73I5qS7aTaftIM5JMjFZ7cv8RtwV2LsTuk+kYGU6SqcCJiX6IyKH65RR8Sb0/1k1krHdt/yOY+LnGheJA=
X-Received: by 2002:a2e:b4b3:: with SMTP id q19mr2185724ljm.374.1622116309916;
 Thu, 27 May 2021 04:51:49 -0700 (PDT)
MIME-Version: 1.0
References: <20210517193908.3113-1-sargun@sargun.me> <20210517193908.3113-3-sargun@sargun.me>
In-Reply-To: <20210517193908.3113-3-sargun@sargun.me>
From:   Rodrigo Campos <rodrigo@kinvolk.io>
Date:   Thu, 27 May 2021 13:51:13 +0200
Message-ID: <CACaBj2YUiowSKzvh02OjpQNqQViA8N0eyRMimkK=90NagRF40w@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] seccomp: Refactor notification handler to prepare
 for new semantics
To:     Sargun Dhillon <sargun@sargun.me>
Cc:     Kees Cook <keescook@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>, containers@lists.linux.dev,
        Tycho Andersen <tycho@tycho.pizza>,
        Andy Lutomirski <luto@kernel.org>,
        =?UTF-8?Q?Mauricio_V=C3=A1squez_Bernal?= <mauricio@kinvolk.io>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 17, 2021 at 9:39 PM Sargun Dhillon <sargun@sargun.me> wrote:
>
> This refactors the user notification code to have a do / while loop around
> the completion condition. This has a small change in semantic, in that
> previously we ignored addfd calls upon wakeup if the notification had been
> responded to, but instead with the new change we check for an outstanding
> addfd calls prior to returning to userspace.
>
> Rodrigo Campos also identified a bug that can result in addfd causing
> an early return, when the supervisor didn't actually handle the
> syscall [1].
>
> [1]: https://lore.kernel.org/lkml/20210413160151.3301-1-rodrigo@kinvolk.io/
>
> Fixes: 7cf97b125455 ("seccomp: Introduce addfd ioctl to seccomp user notifier")
> Signed-off-by: Sargun Dhillon <sargun@sargun.me>
> Acked-by: Tycho Andersen <tycho@tycho.pizza>

Kees, as I mentioned in the linked thread, this issue is present in
5.9+ kernels. Should we add the cc to stable for this patch? Or should
we cc to stable the one linked, that just fixes the issue without
semantic changes to userspace?

Just to be clear, the other patch that fixes the problem without
userspace visible changes is this:
https://lore.kernel.org/lkml/20210413160151.3301-1-rodrigo@kinvolk.io/


Best,
Rodrigo
