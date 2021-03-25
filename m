Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F9C334913F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 12:54:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230233AbhCYLxj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 07:53:39 -0400
Received: from pio-pvt-msa2.bahnhof.se ([79.136.2.41]:53434 "EHLO
        pio-pvt-msa2.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229788AbhCYLx0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 07:53:26 -0400
Received: from localhost (localhost [127.0.0.1])
        by pio-pvt-msa2.bahnhof.se (Postfix) with ESMTP id CBAB23F496;
        Thu, 25 Mar 2021 12:53:13 +0100 (CET)
Authentication-Results: pio-pvt-msa2.bahnhof.se;
        dkim=pass (1024-bit key; unprotected) header.d=shipmail.org header.i=@shipmail.org header.b=Jcr/8gpy;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 tagged_above=-999 required=6.31
        tests=[BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
        DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.001,
        URIBL_BLOCKED=0.001] autolearn=ham autolearn_force=no
Received: from pio-pvt-msa2.bahnhof.se ([127.0.0.1])
        by localhost (pio-pvt-msa2.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id kXkEWKiv6GtY; Thu, 25 Mar 2021 12:53:08 +0100 (CET)
Received: by pio-pvt-msa2.bahnhof.se (Postfix) with ESMTPA id 8DE093F449;
        Thu, 25 Mar 2021 12:53:07 +0100 (CET)
Received: from [10.249.254.165] (unknown [192.198.151.44])
        by mail1.shipmail.org (Postfix) with ESMTPSA id 223A33600A8;
        Thu, 25 Mar 2021 12:53:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=shipmail.org; s=mail;
        t=1616673198; bh=pupAMitWznuoPQ8iF8iLtIylmNo+WPnV6Cb+xjHhIIo=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Jcr/8gpyXj0u86Gzp+qlCA5cbWu6753/rNa1t/ZkoJ7miw09xCznZ+N1NKGpMxI3M
         TG7URHg57VZESD4MKWvhYIB27SRltWGjrSd6DSqcXV+wv7VRd3ubYudSl/+ROMKf+4
         mSfSqOcOFKgCS4638DmDU0fRlp8Y8eXw5QJLnsls=
Subject: Re: [RFC PATCH 1/2] mm,drm/ttm: Block fast GUP to TTM huge pages
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>
References: <6c9acb90-8e91-d8af-7abd-e762d9a901aa@shipmail.org>
 <20210324134833.GE2356281@nvidia.com>
 <0b984f96-00fb-5410-bb16-02e12b2cc024@shipmail.org>
 <20210324163812.GJ2356281@nvidia.com>
 <08f19e80-d6cb-8858-0c5d-67d2e2723f72@amd.com>
 <730eb2ff-ba98-2393-6d42-61735e3c6b83@shipmail.org>
 <20210324231419.GR2356281@nvidia.com>
 <607ecbeb-e8a5-66e9-6fe2-9a8d22f12bc2@shipmail.org>
 <fb74efd9-55be-9a8d-95b0-6103e263aab8@amd.com>
 <15da5784-96ca-25e5-1485-3ce387ee6695@shipmail.org>
 <20210325113023.GT2356281@nvidia.com>
From:   =?UTF-8?Q?Thomas_Hellstr=c3=b6m_=28Intel=29?= 
        <thomas_os@shipmail.org>
Message-ID: <afad3159-9aa8-e052-3bef-d00dee1ba51e@shipmail.org>
Date:   Thu, 25 Mar 2021 12:53:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210325113023.GT2356281@nvidia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/25/21 12:30 PM, Jason Gunthorpe wrote:
> On Thu, Mar 25, 2021 at 10:51:35AM +0100, Thomas Hellström (Intel) wrote:
>
>>> Please explain that further. Why do we need the mmap lock to insert PMDs
>>> but not when insert PTEs?
>> We don't. But once you've inserted a PMD directory you can't remove it
>> unless you have the mmap lock (and probably also the i_mmap_lock in write
>> mode). That for example means that if you have a VRAM region mapped with
>> huge PMDs, and then it gets evicted, and you happen to read a byte from it
>> when it's evicted and therefore populate the full region with PTEs pointing
>> to system pages, you can't go back to huge PMDs again without a munmap() in
>> between.
> This is all basically magic to me still, but THP does this
> transformation and I think what it does could work here too. We
> probably wouldn't be able to upgrade while handling fault, but at the
> same time, this should be quite rare as it would require the driver to
> have supplied a small page for this VMA at some point.

IIRC THP handles this using khugepaged, grabbing the lock in write mode 
when coalescing, and yeah, I don't think anything prevents anyone from 
extending khugepaged doing that also for special huge page table entries.

>
>>> Apart from that I still don't fully get why we need this in the first
>>> place.
>> Because virtual huge page address boundaries need to be aligned with
>> physical huge page address boundaries, and mmap can happen before bos are
>> populated so you have no way of knowing how physical huge page
>> address
> But this is a mmap-time problem, fault can't fix mmap using the wrong VA.

Nope. The point here was that in this case, to make sure mmap uses the 
correct VA to give us a reasonable chance of alignement, the driver 
might need to be aware of and do trickery with the huge page-table-entry 
sizes anyway, although I think in most cases a standard helper for this 
can be supplied.

/Thomas


>
>>> I really don't see that either. When a buffer is accessed by the CPU it
>>> is in > 90% of all cases completely accessed. Not faulting in full
>>> ranges is just optimizing for a really unlikely case here.
>> It might be that you're right, but are all drivers wanting to use this like
>> drm in this respect? Using the interface to fault in a 1G range in the hope
>> it could map it to a huge pud may unexpectedly consume and populate some 16+
>> MB of page tables.
> If the underlying device block size is so big then sure, why not? The
> "unexpectedly" should be quite rare/non existant anyhow.
>
> Jason
>   
