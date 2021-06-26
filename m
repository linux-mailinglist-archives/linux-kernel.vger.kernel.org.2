Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C34DF3B4E64
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jun 2021 13:47:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229984AbhFZLpB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Jun 2021 07:45:01 -0400
Received: from shelob.surriel.com ([96.67.55.147]:33122 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbhFZLpA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Jun 2021 07:45:00 -0400
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <riel@shelob.surriel.com>)
        id 1lx6hf-00014S-BY; Sat, 26 Jun 2021 07:42:27 -0400
Message-ID: <bd6320bb038f02d2bad0bb07ecf2b23f3cda9167.camel@surriel.com>
Subject: Re: [PATCH] sched: cgroup SCHED_IDLE support
From:   Rik van Riel <riel@surriel.com>
To:     Peter Zijlstra <peterz@infradead.org>, Tejun Heo <tj@kernel.org>
Cc:     Josh Don <joshdon@google.com>, Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Paul Turner <pjt@google.com>,
        David Rientjes <rientjes@google.com>,
        Oleg Rombakh <olegrom@google.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Steve Sistare <steven.sistare@oracle.com>,
        linux-kernel@vger.kernel.org
Date:   Sat, 26 Jun 2021 07:42:27 -0400
In-Reply-To: <YNWPBDH/mQdojEu9@hirez.programming.kicks-ass.net>
References: <20210608231132.32012-1-joshdon@google.com>
         <YMobzbLecaFYuLtq@slm.duckdns.org>
         <YNWPBDH/mQdojEu9@hirez.programming.kicks-ass.net>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-Q8vGBBKE25AsRlE5mV6U"
User-Agent: Evolution 3.40.1 (3.40.1-1.fc34) 
MIME-Version: 1.0
Sender: riel@shelob.surriel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Q8vGBBKE25AsRlE5mV6U
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2021-06-25 at 10:08 +0200, Peter Zijlstra wrote:
> On Wed, Jun 16, 2021 at 11:42:05AM -0400, Tejun Heo wrote:
> > A high-level problem that I see with the proposal is that this
> > would bake
> > the current recursive implementation into the interface. The
> > semantics of
> > the currently exposed interface, at least the weight based part, is
> > abstract
> > and doesn't necessarily dictate how the scheduling is actually
> > performed.
> > Adding this would mean that we're now codifying the current
> > behavior of
> > fully nested scheduling into the interface.
>=20
> It's a direct concequence of the hierarchical requirement. The
> approach
> is the only valid one. The other relative controllers that don't do
> this, are simply broken.
>=20
> Absolute controllers have it easier, they can be trivially flattened.

I'm pretty sure CFS can be mostly flattened too, just not
trivially :)

Doing the delta_exectime to vruntime accounting in a somewhat
delayed fashion, with never more than one or two timeslices
worth of vruntime at a time being accounted, should make the
flat CFS runqueue model work.

--=20
All Rights Reversed.

--=-Q8vGBBKE25AsRlE5mV6U
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAmDXEqMACgkQznnekoTE
3oNYbAf+P0FWX2/jiL/fCScDjNZOIEnpTWFyOoVumMs46Zly1HaiKJidykHivnyr
EcfXp5v8OFfFV27/tIgW6LjA5V86XI/dv0Q1eqlo/rGnE/Xr3B5X2JxyzRg+H6ye
hOk44vStRPVj71nd/5+kbb9Mdu3atmzyF2RzRX4/28GSVDF78l02bT+bUbj9sPbf
Sf6QqzyT9BTR3szKRCC5cDY1BkV6u9id77mm/z+7ugZpR9xnLIoKSPHKoLBsS5vc
700Cg3FGeVRX7biCVAKx5qI/GXjM1PWEiJsYlYZz2z+OFk4vYKYvYSBdT1J/YfRw
/PaH1mou1EyaoK9B6L5xSPnNDB9V9Q==
=wO7c
-----END PGP SIGNATURE-----

--=-Q8vGBBKE25AsRlE5mV6U--

