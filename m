Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEF1B419FAD
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 22:00:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236744AbhI0UCK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 16:02:10 -0400
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:33921 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236505AbhI0UCJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 16:02:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1632772831; x=1664308831;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=U+HxWlzaap1cTUdokhUeAOM8SlcfwsApx2dPHFjNzJI=;
  b=P955aFc7qHU65z8C8mkTqWmsStSeB6OZq4MjFZlcFbqEvB9LhqsG81Vu
   bo+W+h9gRsbgfOx88Ww9UG46hCOQ8/uTbBFSAVvqcJWvgds3cqm/RcjKj
   vLGOM6HCwpo+8DDj1YF2/H+pMCPzJWPIcyqogxlDzffQoOV9f1+gHQC7R
   4=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 27 Sep 2021 13:00:31 -0700
X-QCInternal: smtphost
Received: from unknown (HELO nasanex01a.na.qualcomm.com) ([10.52.223.231])
  by ironmsg01-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2021 13:00:30 -0700
Received: from [10.251.44.228] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.7; Mon, 27 Sep 2021
 13:00:28 -0700
Message-ID: <c83b7e80-0a16-d83f-f3f4-ab0b32c7753b@quicinc.com>
Date:   Mon, 27 Sep 2021 23:00:25 +0300
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
 <4f4f6e93-ddc2-c9bb-ef47-4a40f2c3d0d7@quicinc.com>
 <1b9c4377-0a6b-b7d4-7a6b-a69f9469bb70@redhat.com>
From:   Georgi Djakov <quic_c_gdjako@quicinc.com>
In-Reply-To: <1b9c4377-0a6b-b7d4-7a6b-a69f9469bb70@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/27/2021 8:34 PM, David Hildenbrand wrote:
> On 27.09.21 19:22, Georgi Djakov wrote:
>> On 9/24/2021 1:54 AM, Chris Goldsworthy wrote:
>>> From: Sudarshan Rajagopalan <quic_sudaraja@quicinc.com>
>>>
>>> After new memory blocks have been hotplugged, max_pfn and max_low_pfn
>>> needs updating to reflect on new PFNs being hot added to system.
>>>
>>> Signed-off-by: Sudarshan Rajagopalan <quic_sudaraja@quicinc.com>
>>> Signed-off-by: Chris Goldsworthy <quic_cgoldswo@quicinc.com>
>>
>> Thanks for the patch, Chris!
>>
>> With this patch, the data in /proc/kpageflags appears to be correct and
>> memory tools like procrank work again on arm64 platforms.
>>
>> Tested-by: Georgi Djakov <quic_c_gdjako@quicinc.com>
>>
>> Maybe we should add fixes tag, as it has been broken since the following
>> commit:
>> Fixes: abec749facff ("fs/proc/page.c: allow inspection of last section
>> and fix end detection")
> 
> Are you sure that that commit broke it?

Reverting the above commit also "fixes" kpageflags, otherwise
kpageflags_read() returns 0 in the following check:
	if (src >= max_dump_pfn * KPMSIZE)
		return 0;

> I recall that we would naturally run into the limit, because
> 
> count = min_t(size_t, count, (max_pfn * KPMSIZE) - src);

The function returns before we reach this line.

Thanks,
Georgi

> wouldn't really do what you would expect either. But you could 
> force-read beyond max_pfn, yes, because the count computation was just 
> weird.
> 
> 
> I think the real issue is not properly adjusting max_pfn in the first 
> place when we introduced memoruy hotplug on arm64
