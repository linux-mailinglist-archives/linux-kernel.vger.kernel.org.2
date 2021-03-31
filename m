Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59A27350531
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 19:02:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234182AbhCaRBo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 13:01:44 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:24894 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbhCaRBI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 13:01:08 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1617210066; h=Message-ID: References: In-Reply-To: Reply-To:
 Subject: Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=luXWFbhobJVfLtmEd8Rj4gUfk+q4LQMoS+mWmZpxdgA=;
 b=ZvKP1nFymvmoxUz0tD/4qRRZrsbH1e2aBLz2q5TF+CBGTlsQlP2QZQqis6k8JCiDjafOE1zG
 g9tH6ukm6X9tpidx8kjkMHQD86wVeD681YVCBi6TgNXRD7niIaSnE4/hJLNPOjbKD628GKeX
 xMAQebQT+RItsACQMFIGM5NgMiQ=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-west-2.postgun.com with SMTP id
 6064aad1e0e9c9a6b693eebe (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 31 Mar 2021 17:01:05
 GMT
Sender: bbhatt=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 5EE7AC433ED; Wed, 31 Mar 2021 17:01:05 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbhatt)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 9D642C433C6;
        Wed, 31 Mar 2021 17:01:04 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 31 Mar 2021 10:01:04 -0700
From:   Bhaumik Bhatt <bbhatt@codeaurora.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, hemantk@codeaurora.org,
        jhugo@codeaurora.org, linux-kernel@vger.kernel.org,
        carl.yin@quectel.com, naveen.kumar@quectel.com,
        loic.poulain@linaro.org, abickett@codeaurora.org
Subject: Re: [PATCH v1 0/7] MHI Emergency download and flash programmer
 support
Organization: Qualcomm Innovation Center, Inc.
Reply-To: bbhatt@codeaurora.org
Mail-Reply-To: bbhatt@codeaurora.org
In-Reply-To: <20210331111644.GE15610@work>
References: <1617067704-28850-1-git-send-email-bbhatt@codeaurora.org>
 <20210331111644.GE15610@work>
Message-ID: <6fcd439aa759d8cbc9bab1862d1d9a57@codeaurora.org>
X-Sender: bbhatt@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mani,
On 2021-03-31 04:16 AM, Manivannan Sadhasivam wrote:
> On Mon, Mar 29, 2021 at 06:28:17PM -0700, Bhaumik Bhatt wrote:
>> Allow handling EDL mode after SYS_ERROR occurs by reading the 
>> execution
>> environment post handling and move to power on reset state to 
>> accommodate the
>> scenario.
>> Handle EDL mode properly and wait for ready instead of just exiting 
>> from the
>> firmware load.
>> Allow use of the Flash Programmer execution environment as a mission 
>> mode
>> use case for a blank NAND power up scenario.
>> Always attempt a wait for MHI ready state as device could be waiting 
>> for the
>> host to do so after pass through execution environment is seen.
>> Introduce patch to improve state awareness and aid in debugging.
>> 
>> This patch series was tested on x86_64 architecture.
>> 
> 
> These patches were part of a different series before. It is good that
> you splitted the patches but you should mention that here.
> 
> Thanks,
> Mani
> 
I will keep that in mind when submitting next time.

>> Bhaumik Bhatt (6):
>>   bus: mhi: core: Rely on accurate method to determine EDL mode
>>   bus: mhi: core: Wait for ready after an EDL firmware download
>>   bus: mhi: core: Handle EDL mode entry appropriately
>>   bus: mhi: core: Identify Flash Programmer as a mission mode use case
>>   bus: mhi: core: Wait for MHI READY state in most scenarios
>>   bus: mhi: core: Improve state strings for debug messages
>> 
>> Carl Yin (1):
>>   bus: mhi: core: Add support for Flash Programmer execution 
>> environment
>> 
>>  drivers/bus/mhi/core/boot.c     | 13 +++++++------
>>  drivers/bus/mhi/core/init.c     | 34 
>> ++++++++++++++++++----------------
>>  drivers/bus/mhi/core/internal.h |  4 +++-
>>  drivers/bus/mhi/core/main.c     |  3 +++
>>  drivers/bus/mhi/core/pm.c       | 28 +++++++++++++++++++++++++---
>>  include/linux/mhi.h             |  4 +++-
>>  6 files changed, 59 insertions(+), 27 deletions(-)
>> 
>> --
>> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora 
>> Forum,
>> a Linux Foundation Collaborative Project
>> 

Thanks,
Bhaumik
---
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora 
Forum,
a Linux Foundation Collaborative Project
