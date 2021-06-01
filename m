Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78039396F22
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 10:40:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233538AbhFAIlz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 04:41:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:39454 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233422AbhFAIly (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 04:41:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622536813;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=orggq5Gy6cLIvI6QaVbtYLOKf6hGIlVuBDklnjNDuX8=;
        b=e5e56xh12jff5QsnYV+0fgIz8sEcnOS+XOeZuHyf8aQXn9JI1P4Ae1f3F7GjAze8ZkzdUP
        /JbCZtRJkb6JMojOE8J2DxxN9vZe03KsDn2Zm79lKHlGRlq1XQIZ55mCEJs3f5sE1gwWPK
        2I98Y6ox7Vn1i4D/lxIwSz9m+K6vCiI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-181-7xPXUB7WPTeUoZCOwUNCtw-1; Tue, 01 Jun 2021 04:40:11 -0400
X-MC-Unique: 7xPXUB7WPTeUoZCOwUNCtw-1
Received: by mail-wm1-f70.google.com with SMTP id o10-20020a05600c4fcab029014ae7fdec90so1034887wmq.5
        for <linux-kernel@vger.kernel.org>; Tue, 01 Jun 2021 01:40:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=orggq5Gy6cLIvI6QaVbtYLOKf6hGIlVuBDklnjNDuX8=;
        b=BkDEulSeIL7W4/UaT2iTkDQvRA9S9JdA5Z8nOsknrHm86Xihgbo8mUGE7obSnVAqhA
         TWwxQh1WKACD9ohAzmAZKgj5AFgWd8+nSVtRzFUjy9zgz4NVX6m5CGep0LecCW5p+SB5
         +RpAKTDWUwbJnxbcLWFZp+zZ7y0atqt8wtPQxOpX436Bil4pYH60QAa94LzZuOjsNM9D
         tKBh8tPQVmvFjUpHHWgb5a0wJskcJSIQillC4FcNxLvrnAUWMTMxRJZqKMeBganyQr6z
         KMoLzxD2gedZHAE6lZPxyfrqhQjUCxJU7uYZiS2KpvggBOcsiNmb/cfiO+FY/ImYGYQg
         N8Jw==
X-Gm-Message-State: AOAM530VFuSCREAFHSFcNkFZrf5FobgspVkvjUiYNNpEQFabmOqfyQXH
        NnINbaDj++IL2bV6Q7i1oBPRqxtWR0xFvRfDfrb0iCAxYIEnrgMeTXvEnGBUfwoCKrb1xPWjFbq
        Q/SZV/UK1qBRuJnes6eV/Fp6N
X-Received: by 2002:a7b:c853:: with SMTP id c19mr1553846wml.30.1622536810710;
        Tue, 01 Jun 2021 01:40:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzHvS79qiWpZALH1UTCyvER4EOmT/aHQbvBAY4l/D1wFtVDHVnQ9kGs4uaINGcI2cmCAywdVA==
X-Received: by 2002:a7b:c853:: with SMTP id c19mr1553832wml.30.1622536810562;
        Tue, 01 Jun 2021 01:40:10 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c69ce.dip0.t-ipconnect.de. [91.12.105.206])
        by smtp.gmail.com with ESMTPSA id j131sm1893886wma.40.2021.06.01.01.40.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Jun 2021 01:40:10 -0700 (PDT)
Subject: Re: [PATCH V2 4/6] mm: rename the global section array to
 mem_sections
To:     Dong Aisheng <dongas86@gmail.com>
Cc:     Dong Aisheng <aisheng.dong@nxp.com>, linux-mm@kvack.org,
        open list <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Young <dyoung@redhat.com>, Baoquan He <bhe@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>, kexec@lists.infradead.org
