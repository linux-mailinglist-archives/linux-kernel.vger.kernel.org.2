Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29CE135849D
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 15:26:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231650AbhDHN0N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 09:26:13 -0400
Received: from mx2.suse.de ([195.135.220.15]:39930 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231534AbhDHN0H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 09:26:07 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1617888355; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oIIF8FD1kZZIB8sp9PsI8R0MlTFlHz4DJ70lsk8+TS4=;
        b=mmBcZDebG+g16icAUL4Df7wTFv9K20Pp6OM2SN4YD5Uf+Ii4lwcQGF8u0k0wXWd3lKWlIh
        ct4anMYn+wfvrdF68BEkJeARpH5T3e+RuIaYDoMYlFAV/yzdPe09ugfMLE+Xksk0IWZAm4
        9429MawBPqpA8D3EzgaJXaSTgKg5uxY=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id EDCBDB032;
        Thu,  8 Apr 2021 13:25:54 +0000 (UTC)
Date:   Thu, 8 Apr 2021 15:25:52 +0200
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Tejun Heo <tj@kernel.org>, joel@joelfernandes.org,
        chris.hyser@oracle.com, joshdon@google.com, mingo@kernel.org,
        vincent.guittot@linaro.org, valentin.schneider@arm.com,
        mgorman@suse.de, linux-kernel@vger.kernel.org, tglx@linutronix.de,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Zefan Li <lizefan.x@bytedance.com>
Subject: Re: [PATCH 0/9] sched: Core scheduling interfaces
Message-ID: <YG8EYKgcwLCfIZAV@blackbook>
References: <20210401131012.395311786@infradead.org>
 <YGpOF6f0YcMkWy1u@mtj.duckdns.org>
 <YG3i2JF2vBY4CseK@blackbook>
 <YG37MBLBIXIPVv7u@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="0QoOOnHI+Sdl8AiX"
Content-Disposition: inline
In-Reply-To: <YG37MBLBIXIPVv7u@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--0QoOOnHI+Sdl8AiX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 07, 2021 at 08:34:24PM +0200, Peter Zijlstra <peterz@infradead.=
org> wrote:
> IMO as long as cgroups have that tasks file, you get to support people
> using it. That means that tasks joining your cgroup need to 'inherit'
> cgroup properties.
The tasks file is consequence of binding this to cgroups, I'm one step
back. Why to make "core isolation" a cgroup property?

(I understand this could help "visualize" what the common domains are if
cgroups were the only API but with prctl the structure can be
arbitrarily modified anyway.)


> Given something like:
>=20
>         R
>        / \
>       A   B
>          / \
>         C   D
Thanks for the example.=20

> B group can set core_sched=3D1 and then all its (and its decendants) tasks
> get to have the same (group) cookie and cannot share with others.
The same could be achieved with the first task of group B allocating its
new cookie which would be inherited in its descednants.

> If however B is a delegate and has a subgroup D that is security
> sensitive and must not share core resources with the rest of B, then it
> can also set D.core_sched=3D1, such that D (and its decendants) will have
> another (group) cookie.
If there is such a sensitive descendant task, it could allocate a new
cookie (same way as the first one in B did).

> On top of this, say C has a Real-Time tasks, that wants to limit SMT
> interference, then it can set a (task/prctl) cookie on itself, such that
> it will not share the core with the rest of the tasks of B.
(IIUC, in this particular example it'd be redundant if B had no inner
tasks since D isolated itself already.)
Yes, so this is again the same pattern as the tasks above have done.

> In that scenario the D subtree is a restriction (doesn't share) with the
> B subtree.
This implies D's isolation from everything else too, not just B's
members, no?

> And all of B is a restriction on all its tasks, including the Real-Time
> task that set a task cookie, in that none of them can share with tasks
> outside of B (including system tasks which are in R), irrespective of
> what they do with their task cookie.
IIUC, the equivalent restriction could be achieved with the PTRACE-like
check in the prctl API too (with respectively divided uids).

I'm curious whether the cgroup API actually simplifies things that are
possible with the clone/prctl API or allows anything that wouldn't be
otherwise possible.

Regards,
Michal


--0QoOOnHI+Sdl8AiX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEEoQaUCWq8F2Id1tNia1+riC5qSgFAmBvBFwACgkQia1+riC5
qShwjw/+Nz+8PN51hIJ3F6xocWess7ngZINL0fPJ3n716L0sXdbZJGOeHHMpI+GK
uPGNTznUkdPAQ0jXX6XyuUpmG4Mk92KnXFtL9DCbjPEHeOBluoSPLw8piKW+gElO
ATASP84QOw9EUpJ/7FjUrYEk75ucMjsmV1yD/9NEeW6k9rnovPdUh+7UoqfYepd4
GQxudcGYmobBoNF4/iIHr3BDxLzrr0+w7CBVAvEBGsF38JgaSNUGm+p74CIkYV1U
cUlF8FhfHdqufsDAq9+cyQMvAB1CJt7efSoLwpjiXheFODcyylMLc/0qiR0QYxOL
ZviKP1CoSoVj9RtsJYRVubJFqHIwI9i6iehZU2bhyAN+S7eCHe01KXS+XfpF33Mc
G5ZWU8MLU4E902V0EKOwHecRPIitKX9+xwyQ+26Pz5FrmAxhF7iP8//5BYrNP6Mx
D7gWLX6Cj692i2mSHsxqaVQil6IpcwgKaLQK3u2cwyHl3GRmSBy6yLRK8G2Y1hCo
fD/YD5S8/6jfsNBWrojwlsJdKx9YMMnLipiYGw+qLmqStPwCuGpd9PQkwCliO0OQ
6yYuRTHY3X2IqVh9wGdpG08Ae54LekJEunKoBW137Q9rtp1q7U//j4qtXcKHPIl0
Y/Og5zdCtdVS5PzeQTzlzyKUgLKDjXRoI8LaFpwJM/7/eR9L/iU=
=oV8A
-----END PGP SIGNATURE-----

--0QoOOnHI+Sdl8AiX--
