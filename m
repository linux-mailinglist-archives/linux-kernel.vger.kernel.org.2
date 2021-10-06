Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EF244240DC
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 17:08:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239173AbhJFPJ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 11:09:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:26944 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238440AbhJFPJy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 11:09:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633532880;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iml3pNlbn9tn2FywzhER1zlHgKoPS0AbJRacW4jzMgU=;
        b=BYnKwWw+ErSe7dbeP1y/OpWJRWVNHdJzKmxHo9oS/tHdHJ5TJPME+eq2Zl+RXybmUd54Fm
        Dx0BeW/GnpcaEGszxibF4/SVodgSTzupsL2fh+YzW+0YDJeJCANYgwvCZHYvrujN1JsVZ5
        cKpAwWFh9lmg227NLt6WsRu7rgCwwf8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-331-XoskuDgsPJSbdDFoyO8Fmg-1; Wed, 06 Oct 2021 11:07:59 -0400
X-MC-Unique: XoskuDgsPJSbdDFoyO8Fmg-1
Received: by mail-wr1-f72.google.com with SMTP id r16-20020adfb1d0000000b00160bf8972ceso2300274wra.13
        for <linux-kernel@vger.kernel.org>; Wed, 06 Oct 2021 08:07:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:to:cc:references:from:organization:subject
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=iml3pNlbn9tn2FywzhER1zlHgKoPS0AbJRacW4jzMgU=;
        b=DeJSFBXlLBWoY1JeTaj5nRG/FGY3bgdIMx9ScbOAjUR4T1sx5y+wYJyW5Ll2LVCrLl
         yhR5LCbKKIv9kEkf5QLzRbGr98FeqUlLDubqLXL8VigWjdV8GseVNvFF76q34GqK51ND
         af7er/dXhYHrC0+hVbJqmhpw8ifFyjmFy9Th5sn1iRLn6n/Ht3QJFfidsCd8I+zm4BXa
         3u6Q5VyFY1VE8tyB+BFEngcqcEXANaR3wwT3xId2zwGg5tluFyBKpSf+HafYFzEAvlMx
         3Jza8Wti9ie6N3ok2RrGfBETNUrE7vk+e1YYpIU7OMTpz0rVbv60W363ama1bEVGAr4H
         EQNw==
X-Gm-Message-State: AOAM531ZzAxibaHjSGrk8Tm3e1HqW3jxZbZ+oN7eUqOB5AR5XjIk/MO2
        DP8+g74WbIiCIq8mVdQ+ebfs3N5Uchet/xddhyrkTvNXHjekNPcMiEOrKgbCsUCxDS3A3zcrAv/
        VlMYVtMNNZgOSPFrfhXl3OWgB
X-Received: by 2002:a05:600c:4fc6:: with SMTP id o6mr10488632wmq.147.1633532878744;
        Wed, 06 Oct 2021 08:07:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzIy7edjiF6tYBwyhRpW4cHms5SJrrTE90lW3+gTLtxOFwCuTMHSR1zVPnDBv3OjX9leQiDZw==
X-Received: by 2002:a05:600c:4fc6:: with SMTP id o6mr10488572wmq.147.1633532878499;
        Wed, 06 Oct 2021 08:07:58 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c6529.dip0.t-ipconnect.de. [91.12.101.41])
        by smtp.gmail.com with ESMTPSA id w11sm2259159wmc.44.2021.10.06.08.07.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Oct 2021 08:07:58 -0700 (PDT)
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     Michal Hocko <mhocko@suse.com>, John Hubbard <jhubbard@nvidia.com>,
        Pavel Machek <pavel@ucw.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Colin Cross <ccross@google.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Randy Dunlap <rdunlap@infradead.org>,
        Kalesh Singh <kaleshsingh@google.com>,
        Peter Xu <peterx@redhat.com>, rppt@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        vincenzo.frascino@arm.com,
        =?UTF-8?B?Q2hpbndlbiBDaGFuZyAo5by16Yym5paHKQ==?= 
        <chinwen.chang@mediatek.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Jann Horn <jannh@google.com>, apopple@nvidia.com,
        Yu Zhao <yuzhao@google.com>, Will Deacon <will@kernel.org>,
        fenghua.yu@intel.com, thunder.leizhen@huawei.com,
        Hugh Dickins <hughd@google.com>, feng.tang@intel.com,
        Jason Gunthorpe <jgg@ziepe.ca>, Roman Gushchin <guro@fb.com>,
        Thomas Gleixner <tglx@linutronix.de>, krisman@collabora.com,
        chris.hyser@oracle.com, Peter Collingbourne <pcc@google.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Jens Axboe <axboe@kernel.dk>, legion@kernel.org,
        Rolf Eike Beer <eb@emlix.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Thomas Cedeno <thomascedeno@google.com>, sashal@kernel.org,
        cxfcosmos@gmail.com, Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-mm <linux-mm@kvack.org>,
        kernel-team <kernel-team@android.com>