References: <20210531091908.1738465-1-aisheng.dong@nxp.com>
 <20210531091908.1738465-5-aisheng.dong@nxp.com>
 <42617372-c846-85fe-4739-abbe55eca8f6@redhat.com>
 <CAA+hA=Ss4j8qeoe7RtDJ14nuqy+TpOk2qi-A9+YN6=2y8c_CGg@mail.gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <f7f77368-72cf-e15d-cc3c-b0ddf86e14fd@redhat.com>
Date:   Tue, 1 Jun 2021 10:40:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <CAA+hA=Ss4j8qeoe7RtDJ14nuqy+TpOk2qi-A9+YN6=2y8c_CGg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01.06.21 10:37, Dong Aisheng wrote:
> On Tue, Jun 1, 2021 at 4:22 PM David Hildenbrand <david@redhat.com> wrote:
>>
>> On 31.05.21 11:19, Dong Aisheng wrote:
>>> In order to distinguish the struct mem_section for a better code
>>> readability and align with kernel doc [1] name below, change the
>>> global mem section name to 'mem_sections' from 'mem_section'.
>>>
>>> [1] Documentation/vm/memory-model.rst
>>> "The `mem_section` objects are arranged in a two-dimensional array
>>> called `mem_sections`."
>>>
>>> Cc: Andrew Morton <akpm@linux-foundation.org>
>>> Cc: Dave Young <dyoung@redhat.com>
>>> Cc: Baoquan He <bhe@redhat.com>
>>> Cc: Vivek Goyal <vgoyal@redhat.com>
>>> Cc: kexec@lists.infradead.org
>>> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
>>> ---
>>> v1->v2:
>>>    * no changes
>>> ---
>>>    include/linux/mmzone.h | 10 +++++-----
>>>    kernel/crash_core.c    |  4 ++--
>>>    mm/sparse.c            | 16 ++++++++--------
>>>    3 files changed, 15 insertions(+), 15 deletions(-)
>>>
>>> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
>>> index a6bfde85ddb0..0ed61f32d898 100644
>>> --- a/include/linux/mmzone.h
>>> +++ b/include/linux/mmzone.h
>>> @@ -1302,9 +1302,9 @@ struct mem_section {
>>>    #define SECTION_ROOT_MASK   (SECTIONS_PER_ROOT - 1)
>>>
>>>    #ifdef CONFIG_SPARSEMEM_EXTREME
>>> -extern struct mem_section **mem_section;
>>> +extern struct mem_section **mem_sections;
>>>    #else
>>> -extern struct mem_section mem_section[NR_SECTION_ROOTS][SECTIONS_PER_ROOT];
>>> +extern struct mem_section mem_sections[NR_SECTION_ROOTS][SECTIONS_PER_ROOT];
>>>    #endif
>>>
>>>    static inline unsigned long *section_to_usemap(struct mem_section *ms)
>>> @@ -1315,12 +1315,12 @@ static inline unsigned long *section_to_usemap(struct mem_section *ms)
>>>    static inline struct mem_section *__nr_to_section(unsigned long nr)
>>>    {
>>>    #ifdef CONFIG_SPARSEMEM_EXTREME
>>> -     if (!mem_section)
>>> +     if (!mem_sections)
>>>                return NULL;
>>>    #endif
>>> -     if (!mem_section[SECTION_NR_TO_ROOT(nr)])
>>> +     if (!mem_sections[SECTION_NR_TO_ROOT(nr)])
>>>                return NULL;
>>> -     return &mem_section[SECTION_NR_TO_ROOT(nr)][nr & SECTION_ROOT_MASK];
>>> +     return &mem_sections[SECTION_NR_TO_ROOT(nr)][nr & SECTION_ROOT_MASK];
>>>    }
>>>    extern unsigned long __section_nr(struct mem_section *ms);
>>>    extern size_t mem_section_usage_size(void);
>>> diff --git a/kernel/crash_core.c b/kernel/crash_core.c
>>> index 29cc15398ee4..fb1180d81b5a 100644
>>> --- a/kernel/crash_core.c
>>> +++ b/kernel/crash_core.c
>>> @@ -414,8 +414,8 @@ static int __init crash_save_vmcoreinfo_init(void)
>>>        VMCOREINFO_SYMBOL(contig_page_data);
>>>    #endif
>>>    #ifdef CONFIG_SPARSEMEM
>>> -     VMCOREINFO_SYMBOL_ARRAY(mem_section);
>>> -     VMCOREINFO_LENGTH(mem_section, NR_SECTION_ROOTS);
>>> +     VMCOREINFO_SYMBOL_ARRAY(mem_sections);
>>> +     VMCOREINFO_LENGTH(mem_sections, NR_SECTION_ROOTS);
>>>        VMCOREINFO_STRUCT_SIZE(mem_section);
>>>        VMCOREINFO_OFFSET(mem_section, section_mem_map);
>>>        VMCOREINFO_NUMBER(MAX_PHYSMEM_BITS);
>>> diff --git a/mm/sparse.c b/mm/sparse.c
>>> index d02ee6bb7cbc..6412010478f7 100644
>>> --- a/mm/sparse.c
>>> +++ b/mm/sparse.c
>>> @@ -24,12 +24,12 @@
>>>     * 1) mem_section   - memory sections, mem_map's for valid memory
>>>     */
>>>    #ifdef CONFIG_SPARSEMEM_EXTREME
>>> -struct mem_section **mem_section;
>>> +struct mem_section **mem_sections;
>>>    #else
>>> -struct mem_section mem_section[NR_SECTION_ROOTS][SECTIONS_PER_ROOT]
>>> +struct mem_section mem_sections[NR_SECTION_ROOTS][SECTIONS_PER_ROOT]
>>>        ____cacheline_internodealigned_in_smp;
>>>    #endif
>>> -EXPORT_SYMBOL(mem_section);
>>> +EXPORT_SYMBOL(mem_sections);
>>>
>>>    #ifdef NODE_NOT_IN_PAGE_FLAGS
>>>    /*
>>> @@ -66,8 +66,8 @@ static void __init sparse_alloc_section_roots(void)
>>>
>>>        size = sizeof(struct mem_section *) * NR_SECTION_ROOTS;
>>>        align = 1 << (INTERNODE_CACHE_SHIFT);
>>> -     mem_section = memblock_alloc(size, align);
>>> -     if (!mem_section)
>>> +     mem_sections = memblock_alloc(size, align);
>>> +     if (!mem_sections)
>>>                panic("%s: Failed to allocate %lu bytes align=0x%lx\n",
>>>                      __func__, size, align);
>>>    }
>>> @@ -103,14 +103,14 @@ static int __meminit sparse_index_init(unsigned long section_nr, int nid)
>>>         *
>>>         * The mem_hotplug_lock resolves the apparent race below.
>>>         */
>>> -     if (mem_section[root])
>>> +     if (mem_sections[root])
>>>                return 0;
>>>
>>>        section = sparse_index_alloc(nid);
>>>        if (!section)
>>>                return -ENOMEM;
>>>
>>> -     mem_section[root] = section;
>>> +     mem_sections[root] = section;
>>>
>>>        return 0;
>>>    }
>>> @@ -145,7 +145,7 @@ unsigned long __section_nr(struct mem_section *ms)
>>>    #else
>>>    unsigned long __section_nr(struct mem_section *ms)
>>>    {
>>> -     return (unsigned long)(ms - mem_section[0]);
>>> +     return (unsigned long)(ms - mem_sections[0]);
>>>    }
>>>    #endif
>>>
>>>
>>
>> I repeat: unnecessary code churn IMHO.
> 
> Hi David,
> 
> Thanks, i explained the reason during my last reply.
> Andrew has already picked this patch to -mm tree.

Just because it's in Andrews tree doesn't mean it will end up upstream. ;)

Anyhow, no really strong opinion, it's simply unnecessary code churn 
that makes bisecting harder without real value IMHO.

-- 
Thanks,

David / dhildenb

