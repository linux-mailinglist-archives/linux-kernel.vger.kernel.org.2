Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32E1244309C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 15:39:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231312AbhKBOl4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 10:41:56 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:47706 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbhKBOlx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 10:41:53 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 5FFF91FD4E;
        Tue,  2 Nov 2021 14:39:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1635863957; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KLM6q3OCHX8Q1M0ci4/mv4477ca1A686qTV4J0tZwX0=;
        b=QVkJPpq3itzE0WoXuN7WlVkg0kudICKXnbxS6zSLcR4KPZn2Eax2Y1zOQ6Z/R5NmnZOS6J
        oSgTf2nYDTUYqCbwc3mAAjdMCyN+KDZgFzBSbfn065G9gcdHOwqLeRv1mIQDHYoOCHAXsb
        MRTe2TAPrx17esQaF0seqeKywB0fZ1A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1635863957;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KLM6q3OCHX8Q1M0ci4/mv4477ca1A686qTV4J0tZwX0=;
        b=AZYVwT5SonZmrPQVLIdC/Tr9c7v8E1KI4OAl/AeFFKn6NO9I5cXP69n/0ussFeCZz4c8Du
        wn+BwtwPhS6ALEDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2DEC413BF7;
        Tue,  2 Nov 2021 14:39:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id OSuzCZVNgWG8MgAAMHmgww
        (envelope-from <vbabka@suse.cz>); Tue, 02 Nov 2021 14:39:17 +0000
Message-ID: <5f3b17ae-bff5-fd0f-cd1e-fa481f100149@suse.cz>
Date:   Tue, 2 Nov 2021 15:39:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [PATCH v2] mm, slub: emit the "free" trace report before freeing
 memory in kmem_cache_free()
Content-Language: en-US
To:     Tang Yizhou <tangyizhou@huawei.com>,
        Yunfeng Ye <yeyunfeng@huawei.com>, cl@linux.com,
        penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     jhubbard@nvidia.com, songmuchun@bytedance.com, willy@infradead.org,
        wuxu.wu@huawei.com, Hewenliang <hewenliang4@huawei.com>
References: <a6824ebe-a0ad-fedb-ada3-c362f9c8f363@huawei.com>
 <ee45ee4c-0993-e752-f4fc-fed519b67525@huawei.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <ee45ee4c-0993-e752-f4fc-fed519b67525@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/2/21 14:53, Tang Yizhou wrote:
> On 2021/11/2 19:43, Yunfeng Ye wrote:
>> --- a/mm/slub.c
>> +++ b/mm/slub.c
>> @@ -3526,8 +3526,8 @@ void kmem_cache_free(struct kmem_cache *s, void *x)
>>  	s = cache_from_obj(s, x);
>>  	if (!s)
>>  		return;
>> -	slab_free(s, virt_to_head_page(x), x, NULL, 1, _RET_IP_);
>>  	trace_kmem_cache_free(_RET_IP_, x, s->name);
>> +	slab_free(s, virt_to_head_page(x), x, NULL, 1, _RET_IP_);
>>  }
> 
> It seems that kmem_cache_free() in mm/slab.c has the same problem.
> We can fix it. Thanks.

Doh, true. Should go best before the local_irq_save() there.
And also kmem_cache_free() in mm/slob.c.

Interestingly kfree() is already OK in all 3 implementations.

>>  EXPORT_SYMBOL(kmem_cache_free);
>> 
> 

