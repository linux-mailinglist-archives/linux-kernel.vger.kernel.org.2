Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9633F446272
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 11:58:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231617AbhKELBA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 07:01:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:54355 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231536AbhKELA7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 07:00:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636109899;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sSErx+kJ2ynt/KJbrh+QZMhOJvLTwiY8iyfjdsdplQM=;
        b=MClsTdrczSort83DRfSrQ+HyGW5SEKYy0kHkFPKidh8RkmqB2CLWq8YpgkuF7yJXNAYz4K
        bT0F9IfRrDD+LNNiL3LU2MYFVCgDuuN768VwTRHrmIaDtWzI6VeDYYbnH7ZFvNK2Sfv1sc
        M89G43Xs3RxkSjjDIfzwBIzKIXule0w=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-457-zf_ulpl7OFGqnI5JHRXuKw-1; Fri, 05 Nov 2021 06:58:18 -0400
X-MC-Unique: zf_ulpl7OFGqnI5JHRXuKw-1
Received: by mail-wr1-f69.google.com with SMTP id u4-20020a5d4684000000b0017c8c1de97dso2190336wrq.16
        for <linux-kernel@vger.kernel.org>; Fri, 05 Nov 2021 03:58:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:organization:subject
         :in-reply-to:content-transfer-encoding;
        bh=sSErx+kJ2ynt/KJbrh+QZMhOJvLTwiY8iyfjdsdplQM=;
        b=2NmK0cUCj+ZNC8YfzIBtuBkbU9u1mx2k3ZbWtI4YoOJCUFgHAPApgwZEFVD+75StjI
         HEB4yEgs4IJAbI+xGiKXrNoyzSXdci+mX3h4w9oLlGBOPcbl3DZ4FQ1aZXgT1wzj4jXj
         Z8DeVA+ip+/5sGN/+pdA+hsv/96U4R08drnz3DLYBT6tASut4TLhLPhlpsSvaRJcNDCn
         7OMDRbauQUUOAE+N0x9fQ0n6O/g4NNUzurqFif5sB+668zK+EHA3RuZ94lD2IjGjDSUH
         W/90CdhunTkqE7vthQ+9bwJx2k4IxoG5vzThj8+yy236gSNE9U4QXaTq/TaegvgBT3YA
         m+ug==
X-Gm-Message-State: AOAM5304SvkZbYdyfbbN3OfyLAaifaLpePVP5PbtyOJxTu3vzyE9wRt+
        1v2b0x7IK7Wc0vnSCosOtKsVRpD1+6zmeaqqk2t/xLWcH9jN74oOLQuD1wplnDQnwG8S11Q+Q49
        RgQ1TAogi6kHnh7r6ohIEXsmG
X-Received: by 2002:a1c:ed03:: with SMTP id l3mr30018029wmh.86.1636109897436;
        Fri, 05 Nov 2021 03:58:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyW5ERgXtozFgG2CLpRjpzxMBE06phj3qPLFv2NX1yvKy0Ri/ouVaEC6qCHNGd7M2V/2Y7ARA==
X-Received: by 2002:a1c:ed03:: with SMTP id l3mr30018008wmh.86.1636109897255;
        Fri, 05 Nov 2021 03:58:17 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f0c:a000:3f25:9662:b5cf:73f9? (p200300d82f0ca0003f259662b5cf73f9.dip0.t-ipconnect.de. [2003:d8:2f0c:a000:3f25:9662:b5cf:73f9])
        by smtp.gmail.com with ESMTPSA id g5sm3684554wri.45.2021.11.05.03.58.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Nov 2021 03:58:16 -0700 (PDT)
Message-ID: <f6935141-3aeb-540d-afb8-292051166a82@redhat.com>
Date:   Fri, 5 Nov 2021 11:58:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Content-Language: en-US
To:     Naoya Horiguchi <naoya.horiguchi@linux.dev>, linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@suse.com>,
        Ding Hui <dinghui@sangfor.com.cn>,
        Tony Luck <tony.luck@intel.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Yang Shi <shy828301@gmail.com>, Peter Xu <peterx@redhat.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        linux-kernel@vger.kernel.org
References: <20211105055058.3152564-1-naoya.horiguchi@linux.dev>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v3 0/3] mm/hwpoison: fix unpoison_memory()
In-Reply-To: <20211105055058.3152564-1-naoya.horiguchi@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05.11.21 06:50, Naoya Horiguchi wrote:
> Hi,
> 
> I updated the unpoison patchset based ou discussions over v2.
> Please see individual patches for details of updates.
> 
> ----- (cover letter copied from v2) -----
> Main purpose of this series is to sync unpoison code to recent changes
> around how hwpoison code takes page refcount.  Unpoison should work or
> simply fail (without crash) if impossible.
> 
> The recent works of keeping hwpoison pages in shmem pagecache introduce
> a new state of hwpoisoned pages, but unpoison for such pages is not
> supported yet with this series.
> 
> It seems that soft-offline and unpoison can be used as general purpose
> page offline/online mechanism (not in the context of memory error).

I'm not sure what the target use case would be TBH ... for proper memory
offlining/memory hotunplug we have to offline whole memory blocks. For
memory ballooning based mechanisms we simply allocate random free pages
and eventually trigger reclaim to make more random free pages available.
For memory hotunplug via virtio-mem we're using alloc_contig_range() to
allocate ranges of interest we logically unplug.

The only benefit compared to alloc_contig_range() might be that we can
offline smaller chunks -- alloc_contig_range() isn't optimized for
sub-MAX_ORDER granularity yet. But then, alloc_contig_range() should
much rather be extended.

Long story short, I'm not sure there is a sane use case for this
"general purpose page offline/online mechanism" ...

-- 
Thanks,

David / dhildenb

