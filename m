Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B8703B6601
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 17:44:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235682AbhF1PrI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 11:47:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:54420 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235998AbhF1Pqq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 11:46:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624895059;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Dh6piDAixbuaPg3aGqNgRb+P+i5BQmPMS0CpF1jfr/M=;
        b=gEs6nJ8TM03CHO3Kx8uaakAn73ImLRLgyW//oynKVwEwAQDrWPXI9NwjjmTy6HFduRQVhj
        UqMOmm1ptOzgGIbNl3p51xOdP3LImjV0SiygG7BPu/GtWgqWcqGdqhSGeDUd2WM0Q6+E7u
        45JfPkEMJIm9cz4IR+Nwp8pFkSnaFj8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-334-4RLdL1-5PvevxLGRMb76Dg-1; Mon, 28 Jun 2021 11:44:17 -0400
X-MC-Unique: 4RLdL1-5PvevxLGRMb76Dg-1
Received: by mail-wr1-f72.google.com with SMTP id y5-20020adfe6c50000b02901258bf1d760so866941wrm.14
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jun 2021 08:44:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-transfer-encoding:content-language;
        bh=Dh6piDAixbuaPg3aGqNgRb+P+i5BQmPMS0CpF1jfr/M=;
        b=Pk9EQL9VcCCCRMhYZEWpmQgN5ey/r2g0ZtsxJ3bHrc7eAf1WMylp6qz3J96adpj8L+
         nfkHn5rlhlzodS0ScjcGx1nf4KjxAVMrhpLD5dC3wcywlsVh067YmGH7axCZ6KRqj7iD
         jinBDY7xr44s1f+kBeznTUXSBoz5zK7Wnc6FaXlPAssOsBjc/Fp1T1jOB8LCUyZuT2mg
         3sNuuXGbjEes9IjgIhXW6iMHA2yMM0NuH/+JgEwCVnVVGIsl8wpXH4zFJGOlK9OB8Wbt
         pTx7+MsahE8E7ZNlnwuOwzXPQaLCgaXHGiCpqEbqQoA53F4upFBwxQWRIM/Uq3gPLPY4
         C8Dw==
X-Gm-Message-State: AOAM533aGFveqq3OwFbhzSwMxmFXCi2qSHKXs26ZJ2awjIsuePt7jN20
        PUCUudrRB3VRmKtgdX5IfFLw2U3tTvoAR4RLN1XzXLVp47Rdfe1umgYC0VaUMAUpBYqCadMytNO
        JqRIahYwnp5N0wjQNYNpDCpWt
X-Received: by 2002:a5d:460e:: with SMTP id t14mr28379278wrq.149.1624895055886;
        Mon, 28 Jun 2021 08:44:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwRqGQMOoyUuBAXQnq59MthlhjWiXolkwEtpSRKENqOkpiKJ4FiR6tbgITHZEm92EskKUk2zQ==
X-Received: by 2002:a5d:460e:: with SMTP id t14mr28379266wrq.149.1624895055727;
        Mon, 28 Jun 2021 08:44:15 -0700 (PDT)
Received: from ?IPv6:2a01:e0a:59e:9d80:527b:9dff:feef:3874? ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
        by smtp.gmail.com with ESMTPSA id b8sm3480529wmb.20.2021.06.28.08.44.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Jun 2021 08:44:15 -0700 (PDT)
Reply-To: eric.auger@redhat.com
Subject: Re: [PATCH] misc/pvpanic-pci: Allow automatic loading
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     eric.auger.pro@gmail.com, linux-kernel@vger.kernel.org,
        mihai.carabas@oracle.com, arnd@arndb.de, pizhenwei@bytedance.com,
        andriy.shevchenko@linux.intel.com, pbonzini@redhat.com,
        joe@perches.com
References: <20210628144422.895526-1-eric.auger@redhat.com>
 <YNnilZ/Kg4SpU+bw@kroah.com>
From:   Eric Auger <eric.auger@redhat.com>
Message-ID: <5e3f7609-4820-6a8b-306e-553f10ce0f8a@redhat.com>
Date:   Mon, 28 Jun 2021 17:44:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <YNnilZ/Kg4SpU+bw@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On 6/28/21 4:54 PM, Greg KH wrote:
> On Mon, Jun 28, 2021 at 04:44:22PM +0200, Eric Auger wrote:
>> The pvpanic-pci driver does not auto-load and requires manual
>> modprobe. Let's include a device database using the
>> MODULE_DEVICE_TABLE macro.
>>
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>> ---
>>  drivers/misc/pvpanic/pvpanic-pci.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/misc/pvpanic/pvpanic-pci.c b/drivers/misc/pvpanic/pvpanic-pci.c
>> index 9ecc4e8559d5d..30290d42d8aa8 100644
>> --- a/drivers/misc/pvpanic/pvpanic-pci.c
>> +++ b/drivers/misc/pvpanic/pvpanic-pci.c
>> @@ -122,4 +122,6 @@ static struct pci_driver pvpanic_pci_driver = {
>>  	},
>>  };
>>  
>> +MODULE_DEVICE_TABLE(pci, pvpanic_pci_id_tbl);
>> +
> Is this something that you need?  Or is it created by a tool?

the virtual machine monitor (QEMU) exposes the pvpanic-pci device to the
guest. On guest side the module exists but currently isn't loaded
automatically. So the driver fails to be probed and does not its job of
handling guest panic events. We need a SW actor that loads the module
and I thought this should be handled that way. If not, please could you
advise?

Thank you in advance

Eric 
>
> thanks,
>
> greg k-h
>

