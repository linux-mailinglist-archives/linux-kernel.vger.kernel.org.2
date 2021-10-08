Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94A66426678
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 11:15:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbhJHJR2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 05:17:28 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:34363 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229785AbhJHJR1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 05:17:27 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1633684532; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=O1dvGLkJryt1Np3uFmSn2mRuBEvcRBygeog5lcPNHVE=; b=YcXW9un6pBTz3edSfQJffpFpZ3z3yNso0Ndfhozulmi5Ad3GxhgP5b6Q2AqFkWo76CUmuGiE
 8Z8CfAMJJck0N71Pv70d250RTmkNj8Q9fDB7y6tGiV2RS4X6P41fvcbkbrBPSsPigYmnq7wY
 DNNYmYBwnw61kZKkc9G3wq7Ch9c=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-west-2.postgun.com with SMTP id
 61600c324ccc4cf2c7e0540f (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 08 Oct 2021 09:15:30
 GMT
Sender: mkshah=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id C0D12C43618; Fri,  8 Oct 2021 09:15:29 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        NICE_REPLY_A,SPF_FAIL autolearn=no autolearn_force=no version=3.4.0
Received: from [192.168.29.129] (unknown [49.36.85.177])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mkshah)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D8D66C4338F;
        Fri,  8 Oct 2021 09:15:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org D8D66C4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
Subject: Re: [PATCH v11 2/5] soc: qcom: Add Sleep stats driver
To:     Stephan Gerhold <stephan@gerhold.net>
Cc:     swboyd@chromium.org, mka@chromium.org, evgreen@chromium.org,
        bjorn.andersson@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, agross@kernel.org,
        dianders@chromium.org, linux@roeck-us.net, rnayak@codeaurora.org,
        lsrao@codeaurora.org,
        Mahesh Sivasubramanian <msivasub@codeaurora.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Yassine Oudjana <y.oudjana@protonmail.com>
References: <1633600649-7164-1-git-send-email-mkshah@codeaurora.org>
 <1633600649-7164-3-git-send-email-mkshah@codeaurora.org>
 <YV88fNYF0i1Wkr73@gerhold.net>
