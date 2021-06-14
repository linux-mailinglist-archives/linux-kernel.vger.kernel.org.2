Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03B8E3A69DE
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 17:16:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233281AbhFNPSG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 11:18:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:54698 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233080AbhFNPSE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 11:18:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623683760;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tseWl+ar2j5bgA3GbFaHmCrYs1B8K7aJoZuY0R4FknU=;
        b=YS6PBhEG+GdcaDKD2xrXxo0RCRSTZbrxW0ZkgA7cBFZ8kB+xU5wSu9v3KpJ4TSzYMmXPe9
        dP68iFC41uEHRr88ZwOTTxgHWTSOrXi/7VFNSpPznJuSRFbLndpLAbbT1HQaL12G+44Slm
        eNkGuLg4F5+bjf4vCX0sATXJHswgj+s=
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-246-QHzBaR2MOD64zEAL-z7q8w-1; Mon, 14 Jun 2021 11:15:59 -0400
X-MC-Unique: QHzBaR2MOD64zEAL-z7q8w-1
Received: by mail-oo1-f71.google.com with SMTP id e10-20020a4ab14a0000b029020e1573bdb7so7136467ooo.9
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 08:15:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=tseWl+ar2j5bgA3GbFaHmCrYs1B8K7aJoZuY0R4FknU=;
        b=tomJ5k+NEeBK5o97hpeGXwSU8nqCCWqkXQN55Fxv//swnkGmb5aksnyqd/v9ppZ6E0
         IKdzK2nvLH+Cm0jbeXEIEht3rGGp4ciwFgV7SUsHp+0mVvAr5gJTSASUGX5S3ePcrVpL
         HJaFHjvlknjmBYGVdmMIhE4xC1ulngeanCNjnb7QLz8Iq7bh6D8txg1o4f7mDeuqg1As
         QMKc5zBT2iF5mzYtpEoODIv2bY+dj9U7fSEI4pQAQzd8nXZe5FX4d9s7ZDOs21oJVlk+
         jE7z8eh5QIVzexaUtyoh0yESsJPa5AZpfP0kTtzGxlW10crkwIcIvkp8Todejeul9rM5
         /iig==
X-Gm-Message-State: AOAM5303Ax7Tk1LAnHGBr9NSwcCW8HQnrQPI15QraaIlFhRG6aRPmNNz
        nkbRqZu/K8CI7YEgrEno/9D9wvukncNaqEejBHaVmPIGWubZpB/WBaaol8Ww06h4tHpuciRl7y9
        4EsDRmK5wc6vIJ4DfbSoM9QCm
X-Received: by 2002:a9d:4d12:: with SMTP id n18mr14245631otf.128.1623683758961;
        Mon, 14 Jun 2021 08:15:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwcaCZ7HY5QTYsEFbkVzcsOtHFA2QLCLpRc2qiT/TOz9XlKqbbHHsOe3awXHQkzSxP0bJe4eQ==
X-Received: by 2002:a9d:4d12:: with SMTP id n18mr14245619otf.128.1623683758789;
        Mon, 14 Jun 2021 08:15:58 -0700 (PDT)
