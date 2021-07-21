Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A03B3D1950
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 23:40:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbhGUU7Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 16:59:24 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:49096 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229843AbhGUU7X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 16:59:23 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id AE6E81FD4E;
        Wed, 21 Jul 2021 21:29:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1626902974; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5k8V4ifsY920jgT9NekG/0BKiHClg3FqLTv6cJLLmjc=;
        b=xXOrvC4CQQ6B0IF8LbWRucIwAOcrClWcIS8VKG13S2sfJ1WFT/e7LqTq1+IbZLxVoePXqx
        KFlKmo7Lg0es1qKczcg7Krm2nZ/UBZ0DIDc3Y5YOcnKx4HQ04/YyKhvSFqNAQS+uVGRwx/
        IRiKjfW7faN/+svWe87lm21cCcumhGI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1626902974;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5k8V4ifsY920jgT9NekG/0BKiHClg3FqLTv6cJLLmjc=;
        b=K0OwC4V1wKaOPX0SkSokjiupG48TU2okjqYW4UGMWYL6BecqTBtSRJGA95b52rM/AYvjjT
        qMMo5sWwCXxToIDg==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 802F613C12;
        Wed, 21 Jul 2021 21:29:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id BTbAHb6R+GCeBwAAGKfGzw
        (envelope-from <vbabka@suse.cz>); Wed, 21 Jul 2021 21:29:34 +0000
Subject: Re: [PATCH resend] mm: compaction: optimize proactive compaction
 deferrals
To:     Andrew Morton <akpm@linux-foundation.org>,
        Charan Teja Reddy <charante@codeaurora.org>
Cc:     rientjes@google.com, nigupta@nvidia.com, khalid.aziz@oracle.com,
        vinmenon@codeaurora.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <1626869599-25412-1-git-send-email-charante@codeaurora.org>
 <20210721131806.5898dab3e329940fd8bd2db6@linux-foundation.org>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <a693d1b0-e249-cca5-c910-5fbfd8f1a11c@suse.cz>
Date:   Wed, 21 Jul 2021 23:29:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210721131806.5898dab3e329940fd8bd2db6@linux-foundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/21/21 10:18 PM, Andrew Morton wrote:
> On Wed, 21 Jul 2021 17:43:19 +0530 Charan Teja Reddy <charante@codeaurora.org> wrote:
> 
>> Vlastimil Babka figured out that when fragmentation score didn't go down
>> across the proactive compaction i.e. when no progress is made, next wake
>> up for proactive compaction is deferred for 1 <<
>> COMPACT_MAX_DEFER_SHIFT, i.e. 64 times, with each wakeup interval of
>> HPAGE_FRAG_CHECK_INTERVAL_MSEC(=500). In each of this wakeup, it just
>> decrement 'proactive_defer' counter and goes sleep i.e. it is getting
>> woken to just decrement a counter. The same deferral time can also
>> achieved by simply doing the HPAGE_FRAG_CHECK_INTERVAL_MSEC <<
>> COMPACT_MAX_DEFER_SHIFT thus unnecessary wakeup of kcompact thread is
>> avoided thus also removes the need of 'proactive_defer' thread counter.

Acked-by: Vlastimil Babka <vbabka@suse.cz>

>>
>> @@ -2902,23 +2903,30 @@ static int kcompactd(void *p)
>>  
>>  		trace_mm_compaction_kcompactd_sleep(pgdat->node_id);
>>  		if (wait_event_freezable_timeout(pgdat->kcompactd_wait,
>> -			kcompactd_work_requested(pgdat),
>> -			msecs_to_jiffies(HPAGE_FRAG_CHECK_INTERVAL_MSEC))) {
>> +			kcompactd_work_requested(pgdat), timeout)) {
>>  
>>  			psi_memstall_enter(&pflags);
>>  			kcompactd_do_work(pgdat);
>>  			psi_memstall_leave(&pflags);
>> +			/*
>> +			 * Reset the timeout value. The defer timeout by
>> +			 * proactive compaction can effectively lost
>> +			 * here but that is fine as the condition of the
>> +			 * zone changed substantionally and carrying on
>> +			 * with the previous defer is not useful.
>> +			 */
>> +			timeout = default_timeout;
>>  			continue;
> 
> I find this comment hard to follow.  Is this better?

Yes, thanks.

> --- a/mm/compaction.c~mm-compaction-optimize-proactive-compaction-deferrals-fix
> +++ a/mm/compaction.c
> @@ -2909,11 +2909,11 @@ static int kcompactd(void *p)
>  			kcompactd_do_work(pgdat);
>  			psi_memstall_leave(&pflags);
>  			/*
> -			 * Reset the timeout value. The defer timeout by
> -			 * proactive compaction can effectively lost
> -			 * here but that is fine as the condition of the
> -			 * zone changed substantionally and carrying on
> -			 * with the previous defer is not useful.
> +			 * Reset the timeout value. The defer timeout from
> +			 * proactive compaction is lost here but that is fine
> +			 * as the condition of the zone changing substantionally
> +			 * then carrying on with the previous defer interval is
> +			 * not useful.
>  			 */
>  			timeout = default_timeout;
>  			continue;
> _
> 

