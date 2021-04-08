Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42EA4357D18
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 09:13:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229747AbhDHHOB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 03:14:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbhDHHN6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 03:13:58 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1EC6C061760
        for <linux-kernel@vger.kernel.org>; Thu,  8 Apr 2021 00:13:47 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id j7so552984plx.2
        for <linux-kernel@vger.kernel.org>; Thu, 08 Apr 2021 00:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ozlabs-ru.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Di9qeLfkSvyI9kbwbLHgKP2R5sKo/hApUf6AAJm2qkA=;
        b=Fo3DGs1yt93QpkSBkcFZHQ0GR5wBaHnidsuJUVyqqKV1cYuqZ/nfZUSbH6ZXpb9XEh
         84hm2UglCLeYPdF7QO9Ayt8RmNWJp0AtQNQUu43lVzRG5XKAue1UjkqYT7C1IwCnjbnW
         ngvM2wvgLiWVrKsY7HSEIPsPCguWvYQ0BIDCdlN7GgOiLIiSaKiEmpntP/bNIWvsO/yW
         vFNY9LfhXTDKrajvBLFd/IDnT+/iMfJNmpVER6V41UFc49+0PL+6//Sf66GvwKi6JBQJ
         3X7TvmXhoVBfTmEaurY7+FgTZX6s1kaAOOq617KQT8AkShddT1ehxgwxRCAaU7NWwItQ
         rJLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Di9qeLfkSvyI9kbwbLHgKP2R5sKo/hApUf6AAJm2qkA=;
        b=r+edd9RC2An4sE0cqIahU1WAP4PpHMBtFeTbIvf1nCwsK/hZsUYZOR7GsEmv1w4jPp
         91fk0OuLrVTNRNUHwxmylB3wKAovsZCpiMo83wUm0muLFbWMCfAVzKHw3qg5Pg6e7pGh
         Y91FJli+JaBzzw4KjZzz13YWq9B4J0ESvN/dRK0Z/imZRpfQoBcM9g+vuaJPyAdT3nZx
         XFY7pATXxCsFLxwWyFXxpUMBMl9mBbduxwTDqg58srswmYF579dI2RTs0IC0GDStLz2d
         7XYhKFXuRQ/H95z1qPVtIQI/wPsXEfi0l0fuXFlVdD3ly8+j9vVYsYfBoE/O6p6ATFVd
         bcRA==
X-Gm-Message-State: AOAM531+Ofhw9JWY7DG2wUhDKsyQ+JnVD0I/eqVQf/M6gEOpqA7fAc84
        OLTt/pXrIQU88iGgYF034hCjEg==
X-Google-Smtp-Source: ABdhPJy8NzWYgv8GK7MU2cF9UU40GmP7aPtZ+HeYbyqzwzov6z1BOLdmvVquqT+wtFf4zTdF7cEEhw==
X-Received: by 2002:a17:902:edd5:b029:e9:7477:5f0a with SMTP id q21-20020a170902edd5b02900e974775f0amr4510662plk.81.1617866027014;
        Thu, 08 Apr 2021 00:13:47 -0700 (PDT)
Received: from localhost (ppp121-45-194-51.cbr-trn-nor-bras38.tpg.internode.on.net. [121.45.194.51])
        by smtp.gmail.com with UTF8SMTPSA id r23sm7540513pje.38.2021.04.08.00.13.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Apr 2021 00:13:46 -0700 (PDT)
Message-ID: <8e1ce7e9-415b-92ea-0437-a4331ed3c7f9@ozlabs.ru>
Date:   Thu, 8 Apr 2021 17:13:40 +1000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:88.0) Gecko/20100101
 Thunderbird/88.0
Subject: Re: [PATCH v2 1/1] powerpc/iommu: Enable remaining IOMMU Pagesizes
 present in LoPAR
Content-Language: en-US
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Leonardo Bras <leobras.c@gmail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, brking@linux.vnet.ibm.com
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20210407195613.131140-1-leobras.c@gmail.com>
 <87im4xe3pk.fsf@mpe.ellerman.id.au>
