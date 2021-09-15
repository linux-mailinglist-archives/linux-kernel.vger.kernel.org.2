Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1706540C132
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 10:06:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236932AbhIOIHm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 04:07:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236996AbhIOIHb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 04:07:31 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E59BDC061574
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 01:06:12 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id d6so2383074wrc.11
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 01:06:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ZE0PeTRh9qfRZGJNwCzqtIG58jlteNMLdoVqfOwsJSc=;
        b=PiLZA/X9ua4zt13neVQpgP6jN+QDMTGTzbeUs/sHSbBf+dH/4iYMdnQ8XWtx7dF76q
         zhaWYh1exDJt+ed9kyDp6D75YhjZXgvgiwL5vpaRy2oa8TcvpfvfqKMOqXZSxdn2a9/L
         clmXSH4OwOJ0iL8ZZG2hBDHa7BgCsvXyG0/8uj8kMmUJIMf1XZ7Zruhg6ycOwm43vcTL
         rmn4fcAv2g4zu7yTHQsFbItaDImlg/1glSrU1y7WedAvExdsWcfJukJ0uAePMkfQafdL
         9CohDlXmn6ps2tvAuW7EJlbklXwIA8JCwXzvB6bh3Q97hrB+pTjo9zzjmTI7hwYbLLFp
         j09w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZE0PeTRh9qfRZGJNwCzqtIG58jlteNMLdoVqfOwsJSc=;
        b=59rR5FL18E2l2zPo9PHTp/WXKyuoEHkvBpEYkdnwMbVxaNEhNvMXqYzWwJdnvKTzuz
         qdtBbtrh8siJrcWo/1jSZ0EXJcW9uhkXJfIxiNbDBiyzuDJfgcRBnmgImWZEs1agH1Eg
         9y3Xlm6wlxc4IG8LOsS74tHwXv8KrXbnmX31sVTt/nuupdKwNecleiZsMxEZsIQwnePh
         x6RR2Z/E3fXQLkuXcq47YgG2AmrwgxFIvSCoY33fSySvQ6ffVmorE/Ow8eJ5G9CGPuSK
         dRWoHkmW+qE3MVKapH2pP0rXnPSIlMmYkU3rxRXKxFPQSpUR/KdtTDreOvPYm6WFpXfz
         yotQ==
X-Gm-Message-State: AOAM5314SgvI8CvoKsmFEQfAWd3vrRRMr0a5Bv3LG6Gh5I7UG/pAD5DL
        OMq0D4fvCqkavwd8pw/GVwkobV9TOY4xFA==
X-Google-Smtp-Source: ABdhPJwJ2evMM3o2cbEHd2qfC2Zc9a0Zn5BEoBr1iOPEPLIAfRVXA2v74v/MCXQdflid0JKN7ihvHg==
X-Received: by 2002:a5d:4a46:: with SMTP id v6mr3451302wrs.262.1631693171268;
        Wed, 15 Sep 2021 01:06:11 -0700 (PDT)
Received: from ?IPv6:2a00:1098:3142:14:1538:6132:c93a:c98c? ([2a00:1098:3142:14:1538:6132:c93a:c98c])
        by smtp.gmail.com with ESMTPSA id j4sm13056800wrt.23.2021.09.15.01.06.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Sep 2021 01:06:10 -0700 (PDT)
Subject: Re: [PATCH 1/8] staging: vchiq_arm: replace sleep() with
 usleep_range()
To:     Stefan Wahren <stefan.wahren@i2se.com>,
        Gaston Gonzalez <gascoar@gmail.com>,
        linux-staging@lists.linux.dev
Cc:     gregkh@linuxfoundation.org, nsaenz@kernel.org, arnd@arndb.de,
        dan.carpenter@oracle.com, ojaswin98@gmail.com,
        amarjargal16@gmail.com, linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com, linux-kernel@vger.kernel.org
References: <20210914213532.396654-1-gascoar@gmail.com>
 <260b38b8-6f3f-f6cc-0388-09a269ead507@i2se.com>
From:   Phil Elwell <phil@raspberrypi.com>
Message-ID: <d09502f2-84d2-839f-1350-ae7f248e5981@raspberrypi.com>
Date:   Wed, 15 Sep 2021 09:06:09 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <260b38b8-6f3f-f6cc-0388-09a269ead507@i2se.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stefan,

On 15/09/2021 06:21, Stefan Wahren wrote:
> Hi,
> 
> Am 14.09.21 um 23:35 schrieb Gaston Gonzalez:
>> usleep_range() should be used instead of sleep() when sleepings range
>> from 10 us to 20 ms, [1].
>>
>> Reported by checkpatch.pl
>>
>> [1] Documentation/timers/timers-howto.txt
>> ---
>>   drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
>> index b25369a13452..0214ae37e01f 100644
>> --- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
>> +++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
>> @@ -824,7 +824,7 @@ vchiq_bulk_transmit(unsigned int handle, const void *data, unsigned int size,
>>   		if (status != VCHIQ_RETRY)
>>   			break;
>>   
>> -		msleep(1);
>> +		usleep_range(1000, 1100);
> 
> from my understanding the usage of usleep_range() and hrtimers isn't
> necessary here. The intention is to sleep a little bit and not "exactly"
> 1 ms.
> 
> @Phil Elwell: what is your opinion?

Exactly - the aim is just to stop it spinning.

Phil
