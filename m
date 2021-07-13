Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02D3C3C68C8
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 05:01:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233609AbhGMDEM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jul 2021 23:04:12 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:15251 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230324AbhGMDEM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jul 2021 23:04:12 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1626145283; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=HB7jBeoN0dr1qnyamHbemyhTM6XR1B1zi7zhzexijIU=; b=KDQTCdNObUxYIhikP0VfsgHuoPjRxhyF0U8SJiK449XmAL182SBiYJDxyir3HwKzhNne5YXw
 94m4jN+1ESaVtDUUrm2rVdZVUKDwp3UYRMyzJCaR+bQwBzO3SqCmudA/0gNHDKT111liPSNr
 MoinNWysa7aVb5PTggYtD1Zs0ko=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-east-1.postgun.com with SMTP id
 60ed01de5e3e57240b0816cf (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 13 Jul 2021 03:00:46
 GMT
Sender: tdas=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id A4F52C433F1; Tue, 13 Jul 2021 03:00:45 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        NICE_REPLY_A,SPF_FAIL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from [192.168.0.100] (unknown [49.204.181.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tdas)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 09413C433D3;
        Tue, 13 Jul 2021 03:00:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 09413C433D3
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=tdas@codeaurora.org
Subject: Re: [PATCH v2 6/6] clk: qcom: Add video clock controller driver for
 SC7280
To:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     Rajendra Nayak <rnayak@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, robh@kernel.org, robh+dt@kernel.org
References: <1619519590-3019-1-git-send-email-tdas@codeaurora.org>
 <1619519590-3019-7-git-send-email-tdas@codeaurora.org>
 <162261760498.4130789.12499425999582046146@swboyd.mtv.corp.google.com>
From:   Taniya Das <tdas@codeaurora.org>
Message-ID: <bd275558-5280-23d5-33b6-88746588e336@codeaurora.org>
Date:   Tue, 13 Jul 2021 08:30:39 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <162261760498.4130789.12499425999582046146@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Stephen,

Thanks for your review.

On 6/2/2021 12:36 PM, Stephen Boyd wrote:
> Quoting Taniya Das (2021-04-27 03:33:10)
>> diff --git a/drivers/clk/qcom/videocc-sc7280.c b/drivers/clk/qcom/videocc-sc7280.c
>> new file mode 100644
>> index 0000000..3387154
>> --- /dev/null
>> +++ b/drivers/clk/qcom/videocc-sc7280.c
>> @@ -0,0 +1,372 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * Copyright (c) 2021, The Linux Foundation. All rights reserved.
>> + */
>> +
>> +#include <linux/clk-provider.h>
>> +#include <linux/module.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/regmap.h>
>> +
>> +#include <dt-bindings/clock/qcom,videocc-sc7280.h>
>> +
>> +#include "clk-alpha-pll.h"
>> +#include "clk-branch.h"
>> +#include "clk-rcg.h"
>> +#include "common.h"
>> +#include "reset.h"
>> +#include "gdsc.h"
>> +
>> +enum {
>> +       P_BI_TCXO,
>> +       P_SLEEP_CLK,
>> +       P_VIDEO_PLL0_OUT_EVEN,
>> +};
>> +
>> +static struct pll_vco lucid_vco[] = {
> 
> const?
> 

Yes, next patch will have this updated.

>> +       { 249600000, 2000000000, 0 },
>> +};
>> +
> [...]
>> +
>> +static const struct parent_map video_cc_parent_map_0[] = {
>> +       { P_BI_TCXO, 0 },
>> +       { P_VIDEO_PLL0_OUT_EVEN, 3 },
>> +};
>> +
>> +static const struct clk_parent_data video_cc_parent_data_0[] = {
>> +       { .fw_name = "bi_tcxo" },
>> +       { .hw = &video_pll0.clkr.hw },
>> +};
>> +
>> +static const struct parent_map video_cc_parent_map_1[] = {
>> +       { P_SLEEP_CLK, 0 },
>> +};
>> +
>> +static const struct clk_parent_data video_cc_parent_data_1[] = {
>> +       { .fw_name = "sleep_clk" },
>> +};
>> +
>> +static const struct parent_map video_cc_parent_map_2[] = {
>> +       { P_BI_TCXO, 0 },
>> +};
>> +
>> +static const struct clk_parent_data video_cc_parent_data_2_ao[] = {
>> +       { .fw_name = "bi_tcxo_ao" },
> 
> This is new. Why would we want the video clk parent state to turn off
> when the CPU is off? Does the video engine keep XO enabled for itself?
> Can you please add some comment into the code explaining why it's ok to
> use the ao clk here?
> 

This clock is from HW design is enabled, thus our generation scripts 
have marked it to _ao. But I will be removing this in the next patch as 
it is not required to be modelled.

>> +};
>> +
>> +static const struct freq_tbl ftbl_video_cc_iris_clk_src[] = {
>> +       F(133333333, P_VIDEO_PLL0_OUT_EVEN, 3, 0, 0),
>> +       F(240000000, P_VIDEO_PLL0_OUT_EVEN, 2, 0, 0),
>> +       F(335000000, P_VIDEO_PLL0_OUT_EVEN, 2, 0, 0),
>> +       F(424000000, P_VIDEO_PLL0_OUT_EVEN, 2, 0, 0),
>> +       F(460000000, P_VIDEO_PLL0_OUT_EVEN, 2, 0, 0),
>> +       { }
>> +};
> [...]
>> +
>> +static struct clk_branch video_cc_xo_clk = {
>> +       .halt_reg = 0x7018,
>> +       .halt_check = BRANCH_HALT,
>> +       .clkr = {
>> +               .enable_reg = 0x7018,
>> +               .enable_mask = BIT(0),
>> +               .hw.init = &(struct clk_init_data){
>> +                       .name = "video_cc_xo_clk",
>> +                       .parent_hws = (const struct clk_hw*[]){
>> +                               &video_cc_xo_clk_src.clkr.hw,
>> +                       },
>> +                       .num_parents = 1,
>> +                       .flags = CLK_IS_CRITICAL | CLK_SET_RATE_PARENT,
> 
> Please add a comment why it is critical.
> 

Next patch will remove this clock. As it is already enabled from HW, 
will not model the clock to not disable it from SW.

>> +                       .ops = &clk_branch2_ops,
>> +               },
>> +       },
>> +};
>> +

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation.

--