From:   Alexey Kardashevskiy <aik@ozlabs.ru>
In-Reply-To: <87im4xe3pk.fsf@mpe.ellerman.id.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 08/04/2021 15:37, Michael Ellerman wrote:
> Leonardo Bras <leobras.c@gmail.com> writes:
>> According to LoPAR, ibm,query-pe-dma-window output named "IO Page Sizes"
>> will let the OS know all possible pagesizes that can be used for creating a
>> new DDW.
>>
>> Currently Linux will only try using 3 of the 8 available options:
>> 4K, 64K and 16M. According to LoPAR, Hypervisor may also offer 32M, 64M,
>> 128M, 256M and 16G.
> 
> Do we know of any hardware & hypervisor combination that will actually
> give us bigger pages?


On P8 16MB host pages and 16MB hardware iommu pages worked.

On P9, VM's 16MB IOMMU pages worked on top of 2MB host pages + 2MB 
hardware IOMMU pages.


> 
>> Enabling bigger pages would be interesting for direct mapping systems
>> with a lot of RAM, while using less TCE entries.
>>
>> Signed-off-by: Leonardo Bras <leobras.c@gmail.com>
>> ---
>>   arch/powerpc/platforms/pseries/iommu.c | 49 ++++++++++++++++++++++----
>>   1 file changed, 42 insertions(+), 7 deletions(-)
>>
>> diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
>> index 9fc5217f0c8e..6cda1c92597d 100644
>> --- a/arch/powerpc/platforms/pseries/iommu.c
>> +++ b/arch/powerpc/platforms/pseries/iommu.c
>> @@ -53,6 +53,20 @@ enum {
>>   	DDW_EXT_QUERY_OUT_SIZE = 2
>>   };
> 
> A comment saying where the values come from would be good.
> 
>> +#define QUERY_DDW_PGSIZE_4K	0x01
>> +#define QUERY_DDW_PGSIZE_64K	0x02
>> +#define QUERY_DDW_PGSIZE_16M	0x04
>> +#define QUERY_DDW_PGSIZE_32M	0x08
>> +#define QUERY_DDW_PGSIZE_64M	0x10
>> +#define QUERY_DDW_PGSIZE_128M	0x20
>> +#define QUERY_DDW_PGSIZE_256M	0x40
>> +#define QUERY_DDW_PGSIZE_16G	0x80
> 
> I'm not sure the #defines really gain us much vs just putting the
> literal values in the array below?


Then someone says "uuuuu magic values" :) I do not mind either way. Thanks,



>> +struct iommu_ddw_pagesize {
>> +	u32 mask;
>> +	int shift;
>> +};
>> +
>>   static struct iommu_table_group *iommu_pseries_alloc_group(int node)
>>   {
>>   	struct iommu_table_group *table_group;
>> @@ -1099,6 +1113,31 @@ static void reset_dma_window(struct pci_dev *dev, struct device_node *par_dn)
>>   			 ret);
>>   }
>>   
>> +/* Returns page shift based on "IO Page Sizes" output at ibm,query-pe-dma-window. See LoPAR */
>> +static int iommu_get_page_shift(u32 query_page_size)
>> +{
>> +	const struct iommu_ddw_pagesize ddw_pagesize[] = {
>> +		{ QUERY_DDW_PGSIZE_16G,  __builtin_ctz(SZ_16G)  },
>> +		{ QUERY_DDW_PGSIZE_256M, __builtin_ctz(SZ_256M) },
>> +		{ QUERY_DDW_PGSIZE_128M, __builtin_ctz(SZ_128M) },
>> +		{ QUERY_DDW_PGSIZE_64M,  __builtin_ctz(SZ_64M)  },
>> +		{ QUERY_DDW_PGSIZE_32M,  __builtin_ctz(SZ_32M)  },
>> +		{ QUERY_DDW_PGSIZE_16M,  __builtin_ctz(SZ_16M)  },
>> +		{ QUERY_DDW_PGSIZE_64K,  __builtin_ctz(SZ_64K)  },
>> +		{ QUERY_DDW_PGSIZE_4K,   __builtin_ctz(SZ_4K)   }
>> +	};
> 
> 
> cheers
> 

-- 
Alexey
