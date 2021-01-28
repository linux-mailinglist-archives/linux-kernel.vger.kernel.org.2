Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A8D6306A60
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 02:31:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231255AbhA1BaO convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 27 Jan 2021 20:30:14 -0500
Received: from szxga03-in.huawei.com ([45.249.212.189]:2883 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbhA1B3y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 20:29:54 -0500
Received: from DGGEMM403-HUB.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4DR2rv3Fv3z5LbD;
        Thu, 28 Jan 2021 09:27:27 +0800 (CST)
Received: from dggpemm100010.china.huawei.com (7.185.36.24) by
 DGGEMM403-HUB.china.huawei.com (10.3.20.211) with Microsoft SMTP Server (TLS)
 id 14.3.498.0; Thu, 28 Jan 2021 09:28:27 +0800
Received: from dggemi761-chm.china.huawei.com (10.1.198.147) by
 dggpemm100010.china.huawei.com (7.185.36.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2106.2; Thu, 28 Jan 2021 09:28:27 +0800
Received: from dggemi761-chm.china.huawei.com ([10.9.49.202]) by
 dggemi761-chm.china.huawei.com ([10.9.49.202]) with mapi id 15.01.2106.006;
 Thu, 28 Jan 2021 09:28:27 +0800
From:   "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
CC:     "Wangzhou (B)" <wangzhou1@hisilicon.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Zhangfei Gao <zhangfei.gao@linaro.org>,
        "linux-accelerators@lists.ozlabs.org" 
        <linux-accelerators@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "Liguozhu (Kenneth)" <liguozhu@hisilicon.com>,
        "chensihang (A)" <chensihang1@hisilicon.com>
Subject: RE: [RFC PATCH v2] uacce: Add uacce_ctrl misc device
Thread-Topic: [RFC PATCH v2] uacce: Add uacce_ctrl misc device
Thread-Index: AQHW8vWniUnMS+RFOU2UJJCa8sDlvKo39q+AgADtcaD//5AFgIAAh9tQ//+YwwCAAIUv4IAAmdoAgAKKrfA=
Date:   Thu, 28 Jan 2021 01:28:26 +0000
Message-ID: <c4dc2cdf4a904e099641de21282f59d3@hisilicon.com>
References: <1611563696-235269-1-git-send-email-wangzhou1@hisilicon.com>
 <20210125154717.GW4605@ziepe.ca>
 <96b655ade2534a65974a378bb68383ee@hisilicon.com>
 <20210125231619.GY4605@ziepe.ca>
 <5f64a68042c64f37b5cba74028bd2189@hisilicon.com>
 <20210126011304.GZ4605@ziepe.ca>
 <d7fce136c3644755a7aea5794bddf453@hisilicon.com>
 <20210126182024.GA4605@ziepe.ca>
In-Reply-To: <20210126182024.GA4605@ziepe.ca>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.126.200.149]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Jason Gunthorpe [mailto:jgg@ziepe.ca]
> Sent: Wednesday, January 27, 2021 7:20 AM
> To: Song Bao Hua (Barry Song) <song.bao.hua@hisilicon.com>
> Cc: Wangzhou (B) <wangzhou1@hisilicon.com>; Greg Kroah-Hartman
> <gregkh@linuxfoundation.org>; Arnd Bergmann <arnd@arndb.de>; Zhangfei Gao
> <zhangfei.gao@linaro.org>; linux-accelerators@lists.ozlabs.org;
> linux-kernel@vger.kernel.org; iommu@lists.linux-foundation.org;
> linux-mm@kvack.org; Liguozhu (Kenneth) <liguozhu@hisilicon.com>; chensihang
> (A) <chensihang1@hisilicon.com>
> Subject: Re: [RFC PATCH v2] uacce: Add uacce_ctrl misc device
> 
> On Tue, Jan 26, 2021 at 01:26:45AM +0000, Song Bao Hua (Barry Song) wrote:
> > > On Mon, Jan 25, 2021 at 11:35:22PM +0000, Song Bao Hua (Barry Song) wrote:
> > >
> > > > > On Mon, Jan 25, 2021 at 10:21:14PM +0000, Song Bao Hua (Barry Song)
> wrote:
> > > > > > mlock, while certainly be able to prevent swapping out, it won't
> > > > > > be able to stop page moving due to:
> > > > > > * memory compaction in alloc_pages()
> > > > > > * making huge pages
> > > > > > * numa balance
> > > > > > * memory compaction in CMA
> > > > >
> > > > > Enabling those things is a major reason to have SVA device in the
> > > > > first place, providing a SW API to turn it all off seems like the
> > > > > wrong direction.
> > > >
> > > > I wouldn't say this is a major reason to have SVA. If we read the
> > > > history of SVA and papers, people would think easy programming due
> > > > to data struct sharing between cpu and device, and process space
> > > > isolation in device would be the major reasons for SVA. SVA also
> > > > declares it supports zero-copy while zero-copy doesn't necessarily
> > > > depend on SVA.
> > >
> > > Once you have to explicitly make system calls to declare memory under
> > > IO, you loose all of that.
> > >
> > > Since you've asked the app to be explicit about the DMAs it intends to
> > > do, there is not really much reason to use SVA for those DMAs anymore.
> >
> > Let's see a non-SVA case. We are not using SVA, we can have
> > a memory pool by hugetlb or pin, and app can allocate memory
> > from this pool, and get stable I/O performance on the memory
> > from the pool. But device has its separate page table which
> > is not bound with this process, thus lacking the protection
> > of process space isolation. Plus, CPU and device are using
> > different address.
> 
> So you are relying on the platform to do the SVA for the device?
> 

Sorry for late response.

uacce and its userspace framework UADK depend on SVA, leveraging
the enhanced security by isolated process address space.

This patch is mainly an extension for performance optimization to
get stable high-performance I/O on pinned memory even though the
hardware supports IO page fault to get pages back after swapping
out or page migration.
But IO page fault will cause serious latency jitter for high-speed
I/O.
For slow speed device, they don't need to use this extension.

> This feels like it goes back to another topic where I felt the SVA
> setup uAPI should be shared and not buried into every driver's unique
> ioctls.
> 
> Having something like this in a shared SVA system is somewhat less
> strange.

Sounds reasonable. On the other hand, uacce seems to be an common
uAPI for SVA, and probably the only one for this moment.

uacce is a framework not a specific driver as any accelerators
can hook into this framework as long as a device provides
uacce_ops and register itself by uacce_register(). Uacce, for
itself, doesn't bind with any specific hardware. So uacce interfaces
are kind of common uAPI :-)

> 
> Jason

Thanks
Barry

