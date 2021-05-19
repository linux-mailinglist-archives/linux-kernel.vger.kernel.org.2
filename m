Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E359038936E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 18:15:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347646AbhESQQe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 12:16:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240333AbhESQQc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 12:16:32 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 955B3C061760
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 09:15:11 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id c20so20825695ejm.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 09:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=euUbnNVLGUAionJ86okTP34g0fVZ9JZZ001iCcnhQ1E=;
        b=IGWvV3g+wI0u33bR8kxu+8pUactwsMA96L8+f7zB4n75FQciRkhL+61FSo22/9u6ye
         MgtLDx8QRLwTC9VVIaDFu+R/1JjKFkJebO3Xdo0zYdVmRm/1UNRYiO9bc3xAefBg4yZm
         5iJZdF6y21ZH97BrIB5gPP6AyiXmYJ+rwteattF+udD5mG+8U1BZDiulYnP2e1WFdwG/
         3jnffxRvg3TCqKEV5KNJ/s4KzTXIYI5g/O0xU+alPCiUwedXMBf0g2wrUSFTlZSWkJu3
         sxvQCDxSe5aOmz7Zu6Kf+1W1x4B/6FF+ZXsH9bBLXXSBhGWW6O8i7CfbBzDJ5b3BkhV0
         oBQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=euUbnNVLGUAionJ86okTP34g0fVZ9JZZ001iCcnhQ1E=;
        b=K7c+Sbc+wXiPsCVd9H+L7ULzv4BcogScxBFJbJ4UlTlD9dAN0c4gy+SYpOsLmAr+rJ
         5Ac8MaN6/rsMkngXtohqjvjriDJm3Xb9WcPpc0dyVpND1hSwDuBpJq12hUDn9CAYIx/Q
         k4abIQ7KE6EJyCRE7r/npcFmgpR+PWa28bBMIt69wHp5JAPPGuoDg0sXBetryGSmNOrQ
         KUDerzhxcB5m168zTOB4CbIpD6hzlTz6G7+H+5opUKWNn6jPPHm5eR1hGaX20jHoTIX8
         2+o6xdZ1uTf7Cqyw9nq5IoS7+eSkA4JlVKkOo+BkMVHk9sZZyRmY/PJdBvGy8fM84wL4
         nInQ==
X-Gm-Message-State: AOAM5318NV8PsOQLhLVLGHPJhMkBrOnw7XhqHImLWyloq6hw9PsNAsjv
        pZxqU2xMJTvHvkoh03f+Tdi2YrOOyGiB9Qjy5YBncMKXUe5NNQ==
X-Google-Smtp-Source: ABdhPJzxecr0ezsnx3X0SGG9M891eMwzEBBNQ3xtc6D0ZjqjuFWo5rltqyRGYEXlbXNp9E4BwL8fcJpYWV9QLX4LWzQ=
X-Received: by 2002:a17:906:17ca:: with SMTP id u10mr13290634eje.124.1621440910179;
 Wed, 19 May 2021 09:15:10 -0700 (PDT)
MIME-Version: 1.0
References: <20210518090658.9519-1-amanieu@gmail.com> <20210518090658.9519-9-amanieu@gmail.com>
 <CAK8P3a0=iSUBu5GnuWoxEjB0Hpd3iHeVwe2Njfj6x64hoJA5oA@mail.gmail.com>
 <CA+y5pbRiXAF=gobC9sqJmvjVAmihA=O7xcSTkA1f8=QsnZzoEg@mail.gmail.com> <14982d7d-bee1-6c25-8b18-123c29959f52@arm.com>
In-Reply-To: <14982d7d-bee1-6c25-8b18-123c29959f52@arm.com>
From:   "Amanieu d'Antras" <amanieu@gmail.com>
Date:   Wed, 19 May 2021 17:14:33 +0100
Message-ID: <CA+y5pbRwgpctUOBzzscT9XMN9LM2qraPNg6K6onFcpQaaFDYkQ@mail.gmail.com>
Subject: Re: [RESEND PATCH v4 8/8] arm64: Allow 64-bit tasks to invoke compat syscalls
To:     Steven Price <steven.price@arm.com>
Cc:     Arnd Bergmann <arnd@kernel.org>,
        Ryan Houdek <Houdek.Ryan@fex-emu.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        David Laight <David.Laight@aculab.com>,
        Mark Brown <broonie@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 19, 2021 at 4:30 PM Steven Price <steven.price@arm.com> wrote:
> Perhaps I'm missing something, but surely some syscalls that would be
> native on 32 bit will have to be translated by Tango to 64 bit syscalls
> to do the right thing? E.g. from the previous patch compat sigreturn
> isn't available.

That's correct.

Tango handles syscalls in 3 different ways:
- ~20 syscalls are completely emulated in userspace or through 64-bit
syscalls. E.g. sigaction, sigreturn, clone, exit.
- Another ~50 syscalls have various forms of pre/post-processing, but
are otherwise passed on to the kernel compat syscall handler. E.g.
open, mmap, ptrace.
- The remaining syscalls are passed on to the kernel compat syscall
handler directly.

The first group of ~20 syscalls will effectively bypass the
user-specified seccomp filter: any 64-bit syscalls used to emulate
them will be whitelisted. I consider this an acceptable limitation to
Tango's seccomp support since I see no viable way of supporting
seccomp filtering for these syscalls.

> In those cases to correctly emulate seccomp, isn't Tango is going to
> have to implement the seccomp filter in user space?

I have not implemented user-mode seccomp emulation because it can
trivially be bypassed by spawning a 64-bit child process which runs
outside Tango. Even when spawning another translated process, the
user-mode filter will not be preserved across an execve.

> I guess the question comes down to how big a hole is
> syscall_in_tango_whitelist() - if Tango only requires a small set of
> syscalls then there is still some security benefit, but otherwise this
> doesn't seem like a particularly big benefit considering you're already
> going to need the BPF infrastructure in user space.

Currently Tango only whitelists ~50 syscalls, which is small enough to
provide security benefits and definitely better than not supporting
seccomp at all.
