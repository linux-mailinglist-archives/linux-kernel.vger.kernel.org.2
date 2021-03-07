Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AD1332FF48
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Mar 2021 07:32:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230175AbhCGGbo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Mar 2021 01:31:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229971AbhCGGb2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Mar 2021 01:31:28 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01B49C06174A
        for <linux-kernel@vger.kernel.org>; Sat,  6 Mar 2021 22:31:27 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id j14-20020a17090a588eb02900cefe2daa2cso538823pji.0
        for <linux-kernel@vger.kernel.org>; Sat, 06 Mar 2021 22:31:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lgTVaBNy62FaQXG4T7xAtsLpQb7SJOUo67w7wxLxPEA=;
        b=B8lJWYRslFfmnZRMNrhVfkxmfp4MFiFQw1YP0x5TKFi1oeC7TCND4+2D3S910wYBj1
         xkftjqHwg81TT5F7Eu7d8F5vUWc7vvBVZTyEM2EQKq6aNnmWGQw9Xv/LkIPIUACgpzR3
         3OOhXNQEkTopGcMFBGmwA+5Q5kQkQ4VXn4GaxdOlsPDqRwx7yFZfaG6e0cuV1rJTFVcD
         i/6PcrGH7p+CCdxEGRFAIkmgfA6n4WMBgTorYalHPtmJJuRnCUePdFpHJXcQlENclB9p
         jkv1+FcUnY1e/HMpqaY7hEuAPm85tKM7jUitwDEvoLhh+06R2lBttlPQd14lM4l9gM1L
         iZkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lgTVaBNy62FaQXG4T7xAtsLpQb7SJOUo67w7wxLxPEA=;
        b=Aewj6fDhht8fu6V6VM6eDttFHf31UHGEF2twSmuebgwdkTMQ48ZSn07w5jJOWLBbv9
         b+WEACDmMKhadwVdu3dNZVOPF2q0hfAjvSNOSsugj9dCdsIxaG/hqydz2TN23+qxTbw7
         LO9E8QBuiSS87nh85YEw8JhveV/cAZtEWYMm25TNNz8IbWye/6Qp2eB/k3uDxitAWOR6
         hlHYtjpGOXGTNHVqawVZ6XHMjm9P+xeQNaXyQ3SvAhwwXio3CAR2OKPbBIQs/BxMCC4p
         /pDDbcnD5L+AdLzCnTgqSd42TYR/YdK0PTiaLz7rbga8zjmVJ4Fh3z73WoUQaozf4uEz
         uZug==
X-Gm-Message-State: AOAM530Aykk5HfKj4DDZI5W/bm+Zf9AWibvSImrCrqLZX2uC3VaXJElU
        0Upd/undZyLfCIljU2KOjHVkiagAWCeAREReeoDfHg==
X-Google-Smtp-Source: ABdhPJzdZxodEAfZsSGiMWKYWmBZtbZMMbxfaNo2TkklrGQdBeIRlu5Mhe/eB7JuNoJTwCVMn2xKbSEMlWhgFor9+gg=
X-Received: by 2002:a17:902:ead5:b029:e5:bd04:bf48 with SMTP id
 p21-20020a170902ead5b02900e5bd04bf48mr16013637pld.38.1615098686849; Sat, 06
 Mar 2021 22:31:26 -0800 (PST)
MIME-Version: 1.0
References: <20210307051433.2756645-1-maskray@google.com> <20210307062336.GD29191@gate.crashing.org>
In-Reply-To: <20210307062336.GD29191@gate.crashing.org>
From:   =?UTF-8?B?RsSBbmctcnXDrCBTw7JuZw==?= <maskray@google.com>
Date:   Sat, 6 Mar 2021 22:31:15 -0800
Message-ID: <CAFP8O3L91xzZtTQ3gDzpLE=-FvgM3ot5oaBK6jGUZbeT7Pg-RA@mail.gmail.com>
Subject: Re: [PATCH] Replace __toc_start + 0x8000 with .TOC.
To:     Segher Boessenkool <segher@kernel.crashing.org>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Alexey Kardashevskiy <aik@ozlabs.ru>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 6, 2021 at 10:25 PM Segher Boessenkool
<segher@kernel.crashing.org> wrote:
>
> Hi!
>
> On Sat, Mar 06, 2021 at 09:14:33PM -0800, Fangrui Song wrote:
> > TOC relocations are like GOT relocations on other architectures.
> > However, unlike other architectures, GNU ld's ppc64 port defines .TOC.
> > relative to the .got output section instead of the linker synthesized
> > .got input section. LLD defines .TOC. as the .got input section plus
> > 0x8000. When CONFIG_PPC_OF_BOOT_TRAMPOLINE=y,
> > arch/powerpc/kernel/prom_init.o is built, and LLD computed .TOC. can be
> > different from __toc_start defined by the linker script.
> >
> > Simplify kernel_toc_addr with asm label .TOC. so that we can get rid of
> > __toc_start.
> >
> > With this change, powernv_defconfig with CONFIG_PPC_OF_BOOT_TRAMPOLINE=y
> > is bootable with LLD. There is still an untriaged issue with Alexey's
> > configuration.
>
> Do you have any explanation why this *does* work, while the original
> doesn't?  Some explanation that says *what* is wrong.  To me it doesn't
> look like the kernel script is.
>
>
> Segher

The kernel code probably wants to access .TOC. (the TOC base symbol)
via __toc_start+0x8000.
If the kernel understood TOC base is different from the linker
understood TOC base (.TOC.), there should be a problem.
By using .TOC. in the kernel code, the two concepts are guaranteed to match.
