Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BCA73873C5
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 10:11:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347403AbhERIKa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 04:10:30 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:4657 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347386AbhERIKV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 04:10:21 -0400
Received: from dggems705-chm.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FkpVG6RCZz16Pm7;
        Tue, 18 May 2021 16:06:14 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 dggems705-chm.china.huawei.com (10.3.19.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 18 May 2021 16:08:59 +0800
Received: from [10.47.83.99] (10.47.83.99) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Tue, 18 May
 2021 09:08:57 +0100
Subject: Re: [PATCH 1/9] perf: Add EVENT_ATTR_ID to simplify event attributes
To:     Qi Liu <liuqi115@huawei.com>, <will@kernel.org>,
        <mark.rutland@arm.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
        <zhangshaokun@hisilicon.com>
References: <1621322628-9945-1-git-send-email-liuqi115@huawei.com>
 <1621322628-9945-2-git-send-email-liuqi115@huawei.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <d3712491-ca60-ef9f-e56f-d000775dd7f1@huawei.com>
Date:   Tue, 18 May 2021 09:07:56 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <1621322628-9945-2-git-send-email-liuqi115@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.83.99]
X-ClientProxiedBy: lhreml716-chm.china.huawei.com (10.201.108.67) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/05/2021 08:23, Qi Liu wrote:
> Similar EVENT_ATTR macros are defined in many PMU drivers,
> like HiSilicon PMU driver, Arm PMU driver, Arm SMMU PMU
> driver. So Add a generic macro to simplify code.
> 
> Signed-off-by: Qi Liu <liuqi115@huawei.com>
> ---
>   include/linux/perf_event.h | 6 ++++++
>   kernel/events/core.c       | 2 ++
>   2 files changed, 8 insertions(+)
> 

I think that you need to resend with all the maintainers for these files 
included.

Thanks
