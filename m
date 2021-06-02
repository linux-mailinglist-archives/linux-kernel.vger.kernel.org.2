Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5A8D397F76
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 05:27:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231238AbhFBD3f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 23:29:35 -0400
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57]:50291 "EHLO
        out30-57.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230511AbhFBD3e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 23:29:34 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R541e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=xuyu@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0Ub.lqm4_1622604468;
Received: from xuyu-mbp15.local(mailfrom:xuyu@linux.alibaba.com fp:SMTPD_---0Ub.lqm4_1622604468)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 02 Jun 2021 11:27:48 +0800
Subject: Re: [PATCH] mm, thp: relax migration wait when failed to get tail
 page
To:     Hugh Dickins <hughd@google.com>,
        Matthew Wilcox <willy@infradead.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, gavin.dg@linux.alibaba.com,
        Greg Thelen <gthelen@google.com>, Wei Xu <weixugc@google.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>
References: <bc8567d7a2c08ab6fdbb8e94008157265d5d28a3.1622564942.git.xuyu@linux.alibaba.com>
 <alpine.LSU.2.11.2106010947370.1090@eggly.anvils>
 <YLZqKJ4anEGpAZfp@casper.infradead.org>
 <alpine.LSU.2.11.2106011114580.1045@eggly.anvils>
From:   Yu Xu <xuyu@linux.alibaba.com>
Message-ID: <71c320bf-3fcb-f8c0-65e4-ff706af05607@linux.alibaba.com>
Date:   Wed, 2 Jun 2021 11:27:47 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <alpine.LSU.2.11.2106011114580.1045@eggly.anvils>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/2/21 3:10 AM, Hugh Dickins wrote:
> On Tue, 1 Jun 2021, Matthew Wilcox wrote:
>> On Tue, Jun 01, 2021 at 09:55:56AM -0700, Hugh Dickins wrote:
>>>
>>> Well caught: you're absolutely right that there's a bug there.
>>> But isn't cond_resched() just papering over the real bug, and
>>> what it should do is a "page = compound_head(page);" before the
>>> get_page_unless_zero()? How does that work out in your testing?
>>
>> You do realise you're strengthening my case for folios by suggesting
>> that, don't you?  ;-)
> 
> Hah! Well, I do realize that I'm offering you a marketing opportunity.
> And you won't believe how many patches I dread to post for fear of that ;-)
> 
> But I'm not so sure that it strengthens your case: apparently folios
> had not detected this?  Or do you have a hoard of folio-detected fixes
> waiting for the day, and a folio-kit for each of the stable releases?
> 
>>
>> I was going to suggest that it won't make any difference because the
>> page reference count is frozen, but the freezing happens after the call
>> to unmap_page(), so it may make a difference.
> 
> I think that's a good point: I may have just jumped on the missing
> compound_head(), without thinking it through as far as you have.
> 
> I'm having trouble remembering the dynamics now; but I think there
> are cond_resched()s in the unmap_page() part, so the splitter may
> get preempted even on a non-preempt kernel; whereas the frozen
> part is all done expeditiously, with interrupts disabled.
> 
> Greg discovered the same issue recently, but we all got sidetracked,
> and I don't know where his investigation ended up.  He was in favour
> of cond_resched(), I was in favour of compound_head(); and I think I

I ever considered about using compound_head, but isn't there another
race that, the following put_and_wait_on_page_locked operates on the
"tail page" which has been split and is now a single page?

Anyway, I will test and verify compound_head.

> was coming to the conclusion that if cond_resched() is needed, it
> should not be there in __migration_entry_wait(), but somewhere up
> in mm/gup.c, so that other faults that retry, expecting to reschedule
> on return to userspace, do not get trapped in kernelspace this way.

Agreed. I will send v2, if cond_resched is still an option.

> 
> Waiting on migration entries from THP splitting is an egregious
> example, but others may be suffering too.
> 
> Hugh
> 

-- 
Thanks,
Yu
