Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82B0E45A9DC
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 18:20:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233945AbhKWRXR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 12:23:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:54100 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233831AbhKWRXQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 12:23:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637688007;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gyBGpLUvPbnKCHaCkFdWeDZn7pix4sCNzVoEgWtvK2c=;
        b=U6dYrGMzfj0ORPDwPlCDnzqkofJzXTLAL8fd89ty+hCDl2pdiHFBzxBaTechAuNZL66YA8
        E6INjn8cFt6HN3EulLBy6qdApNtFxtYTzwlLGrX8MFywnUwFmhLh0F5Nvp6hj22Ix5zc/y
        eteUouJMk5lBa3jl2ygbiIy/PQAsNlo=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-554-EUq8APL_OQyFGoggDi9biw-1; Tue, 23 Nov 2021 12:20:06 -0500
X-MC-Unique: EUq8APL_OQyFGoggDi9biw-1
Received: by mail-wm1-f69.google.com with SMTP id 144-20020a1c0496000000b003305ac0e03aso1520361wme.8
        for <linux-kernel@vger.kernel.org>; Tue, 23 Nov 2021 09:20:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=gyBGpLUvPbnKCHaCkFdWeDZn7pix4sCNzVoEgWtvK2c=;
        b=05IHTBw/dw3CnlaGfNQ50mdcvQC9FW4HHK3mhel/dbyz16YyjXRgYLxaSLarmyctv+
         9kx4WINbV0W/PJdhiEoBd/+vBceGAPbqP6S56I3qrK6iR04EzCTRSyNonRwJlt7zD2NH
         L4kdpM8UcHVU2c37ApvDtVhClcVRIKC5aY3vQyeinMRpuDg5jcKO8/LholBChPWCdv2z
         7cxy8Brg2B7O+25ESoZ2htLFyJdvbBlz6kYPBUocguyz9pwE0A+3DOzaNFZEimbwVGa7
         kFvu5fF2XGWjtnxZDXJMJaeNyYlsdXNNXi2aeRLijmlBmAQxza2KK92M6gw5+XogWGe0
         eaqA==
X-Gm-Message-State: AOAM530dlogHJBDDqYhV1hda7MoRXZzcQ1rLuD90ElBYvHrXoRk2AUHv
        lYx/4PmYI6sQzwx8wwYosaWWi6TqNQaGv+sH4G2MRhPRViEWYUOLe3kaM32QMC/LMFhL9Q+gKgv
        2cSsunPWu/TvGVYFGpfVxZIZJ
X-Received: by 2002:a05:600c:4ed2:: with SMTP id g18mr5030480wmq.18.1637688004937;
        Tue, 23 Nov 2021 09:20:04 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyHzPwJ2p5/WOOdzmc+nHTjlVc7DUIz4nCp0iyP/fABbjC15VZ1AabSMkgfpldQB/PZPWH65g==
X-Received: by 2002:a05:600c:4ed2:: with SMTP id g18mr5030451wmq.18.1637688004719;
        Tue, 23 Nov 2021 09:20:04 -0800 (PST)
Received: from [192.168.3.132] (p5b0c6765.dip0.t-ipconnect.de. [91.12.103.101])
        by smtp.gmail.com with ESMTPSA id s8sm13174651wra.9.2021.11.23.09.20.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Nov 2021 09:20:03 -0800 (PST)
Message-ID: <c61a6f30-ed62-7773-3371-981102f6804f@redhat.com>
Date:   Tue, 23 Nov 2021 18:20:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH] mm: split thp synchronously on MADV_DONTNEED
Content-Language: en-US
To:     Shakeel Butt <shakeelb@google.com>
Cc:     "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Yang Shi <shy828301@gmail.com>, Zi Yan <ziy@nvidia.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20211120201230.920082-1-shakeelb@google.com>
 <25b36a5c-5bbd-5423-0c67-05cd6c1432a7@redhat.com>
 <CALvZod5L1C1DV_DVs9O3xZm6CJnriunAoj89YLDdCp7ef5yBxA@mail.gmail.com>
 <1b30d06d-f9c0-1737-13e6-2d1a7d7b8507@redhat.com>
 <CALvZod5sFQbf3t_ZDW6ob+BqVtezn-c7i1UyOeev6Lwch96=7g@mail.gmail.com>
 <92fe0c31-b083-28c4-d306-da8a3cd891a3@redhat.com>
 <CALvZod4C1V6Gk96oMCMguaqChjggH0KH3KKcU1QOmjRG+QEAbQ@mail.gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <CALvZod4C1V6Gk96oMCMguaqChjggH0KH3KKcU1QOmjRG+QEAbQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23.11.21 18:17, Shakeel Butt wrote:
> On Tue, Nov 23, 2021 at 8:57 AM David Hildenbrand <david@redhat.com> wrote:
>>
> [...]
>>>>
>>>> I do wonder which these locking contexts are exactly, and if we could
>>>> also do the same thing on ordinary munmap -- because I assume it can be
>>>> similarly problematic for some applications.
>>>
>>> This is a good question regarding munmap. One main difference is
>>> munmap takes mmap_lock in write mode and usually performance critical
>>> applications avoid such operations.
>>
>> Maybe we can extend it too most page zapping, if that makes things simpler.
>>
> 
> Do you mean doing sync THP split for most of page zapping functions
> (but only if that makes things simpler)?
> 

Yes -- if there are no downsides.

-- 
Thanks,

David / dhildenb