From:   Maulik Shah <mkshah@codeaurora.org>
Message-ID: <acaf7b6e-c5b7-ae27-c4ba-37f375f05f19@codeaurora.org>
Date:   Fri, 8 Oct 2021 14:45:20 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YV88fNYF0i1Wkr73@gerhold.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 10/7/2021 11:59 PM, Stephan Gerhold wrote:
> Hi Maulik,
> 
> On Thu, Oct 07, 2021 at 03:27:26PM +0530, Maulik Shah wrote:
>> From: Mahesh Sivasubramanian <msivasub@codeaurora.org>
>>
>> Let's add a driver to read the stats from remote processor and
>> export to debugfs.
>>
>> The driver creates "qcom_sleep_stats" directory in debugfs and
>> adds files for various low power mode available. Below is sample
>> output with command
>>
>> cat /sys/kernel/debug/qcom_sleep_stats/ddr
>> count = 0
>> Last Entered At = 0
>> Last Exited At = 0
>> Accumulated Duration = 0
>>
>> Signed-off-by: Mahesh Sivasubramanian <msivasub@codeaurora.org>
>> Signed-off-by: Lina Iyer <ilina@codeaurora.org>
>> [mkshah: add subsystem sleep stats, create one file for each stat]
>> Signed-off-by: Maulik Shah <mkshah@codeaurora.org>
>> ---
>>   drivers/soc/qcom/Kconfig            |  10 ++
>>   drivers/soc/qcom/Makefile           |   1 +
>>   drivers/soc/qcom/qcom_sleep_stats.c | 259 ++++++++++++++++++++++++++++++++++++
>>   3 files changed, 270 insertions(+)
>>   create mode 100644 drivers/soc/qcom/qcom_sleep_stats.c
>>
>> [...]
>> +
>> +static int qcom_subsystem_sleep_stats_show(struct seq_file *s, void *unused)
>> +{
>> +	struct subsystem_data *subsystem = s->private;
>> +	struct sleep_stats *stat;
>> +
>> +	/* Items are allocated lazily, so lookup pointer each time */
>> +	stat = qcom_smem_get(subsystem->pid, subsystem->smem_item, NULL);
>> +	if (IS_ERR(stat))
>> +		return -EIO;
>> +
>> [...]
>> +
>> +static void qcom_create_subsystem_stat_files(struct dentry *root)
>> +{
>> +	const struct sleep_stats *stat;
>> +	int i;
>> +
>> +	for (i = 0; i < ARRAY_SIZE(subsystems); i++) {
>> +		stat = qcom_smem_get(subsystems[i].pid, subsystems[i].smem_item, NULL);
>> +		if (IS_ERR(stat))
>> +			continue;
>> +
>> +		debugfs_create_file(subsystems[i].name, 0400, root, (void *)&subsystems[i],
>> +				    &qcom_subsystem_sleep_stats_fops);
> 
> This causes WARNINGs on MSM8996 and MSM8916:
> 
> [    0.503054] ------------[ cut here ]------------
> [    0.503100] WARNING: CPU: 1 PID: 1 at drivers/soc/qcom/smem.c:587 qcom_smem_get+0x184/0x1b0
> [    0.503184] CPU: 1 PID: 1 Comm: swapper/0 Not tainted 5.15.0-rc4+ #378
> [    0.503218] Hardware name: Xiaomi Mi Note 2 (DT)
> [    0.503278] pc : qcom_smem_get+0x184/0x1b0
> [    0.503307] lr : qcom_sleep_stats_probe+0xfc/0x20
> [    0.503875] Call trace:
> [    0.503896]  qcom_smem_get+0x184/0x1b0
> [    0.503925]  qcom_sleep_stats_probe+0xfc/0x270
> 
> AFAICT from downstream the smem subsystem information is only read in
> the rpmh_master_stat.c driver, should this be specific to RPMh?

Thanks for checking this on MSM8996. Probably it doesnot have SMEM items 
allocated so causes WARNINGs.

Keeping subsystem stats info in SMEM is not limited to only RPMH 
targets. Downstream has some RPM targets which also uses SMEM to store
subsystem stats so the driver is kept generic.

> 
> There is a rpm_master_stat.c too but that looks quite different,
> so I guess the approach is different with RPM?

Right. on existing upstream RPM targets i can skip to create/get SMEM 
items since
they are not guranteed to be present and one should continue to use 
rpm_master_stats.c to get subsystem stats. (this uses entirely different 
data structure for sleep stats and are not part of RPM data ram/SMEM and 
are deprecated in downstream).

> 
> Two more (unrelated) issues here:
> 
>    1. This will silently not register anything if SMEM probes after the
>       qcom-sleep-stats driver (qcom_smem_get() will return -EPROBE_DEFER)
>       and you will just skip registering the debugfs files.

I think module loading internally takes care of this.
we're making a direct function call into the qcom_smem driver, so we
already have a hard dependency on qcom_smem.ko being loaded.

> 
>    2. In qcom_subsystem_sleep_stats_show() you say
>       /* Items are allocated lazily, so lookup pointer each time */
> 
>       But, if the lookup fails here you don't register the debugfs file
>       at all. Does this work if the subsystem is started after this driver?

Good catch. if the subsystem starts after this driver is loaded, the 
look up fails during probe and we don't create debugfs file for the 
subsystem.

one need to unload/load the driver again after sometime in bootup so by 
that time all the subsytems (modem, adsp, cdsp, etc) are up and we 
create debugfs file for them.

we have downstream fix for this to create the debugfs files irrespective 
of look up fails or not. i have plan to add it once the base driver gets 
merged.

Thanks,
Maulik

> 
> Thanks,
> Stephan
> 

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a 
member of Code Aurora Forum, hosted by The Linux Foundation
