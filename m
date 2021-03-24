Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9187534805C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 19:22:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237511AbhCXSWF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 14:22:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237571AbhCXSVo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 14:21:44 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 466C5C061763
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 11:21:33 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id x16so25422670wrn.4
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 11:21:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7Fgs5+vYQG4I5W+8l5V1B7+DsPBLi1z0BapcBg3qgVE=;
        b=U5xGApXj987w3pZV48fwgmvzOdOdhCriw5kDTTTQkTgEhfs41n3g3yS4wj0JGrepHO
         TmfiNBbjXlZgXsfsSUWUY+CJTt6XZ9sy9M9XIftqUF+4q/mMfWSDdJ5ZSvrdgSKFwOYf
         vlNNBsVXg9G5GjOsS1B5WuUitqN9jboEZfJVM35f8z6CDp2Ke8LHG0vbBkQjc7BpZmQM
         mYlgRDTbJ1jDq0AZdiDcFu8KYZLwxlQDQQ62KU7+lgzTdwjws7Q2g+jJwRQlUFR6Og25
         h0pNfD+zfYVvyh+dQa95+RCRugvgi+oy0exh2JC1upWvFrPZ+CsShaxvKrQ6Q0KkeqBQ
         7R3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7Fgs5+vYQG4I5W+8l5V1B7+DsPBLi1z0BapcBg3qgVE=;
        b=Grqs8Nwr3bOsnlRbMIMbSXt+wVeXG6L2/r/ZEe7k95AucKdoWzhWmXQiTfd69dANod
         hIhxZ8Z/zI6JSr7zbGWBhlg1aja4nq3xb60poFLRV71EqqdRCp369kIw7ipHpLp9xBrf
         tSyTYAAlUoN2MF4yNF2NmVYxtYjz7o19IaORrjDUQXa1BVK3PagYInHZTUhrB4LodUTA
         F8V1R6v5fqF14XiErLFGIple6qBdEnYgLTTTD5rhfQinlUTdeS4yJOJmVAM8PNo5UJTC
         Wvf/b91LUn0xzUj6TOgI+2ToL1zo1y7r/9ufCw+AX8aWP9emOWTcX/88TaMo9F4BU49K
         U9GA==
X-Gm-Message-State: AOAM532IsP/ahQF/jhahmpqyM0g5g4cbqqM0DZsWcNZYqCXLTaaCSr7Z
        pAXSsHUg5uPCGH9BT6C55XH+CBxTVDMmRm+/DBEwew==
X-Google-Smtp-Source: ABdhPJwTypSmzk15zxIHskKCdwQrTqYaSpXWmb6ON0yw5X6PacFF+Iiz56x6a3nSlQXK3q196R6+IvguAkOphMvuwdM=
X-Received: by 2002:a5d:6411:: with SMTP id z17mr4766522wru.119.1616610091879;
 Wed, 24 Mar 2021 11:21:31 -0700 (PDT)
MIME-Version: 1.0
References: <20210304174237.31945-1-bp@alien8.de> <20210304174237.31945-5-bp@alien8.de>
 <CAP-5=fU2D_kmdaLFL7Azm31Czdfdze6EpKg7=uZ+ohbNnb7ssQ@mail.gmail.com>
 <YFtB+Dir1lWjL2gi@kernel.org> <20210324135406.GD5010@zn.tnic>
In-Reply-To: <20210324135406.GD5010@zn.tnic>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 24 Mar 2021 11:21:19 -0700
Message-ID: <CAP-5=fWwZ8WVKHT=+rWdYODx1MTOMR8318mSiheSMx_q4r41hA@mail.gmail.com>
Subject: Re: [PATCH v3 04/21] x86/insn: Add an insn_decode() API
To:     Borislav Petkov <bp@alien8.de>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>, X86 ML <x86@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 24, 2021 at 6:54 AM Borislav Petkov <bp@alien8.de> wrote:
>
> On Wed, Mar 24, 2021 at 10:43:20AM -0300, Arnaldo Carvalho de Melo wrote:
> > Borislav, was this addressed? Ian?
>
> Yap:
>
> https://git.kernel.org/tip/0705ef64d1ff52b817e278ca6e28095585ff31e1

Tested on PPC and ARM64 fwiw. Thanks,
Ian

> --
> Regards/Gruss,
>     Boris.
>
> https://people.kernel.org/tglx/notes-about-netiquette
