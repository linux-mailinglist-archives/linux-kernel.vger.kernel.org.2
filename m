Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D865459C27
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 07:02:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233414AbhKWGFp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 01:05:45 -0500
Received: from smtp04.smtpout.orange.fr ([80.12.242.126]:53780 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbhKWGFo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 01:05:44 -0500
Received: from [192.168.1.18] ([86.243.171.122])
        by smtp.orange.fr with ESMTPA
        id pOswmPY11soWhpOswmyxXs; Tue, 23 Nov 2021 07:02:35 +0100
X-ME-Helo: [192.168.1.18]
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Tue, 23 Nov 2021 07:02:35 +0100
X-ME-IP: 86.243.171.122
Subject: Re: [PATCH 2/2] drm/amdkfd: Slighly optimize 'init_doorbell_bitmap()'
To:     Felix Kuehling <felix.kuehling@amd.com>, alexander.deucher@amd.com,
        christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@linux.ie,
        daniel@ffwll.ch
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <2343a4e6547a8436419308744ba8c433088922a5.1637516393.git.christophe.jaillet@wanadoo.fr>
 <3e54737649cf94daabaa5b51db9f4c21d43124fe.1637516393.git.christophe.jaillet@wanadoo.fr>
 <283c0b53-ff4e-85f8-4738-2d477365f458@amd.com>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Message-ID: <306b774e-6ee7-c976-a303-f566f7ba626c@wanadoo.fr>
Date:   Tue, 23 Nov 2021 07:02:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <283c0b53-ff4e-85f8-4738-2d477365f458@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 22/11/2021 à 22:44, Felix Kuehling a écrit :
> Am 2021-11-21 um 12:41 p.m. schrieb Christophe JAILLET:
>> The 'doorbell_bitmap' bitmap has just been allocated. So we can use the
>> non-atomic '__set_bit()' function to save a few cycles as no concurrent
>> access can happen.
>>
>> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> 
> Thank you for the patches. I think the same sort of change (at least the
> allocation/freeing part) could be applied to the queue_slot_bitmap in
> kfd_process_queue_manager.c. Would you like to submit another revision
> of this patch series that handles that as well?

I'll send a v2 which will fix the missing ',' spotted by the kernel test 
robot and include kfd_process_queue_manager.c.

All my patches are compile tested (otherwise it is said bellow the ---). 
Looks like I missed this one :(.

CJ

> 
> Either way, this series is
> 
> Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
> 
> 
>> ---
>> bitmap_set() could certainly also be use, but range checking would be
>> tricky.
>> ---
>>   drivers/gpu/drm/amd/amdkfd/kfd_process.c | 6 +++---
>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>> index 172ee8763523..2e9d341062c4 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>> @@ -1447,9 +1447,9 @@ static int init_doorbell_bitmap(struct qcm_process_device *qpd,
>>   
>>   	for (i = 0; i < KFD_MAX_NUM_OF_QUEUES_PER_PROCESS / 2; i++) {
>>   		if (i >= range_start && i <= range_end) {
>> -			set_bit(i, qpd->doorbell_bitmap);
>> -			set_bit(i + KFD_QUEUE_DOORBELL_MIRROR_OFFSET,
>> -				qpd->doorbell_bitmap);
>> +			__set_bit(i, qpd->doorbell_bitmap);
>> +			__set_bit(i + KFD_QUEUE_DOORBELL_MIRROR_OFFSET,
>> +				  qpd->doorbell_bitmap);
>>   		}
>>   	}
>>   
> 

