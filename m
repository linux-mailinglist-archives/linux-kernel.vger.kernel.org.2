Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2757A3FC47F
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 11:00:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240445AbhHaIzZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 04:55:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240423AbhHaIzY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 04:55:24 -0400
Received: from vulcan.natalenko.name (vulcan.natalenko.name [IPv6:2001:19f0:6c00:8846:5400:ff:fe0c:dfa0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B57BC061575
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 01:54:29 -0700 (PDT)
Received: from spock.localnet (unknown [151.237.229.131])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by vulcan.natalenko.name (Postfix) with ESMTPSA id 51D49BC4F2F;
        Tue, 31 Aug 2021 10:54:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
        s=dkim-20170712; t=1630400066;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+HEGSe2ebXbBVDzslGRlT9ConeGmSo+zB76IgfFO5a8=;
        b=Jc0kkFdHTyeEuAAHC+pULbrOXwbhq/7J0KOb5SeUSFtbv9x6/0JyeyCWYb1Mr/vMHaGqjT
        cEjB5MRsf0KYRpRCKdDD2WWGI0W1k8ituYxTtgsWHQiRj4lmYsbvvtu+UQCJuV+uycHWf8
        WrvN6HdSF0LkCBFbz7sAnrhRSGqdM2w=
From:   Oleksandr Natalenko <oleksandr@natalenko.name>
To:     akpm@linux-foundation.org, Miaohe Lin <linmiaohe@huawei.com>
Cc:     vbabka@suse.cz, sfr@canb.auug.org.au, peterz@infradead.org,
        mgorman@techsingularity.net, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linmiaohe@huawei.com
Subject: Re: [PATCH 2/6] mm/page_alloc.c: simplify the code by using macro K()
Date:   Tue, 31 Aug 2021 10:54:24 +0200
Message-ID: <9161665.bUqNH3lxUD@natalenko.name>
In-Reply-To: <20210830141051.64090-3-linmiaohe@huawei.com>
References: <20210830141051.64090-1-linmiaohe@huawei.com> <20210830141051.64090-3-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

On pond=C4=9Bl=C3=AD 30. srpna 2021 16:10:47 CEST Miaohe Lin wrote:
> Use helper macro K() to convert the pages to the corresponding size.
> Minor readability improvement.
>=20
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>  mm/page_alloc.c | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)
>=20
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index dbb3338d9287..d3983244f56f 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -8134,8 +8134,7 @@ unsigned long free_reserved_area(void *start, void
> *end, int poison, const char }
>=20
>  	if (pages && s)
> -		pr_info("Freeing %s memory: %ldK\n",
> -			s, pages << (PAGE_SHIFT - 10));
> +		pr_info("Freeing %s memory: %ldK\n", s, K(pages));
>=20
>  	return pages;
>  }
> @@ -8180,14 +8179,13 @@ void __init mem_init_print_info(void)
>  		", %luK highmem"
>  #endif
>  		")\n",
> -		nr_free_pages() << (PAGE_SHIFT - 10),
> -		physpages << (PAGE_SHIFT - 10),
> +		K(nr_free_pages()), K(physpages),
>  		codesize >> 10, datasize >> 10, rosize >> 10,
>  		(init_data_size + init_code_size) >> 10, bss_size >> 10,
> -		(physpages - totalram_pages() - totalcma_pages) << (PAGE_SHIFT=20
=2D 10),
> -		totalcma_pages << (PAGE_SHIFT - 10)
> +		K(physpages - totalram_pages() - totalcma_pages),
> +		K(totalcma_pages)
>  #ifdef	CONFIG_HIGHMEM
> -		, totalhigh_pages() << (PAGE_SHIFT - 10)
> +		, K(totalhigh_pages())
>  #endif
>  		);
>  }

(my concern is not quite within the scope of this submission, but I'll ask=
=20
anyway)

Given we have this:

```
git grep '#define K(x)' v5.14
v5.14:drivers/base/node.c:#define K(x) ((x) << (PAGE_SHIFT - 10))
v5.14:drivers/net/hamradio/scc.c:#define K(x) kiss->x
v5.14:kernel/debug/kdb/kdb_main.c:#define K(x) ((x) << (PAGE_SHIFT - 10))
v5.14:mm/backing-dev.c:#define K(x) ((x) << (PAGE_SHIFT - 10))
v5.14:mm/memcontrol.c:#define K(x) ((x) << (PAGE_SHIFT-10))
v5.14:mm/oom_kill.c:#define K(x) ((x) << (PAGE_SHIFT-10))
v5.14:mm/page_alloc.c:#define K(x) ((x) << (PAGE_SHIFT-10))
```

Shouldn't this macro go to some header file instead to get rid of define=20
repetitions?

Thanks.

=2D-=20
Oleksandr Natalenko (post-factum)


