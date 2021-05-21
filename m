Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D33538C607
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 13:54:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231752AbhEUL4N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 07:56:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:42726 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229519AbhEUL4H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 07:56:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7F1576100C;
        Fri, 21 May 2021 11:54:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621598085;
        bh=ybzBPw26Ot6D2BqBrLTh/riX7CZLmq7j5GozLVtLqZ0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JaqPROlzaj4Jy7/wejYgvabg5YtkOmpvdHJEbTAtze8pbo7qsgCyLi6nSl80jk5BZ
         uLWS+Vbl7SiOtjOeEygqzAW0hMTQENEdBIzGAFyqbOCV2Q0Kyc0WfFbyqSKHhbVtyL
         hSr8lMYaDNrQ4c6uHMJt1V5wsTYNbOmKZk8MUn91M3wMgweKB4Aiv/1WV7bh/ccCVA
         +qYy6zts4KZ8hac1dlK2oFLr4N7ESa7CzwI597qA8omwiB1PyW0nwPss4Ap2GGUHWH
         5Hy73hWosg+uYWZjSQuJZfVIad6PDEPep50PpVBnD5dSIVP/MJ/j+3GwCZ4RzGKrz1
         +ybV20IxR7nxQ==
Date:   Fri, 21 May 2021 12:54:41 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     psodagud@codeaurora.org, will@kernel.org, Dave.Martin@arm.com,
        amit.kachhap@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: sve_user_discard
Message-ID: <20210521115441.GA5825@sirena.org.uk>
References: <785d7bc29da6bff0dceeb712c24601fd@codeaurora.org>
 <20210521091254.GA6675@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="WIyZ46R2i8wDzkSu"
Content-Disposition: inline
In-Reply-To: <20210521091254.GA6675@arm.com>
X-Cookie: Do not write below this line.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--WIyZ46R2i8wDzkSu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 21, 2021 at 10:12:54AM +0100, Catalin Marinas wrote:
> On Thu, May 20, 2021 at 04:02:03PM -0700, psodagud@codeaurora.org wrote:

> > This is regarding sve_user_disable(CPACR_EL1_ZEN_EL0EN) on every system
> > call.  If a userspace task is using SVE instructions and making sys calls in
> > between, it would impact the performance of the thread. On every SVE
> > instructions after SVC/system call, it would trap to EL1.

> > I think by setting CPACR_EL1_ZEN_EL0EN flag,  the processor faults when it
> > runs an SVE instruction. This approach may be taken as part of FPSIMD
> > registers switching optimizations.  Can below portion of the code use
> > thread.fpsimd_cpu and fpsimd_last_state variables to avoid clearing
> > CPACR_EL1_ZEN_EL0EN for this kind of use cases?

This mail hasn't hit the lists yet so I've only got the quoted portions,
missing some context like the "code below" referenced above so I don't
know exactly what the proposal is.

> There were attempts over the past couple of years to optimise the
> syscall return use-case. I think the latest is this one:

> https://lore.kernel.org/r/20201106193553.22946-2-broonie@kernel.org

There's actually this more recently:

    https://lore.kernel.org/linux-arm-kernel/20210512151131.27877-1-broonie@kernel.org/

which does 90% of the optimisation in a lot less code, people seem a bit
more enthusiastic about that version.

> I'll let Mark comment on his plans for reviving the series. Do you
> happen to have some realistic workload that would be improved by this?
> We can always write a micro-benchmark but I wonder how much this matters
> in the real world.

Yeah, I'm not sure how much of a meaningful overhead there is from doing
the sve_user_discard() vs testing to see if we need to do it while
maintaining correctness.  Whatever overhead there is with the current
code will only take effect if we're hitting a slow path anyway so it
feels like it might be more trouble than it's worth.  If the proposal
was to just leave SVE enabled for userspace then the issue there is that
we'd have to context switch SVE even if the process isn't using it,
there is nothing other than a syscall that lets us stop doing that.

It will be interesting to look at this stuff as SVE hardware starts to
become more widely available and used on a wider range of workloads on
systems with various vector sizes, lazy restore might be worth looking
at for example possibly in conjunction with always allowing SVE from
userspace.

--WIyZ46R2i8wDzkSu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmCnn4EACgkQJNaLcl1U
h9Dfhwf9GT73m0jO5ZzRlrEtKUQOuJbxTHfXQcrYcJd4jPG1568wQaW1LhtjmAWQ
MLDZMD4inzrg+ez7KR6k5VI1YoTiOo6RDQdJ7DLVqIqKB87gF/XcMcDIb04mLfcg
VNDva3uajrR+nR9tuk0ZrTNuj9PrAiJx4NPDmATYKPfxaZ7Is3nsFEbD3v4StTQ/
Seens0oUqukeIH+ta1AjC/6+SuRYaSL1T3c5YKfKYGj4AoEdVCpc2hNXNiLTraq0
/A715NKhqKZmFtrQAWGoq3NElV4QLAa8VT+1RmAEsCMj1OOPJegjIv2DCovu3kbG
D04gBecD+r8uaynotl39ZLwTtvgqKg==
=wIQZ
-----END PGP SIGNATURE-----

--WIyZ46R2i8wDzkSu--
