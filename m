Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C713D439109
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 10:19:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230135AbhJYIVb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 04:21:31 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:55992 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230099AbhJYIV1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 04:21:27 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 3EA99218F6;
        Mon, 25 Oct 2021 08:19:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1635149945; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HJynk4kVWigSInhdC1IKd9LkRSRu8y8norq0H8UKTWc=;
        b=ixhWg1kjAkmLIhCbm3WBzMv6Dv/V77hfXDmAiDzVC+aCUicbk0d5gp5Mi3ATnZx+UGPBdh
        2s89kW6RfJ1Ycpnwc2dox36IXmjmgD9IePZ/f93oYO2evwTCrY0m69UWHuc5cbd4FREQCt
        ELEFKDVeNuhlxvQKQwgt0cHMxfIzurs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1635149945;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HJynk4kVWigSInhdC1IKd9LkRSRu8y8norq0H8UKTWc=;
        b=ZII9hYKZy80op/PTmF0i+s+/LoKC8UQCJRoISuzN10oFy3SGT1S2+fTTK/50vxfuWmLfdG
        X3FcwFMma7+XQVAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0DDD013216;
        Mon, 25 Oct 2021 08:19:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id snrKAnlodmG+JAAAMHmgww
        (envelope-from <vbabka@suse.cz>); Mon, 25 Oct 2021 08:19:05 +0000
Message-ID: <895c88e8-b1f8-9ce3-8968-1c349c163b63@suse.cz>
Date:   Mon, 25 Oct 2021 10:19:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH] slob: add size header to all allocations
Content-Language: en-US
To:     Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc:     Rustam Kovhaev <rkovhaev@gmail.com>, cl@linux.com,
        penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, djwong@kernel.org, david@fromorbit.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        gregkh@linuxfoundation.org, viro@zeniv.linux.org.uk,
        dvyukov@google.com
References: <20211015005729.GD24333@magnolia>
 <20211018033841.3027515-1-rkovhaev@gmail.com>
 <20211020114638.GA378758@kvm.asia-northeast3-a.c.our-ratio-313919.internal>
 <1dfb7a79-3e66-a9fe-ee7c-1277d7ff5950@suse.cz>
 <20211024104340.GA4370@kvm.asia-northeast3-a.c.our-ratio-313919.internal>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20211024104340.GA4370@kvm.asia-northeast3-a.c.our-ratio-313919.internal>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/24/21 12:43, Hyeonggon Yoo wrote:
>> >> 
>> >> The main reason for this change is to simplify SLOB a little bit, make
>> >> it a bit easier to debug whenever something goes wrong.
>> >>
>> > 
>> > It seems acceptable But I wonder it is worth to increase memory usage
>> > to allow freeing kmem_cache_alloc-ed objects by kfree()?
>> 
>> Not for the reason above, but for providing a useful API guarantee
>> regardless of selected slab allocator IMHO yes.
>> 
> 
> Mm.. that means some callers free kmem_cache_alloc-ed object using
> kfree, and SLAB/SLUB already support that, and SLOB doesn't.

Exactly. Finding that out started this whole thread.

> In what situations is freeing using kfree needed?
> Wouldn't this make code confusing?

XFS seems to have good reasons - at some common freeing place objects can
appears from multiple caches, and it would be expensive to track their cache
just to free them. See
https://lore.kernel.org/all/20210930044202.GP2361455@dread.disaster.area/

IMHO it really makes sense to support this from API point of view.
kmem_cache_alloc() is basically a more specific version of the generic
kmalloc(). It makes sense if the generic kind of free, that is kfree() works
on those objects too.

>> > Thanks,
>> > Hyeonggon
>> > 
>> >> meminfo right after the system boot, without the patch:
>> >> Slab:              35500 kB
>> >> 
>> >> the same, with the patch:
>> >> Slab:              36396 kB
>> >> 
>> > 
>> 
> 

