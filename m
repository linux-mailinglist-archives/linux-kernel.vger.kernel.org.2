Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54E4441A3C8
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 01:23:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238120AbhI0XYo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 19:24:44 -0400
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:30586 "EHLO
        alexa-out-sd-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237972AbhI0XYn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 19:24:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1632784985; x=1664320985;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=S3JwOABhR/3dTwDn7YJ9Upq8D+qXiJRw20o/fQbTFn4=;
  b=kcV77VrtIROAcPytvAyK+dMORk6aK2f3u1SzMB/JgSILk0B1svSf6L1v
   kgbaVgZ/chGfVunOvjCecsCMMN+LAWGlWptDdktif7Dov261rQaoVpFLZ
   DVGUsRa56dMRlYQlH6ZWmcm+ggtcIeRlvIlur+pSLfYEZpYmF1QQuwKZQ
   w=;
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 27 Sep 2021 16:23:05 -0700
X-QCInternal: smtphost
Received: from unknown (HELO nasanex01a.na.qualcomm.com) ([10.52.223.231])
  by ironmsg03-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2021 16:23:04 -0700
Received: from [10.251.44.228] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.7; Mon, 27 Sep 2021
 16:23:02 -0700
Message-ID: <ed2f59dc-ecd3-ae9c-e44c-81e903c6f08f@quicinc.com>
Date:   Tue, 28 Sep 2021 02:22:59 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
Subject: Re: [RFC] arm64: mm: update max_pfn after memory hotplug
Content-Language: en-US
To:     David Hildenbrand <david@redhat.com>,
        Chris Goldsworthy <quic_cgoldswo@quicinc.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "Will Deacon" <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        Sudarshan Rajagopalan <quic_sudaraja@quicinc.com>
References: <cover.1632437225.git.quic_cgoldswo@quicinc.com>
 <595d09279824faf1f54961cef52b745609b05d97.1632437225.git.quic_cgoldswo@quicinc.com>
 <833493d2-d585-47ee-c258-79eae5deff36@redhat.com>
From:   Georgi Djakov <quic_c_gdjako@quicinc.com>
In-Reply-To: <833493d2-d585-47ee-c258-79eae5deff36@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/27/2021 6:51 PM, David Hildenbrand wrote:
> On 24.09.21 00:54, Chris Goldsworthy wrote:
>> From: Sudarshan Rajagopalan <quic_sudaraja@quicinc.com>
>>
>> After new memory blocks have been hotplugged, max_pfn and max_low_pfn
>> needs updating to reflect on new PFNs being hot added to system.
>>
>> Signed-off-by: Sudarshan Rajagopalan <quic_sudaraja@quicinc.com>
>> Signed-off-by: Chris Goldsworthy <quic_cgoldswo@quicinc.com>
>> ---
>>   arch/arm64/mm/mmu.c | 5 +++++
>>   1 file changed, 5 insertions(+)
>>
>> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
>> index cfd9deb..fd85b51 100644
>> --- a/arch/arm64/mm/mmu.c
>> +++ b/arch/arm64/mm/mmu.c
>> @@ -1499,6 +1499,11 @@ int arch_add_memory(int nid, u64 start, u64 size,
>>       if (ret)
>>           __remove_pgd_mapping(swapper_pg_dir,
>>                        __phys_to_virt(start), size);
>> +    else {
>> +        max_pfn = PFN_UP(start + size);
>> +        max_low_pfn = max_pfn;
>> +    }
>> +
>>       return ret;
> 
> Note: didn't verify if updating max_low_pfn is correct here.

My understanding is that max_low_pfn defines the low/high memory
boundary and it should be also updated.

Thanks,
Georgi
