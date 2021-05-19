Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64C96389276
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 17:22:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346572AbhESPXv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 11:23:51 -0400
Received: from mx2.suse.de ([195.135.220.15]:36168 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240263AbhESPXu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 11:23:50 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 78F4FB18F;
        Wed, 19 May 2021 15:22:29 +0000 (UTC)
To:     Aaron Tomlin <atomlin@redhat.com>, linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, mhocko@suse.com,
        linux-kernel@vger.kernel.org
References: <20210519130609.r3ml6ohb2qsrfq2t@ava.usersys.com>
 <20210519145014.3220164-1-atomlin@redhat.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH] mm/page_alloc: bail out on fatal signal during
 reclaim/compaction retry attempt
Message-ID: <076e1c68-b4a2-26ea-9538-d88e6da800cc@suse.cz>
Date:   Wed, 19 May 2021 17:22:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210519145014.3220164-1-atomlin@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/19/21 4:50 PM, Aaron Tomlin wrote:
> It does not make sense to retry compaction when the last known compact
> result was skipped and a fatal signal is pending.
> 
> In the context of try_to_compact_pages(), indeed COMPACT_SKIPPED can be
> returned; albeit, not every zone, on the zone list, would be considered
> in the case a fatal signal is found to be pending.
> Yet, in should_compact_retry(), given the last known compaction result,
> each zone, on the zone list, can be considered/or checked
> (see compaction_zonelist_suitable()). For example, if a zone was found
> to succeed, then reclaim/compaction would be tried again
> (notwithstanding the above).
> 
> This patch ensures that compaction is not needlessly retried when the
> last known compaction result was skipped and in the unlikely case a
> fatal signal is found pending. So, OOM is at least attempted.
> 
> Signed-off-by: Aaron Tomlin <atomlin@redhat.com>

Hm, indeed, if fatal_signal_pending() is true then try_to_compact_pages() will
bail out in the for-each-zone loop after trying a single zone and if that zone
keeps returning COMPACT_SKIPPED, things can get stuck.
And direct reclaim might see compaction_ready() for another zone and return 1,
faking the progress.
So your patch seems to be solving the issue. But maybe we should just do the
test at the beginning of should_compact_retry() and not specific to
compaction_needs_reclaim() - if there's a fatal signal, there will be no
compaction happening, so we should just say not to retry.
I suppose if the patch fixes your situation where fatal_signal_pending() was
true, there's hopefully not a more general problem with the retry logic?

> ---
>  mm/page_alloc.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index aaa1655cf682..5f9aac27a1b5 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -4268,6 +4268,8 @@ should_compact_retry(struct alloc_context *ac, int order, int alloc_flags,
>  	 * to work with, so we retry only if it looks like reclaim can help.
>  	 */
>  	if (compaction_needs_reclaim(compact_result)) {
> +		if (fatal_signal_pending(current))
> +			goto out;
>  		ret = compaction_zonelist_suitable(ac, order, alloc_flags);
>  		goto out;
>  	}
> 

