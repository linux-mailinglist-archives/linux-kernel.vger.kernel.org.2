Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7726135F892
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 18:08:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352754AbhDNP7m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 11:59:42 -0400
Received: from shelob.surriel.com ([96.67.55.147]:56010 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352707AbhDNP7k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 11:59:40 -0400
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <riel@shelob.surriel.com>)
        id 1lWhuo-0000xe-34; Wed, 14 Apr 2021 11:58:54 -0400
Message-ID: <e0ad1b48a1ad0b6d3a1e79129f397ddb6c32fe35.camel@surriel.com>
Subject: Re: [PATCH v2 00/16] Multigenerational LRU Framework
From:   Rik van Riel <riel@surriel.com>
To:     Andi Kleen <ak@linux.intel.com>, Yu Zhao <yuzhao@google.com>
Cc:     Dave Chinner <david@fromorbit.com>, Jens Axboe <axboe@kernel.dk>,
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
Date:   Wed, 14 Apr 2021 11:58:53 -0400
In-Reply-To: <20210414155130.GU3762101@tassilo.jf.intel.com>
References: <20210413075155.32652-1-sjpark@amazon.de>
         <3ddd4f8a-8e51-662b-df11-a63a0e75b2bc@kernel.dk>
         <20210413231436.GF63242@dread.disaster.area>
         <f4750f9431bd12b7338a47925de8b17015da51a7.camel@surriel.com>
         <CAOUHufafMcaG8sOS=1YMy2P_6p0R1FzP16bCwpUau7g1-PybBQ@mail.gmail.com>
         <20210414155130.GU3762101@tassilo.jf.intel.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-fqISq52dkvESve12W123"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Sender: riel@shelob.surriel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-fqISq52dkvESve12W123
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2021-04-14 at 08:51 -0700, Andi Kleen wrote:
> >    2) It will not scan PTE tables under non-leaf PMD entries that
> > do not
> >       have the accessed bit set, when
> >       CONFIG_HAVE_ARCH_PARENT_PMD_YOUNG=3Dy.
>=20
> This assumes  that workloads have reasonable locality. Could there
> be a worst case where only one or two pages in each PTE are used,
> so this PTE skipping trick doesn't work?

Databases with large shared memory segments shared between
many processes come to mind as a real-world example of a
worst case scenario.

--=20
All Rights Reversed.

--=-fqISq52dkvESve12W123
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAmB3ET0ACgkQznnekoTE
3oOWmwf+NLdHxOkMEfUsaCu0VliS0AtOhRW/rs6xlDeVVKUN1ZUu0EWq090tsEmu
9HorztY9517iMoQG4aSewE5eFdoTA4DznUS9MU3E/7esp9Sw6zbQlg1wHif/Cc/w
qojnfuEvA4tjCZXiUKWJA/qpsvSRmr4tXhmZeJYhBw/V78WJTq0cZ1YKWhuJ+wu7
yeQ9lmt7FY371wa38hHGZ0B5aZqKfXqI4boaRApkVBz3KK4pATQCe7kI3lH0TY8+
XS/9h5DHgz5DaovC2P5LRwmZQG9ZZqytNPy4cYgCt9SSg/jFWRMKM7XnobVHIhsq
zqMi/EQUXy/bnnHNHR5q8CcsjrZmfA==
=GWQL
-----END PGP SIGNATURE-----

--=-fqISq52dkvESve12W123--

