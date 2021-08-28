Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D69893FA355
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Aug 2021 05:19:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233202AbhH1DTR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Aug 2021 23:19:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233117AbhH1DTN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Aug 2021 23:19:13 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9F19C0613D9
        for <linux-kernel@vger.kernel.org>; Fri, 27 Aug 2021 20:18:23 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id f6so11614319iox.0
        for <linux-kernel@vger.kernel.org>; Fri, 27 Aug 2021 20:18:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3I2Cu0hBkyC0eu8QwfehQRNRrLF5kE2Nh3wW304WegI=;
        b=VFc6nnAr/WImQdqxvEVT41P7sUbT0ys0GLIzwNul0ab7smJx8tK8ypODc8gP/mERLl
         ZUsl/ci0RDvaEL1kdtTX7Cq+c4oV018Xm9DmOSP1LfEzZOGow0MUYCcTYWxXG4hYeV1w
         WrFmbucTiKSnLJcliTcKu59QWjzSWN8ijvOK0cNdsTBmf61n9sOHGknE7g+7Tw+PuYWh
         Fu4eztVYTECtsgMOAPGRbpFRtDNaZYddgU1ppgbqRIAkU/2GUmh1QQ7ZQvQEjL/U0pfx
         RW0fY3WGzah8VWtjaGgjpTvhS5HBkKQ1T7B2DywgLCvQP/zWCqFMbVVtNUTMrk2EKBxR
         X0Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3I2Cu0hBkyC0eu8QwfehQRNRrLF5kE2Nh3wW304WegI=;
        b=gFt99HLnntfpb1EH2CHZ1JTOjoWVMBApbtg5hh6Z4Xi9pqx632P9Vztkx7TuKCPehl
         0JdAPhXhqeA6ZDHzhexCpmivm008r6KQ7CFZzxiJEiC56SBUKWIsFST+aLxeD106ZGDS
         dqdBzaTinlWyrl0dbKGs7wF1NWkwzCC0FlaBIL2Z9fBQHtJA5dVjq6qrfuj9tzPt6ngO
         SNBe6hVpV2xj1NqpWwkmdbAS9kJac1KGtZQbfI/DFVEzUsQVOh6OQu7g+tnYoZzaEmFD
         5l0MpZZct5ODOvpSe46BGkM++XbTufr0TqXN41crD4hPih3J2bNZUAcovlGKRz4ahqfK
         0v/g==
X-Gm-Message-State: AOAM531BDkhP4r0WKA5YqBhvv2H1AsOF7AqySy5peBsJqUd3ZDbxH5ys
        /wqULgiw84s5sU6Gj5wVjN2w+VTNWJym/Q==
X-Google-Smtp-Source: ABdhPJx9J4qf7Eq2U2ilnV92laAQModKiua7oN74ITr/ABlhBbh8ljKdjCNGRSeS/BRV7m/j0/d8rg==
X-Received: by 2002:a02:860d:: with SMTP id e13mr10974218jai.12.1630120702695;
        Fri, 27 Aug 2021 20:18:22 -0700 (PDT)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id a17sm4527227ios.36.2021.08.27.20.18.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Aug 2021 20:18:22 -0700 (PDT)
Subject: Re: [PATCH] drivers/cdrom: improved ioctl for media change detection
To:     Lukas Prediger <lumip@lumip.de>
Cc:     linux-kernel@vger.kernel.org
References: <20210805194417.12439-1-lumip@lumip.de>
 <6d6c533d-465e-33ee-5801-cb7ea84924a8@kernel.dk>
 <f0d33ff3-6b9d-bbe7-1776-a22f9f271155@lumip.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <5f3b7d8b-9e97-094b-efd1-cad6cab793b6@kernel.dk>
Date:   Fri, 27 Aug 2021 21:18:16 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <f0d33ff3-6b9d-bbe7-1776-a22f9f271155@lumip.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/27/21 11:30 AM, Lukas Prediger wrote:
>>> @@ -295,6 +297,19 @@ struct cdrom_generic_command
>>>  	};
>>>  };
>>>  
>>> +/* This struct is used by CDROM_TIMED_MEDIA_CHANGE */
>>> +struct cdrom_timed_media_change_info
>>> +{
>>> +	__u64   last_media_change;	/* Timestamp of the last detected media
>>> +					 * change. May be set by caller, updated
>>> +					 * upon successful return of ioctl.
>>> +					 */
>>> +	__u8    has_changed;		/* Set to 1 by ioctl if last detected media
>>> +					 * change was more recent than
>>> +					 * last_media_change set by caller.
>>> +					 */
>>> +};
>>>
>> The struct layout should be modified such that there are no holes or
>> padding in it. Probably just make the has_changed a flags thing, and
>> make it u64 as well. Then you can define bit 0 to be HAS_CHANGED, and
>> that leaves you room to add more flags in the future. Though the latter
>> probably isn't much of a concern here, but...
> 
> 1. jiffies_to_msecs returns unsigned int. Should I reflect that in the
> struct (i.e., make the last_media_change and has_changed fields also
> of type unsigned int or should I keep them at a fixed bit width?

You can make it an u32. Always use explicitly sized types for user API
structures.

> 2. As the last_media_change field will be in ms now, is it safe to
> convert those back to jiffies for comparison or is there a risk of
> information loss (due to rounding or whatever) in either conversion?
> More technically, can I make the assumption that for any jiffies value
> x it holds that

The granularity of jiffies depends on the HZ setting, generally just
consider it somewhere in between 100 and 1000. That's where my initial
granularity numbers came from.

> time_before(msecs_to_jiffies(jiffies_to_msecs(x)), x) is always false ?

I don't think that matters. Internally, always keep things in jiffies.
That's what you use to compare with, and to check if it's changed since
last time. The only time you convert to ms is to pass it back to
userspace. And that's going to be a delta of jiffies always, just ensure
you assign last_checked = jiffies when it's setup initially.

-- 
Jens Axboe

