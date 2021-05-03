Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99BC0371249
	for <lists+linux-kernel@lfdr.de>; Mon,  3 May 2021 10:11:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232972AbhECIMc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 May 2021 04:12:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:24073 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232911AbhECIM3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 May 2021 04:12:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620029496;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vwlHSyZzbGf/1hjjeGeNUgRrxHpiQEqHNLs9/p1ggRw=;
        b=SpnB4wOZYRjWRsZw6CbE6Mx+Vg7HJD6WzRgcfwSky3w5fpAeccqaq2UILjxONahJt3dIqY
        I3rJqAEAihRNarxzQCsVmFZyrKXO6ks++dnv4T+m+Yfo8J5VdHUDu5L17xvNn3pQ/B/4i0
        Xn0AOH9P/eW6AdoYxo/KBkyxXtjPimA=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-387-PPxMIbRrNE2EB8Xrxmxnbg-1; Mon, 03 May 2021 04:11:32 -0400
X-MC-Unique: PPxMIbRrNE2EB8Xrxmxnbg-1
Received: by mail-ed1-f71.google.com with SMTP id h13-20020a05640250cdb02903790a9c55acso4086577edb.4
        for <linux-kernel@vger.kernel.org>; Mon, 03 May 2021 01:11:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=vwlHSyZzbGf/1hjjeGeNUgRrxHpiQEqHNLs9/p1ggRw=;
        b=nCSBnT0+3gBRO/5uyNvYRDvv5+95ZMPyjWvhllwsjmTuIbuc4sNu1MGkji125JFqbP
         S4D3xleENnv2liJ89mSr+nlxknzv9s3sjmq0DKc1nF3+JYHtqbFr2Lkuv+p4HMKQ/G6P
         v6xL/sWlw84ZJtxMZ5o9tDt74XFNp/KTJUDsWJtDO3mrevNJUKcicYAF0xlPAhSC8Xew
         Ar0lsBxgKBfAXrlSNCOG8JwEsm841i3tyMlXN5No3Dghuc1EOKormIXoAYp2dv+Lkv7W
         UJ9JT8ga/+OSwjt3Y0yHTKgBTjIVkAPsQs736sw4Lg4e4L1e1R4ag66tb8E+XHjVBb6B
         nhew==
X-Gm-Message-State: AOAM532KWa6v1O943Xew7Zy+Pw/YZ4cUPZo8KTcHW6R9e7Qrrw3eAKIX
        J7pXAzNa7dVCLilUw3hkDLUWWaHoTbdaej79cJRjHyEHKUNNAJM/fwUDbuyyv38WKuCar8hJWxE
        Gbqy264RP6eWTREAwWeTgkrCu
X-Received: by 2002:a50:eb47:: with SMTP id z7mr16986497edp.68.1620029491052;
        Mon, 03 May 2021 01:11:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxgC+bCNFZ6IjQ+hZxVb6PiUEspf4Kwd7KdWnjG2fBIRF7s94xAa5mK0csiH8ddS3w5cQDqaA==
X-Received: by 2002:a50:eb47:: with SMTP id z7mr16986454edp.68.1620029490784;
        Mon, 03 May 2021 01:11:30 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c649f.dip0.t-ipconnect.de. [91.12.100.159])
        by smtp.gmail.com with ESMTPSA id d15sm12268494edu.86.2021.05.03.01.11.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 May 2021 01:11:30 -0700 (PDT)
Subject: Re: [PATCH v1 5/7] mm: introduce
 page_offline_(begin|end|freeze|unfreeze) to synchronize setting PageOffline()
To:     Mike Rapoport <rppt@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@suse.com>, Roman Gushchin <guro@fb.com>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        Steven Price <steven.price@arm.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Aili Yao <yaoaili@kingsoft.com>, Jiri Bohac <jbohac@suse.cz>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        linux-hyperv@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
References: <20210429122519.15183-1-david@redhat.com>
 <20210429122519.15183-6-david@redhat.com> <YI5Hp49AmWgfTzNy@kernel.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <4aa55978-c224-7ead-f00d-df1a6c3dfda4@redhat.com>
Date:   Mon, 3 May 2021 10:11:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YI5Hp49AmWgfTzNy@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02.05.21 08:33, Mike Rapoport wrote:
> On Thu, Apr 29, 2021 at 02:25:17PM +0200, David Hildenbrand wrote:
>> A driver might set a page logically offline -- PageOffline() -- and
>> turn the page inaccessible in the hypervisor; after that, access to page
>> content can be fatal. One example is virtio-mem; while unplugged memory
>> -- marked as PageOffline() can currently be read in the hypervisor, this
>> will no longer be the case in the future; for example, when having
>> a virtio-mem device backed by huge pages in the hypervisor.
>>
>> Some special PFN walkers -- i.e., /proc/kcore -- read content of random
>> pages after checking PageOffline(); however, these PFN walkers can race
>> with drivers that set PageOffline().
>>
>> Let's introduce page_offline_(begin|end|freeze|unfreeze) for
> 
> Bikeshed: freeze|thaw?
>

Sure :)


-- 
Thanks,

David / dhildenb

