Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D38B5452A53
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 07:06:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232316AbhKPGIQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 01:08:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230489AbhKPGH5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 01:07:57 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E7FDC061570
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 22:05:00 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id i12so175338pfd.6
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 22:05:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=bFUeJG1PK9M94eXJmjy8xlktobGNPFdvyVdHGVDoXdY=;
        b=eGTQ7I2u8pR3PkbccaeyYQs7RCyRw0UVLRi5wDUNsC4lC7NAV/wGQWE5a00v6hdNCS
         UfBv8zXuWg6pZZZAf5IBs/Fq/MFOVJr9bcnwKnnT8djO/1Mvm1gWdZ4iPsYnR+YqJKO1
         OeC8vGZY+UusbCE1z3ynqoPrHADnkRpIL8BmkoxALG88Ae/enXuHBymOZnpNXQS21GrD
         /xKimUIM0MyAsevMAIjqiBgKAqU+2ixyPA/H0cfyHdyPyCB//qnPiP8SvNtVvN2Ghwj+
         nww7IhbKxubsnOkeJ8sincxt98QtBu55muDXYhkeSTocr+2m5R2V6jWU2O9LoH/oNAFs
         W20A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=bFUeJG1PK9M94eXJmjy8xlktobGNPFdvyVdHGVDoXdY=;
        b=MpWVUcfgBWGu8i8oVt3K6HRF5X59vBNNrgrLUzZAq5LiSB8Zr+MWBXmWZC8M93OaDb
         ebNjgztnkMrLsYGqqSXvcNmTeopXd2aes/ZNLrq/UweMXsCLKBEliI4xoWiNgnPa3mEq
         PVpyJzF8qqCq/MO5/qx+gIygwq33JQzetpZ7vl0lbtQQbn+1hanwDgya3xouCqSBMMFU
         gHX4/0vpFSCAA4QqrzQc8DB4rxxm7qEq7HUPWRzycwpgZCCOQ8fZeN/pjFPMchGOSDBl
         gqYRxiINTKmd3W7jx7uFB0k70EL2qSOhnUiIlcW1qc7xBlDBQJkdYuFubS2dSEJNW06T
         9HYg==
X-Gm-Message-State: AOAM5323MOtyeVgIS7MwkIWPrE5GezEps5mxG6hqXjJZ/Tv2nBCume77
        8nrxn3nMGMIbd3OGrevlCrS9juOa8HQ=
X-Google-Smtp-Source: ABdhPJwf6HMS5nA8V3e4KuZjx5RKOPadX/pvdJ5D86x7OCiqK7KoKUW2PfnwxFVJANxN7NXcPIdc6g==
X-Received: by 2002:a63:595c:: with SMTP id j28mr3224266pgm.350.1637042699928;
        Mon, 15 Nov 2021 22:04:59 -0800 (PST)
Received: from [172.18.2.138] ([137.59.101.13])
        by smtp.gmail.com with ESMTPSA id s30sm17587800pfg.17.2021.11.15.22.04.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Nov 2021 22:04:59 -0800 (PST)
Subject: Re: [PATCH] watchdog: ignore nohz_full cores in new cpumask
To:     Petr Mladek <pmladek@suse.com>
Cc:     akpm@linux-foundation.org, frederic@kernel.org,
        linux-kernel@vger.kernel.org
References: <20211112051434.23642-1-qiang.zhang1211@gmail.com>
 <YZJ9ZNusQR/3nh/9@alley>
From:   Zqiang <qiang.zhang1211@gmail.com>
Message-ID: <a8426729-6fd8-4855-d934-552d80f74561@gmail.com>
Date:   Tue, 16 Nov 2021 14:04:57 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YZJ9ZNusQR/3nh/9@alley>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2021/11/15 下午11:31, Petr Mladek wrote:
> On Fri 2021-11-12 13:14:34, Zqiang wrote:
>> If the nohz_full is enabled, when update watchdog_mask, the
>> nohz_full cores should be ignored.
>>
>> Signed-off-by: Zqiang <qiang.zhang1211@gmail.com>
>> ---
>>   kernel/watchdog.c | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/kernel/watchdog.c b/kernel/watchdog.c
>> index ad912511a0c0..3ef11a94783c 100644
>> --- a/kernel/watchdog.c
>> +++ b/kernel/watchdog.c
>> @@ -628,7 +628,9 @@ void lockup_detector_soft_poweroff(void)
>>   static void proc_watchdog_update(void)
>>   {
>>   	/* Remove impossible cpus to keep sysctl output clean. */
>> -	cpumask_and(&watchdog_cpumask, &watchdog_cpumask, cpu_possible_mask);
>> +	cpumask_and(&watchdog_cpumask, &watchdog_cpumask,
>> housekeeping_cpumask(HK_FLAG_TIMER));
> I am not familiar with nozh_full code but this looks fine.
>
>
>> +	if (cpumask_empty(&watchdog_cpumask))
>> +		return;
> But this looks looks wrong. Is there any reason for this?
>
> We need to stop the watchdog when it was running before.
>
> I mean that lockup_detector_reconfigure() must be called anytime
> when the mask has changed even when it became empty.

Thanks Petr

I will resend patch v2.

>
>
>>   	lockup_detector_reconfigure();
>>   }
> Best Regards,
> Petr
