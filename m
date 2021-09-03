Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14F944000EF
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 16:03:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242631AbhICOE2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 10:04:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:26013 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1347375AbhICOEY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 10:04:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630677803;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6tZE3LmZD6jqJSuh20CcZIArD1TpiWN9qz/c9VBYUjE=;
        b=EO+xthW0qlR/rBUUGhl54UsHIGBixi3g2NETrx3ww8YO3BfmCNULfKZUmIJpsZ8Y2Avu0F
        dVmHxNQ8e48xjzWh+Ngx6+e5nEe9HDbv2RZ35rh7ok32ZcD9mFny0vLTgLvg6x5JZZNVc4
        x5oFuVZYMp7ww4t8Fehc/fd0iUEfKII=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-548-5OFmsZWGMrSBNghiINo2Dw-1; Fri, 03 Sep 2021 10:03:22 -0400
X-MC-Unique: 5OFmsZWGMrSBNghiINo2Dw-1
Received: by mail-ed1-f72.google.com with SMTP id b15-20020a05640202cf00b003cd5efcd633so2819150edx.9
        for <linux-kernel@vger.kernel.org>; Fri, 03 Sep 2021 07:03:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6tZE3LmZD6jqJSuh20CcZIArD1TpiWN9qz/c9VBYUjE=;
        b=K70+IsERqbK4VZ7fTQanuPuLjm549NDzqYus4G7LbZJ4ujHeFXrbeLeov66SRdakY4
         RzItf/4xa5ike2jYYLzhjTJB7dUDb1YOsHUlkJ1414370KVi7llFpT543ZKIgRDQApNP
         VVbTMD6DeL40AIejjjpx9mzfp2LxgULpSrBJT72SAJQEcmqAmE3Iu0LpIdmJZou8nSrU
         4CLil5YA8jJl4cd9kmz4nLrmDEIt7zaPj+Xg180Y0Scdzoa+zukNZEqBZksyE2aYDNlK
         VU4PFOi5uj8slPnH4IL8vOTaY/6iLfGy4K+UG4gNAAEGFWTXsUFycJ5v5Gyr5BC4OUzO
         Du1w==
X-Gm-Message-State: AOAM5331lFs37YTz4cb9e9ON5zjqScgBxVOzEK1+/LiXey+MNcQByjAD
        sccCqqhDu1WSqg11XXH9mkX8J9s5dCrNfKJG8Ht1BJDxx7lU4fAspPu8jv1Q1PfM87RqhEpfvA6
        0Psr5WTh5O0+gApnW+t/1T35A6oJDRCA14iNKN2OkgdUIscNmOXsM6IxMKOAhESbvxLFtIjcknR
        c1
X-Received: by 2002:a50:c88d:: with SMTP id d13mr1095285edh.392.1630677801504;
        Fri, 03 Sep 2021 07:03:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxaCT7porsj2UGCGGzKrIMKLimH7h15q/Y8kNosd15RnIz+2gAay6cGCFAoOpdy7q73eWTSDA==
X-Received: by 2002:a50:c88d:: with SMTP id d13mr1095259edh.392.1630677801279;
        Fri, 03 Sep 2021 07:03:21 -0700 (PDT)
Received: from x1.localdomain ([2a0e:5700:4:11:334c:7e36:8d57:40cb])
        by smtp.gmail.com with ESMTPSA id bq4sm2832420ejb.43.2021.09.03.07.03.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Sep 2021 07:03:20 -0700 (PDT)
Subject: Re: [PATCH v6] libata: Add ATA_HORKAGE_NO_NCQ_ON_ATI for Samsung 860
 and 870 SSD.
To:     Jens Axboe <axboe@kernel.dk>, Kate Hsuan <hpa@redhat.com>,
        Damien Le Moal <damien.lemoal@wdc.com>
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210903094411.58749-1-hpa@redhat.com>
 <d3488035-d269-2a63-f958-746f371cf490@kernel.dk>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <f1f0b799-6676-ae06-6a71-05dfeeab8512@redhat.com>
Date:   Fri, 3 Sep 2021 16:03:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <d3488035-d269-2a63-f958-746f371cf490@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 9/3/21 2:35 PM, Jens Axboe wrote:
> On 9/3/21 3:44 AM, Kate Hsuan wrote:
>> Many users are reporting that the Samsung 860 and 870 SSD are having
>> various issues when combined with AMD/ATI (vendor ID 0x1002)  SATA
>> controllers and only completely disabling NCQ helps to avoid these
>> issues.
>>
>> Always disabling NCQ for Samsung 860/870 SSDs regardless of the host
>> SATA adapter vendor will cause I/O performance degradation with well
>> behaved adapters. To limit the performance impact to ATI adapters,
>> introduce the ATA_HORKAGE_NO_NCQ_ON_ATI flag to force disable NCQ
>> only for these adapters.
>>
>> Also, two libata.force parameters (noncqati and ncqati) are introduced
>> to disable and enable the NCQ for the system which equipped with ATI
>> SATA adapter and Samsung 860 and 870 SSDs. The user can determine NCQ
>> function to be enabled or disabled according to the demand.
>>
>> After verifying the chipset from the user reports, the issue appears
>> on AMD/ATI SB7x0/SB8x0/SB9x0 SATA Controllers and does not appear on
>> recent AMD SATA adapters. The vendor ID of ATI should be 0x1002.
>> Therefore, ATA_HORKAGE_NO_NCQ_ON_AMD was modified to
>> ATA_HORKAGE_NO_NCQ_ON_ATI.
> 
> What's this patch against?

linux-block/for-next + my pre-cursor patch from here:

https://lore.kernel.org/linux-ide/20210823095220.30157-1-hdegoede@redhat.com/T/#u

Regards,

Hans

