Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B43E33C67C1
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 02:58:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230486AbhGMBA6 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 12 Jul 2021 21:00:58 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:6806 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbhGMBA5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jul 2021 21:00:57 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4GP2Ct5sKzzXsS1;
        Tue, 13 Jul 2021 08:52:26 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 13 Jul 2021 08:57:59 +0800
Received: from dggpeml500016.china.huawei.com (7.185.36.70) by
 dggpemm500007.china.huawei.com (7.185.36.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 13 Jul 2021 08:57:59 +0800
Received: from dggpeml500016.china.huawei.com ([7.185.36.70]) by
 dggpeml500016.china.huawei.com ([7.185.36.70]) with mapi id 15.01.2176.012;
 Tue, 13 Jul 2021 08:57:59 +0800
From:   "Longpeng (Mike, Cloud Infrastructure Service Product Dept.)" 
        <longpeng2@huawei.com>
To:     Matthew Wilcox <willy@infradead.org>
CC:     Steven Sistare <steven.sistare@oracle.com>,
        Anthony Yznaga <anthony.yznaga@oracle.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "Gonglei (Arei)" <arei.gonglei@huawei.com>
Subject: RE: [RFC PATCH 0/5] madvise MADV_DOEXEC
Thread-Topic: [RFC PATCH 0/5] madvise MADV_DOEXEC
Thread-Index: AQHXc97/nCzRwgdWL0SQOyOsHiWdfas4gR6AgAWFHYCAAAbcAIACA3Tw
Date:   Tue, 13 Jul 2021 00:57:59 +0000
Message-ID: <a94973ab83ce48bd85c91397f82d7915@huawei.com>
References: <1595869887-23307-1-git-send-email-anthony.yznaga@oracle.com>
 <cc714571-4461-c9e0-7b24-e213664caa54@huawei.com>
 <43471cbb-67c6-f189-ef12-0f8302e81b06@oracle.com>
 <a1dbf12e-9949-109e-122c-ba7ba609801b@huawei.com>
 <YOubKmDwxMIvdAed@casper.infradead.org>
In-Reply-To: <YOubKmDwxMIvdAed@casper.infradead.org>
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

Hi Matthew,

> -----Original Message-----
> From: Matthew Wilcox [mailto:willy@infradead.org]
> Sent: Monday, July 12, 2021 9:30 AM
> To: Longpeng (Mike, Cloud Infrastructure Service Product Dept.)
> <longpeng2@huawei.com>
> Cc: Steven Sistare <steven.sistare@oracle.com>; Anthony Yznaga
> <anthony.yznaga@oracle.com>; linux-kernel@vger.kernel.org;
> linux-mm@kvack.org; Gonglei (Arei) <arei.gonglei@huawei.com>
> Subject: Re: [RFC PATCH 0/5] madvise MADV_DOEXEC
> 
> On Mon, Jul 12, 2021 at 09:05:45AM +0800, Longpeng (Mike, Cloud
> Infrastructure Service Product Dept.) wrote:
> > Let me describe my use case more clearly (just ignore if you're not
> > interested in it):
> >
> > 1. Prog A mmap() 4GB memory (anon or file-mapping), suppose the
> > allocated VA range is [0x40000000,0x140000000)
> >
> > 2. Prog A specifies [0x48000000,0x50000000) and
> > [0x80000000,0x100000000) will be shared by its child.
> >
> > 3. Prog A fork() Prog B and then Prog B exec() a new ELF binary.
> >
> > 4. Prog B notice the shared ranges (e.g. by input parameters or ...)
> > and remap them to a continuous VA range.
> 
> This is dangerous.  There must be an active step for Prog B to accept Prog A's
> ranges into its address space.  Otherwise Prog A could almost completely fill
> Prog B's address space and so control where Prog B places its mappings.  It
> could also provoke a latent bug in Prog B if it doesn't handle address space
> exhaustion gracefully.
> 
> I had a proposal to handle this.  Would it meet your requirements?
> https://lore.kernel.org/lkml/20200730152250.GG23808@casper.infradead.org/

I noticed your proposal of project Sileby and I think it can meet Steven's requirement, but I not sure whether it's suitable for mine because there's no sample code yet, is it in progress ?

According to the abstract of Sileby, I have two questions:
1. Would you plan to support the file-mapping memory sharing ? e.g. Prog A's 4G memory is backend with 2M hugetlb.
2. Does each mshare fd only containe one sharing VMA ? For large memory process (1T~4T in our env), maybe there is hundreds of memory ranges need to be shared, this will take too much fd space if so ?

