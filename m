Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 740643ECC16
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 02:29:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231738AbhHPA0m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Aug 2021 20:26:42 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:13424 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230124AbhHPA0l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Aug 2021 20:26:41 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4GnvxX4cbbzdb63;
        Mon, 16 Aug 2021 08:22:24 +0800 (CST)
Received: from dggpeml500016.china.huawei.com (7.185.36.70) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 16 Aug 2021 08:26:07 +0800
Received: from [10.174.148.223] (10.174.148.223) by
 dggpeml500016.china.huawei.com (7.185.36.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 16 Aug 2021 08:26:06 +0800
Subject: Re: [RFC PATCH 0/5] madvise MADV_DOEXEC
To:     David Laight <David.Laight@ACULAB.COM>,
        'Khalid Aziz' <khalid.aziz@oracle.com>,
        Matthew Wilcox <willy@infradead.org>
CC:     Steven Sistare <steven.sistare@oracle.com>,
        Anthony Yznaga <anthony.yznaga@oracle.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "Gonglei (Arei)" <arei.gonglei@huawei.com>
References: <1595869887-23307-1-git-send-email-anthony.yznaga@oracle.com>
 <cc714571-4461-c9e0-7b24-e213664caa54@huawei.com>
 <43471cbb-67c6-f189-ef12-0f8302e81b06@oracle.com>
 <a1dbf12e-9949-109e-122c-ba7ba609801b@huawei.com>
 <YOubKmDwxMIvdAed@casper.infradead.org>
 <a94973ab83ce48bd85c91397f82d7915@huawei.com>
 <55720e1b39cff0a0f882d8610e7906dc80ea0a01.camel@oracle.com>
 <6775a78fa70b4868bfd24c750ec24bdd@AcuMS.aculab.com>
From:   "Longpeng (Mike, Cloud Infrastructure Service Product Dept.)" 
        <longpeng2@huawei.com>
Message-ID: <0591d6d4-5844-13ac-9e22-722e22c911f4@huawei.com>
Date:   Mon, 16 Aug 2021 08:26:06 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <6775a78fa70b4868bfd24c750ec24bdd@AcuMS.aculab.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.148.223]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml500016.china.huawei.com (7.185.36.70)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

在 2021/8/15 4:07, David Laight 写道:
> ...
>>>>> Let me describe my use case more clearly (just ignore if you're not
>>>>> interested in it):
>>>>>
>>>>> 1. Prog A mmap() 4GB memory (anon or file-mapping), suppose the
>>>>> allocated VA range is [0x40000000,0x140000000)
>>>>>
>>>>> 2. Prog A specifies [0x48000000,0x50000000) and
>>>>> [0x80000000,0x100000000) will be shared by its child.
>>>>>
>>>>> 3. Prog A fork() Prog B and then Prog B exec() a new ELF binary.
>>>>>
>>>>> 4. Prog B notice the shared ranges (e.g. by input parameters or
>>>>> ...)
>>>>> and remap them to a continuous VA range.
> 
> Remapping to contiguous VA is going to be difficult in the
> general case for (IIRC) VIVT caches.
> The required cache coherence may only be attainable by
> using uncached mappings.
> 

The Prog B uses mremap() syscall to remapping the shared ranges to other places,
this is a common case for mremap in userspace.
The cache coherence should already be processed in mremap core logic, otherwise
there's maybe something wrong in mremap().

> 	David
> 
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> Registration No: 1397386 (Wales)
> 
