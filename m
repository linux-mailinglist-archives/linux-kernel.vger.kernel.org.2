Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A13DD36487A
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 18:46:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238747AbhDSQqs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 12:46:48 -0400
Received: from shelob.surriel.com ([96.67.55.147]:60998 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231674AbhDSQqr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 12:46:47 -0400
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <riel@shelob.surriel.com>)
        id 1lYX2J-0004hR-DJ; Mon, 19 Apr 2021 12:46:11 -0400
Message-ID: <f1c5aa1d3d7ce4b09052eb373210cb1cfd653af7.camel@surriel.com>
Subject: Re: [PATCH] sched,fair: skip newidle_balance if a wakeup is pending
From:   Rik van Riel <riel@surriel.com>
To:     Valentin Schneider <valentin.schneider@arm.com>,
        linux-kernel@vger.kernel.org
Cc:     kernel-team@fb.com, Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Mel Gorman <mgorman@suse.de>
Date:   Mon, 19 Apr 2021 12:46:10 -0400
In-Reply-To: <87lf9eldsx.mognet@arm.com>
References: <20210418221751.7edfc03b@imladris.surriel.com>
         <87lf9eldsx.mognet@arm.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-8BTaaWvwrhr+DTL3EwGl"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Sender: riel@shelob.surriel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-8BTaaWvwrhr+DTL3EwGl
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2021-04-19 at 12:22 +0100, Valentin Schneider wrote:
> On 18/04/21 22:17, Rik van Riel wrote:
> > @@ -10661,7 +10669,8 @@ static int newidle_balance(struct rq
> > *this_rq, struct rq_flags *rf)
> >                * Stop searching for tasks to pull if there are
> >                * now runnable tasks on this rq.
> >                */
> > -		if (pulled_task || this_rq->nr_running > 0)
> > +		if (pulled_task || this_rq->nr_running > 0 ||
> > +						this_rq->ttwu_pending)
> >                       break;
>=20
> I thought newidle_balance() would already handle this by checking
> idle_cpu(), but that can't work due to rq->curr never being rq->idle
> here
> (we're trying very hard to prevent this!).
>=20
> Would there be any point in bunching up these two checks from
> idle_cpu()
> into an inline helper and reusing it here?

I'm not sure, all the sched classes seem to have their own
magic in the balance functions, and there are enough special
situations out there that we might only be able to consolidate
a few callsites, not the rest.

Also, it turns out newidle_balance needs a different return
value depending on whether we have ->ttwu_pending, a pulled
task, or a queued realtime task...

I'll send v2 without any considation here, since I cannot
figure out a way to make things better here :)

--=20
All Rights Reversed.

--=-8BTaaWvwrhr+DTL3EwGl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAmB9s9MACgkQznnekoTE
3oOqPAgAqma7WLYzgeRBAEZyDZE0+Uj01m41BeucvkJY9beQs5r6BhJEjpkcp0aq
QDDb08lob7+268JFBAkWDHQuVcVUDHQAVk53rHtu3HyU7b6IEyuC6hGbdfzkbAAV
H2YK6nU1mHjC3N0NafHpdwtAxSx0yo19POUIp8QfLFM0Lv9fkqoLq2KfWrqm7G0E
s89YzlNqZzr8rQA+EitloPtn6w0MQUT0CxAJXAVFrqFzz8AS8X7vKtcFfaOnrzsr
Y50XpWYfc2LROjW/uYD6qSqaanZL4pjKT3OiCtueOQfzo+c3ATPnzPVcgcLQlYo4
oJzwRGJaMpJwWmWb4u4/kaDOLGLLXw==
=SRTL
-----END PGP SIGNATURE-----

--=-8BTaaWvwrhr+DTL3EwGl--

