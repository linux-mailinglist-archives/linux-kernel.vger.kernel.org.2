Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DF214429B3
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 09:41:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231176AbhKBIo1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 04:44:27 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:50734 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230000AbhKBIoZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 04:44:25 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 7AD221FD78;
        Tue,  2 Nov 2021 08:41:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1635842510; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tz+vql88CgsF58vdIu35HL5zvxpH8YjJc4+0TvPpKZU=;
        b=H9YxqWEuNTYd76rLiYI4L2XWYeZpjWLmlKrUXU9juLdw0BiHN+rc/+2tqDR7Fy5Se8CEEs
        ckR+mYMKzMouG8AAdyCrXUQoGApmouZx3jOViMTAaaiQMvr3zWWYVivsmtKHsdKeJZ1O04
        jEhFZ/seHwuQ3OclEt90swpZcmneaXo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1635842510;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tz+vql88CgsF58vdIu35HL5zvxpH8YjJc4+0TvPpKZU=;
        b=XT0uu/odAQtZWNn7poivWN7ZKPovW+GJIMttnv1upl52cpOvfSU2FT1dMPk/YkdsZKcob2
        eB4XzNx8FV47N/DQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4EC1013B16;
        Tue,  2 Nov 2021 08:41:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id HgZZEs75gGEFawAAMHmgww
        (envelope-from <vbabka@suse.cz>); Tue, 02 Nov 2021 08:41:50 +0000
Message-ID: <b3843ab5-a2d9-fc12-6ed9-4646c3c6fdd7@suse.cz>
Date:   Tue, 2 Nov 2021 09:41:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [PATCH] mm, slub: place the trace before freeing memory in
 kmem_cache_free()
Content-Language: en-US
To:     John Hubbard <jhubbard@nvidia.com>,
        Yunfeng Ye <yeyunfeng@huawei.com>, cl@linux.com,
        penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     wuxu.wu@huawei.com, Hewenliang <hewenliang4@huawei.com>
References: <867f6da4-6d38-6435-3fbb-a2a3744029f1@huawei.com>
 <df216633-cc14-6c3b-29ed-cdce136402eb@nvidia.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <df216633-cc14-6c3b-29ed-cdce136402eb@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/2/21 08:03, John Hubbard wrote:
> On 10/30/21 03:11, Yunfeng Ye wrote:
>> After the memory is freed, it may be allocated by other CPUs and has
>> been recorded by trace. So the timing sequence of the memory tracing is
>> inaccurate.
>>
>> For example, we expect the following timing sequeuce:
>>
>>      CPU 0                 CPU 1
>>
>>    (1) alloc xxxxxx
>>    (2) free  xxxxxx
>>                           (3) alloc xxxxxx
>>                           (4) free  xxxxxx
>>
>> However, the following timing sequence may occur:
>>
>>      CPU 0                 CPU 1
>>
>>    (1) alloc xxxxxx
>>                           (2) alloc xxxxxx
>>    (3) free  xxxxxx
>>                           (4) free  xxxxxx
>>
>> So place the trace before freeing memory in kmem_cache_free().
> 
> Hi Yunfeng,
> 
> Like Muchun, I had some difficulty with the above description, but
> now I think I get it. :)
> 
> In order to make it easier for others, how about this wording and subject
> line, instead:
> 
> 
> mm, slub: emit the "free" trace report before freeing memory in
> kmem_cache_free()
> 
> After the memory is freed, it can be immediately allocated by other
> CPUs, before the "free" trace report has been emitted. This causes
> inaccurate traces.
> 
> For example, if the following sequence of events occurs:
> 
>     CPU 0                 CPU 1
> 
>   (1) alloc xxxxxx
>   (2) free  xxxxxx
>                          (3) alloc xxxxxx
>                          (4) free  xxxxxx
> 
> ...then they will be inaccurately reported via tracing, so that they
> appear to have happened in this order. This makes it look like CPU 1
> somehow managed to allocate mmemory that CPU 0 still had allocated for
> itself:
> 
>     CPU 0                 CPU 1
> 
>   (1) alloc xxxxxx
>                          (2) alloc xxxxxx
>   (3) free  xxxxxx
>                          (4) free  xxxxxx
> 
> In order to avoid this, emit the "free xxxxxx" tracing report just
> before the actual call to free the memory, instead of just after it.

Agree, this wording is better.
IIRC the same problem was fixed for mmap_lock trace ordering just recently.

>> Signed-off-by: Yunfeng Ye <yeyunfeng@huawei.com>

Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
