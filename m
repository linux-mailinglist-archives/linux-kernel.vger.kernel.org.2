Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 046BA3DDD5A
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 18:17:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232196AbhHBQRH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 12:17:07 -0400
Received: from foss.arm.com ([217.140.110.172]:38242 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229805AbhHBQRG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 12:17:06 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0D8D111D4;
        Mon,  2 Aug 2021 09:16:57 -0700 (PDT)
Received: from [10.57.36.146] (unknown [10.57.36.146])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EE1363F66F;
        Mon,  2 Aug 2021 09:16:53 -0700 (PDT)
Subject: Re: [PATCH v4 5/6] iova: Add iova_len argument to init_iova_domain()
To:     John Garry <john.garry@huawei.com>, Will Deacon <will@kernel.org>
Cc:     joro@8bytes.org, baolu.lu@linux.intel.com,
        iommu@lists.linux-foundation.org, linuxarm@huawei.com,
        thierry.reding@gmail.com, airlied@linux.ie, daniel@ffwll.ch,
        jonathanh@nvidia.com, sakari.ailus@linux.intel.com,
        bingbu.cao@intel.com, tian.shu.qiu@intel.com, mchehab@kernel.org,
        gregkh@linuxfoundation.org, digetx@gmail.com, mst@redhat.com,
        jasowang@redhat.com, linux-kernel@vger.kernel.org,
        chenxiang66@hisilicon.com
References: <1626259003-201303-1-git-send-email-john.garry@huawei.com>
 <1626259003-201303-6-git-send-email-john.garry@huawei.com>
 <20210802150644.GD28735@willie-the-truck>
 <c6be0b9f-531b-dc12-2747-3acbecfcd531@huawei.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <1d06eda1-9961-d023-f5e7-fe87e768f067@arm.com>
Date:   Mon, 2 Aug 2021 17:16:48 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <c6be0b9f-531b-dc12-2747-3acbecfcd531@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-08-02 17:06, John Garry wrote:
> On 02/08/2021 16:06, Will Deacon wrote:
>> On Wed, Jul 14, 2021 at 06:36:42PM +0800, John Garry wrote:
>>> Add max opt argument to init_iova_domain(), and use it to set the 
>>> rcaches
>>> range.
>>>
>>> Also fix up all users to set this value (at 0, meaning use default).
>> Wrap that in init_iova_domain_defaults() to avoid the mysterious 0?
> 
> Sure, I can do something like that. I actually did have separate along 
> those lines in v3 before I decided to change it.

Y'know, at this point I'm now starting to seriously wonder whether 
moving the rcaches into iommu_dma_cookie wouldn't make a whole lot of 
things simpler... :/

Does that sound like crazy talk to you, or an idea worth entertaining?

Robin.
