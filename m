Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70D6331DECB
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Feb 2021 19:08:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234744AbhBQSII (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Feb 2021 13:08:08 -0500
Received: from m42-2.mailgun.net ([69.72.42.2]:63737 "EHLO m42-2.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232901AbhBQSIE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Feb 2021 13:08:04 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1613585265; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=SU4Ew2Jl/seI0yq8ZCxyYv4yJD9/KPHDlda50sJKbi4=; b=Yr4anvRgIi0gyy7BYv4smH5y2yNAaZrP7FPvuvIYQ7KloTSGZ0CEKh2Y75QOTLrl1EJr+2wx
 CyU9miBqlnRkfdWDyuwJCvnqorv4zpPOxLh78CoaFDx21MrmoNsV/4JYe7FjGBBOkHOHvHNs
 I6o5t1TyGfGwHgmRLFyDSxtAJdw=
X-Mailgun-Sending-Ip: 69.72.42.2
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-west-2.postgun.com with SMTP id
 602d5b4f97484ee2ac3940f4 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 17 Feb 2021 18:07:11
 GMT
Sender: neeraju=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id DC930C433ED; Wed, 17 Feb 2021 18:07:10 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        NICE_REPLY_A,SPF_FAIL,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.0
Received: from [192.168.0.100] (unknown [124.123.173.84])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: neeraju)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C2ABBC433C6;
        Wed, 17 Feb 2021 18:07:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C2ABBC433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=neeraju@codeaurora.org
Subject: Re: [PATCH] arm64: Add part number for Arm Cortex-A78
To:     Will Deacon <will@kernel.org>
Cc:     catalin.marinas@arm.com, saiprakash.ranjan@codeaurora.org,
        robh@kernel.org, konrad.dybcio@somainline.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <1613580251-12694-1-git-send-email-neeraju@codeaurora.org>
 <20210217170612.GA4254@willie-the-truck>
From:   Neeraj Upadhyay <neeraju@codeaurora.org>
Message-ID: <c43d8eed-2665-9e9b-c6b5-799b5281c657@codeaurora.org>
Date:   Wed, 17 Feb 2021 23:37:04 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210217170612.GA4254@willie-the-truck>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/17/2021 10:36 PM, Will Deacon wrote:
> On Wed, Feb 17, 2021 at 10:14:11PM +0530, Neeraj Upadhyay wrote:
>> Add the MIDR part number info for the Arm Cortex-A78.
>>
>> Signed-off-by: Neeraj Upadhyay <neeraju@codeaurora.org>
>> ---
>>   arch/arm64/include/asm/cputype.h | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/arch/arm64/include/asm/cputype.h b/arch/arm64/include/asm/cputype.h
>> index ef5b040..3aced88 100644
>> --- a/arch/arm64/include/asm/cputype.h
>> +++ b/arch/arm64/include/asm/cputype.h
>> @@ -72,6 +72,7 @@
>>   #define ARM_CPU_PART_CORTEX_A76		0xD0B
>>   #define ARM_CPU_PART_NEOVERSE_N1	0xD0C
>>   #define ARM_CPU_PART_CORTEX_A77		0xD0D
>> +#define ARM_CPU_PART_CORTEX_A78		0xD41
>>   
>>   #define APM_CPU_PART_POTENZA		0x000
>>   
>> @@ -109,6 +110,7 @@
>>   #define MIDR_CORTEX_A76	MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A76)
>>   #define MIDR_NEOVERSE_N1 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_NEOVERSE_N1)
>>   #define MIDR_CORTEX_A77	MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A77)
>> +#define MIDR_CORTEX_A78	MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A78)
>>   #define MIDR_THUNDERX	MIDR_CPU_MODEL(ARM_CPU_IMP_CAVIUM, CAVIUM_CPU_PART_THUNDERX)
>>   #define MIDR_THUNDERX_81XX MIDR_CPU_MODEL(ARM_CPU_IMP_CAVIUM, CAVIUM_CPU_PART_THUNDERX_81XX)
>>   #define MIDR_THUNDERX_83XX MIDR_CPU_MODEL(ARM_CPU_IMP_CAVIUM, CAVIUM_CPU_PART_THUNDERX_83XX)
> 
> This usually means there's an erratum to work around. What are you hiding ;)
> 
> Will
> 

:) . This is needed for supporting implementation defined AMU counters 
in A78 [1]. However, there is no upstream user of it.

[1] https://www.spinics.net/lists/arm-kernel/msg856989.html


Thanks
Neeraj

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a 
member of the Code Aurora Forum, hosted by The Linux Foundation
