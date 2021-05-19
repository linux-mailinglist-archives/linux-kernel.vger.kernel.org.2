Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07D39388617
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 06:32:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353276AbhESEdr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 00:33:47 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:2977 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232007AbhESEdk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 00:33:40 -0400
Received: from dggems706-chm.china.huawei.com (unknown [172.30.72.59])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4FlKdm1mzzzCst2;
        Wed, 19 May 2021 12:29:32 +0800 (CST)
Received: from dggpeml500019.china.huawei.com (7.185.36.137) by
 dggems706-chm.china.huawei.com (10.3.19.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 19 May 2021 12:32:18 +0800
Received: from [10.174.179.189] (10.174.179.189) by
 dggpeml500019.china.huawei.com (7.185.36.137) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 19 May 2021 12:32:18 +0800
Subject: Re: [PATCH] nvmet: fix memory leak on nvmet_alloc_ctrl()
To:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        "kbusch@kernel.org" <kbusch@kernel.org>
CC:     "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>,
        "amit.engel@dell.com" <amit.engel@dell.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linfeilong@huawei.com" <linfeilong@huawei.com>
References: <1621327598-542045-1-git-send-email-wubo40@huawei.com>
 <BYAPR04MB4965E8D55C4349EC01EF61FB862C9@BYAPR04MB4965.namprd04.prod.outlook.com>
From:   Wu Bo <wubo40@huawei.com>
Message-ID: <ead259ae-2955-1fda-7deb-6262fdc21ecf@huawei.com>
Date:   Wed, 19 May 2021 12:32:17 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.2
MIME-Version: 1.0
In-Reply-To: <BYAPR04MB4965E8D55C4349EC01EF61FB862C9@BYAPR04MB4965.namprd04.prod.outlook.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.189]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500019.china.huawei.com (7.185.36.137)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/5/19 4:27, Chaitanya Kulkarni wrote:
> On 5/18/21 01:21, Wu Bo wrote:
>> From: Wu Bo <wubo40@huawei.com>
>>
>> When cntlid_min is greater than cntlid_max,
>> goto wrong label, should be goto out_free_sqs
>> label. Otherwise there is a memory leak problem
>> on the nvmet_alloc_ctrl function().
>>
>> Fixes: 94a39d61f80f ("nvmet: make ctrl-id configurable")
>> Fixes: 6d65aeab7bf6e ("nvmet: remove unused ctrl->cqs")
>> Signed-off-by: Wu Bo <wubo40@huawei.com>
>> ---
> 
> Looks good, except commit message could be better :-
> 
> When cntlid_min is greater than cntlid_max, goto wrong label, should be
> goto out_free_sqs label. Otherwise there is a memory leak problem on the
> nvmet_alloc_ctrl function().
> 
> Fixes: 94a39d61f80f ("nvmet: make ctrl-id configurable")
> Fixes: 6d65aeab7bf6 ("nvmet: remove unused ctrl->cqs")
> Signed-off-by: Wu Bo <wubo40@huawei.com>
> 
> 
> with above :-

Thanks for your review. I will make the commit message better.
and I found the nvmet-loop has a similar issue,
will send patch series soon.

Thanks,
Wu Bo
> 
> Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
> 
> 
> .
> 

