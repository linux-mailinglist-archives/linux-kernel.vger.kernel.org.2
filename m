Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C700F3FA608
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Aug 2021 15:24:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234389AbhH1NXP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Aug 2021 09:23:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234283AbhH1NXN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Aug 2021 09:23:13 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54F7FC061756
        for <linux-kernel@vger.kernel.org>; Sat, 28 Aug 2021 06:22:23 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id g8so10283465ilc.5
        for <linux-kernel@vger.kernel.org>; Sat, 28 Aug 2021 06:22:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=N6/NoqLq5q1eHvZ7SMZ/ClJchNVm9VRivYbF3KYVhKw=;
        b=Un4PJAhwZv5pNMmH3mkzhg1d58qNoL/PeLZlvNbaNx/7hHQJGTnVhOy+DY0SjnNXQQ
         wRKsA3uSUwESvi0oOg2V4MICkKiJF92bkQTsVSRzZeeHqUgsVLMSjwZ7u/urWs5HZxZ6
         hqdQUvLnwz2uiHR8Stum1AsBtAJRNmsKuyG564OGRsF0ObR/h9AXsuqTnY9lvUA5LBs3
         1LR9omaK+Yl5CS5DyGX7sZbIrgin1qTX7NWG/PMxqYih/kUqC5LEnUmaFxxWLwA1csv8
         0qGsYXvD+wWBNOHswJfvKGfXvAfZVlaTsCqwTPPpEQOCJIXTg0NK2zbR/3rtcU3ETqw3
         OcVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=N6/NoqLq5q1eHvZ7SMZ/ClJchNVm9VRivYbF3KYVhKw=;
        b=l1GH9B3eKmZ2GNtUVDzeDA68J9oeZM/E7QrMK4CUvb5fXbCD0igJ+jgqjgeBonWeGF
         nSYKV/O5lrPmNYVOt5BBaNGK5IhcE+HytUmzybbgkmljvXLiX3FSgUvlKEOhlbnxGCbf
         PpxFtD1qM/l1UVgySWr+F8cqInB3QZSxPQnBEagIpY9RhIICvci5UJLIRydNzFeiV7PN
         ASlJo/Yww9USZTVp51WVC7dpTWW4e2D/ItjqI2SeQgLdDrvUjA14HF1714DsI/qpClo/
         wgyl60gjHF/J9ZGPwZRtU44uZvcHcsKisSucRXWkUsdZyrig0C+XDOm5pciVmkFEIhW/
         Pp9A==
X-Gm-Message-State: AOAM531J+Mzu5iPYBAu+903iiITao76xaAg0daGBlVtECre4zkSik9eJ
        IUcupsboEfWR3cMwexyl6ba3YWUEtHh7LQ==
X-Google-Smtp-Source: ABdhPJx2AkriLG9n/UhIAzKeA5zRoHoKPWtB2in9ituR5+KdoU5wn1e9gja7TnjFQov7tpvGCex4Lg==
X-Received: by 2002:a05:6e02:e42:: with SMTP id l2mr9887189ilk.285.1630156942430;
        Sat, 28 Aug 2021 06:22:22 -0700 (PDT)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id a17sm5251294ios.36.2021.08.28.06.22.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 28 Aug 2021 06:22:21 -0700 (PDT)
Subject: Re: [PATCH] drivers/cdrom: improved ioctl for media change detection
To:     Lukas Prediger <lukas.prediger@lumip.de>
Cc:     linux-kernel@vger.kernel.org
References: <20210805194417.12439-1-lumip@lumip.de>
 <6d6c533d-465e-33ee-5801-cb7ea84924a8@kernel.dk>
 <f0d33ff3-6b9d-bbe7-1776-a22f9f271155@lumip.de>
 <5f3b7d8b-9e97-094b-efd1-cad6cab793b6@kernel.dk>
 <6bbfc86d-8e3b-db5e-0bf5-8bce63d2049f@lumip.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <2f78b2f4-e290-fb58-c097-0f2fdf781f02@kernel.dk>
Date:   Sat, 28 Aug 2021 07:22:20 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <6bbfc86d-8e3b-db5e-0bf5-8bce63d2049f@lumip.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/28/21 4:27 AM, Lukas Prediger wrote:
> Thanks for the reply and sorry for the spam :/. I am not sure what 
> happened there.
> 
>>> 2. As the last_media_change field will be in ms now, is it safe to
>>> convert those back to jiffies for comparison or is there a risk of
>>> information loss (due to rounding or whatever) in either conversion?
>>> More technically, can I make the assumption that for any jiffies value
>>> x it holds that
>> The granularity of jiffies depends on the HZ setting, generally just
>> consider it somewhere in between 100 and 1000. That's where my initial
>> granularity numbers came from.
>>
>>> time_before(msecs_to_jiffies(jiffies_to_msecs(x)), x) is always false ?
>> I don't think that matters. Internally, always keep things in jiffies.
>> That's what you use to compare with, and to check if it's changed since
>> last time. The only time you convert to ms is to pass it back to
>> userspace. And that's going to be a delta of jiffies always, just ensure
>> you assign last_checked = jiffies when it's setup initially.
>>
> The issue I have is that the value I am comparing to is provided by
> the code calling the ioctl so that I don't have to maintain state for
> every potential calling process in the kernel. Therefore, if we want
> the API to work with ms, I have to convert the user provided value
> back to jiffies for comparison. 
> 
> I now ran a brief test that suggests that the above condition does not
> hold and therefore the value returned in has_changed may be 1 for
> subsequent calls when the disc was not in fact changed.
> 
> Workarounds I see would be to either expose the jiffies value through
> the API (which is maybe not really clean), or making the comparison on
> the ms value (but how to deal with potential wraparounds then?). Of
> those, I would currently tend to the first and treat the nature of the
> returned timestamp as an opaque value from the user perspective - it
> is probably not really of any use to them outside of passing it back
> into the ioctl for subsequent calls. Do you see other ways to resolve
> this I may not have thought of?

Maybe it's better to just use ms internally too, and avoid the whole
conversion side of things. Hence just use ktime_get() and ktime_to_ms().

-- 
Jens Axboe

