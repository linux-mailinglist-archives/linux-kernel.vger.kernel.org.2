Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDC7D31458A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 02:23:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230133AbhBIBUu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 20:20:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230307AbhBIBUh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 20:20:37 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF043C061786
        for <linux-kernel@vger.kernel.org>; Mon,  8 Feb 2021 17:19:56 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id s15so8809352plr.9
        for <linux-kernel@vger.kernel.org>; Mon, 08 Feb 2021 17:19:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=t54yD33kVzyBqW7tMjZSfob5XimxFTzloqgNh2ZBkpc=;
        b=QbCjiqa1GR9ANuY9aAYxYU2y3FOXpTUKG5caTMncO1rAvEg+YCngOgjLN9F6HHkH08
         4VDBP1nG3zkWzSDRrLE0tWi2QH4GFwHwcncu1SsB9qRhVIu9JXFS/8hF0ZeEI1Y45E1D
         Ueig+tWKnjicLCY3AHxO7FzGOIR3t4vAVK/oEnwzTZLLzUBh3guBmW9f2d8EhJCnc/Uy
         gQYYF7eVgGqj2G0WMg8AtATPzpiSNc9IkxyoxxyLD9Ga0ahGqSxmAVPDg5NQVb3txUIp
         glaN2lp5SpNdZuZugCN85gO9kY7HCAlw6+8Rr0BZgSWL9+DUcIIpqW/Dqt0iJG5+fzlh
         16Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=t54yD33kVzyBqW7tMjZSfob5XimxFTzloqgNh2ZBkpc=;
        b=CAhXvVAzqR/tc5C9LhHBCvWThVPdz9dn7li9/f6CTdNLXGAbQBVVH/WMR9zpoJnDD3
         RN5YMGYnnEGWrmaeJSX0CQDUCLH903KqzL0DAjfjZU8zNKvj0dqUa/Y3kk1Jc+wG2Y2j
         DzSRz9dG0ZMqUt1hdmZnvgVtI/b2b8oIhLqvnS9vGauKYcE+htZqHoHX/Mb7LP3+XBwP
         7xRkRSKTCeVffM7YsqY7WAn8iUOzGDjiELkcw2EtVFVuBo3STdeiPa3zLTKH2tMox28+
         /Yj+Uhpm3Ot/0ABvTQvzMS4s33JL9nspaZn4YDVwkL4EPGtBaFuwyA4uxYrD2B5NY/jq
         pfKw==
X-Gm-Message-State: AOAM532n+zuBN4sVHCtckvlrrQbnH4jQ+NQfi2w0fL9uu5JCtVX5L7qe
        kSnhXI8pXIVzztMTBtPfcKY=
X-Google-Smtp-Source: ABdhPJxNYfPLoE77uKkmqyRjXbZzA6/RT6tUkJ1p3/P+GtVV2HMvYxEnZdxsS6R3Mjya3q337Teg2Q==
X-Received: by 2002:a17:903:18c:b029:e1:f4f0:dc26 with SMTP id z12-20020a170903018cb02900e1f4f0dc26mr18862677plg.22.1612833596415;
        Mon, 08 Feb 2021 17:19:56 -0800 (PST)
Received: from localhost ([220.240.226.199])
        by smtp.gmail.com with ESMTPSA id 3sm230108pjk.26.2021.02.08.17.19.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Feb 2021 17:19:55 -0800 (PST)
Date:   Tue, 09 Feb 2021 11:19:50 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v5 08/22] powerpc/syscall: Rename syscall_64.c into
 interrupt.c
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Michael Ellerman <mpe@ellerman.id.au>, msuchanek@suse.de,
        Paul Mackerras <paulus@samba.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <cover.1612796617.git.christophe.leroy@csgroup.eu>
        <cddc2deaa8f049d3ec419738e69804934919b935.1612796617.git.christophe.leroy@csgroup.eu>
In-Reply-To: <cddc2deaa8f049d3ec419738e69804934919b935.1612796617.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
Message-Id: <1612833574.78p5tc9eia.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Excerpts from Christophe Leroy's message of February 9, 2021 1:10 am:
> syscall_64.c will be reused almost as is for PPC32.
>=20
> As this file also contains functions to handle other types
> of interrupts rename it interrupt.c
>=20
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

> ---
>  arch/powerpc/kernel/Makefile                      | 2 +-
>  arch/powerpc/kernel/{syscall_64.c =3D> interrupt.c} | 0
>  2 files changed, 1 insertion(+), 1 deletion(-)
>  rename arch/powerpc/kernel/{syscall_64.c =3D> interrupt.c} (100%)
>=20
> diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefile
> index c173efd66c00..26ff8c6e06b7 100644
> --- a/arch/powerpc/kernel/Makefile
> +++ b/arch/powerpc/kernel/Makefile
> @@ -60,7 +60,7 @@ obj-y				:=3D cputable.o syscalls.o \
>  				   hw_breakpoint_constraints.o
>  obj-y				+=3D ptrace/
>  obj-$(CONFIG_PPC64)		+=3D setup_64.o \
> -				   paca.o nvram_64.o note.o syscall_64.o
> +				   paca.o nvram_64.o note.o interrupt.o
>  obj-$(CONFIG_COMPAT)		+=3D sys_ppc32.o signal_32.o
>  obj-$(CONFIG_VDSO32)		+=3D vdso32_wrapper.o
>  obj-$(CONFIG_PPC_WATCHDOG)	+=3D watchdog.o
> diff --git a/arch/powerpc/kernel/syscall_64.c b/arch/powerpc/kernel/inter=
rupt.c
> similarity index 100%
> rename from arch/powerpc/kernel/syscall_64.c
> rename to arch/powerpc/kernel/interrupt.c
> --=20
> 2.25.0
>=20
>=20
