Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E16D319E7C
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 13:38:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230396AbhBLMgy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 07:36:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:54016 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229907AbhBLMgu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 07:36:50 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0A4B564DEE;
        Fri, 12 Feb 2021 12:36:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613133369;
        bh=cnTIOUrwbSss0NsP381REUNNVtv0SaySoeMM4ym6xLs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RdlEud5Vcwv7Bbex5r6Y2fe3o5GEdrpUXdmwC0fYOpCiL0irjf7O+vggKqq0yhlSZ
         Dgsz/WmSW5yJs2O+61tMAy9BcqrM+RH3X1cNRDsmN1SA1MbaATctkDSdVMV1xxdVGG
         A/+ZR/RWTWI8VZdTA8B7rzmUekXxmkr/QiRN3IxmXk3p+nZxCvzaYYV+US91+Y8gqi
         0tTIkwnob0V+vuLPht5lZD4a+ikD83oj4+4he7+4Dr5aTLDheqSRdd6g5LyUtJUhw1
         m0hBkXbZMzeNZFdoVVH7Jy2km0smiY+44p8m8QYJfN5IbCTHhNhQ/UTIr8AfBvmRD5
         JqfoLrfPW/UBA==
Date:   Fri, 12 Feb 2021 12:35:15 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Steven Price <steven.price@arm.com>
Cc:     sonicadvance1@gmail.com, amanieu@gmail.com,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Dave Martin <Dave.Martin@arm.com>,
        Amit Daniel Kachhap <amit.kachhap@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        David Brazdil <dbrazdil@google.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Gavin Shan <gshan@redhat.com>, Mike Rapoport <rppt@kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Kristina Martsenko <kristina.martsenko@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Kevin Hao <haokexin@gmail.com>,
        Jason Yan <yanaijie@huawei.com>, Andrey Ignatov <rdna@fb.com>,
        Peter Collingbourne <pcc@google.com>,
        Julien Grall <julien.grall@arm.com>,
        Tian Tao <tiantao6@hisilicon.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Jens Axboe <axboe@kernel.dk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RESEND RFC PATCH v2] arm64: Exposes support for 32-bit syscalls
Message-ID: <20210212123515.GC6057@sirena.org.uk>
References: <20210211202208.31555-1-Sonicadvance1@gmail.com>
 <58b03e17-3729-99ea-8691-0d735a53b9bc@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Md/poaVZ8hnGTzuv"
Content-Disposition: inline
In-Reply-To: <58b03e17-3729-99ea-8691-0d735a53b9bc@arm.com>
X-Cookie: One size fits all.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Md/poaVZ8hnGTzuv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Feb 12, 2021 at 11:30:41AM +0000, Steven Price wrote:
> On 11/02/2021 20:21, sonicadvance1@gmail.com wrote:

> > Why do we need compatibility layers?
> > There are ARMv8 CPUs that only support AArch64 but still need to run
> > AArch32 applications.
> > Cortex-A34/R82 and other cores are prime examples of this.
> > Additionally if a user is needing to run legacy 32-bit x86 software, it
> > needs the same compatibility layer.

> Unless I'm much mistaken QEMU's user mode already does this - admittedly I
> don't tend to run "legacy 32-bit x86 software".

Yes, this has been deployed on Debian for a long time - you can install
any combination of Debian architectures on a single system and it will
use qemu to run binaries that can't be supported natively by the
hardware.

--Md/poaVZ8hnGTzuv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmAmdgIACgkQJNaLcl1U
h9Ar6Qf7Be9ErKtx5lm+ZTtLIlBvwbYKuCANK8wuDnCzLybGOxE/0n+OHlsJsPoh
+HgRSrSab9IvlOcPXxJZ7tWr81ZW8JHdP+gVAKV2ogYn18IWni9jiFw1ti1qru6m
y8ow6AFHYS2BryKDPchKalvl3iKVcYGkWvtZVwvK0+0K6PkWCNOIRKI7vRNbqXKa
EvMjgvlb//CumMk6TnW3TajWnK5SCpoUN8aP+s5+SJsAsOwpySsum2lwNDXqc1R1
2xYXdB1pgtWgjA7WtasM1W0xwAJ8ol81BaU6FzFXToOPBxg31dff/9dQHXuSyedk
r6DqAhGK+pyhY6mhQJvV5jTzaPad+A==
=UG5o
-----END PGP SIGNATURE-----

--Md/poaVZ8hnGTzuv--
