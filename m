Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCB233AB1DD
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 13:03:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231955AbhFQLFv convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 17 Jun 2021 07:05:51 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:5024 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231704AbhFQLFu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 07:05:50 -0400
Received: from dggeme766-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4G5JvK686qzXglH;
        Thu, 17 Jun 2021 18:58:37 +0800 (CST)
Received: from dggemi761-chm.china.huawei.com (10.1.198.147) by
 dggeme766-chm.china.huawei.com (10.3.19.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Thu, 17 Jun 2021 19:03:40 +0800
Received: from dggemi761-chm.china.huawei.com ([10.9.49.202]) by
 dggemi761-chm.china.huawei.com ([10.9.49.202]) with mapi id 15.01.2176.012;
 Thu, 17 Jun 2021 19:03:40 +0800
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
Thread-Index: AQHXY2JrYee8elXzC0+JGLwcUOk3AasXgdSAgACGfnA=
Date:   Thu, 17 Jun 2021 11:03:40 +0000
Message-ID: <f78a451e1ff5471c9a671ab163df62d6@hisilicon.com>
References: <20210617101910.13228-1-song.bao.hua@hisilicon.com>
 <20210617101910.13228-3-song.bao.hua@hisilicon.com>
 <YMsqP8kf260O6JPJ@kroah.com>
In-Reply-To: <YMsqP8kf260O6JPJ@kroah.com>
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
> Sent: Thursday, June 17, 2021 10:56 PM
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
> As with the other patch, you have to also sign off on this as well.
> 
Ok. Will add my s-o-b for patch 1-3.

> The link is pointing to a v5 of a different patch series, why put that
> here?

This patchset originated from the discussion of that one in the
link tag.

Jonathan and me were trying to add a cluster topology level.
And that one exposed the problem this patchset is addressing.

> 
> thanks,
> 
> greg k-h

Thanks
Barry

