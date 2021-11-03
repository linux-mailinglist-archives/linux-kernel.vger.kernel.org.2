Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71C95443DAB
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Nov 2021 08:24:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232100AbhKCH0f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Nov 2021 03:26:35 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:33062 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232033AbhKCH0e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Nov 2021 03:26:34 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 94FDD21155;
        Wed,  3 Nov 2021 07:23:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1635924237; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=T4u4MEwe36HTs254JfcIvpHngVEczN5pBxWb8/aUgzo=;
        b=YPpVRsyEkqxcThR7LtuBZQJfChALY51l91eibTBytbvKNqqVjXdTY5x/u7qRirnkX0jVnt
        RyLymBqw8w9dd+XOZP75n4Z9LMzK6M2Peb+XWp/GVYpmdhbjLmoS0cf76ewpNXASyAntEs
        +mmDoUKb6iZUiHWk7G1IWx9A7VCmwNQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1635924237;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=T4u4MEwe36HTs254JfcIvpHngVEczN5pBxWb8/aUgzo=;
        b=Ss3QaDDFlOZ+JmQL9WXQ9vxwz6CT3K1+gYRTjGeViHEMDieRnuGxB0NHne+f5QqMzqIP1V
        FxKcaytCb4vIOhDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6B4F913C7E;
        Wed,  3 Nov 2021 07:23:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id I5R1GQ05gmHFOQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Wed, 03 Nov 2021 07:23:57 +0000
Message-ID: <af8e043c-9095-7a9a-0c0d-fcc11dec7e74@suse.cz>
Date:   Wed, 3 Nov 2021 08:23:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [PATCH] mm/slab_common: use WARN() if cache still has objects on
 destroy
Content-Language: en-US
To:     Marco Elver <elver@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        kasan-dev@googlegroups.com, Ingo Molnar <mingo@redhat.com>
References: <20211102170733.648216-1-elver@google.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20211102170733.648216-1-elver@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/2/21 18:07, Marco Elver wrote:
> Calling kmem_cache_destroy() while the cache still has objects allocated
> is a kernel bug, and will usually result in the entire cache being
> leaked. While the message in kmem_cache_destroy() resembles a warning,
> it is currently not implemented using a real WARN().
> 
> This is problematic for infrastructure testing the kernel, all of which
> rely on the specific format of WARN()s to pick up on bugs.
> 
> Some 13 years ago this used to be a simple WARN_ON() in slub, but
> d629d8195793 ("slub: improve kmem_cache_destroy() error message")
> changed it into an open-coded warning to avoid confusion with a bug in
> slub itself.
> 
> Instead, turn the open-coded warning into a real WARN() with the message
> preserved, so that test systems can actually identify these issues, and
> we get all the other benefits of using a normal WARN(). The warning
> message is extended with "when called from <caller-ip>" to make it even
> clearer where the fault lies.
> 
> For most configurations this is only a cosmetic change, however, note
> that WARN() here will now also respect panic_on_warn.
> 
> Signed-off-by: Marco Elver <elver@google.com>

Makes sense.

Reviewed-by: Vlastimil Babka <vbabka@suse.cz>

> ---
>  mm/slab_common.c | 11 +++--------
>  1 file changed, 3 insertions(+), 8 deletions(-)
> 
> diff --git a/mm/slab_common.c b/mm/slab_common.c
> index ec2bb0beed75..0155a3042203 100644
> --- a/mm/slab_common.c
> +++ b/mm/slab_common.c
> @@ -497,8 +497,6 @@ void slab_kmem_cache_release(struct kmem_cache *s)
>  
>  void kmem_cache_destroy(struct kmem_cache *s)
>  {
> -	int err;
> -
>  	if (unlikely(!s))
>  		return;
>  
> @@ -509,12 +507,9 @@ void kmem_cache_destroy(struct kmem_cache *s)
>  	if (s->refcount)
>  		goto out_unlock;
>  
> -	err = shutdown_cache(s);
> -	if (err) {
> -		pr_err("%s %s: Slab cache still has objects\n",
> -		       __func__, s->name);
> -		dump_stack();
> -	}
> +	WARN(shutdown_cache(s),
> +	     "%s %s: Slab cache still has objects when called from %pS",
> +	     __func__, s->name, (void *)_RET_IP_);
>  out_unlock:
>  	mutex_unlock(&slab_mutex);
>  	cpus_read_unlock();
> 

