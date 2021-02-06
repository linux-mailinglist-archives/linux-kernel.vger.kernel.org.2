Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4093311B54
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Feb 2021 06:08:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230392AbhBFFIU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Feb 2021 00:08:20 -0500
Received: from so15.mailgun.net ([198.61.254.15]:33176 "EHLO so15.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229514AbhBFEFl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 23:05:41 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1612584301; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=+/uIP87vJEaaYUqbVLHKGTP87A5yWxtIFnA2Yl8Y65Y=;
 b=EmR4lKM/lKbkPan33De+lM8xbMvF06SVf+ij4fRSR7xiLH2dRYSxHjbp+4Vi0ka89ymw9j9S
 F6Nk3nPa8Gh29j158gjJqEDmkSLCO6ZeKvbVx2XMFi14X/1zSdqCxp6ocL3tz43bxp99CpiX
 W07dq/Fmt+hHsj4m7AlQVlbTuN8=
X-Mailgun-Sending-Ip: 198.61.254.15
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-east-1.postgun.com with SMTP id
 601ddd2d3919dfb4555a585a (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Sat, 06 Feb 2021 00:05:01
 GMT
Sender: abhinavk=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 475A3C433C6; Sat,  6 Feb 2021 00:05:01 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: abhinavk)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id EA5EEC433ED;
        Sat,  6 Feb 2021 00:04:59 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 05 Feb 2021 16:04:59 -0800
From:   abhinavk@codeaurora.org
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     robdclark@gmail.com, sean@poorly.run, airlied@linux.ie,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, daniel@ffwll.ch,
        freedreno@lists.freedesktop.org
Subject: Re: [Freedreno] [PATCH] drm/msm/dp: remove unneeded semicolon
In-Reply-To: <1612321727-25156-1-git-send-email-yang.lee@linux.alibaba.com>
References: <1612321727-25156-1-git-send-email-yang.lee@linux.alibaba.com>
Message-ID: <4efdd6c16dacc1909c9253c355c3c810@codeaurora.org>
X-Sender: abhinavk@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-02-02 19:08, Yang Li wrote:
> Eliminate the following coccicheck warning:
> ./drivers/gpu/drm/msm/dp/dp_ctrl.c:1161:2-3: Unneeded semicolon
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
Reviewed-by: Abhinav Kumar <abhinavk@codeaurora.org>
> ---
>  drivers/gpu/drm/msm/dp/dp_ctrl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c 
> b/drivers/gpu/drm/msm/dp/dp_ctrl.c
> index e3462f5..61ed67b 100644
> --- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
> +++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
> @@ -1158,7 +1158,7 @@ static int dp_ctrl_link_rate_down_shift(struct
> dp_ctrl_private *ctrl)
>  	default:
>  		ret = -EINVAL;
>  		break;
> -	};
> +	}
> 
>  	if (!ret)
>  		DRM_DEBUG_DP("new rate=0x%x\n", ctrl->link->link_params.rate);
