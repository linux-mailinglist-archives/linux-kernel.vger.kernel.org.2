Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D993F3F1214
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 05:46:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236596AbhHSDqm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 23:46:42 -0400
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57]:44589 "EHLO
        out30-57.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236408AbhHSDql (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 23:46:41 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R991e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=alimailimapcm10staff010182156082;MF=joseph.qi@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0UjwfJJg_1629344763;
Received: from B-D1K7ML85-0059.local(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0UjwfJJg_1629344763)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 19 Aug 2021 11:46:03 +0800
Subject: Re: [PATCH v3] ocfs2: quota_local: fix possible
 uninitialized-variable access in ocfs2_local_read_info()
From:   Joseph Qi <joseph.qi@linux.alibaba.com>
To:     Tuo Li <islituo@gmail.com>, akpm <akpm@linux-foundation.org>
Cc:     ocfs2-devel@oss.oracle.com, linux-kernel@vger.kernel.org,
        baijiaju1990@gmail.com, TOTE Robot <oslab@tsinghua.edu.cn>,
        Joel Becker <jlbec@evilplan.org>, Mark Fasheh <mark@fasheh.com>
References: <20210804031832.57154-1-islituo@gmail.com>
 <d19dd958-93f6-bc42-b419-c60571de9b70@linux.alibaba.com>
Message-ID: <ee5f3d8b-3781-d04a-b379-40d4df6e1feb@linux.alibaba.com>
Date:   Thu, 19 Aug 2021 11:46:03 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <d19dd958-93f6-bc42-b419-c60571de9b70@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Andrew,
It seems you haven't picked this patch into -mm tree.
Should we resend it or it's fine now?

Thanks,
Joseph

On 8/4/21 11:26 AM, Joseph Qi wrote:
> 
> 
> On 8/4/21 11:18 AM, Tuo Li wrote:
>> A memory block is allocated through kmalloc(), and its return value is
>> assigned to the pointer oinfo. However, oinfo->dqi_gqinode is not
>> initialized but it is accessed in:
>>   iput(oinfo->dqi_gqinode);
>>
>> To fix this possible uninitialized-variable access, assign NULL to
>> oinfo->dqi_gqinode, and add ocfs2_qinfo_lock_res_init()
>> behind the assignment in ocfs2_local_read_info(). Remove
>> ocfs2_qinfo_lock_res_init() in ocfs2_global_read_info().
>>
> 
> Or we can simplify the above description to:
> "To fix the possible uninitialized-variable access, initialize
> dqi_gqinode and dqi_gqlock first before calling
> ocfs2_global_read_info()."
> 
>> Reported-by: TOTE Robot <oslab@tsinghua.edu.cn>
>> Signed-off-by: Tuo Li <islituo@gmail.com>
> 
> Reviewed-by: Joseph Qi <joseph.qi@linux.alibaba.com>
>> ---
>> v3:
>> * Update description.
>> * Assign NULL to oinfo->dqi_gqinode, and add ocfs2_qinfo_lock_res_init()
>> behind the assignment in ocfs2_local_read_info(). Remove
>> ocfs2_qinfo_lock_res_init() in ocfs2_global_read_info()
>>   Thank Joseph Qi for helpful advice.
>> v2:
>> * Replace kzalloc() with NULL assignment to oinfo->dqi_gqinode.
>>   Thank Joseph Qi for helpful advice.
>> ---
>>  fs/ocfs2/quota_global.c | 1 -
>>  fs/ocfs2/quota_local.c  | 2 ++
>>  2 files changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/ocfs2/quota_global.c b/fs/ocfs2/quota_global.c
>> index eda83487c9ec..f033de733adb 100644
>> --- a/fs/ocfs2/quota_global.c
>> +++ b/fs/ocfs2/quota_global.c
>> @@ -357,7 +357,6 @@ int ocfs2_global_read_info(struct super_block *sb, int type)
>>  	}
>>  	oinfo->dqi_gi.dqi_sb = sb;
>>  	oinfo->dqi_gi.dqi_type = type;
>> -	ocfs2_qinfo_lock_res_init(&oinfo->dqi_gqlock, oinfo);
>>  	oinfo->dqi_gi.dqi_entry_size = sizeof(struct ocfs2_global_disk_dqblk);
>>  	oinfo->dqi_gi.dqi_ops = &ocfs2_global_ops;
>>  	oinfo->dqi_gqi_bh = NULL;
>> diff --git a/fs/ocfs2/quota_local.c b/fs/ocfs2/quota_local.c
>> index b1a8b046f4c2..0e4b16d4c037 100644
>> --- a/fs/ocfs2/quota_local.c
>> +++ b/fs/ocfs2/quota_local.c
>> @@ -702,6 +702,8 @@ static int ocfs2_local_read_info(struct super_block *sb, int type)
>>  	info->dqi_priv = oinfo;
>>  	oinfo->dqi_type = type;
>>  	INIT_LIST_HEAD(&oinfo->dqi_chunk);
>> +	oinfo->dqi_gqinode = NULL;
>> +	ocfs2_qinfo_lock_res_init(&oinfo->dqi_gqlock, oinfo);
>>  	oinfo->dqi_rec = NULL;
>>  	oinfo->dqi_lqi_bh = NULL;
>>  	oinfo->dqi_libh = NULL;
>>
