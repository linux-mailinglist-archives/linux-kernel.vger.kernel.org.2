Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2207312856
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 00:28:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229707AbhBGX2F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Feb 2021 18:28:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229977AbhBGX0j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Feb 2021 18:26:39 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F241C06174A
        for <linux-kernel@vger.kernel.org>; Sun,  7 Feb 2021 15:25:59 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id i8so21799043ejc.7
        for <linux-kernel@vger.kernel.org>; Sun, 07 Feb 2021 15:25:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kylehuey.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NIWOIJolYzJ2sVfUCjgzwEvdF7EGAs7slRBSXjvUO2M=;
        b=Z8WnIK36Vo2PoAnDRAGPoZoAEDrxMG/HuhL5gHT7UTkZMqtJM6J7OlVvHdPYYhmtHV
         h5MuSNJ7X7uV1PMR1DgXCPcMpcW4JxDylV1uFz/6nz/jU2/kftb0jePRkcMTz02pz8SU
         u6Uamu/QgJY3+z6UnLUOpvmXtJQs6qXEMRYAbmRk4ww9Ijf22xYh4/q6jvAEIoRYra4R
         Gp5L5WGuvq76xokuo+Ahjs+wW1RgwzXKLRIwZ8v9Hae2DWklewHtI29v3tMRKwZb1kE9
         kJgHj+x471fGqyeLn3xRVEtOf3v1HArtrc4PePoYqBACnVr72jMHDMJ8CVwH+pUnsrLJ
         Vf0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NIWOIJolYzJ2sVfUCjgzwEvdF7EGAs7slRBSXjvUO2M=;
        b=Gb9fI21m6KmlBWE/HD+gYfqcg5E0JiTloy/NGVnkuOPowAWrOjlSNTim+xFco3TC8d
         lZ6tGelCWpkAGPgGnBIK/rup96gCfe5mH3PDLO1BCUKql5jHXzBO4v9Z+GW2Q8ArD5ml
         45W/8REGFNfgVOEwoPeXnKBhFPzfcpT7PTZR6mxe6Ztq8BlpJGK15r83UGPzTvjU6KpY
         WKAa/5FXt/C5q4Ji3jPtpX2BSKvgc8aRDt/MyB6cRNRbufhGUeZbQw0QcIMo5HLhzvJB
         5hp2g9IN1pPfkaeLuXe7J4LweD4BXFqRd77HI8GfY9bbvRuBOj8n3CCWTWOKUm0fHKIC
         6trg==
X-Gm-Message-State: AOAM531no+0t1FxUjyt7k7gNOkRC77+QQClU/+bOOTbBZ9rhuzQZmLP9
        8hCSLxYXP8T5ny5F/ljVfRbQE+s74jKg1lwpWwxqog==
X-Google-Smtp-Source: ABdhPJx8JdH2PFsd0slgGbJep1+zPo1vEjlrsxhT0heY+TdCmwlM/04w1Acwpd1aDDQL/rGF/qjmKEg6N5Kud789gSA=
X-Received: by 2002:a17:906:1741:: with SMTP id d1mr14680230eje.182.1612740358218;
 Sun, 07 Feb 2021 15:25:58 -0800 (PST)
MIME-Version: 1.0
References: <CA+icZUUhzpmoD_XrHtnFUGSpXHrVOTnVG9Q_Tek8oA8isHZe=Q@mail.gmail.com>
In-Reply-To: <CA+icZUUhzpmoD_XrHtnFUGSpXHrVOTnVG9Q_Tek8oA8isHZe=Q@mail.gmail.com>
From:   Kyle Huey <me@kylehuey.com>
Date:   Sun, 7 Feb 2021 15:25:47 -0800
Message-ID: <CAP045Aot_wYcwXVtfB9NmS98NGZumER39q8piN1ucgHCcpc8OA@mail.gmail.com>
Subject: Re: [Linux v5.11-rc7] x86: entry: Leftover of _TIF_SINGLESTEP define?
To:     sedat.dilek@gmail.com
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 7, 2021 at 3:09 PM Sedat Dilek <sedat.dilek@gmail.com> wrote:
>
> Hi,
>
> congrats to Linux v5.11-rc7.
>
> after commit 6342adcaa683 ("entry: Ensure trap after single-step on
> system call return"):
>
> $ git grep '\_TIF_SINGLESTEP' arch/x86/
> arch/x86/include/asm/thread_info.h:#define _TIF_SINGLESTEP
>  (1 << TIF_SINGLESTEP)
>
> Is this a leftover and can be removed (now)?
>
> Thanks.
>
> Regards,
> - Sedat -
>
> [1] https://marc.info/?l=linux-kernel&m=161273724611262&w=2
> [2] https://git.kernel.org/linus/6342adcaa683

Yes it looks like that can be removed now.

- Kyle
