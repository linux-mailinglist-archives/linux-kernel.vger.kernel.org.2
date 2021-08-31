Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08B9D3FC999
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 16:19:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232743AbhHaOU1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 10:20:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230135AbhHaOUZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 10:20:25 -0400
Received: from vulcan.natalenko.name (vulcan.natalenko.name [IPv6:2001:19f0:6c00:8846:5400:ff:fe0c:dfa0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0DFFC061575
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 07:19:27 -0700 (PDT)
Received: from spock.localnet (unknown [151.237.229.131])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by vulcan.natalenko.name (Postfix) with ESMTPSA id D0D53BC580A;
        Tue, 31 Aug 2021 16:19:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
        s=dkim-20170712; t=1630419565;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9VeBKeJ05t6np4FlW97smb4L774a58zRoIObnDWLK0Y=;
        b=VwWYzK3+aXVtW6Bt32XuwLs8bTCHqhPth47Kxs4FOv7Z1EdFUh4dKgU/cJrJuRB7zS2L/S
        ++2x8A9IPi0BGswv6MZEkGaiJM3VH97hNmKrAYFyqTE0zVohr63h9r2l/Yf/0uLneWj2tG
        uoqVf7DlnYVyHh/izPjBhI+VboPAD7Q=
From:   Oleksandr Natalenko <oleksandr@natalenko.name>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     vbabka@suse.cz, sfr@canb.auug.org.au, peterz@infradead.org,
        mgorman@techsingularity.net, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 2/6] mm/page_alloc.c: simplify the code by using macro K()
Date:   Tue, 31 Aug 2021 16:19:23 +0200
Message-ID: <9426505.MgecbftzqH@natalenko.name>
In-Reply-To: <52bbb8f2-db63-8c56-ea49-d982c13ba541@huawei.com>
References: <20210830141051.64090-1-linmiaohe@huawei.com> <9161665.bUqNH3lxUD@natalenko.name> <52bbb8f2-db63-8c56-ea49-d982c13ba541@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

On =C3=BAter=C3=BD 31. srpna 2021 13:08:42 CEST Miaohe Lin wrote:
> On 2021/8/31 16:54, Oleksandr Natalenko wrote:
> > Hello.
> >=20
> > On pond=C4=9Bl=C3=AD 30. srpna 2021 16:10:47 CEST Miaohe Lin wrote:
> >> Use helper macro K() to convert the pages to the corresponding size.
> >> Minor readability improvement.
> >>=20
> >> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> >> ---
> >>=20
> >>  mm/page_alloc.c | 12 +++++-------
> >>  1 file changed, 5 insertions(+), 7 deletions(-)
> >>=20
> >> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> >> index dbb3338d9287..d3983244f56f 100644
> >> --- a/mm/page_alloc.c
> >> +++ b/mm/page_alloc.c
> >> @@ -8134,8 +8134,7 @@ unsigned long free_reserved_area(void *start, vo=
id
> >> *end, int poison, const char }
> >>=20
> >>  	if (pages && s)
> >>=20
> >> -		pr_info("Freeing %s memory: %ldK\n",
> >> -			s, pages << (PAGE_SHIFT - 10));
> >> +		pr_info("Freeing %s memory: %ldK\n", s, K(pages));
> >>=20
> >>  	return pages;
> >> =20
> >>  }
> >>=20
> >> @@ -8180,14 +8179,13 @@ void __init mem_init_print_info(void)
> >>=20
> >>  		", %luK highmem"
> >> =20
> >>  #endif
> >> =20
> >>  		")\n",
> >>=20
> >> -		nr_free_pages() << (PAGE_SHIFT - 10),
> >> -		physpages << (PAGE_SHIFT - 10),
> >> +		K(nr_free_pages()), K(physpages),
> >>=20
> >>  		codesize >> 10, datasize >> 10, rosize >> 10,
> >>  		(init_data_size + init_code_size) >> 10, bss_size >> 10,
> >>=20
> >> -		(physpages - totalram_pages() - totalcma_pages) << (PAGE_SHIFT
> >=20
> > - 10),
> >=20
> >> -		totalcma_pages << (PAGE_SHIFT - 10)
> >> +		K(physpages - totalram_pages() - totalcma_pages),
> >> +		K(totalcma_pages)
> >>=20
> >>  #ifdef	CONFIG_HIGHMEM
> >>=20
> >> -		, totalhigh_pages() << (PAGE_SHIFT - 10)
> >> +		, K(totalhigh_pages())
> >>=20
> >>  #endif
> >> =20
> >>  		);
> >> =20
> >>  }
> >=20
> > (my concern is not quite within the scope of this submission, but I'll =
ask
> > anyway)
> >=20
> > Given we have this:
> >=20
> > ```
> > git grep '#define K(x)' v5.14
> > v5.14:drivers/base/node.c:#define K(x) ((x) << (PAGE_SHIFT - 10))
> > v5.14:drivers/net/hamradio/scc.c:#define K(x) kiss->x
> > v5.14:kernel/debug/kdb/kdb_main.c:#define K(x) ((x) << (PAGE_SHIFT - 10=
))
> > v5.14:mm/backing-dev.c:#define K(x) ((x) << (PAGE_SHIFT - 10))
> > v5.14:mm/memcontrol.c:#define K(x) ((x) << (PAGE_SHIFT-10))
> > v5.14:mm/oom_kill.c:#define K(x) ((x) << (PAGE_SHIFT-10))
> > v5.14:mm/page_alloc.c:#define K(x) ((x) << (PAGE_SHIFT-10))
> > ```
> >=20
> > Shouldn't this macro go to some header file instead to get rid of define
> > repetitions?
>=20
> Many thanks for figuring this out. I think we should get rid of these
> repetitions too. But I'am not sure where this definition should be. Any
> suggestion? Thanks.

I'm not sure what place suits best. At first I thought maybe linux/mm.h or=
=20
linux/mm_inline.h, but since PAGE_SHIFT is declared in asm-generic/page.h,=
=20
probably K(x) can also go there as well?

=2D-=20
Oleksandr Natalenko (post-factum)


