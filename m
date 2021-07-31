Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F08C33DC249
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Jul 2021 03:21:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234459AbhGaBVr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 21:21:47 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:36462 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231337AbhGaBVq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 21:21:46 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1627694501; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=dpCNWc0mDdu93AS5rMx75tLmuBftQanB+P4HwbB9glo=;
 b=Cr4w9pMiSGmI4QCubWlQmCJ6y0/Tt3bjhe1SW34+8r1mVeyauNLZKTNmKS9N0vH1A3Xb6Q9c
 lRWlm0a2P+zx5gQ6xWJCXfjbuEuaOvmgyme0S/+QspsHxRW9ePPmnOxoVklVfqDmel+NFLfd
 5sI1a2b9yVl03OHSrVHukaUTPRY=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-west-2.postgun.com with SMTP id
 6104a5a3e31d882d1818dd90 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Sat, 31 Jul 2021 01:21:39
 GMT
Sender: abhinavk=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 25CB8C4338A; Sat, 31 Jul 2021 01:21:39 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: abhinavk)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 97AACC433D3;
        Sat, 31 Jul 2021 01:21:37 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 30 Jul 2021 18:21:37 -0700
From:   abhinavk@codeaurora.org
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Kalyan Thota <kalyan_t@codeaurora.org>,
        Kuogee Hsieh <khsieh@codeaurora.org>,
        Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] drm/msm/dp: Support multiple DP instances and add
 sc8180x
In-Reply-To: <20210725042436.3967173-1-bjorn.andersson@linaro.org>
References: <20210725042436.3967173-1-bjorn.andersson@linaro.org>
Message-ID: <b9d0a85574230042940c7221dcf48ccf@codeaurora.org>
X-Sender: abhinavk@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bjorn

On 2021-07-24 21:24, Bjorn Andersson wrote:
> The current implementation supports a single DP instance and the DPU 
> code will
> only match it against INTF_DP instance 0. These patches extends this to 
> allow
> multiple DP instances and support for matching against DP instances 
> beyond 0.
> 
> This is based on v4 of Dmitry's work on multiple DSI interfaces:
> https://lore.kernel.org/linux-arm-msm/20210717124016.316020-1-dmitry.baryshkov@linaro.org/
> 
> With that in place add SC8180x DP and eDP controllers.

Thanks for posting the changes.

I dont have major concerns on the series as such apart from minor 
comments which i will post in a day or two
but I will check and get back if this has been validated on sc7280 
without any concerns.

One question i had is not directly related to this series but related to 
multi-DP in general.
Does audio work fine across both the DPs when both are connected?

The reason I ask this question is that, I dont know how two hdmi-codec 
instances are handled today.
So we will register twice with hdmi-codec so there should be two audio 
streams.

But I am not sure if this works correctly in todays design with 
hdmi-codec.

Any chance you had validated this?

> 
> Bjorn Andersson (5):
>   drm/msm/dp: Remove global g_dp_display variable
>   drm/msm/dp: Modify prototype of encoder based API
>   drm/msm/dp: Support up to 3 DP controllers
>   dt-bindings: msm/dp: Add SC8180x compatibles
>   drm/msm/dp: Add sc8180x DP controllers
> 
>  .../bindings/display/msm/dp-controller.yaml   |   2 +
>  drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c   |  17 +-
>  drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c       |  60 +++---
>  .../gpu/drm/msm/disp/msm_disp_snapshot_util.c |   8 +-
>  drivers/gpu/drm/msm/dp/dp_display.c           | 183 +++++++++++++-----
>  drivers/gpu/drm/msm/msm_drv.h                 |  33 ++--
>  6 files changed, 200 insertions(+), 103 deletions(-)
