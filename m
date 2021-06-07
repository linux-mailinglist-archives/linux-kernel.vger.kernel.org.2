Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 291EA39DC7E
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 14:33:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230410AbhFGMel (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 08:34:41 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:41484 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230173AbhFGMek (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 08:34:40 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 9E9B121A96;
        Mon,  7 Jun 2021 12:32:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1623069168; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bYe/q0XZrVntCLS9h05Nia2rO3f+wWzh6PGpj/Yy9h4=;
        b=vmT5v5q/BU0n/R6rlUEaXiMI6am6a1Gbh2ifEElQ1Zk4VYqib346fXY7X1D55/N/vTjNV5
        +rhizXMk/rJ78j7EOyNcd75/Sx3lYuocO301AWY915eup811E9dlbxb7onyGXRU+MZMHK9
        sfDxefgyDE9Ouri0c5rwtSVL0IzRQtM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1623069168;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bYe/q0XZrVntCLS9h05Nia2rO3f+wWzh6PGpj/Yy9h4=;
        b=QSFj2kiJ7Dp/neGZN2xzbOkvYe6O7s2l7vzZICVAR8gf/8cX9RyNiaSF/jXqUfgW2ki1De
        gockk7eDEIrK2/CQ==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id 827B3118DD;
        Mon,  7 Jun 2021 12:32:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1623069168; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bYe/q0XZrVntCLS9h05Nia2rO3f+wWzh6PGpj/Yy9h4=;
        b=vmT5v5q/BU0n/R6rlUEaXiMI6am6a1Gbh2ifEElQ1Zk4VYqib346fXY7X1D55/N/vTjNV5
        +rhizXMk/rJ78j7EOyNcd75/Sx3lYuocO301AWY915eup811E9dlbxb7onyGXRU+MZMHK9
        sfDxefgyDE9Ouri0c5rwtSVL0IzRQtM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1623069168;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bYe/q0XZrVntCLS9h05Nia2rO3f+wWzh6PGpj/Yy9h4=;
        b=QSFj2kiJ7Dp/neGZN2xzbOkvYe6O7s2l7vzZICVAR8gf/8cX9RyNiaSF/jXqUfgW2ki1De
        gockk7eDEIrK2/CQ==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id 6StMH/ARvmBNfgAALh3uQQ
        (envelope-from <vbabka@suse.cz>); Mon, 07 Jun 2021 12:32:48 +0000
To:     Muchun Song <songmuchun@bytedance.com>, cl@linux.com,
        penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20210606041750.69403-1-songmuchun@bytedance.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH] mm: slub: replace local_irq_save with local_irq_disable
Message-ID: <028651d9-5e3b-8348-00af-e6acf8ea4ced@suse.cz>
Date:   Mon, 7 Jun 2021 14:32:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210606041750.69403-1-songmuchun@bytedance.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/6/21 6:17 AM, Muchun Song wrote:
> The caller of slub_cpu_dead cannot be irq disabled (because slab_mutex is
> holding during the processing), there is no need to use irq_save. Just use
> irq_disable directly.

Well, we shouldn't need to disable irq at all. We are cleaning up for a dead
cpu, so there's nobody else accesing the data. irq save/disable will protect
only the local cpu's data, not of the cpu we are flushing. But we can't simply
remove the irq disable/enable because there are some nested
VM_BUG_ON(!irqs_disabled()) under __flush_cpu_slab(). We basically only disable
irqs here to avoid those from triggering.

My series [1] addresses this completely (among other things), but it's early
stage RFC (v2 should be soon). Your patch is not wrong, but also not urgent or
perf critical. So with that context I'll leave the decision to others :)

[1] https://lore.kernel.org/lkml/20210524233946.20352-1-vbabka@suse.cz/

> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> ---
>  mm/slub.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/slub.c b/mm/slub.c
> index ee51857d8e9b..fbf592ef14ff 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -2529,13 +2529,12 @@ static void flush_all(struct kmem_cache *s)
>  static int slub_cpu_dead(unsigned int cpu)
>  {
>  	struct kmem_cache *s;
> -	unsigned long flags;
>  
>  	mutex_lock(&slab_mutex);
>  	list_for_each_entry(s, &slab_caches, list) {
> -		local_irq_save(flags);
> +		local_irq_disable();
>  		__flush_cpu_slab(s, cpu);
> -		local_irq_restore(flags);
> +		local_irq_enable();
>  	}
>  	mutex_unlock(&slab_mutex);
>  	return 0;
> 

