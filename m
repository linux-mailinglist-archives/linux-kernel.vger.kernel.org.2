Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 230C939F407
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 12:48:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231840AbhFHKus (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 06:50:48 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:43372 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231814AbhFHKuq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 06:50:46 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id E75D5219AA;
        Tue,  8 Jun 2021 10:48:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1623149332; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tZsEvbC1p0tXnhDc/Am2zDqhVkzjQSH0hjGod4w1KOE=;
        b=zLyORY0JbULE9aCi4tyMq+wcEtJX/NcHAWSHLgRsjTi72FphC6XeniKZbu0rpI/S60Ry4o
        Zo5L8vU7bYmlk6u8Bd3KT1G0xlTryJOTqhRg03Eom21DQ/wiRxK5LmHe00XOnDRImLK+2a
        ts3HnHqzOqwUvVq1otMxhMJT5uQmAT8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1623149332;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tZsEvbC1p0tXnhDc/Am2zDqhVkzjQSH0hjGod4w1KOE=;
        b=daeq+qApEUqx7LyDv6hWzIzCfd9+cdvCGZxciY4QBLDfTClf+/H5ajpbPpxxN4dDeOusUg
        tArBFxWocwKQwRDQ==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id BEE6E118DD;
        Tue,  8 Jun 2021 10:48:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1623149332; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tZsEvbC1p0tXnhDc/Am2zDqhVkzjQSH0hjGod4w1KOE=;
        b=zLyORY0JbULE9aCi4tyMq+wcEtJX/NcHAWSHLgRsjTi72FphC6XeniKZbu0rpI/S60Ry4o
        Zo5L8vU7bYmlk6u8Bd3KT1G0xlTryJOTqhRg03Eom21DQ/wiRxK5LmHe00XOnDRImLK+2a
        ts3HnHqzOqwUvVq1otMxhMJT5uQmAT8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1623149332;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tZsEvbC1p0tXnhDc/Am2zDqhVkzjQSH0hjGod4w1KOE=;
        b=daeq+qApEUqx7LyDv6hWzIzCfd9+cdvCGZxciY4QBLDfTClf+/H5ajpbPpxxN4dDeOusUg
        tArBFxWocwKQwRDQ==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id qba1LRRLv2BCDQAALh3uQQ
        (envelope-from <vbabka@suse.cz>); Tue, 08 Jun 2021 10:48:52 +0000
Subject: Re: [RFC 07/26] mm, slub: return slab page from get_partial() and set
 c->page afterwards
To:     Christoph Lameter <cl@gentwo.de>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        David Rientjes <rientjes@google.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mel Gorman <mgorman@techsingularity.net>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Jann Horn <jannh@google.com>
References: <20210524233946.20352-1-vbabka@suse.cz>
 <20210524233946.20352-8-vbabka@suse.cz>
 <alpine.DEB.2.22.394.2105251110550.107680@gentwo.de>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <a1505470-e941-b1cc-05a9-4d4795a7cca4@suse.cz>
Date:   Tue, 8 Jun 2021 12:48:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.22.394.2105251110550.107680@gentwo.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/25/21 11:12 AM, Christoph Lameter wrote:
> On Tue, 25 May 2021, Vlastimil Babka wrote:
> 
>> The function get_partial() finds a suitable page on a partial list, acquires
>> and returns its freelist and assigns the page pointer to kmem_cache_node.
> 	in kmem_cache_cpu ??
> 
>> In later patch we will need more control over the kmem_cache_node assignment,
> 
> kmem_cache_cpu?
> 
>> so instead return the page pointer to get_partial()'s caller and assign it
>> there. No functional change as all of this still happens with disabled irq.
> 
> Instead of passing a kmem_cache_cpu pointer pass a pointer to a pointer to
> a page ....

You're right, confused the two structures here. Fixed, thanks.
