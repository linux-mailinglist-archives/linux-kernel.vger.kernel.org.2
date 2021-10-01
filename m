Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DF1841EF25
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Oct 2021 16:08:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354159AbhJAOJn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Oct 2021 10:09:43 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:46522 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238603AbhJAOJm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Oct 2021 10:09:42 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id EE0942268B;
        Fri,  1 Oct 2021 14:07:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1633097276; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aWvnTVGXWsJcYk3O4hTEocklW2Gx5Reb6p/H6bf33y0=;
        b=dh7x3oakU4w+NZCbj0TCFQNcQKYQk1WJXzoL2OjFD34gMfgkDUMSIYviFhgv03x+EI+qvl
        RVEebq1Z1T5g2oiZUUJUNl7hjM20/Nnx0RmbenYY3NBz1aMAEZTzmD1tTQ0J4KlKtUep+M
        qNPMMLUbZh75HuS2RISUN30XBOLnNxU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1633097276;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aWvnTVGXWsJcYk3O4hTEocklW2Gx5Reb6p/H6bf33y0=;
        b=jhrL9m/oc8K/Rb34VfnmG/ID3Txgxr3eWjJl11KFVXQ1MdpeXbDuHdBm5EF7Q69JJZsxYv
        YzSGNA3kT7/JGXCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D095113C66;
        Fri,  1 Oct 2021 14:07:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id lNVNMjwWV2G7HAAAMHmgww
        (envelope-from <vbabka@suse.cz>); Fri, 01 Oct 2021 14:07:56 +0000
Message-ID: <b3c5bd9a-5fbc-8388-a4ab-6c20864dc7c6@suse.cz>
Date:   Fri, 1 Oct 2021 16:07:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.0.3
Subject: Re: [QUESTION] is SLAB considered legacy and deprecated?
Content-Language: en-US
To:     Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc:     linux-mm@kvack.org, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
References: <20210927090347.GA2533@linux.asia-northeast3-a.c.our-ratio-313919.internal>
 <8aa15f4b-71de-5283-5ebc-d8d1a323473d@suse.cz>
 <20210928111231.GA2596@linux.asia-northeast3-a.c.our-ratio-313919.internal>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20210928111231.GA2596@linux.asia-northeast3-a.c.our-ratio-313919.internal>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/28/21 13:12, Hyeonggon Yoo wrote:
>>> So there is a fundamental question coming into my mind:
>>> 	'is SLAB considered legacy and deprecated?'
>>
>> To some extend, but not yet in a sense where we would have a deadline to get
>> rid of it. 
> 
> What makes you to say 'To some extent'?
> That's what I'm curious about :)

"To some extent" because SLUB is default and if some new stuff was added
that only worked with SLUB and not SLAB, there wouldn't be major
objections expected.

>> In some contexts it's still being preferred, AFAIK.
> 
> In what context is SLAB or SLUB is preferred?

I don't know the full answer. With our distro we have used SLAB, and
switched to SLUB after verifying that there are no major regressions.
Better debugging features were perhaps the major reason.

> And what is the core reason that SLUB is used by default?

The usual reason in MM, nobody objected :)
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=a0acd82080768

>>> It seems there are little development on SLAB and people think that
>>> SLAB is legacy and deprecated, so CONFIG_SLUB is used by default.
>>>
>>> But I think both has pros and cons for their own:
>>> 	SLAB: more temporal locality (cache friendly)
>>> 	but high usage of memory, and less spatial locality (TLB misses) than SLUB.
>>>
>>> 	SLUB: less temporal locality (less cache friendly) than SLAB
>>> 	but more spatial locality (TLB hit), and low usage of memory
>>> 	and good debugging feature.
>>
>> I'm not so sure about the usage of memory, SLUB can easily use more I
>> believe. Instead of caching some arrays of objects it will have one or more
>> private slabs per cpu, and the slabs are larger-order pages.
>>
> 
> SLAB uses much memory than slab, when there are *lots* of NUMA nodes.
> 	because kmem_cache_node exist per node and it keeps alien cache
> 	(used for caching freeing object from remote node),
> 	so it keeps MAX_NUMANODES ^ 2 of array_cache per slab.
> 	that is why I said SLAB uses much memory than SLUB.

Maybe, theoretically. But SLUB has per-cpu partial lists caching whole
slab pages, not just arrays of objects. Number of cpus will generally
grow with number of NUMA nodes.

> to quote Christoph Lameter's (who made SLUB and current maintainer) presentation in 2014:
> 	See link [6] for this
> 	p21: "SLAB queuing can get intensive memory usage going grows
> 	exponentially by NUMA node"
> 
> But I'm not sure if SLAB or SLUB is good on UMA architecture.
> 
>>> Why do people say SLAB is deprecated/legacy?
>>
>> Do they?
>>
> 
> Yes I think they do.
> 
> One example is presentation of David Rientjes (one of maintainers) in 2011:
> 	See link [7]
> 	p5: "SLAB is deprecated, very little development"
> 	p5: "Many distributions still ship with CONFIG_SLAB even
> 		though it is not the kernel default"
> 
> Anyway, I wanted to discuss the current status of SLAB.
> 
> To me, it seems that people do not work on SLAB lately
> and it seems some maintainers (David, Christoph) think
> it's better to move from SLAB to SLUB. one of them is Christoph himself.
> As he made SLUB because he don't agree on design of SLAB. [8]

Right.
Here's the discussion from the last time SLAB removal was proposed and
rejected, feel free to evaluate if the points there are still valid today:

https://lore.kernel.org/all/20190410024714.26607-1-tobin@kernel.org/

> Thanks,
> Hyeonggon.
> 
> Searching his name and sort by date
> [1] https://lore.kernel.org/lkml/?q=Christoph+Lameter&o=10800
> 
> [GIT PULL] SLAB updates for 2.6.37-rc1 by Pekka Enberg
> [2] https://lore.kernel.org/lkml/alpine.DEB.2.00.1010242005280.4447@tiger/#r
> 
> His work on lockless fastpath of slub (2011-02),
> [3] https://lore.kernel.org/lkml/20110225173850.486326452@linux.com/
> 
> His work on lockless fastpath of slub (2011-06)
> [4] https://lore.kernel.org/lkml/20110601172543.437240675@linux.com/
> 
> His work on per cpu partial lists
> [5] https://lore.kernel.org/lkml/20110809211221.831975979@linux.com/
> 
> Christoph's presentation on slab
> [6] - https://events.static.linuxfound.org/sites/events/files/slides/slaballocators.pdf
> 
> David's presentation on slab
> [7] - https://www.socallinuxexpo.org/scale9x-media/scalemedia/scale/scale9x-media/simple_cfp/presentations/16_30-DavidRientjes-Status_of_the_Linux_Slab_Allocators.pdf
> 
> [8] SLUB: The unqueued slab allocator V6
> https://lwn.net/Articles/229096/
> 

