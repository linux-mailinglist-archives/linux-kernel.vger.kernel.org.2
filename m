Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DA9A306C14
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 05:19:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231364AbhA1EP1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 23:15:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231336AbhA1EPL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 23:15:11 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 802A3C061793
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 19:51:35 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id q2so2595137plk.4
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 19:51:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=5/5Nw0RKDmqtkW6U2OGztqbU4sbce483ba0fNg4jHmE=;
        b=2H7Jq4BRpHGb4e6Zb8JdRsmhcW7tJMAZ3DsQEqjU3qgSQ87DRhATbE7momvtGaeN8z
         cPULqYS074E3yQVmL5k6TYZPM6AidXedpyNUvlChoDSqENwiuwSQrBYH7lp9UNoDynhw
         fWShW6Egc2g6ih5k/bpBQKHXksEo8dbQKY2UcVirufVtgWOQmwBArln9Afr3RiUW4Rbj
         myJI9z8Qsb+7DQ3RylIpWIgHz3dNfscCkRnObDsLkiOjpQoNYwJ0p2Q4SZWSuTnzQQcI
         6NrT0iNdOXxxK1M3aeVfjA1IEJ2EA0ClNxWrors1RdQe4CXQCR65hUjIL/x/V5pK+ODr
         WATw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5/5Nw0RKDmqtkW6U2OGztqbU4sbce483ba0fNg4jHmE=;
        b=om2zzQUtFagkMUzkMNtZ/qAcqbloGQnVmCn9LRlO+U1Fpzm12Oce4kTgYJmZF8/4ZS
         aummvJTlM+/uWFCACf4MmSU+3UHjpLWN/5bHWgfjEBY1hwfnALUtpAdTBf5fl7KEBtT4
         jSjC8wsqxBIX+T7KAA7HZpHaTtI68Cv2RkB2/n2bmnkGeAdT7L/ekBETkXzJZGtkdcg9
         rEHdFomNfzDsJIRIiDQ2SXSkq8OWjoXeZQbj1eAmKxv7DFOe1cILC0TlU88DiGHPZUeC
         1txUFOWP8Kb2EcB2FyfrX0OSxIjG7Vv8+tvQjdfTDDS4sKX5OUwgO07K+y01CoLpGhI3
         sa9A==
X-Gm-Message-State: AOAM530GFzu7ZXyCN1758zQ4SltMqPSz9O5PTLG6o/sBWpheUrfBSFil
        aNe5AGwU5FYxKbjmQTJ2c6v72WEMRQjamg==
X-Google-Smtp-Source: ABdhPJzvONeZ3sIE3s9ZX7koPMUSTsnSHN1rf92uuGfpU7wGgGioX0P8v9i3I4oQFoJl2lABlGl/oA==
X-Received: by 2002:a17:90b:368b:: with SMTP id mj11mr9050989pjb.76.1611805894673;
        Wed, 27 Jan 2021 19:51:34 -0800 (PST)
Received: from [192.168.4.41] (cpe-72-132-29-68.dc.res.rr.com. [72.132.29.68])
        by smtp.gmail.com with ESMTPSA id b65sm4012946pfg.3.2021.01.27.19.51.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Jan 2021 19:51:34 -0800 (PST)
Subject: Re: [PATCH v2] blk-cgroup: Use cond_resched() when destroy blkgs
To:     Baolin Wang <baolin.wang@linux.alibaba.com>, tj@kernel.org
Cc:     joseph.qi@linux.alibaba.com, linux-block@vger.kernel.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
References: <8e8a0c4644d5eb01b7f79ec9b67c2b240f4a6434.1611798287.git.baolin.wang@linux.alibaba.com>
 <3f3c12de-b5fb-a9ad-9324-55f5bf9d7453@kernel.dk>
 <f58ce890-d54c-e4a7-d379-ad4ad4ae20de@linux.alibaba.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <36d23f2a-4696-ff74-4423-6719b9670208@kernel.dk>
Date:   Wed, 27 Jan 2021 20:51:32 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <f58ce890-d54c-e4a7-d379-ad4ad4ae20de@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/27/21 8:49 PM, Baolin Wang wrote:
> 
> 
> 在 2021/1/28 11:41, Jens Axboe 写道:
>> On 1/27/21 8:22 PM, Baolin Wang wrote:
>>> On !PREEMPT kernel, we can get below softlockup when doing stress
>>> testing with creating and destroying block cgroup repeatly. The
>>> reason is it may take a long time to acquire the queue's lock in
>>> the loop of blkcg_destroy_blkgs(), or the system can accumulate a
>>> huge number of blkgs in pathological cases. We can add a need_resched()
>>> check on each loop and release locks and do cond_resched() if true
>>> to avoid this issue, since the blkcg_destroy_blkgs() is not called
>>> from atomic contexts.
>>>
>>> [ 4757.010308] watchdog: BUG: soft lockup - CPU#11 stuck for 94s!
>>> [ 4757.010698] Call trace:
>>> [ 4757.010700]  blkcg_destroy_blkgs+0x68/0x150
>>> [ 4757.010701]  cgwb_release_workfn+0x104/0x158
>>> [ 4757.010702]  process_one_work+0x1bc/0x3f0
>>> [ 4757.010704]  worker_thread+0x164/0x468
>>> [ 4757.010705]  kthread+0x108/0x138
>>
>> Kind of ugly with the two clauses for dropping the blkcg lock, one
>> being a cpu_relax() and the other a resched. How about something
>> like this:
>>
>>
>> diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
>> index 031114d454a6..4221a1539391 100644
>> --- a/block/blk-cgroup.c
>> +++ b/block/blk-cgroup.c
>> @@ -1016,6 +1016,8 @@ static void blkcg_css_offline(struct cgroup_subsys_state *css)
>>    */
>>   void blkcg_destroy_blkgs(struct blkcg *blkcg)
>>   {
>> +	might_sleep();
>> +
>>   	spin_lock_irq(&blkcg->lock);
>>   
>>   	while (!hlist_empty(&blkcg->blkg_list)) {
>> @@ -1023,14 +1025,20 @@ void blkcg_destroy_blkgs(struct blkcg *blkcg)
>>   						struct blkcg_gq, blkcg_node);
>>   		struct request_queue *q = blkg->q;
>>   
>> -		if (spin_trylock(&q->queue_lock)) {
>> -			blkg_destroy(blkg);
>> -			spin_unlock(&q->queue_lock);
>> -		} else {
>> +		if (need_resched() || !spin_trylock(&q->queue_lock)) {
>> +			/*
>> +			 * Given that the system can accumulate a huge number
>> +			 * of blkgs in pathological cases, check to see if we
>> +			 * need to rescheduling to avoid softlockup.
>> +			 */
>>   			spin_unlock_irq(&blkcg->lock);
>> -			cpu_relax();
>> +			cond_resched();
>>   			spin_lock_irq(&blkcg->lock);
>> +			continue;
>>   		}
>> +
>> +		blkg_destroy(blkg);
>> +		spin_unlock(&q->queue_lock);
>>   	}
>>   
>>   	spin_unlock_irq(&blkcg->lock);
>>
> 
> Looks better to me. Do I need resend with your suggestion? Thanks.

Probably best, gives Tejun another chance to sign off on it :-)


-- 
Jens Axboe

