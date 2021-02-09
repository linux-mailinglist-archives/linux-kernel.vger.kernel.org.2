Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B7163145A4
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 02:30:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230054AbhBIBaa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 20:30:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbhBIBa1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 20:30:27 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96FDCC061786
        for <linux-kernel@vger.kernel.org>; Mon,  8 Feb 2021 17:29:47 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id b8so8812547plh.12
        for <linux-kernel@vger.kernel.org>; Mon, 08 Feb 2021 17:29:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=0H+UcHXc0T0Hzs8GkN3sRs6CKrIAKPFmzn4TQbxmO7M=;
        b=KeG0M8ZieeBu/SsqRk/HCFfir4K98AM3ocyjGEhadP4MgpkB+k5k0qqht6gA+iV1yJ
         JZnJb746dhFLbS02uTMuP4yZTCzvPxIC/UxLXYRXuZK9BnCTx2w1wuVxGDL//ZTinvle
         fF86f8G3MFsyfpzuzaNsFBXHGhjn+S/OoYTcyYkUueMineEVfbVx9/Gr4uPnBp3mXjaB
         70EJntHYYVHOrQFEpqgumrkE0fbbOjBz6VbYYNzQXTsrQVhGbHuyJplTeYPwxVXhFOcF
         /2TaGT2TaEv5zKia4g3y/V6hewwC8MOBZfKMTw2QL2p99YvUL7XMTzgkTkzR32OisMu2
         JdEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=0H+UcHXc0T0Hzs8GkN3sRs6CKrIAKPFmzn4TQbxmO7M=;
        b=Bk1WrfCR7XDJwYNBnVndV+q3j7NejawMpNErYB28E9+rLKm51Z3hhqE0uavTO6UVB1
         GudQkd64DA5CeaCtxz7KdB5W2JPT+FRqNW5DkWkJR5VrnVOgg/cZp3dYt2l4tXh7yT5m
         OHEgkKj7eSAc9T3XC0uhKFSRQxdk7ut4vBnt8jXnVnzN5d15mz7/BpZHVz283FhP0Z8I
         PRvqrsZVb+jw7vQOZ2/dyqaNlwpQRPy/iHCo3yZnfMJPzBoKk7XYBgiYybDg+CPEew09
         cRVpTG/ZCoDCGrj6nsj6HXLZw+o6vFchiGvAleVUnBxAHrVbCjwUkzkoV0shPHSRLQjt
         TFRQ==
X-Gm-Message-State: AOAM532ECF6Hi34KrwvAIfU8C4tnO6wkLSsqNyf3x4v9a3sYYR7N+fMY
        Fsamayq6mv106fjdkTei6yg=
X-Google-Smtp-Source: ABdhPJzZDCTiTRsiqzRDENBV7cojfewrYQOjo8/jteVxFcY+2p8vgBCT7O7QUANeC4+r47sUQTU/rQ==
X-Received: by 2002:a17:90a:a22:: with SMTP id o31mr1487149pjo.221.1612834187264;
        Mon, 08 Feb 2021 17:29:47 -0800 (PST)
Received: from localhost ([220.240.226.199])
        by smtp.gmail.com with ESMTPSA id d12sm6254201pgm.83.2021.02.08.17.29.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Feb 2021 17:29:46 -0800 (PST)
Date:   Tue, 09 Feb 2021 11:29:41 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v5 11/22] powerpc/syscall: Save r3 in regs->orig_r3
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Michael Ellerman <mpe@ellerman.id.au>, msuchanek@suse.de,
        Paul Mackerras <paulus@samba.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <cover.1612796617.git.christophe.leroy@csgroup.eu>
        <9a90805ab6b9101b46daf56470f457a57acd86fc.1612796617.git.christophe.leroy@csgroup.eu>
In-Reply-To: <9a90805ab6b9101b46daf56470f457a57acd86fc.1612796617.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
Message-Id: <1612834174.puqh8atps5.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Excerpts from Christophe Leroy's message of February 9, 2021 1:10 am:
> Save r3 in regs->orig_r3 in system_call_exception()
>=20
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

> ---
> v5: Removed the assembly one on SCV type system call
> ---
>  arch/powerpc/kernel/entry_64.S  | 2 --
>  arch/powerpc/kernel/interrupt.c | 2 ++
>  2 files changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_6=
4.S
> index 33ddfeef4fe9..a91c2def165d 100644
> --- a/arch/powerpc/kernel/entry_64.S
> +++ b/arch/powerpc/kernel/entry_64.S
> @@ -108,7 +108,6 @@ END_FTR_SECTION_IFSET(CPU_FTR_TM)
>  	li	r11,\trapnr
>  	std	r11,_TRAP(r1)
>  	std	r12,_CCR(r1)
> -	std	r3,ORIG_GPR3(r1)
>  	addi	r10,r1,STACK_FRAME_OVERHEAD
>  	ld	r11,exception_marker@toc(r2)
>  	std	r11,-16(r10)		/* "regshere" marker */
> @@ -278,7 +277,6 @@ END_BTB_FLUSH_SECTION
>  	std	r10,_LINK(r1)
>  	std	r11,_TRAP(r1)
>  	std	r12,_CCR(r1)
> -	std	r3,ORIG_GPR3(r1)
>  	addi	r10,r1,STACK_FRAME_OVERHEAD
>  	ld	r11,exception_marker@toc(r2)
>  	std	r11,-16(r10)		/* "regshere" marker */
> diff --git a/arch/powerpc/kernel/interrupt.c b/arch/powerpc/kernel/interr=
upt.c
> index 46fd195ca659..1a2dec49f811 100644
> --- a/arch/powerpc/kernel/interrupt.c
> +++ b/arch/powerpc/kernel/interrupt.c
> @@ -29,6 +29,8 @@ notrace long system_call_exception(long r3, long r4, lo=
ng r5,
>  {
>  	syscall_fn f;
> =20
> +	regs->orig_gpr3 =3D r3;
> +
>  	if (IS_ENABLED(CONFIG_PPC_IRQ_SOFT_MASK_DEBUG))
>  		BUG_ON(irq_soft_mask_return() !=3D IRQS_ALL_DISABLED);
> =20
> --=20
> 2.25.0
>=20
>=20
