Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4B5E413769
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 18:20:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234579AbhIUQV2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 12:21:28 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3849 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234798AbhIUQVA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 12:21:00 -0400
Received: from fraeml701-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4HDRQN2PlBz67Cqk;
        Wed, 22 Sep 2021 00:17:00 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml701-chm.china.huawei.com (10.206.15.50) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.8; Tue, 21 Sep 2021 18:19:28 +0200
Received: from [10.47.82.229] (10.47.82.229) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Tue, 21 Sep
 2021 17:19:28 +0100
Subject: Re: [PATCH] iommu/arm-smmu-v3: poll cmdq until it has space
To:     Fernand Sieber <sieberf@amazon.com>, <will@kernel.org>,
        <robin.murphy@arm.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux-foundation.org>, <linux-kernel@vger.kernel.org>
References: <20210921114338.1144521-1-sieberf@amazon.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <c1c10203-ffd3-25f9-f2c6-9cee3458aac9@huawei.com>
Date:   Tue, 21 Sep 2021 17:22:48 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <20210921114338.1144521-1-sieberf@amazon.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.82.229]
X-ClientProxiedBy: lhreml736-chm.china.huawei.com (10.201.108.87) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/09/2021 12:43, Fernand Sieber wrote:
>   	do {

I didn't follow the full logic of this change yet ...

>   		llq->val = READ_ONCE(cmdq->q.llq.val);
> -		if (!queue_full(llq))
> +		if (!queue_has_space(llq, n))

But is the polarity really correct? That is, if we don't have space, 
then exit with success (the function to check for space).

>   			break;
> 
> +		/*
> +		 * We must return here even if there's no space, because the producer
> +		 * having moved forward could mean that the last thread observing the
> +		 * SMMU progress has allocated space in the cmdq and moved on, leaving
> +		 * us in this waiting loop with no other thread updating
> +		 * llq->state->val.

what is llq->state->val?

> +		 */
> +		if (llq->prod != prod)
> +			return -EAGAIN;
> +
>   		ret = queue_poll(&qp);

Thanks,
John
