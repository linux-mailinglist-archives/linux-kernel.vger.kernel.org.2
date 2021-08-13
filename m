Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2B223EAFF7
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Aug 2021 08:21:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238824AbhHMGU3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Aug 2021 02:20:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238646AbhHMGU2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Aug 2021 02:20:28 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 560A0C061756
        for <linux-kernel@vger.kernel.org>; Thu, 12 Aug 2021 23:20:02 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d17so10501147plr.12
        for <linux-kernel@vger.kernel.org>; Thu, 12 Aug 2021 23:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=3Plf9kYprckAlJtYbb7SyhR3dTcw+NdeOwPa/nQw2qQ=;
        b=uh320nEJ2La0l2ayXToOEW/pFFNDV4IY+u1oTBcLjMAFVRSG3DAPfo/hPs+T7LiKFI
         dly3bhsDBpKtyQRzECa444UPfQVrIB3XDQXtPifiYLDJkREE4qAQZunXeaiX4qxO3uAz
         CE6fUWMzZDQ7NsW3nBfncRxjGIgKPSgd89onfG4mPkDt0WNiWtplH9sw+JWpjcsRif0b
         lrOU/mBCAlrAZUob8UR3RLm3cVtRilQ0PU2RTX9BsF4Yi/FPpxD4PprjhOKGzOjdLUcc
         tHiy/gjnnpvJ+SwLoxwavleSITLsTGBh5VarwFOoH9e82cCKLUAE93OetgTrgUMLm1Uo
         jMaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=3Plf9kYprckAlJtYbb7SyhR3dTcw+NdeOwPa/nQw2qQ=;
        b=G4JkkJ4jC+UnpxCn5fY7ijFKWVsp/mtgyelDr/8QhNEm3+mzpK+DF75DblKpqunXw+
         Ig3wa4uDpStJKnias2J1wAtJoAcHCwcj645oPEqpeXXJhTu0cmD3pwrK67z9ypl/raz6
         AGZTBTOAHR8e+w9/jlX/KUQOFBtRV/BNtiHntEW8Woh9c46mY6LPpy/akEHT/EjYzanK
         eHkdIbdRhLFELvcv6tk6ztMqJAfFI3ScrsSYVoUI4vRvuQ2H+12WF1sPrTMWy7lSjxix
         v2HSoHGvapkN0fEkFCfP0FU3WP14EdYlN+NrCmMg6wel48sqKpRdr0y4btxnt3A10cg9
         tpfA==
X-Gm-Message-State: AOAM5324l64cPea5kjhsm1kXNlKFELvCMnhLTHwZEl1veUG5VG7wbulu
        7YughQo2L/eJ1GHw49Ks3fc=
X-Google-Smtp-Source: ABdhPJwjY9sww6bgXsU1OD1U78Y9YWxbhl7MSl2Q+cyvPbyaE3AzOVb4t7pilHfLFPL8vJ4tHmwfaA==
X-Received: by 2002:a17:90a:db09:: with SMTP id g9mr1068009pjv.205.1628835601865;
        Thu, 12 Aug 2021 23:20:01 -0700 (PDT)
Received: from localhost (60-242-208-220.static.tpgi.com.au. [60.242.208.220])
        by smtp.gmail.com with ESMTPSA id y23sm810874pfb.130.2021.08.12.23.20.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Aug 2021 23:20:01 -0700 (PDT)
Date:   Fri, 13 Aug 2021 16:19:56 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v2 2/2] powerpc/bug: Provide better flexibility to
 WARN_ON/__WARN_FLAGS() with asm goto
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <b286e07fb771a664b631cd07a40b09c06f26e64b.1618331881.git.christophe.leroy@csgroup.eu>
        <389962b1b702e3c78d169e59bcfac56282889173.1618331882.git.christophe.leroy@csgroup.eu>
