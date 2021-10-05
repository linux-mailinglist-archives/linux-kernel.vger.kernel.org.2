Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F7E042229A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 11:46:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233477AbhJEJrz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 05:47:55 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:37804 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232723AbhJEJry (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 05:47:54 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 2704E223BB;
        Tue,  5 Oct 2021 09:46:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1633427163; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3PzVyIIrgEezjranyNc5nPmS1dlxJBdJtBNQsCuW5RU=;
        b=bwVtP45s1aw1w7lYMwZzDGuMqKc4Kw1H38gSVSuv6Xidq7xUpgpboihxtSMA+5QxoAf5gY
        zxnFmv/Sy0bkMbAtiMbF4HD5HOJeVHX3jmNgo4NPHEWais+H7WEaW0IU9McBAUTGpDTIh8
        B42hByekkRwDl/sddgD1HFPLi/KRtpY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1633427163;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3PzVyIIrgEezjranyNc5nPmS1dlxJBdJtBNQsCuW5RU=;
        b=rhQJ35PXZH2zrvT+kkl6rIp+Z8ddfhUv/IeM7QgyDQkDFnQ2PI1wxp+5Nj/poaIc8vPj3n
        wup6mWcN9RBl+1Ag==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D9FDE13C23;
        Tue,  5 Oct 2021 09:46:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Id9qNNoeXGGKCwAAMHmgww
        (envelope-from <vbabka@suse.cz>); Tue, 05 Oct 2021 09:46:02 +0000
Message-ID: <1818ff73-3f14-a029-8c7f-370cd371abaa@suse.cz>
Date:   Tue, 5 Oct 2021 11:46:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.2
Subject: Re: [PATCH 1/5] mm, slub: fix two bugs in slab_debug_trace_open()
Content-Language: en-US
To:     Miaohe Lin <linmiaohe@huawei.com>, akpm@linux-foundation.org,
        cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com
Cc:     gregkh@linuxfoundation.org, faiyazm@codeaurora.org,
        andreyknvl@gmail.com, ryabinin.a.a@gmail.com, thgarnie@google.com,
        keescook@chromium.org, bharata@linux.ibm.com, guro@fb.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20210916123920.48704-1-linmiaohe@huawei.com>
 <20210916123920.48704-2-linmiaohe@huawei.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20210916123920.48704-2-linmiaohe@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/16/21 14:39, Miaohe Lin wrote:
> It's possible that __seq_open_private() will return NULL. So we should
> check t before using lest dereferencing NULL pointer. And in error paths,
> we forgot to release private buffer via seq_release_private(). Memory
> will leak in these paths.
> 
> Fixes: 64dd68497be7 ("mm: slub: move sysfs slab alloc/free interfaces to debugfs")
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>

Reviewed-by: Vlastimil Babka <vbabka@suse.cz>

> ---
>  mm/slub.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/slub.c b/mm/slub.c
> index 3d2025f7163b..ed160b6c54f8 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -6108,9 +6108,14 @@ static int slab_debug_trace_open(struct inode *inode, struct file *filep)
>  	struct kmem_cache *s = file_inode(filep)->i_private;
>  	unsigned long *obj_map;
>  
> +	if (!t)
> +		return -ENOMEM;
> +
>  	obj_map = bitmap_alloc(oo_objects(s->oo), GFP_KERNEL);
> -	if (!obj_map)
> +	if (!obj_map) {
> +		seq_release_private(inode, filep);
>  		return -ENOMEM;
> +	}
>  
>  	if (strcmp(filep->f_path.dentry->d_name.name, "alloc_traces") == 0)
>  		alloc = TRACK_ALLOC;
> @@ -6119,6 +6124,7 @@ static int slab_debug_trace_open(struct inode *inode, struct file *filep)
>  
>  	if (!alloc_loc_track(t, PAGE_SIZE / sizeof(struct location), GFP_KERNEL)) {
>  		bitmap_free(obj_map);
> +		seq_release_private(inode, filep);
>  		return -ENOMEM;
>  	}
>  
> 

