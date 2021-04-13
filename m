Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC09C35D4EF
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 03:47:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239543AbhDMBr0 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 12 Apr 2021 21:47:26 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:5129 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237718AbhDMBrZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 21:47:25 -0400
Received: from dggeml406-hub.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4FK7hW27DYzYVr4;
        Tue, 13 Apr 2021 09:44:59 +0800 (CST)
Received: from dggpemm500008.china.huawei.com (7.185.36.136) by
 dggeml406-hub.china.huawei.com (10.3.17.50) with Microsoft SMTP Server (TLS)
 id 14.3.498.0; Tue, 13 Apr 2021 09:47:03 +0800
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggpemm500008.china.huawei.com (7.185.36.136) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 13 Apr 2021 09:47:03 +0800
Received: from dggpemm500006.china.huawei.com ([7.185.36.236]) by
 dggpemm500006.china.huawei.com ([7.185.36.236]) with mapi id 15.01.2106.013;
 Tue, 13 Apr 2021 09:47:03 +0800
From:   "chenjun (AM)" <chenjun102@huawei.com>
To:     Richard Cochran <richardcochran@gmail.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "john.stultz@linaro.org" <john.stultz@linaro.org>,
        "Xiangrui (Euler)" <rui.xiang@huawei.com>
Subject: Re: [PATCH] time: Fix overwrite err unexpected in clock_adjtime32
Thread-Topic: [PATCH] time: Fix overwrite err unexpected in clock_adjtime32
Thread-Index: AQHXL6blk8YXTY0RLUu2MVHj98u5SQ==
Date:   Tue, 13 Apr 2021 01:47:03 +0000
Message-ID: <c378f5bd04074751893ba582ba845e0e@huawei.com>
References: <20210412124552.50213-1-chenjun102@huawei.com>
 <20210412141950.GA18311@hoboy.vegasvil.org>
 <0aacd0e17515458483653f570b1efd2d@huawei.com>
 <20210412155830.GA19589@hoboy.vegasvil.org>
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

在 2021/4/12 23:58, Richard Cochran 写道:
> On Mon, Apr 12, 2021 at 02:52:11PM +0000, chenjun (AM) wrote:
>> 在 2021/4/12 22:20, Richard Cochran 写道:
>>> On Mon, Apr 12, 2021 at 12:45:51PM +0000, Chen Jun wrote:
>>>> the correct error is covered by put_old_timex32.
>>>
>>> Well, the non-negative return code (TIME_OK, TIME_INS, etc) is
>>> clobbered by put_old_timex32().
>>>
>>>> Fixes: f1f1d5ebd10f ("posix-timers: Introduce a syscall for clock tuning.")
>>>
>>> This is not the correct commit for the "Fixes" tag.  Please find the
>>> actual commit that introduced the issue.
>>>
>>> In commit f1f1d5ebd10f the code looked like this...
>>>
>>> 	long compat_sys_clock_adjtime(clockid_t which_clock,
>>> 			struct compat_timex __user *utp)
>>> 	{
>>> 		struct timex txc;
>>> 		mm_segment_t oldfs;
>>> 		int err, ret;
>>> 	
>>> 		err = compat_get_timex(&txc, utp);
>>> 		if (err)
>>> 			return err;
>>> 	
>>> 		oldfs = get_fs();
>>> 		set_fs(KERNEL_DS);
>>> 		ret = sys_clock_adjtime(which_clock, (struct timex __user *) &txc);
>>> 		set_fs(oldfs);
>>> 	
>>> 		err = compat_put_timex(utp, &txc);
>>> 		if (err)
>>> 			return err;
>>> 	
>>> 		return ret;
>>> 	}
> 
> Look at the code ^^^
> 
>> The implement of clock_adjtime32 is similar to compat_sys_clock_adjtime.
>> And I think f1f1d5ebd10 introduced the problem actually.
> 
> See how 'ret' and 'err' are two separate variables?  It makes a difference.
> 
> Thanks,
> Richard
> 

Oh, yee.. Very thanks.

3a4d44b616 ("ntp: Move adjtimex related compat syscalls to native 
counterparts") made the change.

-- 
Regards
Chen Jun
