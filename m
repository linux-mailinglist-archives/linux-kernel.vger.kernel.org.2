Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67FA13145A2
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 02:30:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229851AbhBIBaD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 20:30:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbhBIBaC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 20:30:02 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECACDC061788
        for <linux-kernel@vger.kernel.org>; Mon,  8 Feb 2021 17:29:21 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id lw17so706006pjb.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Feb 2021 17:29:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=3BB8r2Xh3JusOcZJw/yjA416GCYQPgxgvzDoA5TTXR0=;
        b=CrJLNZssu+WGrZIJkQw44FIfx5dYnG8xsSrLlfBK3irS+EwMiPUZakiCgtjPe3jFJG
         YlwtGLP2BhpTlMPjra7DfATRyrEvyh1Uc63ZvV51us03Nkgs4lZxNuZBDaXBRVjF6aNF
         AsarGzU1tmIzxpxyC9hNEJsvZd4MRpNoGgapJZwwDEwOmkbzqbGCZqKaWD1+9IX2P/EC
         lqFBHnHVABnkGXOJuwUvu4GdHXm0yhiOIqg1KhF3Dzk2r/SgW0I+LKUgL6z0BlIf5t9J
         O7NtqtEVVwkHUfSjOf+Ftk24XKWHUk/ATTH1rg+/7VcbPc7Dzf4Bf7oBj0oTWQmrbcKi
         v4Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=3BB8r2Xh3JusOcZJw/yjA416GCYQPgxgvzDoA5TTXR0=;
        b=j34g7sH1rqavb8Qa/HsBRyu8cml1f+/dNTerOfvANGRoVx/nmNA5kyDNumIInOwLGy
         0Ppl2nzTvwDcYqkSyfUiV/48nHKZ1TbDOV+DDN4MMW15Ke8UD3G9QiTxM0ZeLG7347b2
         zJrQ3EqgVjzqLBgtZO7OaoQKilqFjLvAJ7f9WgAKmDrq0Hj+F9GAIWkexGWcmw+SCf7I
         2lFnDNsJ/FRsBE+zp8g9S4NDatmoIRwtmDVUWsWBN2Z3jtheI8jkqTXHCJpNa8aH28h0
         Ds8huhnI6PjY2cJzXP9NWuLAAl2Vk9W/srHmsdF69Bs5QTZ0WJjVBqftr8NjQ+wDKogw
         3TRw==
X-Gm-Message-State: AOAM530SKMHpt3t7l6ERKLfY03eFP+9cpMZhTIhUsZbshmHDow67b8BS
        rURnAkyHKwfxMycTIoc5PsA=
X-Google-Smtp-Source: ABdhPJxJUTJb88NIgdD4iksB3Zs6MUxdshLWdT982GjNJdD1J9N01MG9DlVMVF6FoVOFMJMt5IlMjQ==
X-Received: by 2002:a17:90a:ca8f:: with SMTP id y15mr1536276pjt.119.1612834161575;
        Mon, 08 Feb 2021 17:29:21 -0800 (PST)
Received: from localhost ([220.240.226.199])
        by smtp.gmail.com with ESMTPSA id 14sm19720222pfy.55.2021.02.08.17.29.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Feb 2021 17:29:20 -0800 (PST)
Date:   Tue, 09 Feb 2021 11:29:15 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v5 10/22] powerpc/syscall: Use is_compat_task()
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Michael Ellerman <mpe@ellerman.id.au>, msuchanek@suse.de,
        Paul Mackerras <paulus@samba.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <cover.1612796617.git.christophe.leroy@csgroup.eu>
        <c8094662199337a7200fea9f6e1d1f8b1b6d5f69.1612796617.git.christophe.leroy@csgroup.eu>
In-Reply-To: <c8094662199337a7200fea9f6e1d1f8b1b6d5f69.1612796617.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
Message-Id: <1612834040.k147utsmdf.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Excerpts from Christophe Leroy's message of February 9, 2021 1:10 am:
> Instead of hard comparing task flags with _TIF_32BIT, use
> is_compat_task(). The advantage is that it returns 0 on PPC32
> allthough _TIF_32BIT is always set.
>=20
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>


> ---
>  arch/powerpc/kernel/interrupt.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/arch/powerpc/kernel/interrupt.c b/arch/powerpc/kernel/interr=
upt.c
> index 2dac4d2bb1cf..46fd195ca659 100644
> --- a/arch/powerpc/kernel/interrupt.c
> +++ b/arch/powerpc/kernel/interrupt.c
> @@ -2,6 +2,8 @@
> =20
>  #include <linux/context_tracking.h>
>  #include <linux/err.h>
> +#include <linux/compat.h>
> +
>  #include <asm/asm-prototypes.h>
>  #include <asm/kup.h>
>  #include <asm/cputime.h>
> @@ -118,7 +120,7 @@ notrace long system_call_exception(long r3, long r4, =
long r5,
>  	/* May be faster to do array_index_nospec? */
>  	barrier_nospec();
> =20
> -	if (unlikely(is_32bit_task())) {
> +	if (unlikely(is_compat_task())) {
>  		f =3D (void *)compat_sys_call_table[r0];
> =20
>  		r3 &=3D 0x00000000ffffffffULL;
> --=20
> 2.25.0
>=20
>=20
