Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53E6540C1EA
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 10:42:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232676AbhIOIn1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 04:43:27 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:39126 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbhIOIn0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 04:43:26 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 44174221B6;
        Wed, 15 Sep 2021 08:42:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1631695327; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ss0cx9db0tE4mKDvUy1qeDM+5YsJGE3aId/CpWQkZJY=;
        b=PEc06L+q4OSsqr2e2CO2jd60kWPVsnJe60hwmlN1P70NjAg8X1himjcjpe0ZQm0TccloWn
        76C+Ap5LUTM+EaUmLDZxq0w/Jt2NdkrLMEiMTofWgm+mqRCKj5CIoAmA7m6+n0IgjO6YuN
        MqHf/ibR7id5X38ZRFnVolfvTbqdb1g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1631695327;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ss0cx9db0tE4mKDvUy1qeDM+5YsJGE3aId/CpWQkZJY=;
        b=wn6Nm0FqmF2d4WrE02wGsScQ9Fq4hTY72p/+3qqR86tuGWR5/5gN73BoUoiA5SVhhI6Ig6
        1n14LBRyGSX8e0Dg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1E39013C1A;
        Wed, 15 Sep 2021 08:42:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id h3y9Bt+xQWGePQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Wed, 15 Sep 2021 08:42:07 +0000
Message-ID: <ba5b7957-52fc-d8be-ed51-a2d21a233b4b@suse.cz>
Date:   Wed, 15 Sep 2021 10:42:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Content-Language: en-US
To:     David Rientjes <rientjes@google.com>
Cc:     linux-mm@kvack.org, Christoph Lameter <cl@linux.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Pekka Enberg <penberg@kernel.org>,
        Jann Horn <jannh@google.com>, linux-kernel@vger.kernel.org,
        Roman Gushchin <guro@fb.com>
References: <20210913170148.10992-1-vbabka@suse.cz>
 <c167ab10-f970-15c-b0e-fd4484ddc637@google.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [RFC PATCH] mm, slub: change percpu partial accounting from
 objects to pages
In-Reply-To: <c167ab10-f970-15c-b0e-fd4484ddc637@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/15/21 07:32, David Rientjes wrote:
> On Mon, 13 Sep 2021, Vlastimil Babka wrote:
> 
>> While this is no longer a problem in kmemcg context thanks to the accounting
>> rewrite in 5.9, the memory waste is still not ideal and it's questionable
>> whether it makes sense to perform free object count based control when object
>> counts can easily become so much inaccurate. So this patch converts the
>> accounting to be based on number of pages only (which is precise) and removes
>> the page->pobjects field completely. This is also ultimately simpler.
>> 
> 
> Thanks for the very detailed explanation, this is very timely for us.
> 
> I'm wondering if we should be concerned about the memory waste even being 
> possible, though, now that we have the kmemcg accounting change?
> 
> IIUC, because we're accounting objects and not pages, then it *seems* like 
> we could have a high number of pages but very few objects charged per 
> page so this memory waste could go unconstrained from any kmemcg 
> limitation.

So the main problem before 5.9 was that there were separate kmem caches per
memcg with their own percpu partial lists, so the memory used was determined
by caches x cpus x memcgs, now they are shared so it's just caches x cpus.
What you're saying would be also true, but relatively much smaller issue
than what it was before 5.9.

>> To retain the existing set_cpu_partial() heuristic, first calculate the target
>> number of objects as previously, but then convert it to target number of pages
>> by assuming the pages will be half-filled on average. This assumption might
>> obviously also be inaccurate in practice, but cannot degrade to actual number of
>> pages being equal to the target number of objects.
>> 
> 
> I think that's a fair heuristic.
> 
>> We could also skip the intermediate step with target number of objects and
>> rewrite the heuristic in terms of pages. However we still have the sysfs file
>> cpu_partial which uses number of objects and could break existing users if it
>> suddenly becomes number of pages, so this patch doesn't do that.
>> 
>> In practice, after this patch the heuristics limit the size of percpu partial
>> list up to 2 pages. In case of a reported regression (which would mean some
>> workload has benefited from the previous imprecise object based counting), we
>> can tune the heuristics to get a better compromise within the new scheme, while
>> still avoid the unexpectedly long percpu partial lists.
>> 
> 
> Curious if you've tried netperf TCP_RR with this change?  This benchmark 
> was the most significantly improved benchmark that I recall with the 
> introduction of per-cpu partial slabs for SLUB.  If there are any 
> regressions to be introduced by such an approach, I'm willing to bet that 
> it would be surfaced with that benchmark.

I'll try, thanks for the tip.
