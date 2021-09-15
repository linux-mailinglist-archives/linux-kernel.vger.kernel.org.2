Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B8CD40C650
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 15:23:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233505AbhIONYp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 09:24:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:41744 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233395AbhIONYk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 09:24:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631712201;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wszoxTyyMfRTOrq+xGh8kGEYKYqFrhFlKpPnWQlC9Og=;
        b=aMN0q9ArCAE6VOwbOuvVeErkTVeS5atzGdNDZY6t0vgBDt3nm4YcTD43vDyJQ8I+lrQXj5
        A288nA3lS4g24OBqGUuPd0P8Dkk8FEDcJcbp/mcHPs1WD3RBviz1t5qNxZaX/oQ711pktI
        /gV+KIIq1xOfibyX/AuCX/xdWM1+rdQ=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-443-Y7PeIMfEM3avNnciPokq9w-1; Wed, 15 Sep 2021 09:23:19 -0400
X-MC-Unique: Y7PeIMfEM3avNnciPokq9w-1
Received: by mail-qv1-f70.google.com with SMTP id h18-20020ad446f2000000b0037a7b48ba05so3184595qvw.19
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 06:23:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=wszoxTyyMfRTOrq+xGh8kGEYKYqFrhFlKpPnWQlC9Og=;
        b=1+jQrnFZymTRW58XxcUb8UmyLgmSSTqDfRCxZ8EonhXvSZy5DA8nAjUaSBrRm/qDei
         G7+sVoFN2/i18TGCLrTs4NsVweN4+9RWaPqT614zALDUUY6xIM067Jdz0dm+auclj52j
         Tqnk3tFvCZJq2okVyr/UXsTFySlDRPoYm2L26Wy5WOH1+Tm3Ik0QmcMXqEG0IyodPSOo
         uuZ808XjqmJZTVO+5tYwlquUMV40Anr14ke+N+8BFzpM4SZELI1KT8oHuPt/nbUusdHU
         JHMtzwIzX9Y6vjaQIWnmsb5MJlh9kgVDiZBgqLZhK5HiNdW5fQWG2kfwvD6cRDISTYbw
         jvMg==
X-Gm-Message-State: AOAM531COeqHUvzalIbtgC4Wo49GVa5BW51jUWSRT5Gv8Y9/DH0664xm
        f0h7RQ1lGiMT3PTVLKyN3qqyXSpKWW6NHA7W6e/bVQEaZaXpD11NTmGSQc/cjdur5AzXowePtLh
        e4z8Eys7Gj262Rq9xf+DBhYKH
X-Received: by 2002:ac8:7050:: with SMTP id y16mr10170040qtm.44.1631712199469;
        Wed, 15 Sep 2021 06:23:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy+atr7c3KON6z+CkIt241p70ryUn7JbjMiIUwA7cKP39As/nDi87MB0wxvlPi6PWO5AQG+hg==
X-Received: by 2002:ac8:7050:: with SMTP id y16mr10170021qtm.44.1631712199266;
        Wed, 15 Sep 2021 06:23:19 -0700 (PDT)
Received: from localhost.localdomain (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id q192sm9800382qka.93.2021.09.15.06.23.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Sep 2021 06:23:19 -0700 (PDT)
Subject: Re: [PATCH] MAINTAINERS: Add Tom Rix as fpga maintainer
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     mdf@kernel.org, hao.wu@intel.com, linux-kernel@vger.kernel.org,
        linux-fpga@vger.kernel.org
References: <20210914182333.3903389-1-trix@redhat.com>
 <YUDw0gvgdijpytfU@kroah.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <25d1dac2-4f9f-b5f0-8ce8-b88442deac9d@redhat.com>
Date:   Wed, 15 Sep 2021 06:23:16 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YUDw0gvgdijpytfU@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 9/14/21 11:58 AM, Greg KH wrote:
> [note, you got the maintainer's email address wrong on your cc: line
>   I fixed it up...]
>
> On Tue, Sep 14, 2021 at 11:23:33AM -0700, trix@redhat.com wrote:
>> From: Tom Rix <trix@redhat.com>
>>
>> I am the maintainer of the fpga/ subsystem for both the kernel and
>> userspace for Red Hat.  I have been an active reviewer and contributor
>> on for public fpga/ subsystem for the last year.  I would like to
>> help out more.
>>
>> Since I am paid to do this work, change the status to Supported.
>>
>> Signed-off-by: Tom Rix <trix@redhat.com>
>> ---
>>   MAINTAINERS | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 04fa4edf100b83..0443d7ab826659 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -7353,9 +7353,9 @@ F:	include/uapi/linux/fpga-dfl.h
>>   
>>   FPGA MANAGER FRAMEWORK
>>   M:	Moritz Fischer <mdf@kernel.org>
>> -R:	Tom Rix <trix@redhat.com>
>> +M:	Tom Rix <trix@redhat.com>
>>   L:	linux-fpga@vger.kernel.org
>> -S:	Maintained
>> +S:	Supported
>>   W:	http://www.rocketboards.org
>>   Q:	http://patchwork.kernel.org/project/linux-fpga/list/
>>   T:	git git://git.kernel.org/pub/scm/linux/kernel/git/mdf/linux-fpga.git
>> -- 
>> 2.26.3
>>
> Traditionally existing maintainers are the ones that add new
> maintainers, it's not something that you just submit a patch for hoping
> it will be accepted.
>
> What has changed since the last time you asked to do this?

Because public and private requests have gone unanswered for so long, it 
is unclear if Moritz is still maintaining the subsystem.

The nearly year old xrt patchset has been pending for 6 weeks with minor 
changes to one patch out of 14 needing reviews.

The standard release patchset, which needs an opinion has on an api 
change, has been outstanding for 8 weeks.


If maintainership depends on an approving maintainter, what happens when 
the approving maintainer has left ?

Tom

>
> thanks,
>
> greg k-h
>

