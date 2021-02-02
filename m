Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0034930B40A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 01:24:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230258AbhBBAWu convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 1 Feb 2021 19:22:50 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:3413 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbhBBAWr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 19:22:47 -0500
Received: from DGGEMM402-HUB.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4DV57c4Zd1z5NS2;
        Tue,  2 Feb 2021 08:20:44 +0800 (CST)
Received: from dggpemm500009.china.huawei.com (7.185.36.225) by
 DGGEMM402-HUB.china.huawei.com (10.3.20.210) with Microsoft SMTP Server (TLS)
 id 14.3.498.0; Tue, 2 Feb 2021 08:22:01 +0800
Received: from dggemi761-chm.china.huawei.com (10.1.198.147) by
 dggpemm500009.china.huawei.com (7.185.36.225) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2106.2; Tue, 2 Feb 2021 08:22:01 +0800
Received: from dggemi761-chm.china.huawei.com ([10.9.49.202]) by
 dggemi761-chm.china.huawei.com ([10.9.49.202]) with mapi id 15.01.2106.006;
 Tue, 2 Feb 2021 08:22:01 +0800
From:   "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>,
        "Tian, Kevin" <kevin.tian@intel.com>
CC:     "chensihang (A)" <chensihang1@hisilicon.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Zhangfei Gao <zhangfei.gao@linaro.org>,
        "Liguozhu (Kenneth)" <liguozhu@hisilicon.com>,
        "linux-accelerators@lists.ozlabs.org" 
        <linux-accelerators@lists.ozlabs.org>
Subject: RE: [RFC PATCH v2] uacce: Add uacce_ctrl misc device
Thread-Topic: [RFC PATCH v2] uacce: Add uacce_ctrl misc device
Thread-Index: AQHW8vWniUnMS+RFOU2UJJCa8sDlvKo39q+AgADtcaD//5AFgIAAh9tQ//+YwwCAAIUv4IAEx5CAgAWazQCAAI200A==
Date:   Tue, 2 Feb 2021 00:22:01 +0000
Message-ID: <845380ee1cab4be9b1b4a1af3f0f7712@hisilicon.com>
References: <1611563696-235269-1-git-send-email-wangzhou1@hisilicon.com>
 <20210125154717.GW4605@ziepe.ca>
 <96b655ade2534a65974a378bb68383ee@hisilicon.com>
 <20210125231619.GY4605@ziepe.ca>
 <5f64a68042c64f37b5cba74028bd2189@hisilicon.com>
 <20210126011304.GZ4605@ziepe.ca>
 <d7fce136c3644755a7aea5794bddf453@hisilicon.com>
 <MWHPR11MB1886DC78C5FBA3636B94F2578CB99@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210201234424.GI4718@ziepe.ca>
In-Reply-To: <20210201234424.GI4718@ziepe.ca>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.126.202.106]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Jason Gunthorpe [mailto:jgg@ziepe.ca]
> Sent: Tuesday, February 2, 2021 12:44 PM
> To: Tian, Kevin <kevin.tian@intel.com>
> Cc: Song Bao Hua (Barry Song) <song.bao.hua@hisilicon.com>; chensihang (A)
> <chensihang1@hisilicon.com>; Arnd Bergmann <arnd@arndb.de>; Greg
> Kroah-Hartman <gregkh@linuxfoundation.org>; linux-kernel@vger.kernel.org;
> iommu@lists.linux-foundation.org; linux-mm@kvack.org; Zhangfei Gao
> <zhangfei.gao@linaro.org>; Liguozhu (Kenneth) <liguozhu@hisilicon.com>;
> linux-accelerators@lists.ozlabs.org
> Subject: Re: [RFC PATCH v2] uacce: Add uacce_ctrl misc device
> 
> On Fri, Jan 29, 2021 at 10:09:03AM +0000, Tian, Kevin wrote:
> > > SVA is not doom to work with IO page fault only. If we have SVA+pin,
> > > we would get both sharing address and stable I/O latency.
> >
> > Isn't it like a traditional MAP_DMA API (imply pinning) plus specifying
> > cpu_va of the memory pool as the iova?
> 
> I think their issue is the HW can't do the cpu_va trick without also
> involving the system IOMMU in a SVA mode
> 
> It really is something that belongs under some general /dev/sva as we
> talked on the vfio thread

AFAIK, there is no this /dev/sva so /dev/uacce is an uAPI
which belongs to sva.

Another option is that we add a system call like
fs/userfaultfd.c, and move the file_operations and  ioctl
to the anon inode by creating fd via anon_inode_getfd().
Then nothing will be buried by uacce.

> 
> Jason

Thanks
Barry

