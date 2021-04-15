Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DE9B361141
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 19:41:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234188AbhDORlg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 13:41:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:51503 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233980AbhDORlf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 13:41:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618508471;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wTimRIr0YgBuVLpWvKPM6c0MAPH0f+KQspjahIIUAlU=;
        b=cPDV7WzTQ9rHwfUAQ/ac8bvWdvjyTkXGWriMaF++nEkSbJ+qL0n8Miec9j2pcwCP3jD+sH
        R6TckrEa6JX8ZyygS7AnxLHcSdnNw7s2A6J/GQ6S4KME/FKCJ9tWSLOBsC0ts8eb/9IbGh
        oJuCPBuWTEs8RtOWTWoY/1i4yja7kqQ=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-596-pxp1gya3MFWwH2GlIlJCMA-1; Thu, 15 Apr 2021 13:41:10 -0400
X-MC-Unique: pxp1gya3MFWwH2GlIlJCMA-1
Received: by mail-qt1-f199.google.com with SMTP id e6-20020ac85dc60000b029019d9cbbc077so4492900qtx.11
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 10:41:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=wTimRIr0YgBuVLpWvKPM6c0MAPH0f+KQspjahIIUAlU=;
        b=Ve7bkuUc5dERHWidVXG+3JYCKnFzBVCDj018pj5qXNlC3nlL8dr8thzmq1cQe2HeBm
         EopzT+s/XNAOfeAzahPlPs9PeM81CfLKWWzUDuMGhBg4GpEsU5Y/zEEgn9LAcKB9WQKI
         plb1i7slkyf51Rc15ZfV8+SkTGk3ZCjuHtBMIIr/kXoQYy24/Zkhu2a/e6Jdh6mb+w/G
         +KMw4HITbLfVooZf6eKpPX2n9RVzZryDx8/Evbg83ICkQ3Tcjm2j0k5peb/zjSBdI+Nw
         G7AZ8mIwgKyT8SeCwQm5Fi/w7q1txzlz02nCe7u40mVq/fqycbP/ZC+8jXL6nQjtLQAu
         9bqA==
X-Gm-Message-State: AOAM531VeJbEISWjJ6sl4XW7vC9SHDxXfZA0HwT6k03aPlBGkmc1qrOH
        wl9eti5C1fV59dz0zLgg9mzv/m7LugYUXXcvAHppUcSUUeeRplBvBJ6fRG6y59fTWCFxUGIyUio
        L4DcYc7V5kLnpsmvnENiLJ1Sy
X-Received: by 2002:a37:7c5:: with SMTP id 188mr4791832qkh.348.1618508469965;
        Thu, 15 Apr 2021 10:41:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzmgbFnszT76GybNyzgAt7zTaWK3t49+b+KRVvGIM0rKdDofO0Sm6ySwTeX6EQ7djs0OMFxww==
X-Received: by 2002:a37:7c5:: with SMTP id 188mr4791794qkh.348.1618508469626;
        Thu, 15 Apr 2021 10:41:09 -0700 (PDT)
Received: from llong.remote.csb ([2601:191:8500:76c0::cdbc])
        by smtp.gmail.com with ESMTPSA id x18sm2247420qtj.58.2021.04.15.10.41.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Apr 2021 10:41:09 -0700 (PDT)
From:   Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Subject: Re: [PATCH v3 0/5] mm/memcg: Reduce kmemcache memory accounting
 overhead
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vlastimil Babka <vbabka@suse.cz>, Roman Gushchin <guro@fb.com>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, Shakeel Butt <shakeelb@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        Chris Down <chris@chrisdown.name>,
        Yafang Shao <laoar.shao@gmail.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        Masayoshi Mizuma <msys.mizuma@gmail.com>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>
References: <20210414012027.5352-1-longman@redhat.com>
 <20210415171035.GB2531743@casper.infradead.org>
Message-ID: <15cf3cfa-c221-9e84-9f5b-80082207efd3@redhat.com>
Date:   Thu, 15 Apr 2021 13:41:07 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210415171035.GB2531743@casper.infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/15/21 1:10 PM, Matthew Wilcox wrote:
> On Tue, Apr 13, 2021 at 09:20:22PM -0400, Waiman Long wrote:
>> With memory accounting disable, the run time was 2.848s. With memory
>> accounting enabled, the run times with the application of various
>> patches in the patchset were:
>>
>>    Applied patches   Run time   Accounting overhead   Overhead %age
>>    ---------------   --------   -------------------   -------------
>>         None          10.800s         7.952s              100.0%
>>          1-2           9.140s         6.292s               79.1%
>>          1-3           7.641s         4.793s               60.3%
>>          1-5           6.801s         3.953s               49.7%
> I think this is a misleading way to report the overhead.  I would have said:
>
> 			10.800s		7.952s		279.2%
> 			 9.140s		6.292s		220.9%
> 			 7.641s		4.793s		168.3%
> 			 6.801s		3.953s		138.8%
>
What I want to emphasize is the reduction in the accounting overhead 
part of execution time. Your percentage used the accounting disable time 
as the denominator. I think both are valid, I will be more clear about 
that in my version of the patch.

Thanks,
Longman

