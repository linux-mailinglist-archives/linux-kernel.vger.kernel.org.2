Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF22B4004E3
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 20:31:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235927AbhICScV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 14:32:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235865AbhICScP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 14:32:15 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89544C061757
        for <linux-kernel@vger.kernel.org>; Fri,  3 Sep 2021 11:31:14 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id s3so188374ljp.11
        for <linux-kernel@vger.kernel.org>; Fri, 03 Sep 2021 11:31:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=kUpYrB6LA+X1EG7mZxbWQs5iImpyPUWVUxzm2ewn4VY=;
        b=z4ccfB5hb3hkvqLtFWhuflOfpiz8mo7jpdJ2jFD2SuzoME2QUD1YOlmAIMeZweGFnc
         GmqGEsWb4I06ZwK3Ecmc/L3QI3kD8jpbkXl/P+E/eDtu/fqcHSKnNd0KtIsiJyGLtkfu
         qzD9re9bSd2DVPTLnNxILBYeRMZ1wLTQFFJOzM3QED5PQCwhg9ua4MU397g/N70Dc+rZ
         RuusNtBT79ZAj8T09p1lGHunudIt+2pz9qY+W38ERNLWL7N59esF4sFq1dKpzZS8OuFg
         fnQh9VOzd5Ngodp36ogRU7wCMqjS5Q4T+snPD8MQK7YudtiXf0Cy7m5muLG5l9gojPEA
         YxAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kUpYrB6LA+X1EG7mZxbWQs5iImpyPUWVUxzm2ewn4VY=;
        b=IChC/Lx0SesW5SAldeV29LjBBGgl0S1zqJhDiaMHNbvWVQ/+LBRhXwe6xSYx3gTnOK
         FNf8VujpeORmImUI1sA72DQOGanTeWqw2PYsUGwNZQJUQ9t14XxjUyMkI6ByWkFGW8DW
         zKDBdLZNnvUbx4Z70c60f0pZkF6Lh5Yo24PafA+F6tBlmRBt6Lgg3Y3bPkFz6zgZiNfR
         IoQ/dbEi8pDc1nN8s0raMxaBrVR4pKBOZ0o39d8imrT7w4ShZ2CkSohCX65gR2tyFLEu
         UtbDSm/dqaIdwHX/UzEgzAm5MzaXPVprM7Z69EfUONdKY7kxdYOzjOxrUUqTa9dBjFEH
         U5cA==
X-Gm-Message-State: AOAM530dH/R6zlmPU6st+d3u40zXTuXL/DMpW6I/i76lQsqjZYUwRc4l
        B+OnQ4zwc3/5HT8HAZHVI4tqtA==
X-Google-Smtp-Source: ABdhPJzKLREu9lV2YGYPyO/peIQHRIZ9atO6bBDf5sKEpxHDJlUgqDVXsncsW/ACQqpKoCT/1TE8gg==
X-Received: by 2002:a2e:a903:: with SMTP id j3mr256630ljq.347.1630693872515;
        Fri, 03 Sep 2021 11:31:12 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id h13sm18825lfv.62.2021.09.03.11.31.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Sep 2021 11:31:12 -0700 (PDT)
Subject: Re: [PATCH] drm/msm: remove unneeded variable
To:     Lyude Paul <lyude@redhat.com>, cgel.zte@gmail.com,
        robdclark@gmail.com
Cc:     sean@poorly.run, airlied@linux.ie, daniel@ffwll.ch,
        airlied@redhat.com, laurent.pinchart@ideasonboard.com,
        chi.minghao@zte.com.cn, treding@nvidia.com,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Zeal Robot <zealci@zte.com.cn>
References: <20210831115127.18236-1-chi.minghao@zte.com.cn>
 <2d6784e3327cab7bfdc88ca1ef7c9c4c9cca113a.camel@redhat.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Message-ID: <52a6c92d-fe59-cdb8-23de-6fcda6ca2c68@linaro.org>
Date:   Fri, 3 Sep 2021 21:31:11 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <2d6784e3327cab7bfdc88ca1ef7c9c4c9cca113a.camel@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/09/2021 21:40, Lyude Paul wrote:
> Reviewed-by: Lyude Paul <lyude@redhat.com>
> 
> Do you need me to push this?

We'd pick this up through the msm tree.

> 
> On Tue, 2021-08-31 at 04:51 -0700, cgel.zte@gmail.com wrote:
>> From: Chi Minghao <chi.minghao@zte.com.cn>
>>
>> Fix the following coccicheck REVIEW:
>> ./drivers/gpu/drm/msm/edp/edp_ctrl.c:1245:5-8 Unneeded variable
>>
>> Reported-by: Zeal Robot <zealci@zte.com.cn>
>> Signed-off-by: Chi Minghao <chi.minghao@zte.com.cn>
>> ---
>>   drivers/gpu/drm/msm/edp/edp_ctrl.c | 4 +---
>>   1 file changed, 1 insertion(+), 3 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/msm/edp/edp_ctrl.c
>> b/drivers/gpu/drm/msm/edp/edp_ctrl.c
>> index 4fb397ee7c84..3610e26e62fa 100644
>> --- a/drivers/gpu/drm/msm/edp/edp_ctrl.c
>> +++ b/drivers/gpu/drm/msm/edp/edp_ctrl.c
>> @@ -1242,8 +1242,6 @@ bool msm_edp_ctrl_panel_connected(struct edp_ctrl
>> *ctrl)
>>   int msm_edp_ctrl_get_panel_info(struct edp_ctrl *ctrl,
>>                  struct drm_connector *connector, struct edid **edid)
>>   {
>> -       int ret = 0;
>> -
>>          mutex_lock(&ctrl->dev_mutex);
>>   
>>          if (ctrl->edid) {
>> @@ -1278,7 +1276,7 @@ int msm_edp_ctrl_get_panel_info(struct edp_ctrl *ctrl,
>>          }
>>   unlock_ret:
>>          mutex_unlock(&ctrl->dev_mutex);
>> -       return ret;
>> +       return 0;
>>   }
>>   
>>   int msm_edp_ctrl_timing_cfg(struct edp_ctrl *ctrl,
> 


-- 
With best wishes
Dmitry
