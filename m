Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43CCC3AD10D
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 19:18:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234058AbhFRRUb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 13:20:31 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:12922 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233592AbhFRRU3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 13:20:29 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1624036700; h=Message-ID: References: In-Reply-To: Reply-To:
 Subject: Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=tsDQ/x476xQMg+i6U9LMmZaf12qtvL+ZvKD0j04iFt4=;
 b=EmqTCabH7rU0Dwb/4N5p4+IRV1CbifGrkaNnZywpiAnjksHeAhp0dpg8TYiGIDVFhVl/68Ou
 JIBikqS7ULG4RCjoxhsbpHAI+CYW4jWnix4c2CSp+K7epqC7rWmLmYi/q9dLsYSFtvz/g2wu
 7ZCkE/3lrRZvxuUlB9FrlOfuYfg=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-east-1.postgun.com with SMTP id
 60ccd54ae27c0cc77f6aa01e (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 18 Jun 2021 17:18:02
 GMT
Sender: bbhatt=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 1F97DC433D3; Fri, 18 Jun 2021 17:18:01 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbhatt)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 0FC43C433F1;
        Fri, 18 Jun 2021 17:17:59 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 18 Jun 2021 10:17:59 -0700
From:   Bhaumik Bhatt <bbhatt@codeaurora.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, hemantk@codeaurora.org,
        jhugo@codeaurora.org, linux-kernel@vger.kernel.org,
        carl.yin@quectel.com, naveen.kumar@quectel.com,
        loic.poulain@linaro.org
Subject: Re: [PATCH v1 1/4] bus: mhi: core: Add support for processing
 priority of event ring
Organization: Qualcomm Innovation Center, Inc.
Reply-To: bbhatt@codeaurora.org
Mail-Reply-To: bbhatt@codeaurora.org
In-Reply-To: <20210618070322.GO3682@workstation>
References: <1623965435-30224-1-git-send-email-bbhatt@codeaurora.org>
 <1623965435-30224-2-git-send-email-bbhatt@codeaurora.org>
 <20210618070322.GO3682@workstation>
Message-ID: <df7c735f0caeb449bbaa8a6e040ae556@codeaurora.org>
X-Sender: bbhatt@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mani,

