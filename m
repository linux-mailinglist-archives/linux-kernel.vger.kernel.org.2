Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA4E5309F8C
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 00:38:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230360AbhAaXhf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jan 2021 18:37:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230218AbhAaXgW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jan 2021 18:36:22 -0500
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DF3AC061573
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jan 2021 15:35:42 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id s18so17365409ljg.7
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jan 2021 15:35:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RxtVTOwvFLoCBdKKHCXbA57pJv5BeCvLH+KgQ45jFPE=;
        b=Uaad/AzNhD9i9qs4hVY7pyJkU4y4IRnbJ+lAT94Z5xheon9TYqV6ritYDdo0Z6BovO
         Eiiunf+4SLqqb/sM3/HxMYRTLlhWVsnXV7jHKbaJfJMghdaW25T5aMjaCIltgRKELYQv
         WyK8x5KFjphrAV7DodibwS35q7+RL1pYFmqLM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RxtVTOwvFLoCBdKKHCXbA57pJv5BeCvLH+KgQ45jFPE=;
        b=C0ApO5jXci6QINtQ61XzrO2jCVvJPinc7queH3Y07pXtWqBzhn5p2ZWc1oLYZ9hVoC
         C+FkNGZECa77qmMcoYakUgSfApGZemVd8khpIwtIeO3krhvUbirVNCty+YD+7pr9Dzxw
         uKPkKNAarykPvVgrLoB/oq56M9LhU2J2tpABNdlVSfEN49cN14inBAtEvjrc+lmWkCh+
         H2JRNqsC3zJDLg2tTXGgoJKCaosiV0d1IQ0fgVzCg//Fpdg0HN5fd7U1gQO/O5MbdQsy
         xKYaNosno9e0eWNgcH5vBXwZ1XPxYvFqom4HDQoCfy6j2PSc38wsfFSXRcr5wlU0v1C6
         v1Ww==
X-Gm-Message-State: AOAM531jtBbTQGC4M7zzD84qL99V2YNLBAH3d3CwqkLif1jmeu/a0K0F
        VS/UETXrFSz/bp5MmuAa9JsZJ46ivYw0KQ==
X-Google-Smtp-Source: ABdhPJxizNWfQ15sYqnsLb04Wu8DCI3LU5xajerd4PyRs0TzInTVFzAB7m5ZhUtUJK3Nuwjd9xrMZg==
X-Received: by 2002:a2e:91c2:: with SMTP id u2mr8440987ljg.346.1612136139436;
        Sun, 31 Jan 2021 15:35:39 -0800 (PST)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com. [209.85.167.45])
        by smtp.gmail.com with ESMTPSA id c17sm2804361lfs.217.2021.01.31.15.35.38
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 31 Jan 2021 15:35:38 -0800 (PST)
Received: by mail-lf1-f45.google.com with SMTP id f1so20337331lfu.3
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jan 2021 15:35:38 -0800 (PST)
X-Received: by 2002:ac2:4436:: with SMTP id w22mr6894967lfl.41.1612136138002;
 Sun, 31 Jan 2021 15:35:38 -0800 (PST)
MIME-Version: 1.0
References: <CAP045Ao_Zb0HGg0=bvUeV6GjX=-3fz0ScsvM_jE7VsZcVk_-tg@mail.gmail.com>
 <C479ACCB-A1A5-4422-8120-999E8D54314B@amacapital.net> <CAP045AoMRNjvVd1PdHvdf-nn3LNpTDp66sp+SAmZgNU888iFQQ@mail.gmail.com>
 <CAP045ApWnr=UQrBrv3fHj-C6EweukMWEyrCgsiY6Bt_i1Vdj6A@mail.gmail.com>
In-Reply-To: <CAP045ApWnr=UQrBrv3fHj-C6EweukMWEyrCgsiY6Bt_i1Vdj6A@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 31 Jan 2021 15:35:22 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgqRgk0hjvpjHNixK7xSOS_F3fpt3bL9ZUJVhCL3oGgyw@mail.gmail.com>
Message-ID: <CAHk-=wgqRgk0hjvpjHNixK7xSOS_F3fpt3bL9ZUJVhCL3oGgyw@mail.gmail.com>
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

On Sun, Jan 31, 2021 at 3:18 PM Kyle Huey <me@kylehuey.com> wrote:
>
> The key to triggering this bug is to enter a ptrace syscall stop and
> then use PTRACE_SINGLESTEP to exit it. On a good kernel this will not
> result in any userspace code execution in the tracee because on the
> way out of the kernel's syscall handling path the singlestep trap will
> be raised immediately. On a bad kernel that stop will not be raised,
> and in the example below, the program will crash.

Thanks, great explanation, and I can certainly see the behavior you mention.

I wonder if the simple solution is to just

 (a) always set one of the SYSCALL_WORK_EXIT bits on the child in
ptrace (exactly to catch the child on system call exit)

 (b) basically revert 299155244770 ("entry: Drop usage of TIF flags in
the generic syscall code") and have the syscall exit code check the
TIF_SINGLESTEP flag

Hmm?

        Linus
