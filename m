Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C7A13A039F
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 21:24:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236837AbhFHTTH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 15:19:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:49003 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235660AbhFHTHh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 15:07:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623179143;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7bda8qKrYBdrl6J95LCGp+lpIpDC0YoD+14XcFJ5Ns8=;
        b=H/L9lyBYfQ1QgRKi6/PsmkoZE9Ff14QUuuc7WK7Ve3/3cLrNincswGreZ36IdX4GcggKB2
        aS8ZEUz5QsGeavyoJbfJXufCtNhVC+OcT8dX+7SPZ5H7UYWNBIaWRkwUiIIbg0s+5ZLKeq
        TDDmfZFEt4WXw9WcR9DlCLyw/Q+jZJ4=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-104-beloZaphP1GhFd_TUY4GLw-1; Tue, 08 Jun 2021 15:05:42 -0400
X-MC-Unique: beloZaphP1GhFd_TUY4GLw-1
Received: by mail-ot1-f70.google.com with SMTP id c10-20020a9d75ca0000b02903f63362f6f3so1610162otl.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jun 2021 12:05:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=7bda8qKrYBdrl6J95LCGp+lpIpDC0YoD+14XcFJ5Ns8=;
        b=inzmdG345yXkM9VMiwhk0v3fy9aSH9fb4TnR9I1XO8okvaksYycjWWYhg+S0Rg5fqB
         GYBSDFJkp2ZDytnrkKA/vWjVJP/2VYs7NQ10CXHCZvwKKSp5FamzXdIZXqDgb7Cbllaf
         a5m7qSBucnEd2W6VSnFZIdMfOigVl5cvV6j+Y8vFkavDZ8OQ+AnTKc55zp3isFJWdmx4
         4+Horx8xiuOy1AqHd7XJABfjW19N8b8oHMcCT2Un1fPPzwv/xHbd/fR2kVi9WRIARCrS
         PZFyXQJbm34Ghj/60adjxNV9mfaY5cooWmNnSZNWNVx1Pfx8bSNntKmAS5Us8QWuEjgJ
         0EbA==
X-Gm-Message-State: AOAM533gFcSCxiRKhfLcW1yhTh6D1751xakKTtHX1uag0+/oRSY4g2lk
        +NY2nCYWJbxojtgPOpScyyGVXBo3PpleWlbWK9vA6K5itXoCbxddS6uu8HpHStYOlUHY5+3peZ/
        UIeFXepuzGqZ7UQjgpie4RTA3
X-Received: by 2002:a9d:19ed:: with SMTP id k100mr18893735otk.329.1623179141655;
        Tue, 08 Jun 2021 12:05:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz9uRSf/J+rCQi9NLexIXXQEVhh2pTd041kBvsvzmkI7RYzdysf4m+Mc/Rwzl3IYu+OtdO7xg==
X-Received: by 2002:a9d:19ed:: with SMTP id k100mr18893722otk.329.1623179141455;
        Tue, 08 Jun 2021 12:05:41 -0700 (PDT)
Received: from localhost.localdomain (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id e11sm3190450otk.78.2021.06.08.12.05.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Jun 2021 12:05:41 -0700 (PDT)
Subject: Re: [PATCH 1/7] fpga: wrap the write_init() op
To:     =?UTF-8?Q?Martin_Hundeb=c3=b8ll?= <mhu@silicom.dk>,
        Moritz Fischer <mdf@kernel.org>
Cc:     hao.wu@intel.com, michal.simek@xilinx.com,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20210607172402.2938697-1-trix@redhat.com>
 <20210607172402.2938697-2-trix@redhat.com> <YL6fUSD0KLP0l80g@epycbox.lan>
 <2faf6ccb-005b-063a-a2a3-e177082c4b3c@silicom.dk>
From:   Tom Rix <trix@redhat.com>
Message-ID: <6cda92dc-74f1-a6ad-e9f9-030a4095118e@redhat.com>
Date:   Tue, 8 Jun 2021 12:05:39 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <2faf6ccb-005b-063a-a2a3-e177082c4b3c@silicom.dk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 6/7/21 11:23 PM, Martin Hundebøll wrote:
>
>
> On 08/06/2021 00.36, Moritz Fischer wrote:
>> On Mon, Jun 07, 2021 at 10:23:56AM -0700, trix@redhat.com wrote:
>>> From: Tom Rix <trix@redhat.com>
>>>
>>> The board should not be required to provide a
>> Nit: Can you turn these into for whole series:
>> A FPGA Manager should not be ...
>
> Nit nit: should be:
> An FPGA Manager should not be ...
>
> // Martin

ok.

I went down a rabbit hole on this one, looks fine.

Tom

>
>>
>>> write_init() op if there is nothing for it do.
>>> So add a wrapper and move the op checking.
>>> Default to success.
>>>
>>> Signed-off-by: Tom Rix <trix@redhat.com>
>>> ---
>>>   drivers/fpga/fpga-mgr.c | 14 +++++++++++---
>>>   1 file changed, 11 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/fpga/fpga-mgr.c b/drivers/fpga/fpga-mgr.c
>>> index b85bc47c91a9..24547e36a56d 100644
>>> --- a/drivers/fpga/fpga-mgr.c
>>> +++ b/drivers/fpga/fpga-mgr.c
>>> @@ -69,6 +69,14 @@ void fpga_image_info_free(struct fpga_image_info 
>>> *info)
>>>   }
>>>   EXPORT_SYMBOL_GPL(fpga_image_info_free);
>>>   +static int fpga_mgr_write_init(struct fpga_manager *mgr,
>>> +                   struct fpga_image_info *info,
>>> +                   const char *buf, size_t count)
>>> +{
>>> +    if (mgr->mops && mgr->mops->write_init)
>>> +        return  mgr->mops->write_init(mgr, info, buf, count);
>>> +    return 0;
>>> +}
>>>   /*
>>>    * Call the low level driver's write_init function.  This will do the
>>>    * device-specific things to get the FPGA into the state where it 
>>> is ready to
>>> @@ -83,9 +91,9 @@ static int fpga_mgr_write_init_buf(struct 
>>> fpga_manager *mgr,
>>>         mgr->state = FPGA_MGR_STATE_WRITE_INIT;
>>>       if (!mgr->mops->initial_header_size)
>>> -        ret = mgr->mops->write_init(mgr, info, NULL, 0);
>>> +        ret = fpga_mgr_write_init(mgr, info, NULL, 0);
>>>       else
>>> -        ret = mgr->mops->write_init(
>>> +        ret = fpga_mgr_write_init(
>>>               mgr, info, buf, min(mgr->mops->initial_header_size, 
>>> count));
>>>         if (ret) {
>>> @@ -569,7 +577,7 @@ struct fpga_manager *fpga_mgr_create(struct 
>>> device *dev, const char *name,
>>>       int id, ret;
>>>         if (!mops || !mops->write_complete || !mops->state ||
>>> -        !mops->write_init || (!mops->write && !mops->write_sg) ||
>>> +        (!mops->write && !mops->write_sg) ||
>>>           (mops->write && mops->write_sg)) {
>>>           dev_err(dev, "Attempt to register without 
>>> fpga_manager_ops\n");
>>>           return NULL;
>>> -- 
>>> 2.26.3
>>>
>>
>> Can you change the subjects to "fpga: fpga-mgr: ..."
>>
>> Otherwise series looks good.
>>
>> - Moritz
>>
>

