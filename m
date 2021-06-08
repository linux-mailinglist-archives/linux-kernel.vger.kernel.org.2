Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0308339F6A8
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 14:30:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232630AbhFHMch (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 08:32:37 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:5334 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232614AbhFHMcY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 08:32:24 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4FzqH36Ycpz6ttB;
        Tue,  8 Jun 2021 20:26:39 +0800 (CST)
Received: from dggpeml500019.china.huawei.com (7.185.36.137) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 8 Jun 2021 20:30:29 +0800
Received: from [10.174.179.189] (10.174.179.189) by
 dggpeml500019.china.huawei.com (7.185.36.137) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 8 Jun 2021 20:30:28 +0800
Subject: Re: [PATCH] nvme-multipath: combine grpid and ANA state checks in
 nvme_parse_ana_log()
To:     Christoph Hellwig <hch@lst.de>
CC:     <kbusch@kernel.org>, <axboe@fb.com>, <sagi@grimberg.me>,
        <linux-nvme@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linfeilong@huawei.com>
References: <1623125616-629270-1-git-send-email-wubo40@huawei.com>
 <20210608052320.GA13828@lst.de>
From:   Wu Bo <wubo40@huawei.com>
Message-ID: <3a243d2c-f9b9-edcf-1762-9b08cf21f152@huawei.com>
Date:   Tue, 8 Jun 2021 20:30:14 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.2
MIME-Version: 1.0
In-Reply-To: <20210608052320.GA13828@lst.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.189]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500019.china.huawei.com (7.185.36.137)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/6/8 13:23, Christoph Hellwig wrote:
> On Tue, Jun 08, 2021 at 12:13:36PM +0800, Wu Bo wrote:
>> -		if (WARN_ON_ONCE(desc->grpid == 0))
>> +		if (WARN_ON_ONCE(desc->grpid == 0 ||
>> +			le32_to_cpu(desc->grpid) > ctrl->anagrpmax))
>>   			return -EINVAL;
>> -		if (WARN_ON_ONCE(le32_to_cpu(desc->grpid) > ctrl->anagrpmax))
>> -			return -EINVAL;
>> -		if (WARN_ON_ONCE(desc->state == 0))
>> -			return -EINVAL;
>> -		if (WARN_ON_ONCE(desc->state > NVME_ANA_CHANGE))
>> +		if (WARN_ON_ONCE(desc->state == 0 ||
>> +			desc->state > NVME_ANA_CHANGE))
> 
> So besides making the code impossibl to read due to the incorrect
> indentation this also makes each WARN_ON_ONCE cover multiple conditions.
> Not very useful for debugging.
> Indeed, not very useful for debugging, please ignore this patch.

Thanks,
Wu Bo
> 

