Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FFD43DDD27
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 18:07:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232509AbhHBQHh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 12:07:37 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3559 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232269AbhHBQHa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 12:07:30 -0400
Received: from fraeml707-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4GdjZ63gtqz6FFxq;
        Tue,  3 Aug 2021 00:07:10 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml707-chm.china.huawei.com (10.206.15.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 2 Aug 2021 18:07:17 +0200
Received: from [10.47.87.154] (10.47.87.154) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Mon, 2 Aug 2021
 17:07:16 +0100
Subject: Re: [PATCH v4 5/6] iova: Add iova_len argument to init_iova_domain()
To:     Will Deacon <will@kernel.org>
CC:     <joro@8bytes.org>, <robin.murphy@arm.com>,
        <baolu.lu@linux.intel.com>, <iommu@lists.linux-foundation.org>,
        <linuxarm@huawei.com>, <thierry.reding@gmail.com>,
        <airlied@linux.ie>, <daniel@ffwll.ch>, <jonathanh@nvidia.com>,
        <sakari.ailus@linux.intel.com>, <bingbu.cao@intel.com>,
        <tian.shu.qiu@intel.com>, <mchehab@kernel.org>,
        <gregkh@linuxfoundation.org>, <digetx@gmail.com>, <mst@redhat.com>,
        <jasowang@redhat.com>, <linux-kernel@vger.kernel.org>,
        <chenxiang66@hisilicon.com>
References: <1626259003-201303-1-git-send-email-john.garry@huawei.com>
 <1626259003-201303-6-git-send-email-john.garry@huawei.com>
 <20210802150644.GD28735@willie-the-truck>
From:   John Garry <john.garry@huawei.com>
Message-ID: <c6be0b9f-531b-dc12-2747-3acbecfcd531@huawei.com>
Date:   Mon, 2 Aug 2021 17:06:48 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <20210802150644.GD28735@willie-the-truck>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.87.154]
X-ClientProxiedBy: lhreml713-chm.china.huawei.com (10.201.108.64) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/08/2021 16:06, Will Deacon wrote:
> On Wed, Jul 14, 2021 at 06:36:42PM +0800, John Garry wrote:
>> Add max opt argument to init_iova_domain(), and use it to set the rcaches
>> range.
>>
>> Also fix up all users to set this value (at 0, meaning use default).
> Wrap that in init_iova_domain_defaults() to avoid the mysterious 0?

Sure, I can do something like that. I actually did have separate along 
those lines in v3 before I decided to change it.

Thanks,
John
