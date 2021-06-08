Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80AB639F621
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 14:13:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232256AbhFHMPT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 08:15:19 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:40510 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231330AbhFHMPO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 08:15:14 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 3D3A11FD33;
        Tue,  8 Jun 2021 12:13:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1623154401; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5Y/J8Oxrbxf7pNOjDNnn6LhqTrUOzD1NlEUvEz7T1EU=;
        b=WKp/nPQBucPBdqYMkfXdmyAEV4Arhcf8JqYAVzOIStxlfQG+g1jnipSb5vn+bewNdJv6pn
        8RmKQk7/Z56uHr43nYwV6zU0fKENB7CzDnW3ii1QyugjYlFLzIo3AaqS6EOtFOHaKRNAh2
        CYNVlkcqrAAqkYaDN3p4OyMNVx5lujU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1623154401;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5Y/J8Oxrbxf7pNOjDNnn6LhqTrUOzD1NlEUvEz7T1EU=;
        b=IO5xwWfhc9uWRABkXSIIcIhOP/BND3iIXz9Yt7yH3INYf08+mTI/LY7eGvIMJStptpLbu/
        +Y7cTQDKZD99OkBw==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id 177F7118DD;
        Tue,  8 Jun 2021 12:13:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1623154401; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5Y/J8Oxrbxf7pNOjDNnn6LhqTrUOzD1NlEUvEz7T1EU=;
        b=WKp/nPQBucPBdqYMkfXdmyAEV4Arhcf8JqYAVzOIStxlfQG+g1jnipSb5vn+bewNdJv6pn
        8RmKQk7/Z56uHr43nYwV6zU0fKENB7CzDnW3ii1QyugjYlFLzIo3AaqS6EOtFOHaKRNAh2
        CYNVlkcqrAAqkYaDN3p4OyMNVx5lujU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1623154401;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5Y/J8Oxrbxf7pNOjDNnn6LhqTrUOzD1NlEUvEz7T1EU=;
        b=IO5xwWfhc9uWRABkXSIIcIhOP/BND3iIXz9Yt7yH3INYf08+mTI/LY7eGvIMJStptpLbu/
        +Y7cTQDKZD99OkBw==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id L4AtBeFev2AmPAAALh3uQQ
        (envelope-from <vbabka@suse.cz>); Tue, 08 Jun 2021 12:13:21 +0000
Subject: Re: [RFC 10/26] mm, slub: do initial checks in ___slab_alloc() with
 irqs enabled
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Jann Horn <jannh@google.com>
References: <20210524233946.20352-1-vbabka@suse.cz>
 <20210524233946.20352-11-vbabka@suse.cz>
 <20210525130436.GS30378@techsingularity.net>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <c0a21f92-54ed-4e2f-01c5-d669fbb188bb@suse.cz>
Date:   Tue, 8 Jun 2021 14:13:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210525130436.GS30378@techsingularity.net>
Content-Type: text/plain; charset=iso-8859-15
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/25/21 3:04 PM, Mel Gorman wrote:
> On Tue, May 25, 2021 at 01:39:30AM +0200, Vlastimil Babka wrote:
>> As another step of shortening irq disabled sections in ___slab_alloc(), don't
>> disable irqs until doing initial checks if there is a cached percpu slab and
>> it's suitable for our allocation.
>> 
>> Now we have to recheck c->page after actually disabling irqs as an allocation
>> in irq might have replaced it.
>> 
>> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> 
> Minor nit only -- consider adding a comment at the new_slab label that
> IRQs must be disabled already.

Good point, will use lockdep_assert_irqs_disabled() as that's a functional comment.

> Acked-by: Mel Gorman <mgorman@techsingularity.net>

Thanks.


