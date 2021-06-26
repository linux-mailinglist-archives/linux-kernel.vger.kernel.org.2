Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D51403B4DFB
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jun 2021 12:28:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229948AbhFZKaq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Jun 2021 06:30:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbhFZKap (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Jun 2021 06:30:45 -0400
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 348F8C061574
        for <linux-kernel@vger.kernel.org>; Sat, 26 Jun 2021 03:28:23 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4GBqpB5nnSz9sW6;
        Sat, 26 Jun 2021 20:28:18 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1624703299;
        bh=tsxGUdFiqfdXK8lSnuTbyB2qErN23lpFXtslNqHEMq8=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=mDKIkJoXHw+6aDwJRVGJV0camdqrfC52S6oy0WkhRk2m0FTdTQsMOPBtjNn0ukApa
         yNa0shr5io+Jy0qtjfiAOfPPquF3Q+GNt9yR8jp6Z0e1Izkra3MWojk9nXF3WIMRmp
         R+c1XMG1LAKPdWzsZHR9hZ0n/dQvgbJFDor2wJwS4TcbiglpsUrVI6Rt6dlCfAkbbj
         +8tviCoWJCqJ7XzrpLHZ7L4urBr31XXdP5UsYn4yp1zBtlfuiOzcFX8iXdUNQE/fqD
         0zBIXQ+WRjDgNQLbyhC6YlfF5Fti2uIOstrUAYRkYvOzZw6PO9tZy5jqAlBxzrRR4y
         lhREr/k+o5zvQ==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     kernel test robot <lkp@intel.com>,
        =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: Re: arch/powerpc/kvm/powerpc.c:1141:7: warning: Redundant
 assignment of 'gpr' to itself. [selfAssignment]
In-Reply-To: <202106252219.3RFYWdTc-lkp@intel.com>
References: <202106252219.3RFYWdTc-lkp@intel.com>
Date:   Sat, 26 Jun 2021 20:28:16 +1000
Message-ID: <87mtrczzr3.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kernel test robot <lkp@intel.com> writes:
> Hi C=C3=A9dric,
>
> First bad commit (maybe !=3D root cause):
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.gi=
t master
> head:   44db63d1ad8d71c6932cbe007eb41f31c434d140
> commit: 9236f57a9e51c72ce426ccd2e53e123de7196a0f KVM: PPC: Make the VMX i=
nstruction emulation routines static
> date:   5 months ago
> compiler: powerpc64-linux-gcc (GCC) 9.3.0
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>
>
> cppcheck warnings: (new ones prefixed by >>)
>>> arch/powerpc/kvm/powerpc.c:1141:7: warning: Redundant assignment of 'gp=
r' to itself. [selfAssignment]
>      gpr =3D sp_to_dp(gpr);
>          ^
>>> arch/powerpc/kvm/powerpc.c:1341:7: warning: Redundant assignment of 'va=
l' to itself. [selfAssignment]
>      val =3D dp_to_sp(val);

Because of:

#ifdef CONFIG_PPC_FPU
static inline u64 sp_to_dp(u32 fprs)
{
	u64 fprd;

	preempt_disable();
	enable_kernel_fp();
	asm ("lfs%U1%X1 0,%1; stfd%U0%X0 0,%0" : "=3Dm"UPD_CONSTR (fprd) : "m"UPD_=
CONSTR (fprs)
	     : "fr0");
	preempt_enable();
	return fprd;
}

static inline u32 dp_to_sp(u64 fprd)
{
	u32 fprs;

	preempt_disable();
	enable_kernel_fp();
	asm ("lfd%U1%X1 0,%1; stfs%U0%X0 0,%0" : "=3Dm"UPD_CONSTR (fprs) : "m"UPD_=
CONSTR (fprd)
	     : "fr0");
	preempt_enable();
	return fprs;
}

#else
#define sp_to_dp(x)	(x)
#define dp_to_sp(x)	(x)
#endif /* CONFIG_PPC_FPU */


And you must be building the PPC_FPU=3Dn case.

Surely the compiler is smart enough to generate no code for this. So
what's the harm? ie. why is this something we should be fixing?

cheers
