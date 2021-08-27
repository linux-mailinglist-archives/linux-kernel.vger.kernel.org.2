Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A73BD3F9E10
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Aug 2021 19:35:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236573AbhH0RbQ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 27 Aug 2021 13:31:16 -0400
Received: from smtprelay01.ispgateway.de ([80.67.31.35]:9111 "EHLO
        smtprelay01.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230035AbhH0RbO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Aug 2021 13:31:14 -0400
X-Greylist: delayed 84542 seconds by postgrey-1.27 at vger.kernel.org; Fri, 27 Aug 2021 13:31:14 EDT
Received: from [87.92.210.171] (helo=[192.168.0.111])
        by smtprelay01.ispgateway.de with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <lumip@lumip.de>)
        id 1mJfgn-00027z-Eh; Fri, 27 Aug 2021 19:30:49 +0200
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-kernel@vger.kernel.org
References: <20210805194417.12439-1-lumip@lumip.de>
 <6d6c533d-465e-33ee-5801-cb7ea84924a8@kernel.dk>
From:   Lukas Prediger <lumip@lumip.de>
Subject: Re: [PATCH] drivers/cdrom: improved ioctl for media change detection
Message-ID: <f0d33ff3-6b9d-bbe7-1776-a22f9f271155@lumip.de>
Date:   Fri, 27 Aug 2021 20:30:20 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <6d6c533d-465e-33ee-5801-cb7ea84924a8@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Content-Language: en-US
X-Df-Sender: bHVrYXMucHJlZGlnZXJAbHVtaXAuZGU=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27.08.21 01:38, Jens Axboe wrote:

> Thanks for sending in the patch, appologies it's taken so long to get a
> response. CDROM isn't really actively maintained much these days,
> unfortunately. Should get a new maintainer.
>
> Anyway, for this patch, few comments inline.

Thanks for the feedback, I'm currently editing the patch to improve it based on your suggestions.
Some questions before resubmitting below.

> I'd just use jiffies for this, it's not really a case of something that
> needs a fine grained clock source. That'll give you 1-10ms resolution,
> which should be more than adequate for this. Then use jiffies_to_msecs()
> and make the API be in miliseconds.

>> @@ -295,6 +297,19 @@ struct cdrom_generic_command
>>  	};
>>  };
>>  
>> +/* This struct is used by CDROM_TIMED_MEDIA_CHANGE */
>> +struct cdrom_timed_media_change_info
>> +{
>> +	__u64   last_media_change;	/* Timestamp of the last detected media
>> +					 * change. May be set by caller, updated
>> +					 * upon successful return of ioctl.
>> +					 */
>> +	__u8    has_changed;		/* Set to 1 by ioctl if last detected media
>> +					 * change was more recent than
>> +					 * last_media_change set by caller.
>> +					 */
>> +};
>>
> The struct layout should be modified such that there are no holes or
> padding in it. Probably just make the has_changed a flags thing, and
> make it u64 as well. Then you can define bit 0 to be HAS_CHANGED, and
> that leaves you room to add more flags in the future. Though the latter
> probably isn't much of a concern here, but...

1. jiffies_to_msecs returns unsigned int. Should I reflect that in the struct (i.e., make the
last_media_change and has_changed fields also of type unsigned int or should I keep them at
a fixed bit width?

2. As the last_media_change field will be in ms now, is it safe to convert those back to jiffies
for comparison or is there a risk of information loss (due to rounding or whatever) in either conversion?
More technically, can I make the assumption that for any jiffies value x it holds that

time_before(msecs_to_jiffies(jiffies_to_msecs(x)), x) is always false ?

I tried to determine that from the code, but I haven't reached a conclusion that I'm confident in..

Kind regards,
Lukas


