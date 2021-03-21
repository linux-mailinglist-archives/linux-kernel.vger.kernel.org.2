Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBDD834347E
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Mar 2021 21:04:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230438AbhCUUD4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Mar 2021 16:03:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230439AbhCUUDa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Mar 2021 16:03:30 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3551C061574;
        Sun, 21 Mar 2021 13:03:29 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id o66so4347933ybg.10;
        Sun, 21 Mar 2021 13:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EQq7iHQgsKMRk89C6zvaky+IUSEdWuNAeKo0pyatNPg=;
        b=MK6Xwj9t4EhvfV8FnhBGk+aoHf8OExNiJKPBT4oQ1j8YTthMSkopvoANU/HzVaW48W
         6iLq3aIgBmGe5igFOGlpcsK/1kmmrb9ztM1bqn8H1X530i4BzpisCgmLS6U0/lf2ou0R
         +FHPY8Vse4edcpOqxHvUK2mCNNPrE4m/7tKpCwN9sGHlexCSAh9TxsIv/FEn7muDmiVB
         VBINET+WvnXJh+S64OPI6f1AQz44OckA3YUAZapFMbz0+S74xtj2420hLPNXf3aTqAU5
         VoC3knOYfttIIzJdSBFwl01EQ2JtNr1iAmqU2JiYsigPWa2mYOZfiiHSHmovwY7ekE4U
         FM7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EQq7iHQgsKMRk89C6zvaky+IUSEdWuNAeKo0pyatNPg=;
        b=tr/hqe4w/0mlaZw6mV7CxbQQg7NHeqbSAtZYp+U7eqKsC1OmpSoQoJU7Lj1d7+vSWe
         slxmJFgktzSf2EM991A2VUFmVd/4AGXdEhJYi6AfhQ6IzJsJXmILFbArpoSZuw58KHW1
         zH0PAXAN2HLK2uGuCgo2XXPElDGwcpTB+6S+Cj3tV7ycU3XdnChf9uMlukih1AMrtjr9
         FJAzkd6+yEDudWJLDJ7hp7ei9S/pY9dv1VUzQJd8gKEQii59Txfy8FHPQYJl4j2NH55O
         4ra/CHx7xjvxU/F+MPb0jwbimpf9umyI3ThmCGIXKd95Bf3KeNiGtXJYArotUDc3453e
         zqnA==
X-Gm-Message-State: AOAM530Npq27hWHkPMX75qi03eXDTASoaDh4v+DgH2j8Av5RBcytMUP0
        rsLwXrY1xDaP8C6wI9WudHEIIVCWSC92WqbqvTo=
X-Google-Smtp-Source: ABdhPJwa5xPDaXaru7y3umIABZghbW8Vs32wUVmX0VJrpLsCqSFjrX0V9g9IZBh7Tp6f5+gR3PViiRKf0NyCe1wFPxg=
X-Received: by 2002:a25:6e02:: with SMTP id j2mr19552359ybc.247.1616357009160;
 Sun, 21 Mar 2021 13:03:29 -0700 (PDT)
MIME-Version: 1.0
References: <20210321193705.GA13699@duo.ucw.cz>
In-Reply-To: <20210321193705.GA13699@duo.ucw.cz>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Sun, 21 Mar 2021 21:03:18 +0100
Message-ID: <CANiq72n=XNwH8JrPfpzTMrHujhCYVzk5BgVmifiVcTk3W_=L2A@mail.gmail.com>
Subject: Re: Getting Rust to work
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        rust-for-linux@vger.kernel.org,
        kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pavel,

On Sun, Mar 21, 2021 at 8:37 PM Pavel Machek <pavel@ucw.cz> wrote:
>
> First try was on x86-32. It took me a whlie to figure out the problem,
> hence the diff below.

Thanks a lot for trying it out and for the feedback! :-)

The supported architectures are in
Documentation/rust/arch-support.rst, so we should link to that.

x86 32-bit and other architectures should eventually work -- we need
to put some time into them and setting up a few things. For the moment
we focused on x86_64 and arm64.

> Then I got failure because libclang (?) was not installed. I installed
> it. But I guess that should be mentioned in docs as dependency.

Yeah, this is mentioned on the bindgen section in quick-start.rst, I
will try to improve make it more clear, perhaps I'll a section for
libclang itself.

> With CONFIG_RUST unset, kernel builds for me. With CONFIG_RUST=y +
> RUST_EXAMPLE=y... I get errors:

Typically it is due to a kernel option that enables some GCC flag that
libclang does not know about -- I have a hack in place to make it
work, but requires manual maintenance. Can you please attach your
kernel config?

Meanwhile, please try building with Clang or LLVM instead, the GCC
builds are very, very experimental. I'll make it even more explicit in
the quick-start.

Cheers,
Miguel
