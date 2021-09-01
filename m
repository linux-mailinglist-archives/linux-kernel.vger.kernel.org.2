Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FE6E3FD4BB
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 09:47:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242780AbhIAHrT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 03:47:19 -0400
Received: from vulcan.natalenko.name ([104.207.131.136]:54978 "EHLO
        vulcan.natalenko.name" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242622AbhIAHrS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 03:47:18 -0400
Received: from spock.localnet (unknown [151.237.229.131])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by vulcan.natalenko.name (Postfix) with ESMTPSA id 54E60BC723F;
        Wed,  1 Sep 2021 09:46:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
        s=dkim-20170712; t=1630482380;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jd8pd6oI+wsSrsbrPr6mq4lPlotp13CxG8uyl5WvZqw=;
        b=ZcKLDnuAz/oVfROxqCJ3N35+BMHxdHJXjyYqPvAcIt+Rou6yktmDIYunqnYlk/3IXQX/Se
        K50Ij23wvsVp2ubtz7+piVDXcTPIP7Mb/Qhrr4SPv/4ewvtsBe9yoPSEPV128K89fVYI2G
        jUL5pf6CKcPD8EW4Bdlc/46gRWnfTYQ=
From:   Oleksandr Natalenko <oleksandr@natalenko.name>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     vbabka@suse.cz, sfr@canb.auug.org.au, peterz@infradead.org,
        mgorman@techsingularity.net, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 2/6] mm/page_alloc.c: simplify the code by using macro K()
Date:   Wed, 01 Sep 2021 09:46:17 +0200
Message-ID: <5931202.uRb02ylMo7@natalenko.name>
In-Reply-To: <03653d41-abe0-46f0-9eee-28cad9f5edea@huawei.com>
References: <20210830141051.64090-1-linmiaohe@huawei.com> <9426505.MgecbftzqH@natalenko.name> <03653d41-abe0-46f0-9eee-28cad9f5edea@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

On st=C5=99eda 1. z=C3=A1=C5=99=C3=AD 2021 9:37:49 CEST Miaohe Lin wrote:
> On 2021/8/31 22:19, Oleksandr Natalenko wrote:
> > On =C3=BAter=C3=BD 31. srpna 2021 13:08:42 CEST Miaohe Lin wrote:
> >> On 2021/8/31 16:54, Oleksandr Natalenko wrote:
> >>> On pond=C4=9Bl=C3=AD 30. srpna 2021 16:10:47 CEST Miaohe Lin wrote:
> >>>> Use helper macro K() to convert the pages to the corresponding size.
> >>>> Minor readability improvement.
> >>>>=20
> >>>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> >>>> ---
> >>>>=20
> >>>>  mm/page_alloc.c | 12 +++++-------
> >>>>  1 file changed, 5 insertions(+), 7 deletions(-)
> >>>>=20
> >>>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> >>>> index dbb3338d9287..d3983244f56f 100644
> >>>> --- a/mm/page_alloc.c
> >>>> +++ b/mm/page_alloc.c
> >>>> @@ -8134,8 +8134,7 @@ unsigned long free_reserved_area(void *start,
> >>>> void
> >>>> *end, int poison, const char }
> >>>>=20
> >>>>  	if (pages && s)
> >>>>=20
> >>>> -		pr_info("Freeing %s memory: %ldK\n",
> >>>> -			s, pages << (PAGE_SHIFT - 10));
> >>>> +		pr_info("Freeing %s memory: %ldK\n", s, K(pages));
> >>>>=20
> >>>>  	return pages;
> >>>> =20
> >>>>  }
> >>>>=20
> >>>> @@ -8180,14 +8179,13 @@ void __init mem_init_print_info(void)
> >>>>=20
> >>>>  		", %luK highmem"
> >>>> =20
> >>>>  #endif
> >>>> =20
> >>>>  		")\n",
> >>>>=20
> >>>> -		nr_free_pages() << (PAGE_SHIFT - 10),
> >>>> -		physpages << (PAGE_SHIFT - 10),
> >>>> +		K(nr_free_pages()), K(physpages),
> >>>>=20
> >>>>  		codesize >> 10, datasize >> 10, rosize >> 10,
> >>>>  		(init_data_size + init_code_size) >> 10, bss_size >> 10,
> >>>>=20
> >>>> -		(physpages - totalram_pages() - totalcma_pages) <<=20
(PAGE_SHIFT
> >>>=20
> >>> - 10),
> >>>=20
> >>>> -		totalcma_pages << (PAGE_SHIFT - 10)
> >>>> +		K(physpages - totalram_pages() - totalcma_pages),
> >>>> +		K(totalcma_pages)
> >>>>=20
> >>>>  #ifdef	CONFIG_HIGHMEM
> >>>>=20
> >>>> -		, totalhigh_pages() << (PAGE_SHIFT - 10)
> >>>> +		, K(totalhigh_pages())
> >>>>=20
> >>>>  #endif
> >>>> =20
> >>>>  		);
> >>>> =20
> >>>>  }
> >>>=20
> >>> (my concern is not quite within the scope of this submission, but I'll
> >>> ask
> >>> anyway)
> >>>=20
> >>> Given we have this:
> >>>=20
> >>> ```
> >>> git grep '#define K(x)' v5.14
> >>> v5.14:drivers/base/node.c:#define K(x) ((x) << (PAGE_SHIFT - 10))
> >>> v5.14:drivers/net/hamradio/scc.c:#define K(x) kiss->x
> >>> v5.14:kernel/debug/kdb/kdb_main.c:#define K(x) ((x) << (PAGE_SHIFT -
> >>> 10))
> >>> v5.14:mm/backing-dev.c:#define K(x) ((x) << (PAGE_SHIFT - 10))
> >>> v5.14:mm/memcontrol.c:#define K(x) ((x) << (PAGE_SHIFT-10))
> >>> v5.14:mm/oom_kill.c:#define K(x) ((x) << (PAGE_SHIFT-10))
> >>> v5.14:mm/page_alloc.c:#define K(x) ((x) << (PAGE_SHIFT-10))
> >>> ```
> >>>=20
> >>> Shouldn't this macro go to some header file instead to get rid of def=
ine
> >>> repetitions?
> >>=20
> >> Many thanks for figuring this out. I think we should get rid of these
> >> repetitions too. But I'am not sure where this definition should be. Any
> >> suggestion? Thanks.
> >=20
> > I'm not sure what place suits best. At first I thought maybe linux/mm.h=
 or
> > linux/mm_inline.h, but since PAGE_SHIFT is declared in asm-generic/page=
=2Eh,
> > probably K(x) can also go there as well?
>=20
> K(x) is relevant with PAGE_SHIFT. So I think K(x) can also go
> asm-generic/page.h too.

Actually, the comment in this file says:

```
4 /*
5  * Generic page.h implementation, for NOMMU architectures.
6  * This provides the dummy definitions for the memory management.
7  */
```

so it seems I was wrong about this being an appropriate place.

> Am I supposed to do this when free or will you
> kindly do this?

Let me just try to cram this into mm.h and send it out, and then we'll see=
=20
what comments people suggest.

Thanks.

=2D-=20
Oleksandr Natalenko (post-factum)


