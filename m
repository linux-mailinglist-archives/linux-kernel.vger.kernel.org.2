Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E60B13EE173
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 02:47:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233178AbhHQArz convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 16 Aug 2021 20:47:55 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:8026 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232973AbhHQAry (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 20:47:54 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4GpXRP1zNCzYmt2;
        Tue, 17 Aug 2021 08:46:57 +0800 (CST)
Received: from dggpemm100008.china.huawei.com (7.185.36.125) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 17 Aug 2021 08:47:19 +0800
Received: from dggpeml500016.china.huawei.com (7.185.36.70) by
 dggpemm100008.china.huawei.com (7.185.36.125) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 17 Aug 2021 08:47:19 +0800
Received: from dggpeml500016.china.huawei.com ([7.185.36.70]) by
 dggpeml500016.china.huawei.com ([7.185.36.70]) with mapi id 15.01.2176.012;
 Tue, 17 Aug 2021 08:47:19 +0800
From:   "Longpeng (Mike, Cloud Infrastructure Service Product Dept.)" 
        <longpeng2@huawei.com>
To:     Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>
CC:     Khalid Aziz <khalid.aziz@oracle.com>,
        Steven Sistare <steven.sistare@oracle.com>,
        Anthony Yznaga <anthony.yznaga@oracle.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "Gonglei (Arei)" <arei.gonglei@huawei.com>
Subject: RE: [RFC PATCH 0/5] madvise MADV_DOEXEC
Thread-Topic: [RFC PATCH 0/5] madvise MADV_DOEXEC
Thread-Index: AQHXkHx3rHlzMKHix0+kvEwtcZpkNat1QwAAgABEngCAAU730A==
Date:   Tue, 17 Aug 2021 00:47:19 +0000
Message-ID: <3cdccacab6244dd3ac9d491ac7233b43@huawei.com>
References: <1595869887-23307-1-git-send-email-anthony.yznaga@oracle.com>
 <cc714571-4461-c9e0-7b24-e213664caa54@huawei.com>
 <43471cbb-67c6-f189-ef12-0f8302e81b06@oracle.com>
 <a1dbf12e-9949-109e-122c-ba7ba609801b@huawei.com>
 <YOubKmDwxMIvdAed@casper.infradead.org>
 <a94973ab83ce48bd85c91397f82d7915@huawei.com>
 <55720e1b39cff0a0f882d8610e7906dc80ea0a01.camel@oracle.com>
 <db2b7337-4c6b-4e4b-71d3-dc4940353498@redhat.com>
 <YRpVHnr55LpQQvTb@casper.infradead.org>
In-Reply-To: <YRpVHnr55LpQQvTb@casper.infradead.org>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.174.148.223]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Matthew Wilcox [mailto:willy@infradead.org]
> Sent: Monday, August 16, 2021 8:08 PM
> To: David Hildenbrand <david@redhat.com>
> Cc: Khalid Aziz <khalid.aziz@oracle.com>; Longpeng (Mike, Cloud Infrastructure
> Service Product Dept.) <longpeng2@huawei.com>; Steven Sistare
> <steven.sistare@oracle.com>; Anthony Yznaga <anthony.yznaga@oracle.com>;
> linux-kernel@vger.kernel.org; linux-mm@kvack.org; Gonglei (Arei)
> <arei.gonglei@huawei.com>
> Subject: Re: [RFC PATCH 0/5] madvise MADV_DOEXEC
> 
> On Mon, Aug 16, 2021 at 10:02:22AM +0200, David Hildenbrand wrote:
> > > Mappings within this address range behave as if they were shared
> > > between threads, so a write to a MAP_PRIVATE mapping will create a
> > > page which is shared between all the sharers. The first process that
> > > declares an address range mshare'd can continue to map objects in
> > > the shared area. All other processes that want mshare'd access to
> > > this memory area can do so by calling mshare(). After this call, the
> > > address range given by mshare becomes a shared range in its address
> > > space. Anonymous mappings will be shared and not COWed.
> >
> > Did I understand correctly that you want to share actual page tables
> > between processes and consequently different MMs? That sounds like a very bad
> idea.
> 
> That is the entire point.  Consider a machine with 10,000 instances of an
> application running (process model, not thread model).  If each application wants
> to map 1TB of RAM using 2MB pages, that's 4MB of page tables per process or
> 40GB of RAM for the whole machine.
> 
> There's a reason hugetlbfs was enhanced to allow this page table sharing.
> I'm not a fan of the implementation as it gets some locks upside down, so this is an
> attempt to generalise the concept beyond hugetlbfs.
> 
> Think of it like partial threading.  You get to share some parts, but not all, of your
> address space with your fellow processes.  Obviously you don't want to expose
> this to random other processes, only to other instances of yourself being run as the
> same user.

I understand your intent now, you want to share memory ranges by sharing the relevant
pgtable pages. 

I had implemented a similar idea to support QEMU live upgrade about four years ago
( in late 2017),

https://patents.google.com/patent/US20210089345A1

"""
[0131]
In a first possible implementation, the generation unit includes a copying subunit configured
to copy an entry corresponding to the virtual memory area in a PGD page table of the first
virtual machine to an entry corresponding to the virtual memory area in a PGD page table of
the second virtual machine.
"""

We want to share the anonymous memory between old QEMU process and the new one, 
so we limit the QEMU to mmap the VM's memory address in 4T-8T and then share the 
memory by direct copy the PGD entries ( implementation is much more complicated than I 
say ).

Besides to save memory, large memory range can be shared fast in this way.

