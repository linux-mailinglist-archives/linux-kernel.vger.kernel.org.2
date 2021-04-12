Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E96035C938
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 16:52:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242616AbhDLOwd convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 12 Apr 2021 10:52:33 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:5128 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239030AbhDLOwc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 10:52:32 -0400
Received: from dggeml406-hub.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4FJs8v1CfxzYW4V;
        Mon, 12 Apr 2021 22:50:07 +0800 (CST)
Received: from dggpemm100007.china.huawei.com (7.185.36.116) by
 dggeml406-hub.china.huawei.com (10.3.17.50) with Microsoft SMTP Server (TLS)
 id 14.3.498.0; Mon, 12 Apr 2021 22:52:11 +0800
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggpemm100007.china.huawei.com (7.185.36.116) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Mon, 12 Apr 2021 22:52:11 +0800
Received: from dggpemm500006.china.huawei.com ([7.185.36.236]) by
 dggpemm500006.china.huawei.com ([7.185.36.236]) with mapi id 15.01.2106.013;
 Mon, 12 Apr 2021 22:52:11 +0800
From:   "chenjun (AM)" <chenjun102@huawei.com>
To:     Richard Cochran <richardcochran@gmail.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "johnstul@us.ibm.com" <johnstul@us.ibm.com>,
        "Xiangrui (Euler)" <rui.xiang@huawei.com>
Subject: Re: [PATCH] time: Fix overwrite err unexpected in clock_adjtime32
Thread-Topic: [PATCH] time: Fix overwrite err unexpected in clock_adjtime32
Thread-Index: AQHXL6blk8YXTY0RLUu2MVHj98u5SQ==
Date:   Mon, 12 Apr 2021 14:52:11 +0000
Message-ID: <0aacd0e17515458483653f570b1efd2d@huawei.com>
References: <20210412124552.50213-1-chenjun102@huawei.com>
 <20210412141950.GA18311@hoboy.vegasvil.org>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.174.178.53]
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2021/4/12 22:20, Richard Cochran 写道:
> On Mon, Apr 12, 2021 at 12:45:51PM +0000, Chen Jun wrote:
>> the correct error is covered by put_old_timex32.
> 
> Well, the non-negative return code (TIME_OK, TIME_INS, etc) is
> clobbered by put_old_timex32().
> 
>> Fixes: f1f1d5ebd10f ("posix-timers: Introduce a syscall for clock tuning.")
> 
> This is not the correct commit for the "Fixes" tag.  Please find the
> actual commit that introduced the issue.
> 
> In commit f1f1d5ebd10f the code looked like this...
> 
> 	long compat_sys_clock_adjtime(clockid_t which_clock,
> 			struct compat_timex __user *utp)
> 	{
> 		struct timex txc;
> 		mm_segment_t oldfs;
> 		int err, ret;
> 	
> 		err = compat_get_timex(&txc, utp);
> 		if (err)
> 			return err;
> 	
> 		oldfs = get_fs();
> 		set_fs(KERNEL_DS);
> 		ret = sys_clock_adjtime(which_clock, (struct timex __user *) &txc);
> 		set_fs(oldfs);
> 	
> 		err = compat_put_timex(utp, &txc);
> 		if (err)
> 			return err;
> 	
> 		return ret;
> 	}
> 

f1f1d5ebd10:
Introduce compat_sys_clock_adjtime

62a6fa97684:
rename compat_sys_clock_adjtime to COMPAT_SYSCALL_DEFINE2(clock_adjtime

3a4d44b6162:
move COMPAT_SYSCALL_DEFINE2(clock_adjtime from kernel/compat.c to 
kernel/time/posix-timers.c

8dabe7245bb:
COMPAT_SYSCALL_DEFINE2(clock_adjtime, ..
-> SYSCALL_DEFINE2(clock_adjtime32, ..

The implement of clock_adjtime32 is similar to compat_sys_clock_adjtime. 
And I think f1f1d5ebd10 introduced the problem actually.

> Thanks,
> Richard
> 
> 
> 
>> Signed-off-by: Chen Jun <chenjun102@huawei.com>
>> ---
>>   kernel/time/posix-timers.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
>> index bf540f5a..dd5697d 100644
>> --- a/kernel/time/posix-timers.c
>> +++ b/kernel/time/posix-timers.c
>> @@ -1191,8 +1191,8 @@ SYSCALL_DEFINE2(clock_adjtime32, clockid_t, which_clock,
>>   
>>   	err = do_clock_adjtime(which_clock, &ktx);
>>   
>> -	if (err >= 0)
>> -		err = put_old_timex32(utp, &ktx);
>> +	if (err >= 0 && put_old_timex32(utp, &ktx))
>> +		return -EFAULT;
>>   
>>   	return err;
>>   }
>> -- 
>> 2.9.4
>>
> 


-- 
Regards
Chen Jun
