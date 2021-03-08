Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93CD2330B68
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 11:40:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231148AbhCHKkP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 05:40:15 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2649 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230495AbhCHKjx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 05:39:53 -0500
Received: from fraeml714-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4DvF571Tjzz67x4Q;
        Mon,  8 Mar 2021 18:31:55 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml714-chm.china.huawei.com (10.206.15.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Mon, 8 Mar 2021 11:39:51 +0100
Received: from [10.210.165.214] (10.210.165.214) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Mon, 8 Mar 2021 10:39:50 +0000
Subject: Re: [RFC PATCH v3 1/3] blk-mq: Clean up references to old requests
 when freeing rqs
To:     Bart Van Assche <bvanassche@acm.org>, <hare@suse.de>,
        <ming.lei@redhat.com>, <axboe@kernel.dk>, <hch@lst.de>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <pragalla@codeaurora.org>, <kashyap.desai@broadcom.com>,
        <yuyufen@huawei.com>
References: <1614957294-188540-1-git-send-email-john.garry@huawei.com>
 <1614957294-188540-2-git-send-email-john.garry@huawei.com>
 <ab2c3bc2-6dac-3c5c-3589-9383c459f478@acm.org>
From:   John Garry <john.garry@huawei.com>
Message-ID: <ba6bd7b2-ac24-9e62-795d-d494434fc152@huawei.com>
Date:   Mon, 8 Mar 2021 10:37:51 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <ab2c3bc2-6dac-3c5c-3589-9383c459f478@acm.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.210.165.214]
X-ClientProxiedBy: lhreml739-chm.china.huawei.com (10.201.108.189) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/03/2021 18:13, Bart Van Assche wrote:
> On 3/5/21 7:14 AM, John Garry wrote:
>> @@ -2296,10 +2296,14 @@ void blk_mq_free_rqs(struct blk_mq_tag_set *set, struct blk_mq_tags *tags,
>>   
>>   		for (i = 0; i < tags->nr_tags; i++) {
>>   			struct request *rq = tags->static_rqs[i];
>> +			int j;
>>   
>>   			if (!rq)
>>   				continue;
>>   			set->ops->exit_request(set, rq, hctx_idx);
>> +			/* clean up any references which occur in @ref_tags */
>> +			for (j = 0; ref_tags && j < ref_tags->nr_tags; j++)
>> +				cmpxchg(&ref_tags->rqs[j], rq, 0);
>>   			tags->static_rqs[i] = NULL;
>>   		}
>>   	}

Hi Bart,

> What prevents blk_mq_tagset_busy_iter() from reading hctx->tags[...]
> before the cmpxcg() call and dereferencing it after blk_mq_free_rqs()
> has called __free_pages()?
> 

So there is nothing in this patch to stop that. But it's pretty 
unlikely, as the window is very narrow generally between reading 
hctx->tags[...] and actually dereferencing it. However, something like 
that should be made safe in patch 2/3.

Thanks,
John


