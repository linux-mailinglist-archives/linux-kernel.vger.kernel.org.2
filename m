Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF3D337F122
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 04:08:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230126AbhEMCJo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 22:09:44 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:3737 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbhEMCJm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 22:09:42 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FgZjx5xjqzpdrS;
        Thu, 13 May 2021 10:05:09 +0800 (CST)
Received: from [10.67.102.118] (10.67.102.118) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.498.0; Thu, 13 May 2021 10:08:28 +0800
Subject: Re: [RFC PATCH 2/3] vfio/hisilicon: register the driver to vfio
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     Alex Williamson <alex.williamson@redhat.com>, <cohuck@redhat.com>,
        <linux-kernel@vger.kernel.org>, <linuxarm@openeuler.org>
References: <1618284983-55581-3-git-send-email-liulongfang@huawei.com>
 <20210415220137.GA1672608@nvidia.com>
 <10d53c5d-e6d5-a165-84b2-eaf8a3b7dcce@huawei.com>
 <20210419123314.GT1370958@nvidia.com>
 <00c4fa43-21fa-a48b-b95d-a2310ffab725@huawei.com>
 <20210420125957.GA1370958@nvidia.com>
 <20210420160457.6b91850a@x1.home.shazbot.org>
 <25d033e6-1cba-0da0-2ee7-03a14e75b8a5@huawei.com>
 <20210421121224.62382e5d@redhat.com>
 <6ea89655-31c5-233b-ca2a-fcc166b5597c@huawei.com>
 <20210512121053.GT1002214@nvidia.com>
From:   liulongfang <liulongfang@huawei.com>
Message-ID: <3eaa3114-81b6-1bd9-c7e6-cb1541389b58@huawei.com>
Date:   Thu, 13 May 2021 10:08:28 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20210512121053.GT1002214@nvidia.com>
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.102.118]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/5/12 20:10, Jason Gunthorpe wrote:
> On Wed, May 12, 2021 at 04:39:43PM +0800, liulongfang wrote:
> 
>> Therefore, this method of limiting the length of the BAR
>> configuration space can prevent unsafe operations of the memory.
> 
> The issue is DMA controlled by the guest accessing the secure BAR
> area, not the guest CPU.
> 
> Jason
> .
> 
This secure BAR area is not presented to the Guest,
which makes it impossible for the Guest to obtain the secure BAR area
when establishing the DMA mapping of the configuration space.
If the DMA controller accesses the secure BAR area, the access will
be blocked by the SMMU.

Thanks
Longfang.
