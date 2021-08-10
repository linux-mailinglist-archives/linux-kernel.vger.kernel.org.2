Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8B973E247A
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 09:50:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242332AbhHFHu3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 03:50:29 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:35670 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241930AbhHFHuU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 03:50:20 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 12FA81FEB1;
        Fri,  6 Aug 2021 07:50:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1628236204; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6+laCi4KxR5UVLdNnL6puwvywYfdNwxG0t+wvdhSYH8=;
        b=qq2EMQnh29L5obPz8YFw/w1f8NhcK8RC4DwMtK0HU8cUBRohMfnkNeiVcv5rt0cdHaBmP8
        c/U03ADuVgVibyy9YrhilRBvLVw7jaJyTq3hb0vxY/dsT086RpXqHXfk/l2Qx6iMuspEGo
        C/pyta0kFCzohOfDumCANsYItxZZOuE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1628236204;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6+laCi4KxR5UVLdNnL6puwvywYfdNwxG0t+wvdhSYH8=;
        b=BJmvFa6xukjL3UBb1FBe2vxD0SyqyqGCPtB4dNBZu6K3we9h1ZTZTHiUhmUO6tQ8w1N/tT
        w7e737fKM3XzR5AQ==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id E85C213990;
        Fri,  6 Aug 2021 07:50:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id N88gOKvpDGEcGgAAGKfGzw
        (envelope-from <vbabka@suse.cz>); Fri, 06 Aug 2021 07:50:03 +0000
Subject: Re: [PATCH 1/1] mm/vmstat: Protect per cpu variables with preempt
 disable on RT
To:     Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Hugh Dickins <hughd@google.com>, Linux-MM <linux-mm@kvack.org>,
        Linux-RT-Users <linux-rt-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20210805160019.1137-1-mgorman@techsingularity.net>
 <20210805160019.1137-2-mgorman@techsingularity.net>
 <20210805162206.664dfc8c090f2be5ea313d57@linux-foundation.org>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <df1f16f9-1a29-5525-4673-f437fb03dc92@suse.cz>
Date:   Fri, 6 Aug 2021 09:50:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210805162206.664dfc8c090f2be5ea313d57@linux-foundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/6/21 1:22 AM, Andrew Morton wrote:
> On Thu,  5 Aug 2021 17:00:19 +0100 Mel Gorman <mgorman@techsingularity.net> wrote:
> 
>> From: Ingo Molnar <mingo@elte.hu>
>> 
>> Disable preemption on -RT for the vmstat code. On vanila the code runs
>> in IRQ-off regions while on -RT it may not when stats are updated under
>> a local_lock. "preempt_disable" ensures that the same resources is not
>> updated in parallel due to preemption.
>> 
>> This patch differs from the preempt-rt version where __count_vm_event and
>> __count_vm_events are also protected. The counters are explicitly "allowed
>> to be to be racy" so there is no need to protect them from preemption. Only
>> the accurate page stats that are updated by a read-modify-write need
>> protection. This patch also differs in that a preempt_[en|dis]able_rt
>> helper is not used. As vmstat is the only user of the helper, it was
>> suggested that it be open-coded in vmstat.c instead of risking the helper
>> being used in unnecessary contexts.
>> 
>> ...
>>
>> --- a/mm/vmstat.c
>> +++ b/mm/vmstat.c
>> @@ -319,6 +319,16 @@ void __mod_zone_page_state(struct zone *zone, enum zone_stat_item item,
>>  	long x;
>>  	long t;
>>  
>> +	/*
>> +	 * Accurate vmstat updates require a RMW. On !PREEMPT_RT kernels,
>> +	 * atomicity is provided by IRQs being disabled -- either explicitly
>> +	 * or via local_lock_irq. On PREEMPT_RT, local_lock_irq only disables
>> +	 * CPU migrations and preemption potentially corrupts a counter so
>> +	 * disable preemption.
>> +	 */
>> +	if (IS_ENABLED(CONFIG_PREEMPT_RT))
>> +		preempt_disable();
> 
> This is so obvious I expect it has been discussed, but...  why not
> 
> static inline void preempt_disable_if_rt(void)
> {
> 	if (IS_ENABLED(CONFIG_PREEMPT_RT))
> 		preempt_disable();
> }

Yeah v1 introduced similar more generic ones in include/linux/preempt.h and
Thomas didn't like that. I guess it would be more acceptable when confined to
mm/vmstat.c
