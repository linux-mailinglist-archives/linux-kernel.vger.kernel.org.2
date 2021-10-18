Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19C7E43134A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 11:23:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231599AbhJRJZg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 05:25:36 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:59826 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231533AbhJRJY7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 05:24:59 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id E82921FD6E;
        Mon, 18 Oct 2021 09:22:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1634548966; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8Fcnlx2WieTP93iZwOM0gAJT8K7I1qMUMTJBSVqOvvk=;
        b=NfZzymmIfekjz8mE2Ol4wuMwyeQnK6bK3DPLmHt4xJ1/8BsJLCiX95MSNobrs4ymzwE9ia
        actWg1VCK5bJ46yjdYCOVO876If+xCDObtMOayjAt+W/dXoMTlSnR4YuO+YEgcGhtRERA9
        Tm1Zysjtwayv9hjRyjkxG8ia0OYt4uM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1634548966;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8Fcnlx2WieTP93iZwOM0gAJT8K7I1qMUMTJBSVqOvvk=;
        b=dYl0Kes9sfmVtSwI20o18h+rhzeX/aZ2WBPhGjfAdJ6IXke5qoxyCOTWSS/OK9WCNzMpwt
        fvyE6y8OpoPlTkBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A2B7B13D0C;
        Mon, 18 Oct 2021 09:22:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id NijWJuY8bWF2SgAAMHmgww
        (envelope-from <vbabka@suse.cz>); Mon, 18 Oct 2021 09:22:46 +0000
Message-ID: <20758764-8139-ab0b-a782-dc63559b43ba@suse.cz>
Date:   Mon, 18 Oct 2021 11:22:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Content-Language: en-US
To:     Rustam Kovhaev <rkovhaev@gmail.com>, cl@linux.com,
        penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org
Cc:     djwong@kernel.org, david@fromorbit.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        gregkh@linuxfoundation.org, viro@zeniv.linux.org.uk,
        dvyukov@google.com
References: <20211015005729.GD24333@magnolia>
 <20211018033841.3027515-1-rkovhaev@gmail.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH] slob: add size header to all allocations
In-Reply-To: <20211018033841.3027515-1-rkovhaev@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/18/21 05:38, Rustam Kovhaev wrote:
> Let's prepend all  allocations of (PAGE_SIZE - align_offset) and less
> with the size header. This way kmem_cache_alloc() memory can be freed
> with kfree() and the other way around, as long as they are less than
> (PAGE_SIZE - align_offset).

This size limitation seems like an unnecessary gotcha. Couldn't we make
these large allocations in slob_alloc_node() (that use slob_new_pages()
directly) similar enough to large kmalloc() ones, so that kfree() can
recognize them and free properly? AFAICS it might mean just adding
__GFP_COMP to make sure there's a compound order stored, as these already
don't seem to set PageSlab.

> The main reason for this change is to simplify SLOB a little bit, make
> it a bit easier to debug whenever something goes wrong.

I would say the main reason is to simplify the slab API and guarantee that
both kmem_cache_alloc() and kmalloc() can be freed by kfree().

We should also update the comments at top of slob.c to reflect the change.
And Documentation/core-api/memory-allocation.rst (the last paragraph).

> meminfo right after the system boot, without the patch:
> Slab:              35500 kB
> 
> the same, with the patch:
> Slab:              36396 kB

2.5% increase, hopefully acceptable.

Thanks!
