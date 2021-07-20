Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EF843CF9AB
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jul 2021 14:35:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238319AbhGTLyJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jul 2021 07:54:09 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:12281 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236193AbhGTLxR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jul 2021 07:53:17 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4GTdLg6mXSz7tB7;
        Tue, 20 Jul 2021 20:29:15 +0800 (CST)
Received: from dggema762-chm.china.huawei.com (10.1.198.204) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Tue, 20 Jul 2021 20:33:51 +0800
Received: from [10.174.176.221] (10.174.176.221) by
 dggema762-chm.china.huawei.com (10.1.198.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Tue, 20 Jul 2021 20:33:50 +0800
Subject: Re: [PATCH 0/3] optimize the queue idle judgment
To:     <paolo.valente@linaro.org>, <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <yi.zhang@huawei.com>
References: <20210714094529.758808-1-yukuai3@huawei.com>
From:   "yukuai (C)" <yukuai3@huawei.com>
Message-ID: <bad3d311-b232-1969-bb16-00ab6a64a951@huawei.com>
Date:   Tue, 20 Jul 2021 20:33:50 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20210714094529.758808-1-yukuai3@huawei.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.176.221]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggema762-chm.china.huawei.com (10.1.198.204)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/07/14 17:45, Yu Kuai wrote:
> bfqq might plug I/O dispatch when it remains temporarily empty while
> being served, this will benefit for both sequence io bandwidth and relative
> sync io control.
> 
> This path set tries to extend the two special cases that idle is not
> needed, and can get better bandwidth.
> 
> 1) only one group is activated.
> 2) when more than one groups are activated, all queues are issuring
> requests with same size.
> 
> Yu Kuai (3):
>    block, bfq: do not idle if only one cgroup is activated
>    block, bfq: add support to record request size information
>    block, bfq: consider request size in bfq_asymmetric_scenario()
> 
>   block/bfq-iosched.c | 50 +++++++++++++++++++++++++++++++++++++--------
>   block/bfq-iosched.h | 16 +++++++++++++++
>   2 files changed, 57 insertions(+), 9 deletions(-)
> 

ping ...