Received: from localhost.localdomain (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id a24sm3365436otr.3.2021.06.14.08.15.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Jun 2021 08:15:58 -0700 (PDT)
Subject: Re: [PATCH v3 1/4] fpga: dfl: reorganize to subdir layout
To:     Luca Ceresoli <luca@lucaceresoli.net>, mdf@kernel.org,
        hao.wu@intel.com, michal.simek@xilinx.com,
        gregkh@linuxfoundation.org, krzysztof.kozlowski@canonical.com,
        dinguyen@kernel.org, nava.manne@xilinx.com, yilun.xu@intel.com,
        davidgow@google.com, fpacheco@redhat.com, richard.gong@intel.com
Cc:     linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20210611162129.3203483-1-trix@redhat.com>
 <20210611162129.3203483-3-trix@redhat.com>
 <3e83dee8-4746-b22b-c032-1d73364f9cb7@lucaceresoli.net>
From:   Tom Rix <trix@redhat.com>
Message-ID: <c8ff863b-e904-3e39-f397-31efb0762a95@redhat.com>
Date:   Mon, 14 Jun 2021 08:15:55 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <3e83dee8-4746-b22b-c032-1d73364f9cb7@lucaceresoli.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 6/14/21 2:28 AM, Luca Ceresoli wrote:
> Hi Tom,
>
> On 11/06/21 18:21, trix@redhat.com wrote:
>> From: Tom Rix <trix@redhat.com>
>>
>> Follow drivers/net/ethernet/ which has control configs
>> NET_VENDOR_BLA that map to drivers/net/ethernet/bla
>> Since fpgas do not have many vendors, drop the 'VENDOR' and use
>> FPGA_BLA.
>>
>> There are several new subdirs
>> altera/
>> dfl/
>> lattice/
>> xilinx/
>>
>> Each subdir has a Kconfig that has a new/reused
>>
>> if FPGA_BLA
>>    ... existing configs ...
>> endif FPGA_BLA
>>
>> Which is sourced into the main fpga/Kconfig
>>
>> Each subdir has a Makefile whose transversal is controlled in the
>> fpga/Makefile by
>>
>> obj-$(CONFIG_FPGA_BLA) += bla/
>>
>> This is the dfl/ subdir part.
>>
>> Create a dfl/ subdir
>> Move dfl-* files to it.
>> Add a Kconfig and Makefile
>>
>> Because FPGA_DFL is now used in dfl/Kconfig in a if/endif
>> block, all the other configs in dfl/Kconfig implicitly depend
>> on FPGA_DFL.  So the explicit dependence can be removed.  Also
>> since FPGA_DFL depends on HAS_IOMEM, it can be removed from the
>> other configs.
>>
>> Signed-off-by: Tom Rix <trix@redhat.com>
>> ---
>>   MAINTAINERS                                 |  2 +-
>>   drivers/fpga/Kconfig                        | 80 +-------------------
>>   drivers/fpga/Makefile                       | 18 +----
>>   drivers/fpga/dfl/Kconfig                    | 83 +++++++++++++++++++++
>>   drivers/fpga/dfl/Makefile                   | 16 ++++
>>   drivers/fpga/{ => dfl}/dfl-afu-dma-region.c |  0
>>   drivers/fpga/{ => dfl}/dfl-afu-error.c      |  0
>>   drivers/fpga/{ => dfl}/dfl-afu-main.c       |  0
>>   drivers/fpga/{ => dfl}/dfl-afu-region.c     |  0
>>   drivers/fpga/{ => dfl}/dfl-afu.h            |  0
>>   drivers/fpga/{ => dfl}/dfl-fme-br.c         |  0
>>   drivers/fpga/{ => dfl}/dfl-fme-error.c      |  0
>>   drivers/fpga/{ => dfl}/dfl-fme-main.c       |  0
>>   drivers/fpga/{ => dfl}/dfl-fme-mgr.c        |  0
>>   drivers/fpga/{ => dfl}/dfl-fme-perf.c       |  0
>>   drivers/fpga/{ => dfl}/dfl-fme-pr.c         |  0
>>   drivers/fpga/{ => dfl}/dfl-fme-pr.h         |  0
>>   drivers/fpga/{ => dfl}/dfl-fme-region.c     |  0
>>   drivers/fpga/{ => dfl}/dfl-fme.h            |  0
>>   drivers/fpga/{ => dfl}/dfl-n3000-nios.c     |  0
>>   drivers/fpga/{ => dfl}/dfl-pci.c            |  0
>>   drivers/fpga/{ => dfl}/dfl.c                |  0
>>   drivers/fpga/{ => dfl}/dfl.h                |  0
>>   23 files changed, 102 insertions(+), 97 deletions(-)
>>   create mode 100644 drivers/fpga/dfl/Kconfig
>>   create mode 100644 drivers/fpga/dfl/Makefile
>>   rename drivers/fpga/{ => dfl}/dfl-afu-dma-region.c (100%)
>>   rename drivers/fpga/{ => dfl}/dfl-afu-error.c (100%)
>>   rename drivers/fpga/{ => dfl}/dfl-afu-main.c (100%)
>>   rename drivers/fpga/{ => dfl}/dfl-afu-region.c (100%)
>>   rename drivers/fpga/{ => dfl}/dfl-afu.h (100%)
>>   rename drivers/fpga/{ => dfl}/dfl-fme-br.c (100%)
>>   rename drivers/fpga/{ => dfl}/dfl-fme-error.c (100%)
>>   rename drivers/fpga/{ => dfl}/dfl-fme-main.c (100%)
>>   rename drivers/fpga/{ => dfl}/dfl-fme-mgr.c (100%)
>>   rename drivers/fpga/{ => dfl}/dfl-fme-perf.c (100%)
>>   rename drivers/fpga/{ => dfl}/dfl-fme-pr.c (100%)
> You should update Documentation/fpga/dfl.rst too as it mentions
> "drivers/fpga/dfl-fme-pr.c". This update was in your initial patch 5 so
> it's lost now, but it really should be in this patch.
>
>>   rename drivers/fpga/{ => dfl}/dfl-fme-pr.h (100%)
>>   rename drivers/fpga/{ => dfl}/dfl-fme-region.c (100%)
>>   rename drivers/fpga/{ => dfl}/dfl-fme.h (100%)
>>   rename drivers/fpga/{ => dfl}/dfl-n3000-nios.c (100%)
>>   rename drivers/fpga/{ => dfl}/dfl-pci.c (100%)
>>   rename drivers/fpga/{ => dfl}/dfl.c (100%)
> Same as above.

Yes to both, will be fixed in v4

Tom


>

