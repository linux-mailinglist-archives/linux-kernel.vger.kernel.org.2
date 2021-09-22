Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11BC3413EE2
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 03:09:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232284AbhIVBKp convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 21 Sep 2021 21:10:45 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:16280 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230469AbhIVBKo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 21:10:44 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4HDgCc6F8Bz8tKG;
        Wed, 22 Sep 2021 09:08:28 +0800 (CST)
Received: from dggpemm100005.china.huawei.com (7.185.36.231) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Wed, 22 Sep 2021 09:09:12 +0800
Received: from dggpeml100016.china.huawei.com (7.185.36.216) by
 dggpemm100005.china.huawei.com (7.185.36.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Wed, 22 Sep 2021 09:09:12 +0800
Received: from dggpeml100016.china.huawei.com ([7.185.36.216]) by
 dggpeml100016.china.huawei.com ([7.185.36.216]) with mapi id 15.01.2308.008;
 Wed, 22 Sep 2021 09:09:12 +0800
From:   "Longpeng (Mike, Cloud Infrastructure Service Product Dept.)" 
        <longpeng2@huawei.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     "andraprs@amazon.com" <andraprs@amazon.com>,
        "lexnv@amazon.com" <lexnv@amazon.com>,
        "alcioa@amazon.com" <alcioa@amazon.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Gonglei (Arei)" <arei.gonglei@huawei.com>,
        "kamal@canonical.com" <kamal@canonical.com>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "sgarzare@redhat.com" <sgarzare@redhat.com>,
        "stefanha@redhat.com" <stefanha@redhat.com>,
        "vkuznets@redhat.com" <vkuznets@redhat.com>,
        "ne-devel-upstream@amazon.com" <ne-devel-upstream@amazon.com>
Subject: RE: [PATCH v2 1/4] nitro_enclaves: merge contiguous physical memory
 regions
Thread-Topic: [PATCH v2 1/4] nitro_enclaves: merge contiguous physical memory
 regions
Thread-Index: AQHXrvraMNZnMWAuzUKsEPXAU06oZquuFFKAgAEgrmA=
Date:   Wed, 22 Sep 2021 01:09:11 +0000
Message-ID: <f2145906d6394b3cb49dc514f4640cb3@huawei.com>
References: <20210921151039.1502-1-longpeng2@huawei.com>
 <20210921151039.1502-2-longpeng2@huawei.com> <YUn4N4kWe8mBUVUR@kroah.com>
In-Reply-To: <YUn4N4kWe8mBUVUR@kroah.com>
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
> From: Greg KH [mailto:gregkh@linuxfoundation.org]
> Sent: Tuesday, September 21, 2021 11:20 PM
> To: Longpeng (Mike, Cloud Infrastructure Service Product Dept.)
> <longpeng2@huawei.com>
> Cc: andraprs@amazon.com; lexnv@amazon.com; alcioa@amazon.com;
> linux-kernel@vger.kernel.org; Gonglei (Arei) <arei.gonglei@huawei.com>;
> kamal@canonical.com; pbonzini@redhat.com; sgarzare@redhat.com;
> stefanha@redhat.com; vkuznets@redhat.com; ne-devel-upstream@amazon.com
> Subject: Re: [PATCH v2 1/4] nitro_enclaves: merge contiguous physical memory
> regions
> 
> On Tue, Sep 21, 2021 at 11:10:36PM +0800, Longpeng(Mike) wrote:
> > There can be cases when there are more memory regions that need to be
> > set for an enclave than the maximum supported number of memory regions
> > per enclave. One example can be when the memory regions are backed by 2
> > MiB hugepages (the minimum supported hugepage size).
> >
> > Let's merge the adjacent regions if they are physical contiguous. This
> > way the final number of memory regions is less than before merging and
> > could potentially avoid reaching maximum.
> >
> > Signed-off-by: Longpeng(Mike) <longpeng2@huawei.com>
> 
> I need a real (i.e. legal) name for a signed-off-by line please.
> 

Okay.

> > ---
> >  drivers/virt/nitro_enclaves/ne_misc_dev.c | 87
> ++++++++++++++++++++-----------
> >  1 file changed, 58 insertions(+), 29 deletions(-)
> >
> > diff --git a/drivers/virt/nitro_enclaves/ne_misc_dev.c
> b/drivers/virt/nitro_enclaves/ne_misc_dev.c
> > index e21e1e8..a4776fc 100644
> > --- a/drivers/virt/nitro_enclaves/ne_misc_dev.c
> > +++ b/drivers/virt/nitro_enclaves/ne_misc_dev.c
> > @@ -126,6 +126,26 @@ struct ne_cpu_pool {
> >  static struct ne_cpu_pool ne_cpu_pool;
> >
> >  /**
> > + * struct phys_mem_region - Physical memory region
> > + * @paddr:	The start physical address of the region.
> > + * @size:	The sizeof of the region.
> > + */
> > +struct phys_mem_region {
> > +	u64 paddr;
> > +	u64 size;
> > +};
> > +
> > +/**
> > + * struct phys_contig_mem_region - Physical contiguous memory regions
> > + * @num:	The number of regions that currently has.
> > + * @region:	The array of physical memory regions.
> > + */
> > +struct phys_contig_mem_region {
> > +	unsigned long num;
> > +	struct phys_mem_region region[0];
> > +};
> 
> Why create your own structures and not use the in-kernel ones for stuff
> like this?  What is wrong with the existing memory region or resource
> handling logic?
> 

This patch only optimizes the physical memory regions handling logic of 
the Nitro Enclaves driver, not the common resource management in kernel. 
The physical memory regions are need to send to the hardware later.

Thanks for your suggestion, maybe we can use 'struct range' instead of 
'struct phys_mem_region'.

> thanks,
> 
> greg k-h
