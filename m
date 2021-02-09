Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F4BD314585
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 02:20:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230187AbhBIBUZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 20:20:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230252AbhBIBUQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 20:20:16 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36E3FC06178B
        for <linux-kernel@vger.kernel.org>; Mon,  8 Feb 2021 17:19:36 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id r38so11391824pgk.13
        for <linux-kernel@vger.kernel.org>; Mon, 08 Feb 2021 17:19:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=Q25NbHCvK7gvqlVtxwQxq2G5AgI2+835a54bSQpwDn0=;
        b=fVBcLtfSVh1eW6bR54qV61lT9c/3yOfFkQsVpj8aDzy7yF4JM51WSb78nXq2BP4l8K
         Sc6+GYZNMiGfdAzO+kPOxom2yHpPAGF0uKMSOrkOR0ufL9tEd6nYPp2996EHlR+N95O3
         OyGJoIy22guFiH0zI9nEN7AW+c4iKCuVXeV5u/V1rmNOhPaug0POjvt/VLMshYfB97vj
         YZw7h9QaWbUxeGAt+KNe2j7AkLQx6bjUmRix2etrBdNa8HQU50fQdEWzbE9uIVZJpxM7
         u77jpzh12Ubum+RoepuJCgUJd3Uk3R9CU4Jyl8iNfwUrammzHO2BJvgC7GA1vi1an+s7
         I5Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=Q25NbHCvK7gvqlVtxwQxq2G5AgI2+835a54bSQpwDn0=;
        b=NGP44cheWi4rpLBHux2UWpGoZtN/iA2quwMY7C9FKaWtsqobv6O9TvVkpL0glWlFe+
         gTJnyvax+eKuSVMpjwUrtnikL/cOArEYMblXa531KIa48gHbYan1rUJ7zyrsOOufWUbA
         m7IqorsA3HgNwu2mFHcf3qKW/hM0WwNIFfZo6pi0/Aqc+QVnmfmET8huPMVuS0xDkCrZ
         wz4WaUsxXYXBwt8tZoCNwdMGk/2VU6ui6DuvCd5Qay6D/K7nVWC5NqahMYx2CRQpffuW
         ar61voP+pCYj4MHiR/0ba5EQS/J3WiQjBvKaFKm4ObXdrdaDitGI1It9eSNcsGYc/uJ8
         Fktg==
X-Gm-Message-State: AOAM532BV8E6HmozNmoUSzuFjPJCpByIzfjXgpv5XEBi8ryCy24kQFiD
        FvpJ7OzcGpgcPqh4NxXh6GmydtZZIYGNIA==
X-Google-Smtp-Source: ABdhPJzo7j0aNVm/5aQtvGOfxjMGTHBx6h3FhDPMEKMjhASiAoAzlgfYIRECX8l6+Hb6vBjvgl8C5Q==
X-Received: by 2002:a63:545f:: with SMTP id e31mr17576118pgm.212.1612833575735;
        Mon, 08 Feb 2021 17:19:35 -0800 (PST)
Received: from localhost ([220.240.226.199])
        by smtp.gmail.com with ESMTPSA id b15sm14391884pgj.84.2021.02.08.17.19.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Feb 2021 17:19:34 -0800 (PST)
Date:   Tue, 09 Feb 2021 11:19:29 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v5 07/22] powerpc/irq: Add stub irq_soft_mask_return() for
 PPC32
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Michael Ellerman <mpe@ellerman.id.au>, msuchanek@suse.de,
        Paul Mackerras <paulus@samba.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <cover.1612796617.git.christophe.leroy@csgroup.eu>
        <9b9f62c5e2e63cc121fd749a923aaaee92ee0da4.1612796617.git.christophe.leroy@csgroup.eu>
In-Reply-To: <9b9f62c5e2e63cc121fd749a923aaaee92ee0da4.1612796617.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
Message-Id: <1612833316.dhtxt2p9gu.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Excerpts from Christophe Leroy's message of February 9, 2021 1:10 am:
> To allow building syscall_64.c smoothly on PPC32, add stub version
> of irq_soft_mask_return().
>=20
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>

Same kind of comment as the other soft mask stuff. Again not a big deal=20
but there might be a way to improve it. For example make a
debug_syscall_entry(regs) function that ppc64 could put the soft mask
checks into.

No big deal, if you don't make any changes now I might see about doing=20
something like that after your series goes in.

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

> ---
>  arch/powerpc/include/asm/hw_irq.h | 5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/arch/powerpc/include/asm/hw_irq.h b/arch/powerpc/include/asm=
/hw_irq.h
> index 4739f61e632c..56a98936a6a9 100644
> --- a/arch/powerpc/include/asm/hw_irq.h
> +++ b/arch/powerpc/include/asm/hw_irq.h
> @@ -330,6 +330,11 @@ static inline void irq_soft_mask_regs_set_state(stru=
ct pt_regs *regs, unsigned l
>  }
>  #else /* CONFIG_PPC64 */
> =20
> +static inline notrace unsigned long irq_soft_mask_return(void)
> +{
> +	return 0;
> +}
> +
>  static inline unsigned long arch_local_save_flags(void)
>  {
>  	return mfmsr();
> --=20
> 2.25.0
>=20
>=20
