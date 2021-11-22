Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02568458A93
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Nov 2021 09:32:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238847AbhKVIfp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Nov 2021 03:35:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:20872 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232953AbhKVIfn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Nov 2021 03:35:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637569954;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=77VMvTxzwRC+gYmX0HR5hhwgDOQIbvQTIt2pA/Ulf5c=;
        b=A/HlY11nAgI05OLDU87EocBk0I2V4Q5dGjwSUAo6SgEi4hJfl5ihCL2+R+JOKApGnOQXCT
        onBozOIg3zaSBrWvEiqwjN7WwodGU7iCgbS9U8MgTAvNysHGjR9NuZx7F+VJXkjc66gy1n
        Crvfo7Klaq3fPBZb6M/XhmsYoyHtGyo=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-129-JyVsWnjjNGe-XNdYmD2v_g-1; Mon, 22 Nov 2021 03:32:31 -0500
X-MC-Unique: JyVsWnjjNGe-XNdYmD2v_g-1
Received: by mail-wm1-f72.google.com with SMTP id bg20-20020a05600c3c9400b0033a9300b44bso3297559wmb.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Nov 2021 00:32:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:organization:subject
         :in-reply-to:content-transfer-encoding;
        bh=77VMvTxzwRC+gYmX0HR5hhwgDOQIbvQTIt2pA/Ulf5c=;
        b=si8xSp7lnxiaOOCbUQF2Fffco9PuXupyrb0HcE4D7SQYUBxHJyR9iX315np3I7efPK
         pHa7WjuFA6Oqd0zhOHwtn26ABrDcKOfXguOyW4HBtOduLndl75UdGsY7NE3VqnUS8fqI
         lZVDZePd//8ORlR9XsKP6iMZwglYAb5+SwBWKmyOJw9tXbBSvc24Z/8zUKqyJzDlC7Jl
         2UQLQioJOhaYNm2lA1YDZY0kHdNUTxNAVn7HjVuu4NcP/8vn9mbQwcdzgNSLTEe+LsAS
         x9AqFAEUFuz44DONI/9wqV9ym06Rse37WyHQyNJObecX8Y10B0QGgaOBoA4eMb4q0RIG
         JrNQ==
X-Gm-Message-State: AOAM533SgDfK6DoN6e0NfXPSFVfaqOb+P4rFAGaqyg5o9e1Le7pKok3o
        pznZ+gZTj3BhZbOLt49NEWYE9J327MHO9xWG8wQFmtFLvc3awMsV4tOAF/HKP96+ChuJt+nbEPM
        UfIFEhtg+tbMsYI/2CyBrBkC8
X-Received: by 2002:adf:d1e2:: with SMTP id g2mr34963374wrd.179.1637569950657;
        Mon, 22 Nov 2021 00:32:30 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzlQGMN8EdWpL4xofJzq9cQaXxgcFE6A3P7/UDUjYb0RO8zPG1rlyDDlLKC7piWGz2mwaXTzA==
X-Received: by 2002:adf:d1e2:: with SMTP id g2mr34963351wrd.179.1637569950475;
        Mon, 22 Nov 2021 00:32:30 -0800 (PST)
Received: from [192.168.3.132] (p5b0c667b.dip0.t-ipconnect.de. [91.12.102.123])
        by smtp.gmail.com with ESMTPSA id t8sm9617936wmq.32.2021.11.22.00.32.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Nov 2021 00:32:30 -0800 (PST)
Message-ID: <25b36a5c-5bbd-5423-0c67-05cd6c1432a7@redhat.com>
Date:   Mon, 22 Nov 2021 09:32:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Content-Language: en-US
To:     Shakeel Butt <shakeelb@google.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Yang Shi <shy828301@gmail.com>, Zi Yan <ziy@nvidia.com>,
        Matthew Wilcox <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20211120201230.920082-1-shakeelb@google.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH] mm: split thp synchronously on MADV_DONTNEED
In-Reply-To: <20211120201230.920082-1-shakeelb@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20.11.21 21:12, Shakeel Butt wrote:
> Many applications do sophisticated management of their heap memory for
> better performance but with low cost. We have a bunch of such
> applications running on our production and examples include caching and
> data storage services. These applications keep their hot data on the
> THPs for better performance and release the cold data through
> MADV_DONTNEED to keep the memory cost low.
> 
> The kernel defers the split and release of THPs until there is memory
> pressure. This causes complicates the memory management of these
> sophisticated applications which then needs to look into low level
> kernel handling of THPs to better gauge their headroom for expansion.

Can you elaborate a bit on that point? What exactly does such an
application do? I would have assumed that it's mostly transparent for
applications.

> In
> addition these applications are very latency sensitive and would prefer
> to not face memory reclaim due to non-deterministic nature of reclaim.

That makes sense.

> 
> This patch let such applications not worry about the low level handling
> of THPs in the kernel and splits the THPs synchronously on
> MADV_DONTNEED.

The main user I'm concerned about is virtio-balloon, which ends up
discarding VM memory via MADV_DONTNEED when inflating the balloon in the
guest in 4k granularity, but also during "free page reporting"
continuously when e.g., a 2MiB page becomes free in the guest. We want
both activities to be fast, and especially during "free page reporting",
to defer any heavy work.

Do we have a performance evaluation how much overhead is added e.g., for
a single 4k MADV_DONTNEED call on a THP or on a MADV_DONTNEED call that
covers the whole THP?

-- 
Thanks,

David / dhildenb

