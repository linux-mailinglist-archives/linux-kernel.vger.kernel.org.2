Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 654D2316EB5
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 19:32:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233711AbhBJScI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 13:32:08 -0500
Received: from so15.mailgun.net ([198.61.254.15]:22019 "EHLO so15.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233972AbhBJSWx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 13:22:53 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1612981306; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=Xgep1GQsNHDLMCt3NLrLgJj9OuM/EEgROVw7Ki9LSR8=; b=l8Joshn9LevgmG+Xo2hbjMp+8lJFCu6wf5DpETiFDEREtAypemZuL1nTRl/5LX+/6MElYZ1d
 QoGGocUOL45xo/F/845uAUSp5lXARuzKzX8iGp/oM8KOrUG/kANm9nv4M4Y/iu54BOEdYDni
 B/6qxWo6E9rcYhrlqituabqqEOw=
X-Mailgun-Sending-Ip: 198.61.254.15
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-west-2.postgun.com with SMTP id
 6024241af112b7872cd73096 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 10 Feb 2021 18:21:14
 GMT
Sender: tdas=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 7AB9DC433C6; Wed, 10 Feb 2021 18:21:14 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        NICE_REPLY_A,SPF_FAIL autolearn=no autolearn_force=no version=3.4.0
Received: from [192.168.0.106] (unknown [49.204.180.139])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tdas)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C7BA8C433ED;
        Wed, 10 Feb 2021 18:21:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C7BA8C433ED
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=tdas@codeaurora.org
Subject: Re: [PATCH v1 1/2] dt-bindings: clock: Add SC7280 GCC clock binding
To:     Rob Herring <robh@kernel.org>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <1608058114-29025-1-git-send-email-tdas@codeaurora.org>
 <1608058114-29025-2-git-send-email-tdas@codeaurora.org>
 <20201221190005.GA362734@robh.at.kernel.org>
From:   Taniya Das <tdas@codeaurora.org>
Message-ID: <d6d45024-36c5-4f98-774d-2355ab4fceaa@codeaurora.org>
Date:   Wed, 10 Feb 2021 23:51:07 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20201221190005.GA362734@robh.at.kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Rob for your review comments.


>> diff --git a/include/dt-bindings/clock/qcom,gcc-sc7280.h b/include/dt-bindings/clock/qcom,gcc-sc7280.h
>> new file mode 100644
>> index 0000000..3295bd4
>> --- /dev/null
>> +++ b/include/dt-bindings/clock/qcom,gcc-sc7280.h
>> @@ -0,0 +1,215 @@
>> +/* SPDX-License-Identifier: GPL-2.0-only */
> 
> Don't care about non-GPL OS? Better ask your legal dept.
> 

Currently this is the recommendation from the legal dept.

>> +/*
>> + * Copyright (c) 2020, The Linux Foundation. All rights reserved.
>> + */
>> +
>> +#ifndef _DT_BINDINGS_CLK_QCOM_GCC_SC7280_H
>> +#define _DT_BINDINGS_CLK_QCOM_GCC_SC7280_H
>> +
>> +/* GCC clocks */

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation.

--
