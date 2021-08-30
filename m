Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B38F43FB22B
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 09:57:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234376AbhH3H6O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 03:58:14 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:15231 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233318AbhH3H6N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 03:58:13 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4GyjMC0MjLz1DF2w;
        Mon, 30 Aug 2021 15:56:39 +0800 (CST)
Received: from dggpemm500004.china.huawei.com (7.185.36.219) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 30 Aug 2021 15:57:09 +0800
Received: from [10.174.177.91] (10.174.177.91) by
 dggpemm500004.china.huawei.com (7.185.36.219) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Mon, 30 Aug 2021 15:57:09 +0800
Subject: Re: [PATCH -next v4 2/2] iommu/arm-smmu-v3: Add suspend and resume
 support
From:   Bixuan Cui <cuibixuan@huawei.com>
To:     <iommu@lists.linux-foundation.org>, <linux-kernel@vger.kernel.org>
CC:     <will@kernel.org>, <gregkh@linuxfoundation.org>,
        <rafael@kernel.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
        <jean-philippe@linaro.org>, <Jonathan.Cameron@huawei.com>,
        <thunder.leizhen@huawei.com>, <maz@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20210830073858.47084-1-cuibixuan@huawei.com>
 <20210830073858.47084-2-cuibixuan@huawei.com>
Message-ID: <7087f98c-a59e-00a3-2eae-958c25c1ac3c@huawei.com>
Date:   Mon, 30 Aug 2021 15:57:08 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20210830073858.47084-2-cuibixuan@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.91]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500004.china.huawei.com (7.185.36.219)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/8/30 15:38, Bixuan Cui wrote:
> Changes in v4:
> * Restore the arm_smmu_suspend() function code to the v2 version(Directly return 0 in it).
Hello,
I looked up the code of smmu.c and the manual of smmu v3. For the suspend is implemented
by the external clock-gating, it is not clear what the SMMUv3 needs to do. Is it the same
as that in smmu.c?
I roll back the code here, and hope to get some advice.

Thanks,
Bixuan Cui