References: <20211001205657.815551-1-surenb@google.com>
 <20211001205657.815551-3-surenb@google.com>
 <20211005184211.GA19804@duo.ucw.cz>
 <CAJuCfpE5JEThTMhwKPUREfSE1GYcTx4YSLoVhAH97fJH_qR0Zg@mail.gmail.com>
 <20211005200411.GB19804@duo.ucw.cz>
 <CAJuCfpFZkz2c0ZWeqzOAx8KFqk1ge3K-SiCMeu3dmi6B7bK-9w@mail.gmail.com>
 <efdffa68-d790-72e4-e6a3-80f2e194d811@nvidia.com>
 <YV1eCu0eZ+gQADNx@dhcp22.suse.cz>
 <6b15c682-72eb-724d-bc43-36ae6b79b91a@redhat.com>
 <CAJuCfpEPBM6ehQXgzp=g4SqtY6iaC8wuZ-CRE81oR1VOq7m4CA@mail.gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v10 3/3] mm: add anonymous vma name refcounting
Message-ID: <192438ab-a095-d441-6843-432fbbb8e38a@redhat.com>
Date:   Wed, 6 Oct 2021 17:07:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAJuCfpEPBM6ehQXgzp=g4SqtY6iaC8wuZ-CRE81oR1VOq7m4CA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06.10.21 17:01, Suren Baghdasaryan wrote:
> On Wed, Oct 6, 2021 at 2:27 AM David Hildenbrand <david@redhat.com> wrote:
>>
>> On 06.10.21 10:27, Michal Hocko wrote:
>>> On Tue 05-10-21 23:57:36, John Hubbard wrote:
>>> [...]
>>>> 1) Yes, just leave the strings in the kernel, that's simple and
>>>> it works, and the alternatives don't really help your case nearly
>>>> enough.
>>>
>>> I do not have a strong opinion. Strings are easier to use but they
>>> are more involved and the necessity of kref approach just underlines
>>> that. There are going to be new allocations and that always can lead
>>> to surprising side effects.  These are small (80B at maximum) so the
>>> overall footpring shouldn't all that large by default but it can grow
>>> quite large with a very high max_map_count. There are workloads which
>>> really require the default to be set high (e.g. heavy mremap users). So
>>> if anything all those should be __GFP_ACCOUNT and memcg accounted.
>>>
>>> I do agree that numbers are just much more simpler from accounting,
>>> performance and implementation POV.
>>
>> +1
>>
>> I can understand that having a string can be quite beneficial e.g., when
>> dumping mmaps. If only user space knows the id <-> string mapping, that
>> can be quite tricky.
>>
>> However, I also do wonder if there would be a way to standardize/reserve
>> ids, such that a given id always corresponds to a specific user. If we
>> use an uint64_t for an id, there would be plenty room to reserve ids ...
>>
>> I'd really prefer if we can avoid using strings and instead using ids.
> 
> I wish it was that simple and for some names like [anon:.bss] or
> [anon:dalvik-zygote space] reserving a unique id would work, however
> some names like [anon:dalvik-/system/framework/boot-core-icu4j.art]
> are generated dynamically at runtime and include package name.

Valuable information

> Packages are constantly evolving, new ones are developed, names can
> change, etc. So assigning a unique id for these names is not really
> feasible.

So, you'd actually want to generate/reserve an id for a given string at 
runtime, assign that id to the VMA, and have a way to match id <-> 
string somehow?

That reservation service could be inside the kernel or even (better?) in 
user space. The service could for example de-duplicates strings.

My question would be, if we really have to expose these strings to the 
kernel, or if an id is sufficient. Sure, it would move complexity to 
user space, but keeping complexity out of the kernel is usually a good idea.

-- 
Thanks,

David / dhildenb

