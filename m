Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0AB43510FD
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 10:39:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233651AbhDAIib (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 04:38:31 -0400
Received: from mx2.suse.de ([195.135.220.15]:48198 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233050AbhDAIiN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 04:38:13 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id CA413AE92;
        Thu,  1 Apr 2021 08:38:11 +0000 (UTC)
Date:   Thu, 1 Apr 2021 09:38:09 +0100
From:   Mel Gorman <mgorman@suse.de>
To:     Nadav Amit <nadav.amit@gmail.com>
Cc:     "Huang, Ying" <ying.huang@intel.com>,
        Linux-MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Peter Xu <peterx@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        Will Deacon <will@kernel.org>,
        Michel Lespinasse <walken@google.com>,
        Arjun Roy <arjunroy@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [RFC] NUMA balancing: reduce TLB flush via delaying mapping on
 hint page fault
Message-ID: <20210401083809.GX15768@suse.de>
References: <20210329062651.2487905-1-ying.huang@intel.com>
 <20210330133310.GT15768@suse.de>
 <87a6qj8t92.fsf@yhuang6-desk1.ccr.corp.intel.com>
 <20210331131658.GV15768@suse.de>
 <C42F16F8-646B-448D-A098-E1A98637E28D@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="8GpibOaaTibBMecb"
Content-Disposition: inline
In-Reply-To: <C42F16F8-646B-448D-A098-E1A98637E28D@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--8GpibOaaTibBMecb
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 31, 2021 at 09:36:04AM -0700, Nadav Amit wrote:
>=20
>=20
> > On Mar 31, 2021, at 6:16 AM, Mel Gorman <mgorman@suse.de> wrote:
> >=20
> > On Wed, Mar 31, 2021 at 07:20:09PM +0800, Huang, Ying wrote:
> >> Mel Gorman <mgorman@suse.de> writes:
> >>=20
> >>> On Mon, Mar 29, 2021 at 02:26:51PM +0800, Huang Ying wrote:
> >>>> For NUMA balancing, in hint page fault handler, the faulting page wi=
ll
> >>>> be migrated to the accessing node if necessary.  During the migratio=
n,
> >>>> TLB will be shot down on all CPUs that the process has run on
> >>>> recently.  Because in the hint page fault handler, the PTE will be
> >>>> made accessible before the migration is tried.  The overhead of TLB
> >>>> shooting down is high, so it's better to be avoided if possible.  In
> >>>> fact, if we delay mapping the page in PTE until migration, that can =
be
> >>>> avoided.  This is what this patch doing.
> >>>>=20
> >>>=20
> >>> Why would the overhead be high? It was previously inaccessibly so it's
> >>> only parallel accesses making forward progress that trigger the need
> >>> for a flush.
> >>=20
> >> Sorry, I don't understand this.  Although the page is inaccessible, the
> >> threads may access other pages, so TLB flushing is still necessary.
> >>=20
> >=20
> > You assert the overhead of TLB shootdown is high and yes, it can be
> > very high but you also said "the benchmark score has no visible changes"
> > indicating the TLB shootdown cost is not a major problem for the worklo=
ad.
> > It does not mean we should ignore it though.
>=20
> If you are looking for a benchmark that is negatively affected by NUMA
> balancing, then IIRC Parsec???s dedup is such a workload. [1]
>=20

Few questions;

Is Parsec imparied due to NUMA balancing in general or due to TLB
shootdowns specifically?

Are you using "gcc-pthreads" for parallelisation and the "native" size
for Parsec?

Is there any specific thread count that matters either in
absolute terms or as a precentage of online CPUs?

--=20
Mel Gorman
SUSE Labs

--8GpibOaaTibBMecb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEElcbIJ2qkxLDKryriKjSY26pIcMkFAmBlhnEACgkQKjSY26pI
cMkZqwf/eRNLVsSneirGm6M0609dSk2Vg3k6VeqVCLyJCJu4kVFS3HRiG61MyUsv
S0edPNITHFcJFpql9Tf7U7Z1tjQQ8oUZR2KJjIw/lrPBqJu+rW4hu1F1VYfeJHqG
Q6zMR2rsFBNe6kR0hW64e3I8A1rUFVzLrc+HyPQN33UkOjuLZzptUOhXOgVC+80s
KBIPdyAhmDpk80MHy0hwKufbyCH3PcJa1pQ6XIKDQ/na+eTPOgliZayQtKGPs4iV
yghAaPdSNeYftM0NJ4M3WaizOgRTQGQFA6mTaOC+MMuN5h4fEPTcQgwxWbEhQBh4
4mOTvXRbxvhpkcirFa7DuOhsEO+mMw==
=gTdL
-----END PGP SIGNATURE-----

--8GpibOaaTibBMecb--