In-Reply-To: <389962b1b702e3c78d169e59bcfac56282889173.1618331882.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
Message-Id: <1628834900.ecs68prq9x.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Excerpts from Christophe Leroy's message of April 14, 2021 2:38 am:
> Using asm goto in __WARN_FLAGS() and WARN_ON() allows more
> flexibility to GCC.
>=20
> For that add an entry to the exception table so that
> program_check_exception() knowns where to resume execution
> after a WARNING.

Nice idea. How much does it bloat the exception table?
How easy would it be to make a different exception table for
unimportant stuff like WARN_ON faults?

>=20
> Here are two exemples. The first one is done on PPC32 (which
> benefits from the previous patch), the second is on PPC64.
>=20
> 	unsigned long test(struct pt_regs *regs)
> 	{
> 		int ret;
>=20
> 		WARN_ON(regs->msr & MSR_PR);
>=20
> 		return regs->gpr[3];
> 	}
>=20
> 	unsigned long test9w(unsigned long a, unsigned long b)
> 	{
> 		if (WARN_ON(!b))
> 			return 0;
> 		return a / b;
> 	}
>=20
> Before the patch:
>=20
> 	000003a8 <test>:
> 	 3a8:	81 23 00 84 	lwz     r9,132(r3)
> 	 3ac:	71 29 40 00 	andi.   r9,r9,16384
> 	 3b0:	40 82 00 0c 	bne     3bc <test+0x14>
> 	 3b4:	80 63 00 0c 	lwz     r3,12(r3)
> 	 3b8:	4e 80 00 20 	blr
>=20
> 	 3bc:	0f e0 00 00 	twui    r0,0
> 	 3c0:	80 63 00 0c 	lwz     r3,12(r3)
> 	 3c4:	4e 80 00 20 	blr
>=20
> 	0000000000000bf0 <.test9w>:
> 	 bf0:	7c 89 00 74 	cntlzd  r9,r4
> 	 bf4:	79 29 d1 82 	rldicl  r9,r9,58,6
> 	 bf8:	0b 09 00 00 	tdnei   r9,0
> 	 bfc:	2c 24 00 00 	cmpdi   r4,0
> 	 c00:	41 82 00 0c 	beq     c0c <.test9w+0x1c>
> 	 c04:	7c 63 23 92 	divdu   r3,r3,r4
> 	 c08:	4e 80 00 20 	blr
>=20
> 	 c0c:	38 60 00 00 	li      r3,0
> 	 c10:	4e 80 00 20 	blr
>=20
> After the patch:
>=20
> 	000003a8 <test>:
> 	 3a8:	81 23 00 84 	lwz     r9,132(r3)
> 	 3ac:	71 29 40 00 	andi.   r9,r9,16384
> 	 3b0:	40 82 00 0c 	bne     3bc <test+0x14>
> 	 3b4:	80 63 00 0c 	lwz     r3,12(r3)
> 	 3b8:	4e 80 00 20 	blr
>=20
> 	 3bc:	0f e0 00 00 	twui    r0,0
>=20
> 	0000000000000c50 <.test9w>:
> 	 c50:	7c 89 00 74 	cntlzd  r9,r4
> 	 c54:	79 29 d1 82 	rldicl  r9,r9,58,6
> 	 c58:	0b 09 00 00 	tdnei   r9,0
> 	 c5c:	7c 63 23 92 	divdu   r3,r3,r4
> 	 c60:	4e 80 00 20 	blr
>=20
> 	 c70:	38 60 00 00 	li      r3,0
> 	 c74:	4e 80 00 20 	blr

One thing that would be nice for WARN_ON_ONCE is to patch out the trap
after the program interrupt. I've seen sometimes the WARN_ON_ONCE starts
firing a lot and slows down the kernel. That gets harder to do if the
trap is now part of the control flow.

I guess that's less important case for performance though. And in theory
you might be able to replace the trap with an equivalent cmp and branch
(but that's probably going too over engineering it).

Thanks,
Nick

