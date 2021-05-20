Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F377738A726
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 12:36:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237737AbhETKfZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 06:35:25 -0400
Received: from mx2.suse.de ([195.135.220.15]:41856 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236066AbhETKVw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 06:21:52 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 63FD5AC5B;
        Thu, 20 May 2021 10:20:30 +0000 (UTC)
Subject: Re: [PATCH v3] mm/page_alloc: bail out on fatal signal during
 reclaim/compaction retry attempt
To:     Andrew Morton <akpm@linux-foundation.org>,
        Aaron Tomlin <atomlin@redhat.com>
Cc:     linux-mm@kvack.org, mhocko@suse.com, willy@infradead.org,
        linux-kernel@vger.kernel.org
References: <YKVn69o1UizH0kJD@casper.infradead.org>
 <20210519201743.3260890-1-atomlin@redhat.com>
 <20210519213455.97ff95f0124b4120787f8314@linux-foundation.org>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <9b11dcd8-bc3b-aae9-feb1-43543bf9e22f@suse.cz>
Date:   Thu, 20 May 2021 12:20:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210519213455.97ff95f0124b4120787f8314@linux-foundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/20/21 6:34 AM, Andrew Morton wrote:
> On Wed, 19 May 2021 21:17:43 +0100 Aaron Tomlin <atomlin@redhat.com> wrote:
> 
>> It does not make sense to retry compaction when a fatal signal is
>> pending.
> 
> Well, it might make sense.  Presumably it is beneficial to other tasks.

Yeah but the compaction won't happen. compact_zone() will immediately detect it
via __compact_finished() and bail out. So in that sense it does not make sense
to retry :)

>> In the context of try_to_compact_pages(), indeed COMPACT_SKIPPED can be
>> returned; albeit, not every zone, on the zone list, would be considered
>> in the case a fatal signal is found to be pending.
>> Yet, in should_compact_retry(), given the last known compaction result,
>> each zone, on the zone list, can be considered/or checked
>> (see compaction_zonelist_suitable()). For example, if a zone was found
>> to succeed, then reclaim/compaction would be tried again
>> (notwithstanding the above).
>> 
>> This patch ensures that compaction is not needlessly retried
>> irrespective of the last known compaction result e.g. if it was skipped,
>> in the unlikely case a fatal signal is found pending.
>> So, OOM is at least attempted.
> 
> What observed problems motivated this change?
> 
> What were the observed runtime effects of this change?

Yep those details from the previous thread should be included here.

