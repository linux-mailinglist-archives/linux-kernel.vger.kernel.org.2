Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EBAD3AB1ED
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 13:06:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232021AbhFQLIn convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 17 Jun 2021 07:08:43 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:4956 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232358AbhFQLIS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 07:08:18 -0400
Received: from dggeme715-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4G5K0L6lVTz70nk;
        Thu, 17 Jun 2021 19:02:58 +0800 (CST)
Received: from dggemi761-chm.china.huawei.com (10.1.198.147) by
 dggeme715-chm.china.huawei.com (10.1.199.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Thu, 17 Jun 2021 19:06:09 +0800
Received: from dggemi761-chm.china.huawei.com ([10.9.49.202]) by
 dggemi761-chm.china.huawei.com ([10.9.49.202]) with mapi id 15.01.2176.012;
 Thu, 17 Jun 2021 19:06:09 +0800
From:   "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux@rasmusvillemoes.dk" <linux@rasmusvillemoes.dk>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "agordeev@linux.ibm.com" <agordeev@linux.ibm.com>,
        "sbrivio@redhat.com" <sbrivio@redhat.com>,
        "jianpeng.ma@intel.com" <jianpeng.ma@intel.com>,
        "yury.norov@gmail.com" <yury.norov@gmail.com>,
        "valentin.schneider@arm.com" <valentin.schneider@arm.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "bristot@redhat.com" <bristot@redhat.com>,
        "guodong.xu@linaro.org" <guodong.xu@linaro.org>,
        tangchengchang <tangchengchang@huawei.com>,
        "Zengtao (B)" <prime.zeng@hisilicon.com>,
        yangyicong <yangyicong@huawei.com>,
        "tim.c.chen@linux.intel.com" <tim.c.chen@linux.intel.com>,
        "tiantao (H)" <tiantao6@hisilicon.com>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Linuxarm <linuxarm@huawei.com>
Subject: RE: [PATCH v4 2/4] topology: use bin_attribute to avoid buff overflow
Thread-Topic: [PATCH v4 2/4] topology: use bin_attribute to avoid buff
 overflow
Thread-Index: AQHXY2JrYee8elXzC0+JGLwcUOk3AasXgXWAgACIzjA=
Date:   Thu, 17 Jun 2021 11:06:08 +0000
Message-ID: <067dcbcac2594accbcff48e4365a025c@hisilicon.com>
References: <20210617101910.13228-1-song.bao.hua@hisilicon.com>
 <20210617101910.13228-3-song.bao.hua@hisilicon.com>
 <YMsp704yqr/JW3cF@kroah.com>
In-Reply-To: <YMsp704yqr/JW3cF@kroah.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.126.201.234]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Greg KH [mailto:gregkh@linuxfoundation.org]
> Sent: Thursday, June 17, 2021 10:55 PM
> To: Song Bao Hua (Barry Song) <song.bao.hua@hisilicon.com>
> Cc: andriy.shevchenko@linux.intel.com; linux-kernel@vger.kernel.org;
> linux@rasmusvillemoes.dk; rafael@kernel.org; akpm@linux-foundation.org;
> rdunlap@infradead.org; agordeev@linux.ibm.com; sbrivio@redhat.com;
> jianpeng.ma@intel.com; yury.norov@gmail.com; valentin.schneider@arm.com;
> peterz@infradead.org; bristot@redhat.com; guodong.xu@linaro.org;
> tangchengchang <tangchengchang@huawei.com>; Zengtao (B)
> <prime.zeng@hisilicon.com>; yangyicong <yangyicong@huawei.com>;
> tim.c.chen@linux.intel.com; tiantao (H) <tiantao6@hisilicon.com>; Jonathan
> Cameron <jonathan.cameron@huawei.com>; Linuxarm <linuxarm@huawei.com>
> Subject: Re: [PATCH v4 2/4] topology: use bin_attribute to avoid buff overflow
> 
> On Thu, Jun 17, 2021 at 10:19:08PM +1200, Barry Song wrote:
> > From: Tian Tao <tiantao6@hisilicon.com>
> >
> > Reading sys/devices/system/cpu/cpuX/topology/ returns cpu topology.
> > However, the size of this file is limited to PAGE_SIZE because of the
> > limitation for sysfs attribute. so we use bin_attribute instead of
> > attribute to avoid NR_CPUS too big to cause buff overflow.
> >
> > Link:
> https://lore.kernel.org/lkml/20210319041618.14316-2-song.bao.hua@hisilicon
> .com/
> > Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
> > Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> 
> Is this whole series supposed to go through my tree?

I guess so, and that would be perfect.

> 
> If so I'll wait on it based on my comments so far, otherwise I would
> give an ack for this one...
> 

I will address those issues in your comments.


> thanks,
> 
> greg k-h

Thanks
Barry

