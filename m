Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F9BD418FCD
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 09:22:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233185AbhI0HYC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 03:24:02 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:56788 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233137AbhI0HYB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 03:24:01 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 24CDC20090;
        Mon, 27 Sep 2021 07:22:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1632727343; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=twi7tr3G0mRox0fdt3s9a0k/zFUh4epYUQC3P5pAYHo=;
        b=w7Vb50P3NzNYxA5AXNudFCAi8XCg/8hwLk8Utkxy6wLKocK8lS0oXYMn6UxXe4tVsJ+wrX
        4yPbhB6oylqoER4uZGuCJQL1WCzNIzlkhz4z0IDo5OQNiiFXjL5fD65Jz2D5ctXclL4yXw
        VtYEEMSwHstaa6xVhu1uFFhpbK0TRDI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1632727343;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=twi7tr3G0mRox0fdt3s9a0k/zFUh4epYUQC3P5pAYHo=;
        b=4WtWXvGEp8V8Rm5+8ZT0cdHvLk4IA4m7vroQRytxijJqGwY3WvxUMNKCEaAxFL5Gupj5dJ
        26560LowpYPmneCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EA28013A1E;
        Mon, 27 Sep 2021 07:22:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id oyFvOC5xUWEOLAAAMHmgww
        (envelope-from <vbabka@suse.cz>); Mon, 27 Sep 2021 07:22:22 +0000
Message-ID: <566f2009-6acf-4fb9-f7c0-edc1d6ce6561@suse.cz>
Date:   Mon, 27 Sep 2021 09:22:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
Subject: Re: [PATCH resend] slub: Add back check for free nonslab objects
Content-Language: en-US
To:     Kefeng Wang <wangkefeng.wang@huawei.com>, shakeelb@google.com,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20210927021538.155991-1-wangkefeng.wang@huawei.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20210927021538.155991-1-wangkefeng.wang@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/27/21 04:15, Kefeng Wang wrote:
> After commit ("f227f0faf63b slub: fix unreclaimable slab stat for bulk
> free"), the check for free nonslab page is replaced by VM_BUG_ON_PAGE,
> which only check with CONFIG_DEBUG_VM enabled, but this config may
> impact performance, so it only for debug.
> 
> Commit ("0937502af7c9 slub: Add check for kfree() of non slab objects.")
> add the ability, which should be needed in any configs to catch the
> invalid free, they even could be potential issue, eg, memory corruption,
> use after free and double-free, so replace VM_BUG_ON_PAGE to WARN_ON, and
> add dump_page() to help use to debug the issue.

There are other situations in SLUB (such as with smaller allocations that
don't go directly to page allocator) where use after free and double-free
are undetected in non-debug configs, and it's expected that anyone debugging
them will enable slub_debug or even DEBUG_VM. Why should this special case
with nonslab pages be different?

> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---
>  mm/slub.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/slub.c b/mm/slub.c
> index 3095b889fab4..555c2e6ccfca 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -3522,7 +3522,8 @@ static inline void free_nonslab_page(struct page *page, void *object)
>  {
>  	unsigned int order = compound_order(page);
>  
> -	VM_BUG_ON_PAGE(!PageCompound(page), page);
> +	if (WARN_ON(!PageCompound(page)))
> +		dump_page(page, "invalid free nonslab page");
>  	kfree_hook(object);
>  	mod_lruvec_page_state(page, NR_SLAB_UNRECLAIMABLE_B, -(PAGE_SIZE << order));
>  	__free_pages(page, order);
> 

