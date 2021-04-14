Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F4E435EAE2
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 04:31:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244971AbhDNCal (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 22:30:41 -0400
Received: from shelob.surriel.com ([96.67.55.147]:53626 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232708AbhDNCai (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 22:30:38 -0400
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <riel@shelob.surriel.com>)
        id 1lWVHk-0002fD-KE; Tue, 13 Apr 2021 22:29:44 -0400
Message-ID: <f4750f9431bd12b7338a47925de8b17015da51a7.camel@surriel.com>
Subject: Re: [PATCH v2 00/16] Multigenerational LRU Framework
From:   Rik van Riel <riel@surriel.com>
To:     Dave Chinner <david@fromorbit.com>, Jens Axboe <axboe@kernel.dk>
Cc:     SeongJae Park <sj38.park@gmail.com>, Yu Zhao <yuzhao@google.com>,
        linux-mm@kvack.org, Andi Kleen <ak@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Benjamin Manes <ben.manes@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Hillf Danton <hdanton@sina.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Michael Larabel <michael@michaellarabel.com>,
        Michal Hocko <mhocko@suse.com>,
        Michel Lespinasse <michel@lespinasse.org>,
        Roman Gushchin <guro@fb.com>,
        Rong Chen <rong.a.chen@intel.com>,
        SeongJae Park <sjpark@amazon.de>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Yang Shi <shy828301@gmail.com>,
        Ying Huang <ying.huang@intel.com>, Zi Yan <ziy@nvidia.com>,
        linux-kernel@vger.kernel.org, lkp@lists.01.org,
        page-reclaim@google.com
Date:   Tue, 13 Apr 2021 22:29:44 -0400
In-Reply-To: <20210413231436.GF63242@dread.disaster.area>
References: <20210413075155.32652-1-sjpark@amazon.de>
         <3ddd4f8a-8e51-662b-df11-a63a0e75b2bc@kernel.dk>
         <20210413231436.GF63242@dread.disaster.area>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-F++cZhSa2Af2JhhC9Dpg"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Sender: riel@shelob.surriel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-F++cZhSa2Af2JhhC9Dpg
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2021-04-14 at 09:14 +1000, Dave Chinner wrote:
> On Tue, Apr 13, 2021 at 10:13:24AM -0600, Jens Axboe wrote:
>=20
> > The initial posting of this patchset did no better, in fact it did
> > a bit
> > worse. Performance dropped to the same levels and kswapd was using
> > as
> > much CPU as before, but on top of that we also got excessive
> > swapping.
> > Not at a high rate, but 5-10MB/sec continually.
> >=20
> > I had some back and forths with Yu Zhao and tested a few new
> > revisions,
> > and the current series does much better in this regard. Performance
> > still dips a bit when page cache fills, but not nearly as much, and
> > kswapd is using less CPU than before.
>=20
> Profiles would be interesting, because it sounds to me like reclaim
> *might* be batching page cache removal better (e.g. fewer, larger
> batches) and so spending less time contending on the mapping tree
> lock...
>=20
> IOWs, I suspect this result might actually be a result of less lock
> contention due to a change in batch processing characteristics of
> the new algorithm rather than it being a "better" algorithm...

That seems quite likely to me, given the issues we have
had with virtual scan reclaim algorithms in the past.

SeongJae, what is this algorithm supposed to do when faced
with situations like this:
1) Running on a system with 8 NUMA nodes, and
memory
   pressure in one of those nodes.
2) Running PostgresQL or Oracle, with hundreds of
   processes mapping the same (very large) shared
   memory segment.

How do you keep your algorithm from falling into the worst
case virtual scanning scenarios that were crippling the
2.4 kernel 15+ years ago on systems with just a few GB of
memory?

--=20
All Rights Reversed.

--=-F++cZhSa2Af2JhhC9Dpg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAmB2U5gACgkQznnekoTE
3oPxNggArWAg3BKjFNFCqV6hmRJcPb8OiTUU7M6upcMdSo+qTt5ivPbR1oqnHCc4
9B41LFwOhK4jc2LThte6bsSVL3GkPTia9RC5oXouoUiwJdp56vhc6fFnWcXqjJTJ
M2E8mu4iJKq7nDGYqz/w212PB93qDfyv00newmUFybKj6VaJoJf2iR7WLjpU4wjK
SNXJct21QO7AftDHPGYsXmSqVK4vQrodF0b9Pl5CVvfida/SJk0da762a9R8KwqF
pIBWVmGNBD7pZWp7xwvYff0OnIt/5n43O2ZdOhKOwRa6H2jEdaAB3IvsQSknBTJF
FO+6mbmBscAP3jwlbHf2DddcgZKh5A==
=0Yad
-----END PGP SIGNATURE-----

--=-F++cZhSa2Af2JhhC9Dpg--

