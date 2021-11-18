Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFBDA455B1E
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Nov 2021 13:01:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344396AbhKRMDq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Nov 2021 07:03:46 -0500
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:56798 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1344513AbhKRMDe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Nov 2021 07:03:34 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R551e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=xhao@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0UxCl-n0_1637236831;
Received: from B-X3VXMD6M-2058.local(mailfrom:xhao@linux.alibaba.com fp:SMTPD_---0UxCl-n0_1637236831)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 18 Nov 2021 20:00:32 +0800
From:   Xin Hao <xhao@linux.alibaba.com>
Reply-To: xhao@linux.alibaba.com
Subject: Re: [PATCH V1] mm/damon/schemes: Add the validity judgment of
 thresholds
To:     SeongJae Park <sj@kernel.org>
Cc:     sjpark@amazon.de, akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20211118115113.20234-1-sj@kernel.org>
Message-ID: <c1237c76-f15a-7bf5-80bb-e078c2efb7f5@linux.alibaba.com>
Date:   Thu, 18 Nov 2021 20:00:31 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211118115113.20234-1-sj@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/18/21 7:51 PM, SeongJae Park wrote:
> Hi Xin,
>
>
> Thank you for this patch.
>
>  From next time, please send patches for DAMON to sj@kernel.org instead of
> sjpark@amazon.de.
>
> On Thu, 18 Nov 2021 12:16:02 +0800 Xin Hao <xhao@linux.alibaba.com> wrote:
Oh,l will.
>> In dbgfs "schemes" interface, i do some test like this:
>>      # cd /sys/kernel/debug/damon
>>      # echo "2 1 2 1 10 1 3 10 1 1 1 1 1 1 1 1 2 3" > schemes
>>      # cat schemes
>>      # 2 1 2 1 10 1 3 10 1 1 1 1 1 1 1 1 2 3 0 0
>>
>> There have some unreasonable places, i set the valules of these variables
>> "<min_sz, max_sz> <min_nr_a, max_nr_a>, <min_age, max_age>, <wmarks.high,
>> wmarks.mid, wmarks.low>" as "<2, 1>, <2, 1>, <10, 1>, <1, 2, 3>.
>>
>> So there add a validity judgment for these threshold values.
>>
>> Signed-off-by: Xin Hao <xhao@linux.alibaba.com>
>> ---
>>   mm/damon/dbgfs.c | 11 +++++++++++
>>   1 file changed, 11 insertions(+)
>>
>> diff --git a/mm/damon/dbgfs.c b/mm/damon/dbgfs.c
>> index befb27a29aab..a4c94d563d3d 100644
>> --- a/mm/damon/dbgfs.c
>> +++ b/mm/damon/dbgfs.c
>> @@ -215,6 +215,17 @@ static struct damos **str_to_schemes(const char *str, ssize_t len,
>>   			goto fail;
>>   		}
>>   
>> +		if (min_sz > max_sz || min_nr_a > max_nr_a || min_age > max_age) {
>> +			pr_err("mininum > maxinum\n");
> I think this error message is not really needed.
Ok, i will remove it, i add this message is aim to better find where is 
wrong, because there have so many variables
>
>> +			goto fail;
>> +		}
>> +
>> +		if (wmarks.high < wmarks.mid || wmarks.high < wmarks.low ||
>> +		    wmarks.mid <  wmarks.low) {
>> +			pr_err("wrong wmarks\n");
> Ditto.
>
>
> Thanks,
> SJ
>
>> +			goto fail;
>> +		}
>> +
>>   		pos += parsed;
>>   		scheme = damon_new_scheme(min_sz, max_sz, min_nr_a, max_nr_a,
>>   				min_age, max_age, action, &quota, &wmarks);
>> -- 
>> 2.31.0

-- 
Best Regards!
Xin Hao

