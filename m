Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F9153613A2
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 22:40:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235390AbhDOUkN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 16:40:13 -0400
Received: from shelob.surriel.com ([96.67.55.147]:34902 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234536AbhDOUkM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 16:40:12 -0400
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <riel@shelob.surriel.com>)
        id 1lX8m8-0001rQ-My; Thu, 15 Apr 2021 16:39:44 -0400
Message-ID: <a5abd06c61e4152b483043f8b180ba041f0464d1.camel@surriel.com>
Subject: Re: [PATCH 2/2] sched/fair: Relax task_hot() for misfit tasks
From:   Rik van Riel <riel@surriel.com>
To:     Valentin Schneider <valentin.schneider@arm.com>,
        linux-kernel@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Quentin Perret <qperret@google.com>,
        Pavan Kondeti <pkondeti@codeaurora.org>,
        Lingutla Chandrasekhar <clingutla@codeaurora.org>
Date:   Thu, 15 Apr 2021 16:39:44 -0400
In-Reply-To: <20210415175846.494385-3-valentin.schneider@arm.com>
References: <20210415175846.494385-1-valentin.schneider@arm.com>
         <20210415175846.494385-3-valentin.schneider@arm.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-TXy3XvJZvO43nCmvBjz0"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Sender: riel@shelob.surriel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-TXy3XvJZvO43nCmvBjz0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2021-04-15 at 18:58 +0100, Valentin Schneider wrote:
> Consider the following topology:
>=20
> Long story short, preempted misfit tasks are affected by task_hot(),
> while
> currently running misfit tasks are intentionally preempted by the
> stopper
> task to migrate them over to a higher-capacity CPU.
>=20
> Align detach_tasks() with the active-balance logic and let it pick a
> cache-hot misfit task when the destination CPU can provide a capacity
> uplift.
>=20
> Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>

Reviewed-by: Rik van Riel <riel@surriel.com>


This patch looks good, but...

> @@ -7672,6 +7698,15 @@ int can_migrate_task(struct task_struct *p,
> struct lb_env *env)
>  	if (tsk_cache_hot =3D=3D -1)
>  		tsk_cache_hot =3D task_hot(p, env);
> =20
> +	/*
> +	 * On a (sane) asymmetric CPU capacity system, the increase in
> compute
> +	 * capacity should offset any potential performance hit caused
> by a
> +	 * migration.
> +	 */
> +	if ((env->dst_grp_type =3D=3D group_has_spare) &&
> +	    !migrate_degrades_capacity(p, env))
> +		tsk_cache_hot =3D 0;

... I'm starting to wonder if we should not rename the
tsk_cache_hot variable to something else to make this
code more readable. Probably in another patch :)

--=20
All Rights Reversed.

--=-TXy3XvJZvO43nCmvBjz0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAmB4pJAACgkQznnekoTE
3oNZBQgAiarBNquYuLTpU8dvB0Q9jSo4pszYmC09h7UUCB5m9GWLbvBSxG1VvCF1
dWGxCwoj3tkjmlbmGjxTwQUh9Q2PHiIFC0gJu8GBpyj6bRk/ICakO3U2+WjD3lNf
HbTrkb6FH8DJ52QhiyxzOiMkcuMkTtrCCD98EdqUwXxba6ZAxNiMsnQ5+7xYz+Pe
uGqfAjuIGloMvKbejE4myMg3dfQvOSHovPUC0lsLJnYbEereFA2mt3+JwQ8IXW47
gDmYwfhspr7eslvTIyZiQfqkY2GBOgyDlez5a9yD8EBJnzYsrj2cuPhbgSfw5oY2
DOWIyz510QNL3NiBSWEwm8yrLGai7g==
=G9Ps
-----END PGP SIGNATURE-----

--=-TXy3XvJZvO43nCmvBjz0--

