Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E2DA39A6A4
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 19:05:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230048AbhFCRHY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 13:07:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:49301 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229695AbhFCRHX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 13:07:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622739938;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1JY+ThpNvUNc5MWyYcRhRJLduIKbgQwydX8JPKBcVMI=;
        b=BqtEPwmsqijeQbeOl3LK599k2uX8bct9MgHnlnhe10yJytc/dG9y7arSKJ8r41I9gIP+2m
        ABshHmErcW8bH6p1OMyR4KF9DIaLL4CYAiZUy2txWH21Woqpp+LLZXVMjwZ5TfFJq2gUBO
        bewrqdSwm4RyNtllAOq8yHTK+6bwD3E=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-227-hrebSk-sOKeHzTAL5ezCZA-1; Thu, 03 Jun 2021 13:05:36 -0400
X-MC-Unique: hrebSk-sOKeHzTAL5ezCZA-1
Received: by mail-ed1-f70.google.com with SMTP id h16-20020a0564020950b029038cbdae8cbaso3566103edz.6
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jun 2021 10:05:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1JY+ThpNvUNc5MWyYcRhRJLduIKbgQwydX8JPKBcVMI=;
        b=HoevHN07eQPxDDO4xXl+Dj25kY48gazmJbWIl8tankf+lAIbND+cbL2FP/2prLJUyZ
         /zKY0b4RgjmMShtzWjnuflzOYWb03sncVZE+Qjiw/PvAmlaQBMWc9VDyaqAU1UZqyMm6
         hX13h3zIWzDZmAitf5rV1u9JtHgudTaUeZChRy9r0aFpjazndzfQmQVfwyElLM01ltgZ
         4PKrijxPYIJ53vETK2YE4Q+Pt5fXFugorJH4MLCO9EORkD185/JHT/oSV6pILIWqh7zO
         W+85WHEpjG3k4C6KLY03dR0ukFE1oRRSzw6UDhP7rKkGHFzyGz3kyLHfOilg/ILza2pL
         CzgA==
X-Gm-Message-State: AOAM5306pEGMxgGSvg0Je0Qy12hXQZnK9C6m9rA+QL7VMuB7f3F4f2pY
        v0+gZjzIaqTzx+5l37uKD3K/E0Z+xqqve39VxzoA4xA6APq5Yvo06/eodMcwLdUU1NhzHmQHs8l
        fPPfh4gtHb7i5XVwH3MsMOj28
X-Received: by 2002:a17:906:80cd:: with SMTP id a13mr321832ejx.421.1622739934943;
        Thu, 03 Jun 2021 10:05:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyCR2G4+C+bsTminQfLne6RzEYtkn/gW2hcAaGeume0x5y2/DFQE8C/1iTa1I6EVYK7cs8HkQ==
X-Received: by 2002:a17:906:80cd:: with SMTP id a13mr321814ejx.421.1622739934783;
        Thu, 03 Jun 2021 10:05:34 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id gg22sm309562ejb.114.2021.06.03.10.05.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Jun 2021 10:05:34 -0700 (PDT)
Subject: Re: [PATCH 1/1] ishtp: Add support for Intel ishtp eclite driver
To:     "K Naduvalath, Sumesh" <sumesh.k.naduvalath@intel.com>,
        "mgross@linux.intel.com" <mgross@linux.intel.com>,
        "srinivas.pandruvada@linux.intel.com" 
        <srinivas.pandruvada@linux.intel.com>
Cc:     "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Chinnu, Ganapathi" <ganapathi.chinnu@intel.com>,
        "Kumar, Nachiketa" <nachiketa.kumar@intel.com>
References: <20210531120415.14480-1-sumesh.k.naduvalath@intel.com>
 <e28a9a7c-ec02-f71d-da6a-270f2dcbd58f@redhat.com>
 <BYAPR11MB37529B9B31E8188ABB29C683A93E9@BYAPR11MB3752.namprd11.prod.outlook.com>
 <1dbdb756-a87a-0ab6-4784-55e1edeb55d0@redhat.com>
 <BYAPR11MB3752E4A836546F1F07089249A93C9@BYAPR11MB3752.namprd11.prod.outlook.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <a447321d-79fc-6d2c-4a07-d4a24223c5a5@redhat.com>
Date:   Thu, 3 Jun 2021 19:05:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <BYAPR11MB3752E4A836546F1F07089249A93C9@BYAPR11MB3752.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 6/3/21 6:48 PM, K Naduvalath, Sumesh wrote:
> Thank you Hans for the scrutiny. Please find my comments inline.

<snip>

>>> ISH Firmware (the PSE subsystem) can boot up/reinitialize Every Sx
>>> based on usecase or sometimes PSE is always-on. So the resume path is
>>> asynchronous and unpredictable in this case. Re-initialization and
>>> clean up required if PSE also boot up every Sx and might take good
>>> amount of time (Host can come alive before PSE comes up). Thus using
>> asynchronous reset notification.
>>
>> Ok, so I guess we need to live with the ugly deregister + re-register OpRegion
>> dance for the devices where the PSE is shutdown during suspend.
>>
>> You also write: "sometimes PSE is always-on", what about that case, I assume
>> in this case there will be no reset after resume? So then unregistering the
>> OpRegion handler at suspend (and setting link_ready=false) will be wrong
>> since without the reset the OpRegion handler will never get reinstalled ?
> 
> reset is called from bus after every resume. When PSE is always-on, the notification
> comes quicky, where as there reset comes bit later in case of new boot.

Ok, in that case it makes sense to treat the PSE always-on scenario the same
as the scenario where it gets turned off during suspend.

Regards,

Hans

