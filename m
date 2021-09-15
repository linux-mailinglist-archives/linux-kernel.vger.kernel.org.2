Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44CC540BDCF
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 04:36:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbhIOCht (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 22:37:49 -0400
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:51533 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229594AbhIOChs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 22:37:48 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=joseph.qi@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0UoQrdxZ_1631673387;
Received: from B-D1K7ML85-0059.local(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0UoQrdxZ_1631673387)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 15 Sep 2021 10:36:28 +0800
Subject: Re: [Ocfs2-devel] [PATCH v2] ocfs2: Fix handle refcount leak in two
 exception handling paths
From:   Joseph Qi <joseph.qi@linux.alibaba.com>
To:     Chenyuan Mi <cymi20@fudan.edu.cn>, akpm <akpm@linux-foundation.org>
Cc:     Xin Tan <tanxin.ctf@gmail.com>,
        Xiyu Yang <xiyuyang19@fudan.edu.cn>, yuanxzhang@fudan.edu.cn,
        linux-kernel@vger.kernel.org, ocfs2-devel@oss.oracle.com,
        Wengang Wang <wen.gang.wang@oracle.com>
References: <20210908102055.10168-1-cymi20@fudan.edu.cn>
 <06d9e055-29b9-731c-5a36-d888f2c83188@linux.alibaba.com>
Message-ID: <babe7ec5-a7a0-f013-8137-2b541f311594@linux.alibaba.com>
Date:   Wed, 15 Sep 2021 10:36:27 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <06d9e055-29b9-731c-5a36-d888f2c83188@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,
Now there is no objection on this patch.
Would you please pick it into your -mm tree? Thanks.

Joseph

On 9/8/21 6:51 PM, Joseph Qi wrote:
> 
> 
> On 9/8/21 6:20 PM, Chenyuan Mi wrote:
>> The reference counting issue happens in two exception handling paths
>> of ocfs2_replay_truncate_records(). When executing these two exception
>> handling paths, the function forgets to decrease the refcount of handle
>> increased by ocfs2_start_trans(), causing a refcount leak.
>>
>> Fix this issue by using ocfs2_commit_trans() to decrease the refcount
>> of handle in two handling paths.
>>
>> Signed-off-by: Chenyuan Mi <cymi20@fudan.edu.cn>
>> Signed-off-by: Xiyu Yang <xiyuyang19@fudan.edu.cn>
>> Signed-off-by: Xin Tan <tanxin.ctf@gmail.com>
> 
> Reviewed-by: Joseph Qi <joseph.qi@linux.alibaba.com>
>> ---
>>  fs/ocfs2/alloc.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/fs/ocfs2/alloc.c b/fs/ocfs2/alloc.c
>> index f1cc8258d34a..b05fde7edc3a 100644
>> --- a/fs/ocfs2/alloc.c
>> +++ b/fs/ocfs2/alloc.c
>> @@ -5940,6 +5940,7 @@ static int ocfs2_replay_truncate_records(struct ocfs2_super *osb,
>>  		status = ocfs2_journal_access_di(handle, INODE_CACHE(tl_inode), tl_bh,
>>  						 OCFS2_JOURNAL_ACCESS_WRITE);
>>  		if (status < 0) {
>> +			ocfs2_commit_trans(osb, handle);
>>  			mlog_errno(status);
>>  			goto bail;
>>  		}
>> @@ -5964,6 +5965,7 @@ static int ocfs2_replay_truncate_records(struct ocfs2_super *osb,
>>  						     data_alloc_bh, start_blk,
>>  						     num_clusters);
>>  			if (status < 0) {
>> +				ocfs2_commit_trans(osb, handle);
>>  				mlog_errno(status);
>>  				goto bail;
>>  			}
>>
> 
> _______________________________________________
> Ocfs2-devel mailing list
> Ocfs2-devel@oss.oracle.com
> https://oss.oracle.com/mailman/listinfo/ocfs2-devel
> 
