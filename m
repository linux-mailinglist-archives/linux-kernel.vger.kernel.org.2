Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46CA138FF5E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 12:37:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231926AbhEYKid (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 06:38:33 -0400
Received: from mx2.suse.de ([195.135.220.15]:48590 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229693AbhEYKiX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 06:38:23 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1621939013; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TAEMRMdeN7eHAUUj1q6dnzZ4Qoz3CinUiEpDsYlKJ+w=;
        b=dPEJS7SBHuQrhnYYxMm64ogIBl2jNaZbHM7T62kc1NN6ZDaqFHsjSC8JNY50E0Tk4PGnca
        I79plJEcVZ2BiCBtebbdBsFcsD9TGSUFMVrh4sJu9UkrgkJtbIWKPnVF+BZcTzdJYJARTb
        DG0hq3PmcZDP+eq/HpB69QzIi19jdU0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1621939013;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TAEMRMdeN7eHAUUj1q6dnzZ4Qoz3CinUiEpDsYlKJ+w=;
        b=YoJhgwCrsJH23vB/d4T5lQLcT8Payw4SCk4yD2sp3tuKET2sUxzVNU323S+xtY+x3yJt4V
        39BVX6X5PWlk2uAA==
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 3377BAF11;
        Tue, 25 May 2021 10:36:53 +0000 (UTC)
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
 <20210524233946.20352-3-vbabka@suse.cz>
 <20210525101742.GK30378@techsingularity.net>
From:   Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [RFC 02/26] mm, slub: allocate private object map for
 validate_slab_cache()
Message-ID: <aad15d62-23c0-9eeb-d61f-a214eb57fb19@suse.cz>
Date:   Tue, 25 May 2021 12:36:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210525101742.GK30378@techsingularity.net>
Content-Type: text/plain; charset=iso-8859-15
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/25/21 12:17 PM, Mel Gorman wrote:
> On Tue, May 25, 2021 at 01:39:22AM +0200, Vlastimil Babka wrote:
>> validate_slab_cache() is called either to handle a sysfs write, or from a
>> self-test context. In both situations it's straightforward to preallocate a
>> private object bitmap instead of grabbing the shared static one meant for
>> critical sections, so let's do that.
>> 
>> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
>>
>> <SNIP>
>>
>> @@ -4685,10 +4685,17 @@ static long validate_slab_cache(struct kmem_cache *s)
>>  	int node;
>>  	unsigned long count = 0;
>>  	struct kmem_cache_node *n;
>> +	unsigned long *obj_map;
>> +
>> +	obj_map = bitmap_alloc(oo_objects(s->oo), GFP_KERNEL);
>> +	if (!obj_map)
>> +		return -ENOMEM;
>>  
> 
> 
> Most callers of validate_slab_cache don't care about the return value
> except when the validate sysfs file is written. Should a simply
> informational message be displayed for -ENOMEM in case a writer to
> validate fails and it's not obvious it was because of an allocation
> failure?

he other callers are all in the effectively dead resiliency_test() code, which
has meanwhile been replaced in mmotm by kunit tests meanwhile. But it's true
those don't check the results either for now.

> It's a fairly minor concern so whether you add a message or not

I think I'll rather fix up the tests. Or do you mean that -ENOMEM for a sysfs
write is also not enough and there should be a dmesg explanation for that case?

> Acked-by: Mel Gorman <mgorman@techsingularity.net>

Thanks!

