Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE9B836124A
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 20:47:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234606AbhDOSre (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 14:47:34 -0400
Received: from shelob.surriel.com ([96.67.55.147]:58422 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234155AbhDOSrd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 14:47:33 -0400
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <riel@shelob.surriel.com>)
        id 1lX716-0003DA-Jf; Thu, 15 Apr 2021 14:47:04 -0400
Message-ID: <aedc2fe73476daec6523813e837f981c3ef0cff7.camel@surriel.com>
Subject: Re: [PATCH 1/2] sched/fair: Filter out locally-unsolvable misfit
 imbalances
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
Date:   Thu, 15 Apr 2021 14:47:04 -0400
In-Reply-To: <20210415175846.494385-2-valentin.schneider@arm.com>
References: <20210415175846.494385-1-valentin.schneider@arm.com>
         <20210415175846.494385-2-valentin.schneider@arm.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-MBeepDbqBAwNxFcorn1e"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Sender: riel@shelob.surriel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-MBeepDbqBAwNxFcorn1e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2021-04-15 at 18:58 +0100, Valentin Schneider wrote:
> ...
> Further tweak find_busiest_queue() to ensure this doesn't happen.
> Also note
> find_busiest_queue() can now iterate over CPUs with a higher capacity
> than
> the local CPU's, so add a capacity check there.
>=20
> Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>

Reviewed-by: Rik van Riel <riel@surriel.com>

--=20
All Rights Reversed.

--=-MBeepDbqBAwNxFcorn1e
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAmB4iigACgkQznnekoTE
3oPpmQf7BqIlswDG4nIc1KRW4fU8w/sqMkSSpDX0JvC/+DI1QeynU1PZ/bpxmX13
OPOUYZK9B4Vi5fX5Cg/2ysfBoGtxVS8pQs7d8gVXI/wMhDPfye8njNwaIEON1xvz
afWJ6AGqDRx0S8uw2tqjMyhjfRd8qmu4icSRn7tWgxQEXHJmpea2LZkPkOghEcN2
nlpCyRBBxdsXizyZQqBeYy5RXSQ6z+urswNnfekBAQTBvOa7mpckieF1kY39BPzn
QW9GQCtoUxG+xBglLrhM47B7YDYl7MOHstfFBBOvJ0pr03li22M/uZ2fcgaD0gMo
E/TzHoirQymFCdB0aNyc4RMevUhipA==
=MJkU
-----END PGP SIGNATURE-----

--=-MBeepDbqBAwNxFcorn1e--

