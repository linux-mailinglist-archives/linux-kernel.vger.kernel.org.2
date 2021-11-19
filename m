Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6C84457422
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Nov 2021 17:54:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235889AbhKSQ5R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Nov 2021 11:57:17 -0500
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:26224 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229519AbhKSQ5Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Nov 2021 11:57:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1637340855; x=1668876855;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=6DEP3t+XDa5WlLRSEM3s6XOjAWqLN52Ye0b4lfzBcLs=;
  b=Y6/KnjawI4abBc8lx0+V4O73gHRcPJuS64sMnFiipuSn/vifAZlUY+R8
   NHL5atCW2B23/y0tkzGC4h+rrOHK3vADEkXhrr6dua0u/4TfeBrUK5kvD
   F3rudFuReTbDnjPeOip2eYsO6qMPdoI6rPLzcqBp76m89C2O6xZOI/7r4
   E=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 19 Nov 2021 08:54:15 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg01-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2021 08:54:14 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Fri, 19 Nov 2021 08:54:14 -0800
Received: from [10.110.5.170] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.19; Fri, 19 Nov
 2021 08:54:13 -0800
Message-ID: <7b54e2fb-1268-9d66-8b6a-4be247ff9bc1@quicinc.com>
Date:   Fri, 19 Nov 2021 08:54:12 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH v4] drm/msm/dp: do not initialize phy until plugin
 interrupt received
Content-Language: en-US
To:     Stephen Boyd <swboyd@chromium.org>, <agross@kernel.org>,
        <airlied@linux.ie>, <bjorn.andersson@linaro.org>,
        <daniel@ffwll.ch>, <dmitry.baryshkov@linaro.org>,
        <robdclark@gmail.com>, <sean@poorly.run>, <vkoul@kernel.org>
CC:     <quic_abhinavk@quicinc.com>, <aravindh@codeaurora.org>,
        <freedreno@lists.freedesktop.org>,
        <dri-devel@lists.freedesktop.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Kuogee Hsieh <khsieh@codeaurora.org>
References: <1636493893-7600-1-git-send-email-quic_khsieh@quicinc.com>
 <CAE-0n505-VcS46WnVARsvuaizePP-3cYEw_rfipfq9Yj7AW=Ow@mail.gmail.com>
From:   Kuogee Hsieh <quic_khsieh@quicinc.com>
In-Reply-To: <CAE-0n505-VcS46WnVARsvuaizePP-3cYEw_rfipfq9Yj7AW=Ow@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/18/2021 5:20 PM, Stephen Boyd wrote:
> Quoting Kuogee Hsieh (2021-11-09 13:38:13)
>> From: Kuogee Hsieh <khsieh@codeaurora.org>
>>
>> Current DP drivers have regulators, clocks, irq and phy are grouped
>> together within a function and executed not in a symmetric manner.
>> This increase difficulty of code maintenance and limited code scalability.
>> This patch divided the driver life cycle of operation into four states,
>> resume (including booting up), dongle plugin, dongle unplugged and suspend.
>> Regulators, core clocks and irq are grouped together and enabled at resume
>> (or booting up) so that the DP controller is armed and ready to receive HPD
>> plugin interrupts. HPD plugin interrupt is generated when a dongle plugs
>> into DUT (device under test). Once HPD plugin interrupt is received, DP
>> controller will initialize phy so that dpcd read/write will function and
>> following link training can be proceeded successfully. DP phy will be
>> disabled after main link is teared down at end of unplugged HPD interrupt
>> handle triggered by dongle unplugged out of DUT. Finally regulators, code
>> clocks and irq are disabled at corresponding suspension.
>>
>> Changes in V2:
>> -- removed unnecessary dp_ctrl NULL check
>> -- removed unnecessary phy init_count and power_count DRM_DEBUG_DP logs
>> -- remove flip parameter out of dp_ctrl_irq_enable()
>> -- add fixes tag
>>
>> Changes in V3:
>> -- call dp_display_host_phy_init() instead of dp_ctrl_phy_init() at
>>          dp_display_host_init() for eDP
>>
>> Changes in V4:
>> -- rewording commit text to match this commit changes
>>
>> Fixes: e91e3065a806 ("drm/msm/dp: Add DP compliance tests on Snapdragon Chipsets")
>>
>> Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
>> ---
> What commit is this patch based on?

It base on Bjorn's patch,

https://patchwork.freedesktop.org/series/92992/


