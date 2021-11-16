Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C3CB45306F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 12:27:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234983AbhKPL3s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 06:29:48 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:49714 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235004AbhKPL3P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 06:29:15 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 8EADD212B7;
        Tue, 16 Nov 2021 11:26:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1637061977; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5+gUcs/tjKbbk/7yjyhx4CtVWFpBne6sQR2PGyQ6344=;
        b=ML6kzvf86bM4nnzWKFtNChdojDg87P2IrQwJmzvErHw1YCxQyy1sWz1UOQc4HC82R3OD5e
        Y+NB9wEzQBFUNOZMjoxFNPH5cdNt+LOhsNzGjcH+CZSrbNgs2+ka8GqfMgb6D9XpsLiTXW
        7qXbuQhrROM9fivT6OxNZc73SJdaEW0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1637061977;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5+gUcs/tjKbbk/7yjyhx4CtVWFpBne6sQR2PGyQ6344=;
        b=bq5Owu98dWYzz0faNGWzKmuJajz1+tkAdQOg4tXKeWJeakdNKIV0+MZWkxmVPrDSBtBoxW
        DdcgfvYNOLswnpCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5648813C01;
        Tue, 16 Nov 2021 11:26:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id nkATFFmVk2F1QwAAMHmgww
        (envelope-from <vbabka@suse.cz>); Tue, 16 Nov 2021 11:26:17 +0000
Message-ID: <037227db-c869-7d9c-65e8-8f5f8682171d@suse.cz>
Date:   Tue, 16 Nov 2021 12:26:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH v3] slob: add size header to all allocations
Content-Language: en-US
To:     Rustam Kovhaev <rkovhaev@gmail.com>, cl@linux.com,
        penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, corbet@lwn.net
Cc:     djwong@kernel.org, david@fromorbit.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, gregkh@linuxfoundation.org,
        viro@zeniv.linux.org.uk, dvyukov@google.com
References: <be7ee3a6-9b3c-b436-f042-82bd3c416acc@suse.cz>
 <20211029030534.3847165-1-rkovhaev@gmail.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20211029030534.3847165-1-rkovhaev@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/29/21 05:05, Rustam Kovhaev wrote:
> Let's prepend both kmalloc() and kmem_cache_alloc() allocations with the
> size header.
> It simplifies the slab API and guarantees that both kmem_cache_alloc()
> and kmalloc() memory could be freed by kfree().
> 
> meminfo right after the system boot, x86-64 on xfs, without the patch:
> Slab:              35456 kB
> 
> the same, with the patch:
> Slab:              36100 kB
> 
> Link: https://lore.kernel.org/lkml/20210929212347.1139666-1-rkovhaev@gmail.com
> Signed-off-by: Rustam Kovhaev <rkovhaev@gmail.com>

Sorry for the late reply. I think we can further simplify this. We have:

static void *slob_alloc(size_t size, gfp_t gfp, int align,
			int node, int align_offset)

Previously there was one caller that passed size as unchanged, align_offset
= 0, the other passed size + SLOB_HDR_SIZE, align_offset = SLOB_HDR_SIZE.
Now both callers do the latter. We can drop the align_offset parameter and
pass size unchanged. slob_alloc() can internally add SLOB_HDR_SIZE to size,
and use SLOB_HDR_SIZE instead of align_offset.

Thanks,
Vlastimil

