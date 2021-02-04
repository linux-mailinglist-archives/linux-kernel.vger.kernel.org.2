Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93F0630F4EA
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 15:28:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236708AbhBDO1j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 09:27:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:33009 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236679AbhBDO0M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 09:26:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612448685;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XpXFDxYEEygOiSW0EwEnIt2QyvX50R8LwyF4+V7RRmU=;
        b=GBU8J6wJ1yh68epHGlcF91DT43IFU1KuElFbjH8Nt3RXgT28xIHRGGXqzTx2FxTwsV1UPm
        6sJ6hZqA5eBoXowQSApV/wbtk9ERGnje+P8QJ6rEEk1CJluT72k+HSkCGcVMyMRIgAOZ6q
        yXMy2yIRWDzKy5x483NrxBOiT5T7yZc=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-220-XehxD632MHeTGtPEd7q89g-1; Thu, 04 Feb 2021 09:24:43 -0500
X-MC-Unique: XehxD632MHeTGtPEd7q89g-1
Received: by mail-qt1-f199.google.com with SMTP id p20so2641353qtn.23
        for <linux-kernel@vger.kernel.org>; Thu, 04 Feb 2021 06:24:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=XpXFDxYEEygOiSW0EwEnIt2QyvX50R8LwyF4+V7RRmU=;
        b=AAviv1/7XQMP6WqXFOj2TJlqm0y+6cxMFIWztM/0o0ttn7A7OyLusU6nDwVx8RUoj1
         tPpiEQnfz4qTpgE+GmShs9D18riifXJHXrJpaH0Y5/iugpfsbOIrP2/dmu2BJMNwhz/u
         ewdcGt9Jo+OEn25jBbKilCcAYthSHVlj2pnKZGb55hRnkHcM+aNPMuc0on1X2slHmsTe
         1MTwodiBcqLg2AlKI6PYcw19jYi0PU0IpSf8QW6tV+UhMDVv3u2JwRkXKcDvPT0Hl65Y
         nz7+W11I8Qok1If621ntoSOgzGumFmqN9ffmMAHc0uCb1IBssF7cfNzPxPMrKshOiSpX
         T2DA==
X-Gm-Message-State: AOAM532n+bXrq6Hw0aPUcBqBEXuO92PsgBcQBBAUrgY5VaBryuYU08fR
        uktMymSymBwJ1PPZKWzRR4cFAsLHBZxK8UtWpaMhHxoQ/9DQ1N4sCzUR0iWWPebHMMGrEMx8MDj
        rUj974oej1UwHM7t//T7uWF9R
X-Received: by 2002:a37:60e:: with SMTP id 14mr7606616qkg.60.1612448682906;
        Thu, 04 Feb 2021 06:24:42 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzlFRShimnFw8uB0YGrJn4zH7BpK44y33+Whl8wip1+QMHHK9wY+W9WC+2xok1oF9sj/wA8PA==
X-Received: by 2002:a37:60e:: with SMTP id 14mr7606600qkg.60.1612448682692;
        Thu, 04 Feb 2021 06:24:42 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id u7sm4350137qta.75.2021.02.04.06.24.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Feb 2021 06:24:42 -0800 (PST)
Subject: Re: [PATCH v3 1/1] fpga: dfl: afu: harden port enable logic
To:     Russ Weight <russell.h.weight@intel.com>, mdf@kernel.org,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     lgoncalv@redhat.com, yilun.xu@intel.com, hao.wu@intel.com,
        matthew.gerlach@intel.com
References: <20210202230631.198950-1-russell.h.weight@intel.com>
 <15f90871-170c-3487-0f99-47cf54163bb7@redhat.com>
 <9e53d35b-b1b5-5f21-f771-63ce689dd67e@intel.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <6751f883-36d1-dad8-7754-bd335fd767a5@redhat.com>
Date:   Thu, 4 Feb 2021 06:24:40 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <9e53d35b-b1b5-5f21-f771-63ce689dd67e@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2/3/21 3:06 PM, Russ Weight wrote:
>
> On 2/3/21 7:25 AM, Tom Rix wrote:
>> ..snip..
>>
>> On 2/2/21 3:06 PM, Russ Weight wrote:
>>> diff --git a/drivers/fpga/dfl-afu.h b/drivers/fpga/dfl-afu.h
>>> index 576e94960086..e5020e2b1f3d 100644
>>> --- a/drivers/fpga/dfl-afu.h
>>> +++ b/drivers/fpga/dfl-afu.h
>>> @@ -80,7 +80,7 @@ struct dfl_afu {
>>>  };
>>>  
>>>  /* hold pdata->lock when call __afu_port_enable/disable */
>>> -void __afu_port_enable(struct platform_device *pdev);
>>> +int __afu_port_enable(struct platform_device *pdev);
>>>  int __afu_port_disable(struct platform_device *pdev);
>>>  
>> Should the '__' prefix be removed from __afu_port* ?
>>
>> This would make the function names consistent with the other decls
> The '__' prefix is used here to help highlight the fact that these functions go not manage
> the locking themselves and must be called while holding the port mutex. There are additional
> functions, such as__port_reset(), that are following this same convention. I think these
> are OK as they are.

ok

Reviewed-by: Tom Rix <trix@redhat.com>

Tom

>
> - Russ
>
>> Tom
>>
>>>  void afu_mmio_region_init(struct dfl_feature_platform_data *pdata);

