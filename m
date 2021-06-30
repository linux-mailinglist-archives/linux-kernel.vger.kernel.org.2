Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 599303B8959
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jun 2021 21:56:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233923AbhF3T7B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Jun 2021 15:59:01 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:43456 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233777AbhF3T67 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jun 2021 15:58:59 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1625082990; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=QTTE8NNuBrvvp0efVaqe5OgIC5A/+9SKhlJOrgHTdOU=;
 b=aV6cgcg2dkvG5dOICkCIJv77AmrNCI5Isay359GRgwdAitBQ3RvX28TiO3ZaDR5UW7s0x7Ts
 woDPP7ZlC9/mF0HPMh0pJLQW3L20u01rva45FnZ6vX/OYF4WJwX/TANHrR6ZYqg7UapysN/D
 qtu4pycWf67wd1ktDLKYM0yO1Cs=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-west-2.postgun.com with SMTP id
 60dccc6b2a2a9a976194a482 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 30 Jun 2021 19:56:27
 GMT
Sender: sibis=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id E12C0C4323A; Wed, 30 Jun 2021 19:56:26 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: sibis)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 0D57DC433D3;
        Wed, 30 Jun 2021 19:56:25 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 01 Jul 2021 01:26:25 +0530
From:   Sibi Sankar <sibis@codeaurora.org>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     bjorn.andersson@linaro.org, robh+dt@kernel.org,
        swboyd@chromium.org, ulf.hansson@linaro.org, rjw@rjwysocki.net,
        agross@kernel.org, ohad@wizery.com, mathieu.poirier@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dianders@chromium.org, rishabhb@codeaurora.org,
        sidgup@codeaurora.org
Subject: Re: [PATCH v3 11/13] soc: qcom: aoss: Drop power domain support
In-Reply-To: <YNZSN2wXomiZHsz4@google.com>
References: <1624560727-6870-1-git-send-email-sibis@codeaurora.org>
 <1624560727-6870-12-git-send-email-sibis@codeaurora.org>
 <YNZSN2wXomiZHsz4@google.com>
Message-ID: <97e360aff212cc75021279f727a70454@codeaurora.org>
X-Sender: sibis@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-06-26 03:31, Matthias Kaehlcke wrote:
> On Fri, Jun 25, 2021 at 12:22:05AM +0530, Sibi Sankar wrote:
>> The load state resources are expected to follow the life cycle of the
>> remote processor it tracks. However, modeling load state resources as
>> power-domains result in them getting turned off during system suspend
>> and thereby falling out of sync with the remote processors that are 
>> still
>> on. Fix this by replacing load state resource control through the 
>> generic
>> qmp message send interface instead.
> 
> nit: the above sounds as if this patch does all of that, when it only
> removes power domain support. Instead you could start with saying what
> the patch actually does (remove power domain support), followed by why
> PD support isn't needed anymore (now done by sending QMP messages 
> directly).
> 

sure, will fix this up in the next
re-spin.

>> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
>> ---
>>  drivers/soc/qcom/qcom_aoss.c | 109 
>> ++-----------------------------------------
>>  1 file changed, 3 insertions(+), 106 deletions(-)
>> 
>> diff --git a/drivers/soc/qcom/qcom_aoss.c 
>> b/drivers/soc/qcom/qcom_aoss.c
>> index 998ee7605eb2..f0c3726e8c46 100644
>> --- a/drivers/soc/qcom/qcom_aoss.c
>> +++ b/drivers/soc/qcom/qcom_aoss.c
>> 
>> ...
>> 
>> @@ -650,13 +550,11 @@ static int qmp_probe(struct platform_device 
>> *pdev)
>>  	if (ret)
>>  		goto err_close_qmp;
>> 
>> -	ret = qmp_pd_add(qmp);
>> -	if (ret)
>> -		goto err_remove_qdss_clk;
>> -
>>  	ret = qmp_cooling_devices_register(qmp);
>> -	if (ret)
>> +	if (ret) {
>>  		dev_err(&pdev->dev, "failed to register aoss cooling devices\n");
>> +		goto err_remove_qdss_clk;
> 
> This isn't really related with the PD removal, right? I wonder if it 
> was
> intentional to have _probe() succeed even when the cooling device
> registration failed, since the cooling devices aren't essential.
> 

Thanks for catching ^^

> If it is still desirable to fail the change should be done in a 
> separate
> patch, unless it is actually related with removing PD support.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project.
