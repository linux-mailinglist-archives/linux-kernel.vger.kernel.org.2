Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2D3C3583F0
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 14:57:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231607AbhDHM5o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 08:57:44 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:2807 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231371AbhDHM5n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 08:57:43 -0400
Received: from fraeml712-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4FGLhh6ZXVz67vP6;
        Thu,  8 Apr 2021 20:50:28 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml712-chm.china.huawei.com (10.206.15.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Thu, 8 Apr 2021 14:57:31 +0200
Received: from [10.47.1.29] (10.47.1.29) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Thu, 8 Apr 2021
 13:57:30 +0100
Subject: Re: [PATCH 1/2] drivers/perf: hisi: Add driver for HiSilicon PCIe PMU
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Will Deacon <will@kernel.org>
CC:     "liuqi (BA)" <liuqi115@huawei.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        Zhangshaokun <zhangshaokun@hisilicon.com>,
        Linuxarm <linuxarm@huawei.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <1617788943-52722-1-git-send-email-liuqi115@huawei.com>
 <1617788943-52722-2-git-send-email-liuqi115@huawei.com>
 <20210407204004.GB16011@willie-the-truck>
 <20210408100157.000062f0@Huawei.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <16a7a3f8-82b5-a113-57c0-a9d575c649bd@huawei.com>
Date:   Thu, 8 Apr 2021 13:55:02 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20210408100157.000062f0@Huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.1.29]
X-ClientProxiedBy: lhreml716-chm.china.huawei.com (10.201.108.67) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/04/2021 10:01, Jonathan Cameron wrote:
> On Wed, 7 Apr 2021 21:40:05 +0100
> Will Deacon <will@kernel.org> wrote:
> 
>> On Wed, Apr 07, 2021 at 05:49:02PM +0800, Qi Liu wrote:
>>> PCIe PMU Root Complex Integrated End Point(RCiEP) device is supported
>>> to sample bandwidth, latency, buffer occupation etc.
>>>
>>> Each PMU RCiEP device monitors multiple root ports, and each RCiEP is
>>> registered as a pmu in /sys/bus/event_source/devices, so users can
>>> select target PMU, and use filter to do further sets.
>>>
>>> Filtering options contains:
>>> event        - select the event.
>>> subevent     - select the subevent.
>>> port         - select target root ports. Information of root ports
>>>                 are shown under sysfs.
>>> bdf           - select requester_id of target EP device.
>>> trig_len     - set trigger condition for starting event statistics.
>>> trigger_mode - set trigger mode. 0 means starting to statistic when
>>>                 bigger than trigger condition, and 1 means smaller.
>>> thr_len      - set threshold for statistics.
>>> thr_mode     - set threshold mode. 0 means count when bigger than
>>>                 threshold, and 1 means smaller.
>>>
>>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>>
>> Do you have a link to this review, please?
> 
> Internal review, so drop the tag.
> 
> Jonathan

Hi Will,

Are you implying that you would rather that any review for these drivers 
is done in public on the lists?

Cheers,
John
