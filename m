Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AA9C399E13
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 11:50:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229718AbhFCJvq convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 3 Jun 2021 05:51:46 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3135 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbhFCJvq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 05:51:46 -0400
Received: from fraeml740-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Fwgv34Hg6z6S1MR;
        Thu,  3 Jun 2021 17:43:27 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml740-chm.china.huawei.com (10.206.15.221) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 3 Jun 2021 11:49:59 +0200
Received: from localhost (10.52.126.9) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Thu, 3 Jun 2021
 10:49:58 +0100
Date:   Thu, 3 Jun 2021 10:49:57 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Tian Tao <tiantao6@hisilicon.com>
CC:     <andriy.shevchenko@linux.intel.com>, <gregkh@linuxfoundation.org>,
        <rafael@kernel.org>, <akpm@linux-foundation.org>,
        <linux-kernel@vger.kernel.org>, <song.bao.hua@hisilicon.com>
Subject: Re: [PATCH v3 0/3] use bin_attribute to avoid buff overflow
Message-ID: <20210603104957.00007d1d@Huawei.com>
In-Reply-To: <1622712162-7028-1-git-send-email-tiantao6@hisilicon.com>
References: <1622712162-7028-1-git-send-email-tiantao6@hisilicon.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.52.126.9]
X-ClientProxiedBy: lhreml725-chm.china.huawei.com (10.201.108.76) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Jun 2021 17:22:39 +0800
Tian Tao <tiantao6@hisilicon.com> wrote:

> patch #1 adds a new function cpumap_print_to_buf and patch #2 uses
> this function in drivers/base/topology.c, and patch #3 uses this new
> function in drivers/base/node.c.
> 
> v3：
> fixed the strlen issue and patch #1,#2,#3 minor formatting issues, thanks
> to Andy Shevchenko and Jonathan Cameron.
> 
> v2:
> split the original patch #1 into two patches and use kasprintf() in
> patch #1 to simplify the code. do some minor formatting adjustments.
> 

All 3 patches now look good to me. Now I just need to get access to
a system that actually has enough CPUs to need this ;)

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> Tian Tao (3):
>   lib: bitmap: introduce bitmap_print_to_buf
>   topology: use bin_attribute to avoid buff overflow
>   drivers/base/node.c: use bin_attribute to avoid buff overflow
> 
>  drivers/base/node.c     |  52 ++++++++++++++--------
>  drivers/base/topology.c | 115 ++++++++++++++++++++++++++----------------------
>  include/linux/bitmap.h  |   3 ++
>  include/linux/cpumask.h |  21 +++++++++
>  lib/bitmap.c            |  37 +++++++++++++++-
>  5 files changed, 156 insertions(+), 72 deletions(-)
> 

