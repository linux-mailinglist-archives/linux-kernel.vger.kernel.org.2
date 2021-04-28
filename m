Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E0CE36D52A
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 11:57:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238447AbhD1J6O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 05:58:14 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:28864 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230032AbhD1J6M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 05:58:12 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1619603848; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=LoONnR30t2Hr+RE96I57WFMUSUtEPMniqDlWtwTrUlc=;
 b=KAv162EMuGlPkLJiz4sGF6qBfhaUryzlRqsXgjVCEj7hrPT4Z+C5JsZezesS0YbxjJ1JhJ1K
 7/9RJ5ecDmBFEVY/dqm20cuwC915UaX12mYhc2i0kRD6HRHIJpHYHQ25qcud/IR+4l+d6wNs
 B69iu8RSyRoTJXpYNNfIo/z4ThY=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-east-1.postgun.com with SMTP id
 6089317b853c0a2c46c60a22 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 28 Apr 2021 09:57:15
 GMT
Sender: taozha=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id D50BEC43217; Wed, 28 Apr 2021 09:57:14 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: taozha)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 8E1B9C433D3;
        Wed, 28 Apr 2021 09:57:13 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 28 Apr 2021 17:57:13 +0800
From:   taozha@codeaurora.org
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Tingwei Zhang <tingwei@codeaurora.org>,
        Mao Jinlong <jinlmao@codeaurora.org>,
        Yuanfang Zhang <zhangyuanfang@codeaurora.org>
Subject: Re: [PATCH v1] coresight: add node to reset all coresight devices
In-Reply-To: <e753898c-0334-cf84-620e-d9b9f18d87e7@arm.com>
References: <1619166578-28690-1-git-send-email-taozha@codeaurora.org>
 <e753898c-0334-cf84-620e-d9b9f18d87e7@arm.com>
