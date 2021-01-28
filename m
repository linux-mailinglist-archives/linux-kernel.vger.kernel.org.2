Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33C2B30807C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 22:26:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231523AbhA1VZB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 16:25:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:32990 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231439AbhA1VYy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 16:24:54 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 53CEE64DED
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 21:24:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611869053;
        bh=Qsl4p6miI7eSEd2fPPqwxKkuNXr7EicxC031HxTIdm4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=IU/7AcHAxrmz2NdnSCadDiHUu2Furi9m4Bd4WCzrto8haheh3TIFhnfzh/tv5inbX
         r+Ir/2RHqqvL6bZzJhIG1k24PCxMiIlPZ4zECjT6C8YZGbwdTds0MWmN37NGzgZnwZ
         tB0irp9OfCaKjlAVZZrJoFz16BZDInSJ3VTMIe5hJbDEsqA4KLEkddqLANidM6bbc1
         sw4ArMHdBM9MoY+SmrTRJn7oXSJBcn5i/ikf36J2xTReKtX9rPlKbXKr84ItLB8Ds/
         WYu+4tzH6vubg51eId7OILUn+lqTrqs/VEL2jtN1G4wZ/bQmg2yr1pOTBQqCtFg297
         1D3MgbFdqGHww==
Received: by mail-oi1-f176.google.com with SMTP id d18so7638007oic.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 13:24:13 -0800 (PST)
X-Gm-Message-State: AOAM533tIEKDLSXRjBGyDCrLluDAIap8DBXQV+2jMnAuHh98nDZfqD1p
        YO6/QWX3j1LA9odIuo2Vvzu4p5omqd6eKYnY4hU=
X-Google-Smtp-Source: ABdhPJwOZ36pLEYdLYlkAVsv4oyAMtM4K8b9iTbU4fTV0A9CPlnRCJjIlHPKvSc+vvCtKSn3S3EsTyd4oNe0FfTdOQY=
X-Received: by 2002:aca:e103:: with SMTP id y3mr785811oig.11.1611869052544;
 Thu, 28 Jan 2021 13:24:12 -0800 (PST)
MIME-Version: 1.0
References: <20210128044356.38419-1-ndesaulniers@google.com>
 <CAK8P3a0MbxMC9iLe0NGR0ttLY7sZDjsrgKvfRZOXVJLjzDNKmA@mail.gmail.com> <CAKwvOd=ORiCsvv_XQ8By8ZUe0QnzH3T6pFEwnRy65tmUsQ2yQg@mail.gmail.com>
In-Reply-To: <CAKwvOd=ORiCsvv_XQ8By8ZUe0QnzH3T6pFEwnRy65tmUsQ2yQg@mail.gmail.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Thu, 28 Jan 2021 22:23:56 +0100
X-Gmail-Original-Message-ID: <CAK8P3a2Jxj-aEe-kk+xsEX19mHOc6LQ8O=XXCrWowAP0Vo2Kew@mail.gmail.com>
Message-ID: <CAK8P3a2Jxj-aEe-kk+xsEX19mHOc6LQ8O=XXCrWowAP0Vo2Kew@mail.gmail.com>
Subject: Re: [PATCH] ARM: kprobes: rewrite in UAL
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Ard Biesheuvel <ardb@kernel.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 28, 2021 at 7:59 PM 'Nick Desaulniers' via Clang Built
Linux <clang-built-linux@googlegroups.com> wrote:
> On Thu, Jan 28, 2021 at 8:15 AM Arnd Bergmann <arnd@kernel.org> wrote:
>
> > Plus a lot of extra errors when building with CONFIG_THUMB2_KERNEL,
> > as that uses tests in arch/arm/probes/kprobes/test-thumb.c.
>
> Technically, that's a distinctly separate issue;
> arch/arm/probes/kprobes/test-arm.c is not built with
> CONFIG_THUMB2_KERNEL=y.  This patch doesn't introduce those warnings;
> that file has the same issue but it is separate from test-arm.c.
>
> Would you prefer to see a v2 with the swpvsb fix contain fixes for
> test-thumb.c as well, or a separate patch for that?

I think either way is fine. I'd probably go with a combined patch in
this case, since you
are addressing the same issue in two closely related files.

       Arnd
