Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1275365C0A
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 17:21:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232853AbhDTPVQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 11:21:16 -0400
Received: from shelob.surriel.com ([96.67.55.147]:54008 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232174AbhDTPVP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 11:21:15 -0400
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <riel@shelob.surriel.com>)
        id 1lYsB2-0002O2-MJ; Tue, 20 Apr 2021 11:20:36 -0400
Message-ID: <5e21452a727dcd6d3257496a2c42f49bd16e9cb5.camel@surriel.com>
Subject: Re: [PATCH v2] sched,fair: skip newidle_balance if a wakeup is
 pending
From:   Rik van Riel <riel@surriel.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Mel Gorman <mgorman@suse.de>,
        Valentin Schneider <valentin.schneider@arm.com>
Date:   Tue, 20 Apr 2021 11:20:36 -0400
In-Reply-To: <CAKfTPtDjEMJeoZgE1an9Nh9QZPc2gJetsZHL+8QAWzqX5_znvw@mail.gmail.com>
References: <20210419125134.5cab12ea@imladris.surriel.com>
         <CAKfTPtDjEMJeoZgE1an9Nh9QZPc2gJetsZHL+8QAWzqX5_znvw@mail.gmail.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-EQ+bP/elTcYHGVQ0YZqy"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Sender: riel@shelob.surriel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-EQ+bP/elTcYHGVQ0YZqy
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2021-04-20 at 11:04 +0200, Vincent Guittot wrote:
> On Mon, 19 Apr 2021 at 18:51, Rik van Riel <riel@surriel.com> wrote:
> >=20
> > @@ -10688,7 +10697,7 @@ static int newidle_balance(struct rq
> > *this_rq, struct rq_flags *rf)
> >         if (this_rq->nr_running !=3D this_rq->cfs.h_nr_running)
> >                 pulled_task =3D -1;
> >=20
> > -       if (pulled_task)
> > +       if (pulled_task || this_rq->ttwu_pending)
>=20
> This needs at least a comment to explain why we must clear
> this_rq->idle_stamp when this_rq->ttwu_pending is set whereas it is
> also done during sched_ttwu_pending()
>=20
> >                 this_rq->idle_stamp =3D 0;

I spent some time staring at sched_ttwu_pending and
the functions it calls, but I can't seem to spot
where it clears rq->idle_stamp, except inside
ttwu_do_wakeup where it will end up adding a
non-idle period into the rq->avg_idle, which seems
wrong.

If we are actually idle, and get woken up with a
ttwu_queue task, we do not come through newidle_balance,
and we end up counting the idle time into the avg_idle
number.

However, if a task is woken up while the CPU is
in newidle_balance, because prev !=3D idle, we should
not count that period towards rq->avg_idle, for
the same reason we do so when we pulled a task.

I'll add a comment in v3 explaining why idle_stamp
needs to be 0.

--=20
All Rights Reversed.

--=-EQ+bP/elTcYHGVQ0YZqy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAmB+8UQACgkQznnekoTE
3oNf9gf/fqJNMjAsb+l+f0a8DZOeWp0jOFn9CKfgNVt8IIdBSl42GLR8WlUa6YBa
DMITTb+oFqIFlg2SNVbP3dZ3BnVY7oscerSqoMijvJesIWW1JqdNyH2LiFIBqSA+
fmXSEhkb16e1OGh7rY0JuO1zISj2HIoMV2nr5TQFdn9t2xK9Rdim8rsYBQ4oT/kT
fDwyWbCv+3DBGr/wythDgFrvQfprN/1MLjnRK24Mw0U55gttDObdERKcnY0GKNFb
DmHiVdbwg28P5UUhG3+gWYwlKbMR+4nKbg9yGZ+J/PCJP/GFFNN4q6SrzpxaAGQk
V/ePa0wO8Va1ApMyJgQq47Qc7xZsMA==
=UM3R
-----END PGP SIGNATURE-----

--=-EQ+bP/elTcYHGVQ0YZqy--

