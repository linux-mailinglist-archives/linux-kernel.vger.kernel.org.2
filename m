Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9DA33472B8
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 08:34:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232280AbhCXHda convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 24 Mar 2021 03:33:30 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:3381 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231842AbhCXHdZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 03:33:25 -0400
Received: from dggeme759-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4F50Jr2qCHz5gP7;
        Wed, 24 Mar 2021 15:30:52 +0800 (CST)
Received: from dggemi761-chm.china.huawei.com (10.1.198.147) by
 dggeme759-chm.china.huawei.com (10.3.19.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2106.2; Wed, 24 Mar 2021 15:33:23 +0800
Received: from dggemi761-chm.china.huawei.com ([10.9.49.202]) by
 dggemi761-chm.china.huawei.com ([10.9.49.202]) with mapi id 15.01.2106.013;
 Wed, 24 Mar 2021 15:33:23 +0800
From:   "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
To:     Christoph Hellwig <hch@lst.de>,
        "tiantao (H)" <tiantao6@hisilicon.com>
CC:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "paulmck@kernel.org" <paulmck@kernel.org>,
        "ast@kernel.org" <ast@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] dma-mapping: make map_benchmark compile into module
Thread-Topic: [PATCH] dma-mapping: make map_benchmark compile into module
Thread-Index: AQHXIFPOFGbiIAxEO0+6jc+KbhZliqqSM4CAgACIJUA=
Date:   Wed, 24 Mar 2021 07:33:23 +0000
Message-ID: <6153f9d247214d58b5eb7a76cb1258b3@hisilicon.com>
References: <1616552258-22282-1-git-send-email-tiantao6@hisilicon.com>
 <20210324071305.GB647@lst.de>
In-Reply-To: <20210324071305.GB647@lst.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.126.201.12]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Christoph Hellwig [mailto:hch@lst.de]
> Sent: Wednesday, March 24, 2021 8:13 PM
> To: tiantao (H) <tiantao6@hisilicon.com>
> Cc: akpm@linux-foundation.org; peterz@infradead.org; paulmck@kernel.org;
> ast@kernel.org; tglx@linutronix.de; rostedt@goodmis.org; hch@lst.de;
> m.szyprowski@samsung.com; Song Bao Hua (Barry Song)
> <song.bao.hua@hisilicon.com>; iommu@lists.linux-foundation.org;
> linux-kernel@vger.kernel.org
> Subject: Re: [PATCH] dma-mapping: make map_benchmark compile into module
> 
> On Wed, Mar 24, 2021 at 10:17:38AM +0800, Tian Tao wrote:
> > under some scenarios, it is necessary to compile map_benchmark
> > into module to test iommu, so this patch changed Kconfig and
> > export_symbol to implement map_benchmark compiled into module.
> >
> > On the other hand, map_benchmark is a driver, which is supposed
> > to be able to run as a module.
> >
> > Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
> 
> Nope, we're not going to export more kthread internals for a test
> module.

The requirement comes from an colleague who is frequently changing
the map-bench code for some customized test purpose. and he doesn't
want to build kernel image and reboot every time. So I moved the
requirement to Tao Tian.

Right now, kthread_bind() is exported, kthread_bind_mask() seems
to be a little bit "internal" as you said, maybe a wrapper like
kthread_bind_node() won't be that "internal", comparing to exposing
the cpumask?
Anyway, we don't find other driver users for this, hardly I can
convince you it is worth.

Thanks
Barry