On 2021-06-18 12:03 AM, Manivannan Sadhasivam wrote:
> On Thu, Jun 17, 2021 at 02:30:32PM -0700, Bhaumik Bhatt wrote:
>> From: Hemant Kumar <hemantk@codeaurora.org>
>> 
>> Event ring priorities are currently set to 1 and are unused.
>> Default processing priority for event rings is set to regular
>> tasklet. Controllers can choose to use high priority tasklet
>> scheduling for certain event rings critical for processing such
>> as ones transporting control information if they wish to avoid
>> with system scheduling delays for those packets. In order to
>> support these use cases, allow controllers to set event ring
>> priority to high. This patch only adds support and does not
>> enable usage of these priorities.
>> 
>> Signed-off-by: Hemant Kumar <hemantk@codeaurora.org>
>> Signed-off-by: Bhaumik Bhatt <bbhatt@codeaurora.org>
>> ---
>>  drivers/bus/mhi/core/internal.h |  2 +-
>>  drivers/bus/mhi/core/main.c     | 19 ++++++++++++++++---
>>  include/linux/mhi.h             | 14 ++++++++++++--
>>  3 files changed, 29 insertions(+), 6 deletions(-)
>> 
>> diff --git a/drivers/bus/mhi/core/internal.h 
>> b/drivers/bus/mhi/core/internal.h
>> index 672052f..666e102 100644
>> --- a/drivers/bus/mhi/core/internal.h
>> +++ b/drivers/bus/mhi/core/internal.h
>> @@ -535,7 +535,7 @@ struct mhi_event {
>>  	u32 intmod;
>>  	u32 irq;
>>  	int chan; /* this event ring is dedicated to a channel (optional) */
>> -	u32 priority;
>> +	enum mhi_er_priority priority;
> 
> Instead of using enum for priorities, can we just make use of the
> existing "priority" field? Since the existing controllers set it to 
> "1",
> can we use "0" as the high priority?
> 
> This way we don't need to change the controller drivers.
> 
I agree but the reasons to do the enum approach was to allow for future
expansion of the handling if it becomes necessary and provide clarity 
for
the field.

I can always do it this way for now and we can have the enum for another
time but would prefer updating what we have now.
>>  	enum mhi_er_data_type data_type;
>>  	struct mhi_ring ring;
>>  	struct db_cfg db_cfg;
>> diff --git a/drivers/bus/mhi/core/main.c b/drivers/bus/mhi/core/main.c
>> index 8ac73f9..bfc9776 100644
>> --- a/drivers/bus/mhi/core/main.c
>> +++ b/drivers/bus/mhi/core/main.c
>> @@ -425,10 +425,11 @@ void mhi_create_devices(struct mhi_controller 
>> *mhi_cntrl)
>>  	}
>>  }
>> 
>> -irqreturn_t mhi_irq_handler(int irq_number, void *dev)
>> +irqreturn_t mhi_irq_handler(int irq_number, void *priv)
>>  {
>> -	struct mhi_event *mhi_event = dev;
>> +	struct mhi_event *mhi_event = priv;
>>  	struct mhi_controller *mhi_cntrl = mhi_event->mhi_cntrl;
>> +	struct device *dev = &mhi_cntrl->mhi_dev->dev;
>>  	struct mhi_event_ctxt *er_ctxt =
>>  		&mhi_cntrl->mhi_ctxt->er_ctxt[mhi_event->er_index];
>>  	struct mhi_ring *ev_ring = &mhi_event->ring;
>> @@ -454,8 +455,20 @@ irqreturn_t mhi_irq_handler(int irq_number, void 
>> *dev)
>> 
>>  		if (mhi_dev)
>>  			mhi_notify(mhi_dev, MHI_CB_PENDING_DATA);
>> -	} else {
>> +
>> +		return IRQ_HANDLED;
>> +	}
>> +
>> +	switch (mhi_event->priority) {
>> +	case MHI_ER_PRIORITY_HI:
> 
> This could be,
> 
> 	/* Use high priority tasklet for high priority event ring */
> 	if (!mhi_event->priority)
> 		tasklet_hi_schedule(&mhi_event->task);
> 	else
> 		tasklet_schedule(&mhi_event->task);
> 
> Thanks,
> Mani
> 
Yes, this works too if we keep the current non-enum approach.
>> +		tasklet_hi_schedule(&mhi_event->task);
>> +		break;
>> +	case MHI_ER_PRIORITY_DEFAULT:
>>  		tasklet_schedule(&mhi_event->task);
>> +		break;
>> +	default:
>> +		dev_err(dev, "Skip event of unknown priority\n");
>> +		break;
>>  	}
>> 
>>  	return IRQ_HANDLED;
>> diff --git a/include/linux/mhi.h b/include/linux/mhi.h
>> index 86cea52..25ee312 100644
>> --- a/include/linux/mhi.h
>> +++ b/include/linux/mhi.h
>> @@ -198,6 +198,16 @@ enum mhi_er_data_type {
>>  };
>> 
>>  /**
>> + * enum mhi_er_priority - Event ring processing priority
>> + * @MHI_ER_PRIORITY_HI: processed by hi-priority tasklet
>> + * @MHI_ER_PRIORITY_DEFAULT: processed by regular tasklet
>> + */
>> +enum mhi_er_priority {
>> +	MHI_ER_PRIORITY_HI,
>> +	MHI_ER_PRIORITY_DEFAULT,
>> +};
>> +
>> +/**
>>   * enum mhi_db_brst_mode - Doorbell mode
>>   * @MHI_DB_BRST_DISABLE: Burst mode disable
>>   * @MHI_DB_BRST_ENABLE: Burst mode enable
>> @@ -250,7 +260,7 @@ struct mhi_channel_config {
>>   * @irq_moderation_ms: Delay irq for additional events to be 
>> aggregated
>>   * @irq: IRQ associated with this ring
>>   * @channel: Dedicated channel number. U32_MAX indicates a 
>> non-dedicated ring
>> - * @priority: Priority of this ring. Use 1 for now
>> + * @priority: Processing priority of this ring.
>>   * @mode: Doorbell mode
>>   * @data_type: Type of data this ring will process
>>   * @hardware_event: This ring is associated with hardware channels
>> @@ -262,7 +272,7 @@ struct mhi_event_config {
>>  	u32 irq_moderation_ms;
>>  	u32 irq;
>>  	u32 channel;
>> -	u32 priority;
>> +	enum mhi_er_priority priority;
>>  	enum mhi_db_brst_mode mode;
>>  	enum mhi_er_data_type data_type;
>>  	bool hardware_event;
>> --
>> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora 
>> Forum,
>> a Linux Foundation Collaborative Project
>> 
Existing controllers would be fine.

Do you think we have a problem if a new controller blindly inputs a "0" 
in
the priority not knowing the impact of it?

If you give me a go ahead, I can make these changes in v2 and leave the 
enum
stuff out.

Thanks,
Bhaumik
---
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora 
Forum,
a Linux Foundation Collaborative Project
