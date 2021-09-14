Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E88840B693
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 20:14:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231642AbhINSOy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 14:14:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:57672 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229869AbhINSOv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 14:14:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631643213;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YySJec8Y5cj/XTCgQeMbQDasJy1FDWvLFTbpcSw8zPo=;
        b=gZPUNJMVNDIGawqnU/1I1AUYuerIZXAS9s1eE6q8SKXKBHTcvJzQnj5uJO6+GxEJ9LiK/g
        vppeoqU1McDMnXREpF6156QQd4/mFRzGVhinLzB8J3xrwdQ4E5Cj+Gr3g/vVqQUcHeCroz
        X/7iDNMNGF6cuomTcMAFYcW4kZ0wUqU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-496-B8ni6GkjPp-gMX9kLDMQYw-1; Tue, 14 Sep 2021 14:13:31 -0400
X-MC-Unique: B8ni6GkjPp-gMX9kLDMQYw-1
Received: by mail-wm1-f71.google.com with SMTP id c2-20020a7bc8420000b0290238db573ab7so979685wml.5
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 11:13:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:to:cc:references:from:organization:subject
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=YySJec8Y5cj/XTCgQeMbQDasJy1FDWvLFTbpcSw8zPo=;
        b=IlECcjmi5kOEnLi7xb2n800hoHJF8GW75aTIWzG9RzkWKGwf84GDNF/y29Xb1b3FhE
         15h2X1IbxR0x+3ZGTKu3q1wCZ+SJ2m2TcujuDposWYBKO/EXDDH8c/70MZXGa5o6GTzN
         WI+I2wv7k1o8m+oXvA/lofr6RbtfXwVMjAIv31aW6ta/0kT/N9CctfBlY/UQj2z0NxNI
         yJe0Ssl/V0tpPrLziThG7hlDt5BnuA44nEv24Q6VONr9goX2HMwoQqqnAdxcBYQMWz83
         rPoUowm2ZT6YiEAF9FqQpj8OinEE1vbGHqqiuF3mvCkJQO3PvCx0d4sAtpc6lR3obCjv
         HB9A==
X-Gm-Message-State: AOAM532EoX/60Z7VW0U/wJ9f9DmlzI23MWNX+DrjJyQcXw/zhvK3bNj3
        D5U9Fx1tHOX2xPcHwqeqAAAzFOpVzKMmoKp3JB7I+x2CHLlKn0SQkcJFLW/1fOdTntpEzOVz6F2
        AKdY0Jm2yFqFBGIheYfuwF5GOwVwz5zf6nC1AGpYslOow4T2y9TEHZUA0auIdT1ico2BHhIqF
X-Received: by 2002:adf:f18a:: with SMTP id h10mr608671wro.42.1631643210693;
        Tue, 14 Sep 2021 11:13:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzXuSsvldGJZ2y/6wWeFKg2c8pciC4yAYkQ8E9oj79YWzMy6FRVZq0JOMa3+LrYgPDmO+KDiA==
X-Received: by 2002:adf:f18a:: with SMTP id h10mr608649wro.42.1631643210468;
        Tue, 14 Sep 2021 11:13:30 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c6041.dip0.t-ipconnect.de. [91.12.96.65])
        by smtp.gmail.com with ESMTPSA id z79sm512668wmc.17.2021.09.14.11.13.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Sep 2021 11:13:29 -0700 (PDT)
To:     Miaohe Lin <linmiaohe@huawei.com>, akpm@linux-foundation.org
Cc:     mhocko@suse.com, vbabka@suse.cz, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20210914114348.15569-1-linmiaohe@huawei.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v3] mm/page_isolation: fix potential missing call to
 unset_migratetype_isolate()
Message-ID: <454bd51f-d7ee-6304-af23-7c95874f8890@redhat.com>
Date:   Tue, 14 Sep 2021 20:13:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210914114348.15569-1-linmiaohe@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14.09.21 13:43, Miaohe Lin wrote:
> In start_isolate_page_range() undo path, pfn_to_online_page() just checks
> the first pfn in a pageblock while __first_valid_page() will traverse the
> pageblock until the first online pfn is found. So we may miss the call to
> unset_migratetype_isolate() in undo path and pages will remain isolated
> unexpectedly. Fix this by calling undo_isolate_page_range() and this will
> also help to simplify the code further. Note we shouldn't ever trigger it
> because MAX_ORDER-1 aligned pfn ranges shouldn't contain memory holes now.
> 
> Fixes: 2ce13640b3f4 ("mm: __first_valid_page skip over offline pages")
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>

I read Michals reply, however, I am quite conservative with Fixes: tags. 
If there is nothing to fix, there is no BUG and the patch consequently 
merely a cleanup.

I'd have gone with a patch description/subject as follows:

"
mm/page_isolation: cleanup start_isolate_page_range()

We can heavily simplify the code by reusing undo_isolate_page_range().

Note that this also tackles a theoretical issue that would have been a 
real BUG before commit c5e79ef561b0 ("mm/memory_hotplug.c: don't allow 
to online/offline memory blocks with holes"). In 
start_isolate_page_range() undo path, pfn_to_online_page() just checks
the first pfn in a pageblock while __first_valid_page() will traverse 
the pageblock until the first online pfn is found. So we may miss the 
call to unset_migratetype_isolate() in undo path and pages will remain 
isolated unexpectedly.

Nowadays, start_isolate_page_range() never gets called on ranges that 
might contain memory holes. Consequently, this patch is not a fix but a 
cleanup.
"

Anyhow, whatever the other people prefer, no strong opinion.

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

