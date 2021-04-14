Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7734635F5A8
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 16:04:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351709AbhDNNwm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 09:52:42 -0400
Received: from shelob.surriel.com ([96.67.55.147]:48344 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233454AbhDNNwj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 09:52:39 -0400
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <riel@shelob.surriel.com>)
        id 1lWfvr-0001GU-Kr; Wed, 14 Apr 2021 09:51:51 -0400
Message-ID: <93308ea276cfe7997c29ce7132516e830e8fec40.camel@surriel.com>
Subject: Re: [PATCH v2 00/16] Multigenerational LRU Framework
From:   Rik van Riel <riel@surriel.com>
To:     "Huang, Ying" <ying.huang@intel.com>, Yu Zhao <yuzhao@google.com>
Cc:     Dave Chinner <david@fromorbit.com>, Jens Axboe <axboe@kernel.dk>,
        SeongJae Park <sj38.park@gmail.com>,
        Linux-MM <linux-mm@kvack.org>, Andi Kleen <ak@linux.intel.com>,
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
        Yang Shi <shy828301@gmail.com>, Zi Yan <ziy@nvidia.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        Kernel Page Reclaim v2 <page-reclaim@google.com>
Date:   Wed, 14 Apr 2021 09:51:51 -0400
In-Reply-To: <87lf9lqnit.fsf@yhuang6-desk1.ccr.corp.intel.com>
References: <20210413075155.32652-1-sjpark@amazon.de>
         <3ddd4f8a-8e51-662b-df11-a63a0e75b2bc@kernel.dk>
         <20210413231436.GF63242@dread.disaster.area>
         <f4750f9431bd12b7338a47925de8b17015da51a7.camel@surriel.com>
         <CAOUHufafMcaG8sOS=1YMy2P_6p0R1FzP16bCwpUau7g1-PybBQ@mail.gmail.com>
         <87tuo9qtmd.fsf@yhuang6-desk1.ccr.corp.intel.com>
         <CAOUHufbk=TVOpEOvTNRBe0uoOWNZ=wf3umQ628ZFZ=QYhNqsHA@mail.gmail.com>
         <87lf9lqnit.fsf@yhuang6-desk1.ccr.corp.intel.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-TvVzMFbUNFpXYZ2w65cj"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Sender: riel@shelob.surriel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-TvVzMFbUNFpXYZ2w65cj
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2021-04-14 at 16:27 +0800, Huang, Ying wrote:
> Yu Zhao <yuzhao@google.com> writes:
>=20
> > On Wed, Apr 14, 2021 at 12:15 AM Huang, Ying <ying.huang@intel.com>
> > wrote:
> > >=20
> > NUMA Optimization
> > -----------------
> > Support NUMA policies and per-node RSS counters.
> >=20
> > We only can move forward one step at a time. Fair?
>=20
> You don't need to implement that now definitely.  But we can discuss
> the
> possible solution now.

That was my intention, too. I want to make sure we don't
end up "painting ourselves into a corner" by moving in some
direction we have no way to get out of.

The patch set looks promising, but we need some plan to
avoid the worst case behaviors that forced us into rmap
based scanning initially.

> Note that it's possible that only some processes are bound to some
> NUMA
> nodes, while other processes aren't bound.

For workloads like PostgresQL or Oracle, it is common
to have maybe 70% of memory in a large shared memory
segment, spread between all the NUMA nodes, and mapped
into hundreds, if not thousands, of processes in the
system.

Now imagine we have an 8 node system, and memory
pressure in the DMA32 zone of node 0.

How will the current VM behave?

Wha
t will the virtual scanning need to do?

If we can come up with a solution to make virtual
scanning scale for that kind of workload, great.

If not ... if it turns out most of the benefits of
the multigeneratinal LRU framework come from sorting
the pages into multiple LRUs, and from being able
to easily reclaim unmapped pages before having to
scan mapped ones, could it be an idea to implement
that first, independently from virtual scanning?

I am all for improving
our page reclaim system, I
just want to make sure we don't revisit the old traps
that forced us where we are today :)

--=20
All Rights Reversed.

--=-TvVzMFbUNFpXYZ2w65cj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAmB283cACgkQznnekoTE
3oPHTAgAibRj26Dg8hudb4TbNjzdUMWxbcn01w6bKFBXrdvDF+R0L9GpYE5Ujha7
xkegocz6XyUNRTHvfvLL7Z/CsZezxbeJoe3PIvRLZ0DV2L5TxYKFDdq5I+oeYuE2
cRpk5iE4eqZ8e9OK5NV2uFMBJ9M/s1ajvHLlY3izNfSAPX86rjAMFI50DboJChL5
+AXB3s0Qgmg4U9Wo9yyefUNma3AA9zN8E9mMeKnJuBsfVT4SLv+EZxIIPbLUPV24
bd0bce2U1BVlb1U6d4gHgLFDmVrlKmH1NK4MopRQU5sQSTYlnoh5BIsJO9pstNFp
CBP8TQTqMhWSLDnwv7rBMQo8Z5pv9w==
=tvZB
-----END PGP SIGNATURE-----

--=-TvVzMFbUNFpXYZ2w65cj--

