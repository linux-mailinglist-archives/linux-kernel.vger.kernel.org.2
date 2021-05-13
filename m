Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4568537FD4D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 20:35:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231513AbhEMSge convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 13 May 2021 14:36:34 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:2430 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230125AbhEMSgb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 14:36:31 -0400
Received: from dggeml765-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Fh0dK4SNkz61XZ;
        Fri, 14 May 2021 02:32:37 +0800 (CST)
Received: from dggemi712-chm.china.huawei.com (10.3.20.111) by
 dggeml765-chm.china.huawei.com (10.1.199.175) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Fri, 14 May 2021 02:35:18 +0800
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 dggemi712-chm.china.huawei.com (10.3.20.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Fri, 14 May 2021 02:35:17 +0800
Received: from lhreml710-chm.china.huawei.com ([169.254.81.184]) by
 lhreml710-chm.china.huawei.com ([169.254.81.184]) with mapi id
 15.01.2176.012; Thu, 13 May 2021 19:35:15 +0100
From:   Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     Alex Williamson <alex.williamson@redhat.com>,
        liulongfang <liulongfang@huawei.com>,
        "cohuck@redhat.com" <cohuck@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxarm@openeuler.org" <linuxarm@openeuler.org>
Subject: RE: [Linuxarm]  Re: [RFC PATCH 2/3] vfio/hisilicon: register the
 driver to vfio
Thread-Topic: [Linuxarm]  Re: [RFC PATCH 2/3] vfio/hisilicon: register the
 driver to vfio
Thread-Index: AQHXMkL9mza0TJ8TfUm11z5ygPSvFqq7zAN3gAL2j3WAAIzL6IAgnBJYgAGsWYGAACE9wIAABZSAgAAb/VD///p5gIAAEurA
Date:   Thu, 13 May 2021 18:35:15 +0000
Message-ID: <46db963416df47d0b2552e62f57855dc@huawei.com>
References: <20210420160457.6b91850a@x1.home.shazbot.org>
 <25d033e6-1cba-0da0-2ee7-03a14e75b8a5@huawei.com>
 <20210421121224.62382e5d@redhat.com>
 <6ea89655-31c5-233b-ca2a-fcc166b5597c@huawei.com>
 <20210512121053.GT1002214@nvidia.com>
 <3eaa3114-81b6-1bd9-c7e6-cb1541389b58@huawei.com>
 <20210513134422.GD1002214@nvidia.com>
 <e3db0c328da6411ea2ae07595ed5f6c3@huawei.com>
 <20210513110349.68e3d59d@redhat.com>
 <1035a9a9b03b43dd9f859136ed84a7f8@huawei.com>
 <20210513182413.GO1002214@nvidia.com>
In-Reply-To: <20210513182413.GO1002214@nvidia.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.47.81.63]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Jason Gunthorpe [mailto:jgg@nvidia.com]
> Sent: 13 May 2021 19:24
> To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
> Cc: Alex Williamson <alex.williamson@redhat.com>; liulongfang
> <liulongfang@huawei.com>; cohuck@redhat.com;
> linux-kernel@vger.kernel.org; linuxarm@openeuler.org
> Subject: Re: [Linuxarm] Re: [RFC PATCH 2/3] vfio/hisilicon: register the driver to
> vfio
> 
> On Thu, May 13, 2021 at 05:52:56PM +0000, Shameerali Kolothum Thodi
> wrote:
> 
> > Since the devices we are concerned here are all integrated endpoints and if
> the
> > above quirk is an acceptable one, then we can use the uAPI as done in this
> > series without overly complicating things here.
> 
> IMHO such a quirk in the core code should not be done. You need to
> override this in your own driver like Max was showing.

Ok. Sure, will take a look at that.

> I think we are very close to having worked out a great solution to the
> lingering questions on Max's last RFC, hopefully we can post an
> updated version soon

Cool. If possible kindly CC us when it happens.

Thanks,
Shameer

