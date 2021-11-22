Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A404645910E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Nov 2021 16:12:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239768AbhKVPPT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Nov 2021 10:15:19 -0500
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:25920 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232194AbhKVPPS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Nov 2021 10:15:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1637593932; x=1669129932;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=o/mxiAnJscc7T6qrYXL6/zl+l/G+e+N2nw5aKjBuvg4=;
  b=G31S/vTRv4kOhsz72S5uZ2pmbY/VCiWdJb6ukksqBYAUlSLvOSkgMVVN
   hM/FO8nGnLNvF59OymGd1W0/y+3C4r2uutNilUlfIl2Tp3MhZseShVl2X
   H+/psDfutMkkIQvrOmhsfAD5fu3LeXwJt9zwDnCnag9z8isJ4S1UgyJmx
   4=;
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 22 Nov 2021 07:12:11 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg03-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2021 07:12:11 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Mon, 22 Nov 2021 07:12:10 -0800
Received: from [10.239.96.147] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.19; Mon, 22 Nov
 2021 07:12:06 -0800
Message-ID: <b7ec5d50-cc42-fa94-2053-8d652f455a9e@quicinc.com>
Date:   Mon, 22 Nov 2021 23:12:03 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH 01/10] coresight: add support to enable more coresight
 paths
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Tao Zhang <quic_taozha@quicinc.com>
CC:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <coresight@lists.linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        "Tingwei Zhang" <tingwei@codeaurora.org>
References: <1634801936-15080-1-git-send-email-quic_taozha@quicinc.com>
 <1634801936-15080-2-git-send-email-quic_taozha@quicinc.com>
 <20211028180659.GC4045120@p14s>
From:   Jinlong Mao <quic_jinlmao@quicinc.com>
In-Reply-To: <20211028180659.GC4045120@p14s>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mathieu,

Thanks for the comments.

I double checked the code. Please see my comments below.


On 10/29/2021 2:06 AM, Mathieu Poirier wrote:
> On Thu, Oct 21, 2021 at 03:38:47PM +0800, Tao Zhang wrote:
>> Current coresight implementation only supports enabling source
>> ETMs or STM. This patch adds support to enable more kinds of
>> coresight source to sink paths. We build a path from source to
>> sink when any source is enabled and store it in a list. When the
>> source is disabled, we fetch the corresponding path from the list
>> and decrement the refcount on each device in the path. The device
>> is disabled if the refcount reaches zero. Don't store path to
>> coresight data structure of source to avoid unnecessary change to
>> ABI.
>> Since some targets may have coresight sources other than STM and
>> ETMs, we need to add this change to support these coresight
>> devices.
>>
>> Signed-off-by: Tingwei Zhang <tingwei@codeaurora.org>
>> Signed-off-by: Tao Zhang <quic_taozha@quicinc.com>
>> ---
>>   drivers/hwtracing/coresight/coresight-core.c | 100 +++++++++++--------
>>   1 file changed, 56 insertions(+), 44 deletions(-)
>>
>> diff --git a/drivers/hwtracing/coresight/coresight-core.c b/drivers/hwtracing/coresight/coresight-core.c
>> index 8a18c71df37a..1e621d61307a 100644
>> --- a/drivers/hwtracing/coresight/coresight-core.c
>> +++ b/drivers/hwtracing/coresight/coresight-core.c
>> @@ -37,18 +37,16 @@ struct coresight_node {
>>   };
>>   
>>   /*
>> - * When operating Coresight drivers from the sysFS interface, only a single
>> - * path can exist from a tracer (associated to a CPU) to a sink.
>> + * struct coresight_path - path from source to sink
>> + * @path:	Address of path list.
>> + * @link:	hook to the list.
>>    */
>> -static DEFINE_PER_CPU(struct list_head *, tracer_path);
>> +struct coresight_path {
>> +	struct list_head *path;
>> +	struct list_head link;
>> +};
> For sources associated with a CPU, like ETMs, having a per-cpu way of storing
> paths is a definite advantage and should be kept that way.

Hi Mathieu,

Could you please share what is the advantage to handle the sources 
associated with a CPU separatly ?

 From the code, cpu id is only used to get the path of the ETM source.

As there will be many tpdm sources, I think it will be easier to only 
maintain one list for all the sources.

>>   
>> -/*
>> - * As of this writing only a single STM can be found in CS topologies.  Since
>> - * there is no way to know if we'll ever see more and what kind of
>> - * configuration they will enact, for the time being only define a single path
>> - * for STM.
>> - */
>> -static struct list_head *stm_path;
>> +static LIST_HEAD(cs_active_paths);
> Then there are sources that aren't associated with a CPU like STMs and TPDMs.
> Perhaps using an IDR or the hash of the device name as a key to a hashing
> vector would be better than doing a sequential search, especially as the
> list of devices is bound to increase over time.

Agree with you. I will try to use IDR or  the hash of the device name as 
a key to a hashing vector.

