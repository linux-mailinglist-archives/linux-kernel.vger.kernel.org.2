Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C6A633F52D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 17:11:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232418AbhCQQKq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 12:10:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232374AbhCQQKM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 12:10:12 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20FE0C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 09:10:12 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id n132so41541853iod.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 09:10:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=TM7+lzl1LSJKUe4zDj6BKysuV/V7IQ8pfAUZqy6AqQc=;
        b=KQV7+qiTaaTFfLCb4Ta+a5reqtMXZctLNeuHniJ1g3ZeeA4zDXM/YNsfLC64ZlzSVI
         5TmegRuS5vt89jHsXbCQtpxoEHL5GDsEkaL0kYgCw2apEvkrmAAKfv/JTxIgSI/DTl1L
         smIZBicW0xu6P0zH3u1itlr2xt+bON3GpTVQ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TM7+lzl1LSJKUe4zDj6BKysuV/V7IQ8pfAUZqy6AqQc=;
        b=DaqL2K8OeeLd7r9P+K4vf+83uzoEgYIpvYxHAViqnWSOOBWTjWOI12B+hg6+jWzhhB
         KsclARHsH9QOjCQOc239ia5efsZLTUcprqL6NlHlNlJQYwzFDyk8UD2YthXyRuDNnGjd
         M/6Xfw81lbpCr+A4J25TvQZROEgCWMllXXiIQW7L2AOqBVU+F8Vxcx2QJ/PMs0Gj1hGJ
         QRyKx/4hUTFl6Ctdz8VNoHc288M+hhd+/No8x4dPe9vUEaT5cGzqyHxM2GyJ5I5FDGBR
         YVjUJvGCde9pJdtSAqFP+aHPphHyUIifsyGmq+dE2HVEo8uRWAjFlCNRq/9mpzpGrAqm
         W0OA==
X-Gm-Message-State: AOAM533FqEU6D/HYqLtxM1Mr0sn9wfbvUfNluhlwI8E4SLZcqWMS0Pl3
        qp5qqMxXgUuTR5IsgskzObNS/w02OnbajQ==
X-Google-Smtp-Source: ABdhPJy/pwoFdluO/whJN8eY/KG9zuwMjWOW9vVmirNxfeofy4HVowqll60980s1cwaba39COZa3+Q==
X-Received: by 2002:a92:c246:: with SMTP id k6mr7696091ilo.263.1615993608567;
        Wed, 17 Mar 2021 08:06:48 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id h2sm9585199ioj.30.2021.03.17.08.06.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Mar 2021 08:06:47 -0700 (PDT)
Subject: Re: [PATCH 0/6] usbip fixes to crashes found by syzbot
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, shuah@kernel.org
Cc:     valentina.manea.m@gmail.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <cover.1615171203.git.skhan@linuxfoundation.org>
 <YEkQ4qS7tkwmjzDn@kroah.com>
 <5baf6b94-72c4-6e69-65a5-35c5cfb8ca0e@i-love.sakura.ne.jp>
 <YEoTw7CoK7Ob0YR+@kroah.com>
 <8dc1e893-4338-90ff-ea61-de727cad1d11@i-love.sakura.ne.jp>
 <afd1341b-2ed1-f781-d6c8-6064fea3aeb8@i-love.sakura.ne.jp>
 <192bdb07-da84-ce96-2e25-7c0df749940a@i-love.sakura.ne.jp>
 <9e089560-388a-a82d-4841-8092578b9d5d@i-love.sakura.ne.jp>
 <465479ca-544e-3703-cf4e-30f5be04fa11@i-love.sakura.ne.jp>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <fbf64c33-87c3-137c-4faf-66de651243fc@linuxfoundation.org>
Date:   Wed, 17 Mar 2021 09:06:47 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <465479ca-544e-3703-cf4e-30f5be04fa11@i-love.sakura.ne.jp>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/17/21 12:21 AM, Tetsuo Handa wrote:
> Shuah, this driver is getting more and more cryptic and buggy.
> Please explain the strategy for serialization before you write patches.
> 
>> - Fix attach_store() to check usbip_event_happened() before
>>    waking up threads.
> 
> No, this helps nothing.
> 
>> diff --git a/drivers/usb/usbip/vhci_sysfs.c b/drivers/usb/usbip/vhci_sysfs.c
>> index c4b4256e5dad3..f0a770adebd97 100644
>> --- a/drivers/usb/usbip/vhci_sysfs.c
>> +++ b/drivers/usb/usbip/vhci_sysfs.c
>> @@ -418,6 +418,15 @@ static ssize_t attach_store(struct device *dev, struct device_attribute *attr,
>>   	spin_unlock_irqrestore(&vhci->lock, flags);
>>   	/* end the lock */
>>   
>> +	if (usbip_event_happened(&vdev->ud)) {
>> +		/*
>> +		 * something went wrong - event handler shutting
>> +		 * the connection and doing reset - bail out
>> +		 */
>> +		dev_err(dev, "Event happended - handler is active\n");
>> +		return -EAGAIN;
>> +	}
>> +
> 
> detach_store() can queue shutdown event as soon as reaching "/* end the lock */" line
> but attach_store() might be preempted immediately after verifying that
> usbip_event_happened() was false (i.e. at this location) in order to wait for
> shutdown event posted by detach_store() to be processed.
> 

Yes. I haven't sent the patch for that reason. I am trying to test a
solution. I haven't come up with a solution yet.

Holding event_lock isn't the right solution. I am not going to accept
that. This is a window that gets triggered by syzbot injecting errors
in a sequence. Fixing this should be done taking other moving parts of
the driver into account.

thanks,
-- Shuah
