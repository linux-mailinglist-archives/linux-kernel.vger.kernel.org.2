Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4389D34A54D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 11:10:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229893AbhCZKJw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 06:09:52 -0400
Received: from m15114.mail.126.com ([220.181.15.114]:52503 "EHLO
        m15114.mail.126.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229898AbhCZKJY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 06:09:24 -0400
X-Greylist: delayed 1846 seconds by postgrey-1.27 at vger.kernel.org; Fri, 26 Mar 2021 06:09:24 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=Subject:From:Message-ID:Date:MIME-Version; bh=HO2+8
        yOEkgeYzysiOq9FR+H9/COuTtLqX7AQLkhjh0E=; b=nK+Ik7kcibyjN8ExUMi/4
        WYjcmHp38Co+WDcoInpxrviF9oui2r6CTEZMYMuO1PcwN746RU2QoC6tzUFRQW3x
        iRa6d0qqx/ewMyr7gS0WI5xRM3CiWGFRMytnurrL17n9sb9ngF5hiBsoisyIwR1E
        okc0Hq8aeIXnEC5PLvDduc=
Received: from [172.20.20.87] (unknown [182.150.46.145])
        by smtp7 (Coremail) with SMTP id DsmowACnkVGCq11gfdmvPA--.60080S2;
        Fri, 26 Mar 2021 17:38:12 +0800 (CST)
Subject: Re: [PATCH] drm/amdkfd: dqm fence memory corruption
To:     Felix Kuehling <felix.kuehling@amd.com>
Cc:     alexander.deucher@amd.com, christian.koenig@amd.com,
        airlied@linux.ie, daniel@ffwll.ch, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <1611750806-10730-1-git-send-email-jinsdb@126.com>
 <4de809ac-fdd7-b02a-c55f-3c79321cfb7f@amd.com>
From:   Qu Huang <jinsdb@126.com>
Message-ID: <14c4be41-28ab-3266-eaf3-b6b0342e18ba@126.com>
Date:   Fri, 26 Mar 2021 17:38:09 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <4de809ac-fdd7-b02a-c55f-3c79321cfb7f@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: DsmowACnkVGCq11gfdmvPA--.60080S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7tFW7XFyrAw15Gw48Wry7GFg_yoW8Aw4fpF
        WkJFy5Kry8Jw12v34xXa18uFy5Cw4rWrWfWFy7C39xua13XF9IyrW5AFWUK348uFyvya17
        tF4DCrZruF1qvaUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jQ189UUUUU=
X-Originating-IP: [182.150.46.145]
X-CM-SenderInfo: pmlq2vbe6rjloofrz/1tbigQRhDlpECnN1nQAAsl
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/1/28 5:50, Felix Kuehling wrote:
> Am 2021-01-27 um 7:33 a.m. schrieb Qu Huang:
>> Amdgpu driver uses 4-byte data type as DQM fence memory,
>> and transmits GPU address of fence memory to microcode
>> through query status PM4 message. However, query status
>> PM4 message definition and microcode processing are all
>> processed according to 8 bytes. Fence memory only allocates
>> 4 bytes of memory, but microcode does write 8 bytes of memory,
>> so there is a memory corruption.
> 
> Thank you for pointing out that discrepancy. That's a good catch!
> 
> I'd prefer to fix this properly by making dqm->fence_addr a u64 pointer.
> We should probably also fix up the query_status and
> amdkfd_fence_wait_timeout function interfaces to use a 64 bit fence
> values everywhere to be consistent.
> 
> Regards,
>    Felix
Hi Felix, Thanks for your advice, please check v2 at 
https://lore.kernel.org/patchwork/patch/1372584/
Thanks,
Qu.
> 
> 
>>
>> Signed-off-by: Qu Huang <jinsdb@126.com>
>> ---
>>   drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
>> index e686ce2..8b38d0c 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
>> @@ -1161,7 +1161,7 @@ static int start_cpsch(struct device_queue_manager *dqm)
>>   	pr_debug("Allocating fence memory\n");
>>   
>>   	/* allocate fence memory on the gart */
>> -	retval = kfd_gtt_sa_allocate(dqm->dev, sizeof(*dqm->fence_addr),
>> +	retval = kfd_gtt_sa_allocate(dqm->dev, sizeof(uint64_t),
>>   					&dqm->fence_mem);
>>   
>>   	if (retval)

