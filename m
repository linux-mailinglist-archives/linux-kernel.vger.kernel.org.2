Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B98E3D5522
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 10:15:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233038AbhGZHdJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 03:33:09 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3482 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233092AbhGZHc7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 03:32:59 -0400
Received: from fraeml745-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4GYCBC66hNz6DHcW;
        Mon, 26 Jul 2021 16:04:19 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml745-chm.china.huawei.com (10.206.15.226) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 26 Jul 2021 10:13:26 +0200
Received: from [10.47.94.42] (10.47.94.42) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Mon, 26 Jul
 2021 09:13:25 +0100
Subject: Re: [PATCH 00/23] iommu: Refactor DMA domain strictness
To:     Robin Murphy <robin.murphy@arm.com>, <joro@8bytes.org>,
        <will@kernel.org>
CC:     <iommu@lists.linux-foundation.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <suravee.suthikulpanit@amd.com>,
        <baolu.lu@linux.intel.com>, <dianders@chromium.org>
References: <cover.1626888444.git.robin.murphy@arm.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <8e9da41e-4e3a-7098-bece-7f6cba89a2aa@huawei.com>
Date:   Mon, 26 Jul 2021 09:13:08 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <cover.1626888444.git.robin.murphy@arm.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.94.42]
X-ClientProxiedBy: lhreml748-chm.china.huawei.com (10.201.108.198) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/07/2021 19:20, Robin Murphy wrote:
> Hi all,
> 
> First off, yes, this conflicts with just about everything else
> currently in-flight. Sorry about that. If it stands up to initial review
> then I'll start giving some thought to how to fit everything together
> (particularly John's cleanup of strictness defaults, which I'd be
> inclined to fold into a v2 of this series).

It seems to me that patch #20 is the only real conflict, and that is 
just a different form of mine in that passthrough, strict, and lazy are 
under a single choice, as opposed to passthrough being a separate config 
(for mine). And on that point, I did assume that we would have a 
different sysfs file for strict vs lazy in this series, and not a new 
domain type. But I assume that there is a good reason for that.

Anyway, I'd really like to see my series just merged now.

Thanks,
John


> 
> Anyway, this is my take on promoting the strict vs. non-strict DMA
> domain choice to distinct domain types, so that it can fit logically
> into the existing sysfs and Kconfig controls. The first 13 patches are
> effectively preparatory cleanup to reduce churn in the later changes,
> but could be merged in their own right even if the rest is too
> contentious. I ended up splitting patches #2-#11 by driver for ease of
> review, since some of them are more than just trivial deletions, but
> they could readily be squashed (even as far as with #1 and #12 too).
> 
> I'm slightly surprised at how straightforward it's turned out, but it
> has survived some very basic smoke testing for arm-smmu using dmatest
> on my Arm Juno board. Branch here for convenience:

