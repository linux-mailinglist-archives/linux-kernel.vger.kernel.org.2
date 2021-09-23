Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88AB3415548
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 03:56:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238834AbhIWB6A convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 22 Sep 2021 21:58:00 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:16374 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238177AbhIWB57 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 21:57:59 -0400
Received: from dggeml756-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4HFJ7f6ztmzRGkY;
        Thu, 23 Sep 2021 09:52:14 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggeml756-chm.china.huawei.com (10.1.199.158) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.8; Thu, 23 Sep 2021 09:56:27 +0800
Received: from dggpemm500006.china.huawei.com ([7.185.36.236]) by
 dggpemm500006.china.huawei.com ([7.185.36.236]) with mapi id 15.01.2308.008;
 Thu, 23 Sep 2021 09:56:27 +0800
From:   "chenjun (AM)" <chenjun102@huawei.com>
To:     Feng Tang <feng.tang@intel.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "mhocko@suse.com" <mhocko@suse.com>,
        "Xiangrui (Euler)" <rui.xiang@huawei.com>
Subject: Re: [PATCH v2 1/1] mm: Fix the uninitialized use in
 overcommit_policy_handler
Thread-Topic: [PATCH v2 1/1] mm: Fix the uninitialized use in
 overcommit_policy_handler
Thread-Index: AQHXr8dSCEMgjTNiAE6yPyR3F7TvHA==
Date:   Thu, 23 Sep 2021 01:56:27 +0000
Message-ID: <6776dd3a8d9e4618b36110604d1e58dd@huawei.com>
References: <20210922014122.47219-1-chenjun102@huawei.com>
 <20210922153425.GB68763@shbuild999.sh.intel.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.174.178.43]
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tang,

在 2021/9/22 23:34, Feng Tang 写道:
> Hi Jun,
> 
> On Wed, Sep 22, 2021 at 01:41:22AM +0000, Chen Jun wrote:
>> An unexpected value of /proc/sys/vm/panic_on_oom we will get,
>> after running the following program.
>>
>> int main()
>> {
>>      int fd = open("/proc/sys/vm/panic_on_oom", O_RDWR)
> 
> should this be "/proc/sys/vm/overcommit_memory"
> 

Sorry, that is my mistake, I will correct it in v3. Thanks.

>>      write(fd, "1", 1);
>>      write(fd, "2", 1);
>>      close(fd);
>> }
>>
>> write(fd, "2", 1) will pass *ppos = 1 to proc_dointvec_minmax.
>> proc_dointvec_minmax will return 0 without setting new_policy.
>>
>> t.data = &new_policy;
>> ret = proc_dointvec_minmax(&t, write, buffer, lenp, ppos)
>>        -->do_proc_dointvec
>>           -->__do_proc_dointvec
>>                if (write) {
>>                  if (proc_first_pos_non_zero_ignore(ppos, table))
>>                    goto out;
>>
>> sysctl_overcommit_memory = new_policy;
>>
>> so sysctl_overcommit_memory will be set to an uninitialized value.
>>
>> Check whether new_policy has been changed by proc_dointvec_minmax.
>   
> Other than the nit above, it looks good to me, thanks!
> 
> Reviewed-by: Feng Tang <feng.tang@intel.com>
> 
>> Fixes: 56f3547bfa4d ("mm: adjust vm_committed_as_batch according to vm overcommit policy"
>> Signed-off-by: Chen Jun <chenjun102@huawei.com>
>> ---
>>
>> v2:
>>    * Check whether new_policy has been changed by proc_dointvec_minmax.
>>
>>   mm/util.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/mm/util.c b/mm/util.c
>> index 4ddb6e186dd5..d5be67771850 100644
>> --- a/mm/util.c
>> +++ b/mm/util.c
>> @@ -756,7 +756,7 @@ int overcommit_policy_handler(struct ctl_table *table, int write, void *buffer,
>>   		size_t *lenp, loff_t *ppos)
>>   {
>>   	struct ctl_table t;
>> -	int new_policy;
>> +	int new_policy = -1;
>>   	int ret;
>>   
>>   	/*
>> @@ -774,7 +774,7 @@ int overcommit_policy_handler(struct ctl_table *table, int write, void *buffer,
>>   		t = *table;
>>   		t.data = &new_policy;
>>   		ret = proc_dointvec_minmax(&t, write, buffer, lenp, ppos);
>> -		if (ret)
>> +		if (ret || new_policy == -1)
>>   			return ret;
>>   
>>   		mm_compute_batch(new_policy);
>> -- 
>> 2.17.1
>>
> 


-- 
Regards
Chen Jun
