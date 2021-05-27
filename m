Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85328392B84
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 12:12:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236144AbhE0KNs convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 27 May 2021 06:13:48 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:5112 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236061AbhE0KNj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 06:13:39 -0400
Received: from dggeml763-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4FrNpB2cTpzYn83;
        Thu, 27 May 2021 18:09:22 +0800 (CST)
Received: from dggpemm000002.china.huawei.com (7.185.36.174) by
 dggeml763-chm.china.huawei.com (10.1.199.173) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Thu, 27 May 2021 18:12:01 +0800
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 dggpemm000002.china.huawei.com (7.185.36.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 27 May 2021 18:12:01 +0800
Received: from lhreml710-chm.china.huawei.com ([169.254.81.184]) by
 lhreml710-chm.china.huawei.com ([169.254.81.184]) with mapi id
 15.01.2176.012; Thu, 27 May 2021 11:11:59 +0100
From:   Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Alex Williamson <alex.williamson@redhat.com>
CC:     liulongfang <liulongfang@huawei.com>,
        "cohuck@redhat.com" <cohuck@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxarm@openeuler.org" <linuxarm@openeuler.org>,
        "mgurtovoy@nvidia.com" <mgurtovoy@nvidia.com>,
        "Zengtao (B)" <prime.zeng@hisilicon.com>
Subject: RE: [Linuxarm]  Re: [RFC PATCH 2/3] vfio/hisilicon: register the
 driver to vfio
Thread-Topic: [Linuxarm]  Re: [RFC PATCH 2/3] vfio/hisilicon: register the
 driver to vfio
Thread-Index: AQHXMkL9mza0TJ8TfUm11z5ygPSvFqq7zAN3gAL2j3WAAIzL6IAgnBJYgAGsWYGAACE9wIAABZSAgAAb/VD///p5gIAUFV6Q
Date:   Thu, 27 May 2021 10:11:58 +0000
Message-ID: <0301a502747748968393aa3e3b0a849d@huawei.com>
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
x-originating-ip: [10.47.26.21]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[+]

Hi,

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
> 
> I think we are very close to having worked out a great solution to the
> lingering questions on Max's last RFC, hopefully we can post an
> updated version soon

We have now integrated this HiSilicon ACC live migration driver into the
proposed[0] vfio-pci-core subsystem framework. Basically now have
a new vendor extension driver based on this framework. It indeed makes it
easy to do the registration to vfio core and overriding of functions if required.
Performed some basic sanity tests with the prototype and it seems to be
working.

Also, we now managed to get rid of any access to Guest VF dev MMIO space
during the (VFIO_DEVICE_STATE_SAVING | VFIO_DEVICE_STATE_RUNNING)
state. However we still need to access the Guest VF MMIO space during 
few other device states eg; VFIO_DEVICE_STATE_SAVING, VFIO_DEVICE_STATE_STOP
etc. These accesses are to save and restore device register states. As per our
analysis the Guest vCPUs are in stopped state at these device states. So I
hope we don't have any security related holes with these accesses.

Please let us know if we miss something or anything else to be taken care of with
this approach.

We are planning to send out a revised RFC soon, and if there is a plan to
post an updated one to Max's series as mentioned above, will base
it on that one. Please let us know.

Thanks,
Shameer
[0] https://lore.kernel.org/lkml/20210310123127.GT2356281@nvidia.com/T/


