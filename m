Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A691439099
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 09:50:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232036AbhJYHxO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 03:53:14 -0400
Received: from vmi485042.contaboserver.net ([161.97.139.209]:34488 "EHLO
        gentwo.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229491AbhJYHxM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 03:53:12 -0400
Received: by gentwo.de (Postfix, from userid 1001)
        id 783F5B00267; Mon, 25 Oct 2021 09:50:48 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by gentwo.de (Postfix) with ESMTP id 7443EB00100;
        Mon, 25 Oct 2021 09:50:48 +0200 (CEST)
Date:   Mon, 25 Oct 2021 09:50:48 +0200 (CEST)
From:   Christoph Lameter <cl@gentwo.de>
To:     Yuanzheng Song <songyuanzheng@huawei.com>
cc:     dennis@kernel.org, tj@kernel.org, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] mm/percpu: fix data-race with
 pcpu_nr_empty_pop_pages
In-Reply-To: <20211025070015.553813-1-songyuanzheng@huawei.com>
Message-ID: <alpine.DEB.2.22.394.2110250943310.2528@gentwo.de>
References: <20211025070015.553813-1-songyuanzheng@huawei.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Oct 2021, Yuanzheng Song wrote:

> When reading the pcpu_nr_empty_pop_pages in pcpu_alloc()
> and writing the pcpu_nr_empty_pop_pages in
> pcpu_update_empty_pages() at the same time,
> the data-race occurs.

Looks like a use case for the atomic RMV instructions.

> To fix this issue, use READ_ONCE() and WRITE_ONCE() to
> read and write the pcpu_nr_empty_pop_pages.

Never thought that READ_ONCE and WRITE_ONCE can fix races like
this. Really?

> diff --git a/mm/percpu.c b/mm/percpu.c
> index 293009cc03ef..e8ef92e698ab 100644
> --- a/mm/percpu.c
> +++ b/mm/percpu.c
> @@ -574,7 +574,9 @@ static void pcpu_isolate_chunk(struct pcpu_chunk *chunk)
>
>  	if (!chunk->isolated) {
>  		chunk->isolated = true;
> -		pcpu_nr_empty_pop_pages -= chunk->nr_empty_pop_pages;
> +		WRITE_ONCE(pcpu_nr_empty_pop_pages,
> +			   READ_ONCE(pcpu_nr_empty_pop_pages) -
> +			   chunk->nr_empty_pop_pages);

atomic_sub()?

>  	}
>  	list_move(&chunk->list, &pcpu_chunk_lists[pcpu_to_depopulate_slot]);
>  }
> @@ -585,7 +587,9 @@ static void pcpu_reintegrate_chunk(struct pcpu_chunk *chunk)
>
>  	if (chunk->isolated) {
>  		chunk->isolated = false;
> -		pcpu_nr_empty_pop_pages += chunk->nr_empty_pop_pages;
> +		WRITE_ONCE(pcpu_nr_empty_pop_pages,
> +			   READ_ONCE(pcpu_nr_empty_pop_pages) +
> +			   chunk->nr_empty_pop_pages);

atomic_add()?
