Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E66DB3FCB8A
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 18:34:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234087AbhHaQfY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 12:35:24 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:50340 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230047AbhHaQfX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 12:35:23 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id ED87B1FD42;
        Tue, 31 Aug 2021 16:34:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1630427666; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GjqKV1lIX47H7mXGUlYoktIsr/dzoLju9poW6E8M+Ac=;
        b=kxAjlfpNufa5YPyitpH3IXO3sndD7xdW0p0QyiEn+QEsjVrh6ESwiU9TXny6cxh8ZltrpT
        DqVaA8MX7uo/h5bwU8uOxOfdUvkwgTzl8PoIsj5bDUz/oOmJIVcg0J2HUiIu136kLy2bGF
        TNnlVhg/T7zbnyTHOJ8js4UWptl+Spk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1630427666;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GjqKV1lIX47H7mXGUlYoktIsr/dzoLju9poW6E8M+Ac=;
        b=bwaUH3IeXzEdTdZnTKN3IZXAoP2uPLWUVskyxPxeEhcY+FiWNF56+oixnrADxoVhhSKzbx
        G4fOsWvLCJ5jCFDQ==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id CF2EC13A9A;
        Tue, 31 Aug 2021 16:34:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id J83SMRJaLmHnWQAAGKfGzw
        (envelope-from <vbabka@suse.cz>); Tue, 31 Aug 2021 16:34:26 +0000
Message-ID: <00a73cf9-b2e8-116b-dc9c-fc5e2aacb1a1@suse.cz>
Date:   Tue, 31 Aug 2021 18:34:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.0.3
Subject: Re: [PATCH 5/6] mm/page_alloc.c: avoid accessing uninitialized pcp
 page migratetype
Content-Language: en-US
To:     Mel Gorman <mgorman@techsingularity.net>,
        Miaohe Lin <linmiaohe@huawei.com>
Cc:     akpm@linux-foundation.org, sfr@canb.auug.org.au,
        peterz@infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20210830141051.64090-1-linmiaohe@huawei.com>
 <20210830141051.64090-6-linmiaohe@huawei.com>
 <20210831134311.GG4128@techsingularity.net>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20210831134311.GG4128@techsingularity.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/31/21 15:43, Mel Gorman wrote:
> On Mon, Aug 30, 2021 at 10:10:50PM +0800, Miaohe Lin wrote:
>> If it's not prepared to free unref page, the pcp page migratetype is
>> unset. Thus We will get rubbish from get_pcppage_migratetype() and
>> might list_del &page->lru again after it's already deleted from the
>> list leading to grumble about data corruption.
>> 
>> Fixes: 3dcbe270d8ec ("mm/page_alloc: avoid conflating IRQs disabled with zone->lock")
>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> 
> Acked-by: Mel Gorman <mgorman@techsingularity.net>
> 
> This fix is fairly important. Take this patch out and send it on its own
> so it gets picked up relatively quickly. It does not belong in a series
> that is mostly cosmetic cleanups.

Also Cc: stable, please.



