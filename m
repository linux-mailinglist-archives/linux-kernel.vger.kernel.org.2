Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51F923EBFCB
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Aug 2021 04:35:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236685AbhHNCfa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Aug 2021 22:35:30 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:13316 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236656AbhHNCfW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Aug 2021 22:35:22 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4GmkzF5Zq2z85k1;
        Sat, 14 Aug 2021 10:34:49 +0800 (CST)
Received: from dggema762-chm.china.huawei.com (10.1.198.204) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Sat, 14 Aug 2021 10:34:52 +0800
Received: from [10.174.176.73] (10.174.176.73) by
 dggema762-chm.china.huawei.com (10.1.198.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Sat, 14 Aug 2021 10:34:52 +0800
Subject: Re: [PATCH v2 0/4] optimize the bfq queue idle judgment
To:     <paolo.valente@linaro.org>, <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <yi.zhang@huawei.com>
References: <20210806020826.1407257-1-yukuai3@huawei.com>
From:   "yukuai (C)" <yukuai3@huawei.com>
Message-ID: <0b83e2e1-9cce-6ffc-90ca-4f03ad518b82@huawei.com>
Date:   Sat, 14 Aug 2021 10:34:51 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20210806020826.1407257-1-yukuai3@huawei.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.176.73]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggema762-chm.china.huawei.com (10.1.198.204)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/08/06 10:08, Yu Kuai wrote:
> Chagnes in V2:
>   - as suggested by Paolo, add support to track if root_group have any
>   pending requests, and use that to handle the situation when only one
>   group is activated while root group doesn't have any pending requests.
>   - modify commit message in patch 2
> 
> Yu Kuai (4):
>    block, bfq: add support to track if root_group have any pending
>      requests
>    block, bfq: do not idle if only one cgroup is activated
>    block, bfq: add support to record request size information
>    block, bfq: consider request size in bfq_asymmetric_scenario()
> 
>   block/bfq-iosched.c | 69 ++++++++++++++++++++++++++++++++++++++-------
>   block/bfq-iosched.h | 29 +++++++++++++++++--
>   block/bfq-wf2q.c    | 37 +++++++++++++++---------
>   3 files changed, 110 insertions(+), 25 deletions(-)
> 


ping ...
