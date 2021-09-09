Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBE0240583D
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 15:56:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237365AbhIINs6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 09:48:58 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:60252 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352916AbhIINq4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 09:46:56 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 014CD1FDF7;
        Thu,  9 Sep 2021 13:45:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1631195146; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=T+jnSJSB7cw5py1CmeNp0InXf6+WsFW/uFZAHFNDTP4=;
        b=fP0dLsJuGDNcEzP4drqsw8c9o4Rgp5/IqI8QFX3MGWT22HOagKmpsbvSpIavYWq+7shi4X
        1syGniU58QGJwAfdlZSP218/irNPuOF42N+sWwiPUixBuMFEUhaphCx50AtdXNmvWKiTKw
        mhZRjzw1QGIwnxHF9VOPRInP5jRYwmY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1631195146;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=T+jnSJSB7cw5py1CmeNp0InXf6+WsFW/uFZAHFNDTP4=;
        b=sQ0Ap6N2+Vs9qZ5VNnMkX8/V5U5Ke8L42CMj79snG6r77QVubVWn7hmXrfYm3cqRLtqnKH
        TYGFLVjrLD+aAXBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DAE9813B36;
        Thu,  9 Sep 2021 13:45:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id tkWDNAkQOmFCIQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Thu, 09 Sep 2021 13:45:45 +0000
Message-ID: <71f855ac-ff61-1eed-454f-909c0e4210b2@suse.cz>
Date:   Thu, 9 Sep 2021 15:45:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.0.3
Content-Language: en-US
To:     Michal Hocko <mhocko@suse.com>,
        Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Hillf Danton <hdanton@sina.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20210816162749.22b921a61156a091f3e1d14d@linux-foundation.org>
 <b4401912-b59a-2150-feef-468c2d25ba3e@oracle.com>
 <20210816184611.07b97f4c26b83090f5d48fab@linux-foundation.org>
 <10d86c18-f0cf-395f-4209-17ac71b9fc03@oracle.com>
 <efcf6049-6110-d516-b21f-41bb8775f042@suse.cz>
 <2d826470-d345-0196-1359-b79ed08dfc66@oracle.com>
 <b3b334ea-0e6f-ced9-e444-df4ec49455a0@suse.cz>
 <02a1a50f-4e7c-4eb7-519c-35b26ec2c6af@oracle.com>
 <20210907085001.3773-1-hdanton@sina.com>
 <6c42bed7-d4dd-e5eb-5a74-24cf64bf52d3@oracle.com>
 <YTn196em42sDsXs+@dhcp22.suse.cz>
From:   Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH RESEND 0/8] hugetlb: add demote/split page functionality
In-Reply-To: <YTn196em42sDsXs+@dhcp22.suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/9/21 13:54, Michal Hocko wrote:
> On Wed 08-09-21 14:00:19, Mike Kravetz wrote:
>> On 9/7/21 1:50 AM, Hillf Danton wrote:
>> > On Mon, 6 Sep 2021 16:40:28 +0200 Vlastimil Babka wrote:
>> > 
>> > And/or clamp reclaim retries for costly orders
>> > 
>> > 	reclaim retries = MAX_RECLAIM_RETRIES - order;
>> > 
>> > to pull down the chance for stall as low as possible.
>> 
>> Thanks, and sorry for not replying quickly.  I only get back to this as
>> time allows.
>> 
>> We could clamp the number of compaction and reclaim retries in
>> __alloc_pages_slowpath as suggested.  However, I noticed that a single
>> reclaim call could take a bunch of time.  As a result, I instrumented
>> shrink_node to see what might be happening.  Here is some information
>> from a long stall.  Note that I only dump stats when jiffies > 100000.
>> 
>> [ 8136.874706] shrink_node: 507654 total jiffies,  3557110 tries
>> [ 8136.881130]              130596341 reclaimed, 32 nr_to_reclaim
>> [ 8136.887643]              compaction_suitable results:
>> [ 8136.893276]     idx COMPACT_SKIPPED, 3557109
> 
> Can you get a more detailed break down of where the time is spent. Also
> How come the number of reclaimed pages is so excessive comparing to the
> reclaim target? There is something fishy going on here.

I would say it's simply should_continue_reclaim() behaving similarly to
should_compact_retry(). We'll get compaction_suitable() returning
COMPACT_SKIPPED because the reclaimed pages have been immediately stolen,
and compaction indicates there's not enough base pages to begin with to form
a high-order pages. Since the stolen pages will appear on inactive lru, it
seems to be worth continuing reclaim to make enough free base pages for
compaction to no longer be skipped, because "inactive_lru_pages >
pages_for_compaction" is true.

So, both should_continue_reclaim() and should_compact_retry() are unable to
recognize that reclaimed pages are being stolen and limit the retries in
that case. The scenario seems to be uncommon, otherwise we'd be getting more
reports of that.
