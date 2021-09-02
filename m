Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 262B03FEA43
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 09:54:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243869AbhIBHyv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 03:54:51 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:60084 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243180AbhIBHys (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 03:54:48 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 816F822473;
        Thu,  2 Sep 2021 07:53:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1630569229; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7xvu8P4rCUE+QdeioS9zYqea657adsGu4aiuscbEHhA=;
        b=IRZvobgjzVw6AarWxep/eqwiKcJEyTXxc1dn93G6A5YLaxx62CBuVqt5aD+Ra7BmTpsmgx
        p7H2gJZB88EBWP+h+rnR9ahRaCH/cJppapa4VBqm0dw9MurdOZ0GvzPJQJshDpbLRu9nUB
        adP2KHbtYYKyGavlx4gRGkEJEVva9lk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1630569229;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7xvu8P4rCUE+QdeioS9zYqea657adsGu4aiuscbEHhA=;
        b=kDaxr228qJM3i8FMa9Gf7sXtF3aEX8NCx1v1s8f+2rgFyiGPCL32dRJwWP/BndbMk83qm6
        73dLqv5lHEMf2tCA==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 5199C1389C;
        Thu,  2 Sep 2021 07:53:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id OrOFEg2DMGFlQAAAGKfGzw
        (envelope-from <vbabka@suse.cz>); Thu, 02 Sep 2021 07:53:49 +0000
Message-ID: <fe94ffd8-d235-87d8-9c3d-80f7f73e0c4e@suse.cz>
Date:   Thu, 2 Sep 2021 09:53:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.0.3
Subject: Re: [RFC PATCH v2 1/2] lib, stackdepot: check stackdepot handle
 before accessing slabs.
Content-Language: en-US
To:     Imran Khan <imran.f.khan@oracle.com>, geert@linux-m68k.org,
        akpm@linux-foundation.org, ryabinin.a.a@gmail.com,
        glider@google.com, andreyknvl@gmail.com, dvyukov@google.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20210902000154.1096484-1-imran.f.khan@oracle.com>
 <20210902000154.1096484-2-imran.f.khan@oracle.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20210902000154.1096484-2-imran.f.khan@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/2/21 02:01, Imran Khan wrote:
> stack_depot_save allocates slabs that will be used for storing
> objects in future.If this slab allocation fails we may get to
> a situation where space allocation for a new stack_record fails,
> causing stack_depot_save to return 0 as handle.
> If user of this handle ends up invoking stack_depot_fetch with
> this handle value, current implementation of stack_depot_fetch
> will end up using slab from wrong index.
> To avoid this check handle value at the beginning.
> 
> Signed-off-by: Imran Khan <imran.f.khan@oracle.com>
> Suggested-by: Vlastimil Babka <vbabka@suse.cz>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

> ---
>  lib/stackdepot.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/lib/stackdepot.c b/lib/stackdepot.c
> index 0a2e417f83cb..67439c082490 100644
> --- a/lib/stackdepot.c
> +++ b/lib/stackdepot.c
> @@ -232,6 +232,9 @@ unsigned int stack_depot_fetch(depot_stack_handle_t handle,
>  	struct stack_record *stack;
>  
>  	*entries = NULL;
> +	if (!handle)
> +		return 0;
> +
>  	if (parts.slabindex > depot_index) {
>  		WARN(1, "slab index %d out of bounds (%d) for stack id %08x\n",
>  			parts.slabindex, depot_index, handle);
> 

