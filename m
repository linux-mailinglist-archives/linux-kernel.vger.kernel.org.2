Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1DE8422302
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 12:02:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233855AbhJEKEq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 06:04:46 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:57746 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232658AbhJEKEn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 06:04:43 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id C840A20002;
        Tue,  5 Oct 2021 10:02:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1633428172; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TRF8ELWEC1qxhJ/5dNducCWpR3zUfGm/bOvx5X3DSHI=;
        b=s19IdSWkE5zR/troGKl9mvP+u8j19UbOU8PoyoL8Ux7UCwD9p0xWdooHQ78dl54a6mBX7Z
        RX9U/vKiF8JVGaKS2mV4a8dzH3KUCrByLNZ13T/UMs4JtJ97e99RBc8a6E75c4wzo4GErq
        6l8OCe6YthEr/agulzhvh/RKVMAW2wk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1633428172;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TRF8ELWEC1qxhJ/5dNducCWpR3zUfGm/bOvx5X3DSHI=;
        b=iRkP23tVh0lUdovrpOcT6fJIIbCcaJ4yxuMuShuQ1VVnrL8g683YHad2QzRWVbZ5C4bdW0
        MWniqZ6ITQy7FUAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 903B913C23;
        Tue,  5 Oct 2021 10:02:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id GTmDIswiXGH2EwAAMHmgww
        (envelope-from <vbabka@suse.cz>); Tue, 05 Oct 2021 10:02:52 +0000
Message-ID: <0c6203b3-5f25-d3d1-aefa-d975201c7637@suse.cz>
Date:   Tue, 5 Oct 2021 12:02:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.2
Subject: Re: [PATCH 3/5] mm, slub: fix potential memoryleak in
 kmem_cache_open()
Content-Language: en-US
To:     Miaohe Lin <linmiaohe@huawei.com>, akpm@linux-foundation.org,
        cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com
Cc:     gregkh@linuxfoundation.org, faiyazm@codeaurora.org,
        andreyknvl@gmail.com, ryabinin.a.a@gmail.com, thgarnie@google.com,
        keescook@chromium.org, bharata@linux.ibm.com, guro@fb.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20210916123920.48704-1-linmiaohe@huawei.com>
 <20210916123920.48704-4-linmiaohe@huawei.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20210916123920.48704-4-linmiaohe@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/16/21 14:39, Miaohe Lin wrote:
> In error path, the random_seq of slub cache might be leaked. Fix this by
> using __kmem_cache_release() to release all the relevant resources.
> 
> Fixes: 210e7a43fa90 ("mm: SLUB freelist randomization")
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>

Reviewed-by: Vlastimil Babka <vbabka@suse.cz>

> ---
>  mm/slub.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/slub.c b/mm/slub.c
> index a56a6423d4e8..bf1793fb4ce5 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -4210,8 +4210,8 @@ static int kmem_cache_open(struct kmem_cache *s, slab_flags_t flags)
>  	if (alloc_kmem_cache_cpus(s))
>  		return 0;
>  
> -	free_kmem_cache_nodes(s);
>  error:
> +	__kmem_cache_release(s);
>  	return -EINVAL;
>  }
>  
> 

