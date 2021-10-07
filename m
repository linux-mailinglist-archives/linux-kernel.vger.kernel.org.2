Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C251B424E11
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 09:27:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240311AbhJGH3n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 03:29:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:38880 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232512AbhJGH3h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 03:29:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633591664;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ry165nxVbeeGg5gTu6DIc5396l+Gq9PRR2heRwKdlqs=;
        b=F2J6UvJkfj+oqG5/Uwe1EC5RPoE4uYjF7uxgzlZzSDBrl21o2Gtp5meJQ/fqeaeqDy34eL
        /iiOAUUD81j1HeKTcEkb/FtExz7et7GPHvH9L6AVlcX7oG+wPsrQhWvryh2ZOidBSfKsw6
        6F22n8LRnZ+vYeDJqnikzWxt9q/rajE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-254-MGFEo8tlPN63Cfo_A6El0w-1; Thu, 07 Oct 2021 03:27:43 -0400
X-MC-Unique: MGFEo8tlPN63Cfo_A6El0w-1
Received: by mail-wr1-f72.google.com with SMTP id p12-20020adfc38c000000b00160d6a7e293so1444491wrf.18
        for <linux-kernel@vger.kernel.org>; Thu, 07 Oct 2021 00:27:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=Ry165nxVbeeGg5gTu6DIc5396l+Gq9PRR2heRwKdlqs=;
        b=zDNqU1aQg8zk3QJ0tvxRGv/amTKM2va7s03/25zQnSDCmvwZeVGxfUmjGeLEoflhnQ
         IIrbgePkNj6mqI6/vV+A5FT8ti6vs75KsMRK78mwsMPlD/YFrRET1nQ99dfCZHXBLlGo
         JuckfqP51dNmCO57yZzbG11oa5YPQHfyiq6Kbe/HKWyPC/VgNaC/MMOJesYlLs2J/jlW
         NigZSnXINVRHL15s6ellrCELirqAj2hNo2alGc21eymb520JCaCToWSRxHCfN7Ld552F
         elwT/dWNXhC7qcTTSzIjSiYYzZ0L+pavKGK9wGZoB1RQvVPfAk7/8uhcMNGEcTakW1y2
         WyEA==
X-Gm-Message-State: AOAM532oyrLO2iAKsZk2TbxwzgbAHi09tXdhFUNNo0w11YlXOVc1xRdr
        U/1SxGAO7y6STfX0F80s0TeMzMDMss6V2cDyaHXtun7fzW156uxxycgbPtDoVwRfdVNjrAOWdhv
        OfXfhaJ+CKbvF2RYGmIFosq+F
X-Received: by 2002:a7b:cc88:: with SMTP id p8mr2933848wma.101.1633591662024;
        Thu, 07 Oct 2021 00:27:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyfPPQ0UhVVfB2g4Qm80BYGgXuhoWg2b+qdl06xZYcuNFTPFP6YKFU3oUjgAf+DGohOTWKv8Q==
X-Received: by 2002:a7b:cc88:: with SMTP id p8mr2933796wma.101.1633591661824;
        Thu, 07 Oct 2021 00:27:41 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c6886.dip0.t-ipconnect.de. [91.12.104.134])
        by smtp.gmail.com with ESMTPSA id s14sm949540wro.76.2021.10.07.00.27.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Oct 2021 00:27:41 -0700 (PDT)
Subject: Re: [PATCH v10 3/3] mm: add anonymous vma name refcounting
To:     Suren Baghdasaryan <surenb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Michal Hocko <mhocko@suse.com>, John Hubbard <jhubbard@nvidia.com>,
        Pavel Machek <pavel@ucw.cz>, Colin Cross <ccross@google.com>,
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
        Chinwen Chang <chinwen.chang@mediatek.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Jann Horn <jannh@google.com>, apopple@nvidia.com,
        Yu Zhao <yuzhao@google.com>, Will Deacon <will@kernel.org>,
        fenghua.yu@intel.com, thunder.leizhen@huawei.com,
        Hugh Dickins <hughd@google.com>, feng.tang@intel.com,
        Jason Gunthorpe <jgg@ziepe.ca>, Roman Gushchin <guro@fb.com>,
        Thomas Gleixner <tglx@linutronix.de>, krisman@collabora.com,
        Chris Hyser <chris.hyser@oracle.com>,
        Peter Collingbourne <pcc@google.com>,
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
        kernel-team <kernel-team@android.com>,
        Tim Murray <timmurray@google.com>
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
 <192438ab-a095-d441-6843-432fbbb8e38a@redhat.com>
 <CAJuCfpH4KT=fOAWsYhaAb_LLg-VwPvL4Bmv32NYuUtZ3Ceo+PA@mail.gmail.com>
 <20211006192927.f7a735f1afe4182bf4693838@linux-foundation.org>
 <CAJuCfpGLQK5aVe5zQfdkP=K4NBZXPjtG=ycjk3E4D64CAvVPsg@mail.gmail.com>
 <20211006195342.0503b3a3cbcd2c3c3417df46@linux-foundation.org>
 <CAJuCfpEZzrN+V2g4+RsRs5v3e60RGvXOCk_X9e3wWkeMBZProg@mail.gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <3645f74d-54b4-9223-1d53-75cade471fad@redhat.com>
Date:   Thu, 7 Oct 2021 09:27:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAJuCfpEZzrN+V2g4+RsRs5v3e60RGvXOCk_X9e3wWkeMBZProg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07.10.21 05:01, Suren Baghdasaryan wrote:
> On Wed, Oct 6, 2021 at 7:53 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>>
>> On Wed, 6 Oct 2021 19:46:57 -0700 Suren Baghdasaryan <surenb@google.com> wrote:
>>
>>>>>>> I wish it was that simple and for some names like [anon:.bss] or
>>>>>>> [anon:dalvik-zygote space] reserving a unique id would work, however
>>>>>>> some names like [anon:dalvik-/system/framework/boot-core-icu4j.art]
>>>>>>> are generated dynamically at runtime and include package name.
>>>>>>
>>>>>> Valuable information
>>>>>
>>>>> Yeah, I should have described it clearer the first time around.
>>>>
>>>> If it gets this fancy then the 80 char limit is likely to become a
>>>> significant limitation and the choice should be explained & justified.
>>>>
>>>> Why not 97?  1034?  Why not just strndup_user() and be done with it?
>>>
>>> The original patch from 8 years ago used 256 as the limit but Rasmus
>>> argued that the string content should be human-readable, so 80 chars
>>> seems to be a reasonable limit (see:
>>> https://lore.kernel.org/all/d8619a98-2380-ca96-001e-60fe9c6204a6@rasmusvillemoes.dk),
>>> which makes sense to me. We should be able to handle the 80 char limit
>>> by trimming it before calling prctl().
>>
>> What's the downside to making it unlimited?
> 
> If we ignore the human-readability argument, I guess the possibility
> of abuse and increased memory consumption? I'm guessing parsing such a
> string is also easier if there is a known limit?

64k * 80 bytes already makes me nervous enough :)


-- 
Thanks,

David / dhildenb

