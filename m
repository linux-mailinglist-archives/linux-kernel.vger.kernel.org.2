Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 355803EA2A5
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 12:02:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236531AbhHLKBl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 06:01:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235554AbhHLKBk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 06:01:40 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A0CCC061765
        for <linux-kernel@vger.kernel.org>; Thu, 12 Aug 2021 03:01:15 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id g12-20020a17090a7d0cb0290178f80de3d8so9772922pjl.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 Aug 2021 03:01:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=+qsDiG/u0qNSqiYDob4m8A+UZvUspauBM/mjXqKH/5c=;
        b=m7QhLkXoY2rnV9J9PRrFWxJjqJAe+l9MpA3v6uvasoI3UQtP3htCsK63++BRTqBPv7
         qKlIlEdp9CG68czgxhsdmpEOTjrfUsmocvGroCO8QDuxlx9Pb5NV+7ImfBs3Crj64Wfr
         FPrAgH4zj9mU463gi4+0YtC2SlmulfIVm2oXfIRKLSVZjymnI6k6DyVgVaPBfEMLEc21
         Y5rTtCwMcnazAhDWsk/1VtJhiKmNZTP50K4AnkSHS4Xp0ahUeMde+P9qR88fa959GXwV
         2lXuPMR+YIPHA9xv+WOZxqdE+7S7AUGDrSomKoOYaPX2dfv9UrvY4YGsJULdYVGfr6+e
         IBcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=+qsDiG/u0qNSqiYDob4m8A+UZvUspauBM/mjXqKH/5c=;
        b=KsHAw1tyWcP34rPDXDS+8zPb2fKchAqKTgP8usCAMPYTMzsbFUErCJyzys+f+qgsty
         MpN9shdHlAMJfE/UmU9bXID4AcVSk0XtXoYWx8XPWvyYDDdsYQasCEw3BcUxj8PG/4si
         kPjwRZmAHOUwwNu+g/N0RH9oREpd05p+cfDj+RO6UHRBezlSZxB11+2j2q9aruM3ndcB
         KBbNIR+JniRFhgUQkBx67WgDiWyI7xpLkfT5OvaoSOIqjORQqIQJp/TRWMsqrhqLWdgW
         Nu4HrEU7FiYjeEPaS4iMbYrJ5a9AgfYxp+iL0BkXom8CSLw7GB67SITdm8EMnMk6l191
         XVZQ==
X-Gm-Message-State: AOAM532rPY2JYbB0/vDTdjFL/OKSYfVwEMWdv+5eQHq+EpNrP/L+nnmT
        10qg122sqS3pCI6xCdWcBBY=
X-Google-Smtp-Source: ABdhPJzOkUaqI03B0VQXdonY74JRw1ZY7dHfwTV1vXCDirOP5Pgv0GRN8j6MkHfK3q3Uhzv2JzVedw==
X-Received: by 2002:a65:6459:: with SMTP id s25mr3208005pgv.7.1628762474171;
        Thu, 12 Aug 2021 03:01:14 -0700 (PDT)
Received: from localhost ([118.210.97.79])
        by smtp.gmail.com with ESMTPSA id w3sm1781812pfn.96.2021.08.12.03.01.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Aug 2021 03:01:13 -0700 (PDT)
Date:   Thu, 12 Aug 2021 20:01:08 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH] powerpc/interrupt: Do not call single_step_exception()
 from other exceptions
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        fthain@linux-m68k.org, Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>, userm57@yahoo.com
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <aed174f5cbc06f2cf95233c071d8aac948e46043.1628611921.git.christophe.leroy@csgroup.eu>
In-Reply-To: <aed174f5cbc06f2cf95233c071d8aac948e46043.1628611921.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
Message-Id: <1628762462.y419h5w2nx.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Excerpts from Christophe Leroy's message of August 11, 2021 2:13 am:
> single_step_exception() is called by emulate_single_step() which
> is called from (at least) alignment exception() handler and
> program_check_exception() handler.
>=20
> Redefine it as a regular __single_step_exception() which is called
> by both single_step_exception() handler and emulate_single_step()
> function.
>=20

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

> Fixes: 3a96570ffceb ("powerpc: convert interrupt handlers to use wrappers=
")
> Cc: stable@vger.kernel.org
> Cc: Stan Johnson <userm57@yahoo.com>
> Cc: Nicholas Piggin <npiggin@gmail.com>
> Cc: Finn Thain <fthain@linux-m68k.org>
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> ---
>  arch/powerpc/kernel/traps.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>=20
> diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
> index dfbce527c98e..d56254f05e17 100644
> --- a/arch/powerpc/kernel/traps.c
> +++ b/arch/powerpc/kernel/traps.c
> @@ -1104,7 +1104,7 @@ DEFINE_INTERRUPT_HANDLER(RunModeException)
>  	_exception(SIGTRAP, regs, TRAP_UNK, 0);
>  }
> =20
> -DEFINE_INTERRUPT_HANDLER(single_step_exception)
> +static void __single_step_exception(struct pt_regs *regs)
>  {
>  	clear_single_step(regs);
>  	clear_br_trace(regs);
> @@ -1121,6 +1121,11 @@ DEFINE_INTERRUPT_HANDLER(single_step_exception)
>  	_exception(SIGTRAP, regs, TRAP_TRACE, regs->nip);
>  }
> =20
> +DEFINE_INTERRUPT_HANDLER(single_step_exception)
> +{
> +	__single_step_exception(regs);
> +}
> +
>  /*
>   * After we have successfully emulated an instruction, we have to
>   * check if the instruction was being single-stepped, and if so,
> @@ -1130,7 +1135,7 @@ DEFINE_INTERRUPT_HANDLER(single_step_exception)
>  static void emulate_single_step(struct pt_regs *regs)
>  {
>  	if (single_stepping(regs))
> -		single_step_exception(regs);
> +		__single_step_exception(regs);
>  }
> =20
>  static inline int __parse_fpscr(unsigned long fpscr)
> --=20
> 2.25.0
>=20
>=20
