Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31E7135E394
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 18:14:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236635AbhDMQOu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 12:14:50 -0400
Received: from mail-oi1-f177.google.com ([209.85.167.177]:37540 "EHLO
        mail-oi1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231778AbhDMQOs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 12:14:48 -0400
Received: by mail-oi1-f177.google.com with SMTP id k25so17533331oic.4
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 09:14:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=UG+HWfno+uWNfzLfwmGXq7s847iNKJuTbNirN6mdLfo=;
        b=1b47Bs77Ch+fhFL/ZEz44NahmwXjxSeO5CxWr6+L3MldidicVQJ945Sw6r4qp8JLXP
         0vK//RvqD+6D7nAbbuoAvEQPNpTlegBotGkt+IhXLtJ9Uxb7e+Kq532uWp/lDF/sr0BV
         hoU3JgtIHZaX7ccEmLhBJ+oPLQTWRxFe+rjMRkucLAkRQ01QsHkTWgkk2gMDpZYwytUX
         amOYMtC5e/JBmPfzCdNCwQpB8s/+jHzpVEd6U1Tp3J0YzyaB47xJ1KxKqxnBtetx1V3o
         Ae99+hJbx32WgWPFY5mH8JXCPxd2B7J1Ib8RnGSavaqlKpGxYjm3AB8P9vfBXAHRzJhl
         otWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UG+HWfno+uWNfzLfwmGXq7s847iNKJuTbNirN6mdLfo=;
        b=m/wy6JrlI9rr/2tPqPqbQdbOyJmmh9+sz2c8M9Gs3oY2rNgROKxm8dmwqVsfRI9wKe
         zIks82JAYnfo6MDIJOeirxM98mScFCkkPLTAmxeqpKBClhNk5xmMkEQHQa7OD1wcFfNW
         GwZejaRwzitwiT6vIhGvBEHbWu2ieA9n8R5EDzFt/qGEno/NvY6mDTufgB1IQiDHZWHG
         27VHhxaDzCM7CH4lX9bCXBZja74jBU9aiay4sunYR+cuBr9h+ZMtS2xX5ZHygrAZ6/rn
         BrsIiSxRU9K+yg8YuLPVY9e6ypZHOfeTMKT3FcDiH8FZu6jwKU4i1EzjPHE2mWtavsID
         FEfA==
X-Gm-Message-State: AOAM533WUGJY8oL8pAIoHY0SoerFTFUMiEHhl/WqkSAEQ/ppO3KUHXA0
        zo8ED8DvMaKuAWL95uFMXqU1SQ==
X-Google-Smtp-Source: ABdhPJyyw8x5El+MPR+4gnGFYxL9nIulMdUn5LIW4KX0HQEYciHrA3Pq9ZAzCbNfi06lb2z98euuFQ==
X-Received: by 2002:a05:6808:57b:: with SMTP id j27mr533532oig.161.1618330406647;
        Tue, 13 Apr 2021 09:13:26 -0700 (PDT)
Received: from [192.168.1.30] ([207.135.233.147])
        by smtp.gmail.com with ESMTPSA id 3sm2926165ood.46.2021.04.13.09.13.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Apr 2021 09:13:25 -0700 (PDT)
Subject: Re: [PATCH v2 00/16] Multigenerational LRU Framework
To:     SeongJae Park <sj38.park@gmail.com>, Yu Zhao <yuzhao@google.com>
Cc:     linux-mm@kvack.org, Andi Kleen <ak@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Benjamin Manes <ben.manes@gmail.com>,
        Dave Chinner <david@fromorbit.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Hillf Danton <hdanton@sina.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Michael Larabel <michael@michaellarabel.com>,
        Michal Hocko <mhocko@suse.com>,
        Michel Lespinasse <michel@lespinasse.org>,
        Rik van Riel <riel@surriel.com>,
        Roman Gushchin <guro@fb.com>,
        Rong Chen <rong.a.chen@intel.com>,
        SeongJae Park <sjpark@amazon.de>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Yang Shi <shy828301@gmail.com>,
        Ying Huang <ying.huang@intel.com>, Zi Yan <ziy@nvidia.com>,
        linux-kernel@vger.kernel.org, lkp@lists.01.org,
        page-reclaim@google.com
References: <20210413075155.32652-1-sjpark@amazon.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <3ddd4f8a-8e51-662b-df11-a63a0e75b2bc@kernel.dk>
Date:   Tue, 13 Apr 2021 10:13:24 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210413075155.32652-1-sjpark@amazon.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/13/21 1:51 AM, SeongJae Park wrote:
> From: SeongJae Park <sjpark@amazon.de>
> 
> Hello,
> 
> 
> Very interesting work, thank you for sharing this :)
> 
> On Tue, 13 Apr 2021 00:56:17 -0600 Yu Zhao <yuzhao@google.com> wrote:
> 
>> What's new in v2
>> ================
>> Special thanks to Jens Axboe for reporting a regression in buffered
>> I/O and helping test the fix.
> 
> Is the discussion open?  If so, could you please give me a link?

I wasn't on the initial post (or any of the lists it was posted to), but
it's on the google page reclaim list. Not sure if that is public or not.

tldr is that I was pretty excited about this work, as buffered IO tends
to suck (a lot) for high throughput applications. My test case was
pretty simple:

Randomly read a fast device, using 4k buffered IO, and watch what
happens when the page cache gets filled up. For this particular test,
we'll initially be doing 2.1GB/sec of IO, and then drop to 1.5-1.6GB/sec
with kswapd using a lot of CPU trying to keep up. That's mainline
behavior.

The initial posting of this patchset did no better, in fact it did a bit
worse. Performance dropped to the same levels and kswapd was using as
much CPU as before, but on top of that we also got excessive swapping.
Not at a high rate, but 5-10MB/sec continually.

I had some back and forths with Yu Zhao and tested a few new revisions,
and the current series does much better in this regard. Performance
still dips a bit when page cache fills, but not nearly as much, and
kswapd is using less CPU than before.

Hope that helps,
-- 
Jens Axboe

