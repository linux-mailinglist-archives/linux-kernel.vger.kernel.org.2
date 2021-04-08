Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 104F5357EA9
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 11:03:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230298AbhDHJDk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 05:03:40 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:2805 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbhDHJDj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 05:03:39 -0400
Received: from fraeml742-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4FGFRd5lk3z6880Q;
        Thu,  8 Apr 2021 16:53:49 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml742-chm.china.huawei.com (10.206.15.223) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Thu, 8 Apr 2021 11:03:22 +0200
Received: from localhost (10.47.84.3) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2106.2; Thu, 8 Apr 2021
 10:03:21 +0100
Date:   Thu, 8 Apr 2021 10:01:57 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Will Deacon <will@kernel.org>
CC:     Qi Liu <liuqi115@huawei.com>, <mark.rutland@arm.com>,
        <zhangshaokun@hisilicon.com>, <linuxarm@huawei.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] drivers/perf: hisi: Add driver for HiSilicon PCIe
 PMU
Message-ID: <20210408100157.000062f0@Huawei.com>
In-Reply-To: <20210407204004.GB16011@willie-the-truck>
References: <1617788943-52722-1-git-send-email-liuqi115@huawei.com>
        <1617788943-52722-2-git-send-email-liuqi115@huawei.com>
        <20210407204004.GB16011@willie-the-truck>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.84.3]
X-ClientProxiedBy: lhreml706-chm.china.huawei.com (10.201.108.55) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Apr 2021 21:40:05 +0100
Will Deacon <will@kernel.org> wrote:

> On Wed, Apr 07, 2021 at 05:49:02PM +0800, Qi Liu wrote:
> > PCIe PMU Root Complex Integrated End Point(RCiEP) device is supported
> > to sample bandwidth, latency, buffer occupation etc.
> > 
> > Each PMU RCiEP device monitors multiple root ports, and each RCiEP is
> > registered as a pmu in /sys/bus/event_source/devices, so users can
> > select target PMU, and use filter to do further sets.
> > 
> > Filtering options contains:
> > event        - select the event.
> > subevent     - select the subevent.
> > port         - select target root ports. Information of root ports
> >                are shown under sysfs.
> > bdf           - select requester_id of target EP device.
> > trig_len     - set trigger condition for starting event statistics.
> > trigger_mode - set trigger mode. 0 means starting to statistic when
> >                bigger than trigger condition, and 1 means smaller.
> > thr_len      - set threshold for statistics.
> > thr_mode     - set threshold mode. 0 means count when bigger than
> >                threshold, and 1 means smaller.
> > 
> > Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>  
> 
> Do you have a link to this review, please?

Internal review, so drop the tag.

Jonathan

> 
> Will
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

