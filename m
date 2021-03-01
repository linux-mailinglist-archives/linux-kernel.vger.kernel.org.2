Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E5D43282C4
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 16:46:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237375AbhCAPqT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 10:46:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237075AbhCAPqO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 10:46:14 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 532AEC061756
        for <linux-kernel@vger.kernel.org>; Mon,  1 Mar 2021 07:45:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=TSa8nsScEP0oQJAOUkZDicDP/piGiwm3u3sQvk/SQeI=; b=bCI0/hzskyfJ+m3pl398c373zv
        T+QUahHIyJYVFlZ5EhYyfc85PdP1QyT8z+nYu+y8eCrcp1hdhacG1v6x5uXDSUgEcylWEHl43/czQ
        BjnknzV0aadkSR0TSSOK/z5h5TS7JysYkqgRZXWVPZiVE3+naQ1hrL4hsZjGTG4xWjha6ax2qRYQ5
        NJYouITN5s7r4/WmL//wIMFVHVkYOQ7kvkwZr8/ORsgrRyWmZwXTL3mSw4UILfuhuCkDqPwIvMnpN
        kArq23T7wZQ0aDu9BHpMzHmrVmfjIda1S04lTuSVbNdQTHgdG3owRChrDkLVYGZ9J1PPVtJcoAwuW
        tebOnF3A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lGkiy-00Fu9w-HT; Mon, 01 Mar 2021 15:44:50 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 0C923301959;
        Mon,  1 Mar 2021 16:44:43 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id EB1EB2059E79F; Mon,  1 Mar 2021 16:44:42 +0100 (CET)
Date:   Mon, 1 Mar 2021 16:44:42 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Rik van Riel <riel@surriel.com>
Cc:     Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Michael Neuling <mikey@neuling.org>,
        Gautham R Shenoy <ego@linux.vnet.ibm.com>,
        Parth Shah <parth@linux.ibm.com>
Subject: Re: [PATCH] sched/fair: Prefer idle CPU to cache affinity
Message-ID: <YD0L6sba9RfXX+tM@hirez.programming.kicks-ass.net>
References: <20210226164029.122432-1-srikar@linux.vnet.ibm.com>
 <ab046b9d5bcd29b2eb759cd999e2f578a683c673.camel@surriel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2JpPWwCpCiHiKfCh"
Content-Disposition: inline
In-Reply-To: <ab046b9d5bcd29b2eb759cd999e2f578a683c673.camel@surriel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2JpPWwCpCiHiKfCh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 27, 2021 at 02:56:07PM -0500, Rik van Riel wrote:
> On Fri, 2021-02-26 at 22:10 +0530, Srikar Dronamraju wrote:

> > +	if (sched_feat(WA_WAKER) && tnr_busy < tllc_size)
> > +		return this_cpu;
>=20
> I wonder if we need to use a slightly lower threshold on
> very large LLCs, both to account for the fact that the
> select_idle_cpu code may not find the single idle CPU
> among a dozen busy ones, or because on a system with
> hyperthreading we may often be better off picking another
> LLC for HT contention issues?
>=20
> Maybe we could use "tnr_busy * 4 <
> tllc_size * 3" or
> something like that?

How about:

	tnr_busy < tllc_size / topology_max_smt_threads()

?

--2JpPWwCpCiHiKfCh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEv3OU3/byMaA0LqWJdkfhpEvA5LoFAmA9C+oACgkQdkfhpEvA
5Lr4sw/8CHIRe96iDw8Z0JJAEw3nZ7kn+aDNlrrJiZouqveXeylMFdp+7rh9cZ8b
iJX23CwYvC5w/mY1qetiphLgZeY8kpERNrFZT6ZAaRfSXY2qU4U20sO2OybZhJtI
BJuTmAmWifVBciQbvHW1a2r0GQHv61Y5ibu854DgbqRCFIr4zQh/onLSq5GUQ1+i
o6rhtFu32TYR8cYXvNpp0XlP7GlWd0eDEz5aUKMpw1BUUQ6+UBNtKnbxCT8Fkn2H
XYig+LvXUHmA5ambIJS2ZvZYTE8Ic4fK7ySKTePWD3Vj1/qc7PGRAvhm0xtRB5Me
Hc7wLEDIyO6m5rwx2bM5JoNErRUp/Dt2RK/KXkSjDkGhtypcmzVkDnU3hNW4CUJU
NxS3izeaWp5KPumnzqYYlsH5QKVFV0RdIV+yoPrYlPt6sz2A7uQUCuOmj6GgKhUB
1JkE4WXzSkZhY+fzSCumCg2p/Dzt4+Bg2jNjFrygRSG/kFQSvLVr01LADVpE0+Bd
qy/7GmSgVwXe9UDdVBfDNWSDXOM1Ht4XUe/mz53Bec1wF87hWj54LbZH4EIx4EV/
0vIP22cFC428emRIEZdne0HcME4AkaCg+9DE8RCI2JpvA0LBPWTrdUsBBAh5zLuZ
3qgNkN/Rnntpv8LiOad0jW4H5BaXn3D/niJzwBjE4X2q5WuYLlM=
=4Aam
-----END PGP SIGNATURE-----

--2JpPWwCpCiHiKfCh--
