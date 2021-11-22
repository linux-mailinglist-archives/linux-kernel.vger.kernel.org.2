Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAEF3458BB2
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Nov 2021 10:40:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231734AbhKVJnQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Nov 2021 04:43:16 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:39094 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238829AbhKVJnO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Nov 2021 04:43:14 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id B1298212BA;
        Mon, 22 Nov 2021 09:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1637574007; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WwT6Zgy5Ma/gGcy/gPme7/lCbOC1WvnP8Sx49LFqUeM=;
        b=14A6YcwFR0oNG9MYF3W6pKfanVHUbsm+ovvVn0JFgw/5Rcwuncj3v0znVMaP9OqlSPM+Un
        rR7mb29yRKPMHjuCG4C7dizlyAH1A31taatVL9TbsLWKk6CdwZKA+kGTy9LEQNicWjq4TD
        OPCIIx/XU3LqeJ0IrUss8CoUu/YG0l8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1637574007;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WwT6Zgy5Ma/gGcy/gPme7/lCbOC1WvnP8Sx49LFqUeM=;
        b=Kv/9M0niYUx/raFGEN++2Bdv9vMyDVJTsFFiSira2SOWZSSGwGPBcBFUgs5Y1k1EW3rmd3
        KFpwI5DX68chWKBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7353D13C23;
        Mon, 22 Nov 2021 09:40:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id m46GG3dlm2FaWwAAMHmgww
        (envelope-from <vbabka@suse.cz>); Mon, 22 Nov 2021 09:40:07 +0000
Message-ID: <3c996e22-034f-1013-3978-1f786aae38fb@suse.cz>
Date:   Mon, 22 Nov 2021 10:40:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Content-Language: en-US
To:     Christoph Lameter <cl@gentwo.org>,
        Rustam Kovhaev <rkovhaev@gmail.com>
Cc:     penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, corbet@lwn.net, djwong@kernel.org,
        david@fromorbit.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-doc@vger.kernel.org,
        gregkh@linuxfoundation.org, viro@zeniv.linux.org.uk,
        dvyukov@google.com
References: <037227db-c869-7d9c-65e8-8f5f8682171d@suse.cz>
 <20211122013026.909933-1-rkovhaev@gmail.com>
 <alpine.DEB.2.22.394.2111221018070.202803@gentwo.de>
From:   Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH v4] slob: add size header to all allocations
In-Reply-To: <alpine.DEB.2.22.394.2111221018070.202803@gentwo.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/22/21 10:22, Christoph Lameter wrote:
> On Sun, 21 Nov 2021, Rustam Kovhaev wrote:
> 
>> Let's prepend both kmalloc() and kmem_cache_alloc() allocations with the
>> size header.
>> It simplifies the slab API and guarantees that both kmem_cache_alloc()
>> and kmalloc() memory could be freed by kfree().
>>
>> meminfo right after the system boot, x86-64 on xfs, without the patch:
>> Slab:              34700 kB
>>
>> the same, with the patch:
>> Slab:              35752 kB
> 
>> +#define SLOB_HDR_SIZE max(ARCH_KMALLOC_MINALIGN, ARCH_SLAB_MINALIGN)
> 
> Ok that is up to 128 bytes on some architectues. Mostly 32 or 64 bytes.
> 
>> @@ -307,6 +303,7 @@ static void *slob_alloc(size_t size, gfp_t gfp, int align, int node,
>>  	unsigned long flags;
>>  	bool _unused;
>>
>> +	size += SLOB_HDR_SIZE;
> 
> And every object now has this overhead? 128 bytes extra in extreme cases
> per object?
> 
> 
>> -	if (size < PAGE_SIZE - minalign) {
>> -		int align = minalign;
>> +	if (size < PAGE_SIZE - SLOB_HDR_SIZE) {
>> +		int align = SLOB_HDR_SIZE;
> 
> And the object is also aligned to 128 bytes boundaries on some
> architectures.
> 
> So a 4 byte object occupies 256 bytes in SLOB?
> 
> SLOB will no longer be a low memory overhead allocator then.

Hm good point, didn't realize those MINALIGN constants can be that large. I
think this overhead was already the case with SLOB for kmalloc caches, but
now it would be worse, as it would be for all kmem caches.

But it seems there's no reason we couldn't do better? I.e. use the value of
SLOB_HDR_SIZE only to align the beginning of actual object (and name the
define different than SLOB_HDR_SIZE). But the size of the header, where we
store the object lenght could be just a native word - 4 bytes on 32bit, 8 on
64bit. The address of the header shouldn't have a reason to be also aligned
to ARCH_KMALLOC_MINALIGN / ARCH_SLAB_MINALIGN as only SLOB itself processes
it and not the slab consumers which rely on those alignments?
