Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FF8D391A1A
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 16:26:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234674AbhEZO2W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 10:28:22 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:51644 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233313AbhEZO2V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 10:28:21 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by smtp-out1.suse.de (Postfix) with ESMTP id B4A92218C1;
        Wed, 26 May 2021 14:26:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1622039208; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xlBw810CtHPmcgP8WpT8r3LgMwxxwOgbO4Q73mta+GY=;
        b=b56LQQ6YjOdy9NwVSTnpNM0rdhqf3tK35hqG8gNpc1BntrjjL1Jwu6ZVvoOhig52ozHOV2
        lwZnw3aIM0hwHv2GeT/7KHWOVwk2ZAydBl5ubxOXL8TlL9QNPPc0BaW3nVroA6lljLM6z+
        ebKbimPA6sjyKI8hIm82yZrHwSKRw4c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1622039208;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xlBw810CtHPmcgP8WpT8r3LgMwxxwOgbO4Q73mta+GY=;
        b=mIX+pg9bxDNrLH2xfB5GjnrV1tbIubqOeT2K3bvyXd6Sgt1i1/pqNEpRLahoCS1xgQhKE6
        y/yxz8Yr+NbbSRCQ==
Received: from director2.suse.de (director2.suse-dmz.suse.de [192.168.254.72])
        by imap.suse.de (Postfix) with ESMTPSA id 8F19F11A98;
        Wed, 26 May 2021 14:26:48 +0000 (UTC)
Subject: Re: [RFC 3/3] mm/slub: add all_objects implementation in debugfs
To:     glittao@gmail.com, cl@linux.com, penberg@kernel.org,
        rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        faiyazm@codeaurora.org
References: <20210521121127.24653-1-glittao@gmail.com>
 <20210521121127.24653-3-glittao@gmail.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <48b461c6-0221-5f8c-fb53-08a1f299b048@suse.cz>
Date:   Wed, 26 May 2021 16:26:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210521121127.24653-3-glittao@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/21/21 2:11 PM, glittao@gmail.com wrote:
> From: Oliver Glitta <glittao@gmail.com>
> 
> Add all_objects implementation to debugfs to print information
> about all objects in slub cache.

An example listing of 1-2 objects would be useful in the changelog.

Also can you describe what are the guarantees (or limitations) of observing
really all objects if the cache is modified by concurrent allocation and free
operations?

...

> +static void *debugfs_all_objects_start(struct seq_file *m, loff_t *ppos)
> +{
> +	struct slab_debug_private *priv = m->private;
> +	struct kmem_cache *s = priv->inode->i_private;
> +	struct page *page;
> +
> +	priv->map = kmalloc(BITS_TO_LONGS(MAX_OBJS_PER_PAGE), GFP_KERNEL);

We can use bitmap_alloc/bitmap_free wrappers and allocate according to objects
per page in the actual kmem_cache, not the theoretical maximum, see:
https://lore.kernel.org/linux-mm/20210524233946.20352-2-vbabka@suse.cz/

