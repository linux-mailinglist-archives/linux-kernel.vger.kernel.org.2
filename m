Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D714310121
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 00:54:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231383AbhBDXxt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 18:53:49 -0500
Received: from mail29.static.mailgun.info ([104.130.122.29]:13993 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231320AbhBDXxr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 18:53:47 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1612482807; h=Message-ID: References: In-Reply-To: Reply-To:
 Subject: Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=uGT+mmLcNimmrF5O0goRR8yE0/KU/5rkdgh5w5fKbJg=;
 b=Kwx77i8amVguSgWUwzDhX1IbZuCIcS4YXUqW17lD4WuEUeQLh5CVGhTKwR8EQBXuorZs8y1u
 jHKPjwsAYcEF9Y6iiGY+unDPbaFvMTJpssz5pbApgP0VNCO3xeMzzQ7voJtjEGcxlFMQuuKq
 6jV7i6zMQFIayPwgk2Af4UH/Zok=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-east-1.postgun.com with SMTP id
 601c88d35d0f3847870441fd (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 04 Feb 2021 23:52:51
 GMT
Sender: bbhatt=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 3CF2CC43462; Thu,  4 Feb 2021 23:52:50 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbhatt)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A0088C433C6;
        Thu,  4 Feb 2021 23:52:49 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 04 Feb 2021 15:52:49 -0800
From:   Bhaumik Bhatt <bbhatt@codeaurora.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, hemantk@codeaurora.org,
        carl.yin@quectel.com, naveen.kumar@quectel.com,
        jhugo@codeaurora.org, linux-kernel@vger.kernel.org,
        loic.poulain@linaro.org
Subject: Re: [PATCH v2 1/3] bus: mhi: core: Clear devices when moving
 execution environments
Organization: Qualcomm Innovation Center, Inc.
Reply-To: bbhatt@codeaurora.org
Mail-Reply-To: bbhatt@codeaurora.org
In-Reply-To: <20210121075022.GA30041@thinkpad>
References: <1610651795-31287-1-git-send-email-bbhatt@codeaurora.org>
 <1610651795-31287-2-git-send-email-bbhatt@codeaurora.org>
 <20210121075022.GA30041@thinkpad>
Message-ID: <fb1246c0bbc2ebef6ef97f2645d3a741@codeaurora.org>
X-Sender: bbhatt@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mani,

On 2021-01-20 11:50 PM, Manivannan Sadhasivam wrote:
> On Thu, Jan 14, 2021 at 11:16:33AM -0800, Bhaumik Bhatt wrote:
>> When moving from SBL to mission mode execution environment, there
>> is no remove callback notification to MHI client drivers which
>> operate on SBL mode only. Client driver devices are being created
>> in SBL or AMSS(mission mode) and only destroyed after power down
>> or SYS_ERROR. If there exist any SBL-specific channels, those are
>> left open and client drivers are thus unaware of the new execution
>> environment where those channels cannot operate. Close the gap and
>> issue remove callbacks to SBL-specific client drivers once device
>> enters mission mode.
>> 
> 
> What are the SBL specific channels and the client drivers operating on 
> them?
> If this is something going to come in future, then this patch can come 
> later.
> 
> Thanks,
> Mani

Carl from Quectel (CC'd here) will need this patch as he works on EDL 
and Flash
Programmer changes which also needs usage of QSAHARA server over SBL.

Thanks,
Bhaumik
---
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora 
Forum,
a Linux Foundation Collaborative Project