Message-ID: <4036d63a8759ac67a26fd8798b9adf6b@codeaurora.org>
X-Sender: taozha@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-04-23 21:20, Suzuki K Poulose wrote:
> On 23/04/2021 09:29, Tao Zhang wrote:
>> Add new reset_source_sink node to be able to disable all active
>> coresight devices.
>> In this way, we no longer need to manually disable all active
>> coresight devices one by one. After enabling multiple coresight
>> paths, users can reset their status more conveniently by this
>> node.
>> 
> 
> What is the use case here ? Why would you trigger a reset for all the
> sources/sink without gracefully completing any on-going sessions
> (including the perf ones, which are driven by the kernel perf layer)
> 
We have a tool needs a command that could reset all active devices.
Since the tool cannot what dvices are activated, we add this new node
to sysFS for our tool could reset all active device by one command.
We hope that this patch can also provide a more convenient option
for the other users with the same needs.
>> This patch base on coresight-next repo
>> http://git.linaro.org/kernel/coresight.git/log/?h=next
>> 
>> And this patch depends on the following patch
>> https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg2551216.html
> 
> Please post related patches as a series, possibly describing the 
> overall
> problem that you are trying to solve, in the cover letter.
> 
Sure, I will post related patches as a series in patch v2.
>> 
>> Signed-off-by: Tingwei Zhang <tingwei@codeaurora.org>
>> Signed-off-by: Mao Jinlong <jinlmao@codeaurora.org>
>> Signed-off-by: Tao Zhang <taozha@codeaurora.org>
>> ---
>>   drivers/hwtracing/coresight/coresight-core.c | 72 
>> ++++++++++++++++++++++++----
>>   1 file changed, 64 insertions(+), 8 deletions(-)
>> 
>> diff --git a/drivers/hwtracing/coresight/coresight-core.c 
>> b/drivers/hwtracing/coresight/coresight-core.c
>> index 7dfadb6..0001b6c 100644
>> --- a/drivers/hwtracing/coresight/coresight-core.c
>> +++ b/drivers/hwtracing/coresight/coresight-core.c
>> @@ -107,6 +107,23 @@ static int coresight_source_is_unique(struct 
>> coresight_device *csdev)
>>   				 csdev, coresight_id_match);
>>   }
>>   +static int coresight_reset_sink(struct device *dev, void *data)
>> +{
>> +	struct coresight_device *csdev = to_coresight_device(dev);
>> +
>> +	if ((csdev->type == CORESIGHT_DEV_TYPE_SINK ||
>> +	     csdev->type == CORESIGHT_DEV_TYPE_LINKSINK) &&
>> +	     csdev->activated)
>> +		csdev->activated = false;
> 
> Why is this needed, when the disabl_path() should have taken care of 
> this ?
> 
coresight_disable_patch will be called before this part of code.
The aim of this patch is to disable all active coresight devices. Reset 
all
sinks and disable the sysFS "enable_sink" flag is a part of the aim.
>> +
>> +	return 0;
>> +}
>> +
>> +static void coresight_reset_all_sink(void)
>> +{
>> +	bus_for_each_dev(&coresight_bustype, NULL, NULL, 
>> coresight_reset_sink);
>> +}
>> +
> 
> How can you disable all the active sinks when some of the sinks could
> be driven by perf ?
> 
This function will only be called when users need to reset all source 
and
sinks. I see that other functions will also disable the active sink, and
then it may also cause all active sinks to be disabled.
Is it possible to provide users with a reminder that it may affect some
sinks could be driven by perf by adding a description of this function?
>>   static int coresight_find_link_inport(struct coresight_device 
>> *csdev,
>>   				      struct coresight_device *parent)
>>   {
>> @@ -1137,7 +1154,7 @@ int coresight_enable(struct coresight_device 
>> *csdev)
>>   }
>>   EXPORT_SYMBOL_GPL(coresight_enable);
>>   -void coresight_disable(struct coresight_device *csdev)
>> +static void __coresight_disable(struct coresight_device *csdev)
>>   {
>>   	int  ret;
>>   	struct list_head *path = NULL;
>> @@ -1145,14 +1162,12 @@ void coresight_disable(struct coresight_device 
>> *csdev)
>>   	struct coresight_path *cspath_next = NULL;
>>   	struct coresight_device *src_csdev = NULL;
>>   -	mutex_lock(&coresight_mutex);
>> -
>>   	ret = coresight_validate_source(csdev, __func__);
>>   	if (ret)
>> -		goto out;
>> +		return;
>>     	if (!csdev->enable || !coresight_disable_source(csdev))
>> -		goto out;
>> +		return;
>>     	list_for_each_entry_safe(cspath, cspath_next, &cs_active_paths, 
>> link) {
>>   		src_csdev = coresight_get_source(cspath->path);
>> @@ -1165,12 +1180,16 @@ void coresight_disable(struct coresight_device 
>> *csdev)
>>   		}
>>   	}
>>   	if (path == NULL)
>> -		goto out;
>> +		return;
>>     	coresight_disable_path(path);
>>   	coresight_release_path(path);
>> +}
>>   -out:
>> +void coresight_disable(struct coresight_device *csdev)
>> +{
>> +	mutex_lock(&coresight_mutex);
>> +	__coresight_disable(csdev);
>>   	mutex_unlock(&coresight_mutex);
>>   }
>>   EXPORT_SYMBOL_GPL(coresight_disable);
>> @@ -1467,7 +1486,43 @@ int coresight_timeout(void __iomem *addr, u32 
>> offset, int position, int value)
>>     	return -EAGAIN;
>>   }
>> -EXPORT_SYMBOL_GPL(coresight_timeout);
> 
> Why ?
> 
I will restore this part of code in patch v2.
>> +
>> +static ssize_t reset_source_sink_store(struct bus_type *bus,
>> +				       const char *buf, size_t size)
>> +{
>> +	int ret = 0;
>> +	unsigned long val;
>> +	struct coresight_path *cspath = NULL;
>> +	struct coresight_path *cspath_next = NULL;
>> +	struct coresight_device *csdev;
>> +
>> +	ret = kstrtoul(buf, 10, &val);
>> +	if (ret)
>> +		return ret;
>> +
>> +	mutex_lock(&coresight_mutex);
>> +
>> +	list_for_each_entry_safe(cspath, cspath_next, &cs_active_paths, 
>> link) {
>> +		csdev = coresight_get_source(cspath->path);
>> +		if (!csdev)
>> +			continue;
>> +		atomic_set(csdev->refcnt, 1);
> 
> Is this safe ?
> 
I think so.
This code "atomic_set(csdev->refcnt, 1);" will be called only
finding source coresight device. We could refer to the function
enable_source_store, it will also set refcnt to 1 before disable
source coresight device.

Best,
Tao
>> +		__coresight_disable(csdev);
>> +	}
>> +
>> +	/* Reset all activated sinks */
>> +	coresight_reset_all_sink();
>> +
>> +	mutex_unlock(&coresight_mutex);
>> +	return size;
>> +}
>> +static BUS_ATTR_WO(reset_source_sink);
>> +
>> +static struct attribute *coresight_reset_source_sink_attrs[] = {
>> +	&bus_attr_reset_source_sink.attr,
>> +	NULL,
>> +};
>> +ATTRIBUTE_GROUPS(coresight_reset_source_sink);
>>     /*
>>    * coresight_release_platform_data: Release references to the 
>> devices connected
>> @@ -1680,6 +1735,7 @@ EXPORT_SYMBOL_GPL(coresight_alloc_device_name);
>>     struct bus_type coresight_bustype = {
>>   	.name	= "coresight",
>> +	.bus_groups	= coresight_reset_source_sink_groups,
>>   };
>>     static int __init coresight_init(void)
>> 
