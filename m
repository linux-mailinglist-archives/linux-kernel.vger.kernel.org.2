Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DE9241F946
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Oct 2021 03:54:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232373AbhJBB4F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Oct 2021 21:56:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:31414 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232329AbhJBB4E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Oct 2021 21:56:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633139659;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=O0xoezi4Z/qOe9rLHxMxM8UOrRHkvWYCakknTRmKZYE=;
        b=L4OzxGCMpLspgfnkHdx/rKaUYqyDQLMoFZfS7wTquXSiK7k6Fz6Ttz9Olbgs9JH4+P6rXf
        kCvXVL5/ylpP2WL7YfqfwkzB5GM1m0p7/P38qf1Z7SFe0muyCsbZWQ0DcSVO7W4HXdN1oD
        AXoEC3Af8b6zrzej85x7SsvW/34S1Tk=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-204-SUgU2uxxPIafOpTM5w6qMw-1; Fri, 01 Oct 2021 21:54:16 -0400
X-MC-Unique: SUgU2uxxPIafOpTM5w6qMw-1
Received: by mail-qk1-f200.google.com with SMTP id az37-20020a05620a172500b0045e43348ee8so18239797qkb.19
        for <linux-kernel@vger.kernel.org>; Fri, 01 Oct 2021 18:54:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=O0xoezi4Z/qOe9rLHxMxM8UOrRHkvWYCakknTRmKZYE=;
        b=EtrkdXuy/+882XPabfNr3t8zt0j7jqP5aaJ7C+1BLka3cf/AmJwibbMGQAmLEEeyMp
         HGLC8+ltaYZ8VU2Y0z4DXX9YpavUwwi9p0P5IwpuBIu47j/P1wJp8jkQGQeyz45spOlx
         ndj5CeCFxNZIFxKoaJl4JQPfsMlC07DjJVdz6DBNLOE9BWOi/If4gSZlbAGJAvFYbUsw
         OA7tWEqqahZQIKeJjGtLeMSPj7pB1HAajf/VNpcdggNr8GT9DnrF0trkkrPcGI3JKH+c
         izyTajxPhMS0YmGS+Ua3K4ry/3uWMvxn1PXrVe1x6/O6CuydJFdm0DYxp0poDB2r3cnq
         aFeA==
X-Gm-Message-State: AOAM531K4h3WpgwNIBrf+uyYB8xOBhlHE82O5iuHl5c9Ag1F3nwkM9Hu
        Wrmd6ga1iGIFrviQ+nWRGWUtBukU4RcUkqqQ1PapHvRIK2/5YZe2wJOBI5xf9ds7rv1b9NGc/W0
        RPlc+UVWjb16hihspOq6Ehcd7
X-Received: by 2002:a0c:f094:: with SMTP id g20mr12055315qvk.55.1633139656507;
        Fri, 01 Oct 2021 18:54:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJypmZTsFfQss8HzuioAd9a68ABkXlfCgwp7JFvKvJhWuAFJ3fhhyjrAnxkHYQyoxyzrSDDJJA==
X-Received: by 2002:a0c:f094:: with SMTP id g20mr12055294qvk.55.1633139656287;
        Fri, 01 Oct 2021 18:54:16 -0700 (PDT)
Received: from llong.remote.csb ([2601:191:8500:76c0::cdbc])
        by smtp.gmail.com with ESMTPSA id v7sm3966408qkd.41.2021.10.01.18.54.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Oct 2021 18:54:16 -0700 (PDT)
From:   Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Subject: Re: [PATCH 1/3] mm, memcg: Don't put offlined memcg into local stock
To:     Roman Gushchin <guro@fb.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <songmuchun@bytedance.com>
References: <20211001190938.14050-1-longman@redhat.com>
 <20211001190938.14050-2-longman@redhat.com>
 <YVefHLo1+6lgw3aB@carbon.dhcp.thefacebook.com>
Message-ID: <6296d44d-a728-973a-0fc3-b5e30a09f920@redhat.com>
Date:   Fri, 1 Oct 2021 21:54:14 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YVefHLo1+6lgw3aB@carbon.dhcp.thefacebook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/1/21 7:51 PM, Roman Gushchin wrote:
> On Fri, Oct 01, 2021 at 03:09:36PM -0400, Waiman Long wrote:
>> When freeing a page associated with an offlined memcg, refill_stock()
>> will put it into local stock delaying its demise until another memcg
>> comes in to take its place in the stock. To avoid that, we now check
>> for offlined memcg and go directly in this case to the slowpath for
>> the uncharge via the repurposed cancel_charge() function.
> Hi Waiman!
>
> I'm afraid it can make a cleanup of a dying cgroup slower: for every
> released page we'll potentially traverse the whole cgroup tree and
> decrease atomic page counters.
>
> I'm not sure I understand the benefits we get from this change which
> do justify the slowdown on the cleanup path.

I am debugging a problem where some dying memcgs somehow stay around for 
a long time leading to gradual increase in memory consumption over time. 
I see the per-cpu stock as one of the places where a reference to a 
dying memcg may be present. Anyway, I agree that it may not help much. I 
am going to drop it if you think it is not a good idea.

Cheers,
Longman

