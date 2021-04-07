Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7BAF356B1B
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 13:25:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242010AbhDGLZu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 07:25:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:45130 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234598AbhDGLZs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 07:25:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617794738;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6vTOve9t9MRfb5n6V3rOJN+vGohohWSYNISTo4uZoiA=;
        b=J0kmeXGdSS19LyF/m99BxzceMbsVo3Kek52rmU02vZQ87/37nz6wGWUaHkby5LfuvBdvq/
        WmTfI8+qr59vfDg4c7Co067YHdhy6nj5MvxULO096KFz8PgWRAw+gj2hKR3HdvhipJMie/
        BEZkQcb4w0Mgqr01oE//ddQcCVkCf/Y=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-596-Au7OnaX_Ox-xEWLsntXESQ-1; Wed, 07 Apr 2021 07:25:36 -0400
X-MC-Unique: Au7OnaX_Ox-xEWLsntXESQ-1
Received: by mail-ed1-f69.google.com with SMTP id g7so3020406edp.11
        for <linux-kernel@vger.kernel.org>; Wed, 07 Apr 2021 04:25:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6vTOve9t9MRfb5n6V3rOJN+vGohohWSYNISTo4uZoiA=;
        b=k+E6HTvGMbxMHOm8N+7kBDiEK8iAFJEBOOYpPKxlBbGIhmi5OaiTbyR3STxi6+v6c7
         O6UDBHIszNv30omL6fpIucCL20qHo8vbpgyt/b+CyiBKIcyfTeDO19YEgHB+k5cbrrZ8
         ZilK5r2KCzBo5WMbVOJN4QmllmQU8nIjdk9O3Hg1p54L5rxhNif5GMvs2Ti+trOSsdsQ
         kB740GewhWknms/pYyojdx1AaJbsbV+Ha9vO/96Lcu/CZ6zDxVXgNZ9+IbreIPjUGRFe
         3gMDhZCABVCNZSh+dpXBdsPxdy8l1DE5QfgqJm46PupYc9EbprhOIYa4O+LcWojq2M+/
         DIdA==
X-Gm-Message-State: AOAM533ioDAS1b9vQK763DytyGQ2wSaJ5Q2XaZoaxpvIpp0h2+SiXvph
        5OHYf3dP7jtX7uWqL5EfbdbyoU33I0qc6As+LGorzsc1Cu9XbhPEdJIFaAWqyO1ZRhhTSZVeY0a
        IOsqlwLpRYmiIouMS1pX+ZpO9
X-Received: by 2002:a05:6402:148d:: with SMTP id e13mr3770685edv.29.1617794735527;
        Wed, 07 Apr 2021 04:25:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw0kZjqz9PTJqFtWE3x1dV8jt1KkESynnl85mNB3EJ6D5KzQ3B0vRO/5Cla0AO3B3t4uiAqUQ==
X-Received: by 2002:a05:6402:148d:: with SMTP id e13mr3770672edv.29.1617794735409;
        Wed, 07 Apr 2021 04:25:35 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id la16sm2569695ejb.40.2021.04.07.04.25.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Apr 2021 04:25:35 -0700 (PDT)
Subject: Re: [PATCH] platform/surface: clean up a variable in
 surface_dtx_read()
To:     Maximilian Luz <luzmaximilian@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Mark Gross <mgross@linux.intel.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
References: <YF3TgCcpcCYl3a//@mwanda>
 <e614021b-62aa-c879-c324-fc1dc1eec73e@gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <f621186f-6c24-ff5c-237b-f0cc0fa092f8@redhat.com>
Date:   Wed, 7 Apr 2021 13:25:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <e614021b-62aa-c879-c324-fc1dc1eec73e@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 3/26/21 3:06 PM, Maximilian Luz wrote:
> On 3/26/21 1:28 PM, Dan Carpenter wrote:
>> The "&client->ddev->lock" and "&ddev->lock" are the same thing.  Let's
>> use "&ddev->lock" consistently.
>>
>> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> 
> Good catch, thanks!
> 
> Reviewed-by: Maximilian Luz <luzmaximilian@gmail.com>

Thank you for the review, I've merged this now:

Thank you for your patch, I've applied this patch to my review-hans 
branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans

Note it will show up in my review-hans branch once I've pushed my
local branch there, which might take a while.

Once I've run some tests on this branch the patches there will be
added to the platform-drivers-x86/for-next branch and eventually
will be included in the pdx86 pull-request to Linus for the next
merge-window.

Regards,

Hans



> 
>> ---
>>   drivers/platform/surface/surface_dtx.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/platform/surface/surface_dtx.c b/drivers/platform/surface/surface_dtx.c
>> index 1fedacf74050..63ce587e79e3 100644
>> --- a/drivers/platform/surface/surface_dtx.c
>> +++ b/drivers/platform/surface/surface_dtx.c
>> @@ -487,7 +487,7 @@ static ssize_t surface_dtx_read(struct file *file, char __user *buf, size_t coun
>>               if (status < 0)
>>                   return status;
>>   -            if (down_read_killable(&client->ddev->lock))
>> +            if (down_read_killable(&ddev->lock))
>>                   return -ERESTARTSYS;
>>                 /* Need to check that we're not shut down again. */
>>
> 

