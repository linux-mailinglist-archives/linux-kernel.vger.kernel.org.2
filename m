Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9F4B443BD4
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Nov 2021 04:28:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230049AbhKCDaj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 23:30:39 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:27106 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbhKCDai (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 23:30:38 -0400
Received: from dggeme762-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4HkXGq4Q85z1DHxq;
        Wed,  3 Nov 2021 11:25:55 +0800 (CST)
Received: from [10.174.179.252] (10.174.179.252) by
 dggeme762-chm.china.huawei.com (10.3.19.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.15; Wed, 3 Nov 2021 11:27:59 +0800
Subject: Re: [PATCH -next] ALSA: timer: Fix use-after-free problem
To:     Takashi Iwai <tiwai@suse.de>
CC:     <perex@perex.cz>, <tiwai@suse.com>, <broonie@kernel.org>,
        <joe@perches.com>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>, <rui.xiang@huawei.com>
References: <20211102134107.35126-1-wangwensheng4@huawei.com>
 <s5h5ytaps0n.wl-tiwai@suse.de>
From:   "wangwensheng (C)" <wangwensheng4@huawei.com>
Message-ID: <3b02dd76-d952-e38e-bc0c-c8a121919720@huawei.com>
Date:   Wed, 3 Nov 2021 11:27:58 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <s5h5ytaps0n.wl-tiwai@suse.de>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.252]
X-ClientProxiedBy: dggeme706-chm.china.huawei.com (10.1.199.102) To
 dggeme762-chm.china.huawei.com (10.3.19.108)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



ÔÚ 2021/11/2 22:10, Takashi Iwai Ð´µÀ:
> On Tue, 02 Nov 2021 14:41:07 +0100,
> Wang Wensheng wrote:
>>
>> When the timer instance was add into ack_list but was not currently in
>> process, the user could stop it via snd_timer_stop1() without delete it
>> from the ack_list. Then the user could free the timer instance and when
>> it was actually processed UAF occurred.
>>
>> This issue could be reproduced via testcase snd_timer01 in ltp - running
>> several instances of that testcase at the same time.
>>
>> What I actually met was that the ack_list of the timer broken and the
>> kernel went into deadloop with irqoff. That could be detected by
>> hardlockup detector on board or when we run it on qemu, we could use gdb
>> to dump the ack_list when the console has no response.
>>
>> To fix this issue, we introduce a new flag SNDRV_TIMER_IFLG_ACKING to
>> indicate the state where the timer instance is in ack_list but not
>> currently processed and check against the new flag in snd_timer_stop1()
>> and delete it from ack_list if the flag is set.
>>
>> Signed-off-by: Wang Wensheng <wangwensheng4@huawei.com>
> 
> Thanks for the patch.  Just through a quick glance, I wonder whether
> it'd be easier to do list_del_init(&timeri->ack_list) unconditionally
> before the check of timeri->flags in snd_timer1_stop().  Ditto for
> active_list.  So something like:
> 

Thanks for your suggestions. It looks much more efficient and easier and 
is also effective. I will take this as a second version.

> --- a/sound/core/timer.c
> +++ b/sound/core/timer.c
> @@ -624,13 +624,13 @@ static int snd_timer_stop1(struct snd_timer_instance *timeri, bool stop)
>   	if (!timer)
>   		return -EINVAL;
>   	spin_lock_irqsave(&timer->lock, flags);
> +	list_del_init(&timeri->ack_list);
> +	list_del_init(&timeri->active_list);
>   	if (!(timeri->flags & (SNDRV_TIMER_IFLG_RUNNING |
>   			       SNDRV_TIMER_IFLG_START))) {
>   		result = -EBUSY;
>   		goto unlock;
>   	}
> -	list_del_init(&timeri->ack_list);
> -	list_del_init(&timeri->active_list);
>   	if (timer->card && timer->card->shutdown)
>   		goto unlock;
>   	if (stop) {
> 
> 
> Takashi
