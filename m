Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E48C0434AB3
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 14:04:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230185AbhJTMGZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 08:06:25 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:52052 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230229AbhJTMGY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 08:06:24 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1634731450; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=O0IH1Cq3STR9DF8CefTN3jktoLIAHu/Gkj+D6afaP00=; b=pbFUMHJR89vS4eXAC1hhGqUA56b1ANEt9tEsck9ExxdkxQAIMzlSUJ80DB35bc31+jaaIneP
 AGXJUUEm5umWkjxYDukE/QMcguAHh6odaFxIeaoJC+JDOienENm29YzCZs8dbaEbAGn6rGF3
 JyKrsNUqQVqy/h0ej0FAsVIXtC0=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-east-1.postgun.com with SMTP id
 6170058d59612e01006cb13d (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 20 Oct 2021 12:03:25
 GMT
Sender: clingutla=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id A18DBC4338F; Wed, 20 Oct 2021 12:03:24 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        NICE_REPLY_A,SPF_FAIL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from [192.168.43.40] (unknown [223.185.83.206])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: clingutla)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 70153C4338F;
        Wed, 20 Oct 2021 12:03:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 70153C4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
Subject: Re: [PATCH] PM: EM: do not allow pd creation prior to debugfs
 initialization
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     rafael.j.wysocki@intel.com, qperret@google.com,
        daniel.lezcano@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <20211019152819.6141-1-clingutla@codeaurora.org>
 <e01188a0-1dc7-db57-309f-f49390216875@arm.com>
From:   Chandrasekhar L <clingutla@codeaurora.org>
Message-ID: <0c42bec7-4358-a8d6-b1db-f52218a8e59a@codeaurora.org>
Date:   Wed, 20 Oct 2021 17:33:18 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <e01188a0-1dc7-db57-309f-f49390216875@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Lukasz for comment.
For any reason (ex: HW dependency, etc), if  init_call level of cpufreq/devfreq driver changed
prior to fs_init call, we would land there right?

One of such example is, 'drivers/cpufreq/qcom-cpufreq-hw.c' uses postcore_initcall().

Thanks,
Chandrasekhar L


On 10/19/2021 10:35 PM, Lukasz Luba wrote:
>
>
> On 10/19/21 4:28 PM, Lingutla Chandrasekhar wrote:
>> em_dev_register_perf_domain() can be called from any initcall level before
>
> The EM is registered by cpufreq drivers (or devfreq), which is later
> than fs_initcall, so the debugfs is setup. We even have added recently
> a dedicated callback into the cpufreq (register_em()) for that.
>
> Do you have such code which registers EM for CPUs (or some devfreq)
> earlier than this fs_initcall?
>
> I cannot find such code in mainline.
>
> Regards,
> Lukasz

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
 a Linux Foundation Collaborative Project.

