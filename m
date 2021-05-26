Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B1023915B0
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 13:04:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234125AbhEZLFa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 07:05:30 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:48392 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234095AbhEZLFZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 07:05:25 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by smtp-out2.suse.de (Postfix) with ESMTP id 42D371FD2A;
        Wed, 26 May 2021 11:03:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1622027033; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jmH4PcnwK0rytF/VgkkXd+8VdrhyiX8N2LMiP410pmM=;
        b=AhkFEQt5W+uJoB7umdFvSDbZB3TVTeVtxIw3nG86EPFKDPH+Lzkds0UtmnX+ak6QFzIj6c
        MV1kJyHM+VegjS6s5fhbmKPp7axTIqJzfJ16axyLtWXjoC7HLxTSGBJ/bKUJFnL8sixW7l
        jEswJUDEjNAk7qWElofnNhf4VcJXo/Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1622027033;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jmH4PcnwK0rytF/VgkkXd+8VdrhyiX8N2LMiP410pmM=;
        b=GbLhaDhcFq3iUMd0QfZwMwga3xArqoag9jLXIA+EkYKdx6edX8lE7zZUI/BRqGCUdNt1w3
        rTW3Qft0gSADNMBg==
Received: from director2.suse.de (director2.suse-dmz.suse.de [192.168.254.72])
        by imap.suse.de (Postfix) with ESMTPSA id E618411A98;
        Wed, 26 May 2021 11:03:52 +0000 (UTC)
To:     Greg KH <gregkh@linuxfoundation.org>,
        Faiyaz Mohammed <faiyazm@codeaurora.org>
Cc:     cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        glittao@gmail.com, vinmenon@codeaurora.org
References: <1621928285-751-1-git-send-email-faiyazm@codeaurora.org>
 <YKys873HUNp/ZMqV@kroah.com>
 <7324d56f-c5fe-05fa-55f2-7dd2dbf9bce0@codeaurora.org>
 <YKzlia5b/vaDaul9@kroah.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH v7] mm: slub: move sysfs slab alloc/free interfaces to
 debugfs
Message-ID: <371e20a8-6b07-1eaa-d587-3b444d03ba2f@suse.cz>
Date:   Wed, 26 May 2021 13:03:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <YKzlia5b/vaDaul9@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/25/21 1:54 PM, Greg KH wrote:
> On Tue, May 25, 2021 at 02:27:15PM +0530, Faiyaz Mohammed wrote:
> >> --- a/mm/slab_common.c
>> >> +++ b/mm/slab_common.c
>> >> @@ -455,6 +455,9 @@ static void slab_caches_to_rcu_destroy_workfn(struct work_struct *work)
>> >>  #else
>> >>  		slab_kmem_cache_release(s);
>> >>  #endif
>> >> +#ifdef SLAB_SUPPORTS_DEBUGFS
>> >> +		debugfs_slab_release(s);
>> >> +#endif
>> > 
>> > Why do you need these #ifdef if your slub_dev.h file already provides an
>> > "empty" function for this?
>> > 
>> We are not including slub_def.h directly. mm/slab.h includes the
>> slub_def.h if CONFIG_SLUB enable,
>> 
>> from mm/slab.h
>> #ifdef CONFIG_SLAB
>> #include <linux/slab_def.h>
>> #endif
>> 
>> #ifdef CONFIG_SLUB
>> #include <linux/slub_def.h>
>> #endif
>> 
>> so if CONFIG_SLAB is enable then mm/slab.h includes slab_def.h, to avoid
>> undefined reference error added SLAB_SUPPORTS_DEBUGFS like
>> SLAB_SUPPORTS_SYSFS.
> 
> Ick, ok, messy code, I'll stop complaining now if this really is the
> only way to do it (still feels wrong to me...)

How about simply replicating the empty function in
include/linux/slab_def.h

We could do the same with SYSFS, except the SLAB (and SLUB w/o SYSFS) versions
of sysfs_slab_release() would not be empty, but just call
slab_kmem_cache_release(s);
Then we could get rid of the #ifdef's completely?

> greg k-h
> 

