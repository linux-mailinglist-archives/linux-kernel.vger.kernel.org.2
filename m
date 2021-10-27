Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2FD643C1CE
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 06:44:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235671AbhJ0Eqm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 00:46:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230423AbhJ0Eqk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 00:46:40 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ABD9C061570
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 21:44:16 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id n36-20020a17090a5aa700b0019fa884ab85so4100130pji.5
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 21:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=L1HDK0O4PEJoarjnPknLHYAOD4FQi97D4WgPJm/h2O0=;
        b=aF8Oc8xkcC5MJZgDlZadb08Tqx1xs3OwiePcljjlfGFiCBCkVG4NcHfdP0WK0eU3ZR
         OMQmE07XJ3wMD/PDfs/RiaiVQKxEGAhxE17RQCN1mgheH7f37v3bj6eYIJpnjIHqN+1y
         sLN9eq/B595qXaJ9RdJlCfNczSia62mnrJPlrmkd5LEPeq9QqgcsuFOx9Jl6SA75HFcR
         mO25FgVm/17A1mYTC2UsWLls47w3b9hXCip1pkqWXUylcwtbLXYM/scqBVvinkZZH+n5
         2bBnwvDCUBTLp+QvCKfP6eZLBKtmHeeTpZjbSNIJHFAw0VrCuQ36j2WKZSbmBby62zQp
         OMbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=L1HDK0O4PEJoarjnPknLHYAOD4FQi97D4WgPJm/h2O0=;
        b=p/4vJy3kpXp4T8/OxgjZw6N1OITGFNY2U6JlEOSv2b8B5al2bjdgig0cDCe9ZZGoPG
         A29c3SF1NO5JH5MT7J4rLQWGIuU85U81wm0GrZmfjpi2ECfzyYcwxArXW4vJP+sWjlTF
         itqr1yJ80aKM/0x5GVXIumNRo469LZ5epYJ4X9VCp5tR2LXGN9d7Mhp18i1LdnMittVX
         4rW7GdZWUvwkbUZ476R7HPvwfUf04YDwhCjySqY5Dw+uqIHZqgL+PE32kaBfh1jYJge+
         0WCbZ52IVYgAQm+YnWSCKJZ99qD//t9qohjRgiZ7bsfDKXloWlRxKVcj2JuzjnRpUhuc
         cOuA==
X-Gm-Message-State: AOAM531UKeFfr0m0n8+XbECT5pE1yjebdnFM7XXMy0mPzAYqCk5/fASU
        CjhJkBXbGWUpY2ByFwxf8FI=
X-Google-Smtp-Source: ABdhPJy9trhlf3yZoe/kM+w0ybtSLtdBKEjAI2QoTaxq6oILbWQdvt5WnLT4gBK5jfynI8CDxxaLuA==
X-Received: by 2002:a17:90b:d96:: with SMTP id bg22mr2871547pjb.221.1635309855618;
        Tue, 26 Oct 2021 21:44:15 -0700 (PDT)
Received: from localhost ([118.208.159.180])
        by smtp.gmail.com with ESMTPSA id a3sm27234221pfv.174.2021.10.26.21.44.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Oct 2021 21:44:15 -0700 (PDT)
Date:   Wed, 27 Oct 2021 14:44:10 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH 2/3] powerpc/book3e: Fix set_memory_x() and
 set_memory_nx()
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <922bdab3a220781bae2360ff3dd5adb7fe4d34f1.1635226743.git.christophe.leroy@csgroup.eu>
        <c41100f9c144dc5b62e5a751b810190c6b5d42fd.1635226743.git.christophe.leroy@csgroup.eu>
In-Reply-To: <c41100f9c144dc5b62e5a751b810190c6b5d42fd.1635226743.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
Message-Id: <1635309296.3vv9pb80wz.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Excerpts from Christophe Leroy's message of October 26, 2021 3:39 pm:
> set_memory_x() calls pte_mkexec() which sets _PAGE_EXEC.
> set_memory_nx() calls pte_exprotec() which clears _PAGE_EXEC.
>=20
> Book3e has 2 bits, UX and SX, which defines the exec rights
> resp. for user (PR=3D1) and for kernel (PR=3D0).
>=20
> _PAGE_EXEC is defined as UX only.
>=20
> An executable kernel page is set with either _PAGE_KERNEL_RWX
> or _PAGE_KERNEL_ROX, which both have SX set and UX cleared.
>=20
> So set_memory_nx() call for an executable kernel page does
> nothing because UX is already cleared.
>=20
> And set_memory_x() on a non-executable kernel page makes it
> executable for the user and keeps it non-executable for kernel.
>=20
> Also, pte_exec() always returns 'false' on kernel pages, because
> it checks _PAGE_EXEC which doesn't include SX, so for instance
> the W+X check doesn't work.
>=20
> To fix this:
> - change tlb_low_64e.S to use _PAGE_BAP_UX instead of _PAGE_USER
> - sets both UX and SX in _PAGE_EXEC so that pte_user() returns
> true whenever one of the two bits is set

I don't understand this change. Which pte_user() returns true after
this change? Or do you mean pte_exec()?

Does this filter through in some cases at least for kernel executable
PTEs will get both bits set? Seems cleaner to distinguish user and
kernel exec for that but maybe it's a lot of churn?

Thanks,
Nick

> and pte_exprotect()
> clears both bits.
> - Define a book3e specific version of pte_mkexec() which sets
> either SX or UX based on UR.
>=20
> Fixes: 1f9ad21c3b38 ("powerpc/mm: Implement set_memory() routines")
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> ---
> v3: Removed pte_mkexec() from nohash/64/pgtable.h
> v2: New
> ---
