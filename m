Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57131318998
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 12:38:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231217AbhBKLez (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 06:34:55 -0500
Received: from so15.mailgun.net ([198.61.254.15]:43804 "EHLO so15.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231487AbhBKLDL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 06:03:11 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1613041363; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=M1bx3DSE8yFgga28SG1R6GlnwCHzk2Sact1RQh75PdE=; b=XC/qUFDrd45mt1l58Orx64gcRhMcDEPWoWYGfjqP7FSHxiTqmhsNHvihge461M4NwkQK1+kB
 RSt6BAo//AxrdjPBP91ggxkHF1TDJXQMfNbF0Z0ejEd5oAi/EcL6+xZnBeUtugMdZIYrpM7V
 jBb2EKr9+P1DQR4/b9JikEjcPyM=
X-Mailgun-Sending-Ip: 198.61.254.15
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-west-2.postgun.com with SMTP id
 60250eba830f898bacac2eb6 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 11 Feb 2021 11:02:18
 GMT
Sender: mojha=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 1E8D1C433ED; Thu, 11 Feb 2021 11:02:18 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        NICE_REPLY_A,SPF_FAIL,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.0
Received: from [192.168.29.2] (unknown [49.37.87.15])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 955CBC433C6;
        Thu, 11 Feb 2021 11:02:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 955CBC433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=mojha@codeaurora.org
Subject: Re: [PATCH] pstore/ram : Add support for cached pages
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org, tony.luck@intel.com,
        ccross@android.com, anton@enomsg.org,
        Huang Yiwei <hyiwei@codeaurora.org>
References: <1612968741-1692-1-git-send-email-mojha@codeaurora.org>
 <202102101213.D603669D4@keescook>
From:   Mukesh Ojha <mojha@codeaurora.org>
Message-ID: <b371e01b-b5d2-1e49-6df4-1e1ad17ab6c1@codeaurora.org>
Date:   Thu, 11 Feb 2021 16:32:05 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <202102101213.D603669D4@keescook>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2/11/2021 1:47 AM, Kees Cook wrote:
> On Wed, Feb 10, 2021 at 08:22:21PM +0530, Mukesh Ojha wrote:
>> There could be a sceanario where we define some region
>> in normal memory and use them store to logs which is later
>> retrieved by bootloader during warm reset.
>>
>> In this scenario, we wanted to treat this memory as normal
>> cacheable memory instead of default behaviour which
>> is an overhead. Making it cacheable could improve
>> performance.
> Cool; yeah. I like this idea.

Thanks.

>
>> This commit gives control to change mem_type from Device
>> tree, and also documents the value for normal memory.
> What's the safest default setting?

We could keep it default, like it already exist to have unbuffered or 
not to have it in Device tree.

and could  use mem-type to cover normal memory(DDR)  as cached one and 
it will also cover buffered and unbufferd mapping

by mentioning it in device tree as numeric value.

>
>> Signed-off-by: Huang Yiwei <hyiwei@codeaurora.org>
>> Signed-off-by: Mukesh Ojha <mojha@codeaurora.org>
>> ---
>>   Documentation/admin-guide/ramoops.rst |  4 +++-
>>   fs/pstore/ram.c                       |  1 +
>>   fs/pstore/ram_core.c                  | 10 ++++++++--
>>   3 files changed, 12 insertions(+), 3 deletions(-)
>>
>> diff --git a/Documentation/admin-guide/ramoops.rst b/Documentation/admin-guide/ramoops.rst
>> index b0a1ae7..8f107d8 100644
>> --- a/Documentation/admin-guide/ramoops.rst
>> +++ b/Documentation/admin-guide/ramoops.rst
>> @@ -3,7 +3,7 @@ Ramoops oops/panic logger
>>   
>>   Sergiu Iordache <sergiu@chromium.org>
>>   
>> -Updated: 17 November 2011
>> +Updated: 10 Feb 2021
>>   
>>   Introduction
>>   ------------
>> @@ -30,6 +30,8 @@ mapping to pgprot_writecombine. Setting ``mem_type=1`` attempts to use
>>   depends on atomic operations. At least on ARM, pgprot_noncached causes the
>>   memory to be mapped strongly ordered, and atomic operations on strongly ordered
>>   memory are implementation defined, and won't work on many ARMs such as omaps.
>> +Setting ``mem_type=2`` attempts to treat the memory region as normal memory,
>> +which enables full cache on it. This can improve the performance.
>>   
>>   The memory area is divided into ``record_size`` chunks (also rounded down to
>>   power of two) and each kmesg dump writes a ``record_size`` chunk of
>> diff --git a/fs/pstore/ram.c b/fs/pstore/ram.c
>> index ca6d8a8..b262c57 100644
>> --- a/fs/pstore/ram.c
>> +++ b/fs/pstore/ram.c
>> @@ -666,6 +666,7 @@ static int ramoops_parse_dt(struct platform_device *pdev,
>>   		field = value;						\
>>   	}
>>   
>> +	parse_u32("mem-type", pdata->record_size, pdata->mem_type);
> This was handled by "unbuffered" above. Can you find a way to resolve
> potential conflicts between these?
Currently there is no conflict code-wise, even after this change, as it 
overrides if mem-type is there

otherwise everything is intact.

However, if we want to use only  mem-type property then i can remove 
unbuffered property.

not having unbuffered property i.e default=> mem-type = 0
having unbuffered property => mem-type = 1
mem-type = 2 for cached normal memory

>
>>   	parse_u32("record-size", pdata->record_size, 0);
>>   	parse_u32("console-size", pdata->console_size, 0);
>>   	parse_u32("ftrace-size", pdata->ftrace_size, 0);
>> diff --git a/fs/pstore/ram_core.c b/fs/pstore/ram_core.c
>> index aa8e0b6..83cd612 100644
>> --- a/fs/pstore/ram_core.c
>> +++ b/fs/pstore/ram_core.c
>> @@ -396,6 +396,10 @@ void persistent_ram_zap(struct persistent_ram_zone *prz)
>>   	persistent_ram_update_header_ecc(prz);
>>   }
>>   
>> +#define MEM_TYPE_WCOMBINE	0
>> +#define MEM_TYPE_NONCACHED	1
>> +#define MEM_TYPE_NORMAL		2
> It might be nice for this to have a human-readable name too, but let's
> start with numeric. :)
>
> Please update the mem_type MODULE_PARM_DESC to detail the new values too.

Ok, will do in next patch.

>
>> +
>>   static void *persistent_ram_vmap(phys_addr_t start, size_t size,
>>   		unsigned int memtype)
>>   {
>> @@ -409,9 +413,11 @@ static void *persistent_ram_vmap(phys_addr_t start, size_t size,
>>   	page_start = start - offset_in_page(start);
>>   	page_count = DIV_ROUND_UP(size + offset_in_page(start), PAGE_SIZE);
>>   
>> -	if (memtype)
>> +	if (memtype == MEM_TYPE_NORMAL)
>> +		prot = PAGE_KERNEL;
>> +	else if (memtype == MEM_TYPE_NONCACHED)
>>   		prot = pgprot_noncached(PAGE_KERNEL);
>> -	else
>> +	else if (memtype == MEM_TYPE_WCOMBINE)
>>   		prot = pgprot_writecombine(PAGE_KERNEL);
> Let's make this a switch statement.

Ok, will do in next patch.


Thanks

Mukesh

>
>>   
>>   	pages = kmalloc_array(page_count, sizeof(struct page *), GFP_KERNEL);
>> -- 
>> Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center,
>> Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project
>>
