Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17BFF394302
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 14:53:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235297AbhE1MzP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 08:55:15 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:33492 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbhE1MzO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 08:55:14 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id B2D5B218B3;
        Fri, 28 May 2021 12:53:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1622206418; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9CQB6EWZ6xfQcnCaj2E3znJZU9HdjEBg7Abqu1tWIqQ=;
        b=iV0LyRnJj1ccNBJDvAyJhV75xTk06LrvOshh2YO2gQB8ELXJ8aD0+o7Zl39riZjabuhTed
        tt6hFo3Rv/ANBzAPsALdB4wsjG2k6DMjjEovLBXnLVTAg60cJjg88RG3IvsfQ5pPeOB/gI
        77Z+oLTH1NKqSyMbgHvQavPEfxRjQFk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1622206418;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9CQB6EWZ6xfQcnCaj2E3znJZU9HdjEBg7Abqu1tWIqQ=;
        b=cBYwmct3DOk0O8sYKqASgki4a4xQrw9S+2lIhjfcx9d6lv7lP0HpNHVBwiErSG0gX66YL0
        mAa99vB8lwo7wbDg==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id 9EC1611A98;
        Fri, 28 May 2021 12:53:38 +0000 (UTC)
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id Kxg7JtLnsGDyNQAALh3uQQ
        (envelope-from <vbabka@suse.cz>); Fri, 28 May 2021 12:53:38 +0000
Subject: Re: [PATCH v4] mm/page_alloc: bail out on fatal signal during
 reclaim/compaction retry attempt
To:     Aaron Tomlin <atomlin@redhat.com>, linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, mhocko@suse.com, willy@infradead.org,
        linux-kernel@vger.kernel.org
References: <YKZObDpduqwWi/Zm@casper.infradead.org>
 <20210520142901.3371299-1-atomlin@redhat.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <c94f4323-1f63-e9f0-6dfd-402cbbc39a87@suse.cz>
Date:   Fri, 28 May 2021 14:53:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210520142901.3371299-1-atomlin@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/20/21 4:29 PM, Aaron Tomlin wrote:
> A customer experienced a low-memory situation and decided to issue a
> SIGKILL (i.e. a fatal signal). Instead of promptly terminating as one
> would expect, the aforementioned task remained unresponsive.
> 
> Further investigation indicated that the task was "stuck" in the
> reclaim/compaction retry loop. Now, it does not make sense to retry
> compaction when a fatal signal is pending.
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
> This patch ensures that compaction is not needlessly retried
> irrespective of the last known compaction result e.g. if it was skipped,
> in the unlikely case a fatal signal is found pending.
> So, OOM is at least attempted.
> 
> Signed-off-by: Aaron Tomlin <atomlin@redhat.com>

Reviewed-by: Vlastimil Babka <vbabka@suse.cz>

> ---
>  mm/page_alloc.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index aaa1655cf682..b317057ac186 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -4252,6 +4252,9 @@ should_compact_retry(struct alloc_context *ac, int order, int alloc_flags,
>  	if (!order)
>  		return false;
>  
> +	if (fatal_signal_pending(current))
> +		return false;
> +
>  	if (compaction_made_progress(compact_result))
>  		(*compaction_retries)++;
>  
> 

