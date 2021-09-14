Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8817C40ABCC
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 12:34:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231661AbhINKgI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 06:36:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:52339 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231623AbhINKgE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 06:36:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631615686;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=s8aet6o8BGc5Njdk9ZYsP9VXCChwP/HGbbswH50W044=;
        b=cMvpXngRnLaGu0Qzm8EXq63K5OPVBXnIKyBzAMMwvm2a2uGO2X2Se5366L+NWxV2LMVFgC
        lLU2rrKRQI7i0kmPanzICD/88lrQNaM1agMSNj/VYFZ0hPiedDaE+ajw8cEIh7cMVmw4Du
        Z4AVbpcTf3xIBvT04/bHqjJxBmzCSGM=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-208-k9F3EEWSOIi7SLxviEHvHw-1; Tue, 14 Sep 2021 06:34:45 -0400
X-MC-Unique: k9F3EEWSOIi7SLxviEHvHw-1
Received: by mail-ed1-f71.google.com with SMTP id v13-20020a056402174d00b003c25d6b2f13so6543740edx.4
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 03:34:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=s8aet6o8BGc5Njdk9ZYsP9VXCChwP/HGbbswH50W044=;
        b=sGCozZhNF+toYnaLfxRlCvQ8nlj1OcuHcrXeAwO7v1zT5Ln+30F4rHEm5Gpc/8w/1i
         detuUpRCE7eZREw7pr0SRHR7UPjQ3q7PvjLlzYXk4hQtc2m5SgltxPP1rx+gnOlkh1mc
         zhs314awhudnEu2eM8gejVbINaPifWlCWflDMwv991KycqTsNp+obSgkLQyA+LqLgc0x
         mgRW/qWZcXc23xz/s3ZtCKkCuY/lMNabBrzmDVgK9hT9L1ri2Sc749ddk5t171UCuq20
         t2gEyCdBaDPyl95mF6PZ8rWEXb5+DehiL/YPoIxmBmrkSxFbvGF/Avl4rVdpxTMc0z17
         MLdA==
X-Gm-Message-State: AOAM532v43EKhKjvaL6QFPwmxAX/Z9SMXYVT8i+PGnRQIXpjWmbChbY1
        HdN4WIn3mGA5IXKQlqYYedYzZjBYvKz3mPOfh32qu/XXQQNiFeEyK5MbAwIzbw1SgReiZOsJGOz
        vA72oI2atCHO7AsYE1PkgrmvJGSGANB4g1+CmazdXuASqr6cEAshK+um0Xkg1K2h4uKaMQT+QPe
        EZ
X-Received: by 2002:a05:6402:b51:: with SMTP id bx17mr4559335edb.193.1631615684339;
        Tue, 14 Sep 2021 03:34:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwShEPzdj/WbZTH3GBYxpASqFY/Qld8o+Byib4DkvR/k5kKv3Ve7zxfLB3jDEnRXA5ebcG6vw==
X-Received: by 2002:a05:6402:b51:: with SMTP id bx17mr4559313edb.193.1631615684108;
        Tue, 14 Sep 2021 03:34:44 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id r2sm5340399edv.78.2021.09.14.03.34.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Sep 2021 03:34:43 -0700 (PDT)
Subject: Re: [PATCH] platform/x86: amd-pmc: Increase the response register
 timeout
To:     Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>
Cc:     stable@kernel.org, Julian Sikorski <belegdol@gmail.com>,
        Mark Gross <mgross@linux.intel.com>,
        "open list:AMD PMC DRIVER" <platform-driver-x86@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20210914020115.655-1-mario.limonciello@amd.com>
 <666c9ae0-68d5-6008-6fc8-05d097fe3023@amd.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <c971b83a-8fdd-6201-89b5-088951b08680@redhat.com>
Date:   Tue, 14 Sep 2021 12:34:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <666c9ae0-68d5-6008-6fc8-05d097fe3023@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 9/14/21 10:38 AM, Shyam Sundar S K wrote:
> 
> 
> On 9/14/2021 7:31 AM, Mario Limonciello wrote:
>> There have been reports of approximately a 0.9%-1.7% failure rate in SMU
>> communication timeouts with s0i3 entry on some OEM designs.  Currently
>> the design in amd-pmc is to try every 100us for up to 20ms.
>>
>> However the GPU driver which also communicates with the SMU using a
>> mailbox register which the driver polls every 1us for up to 2000ms.
>> In the GPU driver this was increased by commit 055162645a40 ("drm/amd/pm:
>> increase time out value when sending msg to SMU")
>>
>> Increase the maximum timeout used by amd-pmc to 2000ms to match this
>> behavior.  This has been shown to improve the stability for machines
>> that randomly have failures.
>>
>> Cc: stable@kernel.org
>> Reported-by: Julian Sikorski <belegdol@gmail.com>
>> BugLink: https://gitlab.freedesktop.org/drm/amd/-/issues/1629
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>> ---
>>  drivers/platform/x86/amd-pmc.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/platform/x86/amd-pmc.c b/drivers/platform/x86/amd-pmc.c
>> index 3481479a2942..d6a7c896ac86 100644
>> --- a/drivers/platform/x86/amd-pmc.c
>> +++ b/drivers/platform/x86/amd-pmc.c
>> @@ -71,7 +71,7 @@
>>  #define AMD_CPU_ID_YC			0x14B5
>>  
>>  #define PMC_MSG_DELAY_MIN_US		100
>> -#define RESPONSE_REGISTER_LOOP_MAX	200
>> +#define RESPONSE_REGISTER_LOOP_MAX	20000
>>  
>>  #define SOC_SUBSYSTEM_IP_MAX	12
>>  #define DELAY_MIN_US		2000
>>
> 
> Looks good to me.
> 
> Acked-by: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>

Thank you for your patch, I've applied this patch to my review-hans 
branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans

I've also added this to the fixes branch so that it will be included
when I send my next fixes for 5.15 pull-req to Linus.

Once I've run some tests on this branch the patches there will be
added to the platform-drivers-x86/for-next branch and eventually
will be included in the pdx86 pull-request to Linus for the next
merge-window.

Regards,

Hans

