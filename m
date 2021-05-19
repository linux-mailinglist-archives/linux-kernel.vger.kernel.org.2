Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6EAD3884AD
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 04:12:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234877AbhESCOL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 22:14:11 -0400
Received: from shelob.surriel.com ([96.67.55.147]:42456 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234810AbhESCOL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 22:14:11 -0400
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <riel@shelob.surriel.com>)
        id 1ljBhT-0007c4-Hi; Tue, 18 May 2021 22:12:43 -0400
Message-ID: <7b2525ba7871e6b8ce3f48cfd2375804a6791a94.camel@surriel.com>
Subject: Re: [PATCH] mm: move idle swap cache pages to the tail of LRU after
 COW
From:   Rik van Riel <riel@surriel.com>
To:     Huang Ying <ying.huang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Xu <peterx@redhat.com>, Hugh Dickins <hughd@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Mel Gorman <mgorman@suse.de>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Tim Chen <tim.c.chen@intel.com>
Date:   Tue, 18 May 2021 22:12:42 -0400
In-Reply-To: <20210519013313.1274454-1-ying.huang@intel.com>
References: <20210519013313.1274454-1-ying.huang@intel.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-+Nrc0dF5GFqX39nniyXu"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Sender: riel@shelob.surriel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-+Nrc0dF5GFqX39nniyXu
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2021-05-19 at 09:33 +0800, Huang Ying wrote:

> To test the patch, we used pmbench memory accessing benchmark with
> working-set larger than available memory on a 2-socket Intel server
> with a NVMe SSD as swap device.  Test results shows that the pmbench
> score increases up to 21.8% with the decreased size of swap cache and
> swapin throughput.

Nice!

> +++ b/mm/memory.c
> @@ -3012,6 +3012,11 @@ static vm_fault_t wp_page_copy(struct vm_fault
> *vmf)
>  				munlock_vma_page(old_page);
>  			unlock_page(old_page);
>  		}
> +		if (page_copied && PageSwapCache(old_page) &&
> +		    !page_mapped(old_page) && trylock_page(old_page)) {
> +			try_to_free_idle_swapcache(old_page);
> +			unlock_page(old_page);
> +		}

That's quite the if condition!

Would it make sense to move some of the tests, as well
as the trylock and unlock into try_to_free_idle_swapcache()
itself?

Especially considering that page_mapped is already tested
in that function, too...

>  		put_page(old_page);
>  	}



--=20
All Rights Reversed.

--=-+Nrc0dF5GFqX39nniyXu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAmCkdBsACgkQznnekoTE
3oP/8wf+IHvOwx3SjsbsPXZHF7maNb3/rGGoplUC8wLZ8UCVZkmCEgu73qmQzrET
VUCRzXxqiwcusFHfp5nj8LUoP7Cyyg8e7tLKPGtEeadoM22SNm+/LPUZV1ovUbIC
PzuEj3A+8UzL6Tzvb01PV4kiYxTzhiN4/L1j8xK9G3AFfGHPfR75NTG8CPi59Uv+
osFW54seWNG03iLZnn2fzlfu3RUHfvqNNxcoxAbMATLJyIF3pCWEYr6mfmWF0bs7
9GmyKvtDkYK0lBmCTN+tVojYfqJ+D/4n+QDkzXCOQGa2KuUMu/pT5/oar7wfQFt/
eggA8J5VqSBKhgK/MKBIkPCADN+7Ig==
=PxL1
-----END PGP SIGNATURE-----

--=-+Nrc0dF5GFqX39nniyXu--

