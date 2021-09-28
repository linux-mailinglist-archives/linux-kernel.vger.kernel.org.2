Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A8C141B7A5
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 21:34:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242498AbhI1TgZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 15:36:25 -0400
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:29453 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242415AbhI1TgY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 15:36:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1632857684; x=1664393684;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=I3lA1xehKn8cMjMnSUrKM01iaV9gThDho652gL/f/XI=;
  b=thvAjuWgN2cL3dAZgbMB2iJsSY+jk9PqY/pEGgfy74rhvxVJHxZ7EtE1
   aE+sLQOpj/pbE8a12ZGG7h5n/wC1iOB935SAtIpEZtgQn9bJ5cOhyXuKF
   T2onSFVIJDQXXty4NXRNVTEFesaqdfVpSVfJUvovmexpysWSdNAD2Mo3M
   w=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 28 Sep 2021 12:34:44 -0700
X-QCInternal: smtphost
Received: from unknown (HELO nasanex01a.na.qualcomm.com) ([10.52.223.231])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2021 12:34:44 -0700
Received: from [10.251.44.228] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.7; Tue, 28 Sep 2021
 12:34:41 -0700
Message-ID: <61e2f232-4abe-bb10-fff5-cabe8da5a7a9@quicinc.com>
Date:   Tue, 28 Sep 2021 22:34:39 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
Subject: Re: [PATCH] arm64: mm: update max_pfn after memory hotplug
Content-Language: en-US
To:     Chris Goldsworthy <quic_cgoldswo@quicinc.com>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     David Hildenbrand <david@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        "Sudarshan Rajagopalan" <quic_sudaraja@quicinc.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        Florian Fainelli <f.fainelli@gmail.com>
References: <cover.1632853776.git.quic_cgoldswo@quicinc.com>
 <a51a27ee7be66024b5ce626310d673f24107bcb8.1632853776.git.quic_cgoldswo@quicinc.com>
From:   Georgi Djakov <quic_c_gdjako@quicinc.com>
In-Reply-To: <a51a27ee7be66024b5ce626310d673f24107bcb8.1632853776.git.quic_cgoldswo@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/28/2021 9:51 PM, Chris Goldsworthy wrote:
> From: Sudarshan Rajagopalan <quic_sudaraja@quicinc.com>
> 
> After new memory blocks have been hotplugged, max_pfn and max_low_pfn
> needs updating to reflect on new PFNs being hot added to system.
> Without this patch, debug-related functions that use max_pfn such as
> get_max_dump_pfn() or read_page_owner() will not work with any page in
> memory that is hot-added after boot.
> 
> Fixes: 4ab215061554 ("arm64: Add memory hotplug support")
> Signed-off-by: Sudarshan Rajagopalan <quic_sudaraja@quicinc.com>
> Signed-off-by: Chris Goldsworthy <quic_cgoldswo@quicinc.com>
> Acked-by: David Hildenbrand <david@redhat.com>

Tested-by: Georgi Djakov <quic_c_gdjako@quicinc.com>

> Cc: Florian Fainelli <f.fainelli@gmail.com>
> Cc: Georgi Djakov <quic_c_gdjako@quicinc.com>
> ---
>   arch/arm64/mm/mmu.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index cfd9deb..fd85b51 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -1499,6 +1499,11 @@ int arch_add_memory(int nid, u64 start, u64 size,
>   	if (ret)
>   		__remove_pgd_mapping(swapper_pg_dir,
>   				     __phys_to_virt(start), size);
> +	else {
> +		max_pfn = PFN_UP(start + size);
> +		max_low_pfn = max_pfn;
> +	}
> +
>   	return ret;
>   }
>   
> 
