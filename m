Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2853231C18D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Feb 2021 19:33:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230119AbhBOScn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Feb 2021 13:32:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:32928 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229652AbhBOScm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Feb 2021 13:32:42 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4C64264E2B
        for <linux-kernel@vger.kernel.org>; Mon, 15 Feb 2021 18:32:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613413921;
        bh=txjPnO/WEw26xqIpVpPhuE1OXuwFg2SfAzbrnQssS3c=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ZbN4mUOVX2QH6WvDX2Kefj4kv0QwrcnZtlcFFRJ95ciz6GUaEadkCtTyAdFGsbcGg
         gavn80uR75+oslSxe9Wgo7GaoTqXN7IkGveCn+FZLOVBtKDdMVNyMr4mN2J/oE5a7y
         PfWFXLqLy0EtNW4ESgmTuauYhffOab1Hq0THpB/WIuZzWRaCtmKiwb0FhSr6rBRSJF
         YtFrKN/YBrWR0XH1TdiH2GPN0jNc7Mg84mzH48PuhbSwdpqcK3LwN7IKVRc0HvhdbU
         iAI/m64ztoEfS9Nb6rAdm7teCmGRe4IEa1AYBEtBGSS5dxDWmwl0mj4bE/Lgj3NIWW
         aiTexE933Hqnw==
Received: by mail-ot1-f41.google.com with SMTP id r21so6827082otk.13
        for <linux-kernel@vger.kernel.org>; Mon, 15 Feb 2021 10:32:01 -0800 (PST)
X-Gm-Message-State: AOAM533mucdVK8gl1Urn+WkPEMwHCiocJDbT/ypiEvNPq3INvSR+Urtq
        hHdoapTF/gPXnYdfe9eeCbjbF72fBJcpRzBJ4cU=
X-Google-Smtp-Source: ABdhPJxoCxPc0N0GSCMA7s4BheeJzRXgN44kV2i0H6LbkCZrNBOjFYj8EOdoQaYNmG2MS/Kg1gNE2hVbNMrTlyy1roo=
X-Received: by 2002:a05:6830:11:: with SMTP id c17mr11961822otp.77.1613413920685;
 Mon, 15 Feb 2021 10:32:00 -0800 (PST)
MIME-Version: 1.0
References: <20210127110944.41813-1-alexander.sverdlin@nokia.com> <a5c1e655-cdbc-18d5-55fd-c1690c31acbe@gmail.com>
In-Reply-To: <a5c1e655-cdbc-18d5-55fd-c1690c31acbe@gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 15 Feb 2021 19:31:49 +0100
X-Gmail-Original-Message-ID: <CAMj1kXGEP3BNW6aLDaHFq2FCer-e8VXPU3c8xiojNXSqgzdw_g@mail.gmail.com>
Message-ID: <CAMj1kXGEP3BNW6aLDaHFq2FCer-e8VXPU3c8xiojNXSqgzdw_g@mail.gmail.com>
Subject: Re: [PATCH v7 0/2] ARM: Implement MODULE_PLT support in FTRACE
To:     Florian Fainelli <f.fainelli@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Alexander A Sverdlin <alexander.sverdlin@nokia.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(+ Linus)

On Wed, 3 Feb 2021 at 19:24, Florian Fainelli <f.fainelli@gmail.com> wrote:
>
> On 1/27/21 3:09 AM, Alexander A Sverdlin wrote:
> > From: Alexander Sverdlin <alexander.sverdlin@nokia.com>
> >
> > FTRACE's function tracer currently doesn't always work on ARM with
> > MODULE_PLT option enabled. If the module is loaded too far, FTRACE's
> > code modifier cannot cope with introduced veneers and turns the
> > function tracer off globally.
> >
> > ARM64 already has a solution for the problem, refer to the following
> > patches:
> >
> > arm64: ftrace: emit ftrace-mod.o contents through code
> > arm64: module-plts: factor out PLT generation code for ftrace
> > arm64: ftrace: fix !CONFIG_ARM64_MODULE_PLTS kernels
> > arm64: ftrace: fix building without CONFIG_MODULES
> > arm64: ftrace: add support for far branches to dynamic ftrace
> > arm64: ftrace: don't validate branch via PLT in ftrace_make_nop()
> >
> > But the presented ARM variant has just a half of the footprint in terms of
> > the changed LoCs. It also retains the code validation-before-modification
> > instead of switching it off.
>
> Ard, Russell should this be sent to the patch tracker?

Apologies for the delay. Unfortunately, I don't have time to review this.

Linus?
