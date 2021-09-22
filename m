Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFDCE413EA7
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 02:33:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbhIVAfI convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 21 Sep 2021 20:35:08 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:19994 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbhIVAfH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 20:35:07 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4HDfLY4lwFzbmfs;
        Wed, 22 Sep 2021 08:29:25 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Wed, 22 Sep 2021 08:33:20 +0800
Received: from dggpeml100016.china.huawei.com (7.185.36.216) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Wed, 22 Sep 2021 08:33:19 +0800
Received: from dggpeml100016.china.huawei.com ([7.185.36.216]) by
 dggpeml100016.china.huawei.com ([7.185.36.216]) with mapi id 15.01.2308.008;
 Wed, 22 Sep 2021 08:33:19 +0800
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
Subject: RE: [PATCH v2 3/4] nitro_enclaves: add test framework for the misc
 functionality
Thread-Topic: [PATCH v2 3/4] nitro_enclaves: add test framework for the misc
 functionality
Thread-Index: AQHXrvrbICRRDj4Na0elarumsuHBnquuFHuAgAEe7eA=
Date:   Wed, 22 Sep 2021 00:33:19 +0000
Message-ID: <511306b230ed4347a4ba3a2f4d5d4e64@huawei.com>
References: <20210921151039.1502-1-longpeng2@huawei.com>
 <20210921151039.1502-4-longpeng2@huawei.com> <YUn4WTDbU72tcyNY@kroah.com>
In-Reply-To: <YUn4WTDbU72tcyNY@kroah.com>
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
> Subject: Re: [PATCH v2 3/4] nitro_enclaves: add test framework for the misc
> functionality
> 
> On Tue, Sep 21, 2021 at 11:10:38PM +0800, Longpeng(Mike) wrote:
> > Add test framework for the misc functionality.
> 
> What is "the misc functionality"?
> 

The functionalities provided in the ne_misc_dev.c

> >
> > Signed-off-by: Longpeng(Mike) <longpeng2@huawei.com>
> > ---
> >  drivers/virt/nitro_enclaves/Kconfig        |  8 ++++++++
> >  drivers/virt/nitro_enclaves/ne_misc_dev.c  | 27
> +++++++++++++++++++++++++++
> >  drivers/virt/nitro_enclaves/ne_misc_test.c | 17 +++++++++++++++++
> >  3 files changed, 52 insertions(+)
> >  create mode 100644 drivers/virt/nitro_enclaves/ne_misc_test.c
> 
> What changed from v1?
> 

The unit tests are new added in v2, described in the cover letter.

> thanks,
> 
> greg k-h
