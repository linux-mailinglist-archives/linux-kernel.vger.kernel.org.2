Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EDE9372894
	for <lists+linux-kernel@lfdr.de>; Tue,  4 May 2021 12:14:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230213AbhEDKPd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 May 2021 06:15:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230212AbhEDKPa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 06:15:30 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66941C061761
        for <linux-kernel@vger.kernel.org>; Tue,  4 May 2021 03:14:31 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id i13so6962334pfu.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 May 2021 03:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=7iDm+iy2vv0gvGhRKV9ucXH0e1bBgrE+86qry7t/ENk=;
        b=oM+ogurNOu4EOIZYwS8ZYM5Y409XYeBzXlWzgGM/pFIGDYlVjmuHgsP3Pkmc8aeDa4
         zaXjsBCEilPgNNHXLevQnq5Trb/duTBGWwcODXkYn3Q+uUimppR2Q4pecRdp7pDrQETM
         3fkTSwMRnnKj3d0EkQUGHebEefKSCtbGH4C1L2JsWsF6tGnW42yeLyFAnCw134HnYZg5
         Hy1D6jBkzyXwftlsAQbjzRBValsXd41hoM0wJJtOgvdy+CbwNnlt+8EUowFXXRg30G74
         0flltxjqjiDWfffqf/TV8anjqD5eIEAjdVswqdE4gea6hvSkqFOgJ7VZEAmfotVKMgbN
         kImg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=7iDm+iy2vv0gvGhRKV9ucXH0e1bBgrE+86qry7t/ENk=;
        b=gpydkY1ZzI49YG16hAkuPRo9JZBQfFU/d7yrKyk/E2tDbYg5n6Wb9B0P6YzPu6AIXX
         YupCtRsyQ9KVUd+WgTcFZyyjt/YMga0DrVfcA081teFvMsd+5g1UqR5I4RXxPabpNLxu
         os9NkyGHR3uBgCtQ34NnQ9GNT0toyna6UAJXROCpghlnVBIAyYCbVjqxxXLWmdoUbqqo
         xUbfkEBQdRMt0RK3BmLyCtIAn8alqGzMfgaZ+ttX1jGxDxvQ5hVh2ao5bG7XIXD8VB+w
         eDUS8Fxq7rzgFp/BDcWOqAgwbDWlO+MSq3XEdf+P8sfFBSJ8mxHwdLFvhCov4EiLqS5L
         IUtg==
X-Gm-Message-State: AOAM530MMGesYTZU/eE29ESL0IA8nO/nb+p/XeYZOtjHdwnKzN7qHgtE
        46Se2Cjh+idkNiHyGi7zsTjs+rD2vm4=
X-Google-Smtp-Source: ABdhPJwiTsfdvzaek4HRxZWtS8iwwUxU5lEhEvjHJfL72LY74TF7US11zYha5XrWIvKQImAPlfz+IA==
X-Received: by 2002:a63:2d47:: with SMTP id t68mr22775932pgt.416.1620123271078;
        Tue, 04 May 2021 03:14:31 -0700 (PDT)
Received: from localhost ([61.68.127.20])
        by smtp.gmail.com with ESMTPSA id bx12sm3117557pjb.1.2021.05.04.03.14.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 May 2021 03:14:30 -0700 (PDT)
Date:   Tue, 04 May 2021 20:14:25 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH 2/2] powerpc/paca: Remove mm_ctx_id and
 mm_ctx_slb_addr_limit
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <f38728dbe96df5fef84c868640def5f6d7c114bc.1620060357.git.christophe.leroy@csgroup.eu>
        <cc8bc507cce433bc9bbfe86f6fc22b29ce21d461.1620060357.git.christophe.leroy@csgroup.eu>
In-Reply-To: <cc8bc507cce433bc9bbfe86f6fc22b29ce21d461.1620060357.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
Message-Id: <1620123253.cqvw3t8th6.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Excerpts from Christophe Leroy's message of May 4, 2021 2:46 am:
> mm_ctx_id and mm_ctx_slb_addr_limit are not used anymore.
>=20
> Remove them.
>=20
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

> ---
>  arch/powerpc/include/asm/paca.h | 2 --
>  arch/powerpc/kernel/paca.c      | 2 --
>  2 files changed, 4 deletions(-)
>=20
> diff --git a/arch/powerpc/include/asm/paca.h b/arch/powerpc/include/asm/p=
aca.h
> index ec18ac818e3a..ecc8d792a431 100644
> --- a/arch/powerpc/include/asm/paca.h
> +++ b/arch/powerpc/include/asm/paca.h
> @@ -149,11 +149,9 @@ struct paca_struct {
>  #endif /* CONFIG_PPC_BOOK3E */
> =20
>  #ifdef CONFIG_PPC_BOOK3S
> -	mm_context_id_t mm_ctx_id;
>  #ifdef CONFIG_PPC_MM_SLICES
>  	unsigned char mm_ctx_low_slices_psize[BITS_PER_LONG / BITS_PER_BYTE];
>  	unsigned char mm_ctx_high_slices_psize[SLICE_ARRAY_SIZE];
> -	unsigned long mm_ctx_slb_addr_limit;
>  #else
>  	u16 mm_ctx_user_psize;
>  	u16 mm_ctx_sllp;
> diff --git a/arch/powerpc/kernel/paca.c b/arch/powerpc/kernel/paca.c
> index 7f5aae3c387d..9bd30cac852b 100644
> --- a/arch/powerpc/kernel/paca.c
> +++ b/arch/powerpc/kernel/paca.c
> @@ -346,10 +346,8 @@ void copy_mm_to_paca(struct mm_struct *mm)
>  #ifdef CONFIG_PPC_BOOK3S
>  	mm_context_t *context =3D &mm->context;
> =20
> -	get_paca()->mm_ctx_id =3D context->id;
>  #ifdef CONFIG_PPC_MM_SLICES
>  	VM_BUG_ON(!mm_ctx_slb_addr_limit(context));
> -	get_paca()->mm_ctx_slb_addr_limit =3D mm_ctx_slb_addr_limit(context);
>  	memcpy(&get_paca()->mm_ctx_low_slices_psize, mm_ctx_low_slices(context)=
,
>  	       LOW_SLICE_ARRAY_SZ);
>  	memcpy(&get_paca()->mm_ctx_high_slices_psize, mm_ctx_high_slices(contex=
t),
> --=20
> 2.25.0
>=20
>=20
