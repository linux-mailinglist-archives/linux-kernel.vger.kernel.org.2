Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF50237C03A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 16:33:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230483AbhELOfB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 10:35:01 -0400
Received: from mx2.suse.de ([195.135.220.15]:34394 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230370AbhELOfA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 10:35:00 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 0D24EADD7;
        Wed, 12 May 2021 14:33:51 +0000 (UTC)
To:     Andrew Morton <akpm@linux-foundation.org>, glittao@gmail.com
Cc:     cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, "Paul E . McKenney" <paulmck@kernel.org>
References: <20210414163434.4376-1-glittao@gmail.com>
 <20210509214603.d2a5faaa3fe0d71c3517cb36@linux-foundation.org>
From:   Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH] mm/slub: use stackdepot to save stack trace in objects
Message-ID: <f9dd0692-e490-56ce-3cd8-b99aea559e79@suse.cz>
Date:   Wed, 12 May 2021 16:33:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210509214603.d2a5faaa3fe0d71c3517cb36@linux-foundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/10/21 6:46 AM, Andrew Morton wrote:
> On Wed, 14 Apr 2021 18:34:34 +0200 glittao@gmail.com wrote:
> 
>> Many stack traces are similar so there are many similar arrays.
>> Stackdepot saves each unique stack only once.
>> 
>> Replace field addrs in struct track with depot_stack_handle_t handle.
>> Use stackdepot to save stack trace.
>> 
>> The benefits are smaller memory overhead and possibility to aggregate
>> per-cache statistics in the future using the stackdepot handle
>> instead of matching stacks manually.
> 
> Which tree was this prepared against?  5.12's kmem_obj_info() is
> significantly different from the version you were working on.

It was based on -next at the time of submission, which contained patch in Paul's
tree that expands kmem_obj_info to print also free call stack [1] so that also
needs to be switched to stackdepot to work.

> Please take a look, redo, retest and resend?  Thanks.

I expected [1] to be in 5.13-rc1, but as Paul explained to me, it's queued for
5.14. So if we (Oliver) rebase on current -next, can you queue it in the section
of mmotm series that goes after -next?

Vlastimil

[1]
https://lore.kernel.org/linux-arm-kernel/1615891032-29160-2-git-send-email-maninder1.s@samsung.com/
