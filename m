Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA733334C13
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 23:58:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232859AbhCJW5g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 17:57:36 -0500
Received: from z11.mailgun.us ([104.130.96.11]:17040 "EHLO z11.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233925AbhCJW5K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 17:57:10 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1615417030; h=Message-ID: References: In-Reply-To: Reply-To:
 Subject: Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=VYYHofzSY0wCDsmoS7mrOgGJXNqdq4CHb6Pt8JmQLTM=;
 b=i6uPnbF8wu3ew1D21N5C10EtP4kYV9poXZsFTVLSRFhaf2AxzUgOeB0N21byJn5kHqbEnvv6
 RmTz10nCC4zC1Kdb/5QHJ86jliGEkYAgkVprGSgzkIEvBrpuODT6wyxubXCWJ+Vz0afRx96z
 h/2MZeUgKZlL7wgA/68eKOzkWbE=
X-Mailgun-Sending-Ip: 104.130.96.11
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-west-2.postgun.com with SMTP id
 60494ebd0c7cf0f56c888c45 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 10 Mar 2021 22:57:01
 GMT
Sender: bbhatt=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 56010C433ED; Wed, 10 Mar 2021 22:57:01 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbhatt)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 52216C433C6;
        Wed, 10 Mar 2021 22:56:59 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 10 Mar 2021 14:56:59 -0800
From:   Bhaumik Bhatt <bbhatt@codeaurora.org>
To:     Jeffrey Hugo <jhugo@codeaurora.org>
Cc:     manivannan.sadhasivam@linaro.org, linux-arm-msm@vger.kernel.org,
        hemantk@codeaurora.org, linux-kernel@vger.kernel.org,
        loic.poulain@linaro.org, carl.yin@quectel.com,
        naveen.kumar@quectel.com, jhugo=codeaurora.org@codeaurora.org
Subject: Re: [PATCH v3 1/3] bus: mhi: core: Introduce internal register poll
 helper function
Organization: Qualcomm Innovation Center, Inc.
Reply-To: bbhatt@codeaurora.org
Mail-Reply-To: bbhatt@codeaurora.org
In-Reply-To: <b53a5cf8-aa25-0e89-b83f-57ec32fa7075@codeaurora.org>
References: <1614138270-2374-1-git-send-email-bbhatt@codeaurora.org>
 <1614138270-2374-2-git-send-email-bbhatt@codeaurora.org>
 <b53a5cf8-aa25-0e89-b83f-57ec32fa7075@codeaurora.org>
Message-ID: <3d554e8bf92278d9f0ddb8f852880b68@codeaurora.org>
X-Sender: bbhatt@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-03-10 10:57 AM, Jeffrey Hugo wrote:
> On 2/23/2021 8:44 PM, Bhaumik Bhatt wrote:
>> Introduce helper function to allow MHI core driver to poll for
>> a value in a register field. This helps reach a common path to
>> read and poll register values along with a retry time interval.
>> 
>> Signed-off-by: Bhaumik Bhatt <bbhatt@codeaurora.org>
>> ---
>>   drivers/bus/mhi/core/internal.h |  3 +++
>>   drivers/bus/mhi/core/main.c     | 23 +++++++++++++++++++++++
>>   2 files changed, 26 insertions(+)
>> 
>> diff --git a/drivers/bus/mhi/core/internal.h 
>> b/drivers/bus/mhi/core/internal.h
>> index 6f80ec3..005286b 100644
>> --- a/drivers/bus/mhi/core/internal.h
>> +++ b/drivers/bus/mhi/core/internal.h
>> @@ -643,6 +643,9 @@ int __must_check mhi_read_reg(struct 
>> mhi_controller *mhi_cntrl,
>>   int __must_check mhi_read_reg_field(struct mhi_controller 
>> *mhi_cntrl,
>>   				    void __iomem *base, u32 offset, u32 mask,
>>   				    u32 shift, u32 *out);
>> +int __must_check mhi_poll_reg_field(struct mhi_controller *mhi_cntrl,
>> +				    void __iomem *base, u32 offset, u32 mask,
>> +				    u32 shift, u32 val, u32 delayus);
>>   void mhi_write_reg(struct mhi_controller *mhi_cntrl, void __iomem 
>> *base,
>>   		   u32 offset, u32 val);
>>   void mhi_write_reg_field(struct mhi_controller *mhi_cntrl, void 
>> __iomem *base,
>> diff --git a/drivers/bus/mhi/core/main.c b/drivers/bus/mhi/core/main.c
>> index 4e0131b..249ae26 100644
>> --- a/drivers/bus/mhi/core/main.c
>> +++ b/drivers/bus/mhi/core/main.c
>> @@ -4,6 +4,7 @@
>>    *
>>    */
>>   +#include <linux/delay.h>
>>   #include <linux/device.h>
>>   #include <linux/dma-direction.h>
>>   #include <linux/dma-mapping.h>
>> @@ -37,6 +38,28 @@ int __must_check mhi_read_reg_field(struct 
>> mhi_controller *mhi_cntrl,
>>   	return 0;
>>   }
>>   +int __must_check mhi_poll_reg_field(struct mhi_controller 
>> *mhi_cntrl,
>> +				    void __iomem *base, u32 offset,
>> +				    u32 mask, u32 shift, u32 val, u32 delayus)
>> +{
>> +	int ret = -ENOENT;
Make this int ret;
>> +	u32 out, retry = (mhi_cntrl->timeout_ms * 1000) / delayus;
>> +
>> +	while (retry--) {
>> +		ret = mhi_read_reg_field(mhi_cntrl, base, offset, mask, shift,
>> +					 &out);
>> +		if (ret)
>> +			return -EIO;
> 
> I generally dislike recoding return codes.  Do you believe it adds
> value here?  I'm concerned that if I'm debugging an error, I'll get
> EIO, which I trace to here, but then I don't know what the actual
> error from mhi_read_reg_field() was.
> 
Thanks for pointing out. I don't think its necessary to recode and I can 
go back
to returning whatever the reg_field API returns. I have added the 
proposed changes
here which help fix a potential bug that we'd return 0 if read is 
successful but
polling fails.
>> +
>> +		if (out == val)
>> +			return 0;
>> +
>> +		udelay(delayus);
>> +	}
>> +
>> +	return ret;
return -ENOENT; to signify failure to find the entry after poll duration 
completes
>> +}
>> +
>>   void mhi_write_reg(struct mhi_controller *mhi_cntrl, void __iomem 
>> *base,
>>   		   u32 offset, u32 val)
>>   {
>> 

Thanks,
Bhaumik
---
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora 
Forum,
a Linux Foundation Collaborative Project
