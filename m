Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C57E45870A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Nov 2021 00:24:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230135AbhKUX1U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Nov 2021 18:27:20 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:7720 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229920AbhKUX1T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Nov 2021 18:27:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1637537053; x=1669073053;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=tlwdWbWglkxZo5YzvFa5+BGoWfDC7z1mUE2T+vWMsiI=;
  b=ZCYdHqIBQLoyu+KfryOdvVQsBTPaWB58rbghZGdU7cRKFe45YGAPXAQA
   pYcwrw3Yb9gg2gX9B8+JcIPpBM44rLBOGA9JRqYJ1Eh/xmvpqtsy6CmGh
   O3ls5nyMDT+qXA3N3TitgObjhiHHsWlusgSKNyH7EJRpQ77LsnSgN2AL/
   hkAKEZXgFomwbTkwTB+oA8qISX3d+vD7phDR0sNgZwNGOMfnVhZyKjg8G
   J3yf/haYZVOsWjKQ4hecDx7/UieIU8DgQ+4RcNaCWqV3qV1TvYCpP6l5X
   0VHnajgnPlFXfd43uwpdhGRpY8aV65VA1zVpsyU0LRKKY9bRiN8csLU+9
   Q==;
X-IronPort-AV: E=Sophos;i="5.87,253,1631548800"; 
   d="scan'208";a="185247300"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 22 Nov 2021 07:24:13 +0800
IronPort-SDR: NQYcxpNR5w/IhKkFWRqZvr3r5bYRbaP11/W2oHGDSXvPOj5eYnsmrhAJh4HFhFUO8NUfiCyMC6
 c1yizx4vXLWMJ5YgnPvF/wFP1ehV9ma3QR8BOMsGSWtIwkIMx3G3MwY8rDfazHLcstSLxgCOxM
 VBbZM0MORXgjVOHfsWz9lBVX4rTcmSZ2QlKEe+PZu2qjg8qRdVssFGpDR475f3X01ZYM2pmhGY
 5jDcNxAn4gxQqw2CYsPT9W+7Cnmfppq14zmPVqcTrutT+vNFvyjn4MnAzc6JbMUBJiOJu3OBIP
 tAb8dy+2LLpAw9+oRhji8ZHa
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2021 14:57:37 -0800
IronPort-SDR: kDzkV0RtnLeRDey3oa0L9EXhUYu5ZOpJWPwqBDYa8mSYk9nzubrU0Y8Yg0dLoFR9GyvcUj076j
 H+VoluwBH4WqEAIhfdyBTB40trvzCr4fVFoxvumeSpZmr8AUlyaAsOfOv40ivAPU1J4U0TSGMo
 WfEhwzo2dYBNBJnkrXaWd+njT7HJx4gHginvl+NhZ6X6qJ1QfmdcxQv1U3V/ZGe/zQ03auViRn
 tbqj1Y79KPYly06B/WlzChKUEpG2NAk7gX7PLA4dQsD6i7aSIjxyjQ7+492gkrk9QmGPaExaET
 v/Y=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2021 15:24:15 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Hy6183n2Qz1RtVv
        for <linux-kernel@vger.kernel.org>; Sun, 21 Nov 2021 15:24:12 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1637537051; x=1640129052; bh=tlwdWbWglkxZo5YzvFa5+BGoWfDC7z1mUE2
        T+vWMsiI=; b=DnSnRNGG6BynAEvTGN5AppgQL4iHbRy3x5PqjncUbtH7qSD0jgk
        HVFZKFrZgBe6+ZYOaCOZESO8Z/UQM05LgZmmHJvsZ99W/5kBsSsKZIl4gS2ij0mh
        2Cdjx+1vNbAf7zfZ4XcEVJUa6pmFPiTUW7BvEjVjWP7YIar88aMqaBu7DbAZBlYE
        HdXZzW3MhZ3DxeMzKgSGw09XGjWYD8pD87Y/vnYnhqp/1O1Ut24e5n2z155OTIYB
        4oyCtlMg6GrZqLxWOSKuSobKf72KH8d/d3tYJXHY2Lf+iYTxGP2BGVbemMTMYSrq
        E0n6LlCaeNruYFhr9ubGaH9hyIpn2wIpHOw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id qLqHCFN8HTai for <linux-kernel@vger.kernel.org>;
        Sun, 21 Nov 2021 15:24:11 -0800 (PST)
Received: from [10.225.54.48] (unknown [10.225.54.48])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Hy6163Xtcz1RtVl;
        Sun, 21 Nov 2021 15:24:10 -0800 (PST)
Message-ID: <f45d8750-4dfb-ec46-4ef9-a96169722ca4@opensource.wdc.com>
Date:   Mon, 22 Nov 2021 08:24:08 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.1
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
 <fcf2d384-ee03-298c-c1ac-5a39c0d85784@opensource.wdc.com>
 <361abc20-e01e-3c3a-3217-2e7ed6cb3f76@gmail.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital
In-Reply-To: <361abc20-e01e-3c3a-3217-2e7ed6cb3f76@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/11/20 18:51, Sergei Shtylyov wrote:
> On 20.11.2021 9:08, Damien Le Moal wrote:
>> On 11/20/21 00:43, Sergei Shtylyov wrote:
>>>> diff --git a/drivers/ata/sata_fsl.c b/drivers/ata/sata_fsl.c
>>>> index 30759fd1c3a2..011daac4a14e 100644
>>>> --- a/drivers/ata/sata_fsl.c
>>>> +++ b/drivers/ata/sata_fsl.c
>>>> @@ -1493,7 +1493,7 @@ static int sata_fsl_probe(struct platform_device *ofdev)
>>>>    	host_priv->ssr_base = ssr_base;
>>>>    	host_priv->csr_base = csr_base;
>>>>    
>>>> -	irq = irq_of_parse_and_map(ofdev->dev.of_node, 0);
>>>> +	irq = platform_get_irq(ofdev, 0);
>>>>    	if (!irq) {
>>>
>>> 	if (irq < 0) {
>>>
>>>      platform_get_irq() returns negative error codes, not 0 on failure.
>>
>> Sergei,
>>
>> By the way, the kdoc comment for platform_get_irq() says:
>>
>> "Return: non-zero IRQ number on success, negative error number on failure."
>>
>> But irq	0 is valid, isn't it ? So shouldn't this be changed to something
>> like:
>>
>> "Return: IRQ number on success, negative error number on failure."
> 
>     No, it's not valid (the current code WARN()s about it) and won't be 
> returned anymore after my patch [1] gets applied.
> 
> [1] https://marc.info/?l=linux-kernel&m=163623041902285

OK. Got it. Thanks.

> 
> MBR, Sergei
> 


-- 
Damien Le Moal
Western Digital Research
