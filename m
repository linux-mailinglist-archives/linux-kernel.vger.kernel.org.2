Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D991396DBB
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 09:04:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233072AbhFAHGR convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 1 Jun 2021 03:06:17 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:3364 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231928AbhFAHGR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 03:06:17 -0400
Received: from dggeme710-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4FvNNM0J2wz67Qq;
        Tue,  1 Jun 2021 15:00:51 +0800 (CST)
Received: from dggemi761-chm.china.huawei.com (10.1.198.147) by
 dggeme710-chm.china.huawei.com (10.1.199.106) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Tue, 1 Jun 2021 15:04:34 +0800
Received: from dggemi761-chm.china.huawei.com ([10.9.49.202]) by
 dggemi761-chm.china.huawei.com ([10.9.49.202]) with mapi id 15.01.2176.012;
 Tue, 1 Jun 2021 15:04:33 +0800
From:   "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
To:     Greg KH <gregkh@linuxfoundation.org>,
        "tiantao (H)" <tiantao6@hisilicon.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: RE: [PATCH 1/2] topology: use bin_attribute to avoid buff overflow
Thread-Topic: [PATCH 1/2] topology: use bin_attribute to avoid buff overflow
Thread-Index: AQHXVpHLdxqqXqYHy0SNrz7+ZdO1FKr+ElmAgAClbEA=
Date:   Tue, 1 Jun 2021 07:04:33 +0000
Message-ID: <cb90096ab76d4a55a59d0682fa786ba5@hisilicon.com>
References: <1622516210-10886-1-git-send-email-tiantao6@hisilicon.com>
 <1622516210-10886-2-git-send-email-tiantao6@hisilicon.com>
 <YLW+hZwoImx2wjwS@kroah.com>
In-Reply-To: <YLW+hZwoImx2wjwS@kroah.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.126.201.217]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Greg KH [mailto:gregkh@linuxfoundation.org]
> Sent: Tuesday, June 1, 2021 4:59 PM
> To: tiantao (H) <tiantao6@hisilicon.com>
> Cc: linux-kernel@vger.kernel.org; akpm@linux-foundation.org; Song Bao Hua
> (Barry Song) <song.bao.hua@hisilicon.com>; Andy Shevchenko
> <andriy.shevchenko@linux.intel.com>; Rafael J. Wysocki <rafael@kernel.org>
> Subject: Re: [PATCH 1/2] topology: use bin_attribute to avoid buff overflow
> 
> On Tue, Jun 01, 2021 at 10:56:49AM +0800, Tian Tao wrote:
> > Reading sys/devices/system/cpu/cpuX/topology/ returns cpu topology.
> > However, the size of this file is limited to PAGE_SIZE because of the
> > limitation for sysfs attribute. so we use bin_attribute instead of
> > attribute to avoid NR_CPUS too big to cause buff overflow.
> >
> > This patch is based on the following discussion.
> > https://www.spinics.net/lists/linux-doc/msg95921.html
> 
> Please use lore.kernel.org for links as we have no control over other
> sites to ensure that they will work in the future.  Use the message id
> in the link as well, so that if something were to happen to lore, we can
> figure it out.
> 
> Also, you are modifying a bunch of different files here, do you mean to
> do it for all of them?

The plan is providing a common wrapper similar with cpumap_print_to_pagebuf
so that all modules which have bitmap and list topology ABI can move to use
it.

Right now, drivers/base/topology.c and drivers/base/node.c are the first
two examples involved. We are still having around 40 other places in
the todo list.

Thanks
Barry

