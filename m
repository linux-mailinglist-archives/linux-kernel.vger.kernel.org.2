Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8815539F820
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 15:51:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233062AbhFHNw5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 09:52:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232869AbhFHNw4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 09:52:56 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89ACBC061574
        for <linux-kernel@vger.kernel.org>; Tue,  8 Jun 2021 06:50:48 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id i10so32211052lfj.2
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jun 2021 06:50:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AwGQ9lwxbFaU7D5ZRXGobTrptAq9qDG9oA6hNsu1LWM=;
        b=bHOW7xBxGKOFm9Ut4rviNDROtHfcYn/sBInsssIm0k8oTjsGPRwov6xxbXMskEzGNx
         4IXFlztwV8zYgusuMZ+IgS0ZaoIRPW5AWJi6NFSqeTaiZ9QjHBNZv340ATz4Sq1FGQE0
         BC4BQxYsc5Aadl/S8ShGUQbdlStf0WEn0h+QsEDgyyZMp/Ek3CF3/jFAaQYN4ehCFI7p
         f7tkarlFC9lAKv7O3EwZWW49t33PpfPXjF87obCI+B3P//XekM60XOiqvi2lXEkcig38
         zEMVdgdYq+vzqqhFV3MADVMGXl2m1Cl8YgLb3eZUeEeysUaeKlehjojHmJRK+F45BO17
         5R1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AwGQ9lwxbFaU7D5ZRXGobTrptAq9qDG9oA6hNsu1LWM=;
        b=KxaRZKicm7nvubtksFxJ/dHlvVNl8hbRElf1sOSlqu1mFiKNkIyJnKJjevrAAstYyZ
         MSvgeGxM+emBBcwKBWABdjHIXd5Vtp77FZhtIF5ii30zH27fESTRg2GeFBITfZS4H9+f
         eR5n6rjamg8iT9OpacSEWwoZYJnZ3k+sQtC3VfaxgU16AlSNyRp6mQU3G8v2Hcwg5N70
         5PKrwS6mTPBXfD2AkIaaTfrO4d/qdobUwvJliKCJUOJbtswfbGSdqS0HVqbTLZSa9Atn
         +34SbX9bkLV2MRFt20VK7L6Q6BdHy3XoeLvUovYnZS5CNZ0WpvEF3jvWI9IDXYmVZwt6
         BaLQ==
X-Gm-Message-State: AOAM530cKO+JDjVCgwVZWP5wRX03y/tG7ImyP+8Kk3KjEDDT+x0IbHyW
        S7idfdYi+Bq4PAZuqBbhhAQ=
X-Google-Smtp-Source: ABdhPJyNpRJAkDBQxxif0U3UufhE3px3HqwZoztmhjYcQS/sNDgBdm/16qPp7W2BTNupml5pZYB2Ug==
X-Received: by 2002:a19:c30c:: with SMTP id t12mr15704304lff.259.1623160246903;
        Tue, 08 Jun 2021 06:50:46 -0700 (PDT)
Received: from hyperiorarchmachine.localnet (dcx7x4yb9bh06yk5jm2qt-3.rev.dnainternet.fi. [2001:14ba:14f7:3c00:3d09:bda0:2327:559b])
        by smtp.gmail.com with ESMTPSA id l3sm2043507lfe.230.2021.06.08.06.50.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 06:50:46 -0700 (PDT)
From:   jarmo.tiitto@gmail.com
To:     Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <nathan@kernel.org>,
        clang-built-linux@googlegroups.com, Bill Wendling <wcw@google.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org
Cc:     morbo@google.com, Jarmo Tiitto <jarmo.tiitto@gmail.com>
Subject: Re: [PATCH v3 1/1] pgo: Fix sleep in atomic section in prf_open() v3
Date:   Tue, 08 Jun 2021 16:50:45 +0300
Message-ID: <1989067.FY1I2HCei6@hyperiorarchmachine>
In-Reply-To: <162310696843.3797458.16031727600580374864.b4-ty@chromium.org>
References: <20210605183128.129614-1-jarmo.tiitto@gmail.com> <162310696843.3797458.16031727600580374864.b4-ty@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kees Cook wrote tiistaina 8. kes=C3=A4kuuta 2021 2.02.51 EEST:
> On Sat, 5 Jun 2021 21:31:29 +0300, Jarmo Tiitto wrote:
> > In prf_open() the required buffer size can be so large that
> > vzalloc() may sleep thus triggering bug:
> >=20
> > =3D=3D=3D=3D=3D=3D
> >=20
> >  BUG: sleeping function called from invalid context at
> >  include/linux/sched/mm.h:201 in_atomic(): 1, irqs_disabled(): 1,
> >  non_block: 0, pid: 337, name: cat CPU: 1 PID: 337 Comm: cat Not tainted
> >  5.13.0-rc2-24-hack+ #154
> >  Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 0.0.0 02/06/2=
015
> > =20
> >  Call Trace:
> >   dump_stack+0xc7/0x134
> >   ___might_sleep+0x177/0x190
> >   __might_sleep+0x5a/0x90
> >   kmem_cache_alloc_node_trace+0x6b/0x3a0
> >   ? __get_vm_area_node+0xcd/0x1b0
> >   ? dput+0x283/0x300
> >   __get_vm_area_node+0xcd/0x1b0
> >   __vmalloc_node_range+0x7b/0x420
> >   ? prf_open+0x1da/0x580
> >   ? prf_open+0x32/0x580
> >   ? __llvm_profile_instrument_memop+0x36/0x50
> >   vzalloc+0x54/0x60
> >   ? prf_open+0x1da/0x580
> >   prf_open+0x1da/0x580
> >   full_proxy_open+0x211/0x370
> >   ....
> >=20
> > =3D=3D=3D=3D=3D=3D
> >=20
> > [...]
>=20
> Applied to for-next/clang/features, thanks! I made some additional tweaks
> on top of this, in a separate patch I just sent out.
>=20
> [1/1] pgo: Fix sleep in atomic section in prf_open() v3
>       https://git.kernel.org/kees/c/d13b0485a7bb
>=20
> --
> Kees Cook

Oof. Looking now at your fixes, I'm sorry for the extra work needed. :-|
I should have cleaned up the error paths better, since that was mentioned=20
earlier.
My eyes were apparently pointed on the v2 module profiling code I have been=
=20
brewing the past weekend.=20

Thanks!
=2D-
Jarmo



