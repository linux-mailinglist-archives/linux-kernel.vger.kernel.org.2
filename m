Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 393353FCB90
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 18:38:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240000AbhHaQi6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 12:38:58 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:41480 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230047AbhHaQiz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 12:38:55 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 54BE6222DC;
        Tue, 31 Aug 2021 16:37:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1630427878; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=elr0DzDewaztAa9Pi9knUWjSATe4WGI8ZR1bF2BTblI=;
        b=ca1HQCk+kvAlRTDp6miDRJQg1r+7t8eGBkgAnfEYyc5SPBFT3IvMRVMBh2WhyRlO3jjm3g
        Cl9ukvXRDIopHBQOpSC9W3UoMkbszANLBvlqmX3XzptiXhzPDseZb1/QNqR4Gcd9u4IHey
        YarP7ik60uJnN3Au4NDVogLiBGH1p8U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1630427878;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=elr0DzDewaztAa9Pi9knUWjSATe4WGI8ZR1bF2BTblI=;
        b=4Aqx6NY7rW7aNkS0/7rs2Pk5/VDEkOW0xsKFkHwQex+OowAa1m17C4HSbv/TJ9N6PV402O
        xVB8DhRmdVPupSDg==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 2F60113A9A;
        Tue, 31 Aug 2021 16:37:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id 4BW/CuZaLmGzWgAAGKfGzw
        (envelope-from <vbabka@suse.cz>); Tue, 31 Aug 2021 16:37:58 +0000
Message-ID: <cde527a6-36cf-8a01-16b9-41e950676e48@suse.cz>
Date:   Tue, 31 Aug 2021 18:37:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.0.3
Subject: Re: [PATCH 6/6] mm/page_alloc.c: avoid allocating highmem pages via
 alloc_pages_exact_nid()
Content-Language: en-US
To:     Miaohe Lin <linmiaohe@huawei.com>,
        Matthew Wilcox <willy@infradead.org>
Cc:     akpm@linux-foundation.org, sfr@canb.auug.org.au,
        peterz@infradead.org, mgorman@techsingularity.net,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20210830141051.64090-1-linmiaohe@huawei.com>
 <20210830141051.64090-7-linmiaohe@huawei.com>
 <YSzqDt/13YbOAyo4@casper.infradead.org>
 <d90329db-b13a-ac28-c381-758f12c679c2@huawei.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <d90329db-b13a-ac28-c381-758f12c679c2@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/31/21 03:56, Miaohe Lin wrote:
> On 2021/8/30 22:24, Matthew Wilcox wrote:
>> On Mon, Aug 30, 2021 at 10:10:51PM +0800, Miaohe Lin wrote:
>>> Don't use with __GFP_HIGHMEM because page_address() cannot represent
>>> highmem pages without kmap(). Newly allocated pages would leak as
>>> page_address() will return NULL for highmem pages here. But It works
>>> now because the only caller does not specify __GFP_HIGHMEM now.
>> 
>> This is a misunderstanding of how alloc_pages_exact() /
>> alloc_pages_exact_nid() work.  You simply can't call them with
>> GFP_HIGHMEM.
>> 
> 
> Yep, they can't work with GFP_HIGHMEM. So IMO it might be better to
> get rid of GFP_HIGHMEM explicitly or add a comment to clarify this
> situation to avoid future misbehavior. But this may be a unnecessary
> worry... Do you prefer to not change anything here?

I agree with the suggestion below...

> Many thanks.
> 
>> If you really must change anything here,
>> s/__GFP_COMP/(__GFP_COMP|__GFP_HIGHMEM)/g throughout both
>> alloc_pages_exact() and alloc_pages_exact_nid().

... which means __GFP_HIGHMEM would be stripped and additionally there would
be a warning.

