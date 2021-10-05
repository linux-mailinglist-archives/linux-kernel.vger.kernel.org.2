Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB0564223E4
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 12:50:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234133AbhJEKwB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 06:52:01 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:48538 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233449AbhJEKwA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 06:52:00 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 4018322399;
        Tue,  5 Oct 2021 10:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1633431009; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2DQaqPggyWWoMxTaHdXWjVgb1l7WIagrAmguoKg/TnA=;
        b=msbAxrcHNubAn4zcdV6E1sjtDeOExeet6Mk1x5PUjh5jk4CYXlnUsbHi7l5lErdO8Pr3rt
        Kty8j4tjrm+his1g8oAdAa+8rbUxPJemSspEcbeZrOUnAoLgCnIV2/Yju3ddhjs/fC2yRn
        I9fYpJEQbzEkY05n8+os4d/UVagTtC4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1633431009;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2DQaqPggyWWoMxTaHdXWjVgb1l7WIagrAmguoKg/TnA=;
        b=33vDENUIGNRWQAb7RlL6sSYQ2YLfGmED7HTQCx9nMia+qHjH+MfivbCfE4Zh6mCpfT92LA
        mHO++pdnkc/8vWCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EC2A613C2B;
        Tue,  5 Oct 2021 10:50:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id jyGIOOAtXGGsKgAAMHmgww
        (envelope-from <vbabka@suse.cz>); Tue, 05 Oct 2021 10:50:08 +0000
Message-ID: <25db026b-76bc-cad3-7913-c310fc6cd822@suse.cz>
Date:   Tue, 5 Oct 2021 12:50:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.2
Subject: Re: [PATCH 5/5] mm, slub: fix incorrect memcg slab count for bulk
 free
Content-Language: en-US
To:     Miaohe Lin <linmiaohe@huawei.com>, akpm@linux-foundation.org,
        cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com
Cc:     gregkh@linuxfoundation.org, faiyazm@codeaurora.org,
        andreyknvl@gmail.com, ryabinin.a.a@gmail.com, thgarnie@google.com,
        keescook@chromium.org, bharata@linux.ibm.com, guro@fb.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20210916123920.48704-1-linmiaohe@huawei.com>
 <20210916123920.48704-6-linmiaohe@huawei.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20210916123920.48704-6-linmiaohe@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/16/21 14:39, Miaohe Lin wrote:
> kmem_cache_free_bulk() will call memcg_slab_free_hook() for all objects
> when doing bulk free. So we shouldn't call memcg_slab_free_hook() again
> for bulk free to avoid incorrect memcg slab count.
> 
> Fixes: d1b2cf6cb84a ("mm: memcg/slab: uncharge during kmem_cache_free_bulk()")
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>

Reviewed-by: Vlastimil Babka <vbabka@suse.cz>

I now noticed the series doesn't Cc: stable and it should, so I hope Andrew
can add those together with the review tags. Thanks.

> ---
>  mm/slub.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/slub.c b/mm/slub.c
> index f3df0f04a472..d8f77346376d 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -3420,7 +3420,9 @@ static __always_inline void do_slab_free(struct kmem_cache *s,
>  	struct kmem_cache_cpu *c;
>  	unsigned long tid;
>  
> -	memcg_slab_free_hook(s, &head, 1);
> +	/* memcg_slab_free_hook() is already called for bulk free. */
> +	if (!tail)
> +		memcg_slab_free_hook(s, &head, 1);
>  redo:
>  	/*
>  	 * Determine the currently cpus per cpu slab.
> 

