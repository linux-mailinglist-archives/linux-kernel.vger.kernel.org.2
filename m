Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56AA935FBC4
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 21:42:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347795AbhDNTmg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 15:42:36 -0400
Received: from shelob.surriel.com ([96.67.55.147]:34198 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235066AbhDNTme (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 15:42:34 -0400
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <riel@shelob.surriel.com>)
        id 1lWlOV-0004hX-Kt; Wed, 14 Apr 2021 15:41:47 -0400
Message-ID: <db2f6f81d30945eb296c4dcc9824b1ad353cc777.camel@surriel.com>
Subject: Re: [PATCH v2 00/16] Multigenerational LRU Framework
From:   Rik van Riel <riel@surriel.com>
To:     Yu Zhao <yuzhao@google.com>
Cc:     Andi Kleen <ak@linux.intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Jens Axboe <axboe@kernel.dk>,
        SeongJae Park <sj38.park@gmail.com>,
        Linux-MM <linux-mm@kvack.org>,
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
        linux-kernel <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        Kernel Page Reclaim v2 <page-reclaim@google.com>
Date:   Wed, 14 Apr 2021 15:41:46 -0400
In-Reply-To: <CAOUHufaRXbDHbEro1uE1CHvpWB4U67iroj0hT8CkUEOSAddzYQ@mail.gmail.com>
References: <20210413075155.32652-1-sjpark@amazon.de>
         <3ddd4f8a-8e51-662b-df11-a63a0e75b2bc@kernel.dk>
         <20210413231436.GF63242@dread.disaster.area>
         <f4750f9431bd12b7338a47925de8b17015da51a7.camel@surriel.com>
         <CAOUHufafMcaG8sOS=1YMy2P_6p0R1FzP16bCwpUau7g1-PybBQ@mail.gmail.com>
         <20210414155130.GU3762101@tassilo.jf.intel.com>
         <e0ad1b48a1ad0b6d3a1e79129f397ddb6c32fe35.camel@surriel.com>
         <CAOUHufaRXbDHbEro1uE1CHvpWB4U67iroj0hT8CkUEOSAddzYQ@mail.gmail.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-d7+pZEnMCdzHhTJvagz0"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Sender: riel@shelob.surriel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-d7+pZEnMCdzHhTJvagz0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2021-04-14 at 13:14 -0600, Yu Zhao wrote:
> On Wed, Apr 14, 2021 at 9:59 AM Rik van Riel <riel@surriel.com>
> wrote:
> > On Wed, 2021-04-14 at 08:51 -0700, Andi Kleen wrote:
> > > >    2) It will not scan PTE tables under non-leaf PMD entries
> > > > that
> > > > do not
> > > >       have the accessed bit set, when
> > > >       CONFIG_HAVE_ARCH_PARENT_PMD_YOUNG=3Dy.
> > >=20
> > > This assumes  that workloads have reasonable locality. Could
> > > there
> > > be a worst case where only one or two pages in each PTE are used,
> > > so this PTE skipping trick doesn't work?
> >=20
> > Databases with large shared memory segments shared between
> > many processes come to mind as a real-world example of a
> > worst case scenario.
>=20
> Well, I don't think you two are talking about the same thing. Andi
> was
> focusing on sparsity. Your example seems to be about sharing, i.e.,
> ihgh mapcount. Of course both can happen at the same time, as I
> tested
> here:
> https://lore.kernel.org/linux-mm/YHFuL%2FDdtiml4biw@google.com/#t
>=20
> I'm skeptical that shared memory used by databases is that sparse,
> i.e., one page per PTE table, because the extremely low locality
> would
> heavily penalize their performance. But my knowledge in databases is
> close to zero. So feel free to enlighten me or just ignore what I
> said.

A database may have a 200GB shared memory segment,
and a worker task that gets spun up to handle a
query might access only 1MB of memory to answer
that query.

That memory could be from anywhere inside the
shared memory segment. Maybe some of the accesses
are more dense, and others more sparse, who knows?

A lot of the locality
will depend on how memory
space inside the shared memory segment is reclaimed
and recycled inside the database.

--=20
All Rights Reversed.

--=-d7+pZEnMCdzHhTJvagz0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAmB3RXsACgkQznnekoTE
3oOQKgf/cHYeGYL+vEGo2ujR7QJ1IO0KzWQoVv9TjWcfYctiTXl+jzYf/fuyBLqh
Hk+VhgI+jxkQljbjg7Tha183gQRlykdjrghGI8ojQFkNIy1sNRH/JYAeiuqcw/zZ
3YUJhxS7WFczgI7KQ5+iLXFTQebr+UQE/LwfS+FW9gTYVg8OwizIfeQdCowQoiAt
qDbaVKQRClFyGYL7m3FKa84SodEXFf0JIY+qPrTqOWMwH93liO0rQhMNJIcw9XBx
Vd6Ns18YXOCk2tUlv9lVMVBPM+cM7PxFDPjgaZf+L5N2B7z/H2A4UsijUn1ZDe9U
RzcIQ9rtP3HF0tD/lwW4C0pnBLAwLg==
=BeNw
-----END PGP SIGNATURE-----

--=-d7+pZEnMCdzHhTJvagz0--

