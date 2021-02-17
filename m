Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63C3631DC1A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Feb 2021 16:26:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230354AbhBQPXf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Feb 2021 10:23:35 -0500
Received: from z11.mailgun.us ([104.130.96.11]:64062 "EHLO z11.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233539AbhBQPTv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Feb 2021 10:19:51 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1613575167; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=MB1xt0p4slOEmh+2v55474jFBlsMaNDqj0+2lVtrvKs=; b=HHAjnWlVHAFuVRwKtFLVHWO8xvES9oQwDN+NepgayAIkTqKHAcOnJfLTBysbrvywGE2F1gZR
 RdkDoBrEziewFopovrSgNnXnbPVnlVs0zlBtop0396Ooyxa8TzudsG8TGCfZrOPgm/cpXCZu
 Hk3J9IHSH7pa+wLlVwPerHkMdx4=
X-Mailgun-Sending-Ip: 104.130.96.11
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-west-2.postgun.com with SMTP id
 602d310a98fd902dc27373e0 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 17 Feb 2021 15:06:50
 GMT
Sender: jhugo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id E47ADC43461; Wed, 17 Feb 2021 15:06:49 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        NICE_REPLY_A,SPF_FAIL autolearn=no autolearn_force=no version=3.4.0
Received: from [10.226.59.216] (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jhugo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B41B1C433CA;
        Wed, 17 Feb 2021 15:06:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B41B1C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=jhugo@codeaurora.org
Subject: Re: [PATCH] mhi_bus: core: Return EBUSY if MHI ring is full
To:     Loic Poulain <loic.poulain@linaro.org>
Cc:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Hemant Kumar <hemantk@codeaurora.org>,
        Bhaumik Bhatt <bbhatt@codeaurora.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Fan Wu <wufan@codeaurora.org>
References: <1613501314-2392-1-git-send-email-jhugo@codeaurora.org>
 <CAMZdPi9S5OnWs_QFnf+xVM+jLve6cpdvi_vpC_KdEbUUaqoFYg@mail.gmail.com>
From:   Jeffrey Hugo <jhugo@codeaurora.org>
Message-ID: <eb873085-4120-7ec4-1f18-1c768ed741bd@codeaurora.org>
Date:   Wed, 17 Feb 2021 08:06:48 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <CAMZdPi9S5OnWs_QFnf+xVM+jLve6cpdvi_vpC_KdEbUUaqoFYg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/17/2021 8:02 AM, Loic Poulain wrote:
> On Tue, 16 Feb 2021 at 19:50, Jeffrey Hugo <jhugo@codeaurora.org> wrote:
>>
>> From: Fan Wu <wufan@codeaurora.org>
>>
>> Currently ENOMEM is returned when MHI ring is full. This error code is
>> very misleading. Change to EBUSY instead.
> 
> Well, there is no space left in the ring, so it's no so misleading.

ENOMEM is typically a memory allocation failure which is not what a 
client is going to think of regarding the ring, and it's not a unique 
failure code in this case.  gen_tre can also return ENOMEM, which makes 
it difficult for the client to know if there is some significant 
failure, or they might just need to wait (assuming that is something the 
client can do).

-- 
Jeffrey Hugo
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
