Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52E14434793
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 11:05:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229686AbhJTJHd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 05:07:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:49970 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229503AbhJTJHc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 05:07:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634720717;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=G3m5JwlF+0/iNt2yAgQJIZZFDgUco38WFHvzPst+Es4=;
        b=QWt2A5bw0yW6moSwx0T2MkVU/VMF3hqvipOQL21wcsdBOI032iTkT7jJ4xRkfntSSDDWk/
        4FpO/FZ/hWGoxIWLikMGZ3JmGRd/NFs3a4nNe6Kra24BjTwv0rpTWUyD4xNY6+cwVFIGle
        qIgfCCkAE56R1OxbO6rs0pEZPvwayGw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-233-U3RGfKNCMm--wwxUB5xfFA-1; Wed, 20 Oct 2021 05:05:14 -0400
X-MC-Unique: U3RGfKNCMm--wwxUB5xfFA-1
Received: by mail-wm1-f72.google.com with SMTP id y142-20020a1c7d94000000b00322f2e380f2so2289133wmc.6
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 02:05:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:organization:subject
         :in-reply-to:content-transfer-encoding;
        bh=G3m5JwlF+0/iNt2yAgQJIZZFDgUco38WFHvzPst+Es4=;
        b=C50WHpy1PbprjNpd3qasayUrVv0rzmAkB3RNHvAAiZFxJLxyxk3blIhjdgsuKAxtaX
         +Zv7WA2teI9owwQsEpKLTzyLo1I7UzRB05AZCHcFup2Q/GbakQESvpVHc5R3dwz02984
         grm/Z43/5oF0CiTwjn0GrULIztqSl5BT//WZir3oLOQlUzyKC2dBcsbJQCbOb63CWVdJ
         L/tl8w9et/0dH0fx/XaTCVK3Lu1xHXbQt8Vnq+f70669888mbFSeLvT2H691NFPFAx4R
         HwVWrhD/tKR+djner/pVSaP8N5sc2NUisUv3HNVvvrxFkeBwqxK/iPjH+uIMbrgrvzHD
         ipag==
X-Gm-Message-State: AOAM531UEY6onMIGzzxDSsDs7s5+azHRvRczwzCEamylJDPDh9EXuUMS
        LkW6FjeL+F4lxeDh3r7PEa13pW1EDc4/QLKPAHDXYeXKDL1mNqMxUdxVypN033NlNXY/qfVTFg/
        5Jd8Fj618FRDrFLvwvj/vQhbJ
X-Received: by 2002:a1c:3584:: with SMTP id c126mr12431987wma.0.1634720713275;
        Wed, 20 Oct 2021 02:05:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzb0SLmpr2zs9xmS3aBX6A3P6t94cO4LjnC5oOjOpNdU5OcPtsA+jx7w/9mCsSb1aqlwe+faA==
X-Received: by 2002:a1c:3584:: with SMTP id c126mr12431952wma.0.1634720712999;
        Wed, 20 Oct 2021 02:05:12 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c63d4.dip0.t-ipconnect.de. [91.12.99.212])
        by smtp.gmail.com with ESMTPSA id c15sm1390559wrs.19.2021.10.20.02.05.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Oct 2021 02:05:12 -0700 (PDT)
Message-ID: <cbe8d847-8a2d-4220-c6a3-775d517e2edd@redhat.com>
Date:   Wed, 20 Oct 2021 11:05:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Content-Language: en-US
To:     Jianyong Wu <Jianyong.Wu@arm.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "mhiramat@kernel.org" <mhiramat@kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>
Cc:     "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "vbabka@suse.cz" <vbabka@suse.cz>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Anshuman Khandual <Anshuman.Khandual@arm.com>,
        Justin He <Justin.He@arm.com>, nd <nd@arm.com>
References: <20211020020712.90240-1-jianyong.wu@arm.com>
 <4858258b-8fb9-b060-8724-25c89ba2ce0e@redhat.com>
 <AM9PR08MB7276FEF0AE524A9728F63A4CF4BE9@AM9PR08MB7276.eurprd08.prod.outlook.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v1] init: avoid race condition of update page table in
 kernel init
In-Reply-To: <AM9PR08MB7276FEF0AE524A9728F63A4CF4BE9@AM9PR08MB7276.eurprd08.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> But why does it matter on arm64? Can you describe how the exact race
>> triggers?
> 
> I don't know much about how x86 does in memory map. Let me show you how the race happens on arm64.
> When virtio-mem workqueue is triggered, arch_memory_add will be called where the related page table will be created. The call chain is arch_memory_add->__create_pgd_mapping->alloc_init_pud. As the memory add may take for serval seconds, it may be concurrent with mark_rodata_ro, in which page tables are created either.

> The race can occur in alloc_init_pud. See below:
> /***************************************************************************/
> Virtio-mem workqueue thread                                                               mark_rodata_ro thread
> {                                                                                                                         
> ...
>         pudp = pud_set_fixmap_offset(p4dp, addr); // set fixmap
>         do {
>                 pud_t old_pud = READ_ONCE(*pudp);                                         
> ...
>         } while (pudp++, addr = next, addr != end);                                   pudp = pud_set_fixmap_offset;  //set fixmap                                
>         pud_clear_fixmap();  // clear fixmap                                              do {
> }                                                                                                                              pud_t old_pud = READ_ONCE(*pudp);//CRASH
> 

I still don't quite understand how that race can even exist. I assume
it's due to the weird semantics of the "fixmap". (whatever that is :) )
I don't see anything similar happen on other archs, especially x86-64
and s390x, which I'm familiar with.

s390x similarly to x86-64 code uses a vmem_mutex to serialize add/remove
in the direct map and a cpa_mutex to serialize attribute changes (and
splitting of large mappings).

The right should be to teach arm64 mmu code that direct mapping updates
might be concurrent, and that two instances might try messing with the
fixmap concurrently.


On a similar topic: I think we might want to reclaim compeltely empty
page tables when unplugging memory; I suspect that we also have to mess
with the fixmap then, whem removing page tables. But I feel like the
whole fixmap machinery is still a big black box for me.

-- 
Thanks,

David / dhildenb

