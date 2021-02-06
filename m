Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A284F311A71
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Feb 2021 04:48:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231657AbhBFDr1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 22:47:27 -0500
Received: from mail29.static.mailgun.info ([104.130.122.29]:58724 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229690AbhBFCrf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 21:47:35 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1612579620; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=YCO3A4nbifS+88eVDGVj45VVWBGNfR5wxgkvk0/07Xc=; b=fSCPQJub5yP7zj5GtpEvTA9zsUpkuyiLQaO66f2AbshkyvQP4cDhaoxuVcjBN5RuXl/AqNbo
 wFgoiQdX7wUhSpPq4RMy3lsOggXCYwkEpBT+dQuPW2870cHK1NfOxxxltcc1wigMigYGebiU
 sEj6hQcF9/FZBzX5n3J6REkFlq4=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-west-2.postgun.com with SMTP id
 601dcad0f112b7872cb1c441 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 05 Feb 2021 22:46:40
 GMT
Sender: hemantk=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 3C97EC43462; Fri,  5 Feb 2021 22:46:40 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.2 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        NICE_REPLY_A,SPF_FAIL,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.0
Received: from [10.46.162.249] (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: hemantk)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 8673BC433C6;
        Fri,  5 Feb 2021 22:46:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8673BC433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=hemantk@codeaurora.org
Subject: Re: [PATCH v6 8/8] bus: mhi: core: Do not clear channel context more
 than once
To:     Bhaumik Bhatt <bbhatt@codeaurora.org>,
        manivannan.sadhasivam@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, jhugo@codeaurora.org,
        linux-kernel@vger.kernel.org, loic.poulain@linaro.org
References: <1612470486-10440-1-git-send-email-bbhatt@codeaurora.org>
 <1612470486-10440-9-git-send-email-bbhatt@codeaurora.org>
From:   Hemant Kumar <hemantk@codeaurora.org>
Message-ID: <3d1171bd-407b-f644-bbd1-bd6cb8769c18@codeaurora.org>
Date:   Fri, 5 Feb 2021 14:46:39 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1612470486-10440-9-git-send-email-bbhatt@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/4/21 12:28 PM, Bhaumik Bhatt wrote:
> Clearing a channel context can happen twice if the client driver
> unprepares and reset the channels from the remove() callback from
> a controller requested MHI power down sequence. If there are
> multiple attempts at calling the mhi_free_coherent() API, we see
> kernel warnings such as "trying to free invalid coherent area".
> Example for one such client is the QRTR MHI driver. Avoid these
> warnings by skipping mhi_deinit_chan_ctxt() API call and prevent
> extra work from MHI as the channels are already disabled.
> 
> Signed-off-by: Bhaumik Bhatt <bbhatt@codeaurora.org>

Reviewed-by: Hemant Kumar <hemantk@codeaurora.org>
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
