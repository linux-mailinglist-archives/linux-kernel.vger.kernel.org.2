Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF39633C6F9
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 20:41:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233311AbhCOTkq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 15:40:46 -0400
Received: from shelob.surriel.com ([96.67.55.147]:49186 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232024AbhCOTka (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 15:40:30 -0400
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <riel@shelob.surriel.com>)
        id 1lLt4V-0008JW-7D; Mon, 15 Mar 2021 15:40:11 -0400
Message-ID: <048e5e1e977e720c3f9fc536ac54beebcc8319f5.camel@surriel.com>
Subject: Re: [PATCH v1 09/14] mm: multigenerational lru: mm_struct list
From:   Rik van Riel <riel@surriel.com>
To:     Yu Zhao <yuzhao@google.com>, linux-mm@kvack.org
Cc:     Alex Shi <alex.shi@linux.alibaba.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Hillf Danton <hdanton@sina.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>, Michal Hocko <mhocko@suse.com>,
        Roman Gushchin <guro@fb.com>, Vlastimil Babka <vbabka@suse.cz>,
        Wei Yang <richard.weiyang@linux.alibaba.com>,
        Yang Shi <shy828301@gmail.com>,
        Ying Huang <ying.huang@intel.com>,
        linux-kernel@vger.kernel.org, page-reclaim@google.com
Date:   Mon, 15 Mar 2021 15:40:10 -0400
In-Reply-To: <20210313075747.3781593-10-yuzhao@google.com>
References: <20210313075747.3781593-1-yuzhao@google.com>
         <20210313075747.3781593-10-yuzhao@google.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-19NcWN0KB6IZDZ4ZjXkn"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Sender: riel@shelob.surriel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-19NcWN0KB6IZDZ4ZjXkn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 2021-03-13 at 00:57 -0700, Yu Zhao wrote:

> +/*
> + * After pages are faulted in, they become the youngest generation.
> They must
> + * go through aging process twice before they can be evicted. After
> first scan,
> + * their accessed bit set during initial faults are cleared and they
> become the
> + * second youngest generation. And second scan makes sure they
> haven't been used
> + * since the first.
> + */

I have to wonder if the reductions in OOM kills and=20
low-memory tab discards is due to this aging policy
change, rather than from the switch to virtual scanning.

--=20
All Rights Reversed.

--=-19NcWN0KB6IZDZ4ZjXkn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAmBPuBoACgkQznnekoTE
3oNuBwf9F81lfW/snOIZ0xVgUD2f+HT5RenvjslOA2pATrLe1eqBmewSCp+07WzK
wiSTeynZ7wGt7Mt0I3GKmoJiYey81U9uktslnYRqQsVY5/FdkU97dfij8K4LFlQL
vb31hTTpaR+n5t8CPCbTscX1HxwR3v1GJzCQKND0FOHGnFnqf3SgK6g2uK0poXD3
OjgKujlBuWAQTXXkGv2ZULyY82tsJc6n6R2dB2a8BpzrkZoN1qh8IvtwArwq9IoJ
sqzz5EslgyqclFQz6jjAMuSLtYVYy5dn6NW98vJUoDnCWw39Mf8oCKK9YxtH9DaD
cTU6f9MYMav3eNkSH5SN0+cLV+NEcg==
=UIpp
-----END PGP SIGNATURE-----

--=-19NcWN0KB6IZDZ4ZjXkn--

