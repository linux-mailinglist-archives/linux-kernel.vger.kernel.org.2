Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50C0430B60C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 04:51:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231144AbhBBDsW convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 1 Feb 2021 22:48:22 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:3002 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbhBBDsT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 22:48:19 -0500
Received: from DGGEMM405-HUB.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4DV9hv28l2zR5KD;
        Tue,  2 Feb 2021 11:46:23 +0800 (CST)
Received: from dggpemm500012.china.huawei.com (7.185.36.89) by
 DGGEMM405-HUB.china.huawei.com (10.3.20.213) with Microsoft SMTP Server (TLS)
 id 14.3.498.0; Tue, 2 Feb 2021 11:47:33 +0800
Received: from dggemi761-chm.china.huawei.com (10.1.198.147) by
 dggpemm500012.china.huawei.com (7.185.36.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2106.2; Tue, 2 Feb 2021 11:47:33 +0800
Received: from dggemi761-chm.china.huawei.com ([10.9.49.202]) by
 dggemi761-chm.china.huawei.com ([10.9.49.202]) with mapi id 15.01.2106.006;
 Tue, 2 Feb 2021 11:47:33 +0800
From:   "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
To:     "Tian, Kevin" <kevin.tian@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
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
Thread-Index: AQHW8vWniUnMS+RFOU2UJJCa8sDlvKo39q+AgADtcaD//5AFgIAAh9tQ//+YwwCAAIUv4IAEx5CAgAWazQCAADRGAIAAkKkA
Date:   Tue, 2 Feb 2021 03:47:33 +0000
Message-ID: <06924f5853c24f99a4b1f5683bdc74e4@hisilicon.com>
References: <1611563696-235269-1-git-send-email-wangzhou1@hisilicon.com>
 <20210125154717.GW4605@ziepe.ca>
 <96b655ade2534a65974a378bb68383ee@hisilicon.com>
 <20210125231619.GY4605@ziepe.ca>
 <5f64a68042c64f37b5cba74028bd2189@hisilicon.com>
 <20210126011304.GZ4605@ziepe.ca>
 <d7fce136c3644755a7aea5794bddf453@hisilicon.com>
 <MWHPR11MB1886DC78C5FBA3636B94F2578CB99@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210201234424.GI4718@ziepe.ca>
 <MWHPR11MB1886464FFEF10DF9AE708C4A8CB59@MWHPR11MB1886.namprd11.prod.outlook.com>
In-Reply-To: <MWHPR11MB1886464FFEF10DF9AE708C4A8CB59@MWHPR11MB1886.namprd11.prod.outlook.com>
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
> From: Tian, Kevin [mailto:kevin.tian@intel.com]
> Sent: Tuesday, February 2, 2021 3:52 PM
> To: Jason Gunthorpe <jgg@ziepe.ca>
> Cc: Song Bao Hua (Barry Song) <song.bao.hua@hisilicon.com>; chensihang (A)
> <chensihang1@hisilicon.com>; Arnd Bergmann <arnd@arndb.de>; Greg
> Kroah-Hartman <gregkh@linuxfoundation.org>; linux-kernel@vger.kernel.org;
> iommu@lists.linux-foundation.org; linux-mm@kvack.org; Zhangfei Gao
> <zhangfei.gao@linaro.org>; Liguozhu (Kenneth) <liguozhu@hisilicon.com>;
> linux-accelerators@lists.ozlabs.org
> Subject: RE: [RFC PATCH v2] uacce: Add uacce_ctrl misc device
> 
> > From: Jason Gunthorpe <jgg@ziepe.ca>
> > Sent: Tuesday, February 2, 2021 7:44 AM
> >
> > On Fri, Jan 29, 2021 at 10:09:03AM +0000, Tian, Kevin wrote:
> > > > SVA is not doom to work with IO page fault only. If we have SVA+pin,
> > > > we would get both sharing address and stable I/O latency.
> > >
> > > Isn't it like a traditional MAP_DMA API (imply pinning) plus specifying
> > > cpu_va of the memory pool as the iova?
> >
> > I think their issue is the HW can't do the cpu_va trick without also
> > involving the system IOMMU in a SVA mode
> >
> 
> This is the part that I didn't understand. Using cpu_va in a MAP_DMA
> interface doesn't require device support. It's just an user-specified
> address to be mapped into the IOMMU page table. On the other hand,

The background is that uacce is based on SVA and we are building
applications on uacce:
https://www.kernel.org/doc/html/v5.10/misc-devices/uacce.html
so IOMMU simply uses the page table of MMU, and don't do any
special mapping to an user-specified address. We don't break
the basic assumption that uacce is using SVA, otherwise, we
need to re-build uacce and the whole base.

> sharing CPU page table through a SVA interface for an usage where I/O
> page faults must be completely avoided seems a misleading attempt.

That is not for completely avoiding IO page fault, that is just
an extension for high-performance I/O case, providing a way to
avoid IO latency jitter. Using it or not is totally up to users.

> Even if people do want this model (e.g. mix pinning+fault), it should be
> a mm syscall as Greg pointed out, not specific to sva.
> 

We are glad to make it a syscall if people are happy with
it. The simplest way would be a syscall similar with
userfaultfd  if we don't want to mess up mm_struct.

> Thanks
> Kevin

Thanks
Barry
