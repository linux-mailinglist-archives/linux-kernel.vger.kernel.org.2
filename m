Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88CB2457C50
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Nov 2021 08:49:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232401AbhKTHv6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Nov 2021 02:51:58 -0500
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:12792 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230196AbhKTHvy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Nov 2021 02:51:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1637394532; x=1668930532;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=1ibJOyP4jJT4y0c81VAvgOeXbtAdjj1j0sCkGyFJanI=;
  b=dypP9bg9uv37/120k8EqUyQJzH6GUORqcL/xsqBBKrtaFftpYmPwVCdf
   tcB7VXY6o3fiO18rtiB3RvhSR77xCNHCXcT/vZO4xKUuCYkr/cz6WZAAM
   XVFnU4o2MEQm04EPQL+8gsfyO7aFE89QHcYrMydID+3J3/xIppHdVPcZs
   s=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 19 Nov 2021 23:48:51 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2021 23:48:51 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Fri, 19 Nov 2021 23:48:51 -0800
Received: from [10.38.245.239] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.19; Fri, 19 Nov
 2021 23:48:48 -0800
Message-ID: <f587191c-dd08-1b00-3f1a-a123b6747ac8@quicinc.com>
Date:   Fri, 19 Nov 2021 23:48:46 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH] MAINTAINERS: update designated reviewer entry for MSM DRM
 driver
Content-Language: en-US
To:     Joe Perches <joe@perches.com>, <linux-kernel@vger.kernel.org>
CC:     <freedreno@lists.freedesktop.org>, <gregkh@linuxfoundation.org>,
        <robdclark@gmail.com>, <seanpaul@chromium.org>,
        <swboyd@chromium.org>, <nganji@codeaurora.org>,
        <aravindh@codeaurora.org>, <dmitry.baryshkov@linaro.org>,
        <daniel@ffwll.ch>
References: <1637363916-18257-1-git-send-email-quic_abhinavk@quicinc.com>
 <a14da924805afdc39d7df800d3d4b7dc81c3dbf1.camel@perches.com>
From:   Abhinav Kumar <quic_abhinavk@quicinc.com>
In-Reply-To: <a14da924805afdc39d7df800d3d4b7dc81c3dbf1.camel@perches.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joe

Thanks for the feedback.

On 11/19/2021 7:34 PM, Joe Perches wrote:
> On Fri, 2021-11-19 at 15:18 -0800, Abhinav Kumar wrote:
>> Adding myself as a designated reviewer to assist with the
>> code reviews for the changes coming into MSM DRM.
>>
>> Acked-by: Rob Clark <robdclark@gmail.com>
>> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> []
>> diff --git a/MAINTAINERS b/MAINTAINERS
> []
>> @@ -5938,6 +5938,7 @@ M:	Sean Paul <sean@poorly.run>
>>   L:	linux-arm-msm@vger.kernel.org
>>   L:	dri-devel@lists.freedesktop.org
>>   L:	freedreno@lists.freedesktop.org
>> +R:	Abhinav Kumar <quic_abhinavk@quicinc.com>
>>   S:	Maintained
>>   T:	git https://gitlab.freedesktop.org/drm/msm.git
>>   F:	Documentation/devicetree/bindings/display/msm/
> 
> R: goes after M: not L:
> 
I have fixed this and pushed it again.
> 

Thanks

Abhinav
