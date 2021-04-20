Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CBE13660EA
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 22:30:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233912AbhDTUbH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 16:31:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233864AbhDTUbF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 16:31:05 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3696CC06138A
        for <linux-kernel@vger.kernel.org>; Tue, 20 Apr 2021 13:30:32 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id i190so26442986pfc.12
        for <linux-kernel@vger.kernel.org>; Tue, 20 Apr 2021 13:30:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=I0EdX6Z/acORAf6ns8xMAuM0MoN9fdagShR1XPcLHTU=;
        b=AJydimSR/zhzpyQHNvRYem5HMAnHQ0P1xKF7UzFMcctjylEHZ5Kz3E9XtBtfyMFvxa
         XY0s+kKLfu+hcuIZSCAQTLCLgns6WwP+IS7Pa2b7Dijf5xxUNzluMyLi0Shmj1nHkwHY
         avneTJhJOZHYJiM7dL041Za5DnzDUMT2uO/s78XtgcMTgl0R08c5qmTJ+39V1/DcSLb+
         T6dOhjYxTvl5HB9TBoFaGcUz9j5ePwUGSLnsI9pDykprLhfokEDJ62IXyUPr0d4jT4K6
         NSSW6ziqXlAxyYcJXwAmvoyvq+iwZ6ZczM8fvURqIfsgNHQhq6rXTRh15U9xu7sj4D8v
         AdgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=I0EdX6Z/acORAf6ns8xMAuM0MoN9fdagShR1XPcLHTU=;
        b=G8+TzPXSTvAHVr1YeQ/VkKwFv57o2nZv/HA5dUh6MRR1myeP7AXxCUu9LPgfxneGf1
         XMSMd+6RqSAtZp9vQo7Js3+5v53YkJASOwgS6itMJtF6dwDzhVRE9cFSZF1ChVJ1vDws
         bVLvSRLhi+92uhB4YD2SAntxpofd3fNdpHfKQ4fp+UOZAjU16pGPo+SrbCnXWrRV53kA
         QBehMFHLSCm/Qqd1TNM2iaWBOB/APC2or1nK5vy4ua9sIA0dAlSAq5UnZZ3X73mzyvWn
         N9SxXc1jbN8fXGlhd1fXlKjWznNGeSOM6qQC5DJdLnvH6q2sLoCbWQiijiOyhxVKOLsp
         JGAg==
X-Gm-Message-State: AOAM530sl+HMHQV4CSffdS0LpMSjPifqyRjtid/zpC3fw3Yxq/rmjDE4
        jiZ9imQdgHZknCwpxLM2/iWnhQ==
X-Google-Smtp-Source: ABdhPJyCmkC6yXT7iH56sV9igVSdTQzBpbc2WSWDXUzbgSce6jWtBo/9Lb94mV+YrBmaqSevSn73Mg==
X-Received: by 2002:a63:c450:: with SMTP id m16mr18326523pgg.333.1618950631599;
        Tue, 20 Apr 2021 13:30:31 -0700 (PDT)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id b5sm198960pgb.0.2021.04.20.13.30.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Apr 2021 13:30:31 -0700 (PDT)
Subject: Re: [PATCH 032/141] floppy: Fix fall-through warnings for Clang
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Denis Efremov <efremov@linux.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
References: <cover.1605896059.git.gustavoars@kernel.org>
 <ede7ffddba64f621150f8f5c5f2b8f080b560903.1605896059.git.gustavoars@kernel.org>
 <2599e39d-faec-01fc-e835-16a5c96082d6@embeddedor.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <47bcd36a-6524-348b-e802-0691d1b3c429@kernel.dk>
Date:   Tue, 20 Apr 2021 14:30:29 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <2599e39d-faec-01fc-e835-16a5c96082d6@embeddedor.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/20/21 2:25 PM, Gustavo A. R. Silva wrote:
> Hi all,
> 
> Friendly ping: who can take this, please?
> 
> Thanks
> --
> Gustavo
> 
> On 11/20/20 12:28, Gustavo A. R. Silva wrote:
>> In preparation to enable -Wimplicit-fallthrough for Clang, fix a warning
>> by explicitly adding a fallthrough pseudo-keyword in places where the
>> code is intended to fall through to the next case.
>>
>> Link: https://github.com/KSPP/linux/issues/115
>> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
>> ---
>>  drivers/block/floppy.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/block/floppy.c b/drivers/block/floppy.c
>> index 7df79ae6b0a1..21a2a7becba0 100644
>> --- a/drivers/block/floppy.c
>> +++ b/drivers/block/floppy.c
>> @@ -2124,6 +2124,7 @@ static void format_interrupt(void)
>>  	switch (interpret_errors()) {
>>  	case 1:
>>  		cont->error();
>> +		fallthrough;
>>  	case 2:
>>  		break;
>>  	case 0:

I wonder about the consistency of the patches. The one I just applied
for libata adds a break, this one annotates fallthrough. But the cases
are really 100% the same. Why aren't the changes consistent? Both are
obviously fine, but for identical cases it seems odd that they differ.

IMHO, adding a break makes more sense. Annotate the fallthrough if the
two cases share work that needs to be done, as then that solution makes
sense.

-- 
Jens Axboe

