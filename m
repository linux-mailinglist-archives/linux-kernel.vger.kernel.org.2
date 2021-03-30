Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C5D234E7A5
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 14:42:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231902AbhC3MmJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 08:42:09 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:32678 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232005AbhC3Mly (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 08:41:54 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1617108114; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=5x1HUFyxPmR7JWfnpc4ueYoOdcNA5TjKZcekHMTKQpU=; b=sFA2d/GFtP7rhfGQj/Wyx/7vuJ9MFU9gl+gPsnF9O90IaiqsU65e5iuOyIyNsIbexyHXq+b3
 TT32x1XNUNDgUk3YbGGqkMBfJ+rQtdiuNVmkm5jzMojV3Ygf9k6a93Xa1xxvXGXknS4AUnUt
 RRN/R94U8B16jCbY2B3sYa86f80=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-west-2.postgun.com with SMTP id
 60631c7fa2ab6642db48f29e (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 30 Mar 2021 12:41:35
 GMT
Sender: mojha=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 90B7CC433C6; Tue, 30 Mar 2021 12:41:35 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        NICE_REPLY_A,SPF_FAIL,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.0
Received: from [192.168.43.247] (unknown [47.29.126.59])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 6174EC43461;
        Tue, 30 Mar 2021 12:41:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6174EC43461
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=mojha@codeaurora.org
Subject: Re: [PATCH v3] pstore: Add mem_type property DT parsing support
To:     linux-kernel@vger.kernel.org
Cc:     keescook@chromium.org, anton@enomsg.org, ccross@android.com,
        tony.luck@intel.com
References: <1616438537-13719-1-git-send-email-mojha@codeaurora.org>
From:   Mukesh Ojha <mojha@codeaurora.org>
Message-ID: <4626f72d-8fdf-d6c4-424f-d072a25deaec@codeaurora.org>
Date:   Tue, 30 Mar 2021 18:10:58 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <1616438537-13719-1-git-send-email-mojha@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kees/All,

Could you please review again?  I have addressed your comment made on 
last patch version.

Thanks,
Mukesh

On 3/23/2021 12:12 AM, Mukesh Ojha wrote:
> There could be a scenario where we define some region
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
> Changes in v3:
>   - Minor code and documentation update done as per comment given by Kees.
>
> Changes in v2:
>   - if-else converted to switch case
>   - updated MODULE_PARM_DESC with new memory type.
>   - default setting is still intact.
>
>   Documentation/admin-guide/ramoops.rst                  |  4 +++-
>   .../devicetree/bindings/reserved-memory/ramoops.txt    | 10 ++++++++--
>   fs/pstore/ram.c                                        |  7 ++++++-
>   fs/pstore/ram_core.c                                   | 18 ++++++++++++++++--
>   4 files changed, 33 insertions(+), 6 deletions(-)
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
> diff --git a/Documentation/devicetree/bindings/reserved-memory/ramoops.txt b/Documentation/devicetree/bindings/reserved-memory/ramoops.txt
> index b7886fe..6f1cb20 100644
> --- a/Documentation/devicetree/bindings/reserved-memory/ramoops.txt
> +++ b/Documentation/devicetree/bindings/reserved-memory/ramoops.txt
> @@ -42,8 +42,14 @@ Optional properties:
>   - pmsg-size: size in bytes of log buffer reserved for userspace messages
>     (defaults to 0: disabled)
>   
> -- unbuffered: if present, use unbuffered mappings to map the reserved region
> -  (defaults to buffered mappings)
> +- mem-type: if present, sets the type of mapping is to be used to map the
> +  reserved region. mem-type: 0 = write-combined (default), 1 = unbuffered,
> +  2 = cached.
> +
> +- unbuffered: deprecated, use mem_type instead. if present, and mem_type is
> +  not specified, it is equivalent to mem_type = 1 and uses unbuffered mappings
> +  to map the reserved region (defaults to buffered mappings mem_type = 0). If
> +  both are specified -- "mem_type" overrides "unbuffered".
>   
>   - max-reason: if present, sets maximum type of kmsg dump reasons to store
>     (defaults to 2: log Oopses and Panics). This can be set to INT_MAX to
> diff --git a/fs/pstore/ram.c b/fs/pstore/ram.c
> index ca6d8a8..fefe3d3 100644
> --- a/fs/pstore/ram.c
> +++ b/fs/pstore/ram.c
> @@ -56,7 +56,7 @@ MODULE_PARM_DESC(mem_size,
>   static unsigned int mem_type;
>   module_param(mem_type, uint, 0400);
>   MODULE_PARM_DESC(mem_type,
> -		"set to 1 to try to use unbuffered memory (default 0)");
> +		"memory type: 0=write-combined (default), 1=unbuffered, 2=cached");
>   
>   static int ramoops_max_reason = -1;
>   module_param_named(max_reason, ramoops_max_reason, int, 0400);
> @@ -648,6 +648,10 @@ static int ramoops_parse_dt(struct platform_device *pdev,
>   
>   	pdata->mem_size = resource_size(res);
>   	pdata->mem_address = res->start;
> +	/*
> +	 * Setting "unbuffered" is deprecated and will be ignored if
> +	 * "mem_type" is also specified.
> +	 */
>   	pdata->mem_type = of_property_read_bool(of_node, "unbuffered");
>   	/*
>   	 * Setting "no-dump-oops" is deprecated and will be ignored if
> @@ -666,6 +670,7 @@ static int ramoops_parse_dt(struct platform_device *pdev,
>   		field = value;						\
>   	}
>   
> +	parse_u32("mem-type", pdata->record_size, pdata->mem_type);
>   	parse_u32("record-size", pdata->record_size, 0);
>   	parse_u32("console-size", pdata->console_size, 0);
>   	parse_u32("ftrace-size", pdata->ftrace_size, 0);
> diff --git a/fs/pstore/ram_core.c b/fs/pstore/ram_core.c
> index fff363b..fe53050 100644
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
> +		pr_err("invalid mem_type=%d\n", memtype);
> +		return NULL;
> +	}
>   
>   	pages = kmalloc_array(page_count, sizeof(struct page *), GFP_KERNEL);
>   	if (!pages) {
