Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F4544027AF
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 13:19:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244522AbhIGLUc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 07:20:32 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:19015 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239767AbhIGLU3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 07:20:29 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4H3jNn6qQJzbmLQ;
        Tue,  7 Sep 2021 19:15:21 +0800 (CST)
Received: from dggema762-chm.china.huawei.com (10.1.198.204) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2308.8; Tue, 7 Sep 2021 19:19:21 +0800
Received: from [10.174.176.73] (10.174.176.73) by
 dggema762-chm.china.huawei.com (10.1.198.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.8; Tue, 7 Sep 2021 19:19:21 +0800
Subject: Re: [PATCH v2 2/4] block, bfq: do not idle if only one cgroup is
 activated
To:     Paolo Valente <paolo.valente@linaro.org>
CC:     Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <yi.zhang@huawei.com>
References: <20210806020826.1407257-1-yukuai3@huawei.com>
 <20210806020826.1407257-3-yukuai3@huawei.com>
 <21FA636D-2C21-4ACD-B7DE-180ABB1F3562@linaro.org>
 <da0e53b4-e947-9c91-832e-36da67037f0f@huawei.com>
 <F1ADC992-11AE-4511-9033-D233CBCA6F26@linaro.org>
From:   "yukuai (C)" <yukuai3@huawei.com>
Message-ID: <f7900f33-5f27-a6e3-ee3d-f68ad9d8a6d3@huawei.com>
Date:   Tue, 7 Sep 2021 19:19:20 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <F1ADC992-11AE-4511-9033-D233CBCA6F26@linaro.org>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.176.73]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggema762-chm.china.huawei.com (10.1.198.204)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/09/07 17:10, Paolo Valente wrote:
> 
> 
>> Il giorno 2 set 2021, alle ore 15:31, yukuai (C) <yukuai3@huawei.com> ha scritto:
>>
>> On 2021/08/27 1:00, Paolo Valente wrote:
>>> Why do you make these extensive changes, while you can leave all the
>>> function unchanged and just modify the above condition to something
>>> like
>>> || bfqd->num_groups_with_pending_reqs > 1
>>> || (bfqd->num_groups_with_pending_reqs && bfqd->num_queues_with_pending_reqs_in_root)
>>
>> Hi, Paolo
>>
>> I was thinking that if CONFIG_BFQ_GROUP_IOSCHED is enabled, there is no
>> need to caculate smallest_weight, varied_queue_weights, and
>> multiple_classes_busy:
>>
>> If we count root group into num_groups_with_pending_reqs
>> - If num_groups_with_pending_reqs <= 1, idle is not needed
> 
> Unfortunately, if active queues have different weights or belong to
> different classes, then idling is needed to preserve per-queue
> bandwidths.
> 
> Thanks,
> Paolo

Hi, Paolo

It's right, if num_groups_with_pending_reqs == 1, multiple_classes_busy
should be checked, while smallest_weight and varied_queue_weights can
be skipped.

Thanks
Kuai

> .
> 