>
>>   
>>   /*
>>    * When losing synchronisation a new barrier packet needs to be inserted at the
>> @@ -354,6 +352,7 @@ static void coresight_disable_sink(struct coresight_device *csdev)
>>   	if (ret)
>>   		return;
>>   	coresight_control_assoc_ectdev(csdev, false);
>> +	csdev->activated = false;
> I don't see why this is needed and without proper documentation there is no way
> for me to guess the logic behind the change.  The ->activated flag should be
> manipulated from the command line interface only.

When source is disabled, but sink is still actived. It will be confused 
for end users.

>
>>   	csdev->enable = false;
>>   }
>>   
>> @@ -590,6 +589,20 @@ int coresight_enable_path(struct list_head *path, u32 mode, void *sink_data)
>>   	goto out;
>>   }
>>   
>> +static struct coresight_device *coresight_get_source(struct list_head *path)
>> +{
>> +	struct coresight_device *csdev;
>> +
>> +	if (!path)
>> +		return NULL;
>> +
>> +	csdev = list_first_entry(path, struct coresight_node, link)->csdev;
>> +	if (csdev->type != CORESIGHT_DEV_TYPE_SOURCE)
>> +		return NULL;
>> +
>> +	return csdev;
>> +}
>> +
>>   struct coresight_device *coresight_get_sink(struct list_head *path)
>>   {
>>   	struct coresight_device *csdev;
>> @@ -1086,9 +1099,23 @@ static int coresight_validate_source(struct coresight_device *csdev,
>>   	return 0;
>>   }
>>   
>> +static int coresight_store_path(struct list_head *path)
>> +{
>> +	struct coresight_path *node;
>> +
>> +	node = kzalloc(sizeof(struct coresight_path), GFP_KERNEL);
>> +	if (!node)
>> +		return -ENOMEM;
>> +
>> +	node->path = path;
>> +	list_add(&node->link, &cs_active_paths);
>> +
>> +	return 0;
>> +}
>> +
>>   int coresight_enable(struct coresight_device *csdev)
>>   {
>> -	int cpu, ret = 0;
>> +	int ret = 0;
>>   	struct coresight_device *sink;
>>   	struct list_head *path;
>>   	enum coresight_dev_subtype_source subtype;
>> @@ -1133,25 +1160,9 @@ int coresight_enable(struct coresight_device *csdev)
>>   	if (ret)
>>   		goto err_source;
>>   
>> -	switch (subtype) {
>> -	case CORESIGHT_DEV_SUBTYPE_SOURCE_PROC:
>> -		/*
>> -		 * When working from sysFS it is important to keep track
>> -		 * of the paths that were created so that they can be
>> -		 * undone in 'coresight_disable()'.  Since there can only
>> -		 * be a single session per tracer (when working from sysFS)
>> -		 * a per-cpu variable will do just fine.
>> -		 */
>> -		cpu = source_ops(csdev)->cpu_id(csdev);
>> -		per_cpu(tracer_path, cpu) = path;
>> -		break;
>> -	case CORESIGHT_DEV_SUBTYPE_SOURCE_SOFTWARE:
>> -		stm_path = path;
>> -		break;
>> -	default:
>> -		/* We can't be here */
>> -		break;
>> -	}
>> +	ret = coresight_store_path(path);
>> +	if (ret)
>> +		goto err_source;
>>   
>>   out:
>>   	mutex_unlock(&coresight_mutex);
>> @@ -1168,8 +1179,11 @@ EXPORT_SYMBOL_GPL(coresight_enable);
>>   
>>   void coresight_disable(struct coresight_device *csdev)
>>   {
>> -	int cpu, ret;
>> +	int  ret;
>>   	struct list_head *path = NULL;
>> +	struct coresight_path *cspath = NULL;
>> +	struct coresight_path *cspath_next = NULL;
>> +	struct coresight_device *src_csdev = NULL;
>>   
>>   	mutex_lock(&coresight_mutex);
>>   
>> @@ -1180,20 +1194,18 @@ void coresight_disable(struct coresight_device *csdev)
>>   	if (!csdev->enable || !coresight_disable_source(csdev))
>>   		goto out;
>>   
>> -	switch (csdev->subtype.source_subtype) {
>> -	case CORESIGHT_DEV_SUBTYPE_SOURCE_PROC:
>> -		cpu = source_ops(csdev)->cpu_id(csdev);
>> -		path = per_cpu(tracer_path, cpu);
>> -		per_cpu(tracer_path, cpu) = NULL;
>> -		break;
>> -	case CORESIGHT_DEV_SUBTYPE_SOURCE_SOFTWARE:
>> -		path = stm_path;
>> -		stm_path = NULL;
>> -		break;
>> -	default:
>> -		/* We can't be here */
>> -		break;
>> +	list_for_each_entry_safe(cspath, cspath_next, &cs_active_paths, link) {
>> +		src_csdev = coresight_get_source(cspath->path);
>> +		if (!src_csdev)
>> +			continue;
>> +		if (src_csdev == csdev) {
>> +			path = cspath->path;
>> +			list_del(&cspath->link);
>> +			kfree(cspath);
> See my comment above - I agree that sources _not_ associated with a CPU should
> be handled differently.  CPU bound sources should be kept untouched.
>
> That is all the time I had for today, I will continue tomorrow.
>
> Thanks,
> Mathieu
>
>> +		}
>>   	}
>> +	if (path == NULL)
>> +		goto out;
>>   
>>   	coresight_disable_path(path);
>>   	coresight_release_path(path);
>> -- 
>> 2.17.1
>>
