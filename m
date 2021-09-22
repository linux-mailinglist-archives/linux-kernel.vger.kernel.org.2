Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3ED6E413EA3
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 02:27:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbhIVA3Q convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 21 Sep 2021 20:29:16 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:15437 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbhIVA3P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 20:29:15 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4HDfCn4yPszRQFf;
        Wed, 22 Sep 2021 08:23:33 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Wed, 22 Sep 2021 08:27:45 +0800
Received: from dggpeml100016.china.huawei.com (7.185.36.216) by
 dggpemm500007.china.huawei.com (7.185.36.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Wed, 22 Sep 2021 08:27:44 +0800
Received: from dggpeml100016.china.huawei.com ([7.185.36.216]) by
 dggpeml100016.china.huawei.com ([7.185.36.216]) with mapi id 15.01.2308.008;
 Wed, 22 Sep 2021 08:27:44 +0800
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
Thread-Index: AQHXrvraMNZnMWAuzUKsEPXAU06oZquuFF8AgAEeIgA=
Date:   Wed, 22 Sep 2021 00:27:44 +0000
Message-ID: <545781e2bac049dea6a46164fce86267@huawei.com>
References: <20210921151039.1502-1-longpeng2@huawei.com>
 <20210921151039.1502-2-longpeng2@huawei.com> <YUn4Qq/vrqRai/FB@kroah.com>
In-Reply-To: <YUn4Qq/vrqRai/FB@kroah.com>
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
> Sent: Tuesday, September 21, 2021 11:21 PM
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
> > ---
> >  drivers/virt/nitro_enclaves/ne_misc_dev.c | 87
> ++++++++++++++++++++-----------
> >  1 file changed, 58 insertions(+), 29 deletions(-)
> >
> 
> What changed from v1?

It seems you missed the cover letter ?
