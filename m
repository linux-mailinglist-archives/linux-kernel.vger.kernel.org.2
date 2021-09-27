Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E521419C6E
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 19:27:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238183AbhI0R2c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 13:28:32 -0400
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:50182 "EHLO
        alexa-out-sd-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236948AbhI0RYb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 13:24:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1632763373; x=1664299373;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=f2ZLlKxl3PUVq5tABjTZdLABXQd06AW4cCIiqAe8J7k=;
  b=obg1LG6XkRFZh2Z1ae0HA3BlBIjuQ3D1UwV43hDW/syFGu5AOGjeLdHJ
   j7gP0hlTNLdQpzPOF0V5jfLtuz7SuwY5DH+9/ary8GX5WphcwPEHiYLZG
   ym1vuedNKfeU72Wg+SjritxnzFPpM40MxnKgg/nFmn+aX5FroMPtPqyyt
   k=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 27 Sep 2021 10:22:52 -0700
X-QCInternal: smtphost
Received: from unknown (HELO nasanex01a.na.qualcomm.com) ([10.52.223.231])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2021 10:22:52 -0700
Received: from [10.251.44.228] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.7; Mon, 27 Sep 2021
 10:22:49 -0700
Message-ID: <4f4f6e93-ddc2-c9bb-ef47-4a40f2c3d0d7@quicinc.com>
Date:   Mon, 27 Sep 2021 20:22:46 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
Subject: Re: [RFC] arm64: mm: update max_pfn after memory hotplug
Content-Language: en-US
To:     Chris Goldsworthy <quic_cgoldswo@quicinc.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     David Hildenbrand <david@redhat.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        Sudarshan Rajagopalan <quic_sudaraja@quicinc.com>
References: <cover.1632437225.git.quic_cgoldswo@quicinc.com>
 <595d09279824faf1f54961cef52b745609b05d97.1632437225.git.quic_cgoldswo@quicinc.com>
From:   Georgi Djakov <quic_c_gdjako@quicinc.com>
In-Reply-To: <595d09279824faf1f54961cef52b745609b05d97.1632437225.git.quic_cgoldswo@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/24/2021 1:54 AM, Chris Goldsworthy wrote:
> From: Sudarshan Rajagopalan <quic_sudaraja@quicinc.com>
> 
> After new memory blocks have been hotplugged, max_pfn and max_low_pfn
> needs updating to reflect on new PFNs being hot added to system.
> 
> Signed-off-by: Sudarshan Rajagopalan <quic_sudaraja@quicinc.com>
> Signed-off-by: Chris Goldsworthy <quic_cgoldswo@quicinc.com>

Thanks for the patch, Chris!

With this patch, the data in /proc/kpageflags appears to be correct and
memory tools like procrank work again on arm64 platforms.

Tested-by: Georgi Djakov <quic_c_gdjako@quicinc.com>

Maybe we should add fixes tag, as it has been broken since the following
commit:
Fixes: abec749facff ("fs/proc/page.c: allow inspection of last section 
and fix end detection")

Thanks,
Georgi

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
