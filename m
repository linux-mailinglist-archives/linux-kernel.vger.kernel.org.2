Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53158428D50
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 14:48:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235129AbhJKMuO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 08:50:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:35688 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235034AbhJKMuN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 08:50:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D2E8760D43
        for <linux-kernel@vger.kernel.org>; Mon, 11 Oct 2021 12:48:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633956493;
        bh=coqwi6nrnA/rgfWRyHfZ4CX9I41AAO4LFY7T6A6Bsgw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=fCBYVELim5H7qEx8MtUbWk+zL+QYHcDl0fWakHht6uomtyVJzVfu5Oc3dxEn2iuH8
         7Om8KYBzvfeBnTBLJvHLB2ed05TEBERHouOJkHhu3fflewP5babV/z/VkMtexSz+HP
         GCapGrGYpY0sSIFw+wK/eTGUYCmdhn1ojxIFY9Lbz2n401uP73kc8vquAEEz1Ih5Vu
         yfBFX3n/VM5SiRs+n6SEhPnOVZg31FsbIw8rgHtsXeIrZ9emq3gzp1KmY+W+Hvdp/W
         33zDysy0cKYiJrTY1Q4TPR1OFDWYa1EDOrO9JPXG0PP+KpI9d/9w48+bObAGbaBvzj
         AtELl6NjPlVlw==
Received: by mail-wr1-f41.google.com with SMTP id e12so55874849wra.4
        for <linux-kernel@vger.kernel.org>; Mon, 11 Oct 2021 05:48:13 -0700 (PDT)
X-Gm-Message-State: AOAM533+PECAvmKxlqFb6WNESn10h3LJmFTeCsrosmvfLBEKP3Ag8jow
        Xorulm/n5N/QQ4QVxL4NMrBvT53YVVUTbAUv+CI=
X-Google-Smtp-Source: ABdhPJzJ91rg+hLVEkHiRANCRlm7wUcbsrFmq3ntDIPHvq3mN08w74MORoShTwBnXcQGewIx+vDDLKOAdiZZR1df8bE=
X-Received: by 2002:a1c:4b08:: with SMTP id y8mr10407430wma.98.1633956492335;
 Mon, 11 Oct 2021 05:48:12 -0700 (PDT)
MIME-Version: 1.0
References: <20211007195754.678124-1-anders.roxell@linaro.org> <20211011100256.GA3681@willie-the-truck>
In-Reply-To: <20211011100256.GA3681@willie-the-truck>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Mon, 11 Oct 2021 14:47:56 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0wf8_8YWmi8FRjmqUZej3ximgfxHgRZEOxsV-x3M5_QQ@mail.gmail.com>
Message-ID: <CAK8P3a0wf8_8YWmi8FRjmqUZej3ximgfxHgRZEOxsV-x3M5_QQ@mail.gmail.com>
Subject: Re: [PATCH] arm64: asm: vdso: gettimeofday: export common variables
To:     Will Deacon <will@kernel.org>
Cc:     Anders Roxell <anders.roxell@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 11, 2021 at 12:03 PM Will Deacon <will@kernel.org> wrote:
>
> On Thu, Oct 07, 2021 at 09:57:54PM +0200, Anders Roxell wrote:
> > When building the kernel with sparse enabled 'C=1' the following
> > warnings can be seen:
> >
> > arch/arm64/kernel/vdso/vgettimeofday.c:9:5: warning: symbol '__kernel_clock_gettime' was not declared. Should it be static?
> > arch/arm64/kernel/vdso/vgettimeofday.c:15:5: warning: symbol '__kernel_gettimeofday' was not declared. Should it be static?
> > arch/arm64/kernel/vdso/vgettimeofday.c:21:5: warning: symbol '__kernel_clock_getres' was not declared. Should it be static?
> >
> > Rework so the variables are exported, since these variables are
> > created and used in vdso/vgettimeofday.c, also used in vdso.lds.S.
>
> Hmm, these functions are part of the vDSO and shouldn't be called from the
> kernel, so I don't think it makes sense to add prototypes for them to a
> kernel header, to be honest.

It's a recurring problem, and I have recommended this method to Anders as
I don't see any of the alternatives as better.

The thing is that both sparse (with make C=1) and gcc/clang (with make W=1)
warn about missing prototypes, and this catches a lot of real bugs. I hope
that we can eventually get to the point of enabling the warning by default for
all files, but that means we need a declaration for each global function and
variable.

It's possible to work around this by adding a declaration just before the
function definition to shut up those warnings, but I think that's worse because
we should not encourage having declarations in .c files where they may
get out of sync with a definition in another file. It's also possible that some
of the tools will start warning about extern declarations in .c files for this
reason, so it would end up as double work to add them here and move them
later.

       Arnd
