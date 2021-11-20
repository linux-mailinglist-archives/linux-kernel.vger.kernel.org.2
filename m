Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D47DD457BF7
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Nov 2021 07:08:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235727AbhKTGLj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Nov 2021 01:11:39 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:14061 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232021AbhKTGL1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Nov 2021 01:11:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1637388506; x=1668924506;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=HEd3/uHrcFEOQzwerh2/2EB6Y+yQu9KO9X0qYOqqaew=;
  b=YWbQd3O17hxxWoa0MNB7Y4Rjx7P3KzVzyYjE3X8wlq4/M4uLFC71MMzz
   PLGg2qGAXhc9yhiiGtHIs97A8qlOBVhG8+dMIjmjYNEc8q3j1V2ERhLdJ
   RaiDPPwzGPQuCIk0BRqNUPcl5phaNOrBNI8+pCIW0Bz+2HpIWigOoNLlm
   L3TiwwLzzZDCtUCY4Qk7dheAw4qtfQJd8E8au0j9lCFnnMU2atDF7lcZ6
   u7PoV8ocbXtx0vhchZw+HjlGdtHhLhDbKmJmkgNpZnTneN0aTfSPMrPBi
   91RN29FuM6SYbQ6nVXarPmtKClECTRszMWvP7za7HAWBcSnKVcSwxOvjc
   g==;
X-IronPort-AV: E=Sophos;i="5.87,250,1631548800"; 
   d="scan'208";a="187173866"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 20 Nov 2021 14:08:12 +0800
IronPort-SDR: GLCK1V22oYfpCKuYgZS1jhPVLwSWCaZZin3qceJZZWAIjryq86ZgElP0j9XfjXli4og6BTNUbT
 +LSs+H5icDrbW0afcD2esP9KhizBQvmzbKeQRjEpuJ7A7rpPMCxJ1yULGqmvCRNEJXrdvQbZeZ
 16tZma9je4y3qhRGNqpDrvl89znTXecJ0/RpTtcvm05RxmcKrdOVdeTys9IuP76LiEXzG0R96f
 7XNxgVyyEnTHF23lIjQz1KWGg2HEjdZmTQ66aI0B87jsizklDEY2YKm5xy48La33/mYjvN1zbv
 QCUOUdx2azntLanrDRJu7xuY
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2021 21:41:36 -0800
IronPort-SDR: GbhjiPhD1fEhmyl9sVitHBmE7lQ5OO7AwTiYFgehbFuLIPpjiq8oPz9ByLzxh8l1TW4fWDoIwN
 EguN00fjAQBcrlSzy1wnhKWt8YFHi2DiDe6EYC3o185U0ZmE3KfiOnnBYtOAE5rZMIZYMiFIvL
 uU3U+RUTi7dmJx/C4v19FP59BDzyhencKcVwnACbOSzlyKPuIBgqnZcWwc3uhnjOozkkp0ICpT
 LxAeaEDSqGsFu3bBj7hOF4GP0/H5rkXu8SwFAdnYXNVAX8NMHYTHh3jJ8CoifzKrvn3y0gQImR
 STw=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2021 22:08:12 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Hx34B6kWRz1RtW0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Nov 2021 22:08:10 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1637388489; x=1639980490; bh=HEd3/uHrcFEOQzwerh2/2EB6Y+yQu9KO9X0
        qYOqqaew=; b=C4fCGAjKgSv+98wZhegtNQYFGIpXvA8qJvetsEKZbX9XhHlxtrG
        G/Y91GId3w/CJ3a9x5anyDLmpGzSk+hgDGfytpRhqhpMuWQHJ042Y/zKYJkfKeXF
        KqOxqE44ehwtH4k3gIufJU2BrFgTxSBsSjlbfv1L3guE6gsgmJ3n/4Qjd1Ca3oRC
        RtXmLFhSNARDQvzSZBwjwkqbOmc5dvjY+vn6fyZtCvHOf5TztAtrgbNFjvhxsvGl
        /SYmiZ/VvCCn3UvmCr5o1d/48jdsq7vHlRfNPuOUomgBQbHdS4OW25HKU8pghmE9
        Mq9zlh/jKhFMY9yLc34uDyVTxXfzqivr2Vg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id cAHcSz3bE6-c for <linux-kernel@vger.kernel.org>;
        Fri, 19 Nov 2021 22:08:09 -0800 (PST)
Received: from [10.225.163.105] (unknown [10.225.163.105])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Hx3476X3kz1RtVl;
        Fri, 19 Nov 2021 22:08:07 -0800 (PST)
Message-ID: <fcf2d384-ee03-298c-c1ac-5a39c0d85784@opensource.wdc.com>
Date:   Sat, 20 Nov 2021 15:08:06 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH -next 2/2] sata_fsl: fix warning in remove_proc_entry when
 rmmod sata_fsl
Content-Language: en-US
To:     Sergei Shtylyov <sergei.shtylyov@gmail.com>,
        Baokun Li <libaokun1@huawei.com>, axboe@kernel.dk,
        tj@kernel.org, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     yebin10@huawei.com, yukuai3@huawei.com,
        Hulk Robot <hulkci@huawei.com>
References: <20211119041128.2436889-1-libaokun1@huawei.com>
 <20211119041128.2436889-3-libaokun1@huawei.com>
 <283712c0-bab7-de13-fc27-6ae2e6f9532f@gmail.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <283712c0-bab7-de13-fc27-6ae2e6f9532f@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/20/21 00:43, Sergei Shtylyov wrote:
>> diff --git a/drivers/ata/sata_fsl.c b/drivers/ata/sata_fsl.c
>> index 30759fd1c3a2..011daac4a14e 100644
>> --- a/drivers/ata/sata_fsl.c
>> +++ b/drivers/ata/sata_fsl.c
>> @@ -1493,7 +1493,7 @@ static int sata_fsl_probe(struct platform_device *ofdev)
>>   	host_priv->ssr_base = ssr_base;
>>   	host_priv->csr_base = csr_base;
>>   
>> -	irq = irq_of_parse_and_map(ofdev->dev.of_node, 0);
>> +	irq = platform_get_irq(ofdev, 0);
>>   	if (!irq) {
> 
> 	if (irq < 0) {
> 
>     platform_get_irq() returns negative error codes, not 0 on failure.

Sergei,

By the way, the kdoc comment for platform_get_irq() says:

"Return: non-zero IRQ number on success, negative error number on failure."

But irq	0 is valid, isn't it ? So shouldn't this be changed to something
like:

"Return: IRQ number on success, negative error number on failure."

-- 
Damien Le Moal
Western Digital Research
