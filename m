Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDE1E37173E
	for <lists+linux-kernel@lfdr.de>; Mon,  3 May 2021 16:56:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230054AbhECO5p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 May 2021 10:57:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:33420 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229703AbhECO5o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 May 2021 10:57:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B8F0D6121D
        for <linux-kernel@vger.kernel.org>; Mon,  3 May 2021 14:56:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620053810;
        bh=w/TOn6BhhAtIoEsbu/HzZYIYw9TLlFA8kuOGe+aVX+E=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=iN/aPoUmqnI8S89/QJkNgT2UTZ8psgTpF5EsDA6wcNxxINrWyDt+DpTdJ9hprs+oR
         MNHK9TRKEDmvFe1hM03zUnADL+btFJ9x7Y6RPWw0vWVMOP2gjSAmbcLv/E0HR4djbp
         SHqYuo8nX7E/evZWcNpHerJPcnsWgmk1my8MeXy06ZwvY1FbERE5j43TvbkqgZTW9E
         4WC0anQ0yTAABFo69MKwMsvIFlhbv+pao2D39Gz+fwp31Vf9DxtJx2VQYb1gN8VtXn
         afUK9ymYign/zOxmdI7PP395z8LCuaBk/WHzSrArsW4VngzwxOxsShf1wNqdqFT3ql
         90hMiHimwOFxg==
Received: by mail-ed1-f43.google.com with SMTP id n25so6626149edr.5
        for <linux-kernel@vger.kernel.org>; Mon, 03 May 2021 07:56:50 -0700 (PDT)
X-Gm-Message-State: AOAM530q77AVhzFkA0LdFdNuPWEqE4ZReGSpnp7iwSD/967nGelnPmV5
        JWD9GhRiVrL8lmbEIrfr/WT6KOPhVG4SlqEw9g==
X-Google-Smtp-Source: ABdhPJyFfmzPSzhVJUZ/sDNPGF/dUD0IxlJJuegnE6UDhr3Kw/99anzDYe8SdQwP2JyL4Qy7Q1P5heEPrZh1S20adBE=
X-Received: by 2002:a05:6402:1e4:: with SMTP id i4mr20200251edy.62.1620053809168;
 Mon, 03 May 2021 07:56:49 -0700 (PDT)
MIME-Version: 1.0
References: <20210420031511.2348977-1-robh@kernel.org> <YIxTfKh6/uxvd0Fu@kernel.org>
In-Reply-To: <YIxTfKh6/uxvd0Fu@kernel.org>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 3 May 2021 09:56:37 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJuG+rz6bfnsYAW3fQKq28d_38Qihrb72zB_20L4=gDMg@mail.gmail.com>
Message-ID: <CAL_JsqJuG+rz6bfnsYAW3fQKq28d_38Qihrb72zB_20L4=gDMg@mail.gmail.com>
Subject: Re: [PATCH v7 0/9] arm64 userspace counter access support
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Honnappa Nagarahalli <honnappa.nagarahalli@arm.com>,
        Zachary.Leaf@arm.com, Raphael Gault <raphael.gault@arm.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Itaru Kitayama <itaru.kitayama@gmail.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 30, 2021 at 1:59 PM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Mon, Apr 19, 2021 at 10:15:02PM -0500, Rob Herring escreveu:
> > Hi all,
> >
> > Another version of arm64 userspace counter access support. I sent out
> > the libperf bits separately and those are now applied (Thanks!), so this
> > is just the arm64 bits.
> >
> >
> > This originally resurrected Raphael's series[1] to enable userspace counter
> > access on arm64. My previous versions are here[2][3][4][5][6][7]. A git
> > branch is here[8].
>
> Rob, please don't mix kernel patches with tools patches. The kernel
> bits, if arch specific should go via the arch maintainer, core stuff to
> PeterZ/Ingo/bpetkov/tglx, and tooling stuff I'll collect.

Okay, perhaps MAINTAINERS should be updated to reflect that better.

>
> We did it on purpose to avoid any semblance of kernel/tool lockstep.
>
> The kernel changes should not prevent the tooling from working and the
> tooling changes shouldn't require the kernel changes.
>
> Preexisting kernels should work with new tools and vice versa.

The only issue I see here is the userspace access tests will fail if
enabled in libperf for an arch but run on an older kernel without
userspace access support. I could instead skip tests if cap_user_rdpmc
is not set, but then how to test that it is set when it should be? I
suppose checking sysfs 'rdpmc' is one option assuming we end up with
the same file on Arm.

Rob
