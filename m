Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD83E32A31B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 16:01:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381864AbhCBIrE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 03:47:04 -0500
Received: from m42-2.mailgun.net ([69.72.42.2]:34100 "EHLO m42-2.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1377823AbhCBIba (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 03:31:30 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1614673837; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=uvgXH+3x+Hv9/MzbaBsOe98AgJTnGMWGyaJmFxeLpA4=; b=pXptBSag7z9+cB7YK//3qXBcp4u6b84E5KdiCkrknWR6M14Ec0FIS4ft41DXvBwfiMeu2DDz
 d5KF+lQF6uO+J9tcGs8LX/BoRguoAWRLQ0U0hrU46zwaTuWR4mnoAJWSEYvOk/JleBcYFulT
 9F6bczNs73sOOzM0Y7aTny0wYzc=
X-Mailgun-Sending-Ip: 69.72.42.2
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-west-2.postgun.com with SMTP id
 603df78d608e0b56531ced75 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 02 Mar 2021 08:30:05
 GMT
Sender: mojha=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 73077C43462; Tue,  2 Mar 2021 08:30:05 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        NICE_REPLY_A,SPF_FAIL,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.0
Received: from [192.168.29.2] (unknown [49.37.86.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 1CA88C433CA;
        Tue,  2 Mar 2021 08:29:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1CA88C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=mojha@codeaurora.org
Subject: Re: [RESEND PATCH v2 1/2] pstore: Add mem_type property DT parsing
 support
To:     linux-kernel@vger.kernel.org
Cc:     keescook@chromium.org, anton@enomsg.org, ccross@android.com,
        tony.luck@intel.com
References: <1614268817-7596-1-git-send-email-mojha@codeaurora.org>
From:   Mukesh Ojha <mojha@codeaurora.org>
Message-ID: <db8e0187-49a2-141d-3ac1-07e929f528c0@codeaurora.org>
Date:   Tue, 2 Mar 2021 13:59:49 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <1614268817-7596-1-git-send-email-mojha@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kees,

i have updated the patch based on your last comments.
please review.

Thanks,
Mukesh

On 2/25/2021 9:30 PM, Mukesh Ojha wrote:
> There could be a sceanario where we define some region
> in normal memory and use them store to logs which is later
> retrieved by bootloader during warm reset.
>
> In this scenario, we wanted to treat this memory as normal
> cacheable memory instead of default behaviour which
> is an overhead. Making it cacheable could improve
> performance.
>
> This commit gives control to change mem_type from Device
> tree, and also documents the value for normal memory.
>
> Signed-off-by: Mukesh Ojha <mojha@codeaurora.org>
> ---
> Changes in v2:
>   - if-else converted to switch case
>   - updated MODULE_PARM_DESC with new memory type.
>   - default setting is still intact.
>
>   Documentation/admin-guide/ramoops.rst |  4 +++-
>   fs/pstore/ram.c                       |  3 ++-
>   fs/pstore/ram_core.c                  | 18 ++++++++++++++++--
>   3 files changed, 21 insertions(+), 4 deletions(-)
>
> diff --git a/Documentation/admin-guide/ramoops.rst b/Documentation/admin-guide/ramoops.rst
> index b0a1ae7..8f107d8 100644
> --- a/Documentation/admin-guide/ramoops.rst
> +++ b/Documentation/admin-guide/ramoops.rst
> @@ -3,7 +3,7 @@ Ramoops oops/panic logger
>   
>   Sergiu Iordache <sergiu@chromium.org>
>   
> -Updated: 17 November 2011
> +Updated: 10 Feb 2021
>   
>   Introduction
>   ------------
> @@ -30,6 +30,8 @@ mapping to pgprot_writecombine. Setting ``mem_type=1`` attempts to use
>   depends on atomic operations. At least on ARM, pgprot_noncached causes the
>   memory to be mapped strongly ordered, and atomic operations on strongly ordered
>   memory are implementation defined, and won't work on many ARMs such as omaps.
> +Setting ``mem_type=2`` attempts to treat the memory region as normal memory,
> +which enables full cache on it. This can improve the performance.
>   
>   The memory area is divided into ``record_size`` chunks (also rounded down to
>   power of two) and each kmesg dump writes a ``record_size`` chunk of
> diff --git a/fs/pstore/ram.c b/fs/pstore/ram.c
> index ca6d8a8..af4ca6a4 100644
> --- a/fs/pstore/ram.c
> +++ b/fs/pstore/ram.c
> @@ -56,7 +56,7 @@ MODULE_PARM_DESC(mem_size,
>   static unsigned int mem_type;
>   module_param(mem_type, uint, 0400);
>   MODULE_PARM_DESC(mem_type,
> -		"set to 1 to try to use unbuffered memory (default 0)");
> +		"set to 1 to use unbuffered memory, 2 for cached memory (default 0)");
>   
>   static int ramoops_max_reason = -1;
>   module_param_named(max_reason, ramoops_max_reason, int, 0400);
> @@ -666,6 +666,7 @@ static int ramoops_parse_dt(struct platform_device *pdev,
>   		field = value;						\
>   	}
>   
> +	parse_u32("mem-type", pdata->record_size, pdata->mem_type);
>   	parse_u32("record-size", pdata->record_size, 0);
>   	parse_u32("console-size", pdata->console_size, 0);
>   	parse_u32("ftrace-size", pdata->ftrace_size, 0);
> diff --git a/fs/pstore/ram_core.c b/fs/pstore/ram_core.c
> index aa8e0b6..0da012f 100644
> --- a/fs/pstore/ram_core.c
> +++ b/fs/pstore/ram_core.c
> @@ -396,6 +396,10 @@ void persistent_ram_zap(struct persistent_ram_zone *prz)
>   	persistent_ram_update_header_ecc(prz);
>   }
>   
> +#define MEM_TYPE_WCOMBINE	0
> +#define MEM_TYPE_NONCACHED	1
> +#define MEM_TYPE_NORMAL		2
> +
>   static void *persistent_ram_vmap(phys_addr_t start, size_t size,
>   		unsigned int memtype)
>   {
> @@ -409,10 +413,20 @@ static void *persistent_ram_vmap(phys_addr_t start, size_t size,
>   	page_start = start - offset_in_page(start);
>   	page_count = DIV_ROUND_UP(size + offset_in_page(start), PAGE_SIZE);
>   
> -	if (memtype)
> +	switch (memtype) {
> +	case MEM_TYPE_NORMAL:
> +		prot = PAGE_KERNEL;
> +		break;
> +	case MEM_TYPE_NONCACHED:
>   		prot = pgprot_noncached(PAGE_KERNEL);
> -	else
> +		break;
> +	case MEM_TYPE_WCOMBINE:
>   		prot = pgprot_writecombine(PAGE_KERNEL);
> +		break;
> +	default:
> +		pr_err("invalid memory type\n");
> +		return NULL;
> +	}
>   
>   	pages = kmalloc_array(page_count, sizeof(struct page *), GFP_KERNEL);
>   	if (!pages) {
